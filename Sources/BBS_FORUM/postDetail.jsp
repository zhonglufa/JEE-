
<!-- 回复回复的表单 -->
<div class="reply-to-reply-form" id="reply-to-reply-form-${reply.replyId}">
    <form action="${pageContext.request.contextPath}/reply/add" method="post">
        <input type="hidden" name="commentId" value="${comment.commentId}">
        <input type="hidden" name="postId" value="${post.postId}">
        <!-- 对当前回复进行留言 -->
        <input type="hidden" name="parentId" value="${reply.replyId}">
        <textarea name="content" placeholder="回复${reply.userName}..." required></textarea>
        <div class="reply-form-actions">
            <button type="button" class="reply-form-btn reply-cancel" data-comment-id="${reply.replyId}">取消</button>
            <button type="submit" class="reply-form-btn reply-submit">
                <i class="fas fa-paper-plane"></i> 发表回复
            </button>
        </div>
    </form>
</div>
