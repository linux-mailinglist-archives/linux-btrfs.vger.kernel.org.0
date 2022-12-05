Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53FE642623
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 10:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiLEJwR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 04:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiLEJvk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 04:51:40 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB2DEF2
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 01:51:37 -0800 (PST)
From:   robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1670233896; bh=FZiWfKbxHokXbGAYSTg/VyUnUA/E1Gph5idgH7yvMHY=;
        h=From:To:Cc:Subject:Date;
        b=JhwNgzC7GrZ3tMp5gFXDxQKxdvP0sCaXxLD9OFeCbAMtg6UmKV+sWlwf8p6meUMAs
         /2rDdnksPthEkDd11SPHAkXboSrxWK8buN8yJUj0+5NR4bNyQKWemsTE6YJ4nBMVka
         lxDYHAhjhhP0FqSZF+bpBaF8rUYYACYZodXNoE+8=
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH 0/3] btrfs: fix unexpected -ENOMEM with percpu_counter_init when create snapshot
Date:   Mon,  5 Dec 2022 17:51:19 +0800
Message-Id: <20221205095122.17011-1-robbieko@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

[Issue]
When creating subvolume/snapshot, the transaction may be abort due to -ENOMEM

  WARNING: CPU: 1 PID: 411 at fs/btrfs/transaction.c:1937 create_pending_snapshot+0xe30/0xe70 [btrfs]()
  CPU: 1 PID: 411 Comm: btrfs Tainted: P O 4.4.180+ #42661
  Call Trace:
    create_pending_snapshot+0xe30/0xe70 [btrfs]
    create_pending_snapshots+0x89/0xb0 [btrfs]
    btrfs_commit_transaction+0x469/0xc60 [btrfs]
    btrfs_mksubvol+0x5bd/0x690 [btrfs]
    btrfs_mksnapshot+0x102/0x170 [btrfs]
    btrfs_ioctl_snap_create_transid+0x1ad/0x1c0 [btrfs]
    btrfs_ioctl_snap_create_v2+0x102/0x160 [btrfs]
    btrfs_ioctl+0x2111/0x3130 [btrfs]
    do_vfs_ioctl+0x7ea/0xa80
    SyS_ioctl+0xa1/0xb0
    entry_SYSCALL_64_fastpath+0x1e/0x8e
  ---[ end trace 910c8f86780ca385 ]---
  BTRFS: error (device dm-2) in create_pending_snapshot:1937: errno=-12 Out of memory

[Cause]
During creating a subvolume/snapshot, it is necessary to allocate memory for Initializing fs root.
Therefore, it can only use GFP_NOFS to allocate memory to avoid deadlock issues.
However, atomic allocation is required when processing percpu_counter_init
without GFP_KERNEL due to the unique structure of percpu_counter.
In this situation, allocating memory for initializing fs root may cause
unexpected -ENOMEM when free memory is low and causes btrfs transaction to abort.

[Fix]
We allocate memory at the beginning of creating a subvolume/snapshot.
This way, we can ensure the memory is enough when initializing fs root.
Even -ENOMEM happens at the beginning of creating a subvolume/snapshot,
the transaction won’t abort since it hasn’t started yet.

Robbie Ko (3):
  btrfs: refactor anon_dev with new_fs_root_args for create
    subvolume/snapshot
  btrfs: change snapshot_lock to dynamic pointer
  btrfs: add snapshot_lock to new_fs_root_args

 fs/btrfs/ctree.h       |   2 +-
 fs/btrfs/disk-io.c     | 107 ++++++++++++++++++++++++++++++-----------
 fs/btrfs/disk-io.h     |  12 ++++-
 fs/btrfs/file.c        |   8 +--
 fs/btrfs/inode.c       |  12 ++---
 fs/btrfs/ioctl.c       |  38 +++++++--------
 fs/btrfs/transaction.c |   2 +-
 fs/btrfs/transaction.h |   5 +-
 8 files changed, 123 insertions(+), 63 deletions(-)

-- 
2.17.1

