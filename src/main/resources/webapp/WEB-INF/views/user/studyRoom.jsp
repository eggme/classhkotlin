<%--
  Created by IntelliJ IDEA.
  User: kyyet
  Date: 2021-03-25
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link href="https://vjs.zencdn.net/7.8.4/video-js.css" rel="stylesheet"/>
<script src="https://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js"></script>
<script src="https://vjs.zencdn.net/7.8.4/video.js"></script>
<link rel="stylesheet" href="/css/studyRoom.css">
<script src="/js/studyRoom.js"></script>

<c:set var="totalClass" value="0"></c:set>
<c:set var="totalTime" value="${course.getTotalTime()}"></c:set>
<c:set var="currentClass" value="0"></c:set>
<c:set var="currentTime" value="0"></c:set>
<c:set var="index" value="0"></c:set>

<c:set var="total_section_class_count" value="0"/>
<c:forEach var="section" items="${course.courseSections}" varStatus="status">
    <c:set var="temp" value="${fn:length(section.courseClasses)}"></c:set>
    <c:set var="totalClass" value="${totalClass + temp}"/>
</c:forEach>
<c:set var="total_section_class_count" value="${totalClass}"></c:set>
<c:choose>
    <c:when test="${!(courseHistories eq null)}">
        <c:forEach var="history" items="${courseHistories}" varStatus="index">
            <c:if test="${history.startTime ge (history.endTime-10)}">
                <c:set var="currentTime" value="${currentTime + history.endTime}"></c:set>
            </c:if>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <c:set var="currentTime" value="0"></c:set>
    </c:otherwise>
</c:choose>
<div class="flex_container">
    <div class="study_wrap">
        <div class="curriculum_wrap actived">
            <div class="text">
                <span>목차</span>
                <span class="close_button"><i class="fas fa-times"></i></span>
            </div>
            <div class="course_title_wrap">
                <div class="course_real_title">
                    <span class="title">${courseClass.name}</span>
                </div>
                <div class="course_option">
                    <span>수강기간 : 무제한</span>
                    <%-- courseHistories 가 null 일 때, -> 익명 사용자이거나, 수강 기록이 전혀 없는 수강생 --%>
                    <%-- courseHistories 가 null이 아닐 때, -> 수강 기록이 있는 수강생 --%>
                    <div class="course_progress_rate">
                        <sec:authorize access="isAuthenticated()">
                            <sec:authentication var="userobject" property="principal"/>
                            <c:choose>
                                <c:when test="${(course.isCourseRegistration(userobject)) && (!(courseHistory eq null))}">
                                    <%-- 수강신청이 되어있는 사람 --%>
                                    <span class="">진도율 : </span>
                                    <span class="current_class_count">
                                        <c:out value="${courseHistory.completionCourseCount()}"/>
                                    </span>
                                    <span>강/</span>
                                    <span class="total_class_count">
                                        <c:out value="${total_section_class_count}"/>
                                    </span>
                                    <span>강 (</span>
                                    <span class="course_rate">
                                        <script>
                                            getPercent('${courseHistory.completionCourseCount()}', '${total_section_class_count}', '.course_rate');
                                        </script>
                                    </span>
                                    <span>) | 시간 : </span>  <%-- 총 완료된 시간 구해야합니다 --%>
                                    <span class="current_study_time"></span>
                                    <span>분 / </span>
                                    <span class="total_study_time"></span>
                                    <span>분</span>
                                    <script>
                                        timeFormatWrapper('${currentTime}', '.current_study_time');
                                        timeFormatWrapper('${totalTime}', '.total_study_time');
                                    </script>
                                </c:when>
                                <c:otherwise>
                                    <%-- 수강신청이 되었고, 강의 기록이 없는 사람 --%>
                                    <span class="">진도율 : </span>
                                    <span class="current_class_count">0</span>
                                    <span>강/</span>
                                    <span class="total_class_count">${total_section_class_count}</span>
                                    <span>강 (</span>
                                    <span class="course_rate">0</span>
                                    <span>%) | 시간 : </span>
                                    <span class="current_study_time">0</span>
                                    <span>분 / </span>
                                    <span class="total_study_time">0</span>
                                    <span>분</span>
                                </c:otherwise>
                            </c:choose>
                        </sec:authorize>
                        <sec:authorize access="isAnonymous()">
                            <%-- 수강신청도 안되있고 익명의 사용자가 볼 때 --%>
                            <span class="">진도율 : </span>
                            <span class="current_class_count">0</span>
                            <span>강/</span>
                            <span class="total_class_count">
                                <c:out value="${total_section_class_count}"/>
                            </span>
                            <span>강 (</span>
                            <span class="course_rate">0%</span>
                            <span>) | 시간 : </span>
                            <span class="current_study_time">0</span>
                            <span>분 / </span>
                            <span class="total_study_time"></span>
                            <span>분</span>
                            <script>
                                timeFormatWrapper('${totalTime}', '.total_study_time');
                            </script>
                        </sec:authorize>
                    </div>
                </div>
                <div class="course_progress_wrap">
                    <progress class="course_progress" value="0" max="100"/>
                    <script>
                        getPercentProgress('${courseHistory.completionCourseCount()}', '${total_section_class_count}', '.course_progress');
                    </script>
                </div>
            </div>
            <div class="course_content_wrap" data-cId="${courseClass.id}">
                <div class="course_content">
                    <c:choose>
                        <c:when test="${course.isCourseRegistration(userobject)}"> <%-- 수강신청이 됐을 때 --%>
                            <c:forEach var="section" items="${course.courseSections}" varStatus="status">
                                <script>// course_id, section_id, sectionCode
                                createSectionContent('${section.name}', '${course.id}',
                                    '${section.id}', '${status.index}');
                                </script>
                                <c:forEach var="course_class" items="${section.courseClasses}" varStatus="classStatus">
                                    <script> // name, class_id, sectionCode, classCode, study_time
                                    createClassContent('${course_class.name}', '${course.id}',
                                        '${course_class.id}', '${status.index}',
                                        '${classStatus.index}', '${course_class.seconds}',
                                        '${course_class.preview}', true);
                                    </script>
                                </c:forEach>
                            </c:forEach>
                        </c:when>
                        <c:otherwise> <%-- 수강신청이 안됐거나 익명의 사용자일 때 --%>
                            <c:forEach var="section" items="${course.courseSections}" varStatus="status">
                                <script>// course_id, section_id, sectionCode
                                createSectionContent('${section.name}', '${course.id}',
                                    '${section.id}', '${status.index}');
                                </script>
                                <c:forEach var="course_class" items="${section.courseClasses}" varStatus="classStatus">
                                    <script> // name, class_id, sectionCode, classCode, study_time
                                    createClassContent('${course_class.name}', '${course.id}',
                                        '${course_class.id}', '${status.index}',
                                        '${classStatus.index}', '${course_class.seconds}',
                                        '${course_class.preview}', false);
                                    </script>
                                </c:forEach>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${!(courseHistories eq null)}">
                            <c:forEach var="history" items="${courseHistories}" varStatus="index">
                                <script>
                                    changeCourseStatus('${history.courseClass.id}', '${history.startTime}', '${history.endTime}');
                                    changeActiveCourse('${courseClass.id}');
                                </script>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <script>
                                changeActiveCourse('${courseClass.id}');
                            </script>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <div class="study_box_wrap">
            <ul class="study_menu">
                <li class="course_data_list checked"><i class="fas fa-list"></i></li>
                <li class="course_community"><i class="fas fa-comment-dots"></i></li>
                <li class="course_note"><i class="fas fa-pen"></i></li>
            </ul>
        </div>
    </div>
    <div id="video_wrap">
        <div class="top_bar">
            <div class="hover_interaction">
                <div class="course_dashboard">
                    <div class="clip_board">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <div class="dashboard" data-id="${course.id}">
                        강의 대시보드
                    </div>

                </div>
                <div class="triangle"></div>
            </div>
            <div class="course_title">
                <span class="course_title_value">${courseClass.name}</span>
                <div class="review_button">
                    <span class="star"><i class="fas fa-star"></i></span>
                    <span>수강평 작성하기</span>
                </div>
            </div>
        </div>
        <div class="video_bg">
            <div class="min_height">
                <video id="myPlayer" class="video-js vjs-default-skin vjs-fill" data-id="${course.id}"
                       data-cId="${courseClass.id}"></video>
                <div class="hidden video_ended">
                    <div class="course_ended_alert">
                        <div class="course_next_title">[다음 수업]</div>
                        <div class="course_next_name"></div>
                        <div class="replay_and_next">
                            <div class="replay next_button_template" data-id="${course.id}"
                                 data-cId="${courseClass.id}">수업 다시보기 <i class="fas fa-redo"></i></div>
                            <div class="next next_button_template" data-id="${course.id}">다음 수업보기 <i
                                    class="fas fa-play"></i></div>
                        </div>
                    </div>
                </div>
            </div>
            <c:choose>
                <c:when test="${!error}">
                    <c:if test="${!empty courseClass.mediaPath}">
                        <c:choose>
                            <c:when test="${currentHistory eq null}">
                                <script>
                                    Authorized();
                                    loadVideoUrl('${courseClass.mediaPath}');
                                    loadVideoJS(0, '${currentHistory.endTime}');
                                </script>
                            </c:when>
                            <c:otherwise>
                                <script>
                                    Authorized();
                                    loadVideoUrl('${courseClass.mediaPath}');
                                    loadVideoJS('${currentHistory.startTime}', '${currentHistory.endTime}');
                                </script>
                            </c:otherwise>
                        </c:choose>

                    </c:if>
                </c:when>
                <c:otherwise>
                    <script>
                        noAuthorized();
                    </script>
                    <div class="unauthorized_wrap">
                        <form action="/study/add/cart" method="post" class="course_cart_form">
                            <input type="hidden" name="course_id" value="${course.id}">
                            <input type="hidden" name="courseClass_id" value="${courseClass.id}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="form_wrap">
                                <div class="h1_area"><h1>🙊 수강권한이 없어요! 🙈</h1></div>
                                <div class="span_area">
                                    <span class="add_br">이 수업은 수강신청 이후에 학습할 수 있습니다.<br/>이 배움으로 더욱 많은 것을 이뤄보세요!!</span>
                                </div>
                                <div class="price_area">
                                    <div class="price">
                                        <c:out value="${course.price}"></c:out> 원
                                    </div>
                                </div>
                                <div class="button_area">
                                    <div class="payment_area">
                                        <div class="do_payment_button error_button" data-id="${course.id}">바로 결제하기</div>
                                        <sec:authorize access="isAuthenticated()">
                                            <sec:authentication var="mem" property="principal"/>
                                            <c:if test="${!(member.isPutInTheCart(course.id))}">
                                                <div class="add_course_button error_button" data-id="${course.id}">수강바구니 담기</div>
                                            </c:if>
                                        </sec:authorize>
                                        <sec:authorize access="isAnonymous()">
                                            <div class="add_course_button error_button" data-id="${course.id}">수강바구니 담기</div>
                                        </sec:authorize>
                                        <div class="go_course_info_button error_button" data-id="${course.id}">강의소개로 이동</div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="instructorMemo_wrap">
                ${courseClass.instructorMemo}
            </div>
        </div>
        <div class="bottom_menu">
            <div class="button_wrap">
                <div class="previous_button">
                    <i class="fas fa-chevron-left"></i> 이전 강의
                </div>
                <div class="check_button">
                    <i class="fas fa-check"></i>
                </div>
                <div class="next_button">
                    <i class="fas fa-chevron-right"></i> 다음 강의
                </div>
            </div>
        </div>
    </div>
</div>


<%-- 완강 축하 모달 <i class="fas fa-cart-plus"></i>--%>
<div class="clear_course_form_wrap modal_form_wrap">
    <form class="clear_course_form" method="post" action="/course/carts">
        <div class="clear_course_content animate modal_content">
            <div class="clear_course_container modal_container">
                <div class="clear_course_icon"><i class="far fa-check-circle"></i></div>
                <div class="clear_course_title">완강! 축하합니다 🎉</div>
                <div class="clear_course_desc">수고하셨습니다. 💌
                    강의는 어떠셨나요? 학습하면서 느꼈던 솔직한 감상을 수강평에 남겨주세요!
                    여러분의 수강평은 지식공유자에게 큰 힘이 됩니다. :)
                </div>
                <div class="clear_course_buttons modal_buttons_flex_template">
                    <div class="clear_course_submit modal_submit_button_template">확인</div>
                </div>
            </div>
        </div>
    </form>
</div>

<%-- 장바구니 담기 완료 모달 <i class="fas fa-cart-plus"></i>--%>
<div class="add_cart_form_wrap modal_form_wrap">
    <form class="add_cart_form" method="post" action="/course/carts">
        <div class="add_cart_content animate modal_content">
            <div class="add_cart_container modal_container">
                <div class="add_cart_exit"><i class="fas fa-cart-plus"></i></div>
                <div class="add_cart_title">강의가 수강바구니에<br/>담겼습니다</div>
                <div class="add_cart_desc">바로 확인 하시겠습니까?</div>
                <div class="add_cart_buttons modal_buttons_flex_template">
                    <div class="add_cart_cancel modal_cancel_button_template">취소</div>
                    <div class="add_cart_submit modal_submit_button_template">확인</div>
                </div>
            </div>
        </div>
    </form>
</div>

<c:if test="${!(modal eq null)}">
    <script>
        openModal(".add_cart_form_wrap");
    </script>
</c:if>