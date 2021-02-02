Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41030B73D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 06:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBBFjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 00:39:33 -0500
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:39326 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhBBFjb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 00:39:31 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436284|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00730966-0.000369831-0.992321;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JTun0rY_1612244317;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JTun0rY_1612244317)
          by smtp.aliyun-inc.com(10.147.40.233);
          Tue, 02 Feb 2021 13:38:37 +0800
Date:   Tue, 02 Feb 2021 13:38:39 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org
Subject: Re: [PATCH 6/6] btrfs: do not block inode logging for so long during transaction commit
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <d9df3c01bd2fbfeddfe205fa229ecea2d7478711.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com> <d9df3c01bd2fbfeddfe205fa229ecea2d7478711.1606305501.git.fdmanana@suse.com>
Message-Id: <20210202133838.1639.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Filipe Manana

The dbench result with these patches is very good. thanks a lot. 

This is the dbench(synchronous mode) result , and then a question.

command: dbench -s -t 60 -D /btrfs/ 32
mount option:ssd,space_cache=v2
kernel:5.10.12 + patchset 1 + this patchset
patchset 1:
0001-btrfs-fix-race-causing-unnecessary-inode-logging-dur.patch
0002-btrfs-fix-race-that-results-in-logging-old-extents-d.patch
0003-btrfs-fix-race-that-causes-unnecessary-logging-of-an.patch
0004-btrfs-fix-race-that-makes-inode-logging-fallback-to-.patch
0005-btrfs-fix-race-leading-to-unnecessary-transaction-co.patch
0006-btrfs-do-not-block-inode-logging-for-so-long-during-.patch

We get two types of result as below, and the result type 1 is not easy
to reproduce now.

Question:
for synchronous mode, the result type 1 is perfect?
and there is still some minor place about the flush to do for
the result type2?


result type 1:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX     868942     0.028     3.017
 Close         638536     0.003     0.061
 Rename         36851     0.663     4.000
 Unlink        175182     0.399     5.358
 Qpathinfo     789014     0.014     1.846
 Qfileinfo     137684     0.002     0.047
 Qfsinfo       144241     0.004     0.059
 Sfileinfo      70913     0.008     0.046
 Find          304554     0.057     1.889
** WriteX        429696     3.960  2239.973
 ReadX        1363356     0.005     0.358
 LockX           2836     0.004     0.038
 UnlockX         2836     0.002     0.018
** Flush          60771     0.621     6.794

Throughput 452.385 MB/sec (sync open)  32 clients  32 procs  max_latency=1963.312 ms
+ stat -f -c %T /btrfs/
btrfs
+ uname -r
5.10.12-4.el7.x86_64


result type 2:
 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX     888943     0.028     2.679
 Close         652765     0.002     0.058
 Rename         37705     0.572     3.962
 Unlink        179713     0.383     3.983
 Qpathinfo     806705     0.014     2.294
 Qfileinfo     140752     0.002     0.125
 Qfsinfo       147909     0.004     0.049
 Sfileinfo      72374     0.008     0.104
 Find          311839     0.058     2.305
** WriteX        439656     3.854  1872.109
 ReadX        1396868     0.005     0.324
 LockX           2910     0.004     0.026
 UnlockX         2910     0.002     0.025
** Flush          62260     0.750  1659.364

Throughput 461.856 MB/sec (sync open)  32 clients  32 procs  max_latency=1872.118 ms
+ stat -f -c %T /btrfs/
btrfs
+ uname -r
5.10.12-4.el7.x86_64



Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/02

> From: Filipe Manana <fdmanana@suse.com>
> 
> Early on during a transaction commit we acquire the tree_log_mutex and
> hold it until after we write the super blocks. But before writing the
> extent buffers dirtied by the transaction and the super blocks we unblock
> the transaction by setting its state to TRANS_STATE_UNBLOCKED and setting
> fs_info->running_transaction to NULL.
> 
> This means that after that and before writing the super blocks, new
> transactions can start. However if any transaction wants to log an inode,
> it will block waiting for the transaction commit to write its dirty
> extent buffers and the super blocks because the tree_log_mutex is only
> released after those operations are complete, and starting a new log
> transaction blocks on that mutex (at start_log_trans()).
> 
> Writing the dirty extent buffers and the super blocks can take a very
> significant amount of time to complete, but we could allow the tasks
> wanting to log an inode to proceed with most of their steps:
> 
> 1) create the log trees
> 2) log metadata in the trees
> 3) write their dirty extent buffers
> 
> They only need to wait for the previous transaction commit to complete
> (write its super blocks) before they attempt to write their super blocks,
> otherwise we could end up with a corrupt filesystem after a crash
> 
> So change start_log_trans() to use the root tree's log_mutex to serialize
> for the creation of the log root tree instead of using the tree_log_mutex,
> and make btrfs_sync_log() acquire the tree_log_mutex before writing the
> super blocks. This allows for inode logging to wait much less time when
> there is a previous transaction that is still committing, often not having
> to wait at all, as by the time when we try to sync the log the previous
> transaction already wrote its super blocks.
> 
> This patch belongs to a patch set that is comprised of the following
> patches:
> 
>   btrfs: fix race causing unnecessary inode logging during link and rename
>   btrfs: fix race that results in logging old extents during a fast fsync
>   btrfs: fix race that causes unnecessary logging of ancestor inodes
>   btrfs: fix race that makes inode logging fallback to transaction commit
>   btrfs: fix race leading to unnecessary transaction commit when logging inode
>   btrfs: do not block inode logging for so long during transaction commit
> 
> The following script that uses dbench was used to measure the impact of
> the whole patchset:
> 
>   $ cat test-dbench.sh
>   #!/bin/bash
> 
>   DEV=/dev/nvme0n1
>   MNT=/mnt/btrfs
>   MOUNT_OPTIONS="-o ssd"
> 
>   echo "performance" | \
>       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> 
>   mkfs.btrfs -f -m single -d single $DEV
>   mount $MOUNT_OPTIONS $DEV $MNT
> 
>   dbench -D $MNT -t 300 64
> 
>   umount $MNT
> 
> The test was run on a machine with 12 cores, 64G of ram, using a NVMe
> device and a non-debug kernel configuration (Debian's default).
> 
> Before patch set:
> 
>  Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  NTCreateX    11277211    0.250    85.340
>  Close        8283172     0.002     6.479
>  Rename        477515     1.935    86.026
>  Unlink       2277936     0.770    87.071
>  Deltree          256    15.732    81.379
>  Mkdir            128     0.003     0.009
>  Qpathinfo    10221180    0.056    44.404
>  Qfileinfo    1789967     0.002     4.066
>  Qfsinfo      1874399     0.003     9.176
>  Sfileinfo     918589     0.061    10.247
>  Find         3951758     0.341    54.040
>  WriteX       5616547     0.047    85.079
>  ReadX        17676028    0.005     9.704
>  LockX          36704     0.003     1.800
>  UnlockX        36704     0.002     0.687
>  Flush         790541    14.115   676.236
> 
> Throughput 1179.19 MB/sec  64 clients  64 procs  max_latency=676.240 ms
> 
> After patch set:
> 
> Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  NTCreateX    12687926    0.171    86.526
>  Close        9320780     0.002     8.063
>  Rename        537253     1.444    78.576
>  Unlink       2561827     0.559    87.228
>  Deltree          374    11.499    73.549
>  Mkdir            187     0.003     0.005
>  Qpathinfo    11500300    0.061    36.801
>  Qfileinfo    2017118     0.002     7.189
>  Qfsinfo      2108641     0.003     4.825
>  Sfileinfo    1033574     0.008     8.065
>  Find         4446553     0.408    47.835
>  WriteX       6335667     0.045    84.388
>  ReadX        19887312    0.003     9.215
>  LockX          41312     0.003     1.394
>  UnlockX        41312     0.002     1.425
>  Flush         889233    13.014   623.259
> 
> Throughput 1339.32 MB/sec  64 clients  64 procs  max_latency=623.265 ms
> 
> +12.7% throughput, -8.2% max latency
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ctree.h    |  2 +-
>  fs/btrfs/tree-log.c | 56 +++++++++++++++++++++++++++++++--------------
>  2 files changed, 40 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index c0c6e79c43f9..7185384f475a 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1026,7 +1026,7 @@ enum {
>  	BTRFS_ROOT_DEAD_RELOC_TREE,
>  	/* Mark dead root stored on device whose cleanup needs to be resumed */
>  	BTRFS_ROOT_DEAD_TREE,
> -	/* The root has a log tree. Used only for subvolume roots. */
> +	/* The root has a log tree. Used for subvolume roots and the tree root. */
>  	BTRFS_ROOT_HAS_LOG_TREE,
>  	/* Qgroup flushing is in progress */
>  	BTRFS_ROOT_QGROUP_FLUSHING,
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index bc5b652f4f64..e8b84543d565 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -139,8 +139,25 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>  			   struct btrfs_log_ctx *ctx)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> +	struct btrfs_root *tree_root = fs_info->tree_root;
>  	int ret = 0;
>  
> +	/*
> +	 * First check if the log root tree was already created. If not, create
> +	 * it before locking the root's log_mutex, just to keep lockdep happy.
> +	 */
> +	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &tree_root->state)) {
> +		mutex_lock(&tree_root->log_mutex);
> +		if (!fs_info->log_root_tree) {
> +			ret = btrfs_init_log_root_tree(trans, fs_info);
> +			if (!ret)
> +				set_bit(BTRFS_ROOT_HAS_LOG_TREE, &tree_root->state);
> +		}
> +		mutex_unlock(&tree_root->log_mutex);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	mutex_lock(&root->log_mutex);
>  
>  	if (root->log_root) {
> @@ -156,13 +173,6 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>  			set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
>  		}
>  	} else {
> -		mutex_lock(&fs_info->tree_log_mutex);
> -		if (!fs_info->log_root_tree)
> -			ret = btrfs_init_log_root_tree(trans, fs_info);
> -		mutex_unlock(&fs_info->tree_log_mutex);
> -		if (ret)
> -			goto out;
> -
>  		ret = btrfs_add_log_tree(trans, root);
>  		if (ret)
>  			goto out;
> @@ -3022,6 +3032,8 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>  	int log_transid = 0;
>  	struct btrfs_log_ctx root_log_ctx;
>  	struct blk_plug plug;
> +	u64 log_root_start;
> +	u64 log_root_level;
>  
>  	mutex_lock(&root->log_mutex);
>  	log_transid = ctx->log_transid;
> @@ -3199,22 +3211,31 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>  		goto out_wake_log_root;
>  	}
>  
> -	btrfs_set_super_log_root(fs_info->super_for_commit,
> -				 log_root_tree->node->start);
> -	btrfs_set_super_log_root_level(fs_info->super_for_commit,
> -				       btrfs_header_level(log_root_tree->node));
> -
> +	log_root_start = log_root_tree->node->start;
> +	log_root_level = btrfs_header_level(log_root_tree->node);
>  	log_root_tree->log_transid++;
>  	mutex_unlock(&log_root_tree->log_mutex);
>  
>  	/*
> -	 * Nobody else is going to jump in and write the ctree
> -	 * super here because the log_commit atomic below is protecting
> -	 * us.  We must be called with a transaction handle pinning
> -	 * the running transaction open, so a full commit can't hop
> -	 * in and cause problems either.
> +	 * Here we are guaranteed that nobody is going to write the superblock
> +	 * for the current transaction before us and that neither we do write
> +	 * our superblock before the previous transaction finishes its commit
> +	 * and writes its superblock, because:
> +	 *
> +	 * 1) We are holding a handle on the current transaction, so no body
> +	 *    can commit it until we release the handle;
> +	 *
> +	 * 2) Before writing our superblock we acquire the tree_log_mutex, so
> +	 *    if the previous transaction is still committing, and hasn't yet
> +	 *    written its superblock, we wait for it to do it, because a
> +	 *    transaction commit acquires the tree_log_mutex when the commit
> +	 *    begins and releases it only after writing its superblock.
>  	 */
> +	mutex_lock(&fs_info->tree_log_mutex);
> +	btrfs_set_super_log_root(fs_info->super_for_commit, log_root_start);
> +	btrfs_set_super_log_root_level(fs_info->super_for_commit, log_root_level);
>  	ret = write_all_supers(fs_info, 1);
> +	mutex_unlock(&fs_info->tree_log_mutex);
>  	if (ret) {
>  		btrfs_set_log_full_commit(trans);
>  		btrfs_abort_transaction(trans, ret);
> @@ -3299,6 +3320,7 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
>  	if (fs_info->log_root_tree) {
>  		free_log_tree(trans, fs_info->log_root_tree);
>  		fs_info->log_root_tree = NULL;
> +		clear_bit(BTRFS_ROOT_HAS_LOG_TREE, &fs_info->tree_root->state);
>  	}
>  	return 0;
>  }
> -- 
> 2.28.0


