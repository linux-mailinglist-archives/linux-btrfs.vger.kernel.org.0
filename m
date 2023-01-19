Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6FE673D52
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 16:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjASPTl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 10:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjASPTe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 10:19:34 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC48298E
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 07:19:32 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7254F68D08; Thu, 19 Jan 2023 16:19:29 +0100 (CET)
Date:   Thu, 19 Jan 2023 16:19:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     linux-btrfs@vger.kernel.org
Subject: new lockdep warning about registering a non-static key
Message-ID: <20230119151929.GA29005@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

xfstests btrfs/168 on current misc-next:

btrfs/168 1s ... [   32.860171] run fstests btrfs/168 at 2023-01-19 15:18:17
[   33.224255] BTRFS info (device vdb): using crc32c (crc32c-intel) checksum
alm
[   33.224835] BTRFS info (device vdb): using free space tree
[   33.229739] BTRFS info (device vdb): auto enabling async discard
[   33.442266] BTRFS: device fsid 62b088c0-2f9a-490e-a6d8-e661c167c616 devid 1
)
)[   33.489483] BTRFS info (device vdc): using crc32c (crc32c-intel) checksum
)alm
)[   33.490135] BTRFS info (device vdc): using free space tree
)[   33.494829] BTRFS info (device vdc): auto enabling async discard
)[   33.495469] BTRFS info (device vdc): checking UUID tree
)[   33.566003] INFO: trying to register non-static key.
)[   33.566400] The code is fine but needs lockdep annotation, or maybe
)[   33.566813] you didn't initialize this object before use?
)[   33.567172] turning off the locking correctness validator.
)[   33.567527] CPU: 0 PID: 7480 Comm: btrfs Not tainted 6.2.0-rc4+ #331
)[   33.567930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
)rel-4
)[   33.568665] Call Trace:
)[   33.568830]  <TASK>
)[   33.568996]  dump_stack_lvl+0x5b/0x73
)[   33.569256]  register_lock_class+0x48d/0x4a0
)[   33.569541]  ? __kmem_cache_alloc_node+0x28c/0x340
)[   33.569854]  ? kmalloc_trace+0x21/0x50
)[   33.569871]  ? btrfs_lru_cache_store+0x3e/0x1c0
)[   33.569871]  ? cache_dir_utimes+0xac/0xe0
)[   33.569871]  ? finish_inode_if_needed+0x14d1/0x17c0
)[   33.569871]  ? changed_cb+0x1c1/0xbd0
)[   33.569871]  ? btrfs_ioctl_send+0x1d6e/0x2080
)[   33.569871]  ? _btrfs_ioctl_send+0xd9/0x120
)[   33.569871]  __lock_acquire+0x6d/0x1ef0
)[   33.569871]  lock_acquire+0xd2/0x2e0
)[   33.569871]  ? mtree_insert_range+0x86/0x170
)[   33.569871]  ? btrfs_lru_cache_store+0x3e/0x1c0
)[   33.569871]  _raw_spin_lock+0x2a/0x40
)[   33.569871]  ? mtree_insert_range+0x86/0x170
)[   33.569871]  mtree_insert_range+0x86/0x170
)[   33.569871]  btrfs_lru_cache_store+0x5f/0x1c0
)[   33.569871]  cache_dir_utimes+0xac/0xe0
)[   33.569871]  finish_inode_if_needed+0x14d1/0x17c0
)[   33.569871]  ? lock_is_held_type+0xe3/0x140
)[   33.569871]  ? find_held_lock+0x2b/0x80
)[   33.569871]  changed_cb+0x1c1/0xbd0
)[   33.569871]  ? lock_is_held_type+0xe3/0x140
)[   33.569871]  ? find_held_lock+0x2b/0x80
)[   33.569871]  ? lock_release+0x145/0x2f0
)[   33.569871]  ? read_extent_buffer+0x92/0xb0
)[   33.569871]  btrfs_ioctl_send+0x1d6e/0x2080
)[   33.569871]  ? _btrfs_ioctl_send+0xf3/0x120
)[   33.569871]  ? rcu_read_lock_sched_held+0x36/0x70
)[   33.569871]  _btrfs_ioctl_send+0xd9/0x120
)[   33.569871]  ? __lock_acquire+0x397/0x1ef0
)[   33.569871]  btrfs_ioctl+0x11c1/0x3230
)[   33.569871]  ? lock_is_held_type+0xe3/0x140
)[   33.569871]  ? find_held_lock+0x2b/0x80
)[   33.569871]  ? lock_release+0x145/0x2f0
)[   33.569871]  __x64_sys_ioctl+0x80/0xb0
)[   33.569871]  do_syscall_64+0x34/0x80
)
