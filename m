Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A5F68DE57
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjBGQ5h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjBGQ5f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:57:35 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327613B667
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:57:33 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id cr22so17406915qtb.10
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAZBp3SfPqPNz+uqZs8QZxXxNaZt+/4AFGgxJ5FUXvg=;
        b=ccUHvBZAVraIY+YlW89wPbN2w5yscDcmZI6449q4lvWwH2jLMLeg8UUhV7rIsOJ2kc
         us6aU0Ki8b/ZWyALVqRW5qum02IGeClfQFVYiyG7qS85qVKaasTn8d/pbuQJpzi/vUFf
         JFyEscpRMv+WpyXitp6it6R6TsRtz9yiB8tsaVVwUKVNgeoaqRI/L4GumKHZarpdNAv4
         k/no/odeP3+SmIr3CI7lYB6k2U+vCASaGsNgP1jfmTsCFqGlW+q5eU5H/PsT+F7+YvOO
         dsYNXe/HBhdxwBSqh9mXVZl5uo7FGWXzmap31Lr40trnQ7w/UDxVDlWc3DEsdlxCWqB5
         7+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAZBp3SfPqPNz+uqZs8QZxXxNaZt+/4AFGgxJ5FUXvg=;
        b=4lv2Debhx0vt0zq6sdlq7LPD6UNvEcrIe/raWHF2eMn/tqmDM1TKlNbMoHxU/J1BHQ
         9ExhwU/vUt0ieItKqGteH+LzmhnVtSpIbRuPvGqrbN5OC3q5DZKngwJ+Axl3bry+fwIL
         eL5OvTkqwlNtjyWrF9tkHdqFJXMpFbUzGu3eae/3LKTHDq6uq70I3xJEw/QllKS2gQNx
         Ygwuk/wz/HafUUmUikqRMqiYcd2IM7vFTrow2f9c0uqlUn4ZYEzLxfHQSJZJlVe55J39
         1JHaTXOojTHEW8hQNW7lbYuLAJSOVoJV+v2IZ89LFCpyV0Cevw5MwmC0DPTyLysRLsQr
         NQeQ==
X-Gm-Message-State: AO0yUKXocsphkA8ZByBQdydllrSrT3o0F22m0NZZxU2wuGIvp3t3uE1b
        k1XgBuTyLvAJykU/NVN9+IxuLLVP2gP0frSBPh0=
X-Google-Smtp-Source: AK7set9MUo5LIycpJAMEBzpoLhbZTYS1QKXJVN4z63FPEjCMAsTsk3unLokEKKhNT7RA4vdrHvS/+w==
X-Received: by 2002:a05:622a:11ca:b0:3b8:33b5:a7ec with SMTP id n10-20020a05622a11ca00b003b833b5a7ecmr6969939qtk.22.1675789051948;
        Tue, 07 Feb 2023 08:57:31 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y18-20020ac87c92000000b003b630ea0ea1sm9630265qtv.19.2023.02.07.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:57:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/7] btrfs: handle errors from btrfs_read_node_slot in split
Date:   Tue,  7 Feb 2023 11:57:21 -0500
Message-Id: <180cdbe61c2a59e939d1ff285519ed93fc5d1ab6.1675787102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1675787102.git.josef@toxicpanda.com>
References: <cover.1675787102.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While investigating a problem with error injection I tripped over
curious behavior in the node/leaf splitting code.  If we get an EIO when
trying to read either the left or right leaf/node for splitting we'll
simply treat the node as if it were full and continue on.  The end
result of this isn't too bad, we simply end up allocating a block when
we may have pushed items into the adjacent blocks.  However this does
essentially allow us to continue to modify a file system that we've
gotten errors on, either from a bad disk or csum mismatch or other
corruption.  This isn't particularly safe, so instead handle these
btrfs_read_node_slot() usages differently.  We allow you to pass in any
slot, the idea being that we save some code if the slot number is
outside of the range of the parent.  This means we treat all errors the
same, when in reality we only want to ignore -ENOENT.

Fix this by changing how we call btrfs_read_node_slot(), which is to
only call it for slots we know are valid.  This way if we get an error
back from reading the block we can properly pass the error up the chain.
This was validated with the error injection testing I was doing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 53 ++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 484d750df4c6..ed042b541326 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1069,11 +1069,14 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
 		return 0;
 
-	left = btrfs_read_node_slot(parent, pslot - 1);
-	if (IS_ERR(left))
-		left = NULL;
+	if (pslot) {
+		left = btrfs_read_node_slot(parent, pslot - 1);
+		if (IS_ERR(left)) {
+			ret = PTR_ERR(left);
+			left = NULL;
+			goto enospc;
+		}
 
-	if (left) {
 		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left,
@@ -1084,11 +1087,14 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	right = btrfs_read_node_slot(parent, pslot + 1);
-	if (IS_ERR(right))
-		right = NULL;
+	if (pslot + 1 < btrfs_header_nritems(parent)) {
+		right = btrfs_read_node_slot(parent, pslot + 1);
+		if (IS_ERR(right)) {
+			ret = PTR_ERR(right);
+			right = NULL;
+			goto enospc;
+		}
 
-	if (right) {
 		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right,
@@ -1245,14 +1251,14 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 	if (!parent)
 		return 1;
 
-	left = btrfs_read_node_slot(parent, pslot - 1);
-	if (IS_ERR(left))
-		left = NULL;
-
 	/* first, try to make some room in the middle buffer */
-	if (left) {
+	if (pslot) {
 		u32 left_nr;
 
+		left = btrfs_read_node_slot(parent, pslot - 1);
+		if (IS_ERR(left))
+			return PTR_ERR(left);
+
 		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
 
 		left_nr = btrfs_header_nritems(left);
@@ -1297,16 +1303,17 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		btrfs_tree_unlock(left);
 		free_extent_buffer(left);
 	}
-	right = btrfs_read_node_slot(parent, pslot + 1);
-	if (IS_ERR(right))
-		right = NULL;
 
 	/*
 	 * then try to empty the right most buffer into the middle
 	 */
-	if (right) {
+	if (pslot + 1 < btrfs_header_nritems(parent)) {
 		u32 right_nr;
 
+		right = btrfs_read_node_slot(parent, pslot + 1);
+		if (IS_ERR(right))
+			return PTR_ERR(right);
+
 		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
 
 		right_nr = btrfs_header_nritems(right);
@@ -3203,12 +3210,8 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_assert_tree_write_locked(path->nodes[1]);
 
 	right = btrfs_read_node_slot(upper, slot + 1);
-	/*
-	 * slot + 1 is not valid or we fail to read the right node,
-	 * no big deal, just return.
-	 */
 	if (IS_ERR(right))
-		return 1;
+		return PTR_ERR(right);
 
 	__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
 
@@ -3422,12 +3425,8 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_assert_tree_write_locked(path->nodes[1]);
 
 	left = btrfs_read_node_slot(path->nodes[1], slot - 1);
-	/*
-	 * slot - 1 is not valid or we fail to read the left node,
-	 * no big deal, just return.
-	 */
 	if (IS_ERR(left))
-		return 1;
+		return PTR_ERR(left);
 
 	__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
 
-- 
2.26.3

