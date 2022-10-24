Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18F60BE0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 01:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiJXXAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 19:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiJXW7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 18:59:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB51116F
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 14:21:59 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b79so8824081iof.5
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0/0XINT4mcWnMu8GE+kJhCwDo/brT605IWyeBkR2bY=;
        b=LCidE+qegguZqgFJVcGKMUnA32lDjQzPeZvHSZbBiUY9n8E9y06oMWQlMe7atq+F/f
         Aod8I8HhSOvDVEivYu6nw/koYLiFXXrYLYK5+fTcsI7lgmvCULCZVtvH8ykj3zt4CMwx
         Ag4UINlrYwifp/k5i6RFL9XRCxdKluBtb657wwyubMQ38sndDk/HujBH1fqXGnGLyGDC
         xxsXvUSq4de2b0k9vb9oSAMNxqSq5d36iqnq4akXpB8JuFWPa285vPuqkNoE99zCM9L7
         13Th/35gs7AP1Ugi9by7GfPLapOW0p8wrHXnLC6peiioTBmRs2TCMszUrP/u8aDekwkc
         6w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0/0XINT4mcWnMu8GE+kJhCwDo/brT605IWyeBkR2bY=;
        b=IYhEHRbOCaLEUf9XManup2vb1juuPdR5iAK9Fkt6NIyNgDvJdgKi+gbKaaF6bjTxZ1
         r8ydP4TEQuwjJVl7MeLz/eNNvGqWrZ0oNGIT+mFwMdQ9UuWIt2yV3jAIwGmUlqhSd+tV
         oOpznzJ+zZpVCvzSuCYeYK2sv4GMOZvqKfdYHjNysqR0QfeFLGnVLBrjvKtslWm4ltNO
         HGW7b2+4W3Q6fkESnol2Qmam+ff7cRKyiAxVr6nhfHQo7q5RAb64p8qIikAoK/MEEt7X
         W4Qcf/bQufRQAifLhNic5dkmlHQuZ4mP4/Whd88YIS+EwN0RGur03HDwpJdOy/xt03IZ
         zWAw==
X-Gm-Message-State: ACrzQf04IqE1MBS3d/QFSR7SE4DHz0J0LxRF6ZXxMKZ9yTIpxOgQKRKH
        w8GE1//xGhOlOgFrorIUzQXKnWU4PbqbkQ==
X-Google-Smtp-Source: AMsMyM49COiksAVfYwDaM/2xzOTZYfWF5D7Oc0wJwSYmz3AYYGShItp6eBQzHvcCl421LO5ITpMf8w==
X-Received: by 2002:ac8:5902:0:b0:39c:e440:6adb with SMTP id 2-20020ac85902000000b0039ce4406adbmr28930462qty.18.1666642575589;
        Mon, 24 Oct 2022 13:16:15 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x6-20020a05620a448600b006b9c9b7db8bsm623160qkp.82.2022.10.24.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:16:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: remove unused function prototypes
Date:   Mon, 24 Oct 2022 16:16:14 -0400
Message-Id: <36f49ea2d8cca64fde3bce26feff36b7fbee540f.1666642537.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

I wrote the following  coccinelle script to find function declarations
that didn't have the corresponding code for them

@funcproto@
identifier func;
type T;
position p0;
@@

T func@p0(...);

@funccode@
identifier funcproto.func;
position p1;
@@

func@p1(...) { ... }

@script:python depends on !funccode@
p0 << funcproto.p0;
@@
print("Proto with no function at %s:%s" % (p0[0].file, p0[0].line))

and ran it against btrfs, which identified the 4 function prototypes
I've removed in this patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- This patch depends on my previous cleanup series, I just didn't want to resend
  the whole thing again.

 fs/btrfs/ctree.h   | 3 ---
 fs/btrfs/disk-io.h | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 98ef5aed419b..f8bbd3a8b389 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -733,7 +733,6 @@ int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 offset);
 int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, u64 offset);
-int btrfs_find_orphan_item(struct btrfs_root *root, u64 offset);
 
 /* file-item.c */
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
@@ -912,8 +911,6 @@ int __pure btrfs_is_empty_uuid(u8 *uuid);
 int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_to_defrag);
-void btrfs_get_block_group_info(struct list_head *groups_list,
-				struct btrfs_ioctl_space_info *space);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 			       struct btrfs_ioctl_balance_args *bargs);
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 0a77948bb703..bba8eba2543e 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -114,8 +114,6 @@ int btrfs_read_extent_buffer(struct extent_buffer *buf, u64 parent_transid,
 bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
 			 u64 dio_file_offset,
 			 extent_submit_bio_start_t *submit_bio_start);
-blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
-			  int mirror_num);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
@@ -128,8 +126,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *trans,
 				  struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     u64 objectid);
-int btree_lock_page_hook(struct page *page, void *data,
-				void (*flush_fn)(void *));
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
 int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid);
 int btrfs_init_root_free_objectid(struct btrfs_root *root);
-- 
2.26.3

