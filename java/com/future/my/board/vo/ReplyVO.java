package com.future.my.board.vo;

public class ReplyVO {

		private int boardNo;               /*게시글 번호*/
		private String replyNo;            /*댓글 번호*/
		private String memId;              /*댓글 작성자 아이디*/
		private String memNm;              /*댓글 작성자 이름 */
		private String replyContent;       /*댓글 내용 */
		private String useYn;              /*사용 여부 */
		private String replyDate;          /*수정 일자 */

		public ReplyVO() {
		}

		public int getBoardNo() {
			return boardNo;
		}

		public void setBoardNo(int boardNo) {
			this.boardNo = boardNo;
		}

		public String getReplyNo() {
			return replyNo;
		}

		public void setReplyNo(String replyNo) {
			this.replyNo = replyNo;
		}

		public String getMemId() {
			return memId;
		}

		public void setMemId(String memId) {
			this.memId = memId;
		}

		public String getMemNm() {
			return memNm;
		}

		public void setMemNm(String memNm) {
			this.memNm = memNm;
		}

		public String getReplyContent() {
			return replyContent;
		}

		public void setReplyContent(String replyContent) {
			this.replyContent = replyContent;
		}

		public String getUseYn() {
			return useYn;
		}

		public void setUseYn(String useYn) {
			this.useYn = useYn;
		}

		public String getReplyDate() {
			return replyDate;
		}

		public void setReplyDate(String replyDate) {
			this.replyDate = replyDate;
		}

		@Override
		public String toString() {
			return "ReplyVO [boardNo=" + boardNo + ", replyNo=" + replyNo + ", memId=" + memId + ", memNm=" + memNm
					+ ", replyContent=" + replyContent + ", useYn=" + useYn + ", replyDate=" + replyDate + "]";
		}
		
		
		
		
}
