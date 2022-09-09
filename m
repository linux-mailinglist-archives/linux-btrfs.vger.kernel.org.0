Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05D5B41DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiIIVyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiIIVyk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A8E63CF
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m9so2283518qvv.7
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=kTGt01uXOuF+evZSs3NlXlqXZ3La1eFakwfpIx4UWQw=;
        b=4sECLwifBpMEhaSkYjm1jDbXSKhJS/ilyoXsEhiwFZJMhdbjR/cQR6mHFuspa2yr7f
         398+n3NDdWwID/2w/vbXxyCefzn1s1Ppm0lScyzcOaWe5gDf2wZr6CGWhTPF0lsXcywL
         Nc4aNQTVwQDVFZnNO14ABK5+neuvOceK1lZwVRiBgnqbSD3x7fYUDBmjjGAFyoF1rMOh
         fLM50zULI3K3Cm4MZC7hvFKFMFHojDpPAPuxA+FCyH4VAb3dd2dl1DU/z31LPgXJqD05
         miEVSRAwZJZojFa8kbemSI87WDgsrsn1IP8em6MwYans0pXlF/Kcstqv+JTHJsJU7egY
         Mn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kTGt01uXOuF+evZSs3NlXlqXZ3La1eFakwfpIx4UWQw=;
        b=d8Dh9hL098HTeUe37sPb4IXrqAOFQ4cKNMfXuav6/ulfYfUmmxb6mINJYu8g8v/faI
         QhmW8CQBPUEo7YnrD9/V3MChWHnmGkNgbnpPGAqfYj4UOUhMsxW+lu4/9B/yYzY1rkGU
         5ESbhgNubBQVDDyt9Sy/M2r+5u890V0XwRsSn8wHgcV5WlBAvMB0zzOHhtOmMMprYaN7
         tn7lt7vK07VOmXUKP13cx5dUT190qs4vhiidGT7/w250RhnkUTftVybk+w8Yab1jH//y
         OIU9BZ+gPGUDU2nK/A2hlFR9ahaUxMgYJHX4pNbQpVO8Tk38XGclNcbQMyfeJf9YfKQZ
         WI0g==
X-Gm-Message-State: ACgBeo2RaPE0aWrpvU0LPY3TW8aLxW9IZz6YM+06CDwp2+Ys47PpqsQx
        2HLB/FYSlD+JQvH4XEaLWxNPenBFffko1g==
X-Google-Smtp-Source: AA6agR78bzZisfZ0drPv6ybrqcD5TITpM0fySyKxyJSbQhB1P/u3DOYDlFf6RMW89glsYcrN546k8g==
X-Received: by 2002:a05:6214:570d:b0:49e:3c24:ee9a with SMTP id lt13-20020a056214570d00b0049e3c24ee9amr13738615qvb.105.1662760477959;
        Fri, 09 Sep 2022 14:54:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i2-20020a05620a248200b006bba46e5eeasm1524775qkn.37.2022.09.09.14.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 32/36] btrfs: get rid of extent_io_tree::dirty_bytes
Date:   Fri,  9 Sep 2022 17:53:45 -0400
Message-Id: <75f665e32cdf1682ca3ee2925878b1096cc35fd5.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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

This was used as an optimization for count_range_bits(EXTENT_DIRTY),
which was used by the failed record code.  However this was removed here

btrfs: convert the io_failure_tree to a plain rb_tree

which was the last user of this optimization.  Remove the ->dirty_bytes
as nobody cares anymore.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 17 +----------------
 fs/btrfs/extent-io-tree.h |  1 -
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 018fde078d78..3a89d338ddc6 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -98,7 +98,6 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 {
 	tree->fs_info = fs_info;
 	tree->state = RB_ROOT;
-	tree->dirty_bytes = 0;
 	spin_lock_init(&tree->lock);
 	tree->private_data = private_data;
 	tree->owner = owner;
@@ -376,10 +375,6 @@ static void set_state_bits(struct extent_io_tree *tree,
 	if (tree->private_data && is_data_inode(tree->private_data))
 		btrfs_set_delalloc_extent(tree->private_data, state, bits);
 
-	if ((bits_to_set & EXTENT_DIRTY) && !(state->state & EXTENT_DIRTY)) {
-		u64 range = state->end - state->start + 1;
-		tree->dirty_bytes += range;
-	}
 	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
 	BUG_ON(ret < 0);
 	state->state |= bits_to_set;
@@ -514,12 +509,6 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if ((bits_to_clear & EXTENT_DIRTY) && (state->state & EXTENT_DIRTY)) {
-		u64 range = state->end - state->start + 1;
-		WARN_ON(range > tree->dirty_bytes);
-		tree->dirty_bytes -= range;
-	}
-
 	if (tree->private_data && is_data_inode(tree->private_data))
 		btrfs_clear_delalloc_extent(tree->private_data, state, bits);
 
@@ -1519,10 +1508,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		return 0;
 
 	spin_lock(&tree->lock);
-	if (cur_start == 0 && bits == EXTENT_DIRTY) {
-		total_bytes = tree->dirty_bytes;
-		goto out;
-	}
+
 	/*
 	 * this search will find all the extents that end after
 	 * our range starts.
@@ -1548,7 +1534,6 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		}
 		state = next_state(state);
 	}
-out:
 	spin_unlock(&tree->lock);
 	return total_bytes;
 }
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 37543fb713bd..94574062eabe 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -69,7 +69,6 @@ struct extent_io_tree {
 	struct rb_root state;
 	struct btrfs_fs_info *fs_info;
 	void *private_data;
-	u64 dirty_bytes;
 
 	/* Who owns this io tree, should be one of IO_TREE_* */
 	u8 owner;
-- 
2.26.3

