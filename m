Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C6C3E995C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 22:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhHKUIC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 16:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKUIC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 16:08:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189F3C061765;
        Wed, 11 Aug 2021 13:07:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c24so8272362lfi.11;
        Wed, 11 Aug 2021 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6x/Ii2bZE05v6ZuwKQcPDMHG6HP7Qj7fPV8rl2juls0=;
        b=LkdVKZdciMSClp8si2q44wywjxt8r3IN6TppA4H2TIPu+0+91MXgkz7z1e2+cYx5bI
         FFl24k22TB9SAb1U6LpW3yIVJMqKxbb+iuhqE0nuiyu34CH/K+GttoXzqCcEItavH5Es
         onq/90eG/hFmvZr+r3t0FtWJEQmNb4ojZxADmVa2jb3HNeklXwxjMFJ1E1dK0TbVBQSI
         p8wOruNV8Cik61hmh2G77K9c0671XGyJaRyHTrmF9QuoyEG6l1xhGQU38I0tekpQIHZF
         7b5EArW/vmqy67abzu1C8OKde7KDB6QUiDyCnNx+uLPq0NJT3YsZ1TBBj+Pl+HY2uZn5
         4KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6x/Ii2bZE05v6ZuwKQcPDMHG6HP7Qj7fPV8rl2juls0=;
        b=YGJCJl77edHkEji32purXXXhxCCNwM9hXmS33Dh+EknO57S8dIAfQE6Fm/+NXOgITA
         1cHd31OBahmMSJ1Jnz2SCHzB6UH1QGMWFHh9wbwi+OcZEHoM1JMvHvUInidNA0p61vLZ
         BTeyh4ZfmFDWzIHYKI9aB7o4QF3CgQvvF7gG39B4OucR63fcvoAOg+4BWYDKq4P8a5rg
         iQh3lueZ+2VvoM4wcIsSkuqnv8ZO/spPQCAJpsEpJQriwDfhMExBFL2tnYLy5Dunr9jl
         XyKfCrcVY15XEaHuZH7gimJmuiGvQKTLP8X8RcMoi/zWudMjmgY/E5gjgdfT2EorZdOb
         w9IA==
X-Gm-Message-State: AOAM532klzV8WvmEdHD3mCfPix6Bh2YTyhf2G84uFVn89vwfWKoNu+FJ
        HbzY1orZbaXpt1AOYWgsIPkxc5O69c52KvS3S9U=
X-Google-Smtp-Source: ABdhPJy2RDrh2NEyZNAkYxs6FdawzbOZTa+AN1/da3WGSDF8im1sQA9aDuHZYtgmT0LRESl9xE9jAQ==
X-Received: by 2002:a05:6512:3f90:: with SMTP id x16mr374331lfa.518.1628712456173;
        Wed, 11 Aug 2021 13:07:36 -0700 (PDT)
Received: from localhost.localdomain ([46.109.162.86])
        by smtp.gmail.com with ESMTPSA id u9sm32038lfc.278.2021.08.11.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:07:35 -0700 (PDT)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] btrfs: Allow read-only mount with corrupted extent tree
Date:   Wed, 11 Aug 2021 23:07:17 +0300
Message-Id: <20210811200717.48344-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.32.0
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
index 9e7d9d0c763d..80b9bb9afb8c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2212,6 +2212,26 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
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
index a59ab7b9aea0..b1ad9c85d578 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2115,7 +2115,7 @@ static int read_backup_root(struct btrfs_fs_info *fs_info, u8 priority)
 }
 
 /* helper to cleanup workers */
-static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
+void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 {
 	btrfs_destroy_workqueue(fs_info->fixup_workers);
 	btrfs_destroy_workqueue(fs_info->delalloc_workers);
@@ -2283,7 +2283,7 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->qgroup_rescan_lock);
 }
 
-static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
+int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 		struct btrfs_fs_devices *fs_devices)
 {
 	u32 max_active = fs_info->thread_pool_size;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 0e7e9526b6a8..41348c8d3f9a 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -139,6 +139,8 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid);
 int btrfs_init_root_free_objectid(struct btrfs_root *root);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
+void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info);
+int btrfs_init_workqueues(struct btrfs_fs_info *fs_info, struct btrfs_fs_devices *fs_devices);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void btrfs_set_buffer_lockdep_class(u64 objectid,
-- 
2.32.0

