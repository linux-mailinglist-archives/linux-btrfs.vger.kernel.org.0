Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8799744CA5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhKJUSA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhKJUR7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:59 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D264C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:11 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id u16so2644631qvk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=l71HG4rrF1bch7aFnY+4ss8kw+V0MPubtB8XLE0T2hYY1+yYSBNiCCbRKCor4jSLRC
         eczMUCPlV5inu+RM5LoIZEz/Bve6N+NmECqzfD7W15IUOni8yMc/6U0qbbuySnZPXD8C
         QD2pUsV/NKutbNVs3RSwCrSd1u9TuvehsBNnHpi+LmB2XrG8EdltKcAPQlxHas1gMsdE
         GTKN04spw2axtpRrP5W9E0dr+VoWmKbcb0HFE8glpdmvPZMU3FkUMp0ohCycCpFLWmHj
         eQGNUtrVvq+C0j1fiCSh6iMdUq39pwcf1ig/5nn2SE25khR4/NkPcXgdHMKk4gjwrZc1
         vpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=D3apiNw4HEXmyTFngyt/yIOTCGaaZKOVmpezHwXHnZFih3Vz7MPafSb/9GFJRwtMXx
         yy6vAp+S7ePJ6sBIkR9JWcQicxWznjgUVxvfVP1XoqgYeV0Al83ImLc1+JzvBiQFNG6z
         B2OSa7l1ow+khlB+Zp/O454Z4fe1LScVE84VaGhwEzx+x5XxB8cwuKjm5JMYIz4ZUnSQ
         2pooQfeHqDnRHZnlucfmcxc/kMy61AwABnuccRM0ic6gCuwZiY8eoXZz0HrbZb4kCnJP
         2qOjSm0+4HoHpPuR5qCSq7PAjWw/smgjS5DDhr+2+1sQS/sbbaEJ65IRSKb34VS50iRe
         e6mw==
X-Gm-Message-State: AOAM530vgdw7Z1V0b5XmspkuBS+GW3u1I6/NET7pOUiExPmizwwq8PV/
        vIF7JR6WTwzL1guFfFxw5gv3+7ucnFetzQ==
X-Google-Smtp-Source: ABdhPJzm/Ou4WYQYM8vZtV8VGFKNh+CpDuLmfGC1yU8OGqNLUlXEYmoG1Ab3dC24LSPCFglOOWGuHg==
X-Received: by 2002:a05:6214:2606:: with SMTP id gu6mr1374713qvb.30.1636575310565;
        Wed, 10 Nov 2021 12:15:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v17sm405327qkl.123.2021.11.10.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 16/30] btrfs-progs: handle no bg item in extent tree for free space tree
Date:   Wed, 10 Nov 2021 15:14:28 -0500
Message-Id: <f9ec634f55d64e50b610ff3fb36e61bc41b58313.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have an ASSERT(ret == 0) when populating the free space tree as we
should at least find the block group item with extent tree v1.  However
with v2 we no longer have the block group item in the extent tree, so
fix the population logic to handle an empty block group (which occurs
during mkfs) and only assert if ret != 0 and we don't have extent tree
v2 turned on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/free-space-tree.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 0fdf5004..896bd3a2 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1057,6 +1057,9 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
+	start = block_group->start;
+	end = block_group->start + block_group->length;
+
 	/*
 	 * Iterate through all of the extent and metadata items in this block
 	 * group, adding the free space between them and the free space at the
@@ -1071,10 +1074,11 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out;
-	ASSERT(ret == 0);
+	if (ret > 0) {
+		ASSERT(btrfs_fs_incompat(trans->fs_info, EXTENT_TREE_V2));
+		goto done;
+	}
 
-	start = block_group->start;
-	end = block_group->start + block_group->length;
 	while (1) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
@@ -1106,6 +1110,7 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 		if (ret)
 			break;
 	}
+done:
 	if (start < end) {
 		ret = __add_to_free_space_tree(trans, block_group, path2,
 				start, end - start);
-- 
2.26.3

