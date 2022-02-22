Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED54F4C0486
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiBVWZB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiBVWZB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:25:01 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3CB10AA
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:24:35 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id c7so1842059qka.7
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MVbqN2So22y7pqfzN+3IWTN8Uv6xdclLBQeEx5Haa7g=;
        b=CNO1BttxZ0OP9FuGArgGO2w/sSlR5XGEZln2Dj7rN1cS3hyliN5gpdLjKsnifYEI21
         OVuA1MDshfjH/xLDLR8oE+HSyIv0MUfK2YlnVE5gkR5Va+OJWrF3tm91nqr3lNzFIL/X
         fkrps98d1W0cJKWFJPnQez9r3itAYHx7GjDvxpiDW2TDIGCczw7WWyQmTmv6WNlURqqI
         xoZQM5TiAK/vPqYlzIbBUl/JU0TculGMc1BXivf6LYUw6vL7JgQLvBQuzJI4YeWL8fl9
         9g2JimgugUzVdnOZE+iZIWw0rQuaToP8Mu3gA/5toeBMIxvT9H4n81ASJgoVG9SiU2+j
         Re3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVbqN2So22y7pqfzN+3IWTN8Uv6xdclLBQeEx5Haa7g=;
        b=WrjbeGWK/VVizuizqWxQ0348YxpsmiJHmI004zxiKjXQGrxGWrgDv/ANP2MB5pBpo4
         Hzd5EVYNSzhXDfT+bcHeF9HtbdE5ze+Okcb/upB46/CgL3j8qNNPr8RUhUX9qZvwri5I
         ar9F3dcJbPHMK4t4BNmYb6YfQs0ZeQotopMBDkypgyyIgUxzY1Qu4cYDm/sAr4Ae3tv9
         21tXgrBG0s+8WpmtIbWG8X4VatrPUewAR8sptNurG+U0suMFgJi5MzmF0HERyCzarjP4
         AH7cOHBDB+XBIRem4POhoZt9wJuygXHpRdniEM7425clRhr7fcax+1tqTVtaWtuYCRir
         MRGQ==
X-Gm-Message-State: AOAM5313F2JaEysrWX1ojSmyqMz65HpVUFEqHb2/JWxWn3CV/pgFDcOK
        SxGDjjoVm/BVyMzwSw0Iiy53CwWRNrGgQIVT
X-Google-Smtp-Source: ABdhPJy4zhCE4LaXbMZwaDfv4moFMSW4VmE3/1Xf7Ws5er4FTV8QmB/QYv0cQkXgyL0UEYakeJ+lYw==
X-Received: by 2002:a05:620a:70e:b0:605:b871:6af4 with SMTP id 14-20020a05620a070e00b00605b8716af4mr16725310qkc.747.1645568674049;
        Tue, 22 Feb 2022 14:24:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f16sm793938qtk.8.2022.02.22.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:24:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs-progs: handle orphan directories properly
Date:   Tue, 22 Feb 2022 17:24:30 -0500
Message-Id: <55249a3d61f77a66057ee93ad6c69c3dddd66683.1645568638.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568638.git.josef@toxicpanda.com>
References: <cover.1645568638.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When implementing the GC tree I started getting btrfsck errors when a
test rm -rf <directory> with files inside of it and immediately unmount,
leaving behind orphaned directory items that have GC items for them.

This made me realize that we don't actually handle this case currently
for our normal orphan path.  If we fail to clean everything up and leave
behind the orphan items we'll fail fsck.

Fix this by not processing any backrefs we find if we found an inode
item and its nlink is 0.  This allows us to pass the test case I've
provided to validate this patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c        | 15 ++++++++++++++-
 check/mode-lowmem.c |  6 ++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index abe208df..e9ac94cc 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1018,6 +1018,16 @@ static int merge_inode_recs(struct inode_record *src, struct inode_record *dst,
 	int ret = 0;
 
 	dst->merging = 1;
+
+	/*
+	 * If we wandered into a shared node while we were processing an inode
+	 * we may have added backrefs for a directory that had nlink == 0, so
+	 * skip adding these backrefs to our src inode if we have nlink == 0 and
+	 * we actually found the inode item.
+	 */
+	if (src->found_inode_item && src->nlink == 0)
+		goto skip_backrefs;
+
 	list_for_each_entry(backref, &src->backrefs, list) {
 		if (backref->found_dir_index) {
 			add_inode_backref(dst_cache, dst->ino, backref->dir,
@@ -1039,7 +1049,7 @@ static int merge_inode_recs(struct inode_record *src, struct inode_record *dst,
 					backref->ref_type, backref->errors);
 		}
 	}
-
+skip_backrefs:
 	if (src->found_dir_item)
 		dst->found_dir_item = 1;
 	if (src->found_file_extent)
@@ -1394,6 +1404,9 @@ static int process_dir_item(struct extent_buffer *eb,
 	rec = active_node->current;
 	rec->found_dir_item = 1;
 
+	if (rec->found_inode_item && rec->nlink == 0)
+		return 0;
+
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
 	total = btrfs_item_size_nr(eb, slot);
 	while (cur < total) {
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index f354a29b..0cdf24cd 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2727,6 +2727,8 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 					imode_to_type(mode), key.objectid,
 					key.offset);
 			}
+			if (is_orphan && key.type == BTRFS_DIR_INDEX_KEY)
+				break;
 			ret = check_dir_item(root, &key, path, &size);
 			err |= ret;
 			break;
@@ -2769,7 +2771,7 @@ out:
 				&nlink);
 		}
 
-		if (nlink != 1) {
+		if (nlink > 1) {
 			err |= LINK_COUNT_ERROR;
 			error("root %llu DIR INODE[%llu] shouldn't have more than one link(%llu)",
 			      root->objectid, inode_id, nlink);
@@ -2785,7 +2787,7 @@ out:
 				gfs_info->nodesize);
 		}
 
-		if (isize != size) {
+		if (isize != size && !is_orphan) {
 			if (repair)
 				ret = repair_dir_isize_lowmem(root, path,
 							      inode_id, size);
-- 
2.26.3

