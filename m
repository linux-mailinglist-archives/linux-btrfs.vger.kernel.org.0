Return-Path: <linux-btrfs+bounces-15026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1506AEB2BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A0C1884376
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACFF25EFBF;
	Fri, 27 Jun 2025 09:19:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA225FA0E
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015972; cv=none; b=il5Rjc4eUtHjqP++CqOtXjXoOUVWBis3HwkhX18gNyNOdV3nxUgtzZC31mOWeeoduKlWBeY9IKp8+NOQfY29W40OPVrnH1HLPHVB3nkY1w+NMSOk/RH8rjzDQRCNpJKSAvi8gQQYvj3ggKnatOrh6F9tnXESsRoQNsLTDTlhbHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015972; c=relaxed/simple;
	bh=p/7np7V+nARtN7k75exu4ABo1w7MrDksXElCV23P7nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HusUEqC/EFRW1uKDu5IftdlGgeaU+cNVeUGn2cq0K8POrFUn+P4TP1dcsE+D63tnTFMpYXanwOCzy4CmJK3p2t5wnapBc1EJcDaCBeuZ+VMh0cwMQPG57LKem11m+Qgp0QRO3kE/2VOrAuCejktB/n564Xe54P0xNAmYn0NtIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1185414f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015969; x=1751620769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cszw3b0IVPIAAJi38JJlozu3RWXRY8juQLuG/jj2awE=;
        b=N4V66E6Ql2ToMGoXuWtoMVbbXoCH98o9UrM3rux5TcOKeGE9mIy2PI/M4M/aLhsVJY
         1wCU3Hplvh7TUMHVL90i1CzxWM2gEQkat1lR2LjQomFqrD5WNMsd4X+PEmrGR/BE5Dy0
         YaOAL4qZRN7QpP/k2RWuDKzekC/xgcuq+FOI7keHfAE1N/X49wuOm9nMakYwrHGRnORH
         FlRst3mombJjA4ntagZGVPQHJldVTXwindj9ekP/PZVSGg947niTx4ibfB3exyTg5AJW
         fD3D8iFxq+uu+m+XYBKAGwckVmv6lYuYRc0UbVhuAa52olvl0iwyQiL7YpXja5ZBR5xT
         OlAg==
X-Gm-Message-State: AOJu0YymCJqP74UOZw+94TGU204YggzPx8n4yToOATvlxugdmaxkvbGk
	z/tRhfNPq0Lx94iq1cYT/k6FytMKnqJNol+Q7ZIEa32oBhNVGk4E5WyFSWdejg==
X-Gm-Gg: ASbGncsQZ5CXiBbMqfeSIzZ/Sg7nwuex3wpuHIIjdNGoz79fUGlpEPDoZRE/Pn8cfwx
	eAP4tX6mAqiAyYCjrWKIeBGKR2CD5M7kD5P0QpRtcMz/xq1kd94BeXJGzdo0SRgS1+r1dhZ+PTc
	VZyMsB14e/mKZDhfrz4sSMH/7/jLIe6Z8jai8KXRNfbm3CHxK3f3D3rPdewkrwCLCHBSPPA7QCO
	6Uc+R8NmeDN1DwmoZYwTSeXO3I93y3KbgghNIqHfvGGfWc6Z//PsukD1+PdA7z+XHaBttAj4xze
	8JvCaT5r2aA3XlYPcC6QJYZWdoC38wlf2+ixTgX6rt4Wz3g1lu+g4Zyudau1iJac91rDHnY6TZE
	U8A2kpf6HP9utlvwsyHf4gohEegnyWV3gED1hD/NdD2tfy1Ds9UJJGZNseZg=
X-Google-Smtp-Source: AGHT+IH8z1dTF5USA9y8apBD+78fdInQG5S1Cza6PCjt0ZRCODQxEoWgV3ejO9LdsEJDq3Bjb5TdSA==
X-Received: by 2002:a05:6000:1281:b0:3a6:e1bd:6102 with SMTP id ffacd0b85a97d-3a9001a2073mr1858091f8f.49.1751015969055;
        Fri, 27 Jun 2025 02:19:29 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:28 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 5/9] btrfs: remove delalloc_root_mutex
Date: Fri, 27 Jun 2025 11:19:10 +0200
Message-ID: <20250627091914.100715-6-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627091914.100715-1-jth@kernel.org>
References: <20250627091914.100715-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When benchmarking garbage collection on zoned BTRFS filesystems on ZNS
drives, we regularly observe hung_task messages like the following:

INFO: task kworker/u132:2:297 blocked for more than 122 seconds.
       Not tainted 6.16.0-rc1+ #1225
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u132:2  state:D stack:0     pid:297   tgid:297   ppid:2      task_flags:0x4208060 flags:0x00004000
 Workqueue: events_unbound btrfs_preempt_reclaim_metadata_space
 Call Trace:
  <TASK>
  __schedule+0x2f9/0x7b0
  schedule+0x27/0x80
  schedule_preempt_disabled+0x15/0x30
  __mutex_lock.constprop.0+0x4af/0x890
  ? srso_return_thunk+0x5/0x5f
  btrfs_start_delalloc_roots+0x8a/0x290
  ? timerqueue_del+0x2e/0x60
  shrink_delalloc+0x10c/0x2d0
  ? srso_return_thunk+0x5/0x5f
  ? psi_group_change+0x19e/0x460
  ? srso_return_thunk+0x5/0x5f
  ? btrfs_reduce_alloc_profile+0x9a/0x1d0
  flush_space+0x202/0x280
  ? srso_return_thunk+0x5/0x5f
  ? need_preemptive_reclaim+0xaa/0x190
  btrfs_preempt_reclaim_metadata_space+0xe7/0x340
  process_one_work+0x192/0x350
  worker_thread+0x25a/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xfc/0x240
  ? __pfx_kthread+0x10/0x10
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x152/0x180
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 INFO: task kworker/u132:2:297 is blocked on a mutex likely owned by task kworker/u129:0:2359.
 task:kworker/u129:0  state:R  running task     stack:0     pid:2359  tgid:2359  ppid:2

The affected tasks are blocked on 'struct btrfs_fs_info::delalloc_root_mutex',
a global lock that serializes entry into btrfs_start_delalloc_roots().
This lock was introduced in commit 573bfb72f760 ("Btrfs: fix possible
empty list access when flushing the delalloc inodes") but without a
clear justification for its necessity.

However, the condition it was meant to protect against—a possibly empty
list access—is already safely handled by 'list_splice_init()', which
does nothing when the source list is empty.

There are no known concurrency issues in btrfs_start_delalloc_roots()
that require serialization via this mutex. All critical regions are
either covered by per-root locking or operate on safely isolated lists.

Removing the lock eliminates the observed hangs and improves metadata
GC throughput, particularly on systems with high concurrency like
ZNS-based deployments.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 1 -
 fs/btrfs/fs.h      | 1 -
 fs/btrfs/inode.c   | 2 --
 3 files changed, 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 35cd38de7727..929f39886b0e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2795,7 +2795,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
 	mutex_init(&fs_info->reclaim_bgs_lock);
 	mutex_init(&fs_info->reloc_mutex);
-	mutex_init(&fs_info->delalloc_root_mutex);
 	mutex_init(&fs_info->zoned_meta_io_lock);
 	mutex_init(&fs_info->zoned_data_reloc_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index a388af40a251..04ebc976f841 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -606,7 +606,6 @@ struct btrfs_fs_info {
 	 */
 	struct list_head ordered_roots;
 
-	struct mutex delalloc_root_mutex;
 	spinlock_t delalloc_root_lock;
 	/* All fs/file tree roots that have delalloc inodes. */
 	struct list_head delalloc_roots;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 80c72c594b19..d68f4ef61c43 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8766,7 +8766,6 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 	if (BTRFS_FS_ERROR(fs_info))
 		return -EROFS;
 
-	mutex_lock(&fs_info->delalloc_root_mutex);
 	spin_lock(&fs_info->delalloc_root_lock);
 	list_splice_init(&fs_info->delalloc_roots, &splice);
 	while (!list_empty(&splice)) {
@@ -8800,7 +8799,6 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 		list_splice_tail(&splice, &fs_info->delalloc_roots);
 		spin_unlock(&fs_info->delalloc_root_lock);
 	}
-	mutex_unlock(&fs_info->delalloc_root_mutex);
 	return ret;
 }
 
-- 
2.49.0


