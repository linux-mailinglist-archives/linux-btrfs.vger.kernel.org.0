Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82724A180
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHSOQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 10:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgHSOQj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 10:16:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0E82076E;
        Wed, 19 Aug 2020 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597846599;
        bh=vTJUHVdF35cnboLxY4OxDfXFZrXo8IGxmY/aGjhnyJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKi/GbBN5RqAlPUl9kLaBnPLwd6i67sIOjkR/rjij9RIXaYtwmzGzdtYUspZOgk6f
         UgzyYXdRJly1tMaVpE5bq+VQyhEXTf4pdCYSEwRfqjWH9FoBSAHAnbmKXBlQjGbhKP
         cX/JGDjq8TnBD3spLj5MFlebOrlrW4N87sL3hbfs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] fs/btfrs: Fix -Wunused-but-set-variable warnings
Date:   Wed, 19 Aug 2020 17:16:28 +0300
Message-Id: <20200819141630.1338693-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819141630.1338693-1-leon@kernel.org>
References: <20200819141630.1338693-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The compilation with W=1 generates the following warnings:
 fs/btrfs/sysfs.c:1630:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
  1630 |  int ret;
       |      ^~~
 fs/btrfs/sysfs.c:1629:6: warning: variable 'features' set but not used [-Wunused-but-set-variable]
  1629 |  u64 features;
       |      ^~~~~~~~

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 fs/btrfs/sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c8df2edafd85..d3652bcc2a86 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1626,13 +1626,12 @@ void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_fs_devices *fs_devs;
 	struct kobject *fsid_kobj;
-	u64 features;
-	int ret;
+	int __maybe_unused ret;

 	if (!fs_info)
 		return;

-	features = get_features(fs_info, set);
+	get_features(fs_info, set);
 	ASSERT(bit & supported_feature_masks[set]);

 	fs_devs = fs_info->fs_devices;
--
2.26.2

