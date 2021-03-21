Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B1C34350C
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Mar 2021 22:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhCUVrO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 17:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhCUVrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 17:47:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AD3C061574;
        Sun, 21 Mar 2021 14:46:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so7971355wmd.4;
        Sun, 21 Mar 2021 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHVroE09bYfHZ55DaPFtDs49Byg6Kj1pwjra28kTtDc=;
        b=cZ3Z2iqzc+HKxMSXTVl8O24XA5V5hy2iN4NP/8/PjkvFpBZCd5gdSVYl0jUpUfwIuA
         oaOqEibaWW7Iap2K8KNEGQJI8KHJvQW1s4nS01J4X/P+DcRJFI0oPj1sj2Z4Buk/cARN
         avf+dspseEpjBQ+SyJ7IbJIxunAiI6PADPwaZHygb55lJTV9kobgH5gPmNfhbqrD8uet
         JZz+TuYSWX0A6D46KUzU1hPcENmX7RaOMKlvMndrrYN/pO5PeNvIBuBsCuz/83cPeqP6
         /8b4wuZ7IGnZigambPX0p9poYN3hBywSxu7LvX/aeXHq9mjbD5T3JsebQ0CqEJU5iMVQ
         /i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHVroE09bYfHZ55DaPFtDs49Byg6Kj1pwjra28kTtDc=;
        b=WBj9qxoQaw8cds546usm/BIVBacbkhSeJOwN+/2g9B8xyml514lNzAUeG5qdJyX0hQ
         CanspalEODrRWnurEo98rvD8DCxkLty3gMOhbZa3Mxe2rlETfCprSSCdmPWRgqw6yc4s
         NQgWUgCD7LYZtfXLHRNSYFX0t1CwxjZDKAVByovvK++jQyKp6OeYI2BK4C74DcnQKFL0
         EXuMq5o1Mczm9MQ2BcpGUPrV8DIM6pMSeS2mNK7ddkd/4lEFMWzY3knITkIb6X2CvN74
         yqDoxbLZr1g8UY+1jG9J/kvVCek6VfAzy2hFH8S4K0s2Xtd6bXQi+XZpNiDlKNssaVL0
         9Bqw==
X-Gm-Message-State: AOAM5325ONrw0cQe4hBhfDAxd33BW6pdfFTeVYjMxqtJp7NpLe8HOiZm
        ZVKrflm278BMilr1eL7nRld9PLOh55otOZtL
X-Google-Smtp-Source: ABdhPJz3/OZOyp/t3SBNk/Xl3q0rAGlb80cj8tSYGJBFmQzfC5TgSgbinL39KJCiZM+8ebj7fwvHwA==
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr13400834wmh.9.1616363217170;
        Sun, 21 Mar 2021 14:46:57 -0700 (PDT)
Received: from localhost.localdomain ([46.109.162.86])
        by smtp.gmail.com with ESMTPSA id p12sm17651849wrx.28.2021.03.21.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 14:46:56 -0700 (PDT)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, ce3g8jdj@umail.furryterror.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] btrfs: Allow read-only mount with corrupted extent tree
Date:   Sun, 21 Mar 2021 23:49:39 +0200
Message-Id: <20210321214939.6984-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317012054.238334-1-davispuh@gmail.com>
References: <20210317012054.238334-1-davispuh@gmail.com>
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
 fs/btrfs/block-group.c | 20 ++++++++++++++++++++
 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/disk-io.h     |  2 ++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 48ebc106a606..f485cf14c2f8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2048,6 +2048,26 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	ret = check_chunk_block_group_mappings(info);
 error:
 	btrfs_free_path(path);
+
+	if (ret == -EIO && btrfs_test_opt(info, IGNOREBADROOTS)) {
+
+		if (btrfs_super_log_root(info->super_copy) != 0) {
+			btrfs_warn(info, "Ignoring tree-log replay due to extent tree corruption!");
+			btrfs_set_super_log_root(info->super_copy, 0);
+		}
+
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

