Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD828F6FD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 09:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKKImg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 03:42:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43641 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfKKImf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 03:42:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so10207059pfb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2019 00:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UdEYO/l+yqACUXEMzQNWfPJKUu9x/M3Z7pOW/zQLvdM=;
        b=dTnzZGzZO9U76nlW/CNGLogWRP6lultFwWwfFdUd3txPIKNBuTDO4n8UXs+GockSsE
         lKFC3myJL5OF/ScR45zaNagcSUgm3dj34eAFVVa+hu2H4A1uJV1IomQERwgZXeAGPv4E
         yp9EKDuQ0mFGTt0wVFcsRZ3CU0De19AKFa4H2/YRwrPbDrmMMLesFhtcdd/5FPjxC3ZO
         SyS8dxzLuhac9AtycZpo8s1T0kskXP+U0hzp+QFAAHzo+VUemO5bZYDdJNmxgDhRw3Bm
         gXNbOEMKHcVzEg36qmczvXQew0rghR6aXTa1GgFwDJV/zeC+rIhlei5FiRlxi2L0NJKn
         MPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UdEYO/l+yqACUXEMzQNWfPJKUu9x/M3Z7pOW/zQLvdM=;
        b=BqK0+c+vOL2vGj6HlY8oHWEUjrlGNcw5hHyoxEVZd48YNYnaVOq8uhJeJUUIhVDG+c
         hhfgIVkjrPQiATtXTXSE/Q/JfpPRI/Bj+4DdIuxvH6HyYd7vA21UXUHqyGQ6ggflCrSh
         +2dTqvZ52gWgmQ3Rn5Qo9qpL9SfN1Zs9zSRuo+rD7dW8kuJ836voQZBxmcYvZgTtU590
         VowTAZH00sX2Yv4eRLyWa8hV0MwQh8QbWl76WMkLqDmeRNQ2h3M65uBaK8ZQIOU0JIFt
         e6k364Vm4Ylcm61D/SeXpuSDE+wy/tJUNOu0cdlNdapnR2X3DXHrmL/pib/w8dvfIuW4
         eQXw==
X-Gm-Message-State: APjAAAWZcaTTgJVlmgN5DmOpZBkWsqQtjPntO7SdYD9KPpWoR3XDSWnw
        sVgMeLHzyOPeF0j1MM4xRNcxa9j2zpw=
X-Google-Smtp-Source: APXvYqzaikJry4J+4Uxp89WKCJtgVwV/gPayGaexcGo9jfqvHDfoVQYbTimHkg/p8Ow1NvNlY+J01A==
X-Received: by 2002:a65:6145:: with SMTP id o5mr26646509pgv.38.1573461751965;
        Mon, 11 Nov 2019 00:42:31 -0800 (PST)
Received: from cat-arch.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id i16sm12771679pfa.184.2019.11.11.00.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:42:31 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Damenly_Su@gmx.com
Subject: [PATCH 1/2] btrfs-progs: add comments of block group lookup functions
Date:   Mon, 11 Nov 2019 16:42:25 +0800
Message-Id: <20191111084226.475957-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The progs side function btrfs_lookup_first_block_group() calls
find_first_extent_bit() to find block group which contains bytenr
or after the bytenr. This behavior differs from kernel code, so
add the comments.

Add the coments of btrfs_lookup_block_group() too, this one works
like kernel side.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 extent-tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/extent-tree.c b/extent-tree.c
index d67e4098351f..f690ae999f37 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -164,6 +164,9 @@ err:
 	return 0;
 }
 
+/*
+ * Return the block group that contains or after bytenr
+ */
 struct btrfs_block_group_cache *btrfs_lookup_first_block_group(struct
 						       btrfs_fs_info *info,
 						       u64 bytenr)
@@ -193,6 +196,9 @@ struct btrfs_block_group_cache *btrfs_lookup_first_block_group(struct
 	return block_group;
 }
 
+/*
+ * Return the block group that contains the given bytenr
+ */
 struct btrfs_block_group_cache *btrfs_lookup_block_group(struct
 							 btrfs_fs_info *info,
 							 u64 bytenr)
-- 
2.23.0

