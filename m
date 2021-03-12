Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B15339859
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhCLU0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhCLU00 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:26 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7DC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:26 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r14so4843611qtt.7
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CttJ9njXn1GJ9FxGeLawCa94kwhIkd25rDBMICcOQc=;
        b=JNoDxT89lNUv309zOYGSGNy1YOBHfJWvpWxDjPyvB793d/562+M7AHcZVXR/VWMUds
         8o/LHgJXym+Bs/tRKmoIIizcZ2PUR5A/JWt1TLusnCOVJn7iX5cdMMPiYw/3cZZP80Bu
         9VA6yLsJWm1lASmCIsqAGgAfxtShkF9ivoCw34fR56d4xFnuOPafmRMlw/wciWWMwlRu
         dIwxpaVTD4xst+u3r1XV/jNcyvEwxyAMTzXwtQFcZtCvKgKLhSbedr0oOMTs1Qw+DCxz
         u2s3O20sna0sNxeezSYw6o4tDo1Zr+OPsHgQ71Gogr0NF5ZCQKkQ0EalPXTEawAIkSGn
         aWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CttJ9njXn1GJ9FxGeLawCa94kwhIkd25rDBMICcOQc=;
        b=OjAaG5GSO6GtFSJiVKArQNQGRybH0JBSM9F4bR+Fi0m34XCr0NvheRySofjqh+CNIr
         wH4rbfweyCC5FIBnJi1QLID5kOE5cy68c8qxamvxNmhIqwCg3sdJq8PGZ84t2UyJ/Oa7
         I1tX7Dl6fMhpDDqw2SuwIrrKJtz1kf1I5j6gOQFz6pwXQRMz/8LofevVHo0c9/kznSCv
         Mtqt+JXOVT+DaR/eiAKgyzncOrImoZDr+g+kH5/i3HI54b4uEwS+oDFuzB1XVx2iTin0
         8MqWELCwvG9g+lSqL1tGFhSaRiyLN3AMWX8ALeo564SiS5ab8Ta1Aj4bUjx8J4aYxZjG
         H+Pg==
X-Gm-Message-State: AOAM532DVBDuLcWgmwla0FTDl6t6qPCMMzYc0GjIkNVWQ94/jmkxSbuj
        U3zicD6iS0uLVX+Y49AI+cC84bC47R9aKyVl
X-Google-Smtp-Source: ABdhPJzX84gSadisAcrYqXgjW7qscQTJTWUSRNl/MIp8DRlyehhuVYx/h5gqr0fw3SiYfQkThvl5KQ==
X-Received: by 2002:ac8:66c4:: with SMTP id m4mr13743201qtp.374.1615580785743;
        Fri, 12 Mar 2021 12:26:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l65sm5160871qkf.113.2021.03.12.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 32/39] btrfs: remove the extent item sanity checks in relocate_block_group
Date:   Fri, 12 Mar 2021 15:25:27 -0500
Message-Id: <fc498e7a8e4d6e7cfb5661627f3225738bdc609b.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These checks are all taken care of for us by the tree checker code.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 71a3db66c1ab..288d5df39fa0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3407,20 +3407,6 @@ static void unset_reloc_control(struct reloc_control *rc)
 	mutex_unlock(&fs_info->reloc_mutex);
 }
 
-static int check_extent_flags(u64 flags)
-{
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if (!(flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    !(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))
-		return 1;
-	return 0;
-}
-
 static noinline_for_stack
 int prepare_to_relocate(struct reloc_control *rc)
 {
@@ -3472,7 +3458,6 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
 	u64 flags;
-	u32 item_size;
 	int ret;
 	int err = 0;
 	int progress = 0;
@@ -3521,19 +3506,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				    struct btrfs_extent_item);
-		item_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
-		if (item_size >= sizeof(*ei)) {
-			flags = btrfs_extent_flags(path->nodes[0], ei);
-			ret = check_extent_flags(flags);
-			BUG_ON(ret);
-		} else if (unlikely(item_size == sizeof(struct btrfs_extent_item_v0))) {
-			err = -EINVAL;
-			btrfs_print_v0_err(trans->fs_info);
-			btrfs_abort_transaction(trans, err);
-			break;
-		} else {
-			BUG();
-		}
+		flags = btrfs_extent_flags(path->nodes[0], ei);
 
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			ret = add_tree_block(rc, &key, path, &blocks);
-- 
2.26.2

