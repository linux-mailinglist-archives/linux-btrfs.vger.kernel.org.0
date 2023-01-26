Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C484767D71C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 22:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjAZVBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 16:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjAZVBQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 16:01:16 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63AF3669D
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:07 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id m12so2395660qvt.9
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkZEpr2L5P1ocWqg9oO0bXldfdgVY0am7oJTJOgUCP4=;
        b=GbtLuqu6eAXPCRaLo1/NQb8HDYR/cbyd46ittlH9WFRafyRnWL/4tgVgfXI87ouX7C
         0IxpHV4LfMqXY67FIcbcJLTn5y0r9T5v6BgO0itL/NIGdWYvnq6aePu17wtwURtsW8a/
         WsyFSOK0i2a92EApT8IFltG4r3ABcVnE6wuC0/5F9GLS22QHnqaa7GGjthuP/Q66SBen
         pTdKTDtpKoaH/vU56RlZ/GJQjdqwPFxiQpoeilQAyai9lg0JU+3IjiTArBb798exPDGE
         KE7a8k1Mv7sKBiMVsp7U+pwdcxaAPZMXISEGKIWR+fnj4ON3XK+cZaCTnDawi/qqGDLi
         Yabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkZEpr2L5P1ocWqg9oO0bXldfdgVY0am7oJTJOgUCP4=;
        b=nP252qHKGF3u01XyzZWrS1GVA7AgEQBRZSCBzJHeHX5lW0YwHjq1o3cn9i+sW2XQz6
         ZFbwp5HLsc3gUj1r0oMKnznVqPvulDajwMD6yGVXugu+6PkKeLsObsBVMEWpY5E7zcjE
         2BOhnXfPQxQCMhB5Bwqcq5ibCESZ+ES/Dmxk03tc63FSxhXqSuGqePMUbmjIkfSzUS+Z
         X2EgZyQil5QFSoof4Qn34AHChSog71r6mXmWGDhGeeLQZHOLF173waIVFeu57rMLcVXw
         DDNn4dBTCUlWFK1YZBCD832t6XCZMCOf8y5bpiZ2oXiGFwdfRTtq5awGEZugk6zuGSto
         za5Q==
X-Gm-Message-State: AO0yUKWuXYxwW4myrMAsPtJC0nZvOEomjOUF0gJdw5GUyzA3XASdvpnx
        xYjaVFQFJ17cp43M+S3HfTkEiQ0pL/Peh591AvA=
X-Google-Smtp-Source: AK7set/Nc6Zhp8GA9zRmGNuoxW+W6xFMMQfO3xMsa69TmxYwfTmFCvC9WaQfMh2P2w96XmZGbUL9WA==
X-Received: by 2002:a05:6214:924:b0:4c7:3c7c:4d1e with SMTP id dk4-20020a056214092400b004c73c7c4d1emr4587185qvb.15.1674766866603;
        Thu, 26 Jan 2023 13:01:06 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id b4-20020a378004000000b0070736988c10sm1552242qkd.110.2023.01.26.13.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:01:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 3/7] btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
Date:   Thu, 26 Jan 2023 16:00:56 -0500
Message-Id: <0e818f6eca3cf65a4eb9ce844d8c93d40054e8e1.1674766637.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674766637.git.josef@toxicpanda.com>
References: <cover.1674766637.git.josef@toxicpanda.com>
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

Now that we're passing in the trans into btrfs_clean_tree_block, we can
easily roll in the handling of the !trans case and replace all
occurrences of

if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
	clear_extent_buffer_dirty(eb);

with

btrfs_tree_lock(eb);
btrfs_clean_tree_block(eb);
btrfs_tree_unlock(eb);

We need the lock because if we are actually dirty we need to make sure
we aren't racing with anything that's starting writeout currently.  This
also makes sure that we're accounting fs_info->dirty_metadata_bytes
appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c  | 11 ++++++-----
 fs/btrfs/tree-log.c | 34 +++++++++++++++-------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5942005d50fe..5bcb77662b1d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -969,7 +969,7 @@ void btrfs_clean_tree_block(struct btrfs_trans_handle *trans,
 			    struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-	if (btrfs_header_generation(buf) == trans->transid) {
+	if (!trans || btrfs_header_generation(buf) == trans->transid) {
 		btrfs_assert_tree_write_locked(buf);
 
 		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
@@ -5077,11 +5077,12 @@ static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 			start += fs_info->nodesize;
 			if (!eb)
 				continue;
-			wait_on_extent_buffer_writeback(eb);
 
-			if (test_and_clear_bit(EXTENT_BUFFER_DIRTY,
-					       &eb->bflags))
-				clear_extent_buffer_dirty(eb);
+			btrfs_tree_lock(eb);
+			wait_on_extent_buffer_writeback(eb);
+			btrfs_clean_tree_block(NULL, eb);
+			btrfs_tree_unlock(eb);
+
 			free_extent_buffer_stale(eb);
 		}
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d0c40a4af48d..f543af4328b6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2635,11 +2635,12 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 					return ret;
 				}
 
+				btrfs_tree_lock(next);
+				btrfs_clean_tree_block(trans, next);
+				btrfs_wait_tree_block_writeback(next);
+				btrfs_tree_unlock(next);
+
 				if (trans) {
-					btrfs_tree_lock(next);
-					btrfs_clean_tree_block(trans, next);
-					btrfs_wait_tree_block_writeback(next);
-					btrfs_tree_unlock(next);
 					ret = btrfs_pin_reserved_extent(trans,
 							bytenr, blocksize);
 					if (ret) {
@@ -2649,8 +2650,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 					btrfs_redirty_list_add(
 						trans->transaction, next);
 				} else {
-					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
-						clear_extent_buffer_dirty(next);
 					unaccount_log_buffer(fs_info, bytenr);
 				}
 			}
@@ -2705,11 +2704,12 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 
 				next = path->nodes[*level];
 
+				btrfs_tree_lock(next);
+				btrfs_clean_tree_block(trans, next);
+				btrfs_wait_tree_block_writeback(next);
+				btrfs_tree_unlock(next);
+
 				if (trans) {
-					btrfs_tree_lock(next);
-					btrfs_clean_tree_block(trans, next);
-					btrfs_wait_tree_block_writeback(next);
-					btrfs_tree_unlock(next);
 					ret = btrfs_pin_reserved_extent(trans,
 						     path->nodes[*level]->start,
 						     path->nodes[*level]->len);
@@ -2718,9 +2718,6 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 					btrfs_redirty_list_add(trans->transaction,
 							       next);
 				} else {
-					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
-						clear_extent_buffer_dirty(next);
-
 					unaccount_log_buffer(fs_info,
 						path->nodes[*level]->start);
 				}
@@ -2788,19 +2785,18 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			next = path->nodes[orig_level];
 
+			btrfs_tree_lock(next);
+			btrfs_clean_tree_block(trans, next);
+			btrfs_wait_tree_block_writeback(next);
+			btrfs_tree_unlock(next);
+
 			if (trans) {
-				btrfs_tree_lock(next);
-				btrfs_clean_tree_block(trans, next);
-				btrfs_wait_tree_block_writeback(next);
-				btrfs_tree_unlock(next);
 				ret = btrfs_pin_reserved_extent(trans,
 						next->start, next->len);
 				if (ret)
 					goto out;
 				btrfs_redirty_list_add(trans->transaction, next);
 			} else {
-				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
-					clear_extent_buffer_dirty(next);
 				unaccount_log_buffer(fs_info, next->start);
 			}
 		}
-- 
2.26.3

