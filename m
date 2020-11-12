Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BE72B1015
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgKLVUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgKLVUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:34 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF527C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:28 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d28so6870913qka.11
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3GdvVeYUHuHsAl/wkRIed8nsKiAiLaEzEnl0Kmn6TKo=;
        b=HhttVnLi9sWOPNxuF9T6NI5+aAuzXmjgFy3TZ9aAs1p1xCD3lR0sB0N90IwPqpmbRl
         9QMCuns8PP3ZqYtbb5n4TL5UQaZ4UQZo1cyT1tEumsqGn6D3Q+CATfGp2cvw2dv8BJQQ
         PUStQekJEJ6odtROy565WynmlvQkRoBdbByfUybkArfKWN1qAWHFcMzTG5GFlqyKOYSw
         yx6w+1yWxWdHjExXlCz7DH3cIay7zkq16t4pIUE9qr8OTIijtsDLtA9JCXh7cleTAKIm
         1g5tkviaE9IgEEbAeDp5YXcAFmXun9dK9zKMrVMiEinCdVd82xOhW1xZCZX8QFixnaUG
         1WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GdvVeYUHuHsAl/wkRIed8nsKiAiLaEzEnl0Kmn6TKo=;
        b=MuWdioTdhjeH99ROA9zqkgrCYp2kdPGt5htbacASgpDWbtaPBpSkbphijYGopO+AYA
         Loe9A3KR2npS5lOCq8GNyh6ePhGtApHN0fDjarwAltFmErN7dJeacyNpTIfXU53Awnjl
         lak3CiyJ8uxrxm9vw9ou26bW83gw3aW1oXq/HAgpjZP1rh0EFqSwbAmKR+M2IUthTaoy
         6+YIeLx/KIiilEd0sqsd7NmVx7nJ/oCgySsJhPuxc+i9Ui8IsI6NknO4hbvcnfikJk6t
         MA2wCJRZhVRHEu6OvhRnLcStMRdUdALzltBJYheFEhKzQ54nAzxUcN50tRkXaEsN0p6E
         9rSA==
X-Gm-Message-State: AOAM532ed1kuJPSRM1BRDXSLpmjJF5KSm3SUlTywrN5H8kURixJ3zSCo
        yK3u2rJ31kVXSHalQZ8jl8PKiG7Y4bBjSQ==
X-Google-Smtp-Source: ABdhPJyWi/fQ3NEb+mkVz53egshGPNbFKaLB5kQf7tan4saNBsFNoZEaWTJL51v7mMpLZro206h4eg==
X-Received: by 2002:a37:6c06:: with SMTP id h6mr1889707qkc.288.1605216027332;
        Thu, 12 Nov 2020 13:20:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w184sm1159266qkd.47.2020.11.12.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 35/42] btrfs: remove the extent item sanity checks in relocate_block_group
Date:   Thu, 12 Nov 2020 16:19:02 -0500
Message-Id: <736cea4bf84d6f8b919e13d02836f46c9b2fa5fd.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These checks are all taken care of for us by the tree checker code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 100cd8eba91c..80d5fea41791 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3365,20 +3365,6 @@ static void unset_reloc_control(struct reloc_control *rc)
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
@@ -3430,7 +3416,6 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
 	u64 flags;
-	u32 item_size;
 	int ret;
 	int err = 0;
 	int progress = 0;
@@ -3479,19 +3464,6 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
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
 
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			ret = add_tree_block(rc, &key, path, &blocks);
-- 
2.26.2

