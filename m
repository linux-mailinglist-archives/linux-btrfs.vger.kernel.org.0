Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88CA646412
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiLGW2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 17:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLGW2X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 17:28:23 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D805B5B1
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 14:28:21 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h24so17325140qta.9
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 14:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YSJn7uUirpjoq/znkENuFvimDFsQD/Dz7Or9p1ebJg=;
        b=lTaIA1BbscD2meRYe9hzNfERxFK99oPfu7Zfx9vHuHZCTzJEpO57zn76lEUSc3RQQ+
         8qmZnU2xdt0BsHTkob7mGy6FC8h+zjzUo8OKIuHL2XSPgr5EVul+8r9KO118A6SbiAYZ
         Su3OdkHp7mceSWMFxdaD9+LeckkOY38qXyMYEPOpPH8yI0yQIhjNeTaakXT1zRk14SJZ
         eqD8g1df7pvxpZJ3QPf/bg4JM9bFjYZfdccnJ2okpftXHtg+hl4VKqYguW+sc4RHOdA4
         dr5DF+hC9UvZYbQzO77nbzfbnu6Fc6LbhFBX5fQR8le2OZ6wYQ7zXRbszaudPPpgaoDu
         3W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YSJn7uUirpjoq/znkENuFvimDFsQD/Dz7Or9p1ebJg=;
        b=aphtS+3rab96HkUGxXWJY5Wf0ePflpCu9EWRaUWBrXoyFzrb1H29LhO/8NRfTpwe2x
         X8DrX3a1eHEe9Aw0ARuQU0ykdKcYqQdvfgnole1Yb57hjZrL7O2I+5HTAW+cHUND+6/C
         SNZ8NcZq8W2L0Awl2UCWmr3WuEb+hFNaGxnaNkVdc/rRWyjbeqK18ElsVHPWbfM0TpoZ
         ZoXugBqQTCkS3pRu5C3rNVXpi05rGk+8jCLtFQjkzKhlHhTFXDofxy0nhJhsd1p66OjI
         ZXTVKtbU6XzryYziUCuZ6zGGF11EeXDd5XN2m8SaxarsMVHyO0NYONXKeazz+lY+2fY8
         fb8w==
X-Gm-Message-State: ANoB5plSKUkPMQYmWE45YdM6JCvQsP7lWS+gYdkXsdkSfPiYwYQZTT22
        5RR2fRBas76J4sOpxGujLRkRwcQMb9R5Vz0Q
X-Google-Smtp-Source: AA0mqf54XKocSi1cyWnZEq2tqRte/9JKvDdu48ds616S95X0/qtdtIKv5xfcrC/aqkE1M8NfYMpmaA==
X-Received: by 2002:a05:622a:114a:b0:3a7:e1db:2fdb with SMTP id f10-20020a05622a114a00b003a7e1db2fdbmr1667417qty.58.1670452100262;
        Wed, 07 Dec 2022 14:28:20 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c3-20020ac81e83000000b003a7ec97c882sm3484605qtm.6.2022.12.07.14.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:28:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
Date:   Wed,  7 Dec 2022 17:28:07 -0500
Message-Id: <814963dbb8e94fdaaa3092d63bead4305377ec2a.1670451918.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1670451918.git.josef@toxicpanda.com>
References: <cover.1670451918.git.josef@toxicpanda.com>
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

Now that btrfs_clean_block doesn't care about the transid, we can
replace all occurrences of

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
 fs/btrfs/disk-io.c  |  9 +++++----
 fs/btrfs/tree-log.c | 34 +++++++++++++++-------------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 267163e546a5..275ba1925eeb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -5074,11 +5074,12 @@ static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 			start += fs_info->nodesize;
 			if (!eb)
 				continue;
-			wait_on_extent_buffer_writeback(eb);
 
-			if (test_and_clear_bit(EXTENT_BUFFER_DIRTY,
-					       &eb->bflags))
-				clear_extent_buffer_dirty(eb);
+			btrfs_tree_lock(eb);
+			wait_on_extent_buffer_writeback(eb);
+			btrfs_clean_tree_block(eb);
+			btrfs_tree_unlock(eb);
+
 			free_extent_buffer_stale(eb);
 		}
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8fcfaf015a70..73e621df32f7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2635,11 +2635,12 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 					return ret;
 				}
 
+				btrfs_tree_lock(next);
+				btrfs_clean_tree_block(next);
+				btrfs_wait_tree_block_writeback(next);
+				btrfs_tree_unlock(next);
+
 				if (trans) {
-					btrfs_tree_lock(next);
-					btrfs_clean_tree_block(next);
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
+				btrfs_clean_tree_block(next);
+				btrfs_wait_tree_block_writeback(next);
+				btrfs_tree_unlock(next);
+
 				if (trans) {
-					btrfs_tree_lock(next);
-					btrfs_clean_tree_block(next);
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
+			btrfs_clean_tree_block(next);
+			btrfs_wait_tree_block_writeback(next);
+			btrfs_tree_unlock(next);
+
 			if (trans) {
-				btrfs_tree_lock(next);
-				btrfs_clean_tree_block(next);
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

