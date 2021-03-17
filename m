Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3967733E5CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 02:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCQBSn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 21:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCQBS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 21:18:26 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A2C06174A;
        Tue, 16 Mar 2021 18:18:25 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id t5so663092qvs.5;
        Tue, 16 Mar 2021 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeOykkNMQbbpBA1PJcQ5FeH6saPBzbh4QkGHZqnk0Ro=;
        b=A5vgn0XfdQWMBrZ+VPQzMLIwVToSpQml7c3VSZmGwmJQLT+kinyhb8zgzDkSuyOh6i
         geME8qVdxDB5h5TPWgouA3IvTLxOkeXhMK5UG+OamFD/g1NreNEnG7jNzpZMBSFm1/hi
         5VJUPgfEyeRkQKgNGNJqIeWQhgNs5nKNaoDMFdcGPH5W18pX5TrCAdF3Sa9YhWUnHHgV
         zfC+z1DUzQZbC9nmx10mniREBby3J2F0l72iKIp7Xj5dl5HvMjgCjsCuoJKcg3kg8j2m
         WKUXhk5xcyTwngwQNQZ/UWP/hVeSqI7wpWxGB8lXDPyTFV6usINQ55D9Y7I9zMz0hELF
         8FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeOykkNMQbbpBA1PJcQ5FeH6saPBzbh4QkGHZqnk0Ro=;
        b=ldb689sjkoBdWrBUe2qZnmz0x1zBlZmu3eqqvZA682fZbLsgPoc+/7eJE8noEeT6ov
         qHmrqBStu9HAJv+rRzus+A9uLRhQb3na43YlqcqT6LjEphnPgx1Ju06RXCVdH9PYfF8v
         C2NYASOcSqNHNaj6FZsu9yTtZ09tUXwMBhJC1Y7tG3K2Qa2WWGEvgXjr0n3WLzhJBH8b
         ALr0XHIQAov5JwQ48iK9Sm8LarNq3mcEsTRSr/O1uYu6yAAZrPIcQHTC7im1G400EPBY
         ZevE8cr8KsLKrU8iv27PcVjDGgTpMfKr+QRyxC3DhhBlNM6vLTlzW6ntU3smFSuOtKZb
         Mxmw==
X-Gm-Message-State: AOAM532gKJRAo60FzbGd+y1rLrdncTWSTYh3i1FmNy6c4NdR98jntBM+
        pONAmowT4Qv8H1El8OMvMiHXOQTtEy3A5JKZ
X-Google-Smtp-Source: ABdhPJxTgchsNsgHQVgO5cunG8vrSgO+PI/WYRYmRNSBvTBlM9N9cjvoIsyMPnHhi4M8iP7fE8fQ7Q==
X-Received: by 2002:a0c:f053:: with SMTP id b19mr2886205qvl.7.1615943904975;
        Tue, 16 Mar 2021 18:18:24 -0700 (PDT)
Received: from localhost.localdomain ([81.198.225.48])
        by smtp.gmail.com with ESMTPSA id o1sm14749908qtq.81.2021.03.16.18.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 18:18:24 -0700 (PDT)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, ce3g8jdj@umail.furryterror.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [RFC] btrfs: Allow read-only mount with corrupted extent tree
Date:   Wed, 17 Mar 2021 03:20:55 +0200
Message-Id: <20210317012054.238334-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if there's any corruption at all in extent tree
(eg. even single bit) then mounting will fail with:
"failed to read block groups: -5" (-EIO)
It happens because we immediately abort on first error when
searching in extent tree for block groups.

Now with this patch if `ignorebadroots` option is specified
then we handle such case and continue by removing already
created block groups and creating dummy block groups.

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 fs/btrfs/block-group.c | 14 ++++++++++++++
 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/disk-io.h     |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 48ebc106a606..827a977614b3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	ret = check_chunk_block_group_mappings(info);
 error:
 	btrfs_free_path(path);
+
+	if (ret == -EIO && btrfs_test_opt(info, IGNOREBADROOTS)) {
+		btrfs_put_block_group_cache(info);
+		btrfs_stop_all_workers(info);
+		btrfs_free_block_groups(info);
+		ret = btrfs_init_workqueues(info, NULL);
+		if (ret)
+			return ret;
+		ret = btrfs_init_space_info(info);
+		if (ret)
+			return ret;
+		return fill_dummy_bgs(info);
+	}
+
 	return ret;
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 07a2b4f69b10..dc744f76d075 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1955,7 +1955,7 @@ static int read_backup_root(struct btrfs_fs_info *fs_info, u8 priority)
 }
 
 /* helper to cleanup workers */
-static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
+void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 {
 	btrfs_destroy_workqueue(fs_info->fixup_workers);
 	btrfs_destroy_workqueue(fs_info->delalloc_workers);
@@ -2122,7 +2122,7 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->qgroup_rescan_lock);
 }
 
-static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
+int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 		struct btrfs_fs_devices *fs_devices)
 {
 	u32 max_active = fs_info->thread_pool_size;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index e45057c0c016..f9bfcba86a04 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -137,6 +137,8 @@ int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid);
 int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
+void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info);
+int btrfs_init_workqueues(struct btrfs_fs_info *fs_info, struct btrfs_fs_devices *fs_devices);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void btrfs_set_buffer_lockdep_class(u64 objectid,
-- 
2.30.2

