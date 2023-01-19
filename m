Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2966745A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjASWO2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjASWNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:47 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58ADA838E
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:35 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z9so2739184qtv.5
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YSJn7uUirpjoq/znkENuFvimDFsQD/Dz7Or9p1ebJg=;
        b=6W0shub5HaPja2EPBb9fcTM4Q+7cYoEzblP30Phfgibj2kfXqDPz3QrR1giCvMCgTE
         oiOcJOwwZWY6hzSTiBTCQ327ez5uTJr0ZtUkKXBahxr/y7yNoe1vJ2wLb+hWDE5p3G58
         BH0vhxK8/Q/X4NB0byNhy/SPgkWcpmbgSaV/4Wy+bTmBvz7udZs7IS6ckHqwxkzyvsES
         iQ7F1keNL5sN141tNuVjpw/9hwq15jjOkNrJazEChxdjimZ7C5wz8MqEXhZKjBiOQlo+
         uR+0kFZsgH0zKHqH7fsXp+96AeCtVb/dYsrtZtFpMGcEGY6WtwQOc1AWJ0qma4ZCdlaY
         vBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YSJn7uUirpjoq/znkENuFvimDFsQD/Dz7Or9p1ebJg=;
        b=Lbko0Q0Q9iKyfV/D3YzrV2GZTFQ+tclVywJGlEgJUKCo6njZJ9M0YqTL9aLzaif/Pj
         oihGy05EZlwHuWQ+0L/TRo5ryk7VgsxwEvnJ0kaP/1djycxsL5HFdfiP6B+hbc0eUQzD
         R5xcW36myPC3hjgvl57ds+m51I30ADlNCT9ZNkbLsvkpd4hnCZkJZUtQ1bYJnNL4dwJT
         U5rNM9+g+RECuVzcazwZrdSjknNdFRHl5jOC6L3S/50w+eBVi0bHUzaHwKlJE+wcJ3XL
         aK+qKSTJNl0r7bh6BLp5a8cbp1NOeSjAzJ9IGczjP/4i0AySEaoaRLttYGJzrnkF9Vr+
         yRzg==
X-Gm-Message-State: AFqh2ko8ZlTLH+W0ngiAJoYzj9bJ4agP0hj662Vu8fM2fsO7ayNEMqpK
        8h56SKO3WEFxkq2b/tmB7GWMd+wrVSJk4i1GGc0=
X-Google-Smtp-Source: AMrXdXsdbDTnJjh4j0wYFBaftDqKvMF3LSa1zPvWK1t4aPR8LPIFxBpp+WHPbmYb1TygNHxXxLk8wA==
X-Received: by 2002:a05:622a:995:b0:3ad:797e:7314 with SMTP id bw21-20020a05622a099500b003ad797e7314mr20114164qtb.1.1674165214330;
        Thu, 19 Jan 2023 13:53:34 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b0070209239b87sm5286136qkb.41.2023.01.19.13.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 5/9] btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
Date:   Thu, 19 Jan 2023 16:53:21 -0500
Message-Id: <199c9a6b1d22d40ab8c73609508e6c982aff2272.1674164991.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
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

