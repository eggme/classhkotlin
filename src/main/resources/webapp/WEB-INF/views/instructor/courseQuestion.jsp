<%--
  Created by IntelliJ IDEA.
  User: kyyet
  Date: 2021-03-26
  Time: 오전 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
<link rel="stylesheet" href="/css/courseQuestion.css">
<script src="/js/courseQuestion.js"></script>

<div class="main_section">
    <div class="real_course_content">
        <div class="search_wrap">
            <div class="input_area">
                <input type="text" name="query" class="question_input"/>
                <div class="search_icon_wrap">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div class="button_area">
                <div class="button_icon"><i class="fas fa-pen"></i></div>
                <div class="title">글쓰기</div>
            </div>
        </div>
        <div class="question_area">
            <c:choose>
                <c:when test="${empty list}">
                    <div class="empty_list">아직 관련 글이 없습니다. 첫 글을 남겨주세요!</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="question" items="${list}" varStatus="question_status" >
                        <div class="question_content" data-id="${question.id}">
                            <div class="question_data_area">
                                <div class="question_content_wrap">
                                    <div class="review_title">
                                        <c:out value="${question.title}" />
                                    </div>
                                    <div class="review_content">
                                        <c:out value="${question.content}"></c:out>
                                    </div>
                                    <div class="review_tags">
                                        <c:forEach var="tags" items="${question.courseTags}" varStatus="tag_status">
                                            <div class='review_hash_tag'>
                                        <span class='review_tag_value'>#
                                            <c:out value="${tags.tag}"></c:out>
                                        </span>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="question_member_wrap">
                                    <div class="member_name">
                                        <c:out value="${question.member.nickName}"/>
                                    </div>
                                    <div class="separator"> · </div>
                                    <div class="question_time question_${question.id}">
                                        <script>
                                            timeForTodayObject("${question.modify_at}", '.question_${question.id}');
                                        </script>
                                    </div>
                                    <div class="separator">&nbsp;·&nbsp;</div>
                                    <div class="course_title">
                                        <c:out value="${question.course.name}"/>
                                        <c:if test="${!question.courseClass eq null}">
                                            <div class="separator">&nbsp;·&nbsp;</div>
                                            <div class="courseClass_title">
                                                <c:out value="${question.courseClass.name}"/>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="question_toolbar">
                                <div class="circle_answer_area">
                                    <div class="answer_count">
                                        <c:out value="${question.getCommentSize()}"/>
                                    </div>
                                    <div class="answer_title">
                                        <c:out value="${question.questionStatus.getValue()}"/>
                                    </div>
                                </div>
                                <div class="like_area">
                                    <div class="like_icon"><i class="fas fa-heart"></i></div>
                                    <div class="like_count">0</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="box_wrap">
        <div class="course_box">
            <div class="course_box_warp">
                <form action="/course/add/cart" method="post" class="course_cart_form">
                    <input type="hidden" name="course_id" value="${course.id}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <sec:authorize access="isAuthenticated()">
                        <sec:authentication var="userobject" property="principal"></sec:authentication>
                        <c:choose>
                            <c:when test="${course.isCourseRegistration(userobject)}">
                                <%-- 로그인이 된 상태에서 해당 유저가 해당 강의에 수강신청이 된 상태 --%>
                                <div class="course_price"></div>
                                <div class="course_status">학습중</div>
                                <div class="learning_box_study learning_box_template" data-id="${course.id}">이어 학습하기</div>
                            </c:when>
                            <c:when test="${member.isPutInTheCart(course.id)}">
                                <%-- 로그인이 된 상태에서 해당 유저가 해당 강의에 수강신청이 안돼있고 장바구니에 담긴 상태 --%>
                                <c:choose>
                                    <c:when test="${course.price eq 0}">
                                        <div class="course_price">무료</div>
                                        <div class="course_status"></div>
                                        <div class="learning_box_purchase learning_box_template" data-status="authentication">바로 학습하기</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="course_price">
                                            <script>
                                                CostSeparatorKR('${course.price}', '.course_price');
                                            </script>
                                        </div>
                                        <div class="course_status"></div>
                                        <div class="learning_box_purchase learning_box_template" data-status="authentication">결제하기</div>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <%-- 로그인은 됐는데 해당 유저가 해당 강의에 수강신청이 안된 상태 --%>
                                <c:choose>
                                    <c:when test="${course.price eq 0}">
                                        <div class="course_price">무료</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="course_price">
                                            <script>
                                                CostSeparatorKR('${course.price}', '.course_price');
                                            </script>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="course_status"></div>
                                <div class="learning_box learning_box_template" data-status="authentication">수강신청</div>
                            </c:otherwise>
                        </c:choose>
                    </sec:authorize>
                    <sec:authorize access="isAnonymous()">
                        <%-- 비로그인 시 익명 사용자 접근 시 --%>
                        <c:choose>
                            <c:when test="${course.price eq 0}">
                                <div class="course_price">무료</div>
                            </c:when>
                            <c:otherwise>
                                <div class="course_price">
                                    <script>
                                        CostSeparatorKR('${course.price}', '.course_price');
                                    </script>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="course_status"></div>
                        <div class="learning_box learning_box_template" data-status="anonymous">수강신청</div>
                    </sec:authorize>
                </form>
                <div class="mini_box">
                    <div class="add_box mini_box_content"><i class="far fa-plus-square line_height"></i> 내 목록 추가</div>
                    <div class="share mini_box_content"><i class="fas fa-share-alt line_height"></i> 공유하기</div>
                </div>
            </div>
            <div class="course_subtext">
                <div class="top_margin">지식공유자 : <span class="instructor_name_tab">
                    <c:out value="${course.instructor.member.nickName}"></c:out></span></div>
                <%--  총 수업 수 구하는 로직 --%>
                <c:set var="total_section_class_count" value="0"/>
                <c:forEach var="section" items="${course.courseSections}" varStatus="status">
                    <c:forEach var="class_o" items="${section.courseClasses}" varStatus="status">
                        <c:set var="total_section_class_count" value="${total_section_class_count + 1}"/>
                    </c:forEach>
                </c:forEach>
                <div class="top_margin ">총 <span class="total_class">
                    <c:out value="${total_section_class_count}"></c:out></span>개 수업 · 총 <span class="course_total_time">
                    <script>timeFormatKorWrapper('${course.getTotalTime()}', '.course_total_time');</script>
                </span>
                </div>
                <div class="top_margin">기간 : 평생 무제한 시청</div>
                <div class="top_margin">수료증 : 발급 강의</div>
                <div class="top_margin">수강 난이도 : <span class="course_level"><c:out
                        value="${course.courseLevel.value}"/></span></div>
            </div>
        </div>
    </div>
</div>
<div class="question_write_form_wrapper hoflearn_modal_wrapper" data-id="${course.id}">
    <div class="question_write_form hoflearn_modal_form animate">
        <form class="question_form" action="/question/add" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="course_id" class="course_id" />
            <div class="question_relative_wrap hoflearn_modal_relative_wrap">
                <div class="question_name_wrap hoflearn_modal_content_template">
                    <div class="question_name_menu question_menu_template">제목</div>
                    <div class="question_name_input question_input_template hoflearn_modal_input_template">
                        <input type="text" class="question_name" name="title" placeholder="제목을 입력해주세요.">
                    </div>
                </div>
                <div class="question_tag_wrap hoflearn_modal_content_template">
                    <div class="question_tag_menu hoflearn_modal_menu_template">태그</div>
                    <div class="question_tag_input">
                        <div class="tag_wrap_template">
                            <div class="hashtag"><i class="fas fa-hashtag"></i></div>
                            <div class="hashtag_value">

                            </div>
                            <input type="text" class="question_tag" placeholder="태그를 설정해주세요.">
                        </div>
                        <div class="tag_description">최대 10개의 태그를 달 수 있어요!</div>
                    </div>
                </div>
                <div class="question_content_wrap hoflearn_modal_content_template">
                    <div class="question_content_menu hoflearn_modal_menu_template">질문 내용</div>
                    <div class="question_content_input">
                <textarea id="myQuestion" name="content">
                    <p><b>강의와 관련있는 질문을 남겨주세요.</b></p>
<p>• 강의와 관련이 없는 질문은 지식공유자가 답변하지 않을 수 있습니다. (사적 상담, 컨설팅, 과제 풀이 등)</p>
<p>• 질문을 남기기 전, 비슷한 내용을 질문한 수강생이 있는지 먼저 검색을 해주세요. (중복 질문을 자제해주세요.)</p>
<p>• <u>서비스 운영 관련 질문은 인프런 우측 하단 ‘문의하기’</u>를 이용해주세요. (영상 재생 문제, 사이트 버그, 강의 환불 등)</p>
<br/>
<p><b>질문 전달에도 요령이 필요합니다.</b></p>
<p>• 지식공유자가 질문을 좀 더 쉽게 확인할 수 있게 도와주세요.</p>
<p>• 강의실 페이지(/lecture) 에서 '질문하기'를 이용해주시면 질문과 연관된 수업 영상 제목이 함께 등록됩니다.</p>
<p>• 강의 대시보드에서 질문을 남길 경우, <u>관련 섹션 및 수업 제목을 기재</u>해주세요.</p>
<p>• 수업 특정 구간에 대한 질문은 꼭 <u>영상 타임코드</u>를 남겨주세요!</p>
<br/>
<p><b>구체적인 질문일수록 명확한 답을 받을 수 있어요.</b></p>
<p>• 질문 제목은 핵심 키워드를 포함해 간결하게 적어주세요.</p>
<p>• 질문 내용은 자세하게 적어주시되, 지식공유자가 답변할 수 있도록 <u>구체적으로 남겨주세요.</u></p>
<p>• 정확한 질문 내용과 함께 코드를 적어주시거나, <u>캡쳐 이미지</u>를 첨부하면 더욱 좋습니다.</p>
<br/>
<p><b>기본적인 예의를 지켜주세요.</b></p>
<p>• 정중한 의견 및 문의 제시, 감사 인사 등의 커뮤니케이션은 더 나은 강의를 위한 기틀이 됩니다.</p>
<p>• 질문이 있을 때에는 강의를 만든 지식공유자에 대한 기본적인 예의를 꼭 지켜주세요.</p>
<p>• 반말, 욕설, 과격한 표현 등 지식공유자를 불쾌하게 할 수 있는 내용은 스팸 처리 등 제재를 가할 수 있습니다.</p> </textarea>
                    </div>
                </div>
            </div>
            <div class="hoflearn_modal_button_wrap">
                <div class="hoflearn_modal_button_template question_cancel">취소</div>
                <div class="hoflearn_modal_button_template question_submit">저장</div>
            </div>
        </form>
    </div>
</div>