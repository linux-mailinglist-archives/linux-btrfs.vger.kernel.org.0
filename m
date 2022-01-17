Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2BE49022F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 07:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiAQG44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 01:56:56 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38464 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiAQG44 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 01:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642402615; x=1673938615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RcMQFNa42T/l9xqme8VqHD45jRFqN+LTcihJ4eJZb4E=;
  b=qL7oHyjGjcRPIhfqNUZi+HnMUbQxedJ+U3Z+EmnXd8kqSCEV2pm0YZbU
   IKyx6hvs8VFU+PsCBBl5j4FyalqRgvCu/FZqRKk7341x4JCXzCncRIN5v
   zUnnc+x5cIXqsAApzRr6GJW73pTzavzIKN//VBsOaaJ88KbO7Ax+iFHZG
   23Ce7UwHriI5Bjc46dawHks08mdNXdqOR9nuOuJVVa+Pyl6cb5u7Mo0DJ
   55uJ/s8L7gsIvRZU8w6yEb7Io7GOkk0sGp/nGCAqcTvhCsXFZJqYehxoq
   VltzXv0IswUTDBCtQ4szjbRSSu12CmpMTPykm/l4S4lByr5WtEgrVzVuR
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,294,1635177600"; 
   d="scan'208";a="302494935"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2022 14:56:55 +0800
IronPort-SDR: 1wvJnzwawv1ryKLy/c9ICg53MRDKIxSyoXz6w9MHDyFzIcgJvY+DsabReA23h+csuCmZr2KYU8
 rzQQTf1ExrtKXl7HGQXHjykgh8TxXXOf5QqhDpJvXaBZapSSR60MB4j28D739dL2yVfIOjjW1D
 BdVbJDji77lHhuXFnCyB2kfgsYe/wT9uhfEUByYFW0BG9EjMh41+9PwxItRus9SpYi2NoTZP07
 HIJvxpCaATmDHUAoUPTdBxZ3UtX5nnn8wHFc7b1PYTlAhpU+FdN8RTdrCQmP+m+vuYIFuPnR43
 80cWt2wUzDA9QRWhimUthftU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 22:29:10 -0800
IronPort-SDR: n/wbqX9d4vw9j8n6wAqbG0dFefT0+DkBDbSRkgPL+kyHKnbbxzsG/pBXqHwHoNRi9giLJBxW6l
 nycqKPjQzMtK7qtxd3GaVd+ChGsa/solk3PbMk+tkmMTJTkiNbM0bp3wCm9x+JyXJiETjWsLFY
 xu0QDjRu5U55u/hh4932DgdJpxClpyNfEUlJWUIABcvSuxE2oQAwJLTeNH8qN2W6UTTbAObr+R
 n2Nkd+yDm4rLdyWD4fEcxWWA+LaZH9QP8TtFz+RRS3Os7ov4lm5qprPVu6f3MuWViS5kGQiig1
 COw=
WDCIronportException: Internal
Received: from jpf010138.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.147])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jan 2022 22:56:54 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: mark relocation as writing
Date:   Mon, 17 Jan 2022 15:56:52 +0900
Message-Id: <e935669f435882ba179812a955bcbb89d964db26.1642401849.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a hung_task issue with running generic/068 on an SMR
device. The hang occurs while a process is trying to thaw the
filesystem. The process is trying to take sb->s_umount to thaw the
FS. The lock is held by fsstress, which calls btrfs_sync_fs() and is
waiting for an ordered extent to finish. However, as the FS is frozen,
the ordered extent never finish.

Having an ordered extent while the FS is frozen is the root cause of
the hang. The ordered extent is initiated from btrfs_relocate_chunk()
which is called from btrfs_reclaim_bgs_work().

This commit add sb_*_write() around btrfs_relocate_chunk() call
site. For the usual "btrfs balance" command, we already call it with
mnt_want_file() in btrfs_ioctl_balance().

Additionally, add an ASSERT in btrfs_relocate_chunk() to check it is
properly called.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
Cc: stable@vger.kernel.org # 5.13+
Link: https://github.com/naota/linux/issues/56
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 3 +++
 fs/btrfs/volumes.c     | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 68feabc83a27..913fee0daafd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1516,11 +1516,13 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
 		return;
 
+	sb_start_write(fs_info->sb);
 	/*
 	 * Long running balances can keep us blocked here for eternity, so
 	 * simply skip reclaim if we're unable to get the mutex.
 	 */
 	if (!mutex_trylock(&fs_info->reclaim_bgs_lock)) {
+		sb_end_write(fs_info->sb);
 		btrfs_exclop_finish(fs_info);
 		return;
 	}
@@ -1595,6 +1597,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
+	sb_end_write(fs_info->sb);
 	btrfs_exclop_finish(fs_info);
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b07d382d53a8..3975511f3201 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3251,6 +3251,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	u64 length;
 	int ret;
 
+	/* Assert we called sb_start_write(), not to race with FS freezing */
+	lockdep_assert_held_read(fs_info->sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1);
+
 	/*
 	 * Prevent races with automatic removal of unused block groups.
 	 * After we relocate and before we remove the chunk with offset
@@ -8306,6 +8309,7 @@ static int relocating_repair_kthread(void *data)
 		return -EBUSY;
 	}
 
+	sb_start_write(fs_info->sb);
 	mutex_lock(&fs_info->reclaim_bgs_lock);
 
 	/* Ensure block group still exists */
@@ -8329,6 +8333,7 @@ static int relocating_repair_kthread(void *data)
 	if (cache)
 		btrfs_put_block_group(cache);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
+	sb_end_write(fs_info->sb);
 	btrfs_exclop_finish(fs_info);
 
 	return ret;
-- 
2.34.1

