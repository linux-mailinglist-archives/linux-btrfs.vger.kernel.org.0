Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3303330FE15
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 21:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbhBDUWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 15:22:22 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56893 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240037AbhBDUWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 15:22:11 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 536665C0158;
        Thu,  4 Feb 2021 15:09:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Feb 2021 15:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm3; bh=eNQoWXOEghx2Toj2E8hgd3IEdo
        bFfGCNi3GDDNGIa/k=; b=miQR+GotC5TDaETQmVkEQIEiGIL+2OoiIkY/Lv/l/J
        vw/iFp+LXDhnODtLkEN2++ZPV9qQj/7VPJM6/vWfQziI9R6kHCKTVCgWIn897HVf
        Ujy5Xqh1LaqeLqFgRPrMh29rPOs13Lj2lN86wq7mhS0cnIR8KlZhCU33+Tnu+M/8
        qmK38dpTzLNLrQBiUKW4WIIYwB3Qhwp45hwbD5iQNRNp+HhHZyftEUrObGmXx0+s
        9/n6U0wnU1p/sMGn9V+mKY1rqj6VGzhVq9grZIRKNcM/z5daZd7aQj+nFq2LL403
        wn275wSlXLnf+XJsaiTfqiMFnfxmtKSC8hl3SVr/1FPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=eNQoWXOEghx2Toj2E8hgd3IEdobFfGCNi3GDDNGIa/k=; b=W5qOr8ag
        Q8eWgdVs5iuP+mi1EMZz7+KhEDGaQimwAR0azVuAoUrG0zro+u4NnENtCNzeSgLE
        QxHlvwmu+95cgAs/VHwycAPgN3c2lpbBYNehRNvGykqIgCcPwVmZnmLut9sWdQy6
        LxXMYN4q5vYzjzaZybq+JLZ3S3TM35rfVjoigefFR2UbdO1HTkw4s4qhkWy+ng9P
        StUXczN/hvoYXZeJXfsaS/j2KJrqElYeETAjwc9Spfb5qpqeoK72Hgh053IlBzzt
        +A2pXZfU/qGLRzj9vj5agSciBVqJRz2iEHREGMJR+UZvQkeY7Knkxy8MneGdINbf
        XT/i4+fX+b257A==
X-ME-Sender: <xms:iFQcYHsDf8vxoYSxFDJGkeiblFcTVj7yyPrLnZuOCEsOhy3n8T6lCQ>
    <xme:iFQcYIcZj-kiy6mn6jxi7bQLwENhExQRQK2iG7Hm7CRoQmOeXdv7mnNrlU_MT31cd
    XefL7hTrfJss2vSzmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:iFQcYKyAsZQ3klVGDvKl3nQ6ufxyYfPg_1EHRnIWnisLhpTOU0vkxQ>
    <xmx:iFQcYGO9odT5J1GdGeZdk6PuneaHOwqhdHiS6ozykks6p2dgz5oDLg>
    <xmx:iFQcYH9ZjIaWpgI7Q3g5yr2DsA6V-jHLKmiqZv4fLFdlAxJM2O-dxQ>
    <xmx:iFQcYEJWlPUwU2CFtKHekGLPMWmebblBt8ZweO84yASBoDK1yKN5KQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8C29108005B;
        Thu,  4 Feb 2021 15:09:43 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block
Date:   Thu,  4 Feb 2021 12:09:32 -0800
Message-Id: <fc655b11d471dd6796e2bff93d36948e4bcc37c7.1612468824.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1612468824.git.boris@bur.io>
References: <cover.1612468824.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To corrupt holes/prealloc/inline extents, we need to mess with
extent data items. This patch makes it possible to modify
disk_bytenr with a specific value (useful for hole corruptions)
and to modify the type field (useful for prealloc corruptions)

Signed-off-by: Boris Burkov <boris@bur.io>
---
 btrfs-corrupt-block.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index bf1ce9c5..40d8ad8e 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -323,6 +323,7 @@ enum btrfs_inode_field {
 
 enum btrfs_file_extent_field {
 	BTRFS_FILE_EXTENT_DISK_BYTENR,
+	BTRFS_FILE_EXTENT_TYPE,
 	BTRFS_FILE_EXTENT_BAD,
 };
 
@@ -377,6 +378,8 @@ static enum btrfs_file_extent_field convert_file_extent_field(char *field)
 {
 	if (!strncmp(field, "disk_bytenr", FIELD_BUF_LEN))
 		return BTRFS_FILE_EXTENT_DISK_BYTENR;
+	if (!strncmp(field, "type", FIELD_BUF_LEN))
+		return BTRFS_FILE_EXTENT_TYPE;
 	return BTRFS_FILE_EXTENT_BAD;
 }
 
@@ -673,14 +676,14 @@ out:
 
 static int corrupt_file_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root, u64 inode, u64 extent,
-			       char *field)
+			       char *field, u64 bogus)
 {
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	enum btrfs_file_extent_field corrupt_field;
-	u64 bogus;
 	u64 orig;
+	u8 bogus_type = bogus;
 	int ret = 0;
 
 	corrupt_field = convert_file_extent_field(field);
@@ -712,9 +715,18 @@ static int corrupt_file_extent(struct btrfs_trans_handle *trans,
 	switch (corrupt_field) {
 	case BTRFS_FILE_EXTENT_DISK_BYTENR:
 		orig = btrfs_file_extent_disk_bytenr(path->nodes[0], fi);
-		bogus = generate_u64(orig);
+		if (bogus == (u64)-1)
+			bogus = generate_u64(orig);
 		btrfs_set_file_extent_disk_bytenr(path->nodes[0], fi, bogus);
 		break;
+	case BTRFS_FILE_EXTENT_TYPE:
+		if (bogus == (u64)-1) {
+			fprintf(stderr, "Specify a new extent type value (-v)\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		btrfs_set_file_extent_type(path->nodes[0], fi, bogus_type);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -1394,9 +1406,9 @@ int main(int argc, char **argv)
 			printf("corrupting inode\n");
 			ret = corrupt_inode(trans, root, inode, field);
 		} else {
-			printf("corrupting file extent\n");
 			ret = corrupt_file_extent(trans, root, inode,
-						  file_extent, field);
+						  file_extent, field,
+						  bogus_value);
 		}
 		btrfs_commit_transaction(trans, root);
 		goto out_close;
-- 
2.24.1

