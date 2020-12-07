Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68782D12DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgLGN75 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGN74 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:56 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3BFC094255
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:09 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so9392621qtp.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOdTaGLj82z5oYT5RFXY3u1vGDFWSx78SY5hlvg+0k0=;
        b=yAmLXjT6nZGWOY8JWSVgfUVqGxAbmOR7ggz3gksdgX8YabC84tQqq2Lo7xOKguOGyy
         CCHnYpiW7c4tCR9Lp8EyfjFlG9c9+QTdSZ0wBqk81htzF9CWYdJAOhjxUZ48mgFVFwsv
         BYZXGukuoosEVK/E81znoqkt8uddgjDQLnBoCCYWQauoj6VK5r31pqpd0EwE8MKHUgeh
         ZTwVyJoss6WsTbmdeZfe1bfxbTjM3wVObFVi3L7l/O77f+PWWzzWcuFlDY3WwCbWL1XF
         7J/GS7HRkdnlyO7zB6CzRFR45UZX9L5A4G1565swO8d5021JgAOasrjGR6kyGZFSEu3C
         e5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOdTaGLj82z5oYT5RFXY3u1vGDFWSx78SY5hlvg+0k0=;
        b=X/RAjYjwSBA1dJsE59Li6OTlmowpG9tPUcTI1fWgn0TNqdCY1AJjDrqMlhJvI2LCoB
         gz8OeW2ys2rd2qRH74aJHWGjV+G1voK9xz9cA8CIMOCaJNihX7LfzhPuFvsU/gYMQBGA
         lGfU86XQVw47dpcvp1eG6MRXEuvuPSjjpNxY2qDfQfzPVa/Qlq++7hi0InoS3xBV3+nS
         xtdnFSvk5UP9vzs7K2+ghiKAgmHn4lBwrnYO52U10dc4zBvLbcMcgM7fECMrrb/wnd7a
         STttoMLem0tz10QL7ZgeZJw77Ptj7OASW1TnxHWkqJunqJxrs4vZE9O3cXtdF9ES02C4
         +W8A==
X-Gm-Message-State: AOAM532pLJOI9vxkkCtCrF1XcqtHKHy46VWxGrDVRi/GYcdZZbS2JP5F
        p6XY7eWiK2VomklMNV33r53GUjNEY/cKCk8x
X-Google-Smtp-Source: ABdhPJwe/Wq9Lqxplscv5U23MjE0TxhRbAglf+ynl42REMv6zEfQ62BXZStZ6i5szkSpMybmpS/GBg==
X-Received: by 2002:ac8:685:: with SMTP id f5mr23763795qth.40.1607349547903;
        Mon, 07 Dec 2020 05:59:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a28sm1121170qtm.80.2020.12.07.05.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 42/52] btrfs: remove the extent item sanity checks in relocate_block_group
Date:   Mon,  7 Dec 2020 08:57:34 -0500
Message-Id: <76552150f815342385cce5a4b01832ee3670fbef.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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
index bff7e99f3654..5227b4f7d115 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3363,20 +3363,6 @@ static void unset_reloc_control(struct reloc_control *rc)
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
@@ -3428,7 +3414,6 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
 	u64 flags;
-	u32 item_size;
 	int ret;
 	int err = 0;
 	int progress = 0;
@@ -3477,19 +3462,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
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

