Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03F222CCD
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 22:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgGPU3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 16:29:51 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47211 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbgGPU3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 16:29:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 10C5910A7;
        Thu, 16 Jul 2020 16:29:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 16 Jul 2020 16:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=lq5lYAwGKAKPA
        7FTNZKl+phaQuxzXONXDGWcSGjTGhw=; b=CFcsAHtdO9WQRhUcXsehB4W94Ne7p
        tTKSOKqWn9gZ3Lx+QH23U1e4jN09SjL++5nxJbGeTE1uB1Uk4+ldeaEpsAz/lerW
        spkQEjq7H3qfuU07SVuMzPo2JL1m5U/6Yup9bl5wQc2/Cv++gfo8KuxgWn34xVC+
        Bs+g8+xBnAGKqIz2KHts7herSgTNE6t6YDuJQvZKdx/5qNydky+z8Kb/THYr+Djz
        WHu9IxxTmtKU5G58GTIdwhmk29A8CKIxtXD9LJrItmw91KlH16jZqW9evIMMTipx
        fH50teUxSeHzSW7cCBflNeTAkxV0cHdRgWH+GnZ/V+cnomN6ZKrfJNSSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=lq5lYAwGKAKPA7FTNZKl+phaQuxzXONXDGWcSGjTGhw=; b=Av74mfK+
        y6UWnal3VGT/2SUIAjJX/DX+/jqgqPLsHDy7fXcvrahb3RPUYuZIrLPT5VTVQE11
        zOiF0RMYUiPdILQ8zEAu3CBexyBF6gNlGEP3OD6RHnKQVFBx+/klN8fAxNmPAsOe
        PAJn2KbQHvYvxiXZ5kpZvxrUwWAqYaxLeIH1ESlhfhofXsMLcLr1XNdzJBI1ihL+
        N/sOqr5fWDcYx8ne4EvTj4Ea3t48EMoZgHGu05XFP4yJhs/MBHMlu2TeY6nv6gqq
        5fbb8Ca+OPMZ/JTGoigSHAxWT+cJXzxtutPtb3l9ZTYrpVJLkpMELWxyVfpy8okn
        3rgiyvApXFoTBQ==
X-ME-Sender: <xms:vbgQX8qDELD6Sypgsd0ozHoaGPVFnO5U5mBo9O7cDd2QMiy8cq37BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfeeggdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:vbgQXyq1nb_5EMPm-HWu-0-yhYt4dZQl_Qg1VBhgAjft7Wzcs-GVFw>
    <xmx:vbgQXxM3Aq2CccUNJ-ATq6OD_OB8408C_Je03ZGaSePfynjHiWUuzA>
    <xmx:vbgQXz7x0yt-7LMC848EcTiCFdP-lRtPaNTGcAUD7Y41RYYFZe_qGQ>
    <xmx:vbgQX1SmdMQ4G2jDeSppL7BJd7gMGScbuORa_ZNBLOG3b-B_3mtxeA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC9D33280059;
        Thu, 16 Jul 2020 16:29:48 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3] btrfs: fix mount failure caused by race with umount
Date:   Thu, 16 Jul 2020 13:29:46 -0700
Message-Id: <20200716202946.2527706-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200716185110.GB3703@twin.jikos.cz>
References: <20200716185110.GB3703@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It is possible to cause a btrfs mount to fail by racing it with a slow
umount. The crux of the sequence is generic_shutdown_super not yet
calling sop->put_super before btrfs_mount_root calls btrfs_open_devices.
If that occurs, btrfs_open_devices will decide the opened counter is
non-zero, increment it, and skip resetting fs_devices->total_rw_bytes to
0. From here, mount will call sget which will result in grab_super
trying to take the super block umount semaphore. That semaphore will be
held by the slow umount, so mount will block. Before up-ing the
semaphore, umount will delete the super block, resulting in mount's sget
reliably allocating a new one, which causes the mount path to dutifully
fill it out, and increment total_rw_bytes a second time, which causes
the mount to fail, as we see double the expected bytes.

Here is the sequence laid out in greater detail:

CPU0                                                    CPU1
down_write sb->s_umount
btrfs_kill_super
  kill_anon_super(sb)
    generic_shutdown_super(sb);
      shrink_dcache_for_umount(sb);
      sync_filesystem(sb);
      evict_inodes(sb); // SLOW

                                              btrfs_mount_root
                                                btrfs_scan_one_device
                                                fs_devices = device->fs_devices
                                                fs_info->fs_devices = fs_devices
                                                // fs_devices-opened makes this a no-op
                                                btrfs_open_devices(fs_devices, mode, fs_type)
                                                s = sget(fs_type, test, set, flags, fs_info);
                                                  find sb in s_instances
                                                  grab_super(sb);
                                                    down_write(&s->s_umount); // blocks

      sop->put_super(sb)
        // sb->fs_devices->opened == 2; no-op
      spin_lock(&sb_lock);
      hlist_del_init(&sb->s_instances);
      spin_unlock(&sb_lock);
      up_write(&sb->s_umount);
                                                    return 0;
                                                  retry lookup
                                                  don't find sb in s_instances (deleted by CPU0)
                                                  s = alloc_super
                                                  return s;
                                                btrfs_fill_super(s, fs_devices, data)
                                                  open_ctree // fs_devices total_rw_bytes improperly set!
                                                    btrfs_read_chunk_tree
                                                      read_one_dev // increment total_rw_bytes again!!
                                                      super_total_bytes < fs_devices->total_rw_bytes // ERROR!!!

To fix this, we clear total_rw_bytes from within btrfs_read_chunk_tree
before the calls to read_one_dev, while holding the sb umount semaphore
and the uuid mutex.

To reproduce, it is sufficient to dirty a decent number of inodes, then
quickly umount and mount.

for i in $(seq 0 500)
do
  dd if=/dev/zero of="/mnt/foo/$i" bs=1M count=1
done
umount /mnt/foo&
mount /mnt/foo

does the trick for me.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/volumes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c7a3d4d730a3..26b9bcb00c2b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7035,6 +7035,14 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	mutex_lock(&uuid_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 
+	/*
+	 * It is possible for mount and umount to race in such a way that
+	 * we execute this code path, but open_fs_devices failed to clear
+	 * total_rw_bytes. We certainly want it cleared before reading the
+	 * device items, so clear it here.
+	 */
+	fs_info->fs_devices->total_rw_bytes = 0;
+
 	/*
 	 * Read all device items, and then all the chunk items. All
 	 * device items are found before any chunk item (their object id
-- 
2.24.1

