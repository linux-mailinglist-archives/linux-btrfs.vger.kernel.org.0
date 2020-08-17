Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC350246613
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 14:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHQMMk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 08:12:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:57088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgHQMMj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 08:12:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AB6EAEDA;
        Mon, 17 Aug 2020 12:13:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 431A2DA6EF; Mon, 17 Aug 2020 14:11:34 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: remove const from btrfs_feature_set_name
Date:   Mon, 17 Aug 2020 14:11:34 +0200
Message-Id: <10b15e1509df9cfac16f3f1c1ec26574009778fd.1597666167.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1597666167.git.dsterba@suse.com>
References: <cover.1597666167.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_feature_set_name returns a const char pointer, the
second const is not necessary and reported as a warning:

 In file included from fs/btrfs/space-info.c:6:
 fs/btrfs/sysfs.h:16:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    16 | const char * const btrfs_feature_set_name(enum btrfs_feature_set set);
       | ^~~~~

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 2 +-
 fs/btrfs/sysfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 88fd4ce937b8..11e5f0a520d8 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -973,7 +973,7 @@ static const char * const btrfs_feature_set_names[FEAT_MAX] = {
 	[FEAT_INCOMPAT]	 = "incompat",
 };
 
-const char * const btrfs_feature_set_name(enum btrfs_feature_set set)
+const char *btrfs_feature_set_name(enum btrfs_feature_set set)
 {
 	return btrfs_feature_set_names[set];
 }
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index c9efa15f96e0..4217823e255c 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -13,7 +13,7 @@ enum btrfs_feature_set {
 };
 
 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
-const char * const btrfs_feature_set_name(enum btrfs_feature_set set);
+const char *btrfs_feature_set_name(enum btrfs_feature_set set);
 int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
 int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
-- 
2.25.0

