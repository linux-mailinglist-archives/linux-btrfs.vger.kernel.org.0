Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E533E7A72B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 08:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjITGSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 02:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITGSu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 02:18:50 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D189D;
        Tue, 19 Sep 2023 23:18:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id E7DBB60157;
        Wed, 20 Sep 2023 08:18:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695190718; bh=LHuGey4TTsCHQfhZeL2CAsAnbsLEBdvwK2SjAiHcwIE=;
        h=Date:From:Subject:To:Cc:From;
        b=DLbJ+0RUaTILV9c8RqT1F2T8y/0BQF243H2IA5bmO27MeKuJBM4NgD9U9sMGYkUfQ
         y3yrP5DKzm29Z+Sn6Kubwb3bOJO7nhgpdyRs5P4v2MPnrchvIr3gdmmqo0k08gQNHP
         hVO/+kKqkggk/8R29f9q0J9uWRUS6PFsGZ0YVTZdV0O1JOQYIfK94u2Mc2LiSEPpUO
         oTGCk9eDwjJVgTuAbhnLyqPG5TvWru+bqSPntzAzCb+P0HsnMY7x8h1h4PCWu+tasn
         CM1HT1UDsRQBeA2+vWXmhqSHQhgNSZlGvZArBJI4kEWPDE8JyLZIpwyIIoSNcfasuH
         mfwNQ3N7x5oTQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nkcAFhpHWtSl; Wed, 20 Sep 2023 08:18:36 +0200 (CEST)
Received: from [192.168.1.6] (78-2-200-2.adsl.net.t-com.hr [78.2.200.2])
        by domac.alu.hr (Postfix) with ESMTPSA id AC60460152;
        Wed, 20 Sep 2023 08:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695190715; bh=LHuGey4TTsCHQfhZeL2CAsAnbsLEBdvwK2SjAiHcwIE=;
        h=Date:From:Subject:To:Cc:From;
        b=wmjacRb9nZ05EdDCqFterWlfuKQIyta8edvfJpzJA06U9Y6NpPklJFADAfk9s5G5A
         n0TIgreoAPwAKuW0pHvfQDGDO+soIjJnBxCPPCjCv6T9lQmne5OeNSn3Nlen1LVstx
         7tO8AAGIiFdZmwG8D6huCWFoqdzkfaNhB+0MAM5577+SrtPPWpasS0wfvwp/Owx11g
         o8jBf1TgHttD/yjFb6hvyHRJu4jWAA8xaTReRsXUxwl7OCe79xI3GtPZ1S2rctxPqq
         F14/YqmKsJt/dSNuIAFZ5bDdfdTIFtVN1ZQtZiMq++ewPt8NmhWmtHa2yThS9T4mWs
         WWmph5Sm+y/vw==
Message-ID: <c9e4e480-6f52-949b-e4b6-3eb0fcda3f83@alu.unizg.hr>
Date:   Wed, 20 Sep 2023 08:18:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: BUG: KCSAN: data-race in btrfs_calculate_inode_block_rsv_size [btrfs]
 / btrfs_use_block_rsv [btrfs] [EXPERIMENTAL PATCH]
To:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

This is your friendly bug reporter again.

Please don't throw stuff at me, as I found another KCSAN data-race problem.

I feel like a boy who cried wolf ...

I hope this will get some attention, as it looks this time like a real btrfs problem that could cause
the kernel module to make a wrong turn when managing storage in different threads simultaneously and
lead to the corruption of data. However, I do not have an example of this corruption, it is by now only
theoretical in this otherwise great filesystem.

In fact, I can announce quite a number of KCSAN bugs already in dmesg log:

    # of
occuren
     ces problematic function
-------------------------------------------
     182 __bitmap_and+0xa3/0x110
       2 __bitmap_weight+0x62/0xa0
     138 __call_rcu_common.constprop.0
       3 __cgroup_account_cputime
       1 __dentry_kill
       3 __mod_lruvec_page_state
      15 __percpu_counter_compare
       1 __percpu_counter_sum+0x8f/0x120
       1 acpi_ut_acquire_mutex
       2 amdgpu_fence_emit
       1 btrfs_calculate_inode_block_rsv_size
       1 btrfs_page_set_uptodate
      28 copy_from_read_buf
       3 d_add
       3 d_splice_alias
       1 delayacct_add_tsk+0x10d/0x630
       7 do_epoll_ctl
       1 do_vmi_align_munmap
      86 drm_sched_entity_is_ready
       4 drm_sched_entity_pop_job
       3 enqueue_timer
       1 finish_fault+0xde/0x360
       2 generic_fillattr
       2 getrusage
       9 getrusage+0x3ba/0xaa0
       1 getrusage+0x3df/0xaa0
       6 inode_needs_update_time
       1 inode_set_ctime_current
       1 inode_update_timestamps
       3 kernfs_refresh_inode
      22 ktime_get_mono_fast_ns+0x87/0x120
      13 ktime_get_mono_fast_ns+0xb0/0x120
      24 ktime_get_mono_fast_ns+0xc0/0x120
      79 mas_topiary_replace
      12 mas_wr_modify
      61 mas_wr_node_store
       1 memchr_inv+0x71/0x160
       1 memchr_inv+0xcf/0x160
      19 n_tty_check_unthrottle
       5 n_tty_kick_worker
      35 n_tty_poll
      32 n_tty_read
       1 n_tty_read+0x5f8/0xaf0
       3 osq_lock
      27 process_one_work
       4 process_one_work+0x169/0x700
       2 rcu_implicit_dynticks_qs
       1 show_stat+0x45b/0xb70
       3 task_mem
     344 tick_nohz_idle_stop_tick
      32 tick_nohz_next_event
       1 tick_nohz_next_event+0xe7/0x1e0
      90 tick_sched_do_timer
       5 tick_sched_do_timer+0x2c/0x120
       1 wbt_done
       1 wbt_issue
       2 wq_worker_tick
      37 xas_clear_mark

------------------------------------------------------

This report is from a vanilla torvalds tree 6.6-rc2 kernel on Ubuntu 22.04:

[13429.116126] ==================================================================
[13429.116794] BUG: KCSAN: data-race in btrfs_calculate_inode_block_rsv_size [btrfs] / btrfs_use_block_rsv [btrfs]

[13429.118113] write to 0xffff8884c38043f8 of 8 bytes by task 25471 on cpu 30:
[13429.118124] btrfs_calculate_inode_block_rsv_size (/home/marvin/linux/kernel/torvalds2/fs/btrfs/delalloc-space.c:276) btrfs
[13429.118819] btrfs_delalloc_release_metadata (/home/marvin/linux/kernel/torvalds2/./include/linux/spinlock.h:391 /home/marvin/linux/kernel/torvalds2/fs/btrfs/delalloc-space.c:400) btrfs
[13429.119479] btrfs_remove_ordered_extent (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ordered-data.c:606) btrfs
[13429.120135] btrfs_finish_one_ordered (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3221) btrfs
[13429.120789] btrfs_finish_ordered_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3234) btrfs
[13429.121439] finish_ordered_fn (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ordered-data.c:304) btrfs
[13429.122095] btrfs_work_helper (/home/marvin/linux/kernel/torvalds2/fs/btrfs/async-thread.c:314) btrfs
[13429.122781] process_one_work (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2630)
[13429.122794] worker_thread (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2697 /home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2784)
[13429.122804] kthread (/home/marvin/linux/kernel/torvalds2/kernel/kthread.c:388)
[13429.122813] ret_from_fork (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/process.c:147)
[13429.122825] ret_from_fork_asm (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:312)

[13429.122842] read to 0xffff8884c38043f8 of 8 bytes by task 25472 on cpu 25:
[13429.122853] btrfs_use_block_rsv (/home/marvin/linux/kernel/torvalds2/fs/btrfs/block-rsv.c:496) btrfs
[13429.123513] btrfs_alloc_tree_block (/home/marvin/linux/kernel/torvalds2/fs/btrfs/extent-tree.c:4925) btrfs
[13429.124162] __btrfs_cow_block (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ctree.c:546) btrfs
[13429.124806] btrfs_cow_block (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ctree.c:712) btrfs
[13429.125452] btrfs_search_slot (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ctree.c:2194) btrfs
[13429.126094] btrfs_lookup_file_extent (/home/marvin/linux/kernel/torvalds2/fs/btrfs/file-item.c:271) btrfs
[13429.126742] btrfs_drop_extents (/home/marvin/linux/kernel/torvalds2/fs/btrfs/file.c:250) btrfs
[13429.127392] insert_reserved_file_extent (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:2900) btrfs
[13429.128040] btrfs_finish_one_ordered (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3111) btrfs
[13429.128689] btrfs_finish_ordered_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3234) btrfs
[13429.129338] finish_ordered_fn (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ordered-data.c:304) btrfs
[13429.129992] btrfs_work_helper (/home/marvin/linux/kernel/torvalds2/fs/btrfs/async-thread.c:314) btrfs
[13429.130648] process_one_work (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2630)
[13429.130659] worker_thread (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2697 /home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2784)
[13429.130670] kthread (/home/marvin/linux/kernel/torvalds2/kernel/kthread.c:388)
[13429.130678] ret_from_fork (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/process.c:147)
[13429.130689] ret_from_fork_asm (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:312)

[13429.130704] value changed: 0x0000000000760000 -> 0x0000000000720000

[13429.130718] Reported by Kernel Concurrency Sanitizer on:
[13429.130727] CPU: 25 PID: 25472 Comm: kworker/u66:3 Tainted: G             L     6.6.0-rc2-kcsan-00003-g16819584c239-dirty #22
[13429.130739] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[13429.130747] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[13429.131404] ==================================================================

The code is:

fs/btrfs/delalloc-space.c
---------------------------------------------------------------------------------
   242 static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
   243                                                  struct btrfs_inode *inode)
   244 {
   245         struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
   246         u64 reserve_size = 0;
   247         u64 qgroup_rsv_size = 0;
   248         u64 csum_leaves;
   249         unsigned outstanding_extents;
   250
   251         lockdep_assert_held(&inode->lock);
   252         outstanding_extents = inode->outstanding_extents;
   253
   254         /*
   255          * Insert size for the number of outstanding extents, 1 normal size for
   256          * updating the inode.
   257          */
   258         if (outstanding_extents) {
   259                 reserve_size = btrfs_calc_insert_metadata_size(fs_info,
   260                                                 outstanding_extents);
   261                 reserve_size += btrfs_calc_metadata_size(fs_info, 1);
   262         }
   263         csum_leaves = btrfs_csum_bytes_to_leaves(fs_info,
   264                                                  inode->csum_bytes);
   265         reserve_size += btrfs_calc_insert_metadata_size(fs_info,
   266                                                         csum_leaves);
   267         /*
   268          * For qgroup rsv, the calculation is very simple:
   269          * account one nodesize for each outstanding extent
   270          *
   271          * This is overestimating in most cases.
   272          */
   273         qgroup_rsv_size = (u64)outstanding_extents * fs_info->nodesize;
   274
   275         spin_lock(&block_rsv->lock);
→ 276         block_rsv->size = reserve_size;
   277         block_rsv->qgroup_rsv_size = qgroup_rsv_size;
   278         spin_unlock(&block_rsv->lock);
   279 }

fs/btrfs/block-rsv.c
-------------------------------------------------------------------------------
   477 struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
   478                                             struct btrfs_root *root,
   479                                             u32 blocksize)
   480 {
   481         struct btrfs_fs_info *fs_info = root->fs_info;
   482         struct btrfs_block_rsv *block_rsv;
   483         struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
   484         int ret;
   485         bool global_updated = false;
   486
   487         block_rsv = get_block_rsv(trans, root);
   488
   489         if (unlikely(block_rsv->size == 0))
   490                 goto try_reserve;
   491 again:
   492         ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
   493         if (!ret)
   494                 return block_rsv;
   495
→ 496         if (block_rsv->failfast)
   497                 return ERR_PTR(ret);
   498
   499         if (block_rsv->type == BTRFS_BLOCK_RSV_GLOBAL && !global_updated) {
   500                 global_updated = true;
   501                 btrfs_update_global_block_rsv(fs_info);
   502                 goto again;
   503         }
   504
   505         /*
   506          * The global reserve still exists to save us from ourselves, so don't
   507          * warn_on if we are short on our delayed refs reserve.
   508          */
   509         if (block_rsv->type != BTRFS_BLOCK_RSV_DELREFS &&
   510             btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
   511                 static DEFINE_RATELIMIT_STATE(_rs,
   512                                 DEFAULT_RATELIMIT_INTERVAL * 10,
   513                                 /*DEFAULT_RATELIMIT_BURST*/ 1);
   514                 if (__ratelimit(&_rs))
   515                         WARN(1, KERN_DEBUG
   516                                 "BTRFS: block rsv %d returned %d\n",
   517                                 block_rsv->type, ret);
   518         }
   519 try_reserve:
   520         ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
   521                                            BTRFS_RESERVE_NO_FLUSH);
   522         if (!ret)
   523                 return block_rsv;
   524         /*
   525          * If we couldn't reserve metadata bytes try and use some from
   526          * the global reserve if its space type is the same as the global
   527          * reservation.
   528          */
   529         if (block_rsv->type != BTRFS_BLOCK_RSV_GLOBAL &&
   530             block_rsv->space_info == global_rsv->space_info) {
   531                 ret = btrfs_block_rsv_use_bytes(global_rsv, blocksize);
   532                 if (!ret)
   533                         return global_rsv;
   534         }
   535
   536         /*
   537          * All hope is lost, but of course our reservations are overly
   538          * pessimistic, so instead of possibly having an ENOSPC abort here, try
   539          * one last time to force a reservation if there's enough actual space
   540          * on disk to make the reservation.
   541          */
   542         ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
   543                                            BTRFS_RESERVE_FLUSH_EMERGENCY);
   544         if (!ret)
   545                 return block_rsv;
   546
   547         return ERR_PTR(ret);
   548 }

Now, see the logical problem: when these two threads are (obviously) executed in parallel,
the write side uses spin_lock(&block_srv) from *inode it changes the reserve_size of,
however it seems that this line 496 of btrfs_use_block_rsv() reads these struct members
without a lock and they can change during the operation.

To illustrate this, an experimental patch is provided:

(NOTE that btrfs_block_rsv_use_bytes() uses spin_lock(&block_rsv->lock), so it had to be
  moved upwards.)

----------------------------------------
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 77684c5e0c8b..8153814c7861 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -166,7 +166,9 @@ int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src,
  {
         int ret;
  
+       spin_lock(&src->lock);
         ret = btrfs_block_rsv_use_bytes(src, num_bytes);
+       spin_unlock(&src->lock);
         if (ret)
                 return ret;
  
@@ -298,14 +300,12 @@ int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv, u64 num_bytes)
  {
         int ret = -ENOSPC;
  
-       spin_lock(&block_rsv->lock);
         if (block_rsv->reserved >= num_bytes) {
                 block_rsv->reserved -= num_bytes;
                 if (block_rsv->reserved < block_rsv->size)
                         block_rsv->full = false;
                 ret = 0;
         }
-       spin_unlock(&block_rsv->lock);
         return ret;
  }
  
@@ -486,15 +486,16 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
  
         block_rsv = get_block_rsv(trans, root);
  
+       spin_lock(&block_rsv->lock);
         if (unlikely(block_rsv->size == 0))
                 goto try_reserve;
  again:
         ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
         if (!ret)
-               return block_rsv;
+               goto exit_ret_block_rsv;
  
         if (block_rsv->failfast)
-               return ERR_PTR(ret);
+               goto exit_ret_err;
  
         if (block_rsv->type == BTRFS_BLOCK_RSV_GLOBAL && !global_updated) {
                 global_updated = true;
@@ -520,7 +521,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
         ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
                                            BTRFS_RESERVE_NO_FLUSH);
         if (!ret)
-               return block_rsv;
+               goto exit_ret_block_rsv;
         /*
          * If we couldn't reserve metadata bytes try and use some from
          * the global reserve if its space type is the same as the global
@@ -530,7 +531,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
             block_rsv->space_info == global_rsv->space_info) {
                 ret = btrfs_block_rsv_use_bytes(global_rsv, blocksize);
                 if (!ret)
-                       return global_rsv;
+                       goto exit_ret_global_rsv;
         }
  
         /*
@@ -542,9 +543,20 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
         ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
                                            BTRFS_RESERVE_FLUSH_EMERGENCY);
         if (!ret)
-               return block_rsv;
+               goto exit_ret_block_rsv;
  
+exit_ret_err:
+       spin_unlock(&block_rsv->lock);
         return ERR_PTR(ret);
+
+exit_ret_block_rsv:
+       spin_unlock(&block_rsv->lock);
+       return block_rsv;
+
+exit_ret_global_rsv:
+       spin_unlock(&block_rsv->lock);
+       return global_rsv;
+
  }
  
  int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
---

This is of course just a symptomatic patch, but since btrfs_block_rsv_use_bytes() is not used outside
of fs/btrfs/block-rsv.c,it could just work as PoC.

OTOH, this version might be more elegant:

----------------------------------------------------------------------
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 77684c5e0c8b..192be99cc6f4 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -294,18 +294,28 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
                                        qgroup_to_release);
  }
  
-int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv, u64 num_bytes)
+static
+int __btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv, u64 num_bytes)
  {
         int ret = -ENOSPC;
  
-       spin_lock(&block_rsv->lock);
         if (block_rsv->reserved >= num_bytes) {
                 block_rsv->reserved -= num_bytes;
                 if (block_rsv->reserved < block_rsv->size)
                         block_rsv->full = false;
                 ret = 0;
         }
+       return ret;
+}
+
+int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv, u64 num_bytes)
+{
+       int ret;
+
+       spin_lock(&block_rsv->lock);
+       ret = __btrfs_block_rsv_use_bytes(block_rsv, num_bytes);
         spin_unlock(&block_rsv->lock);
+
         return ret;
  }
  
@@ -486,15 +496,16 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
  
         block_rsv = get_block_rsv(trans, root);
  
+       spin_lock(&block_rsv->lock);
         if (unlikely(block_rsv->size == 0))
                 goto try_reserve;
  again:
-       ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
+       ret = __btrfs_block_rsv_use_bytes(block_rsv, blocksize);
         if (!ret)
-               return block_rsv;
+               goto exit_ret_block_rsv;
  
         if (block_rsv->failfast)
-               return ERR_PTR(ret);
+               goto exit_ret_err;
  
         if (block_rsv->type == BTRFS_BLOCK_RSV_GLOBAL && !global_updated) {
                 global_updated = true;
@@ -520,7 +531,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
         ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
                                            BTRFS_RESERVE_NO_FLUSH);
         if (!ret)
-               return block_rsv;
+               goto exit_ret_block_rsv;
         /*
          * If we couldn't reserve metadata bytes try and use some from
          * the global reserve if its space type is the same as the global
@@ -528,9 +539,9 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
          */
         if (block_rsv->type != BTRFS_BLOCK_RSV_GLOBAL &&
             block_rsv->space_info == global_rsv->space_info) {
-               ret = btrfs_block_rsv_use_bytes(global_rsv, blocksize);
+               ret = __btrfs_block_rsv_use_bytes(global_rsv, blocksize);
                 if (!ret)
-                       return global_rsv;
+                       goto exit_ret_global_rsv;
         }
  
         /*
@@ -542,9 +553,20 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
         ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
                                            BTRFS_RESERVE_FLUSH_EMERGENCY);
         if (!ret)
-               return block_rsv;
+               goto exit_ret_block_rsv;
  
+exit_ret_err:
+       spin_unlock(&block_rsv->lock);
         return ERR_PTR(ret);
+
+exit_ret_block_rsv:
+       spin_unlock(&block_rsv->lock);
+       return block_rsv;
+
+exit_ret_global_rsv:
+       spin_unlock(&block_rsv->lock);
+       return global_rsv;
+
  }
  
  int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
---

Of course, I did not run these patches on a production system, I just verified that they build.

Best regards,
Mirsad Todorovac
