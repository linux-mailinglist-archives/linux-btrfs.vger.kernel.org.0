Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24F21AC1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 02:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgGJAoP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 20:44:15 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36961 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgGJAoO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 20:44:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7FFAF9F7;
        Thu,  9 Jul 2020 20:44:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 09 Jul 2020 20:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=pXP7fces+leP4k9HK7j9Ymtbyk
        lzJn5vKIdqMO1/eiQ=; b=W9apJZYgEiyrEWYc0ES4dXgp08mky4k1uCJqclP0wJ
        iBP1fURM70OaRh0SzdYmGLns1D0Q9nvbXhPRjvNURI4vRVJlqdM5Mgn3q971vhb4
        wMHG2HBViygYs5Il//lOK6VQnUuf8fHuTXgKlvcb4EsVwL6z7oclhnTdPNV0C61S
        9QVHCx823E1qPBEIzyVp2Lp0DX7SOx+aQrM0RKAcEFa3MCPJSrRUf7NjxQ9vdAgD
        VgoCwG74/xH9Vt7aRrD7aiQrfX3G3gvr72h3t1OyH8iZv+yfzW9RZ96lLd0Vmm9u
        RkPVoNOOTHhTGkbM1utdMRvRPUQMydFoc6Cyw3ucqKsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pXP7fces+leP4k9HK
        7j9YmtbyklzJn5vKIdqMO1/eiQ=; b=uUZXZ8GAPkqqUy/BzOvViBII7Csr8qCMM
        M3jkvvOKXCo4tNZvt/Ag/nS8AnzH6eobs54Z67VUPzfpIIVwEq0XsENwuPXx1O5i
        Lj3z/6ICeUs7vAPzflPN51OrSrqL6esh+5gsu7B9i5ppJkLnTtp4oDHmRZyUGgrx
        nge8M6hcXPCybdNT1memApjNHNGu+OvIypn0FykdawBL3Dlq203XXxVWr3ioyonQ
        crg5FxyzI8XDkkXJoqHxUOjwQwv0rzHmkyeXJ0FE+xxzo1b++lAIlEs+XByyLsga
        ivfeiYsKObHJY2knzJpeNBfFENHqHeBZknVDfpjIH4leTajRrBwZg==
X-ME-Sender: <xms:3LkHX9rnyXxgBlKUG1xenu57UhVxtKnnGEjKHmx0XhTC5jYQSPgsUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddtgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehu
    rhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtle
    euieejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphepudei
    fedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:3LkHX_qvM5mJYVS6ozsOrCt6D6xom5bmGLvbCQa_bUR2pkoKaR6FiA>
    <xmx:3LkHX6Ph9KjYIgp5d1qgp2q5IuHPuA3hZn8G97_1hn6y5MIG6ZMxMQ>
    <xmx:3LkHX47wI5R8KKuO9TfP1Qd0PyKwTFRP9TaCpCvCsTTQf8-47C4H6Q>
    <xmx:3bkHX8FdfpanCyfKBNxksikEwnVdICkyqN362TBTkp7jxMr-_iH_Ug>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 326F730600A6;
        Thu,  9 Jul 2020 20:44:12 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] btrfs: fix mount failure caused by race with umount
Date:   Thu,  9 Jul 2020 17:44:08 -0700
Message-Id: <20200710004408.1246282-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
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

To fix this, we observe that if we have already filled the device, the
state bit BTRFS_DEV_STATE_IN_FS_METADATA will be set on it, and we can
use that to avoid filling it a second time for no reason and,
critically, avoid double counting in total_rw_bytes. One gotcha is that
read_one_chunk also sets this bit, which happens before read_one_dev (in
read_sys_array), so we must remove that setting of the bit as well, for
the state bit to truly correspond to the device struct being filled from
disk.

To reproduce, it is sufficient to dirty a decent number of inodes, then
quickly umount and mount.

for i in $(seq 0 500)
do
  dd if=/dev/zero of="/mnt/foo/$i" bs=1M count=1
done
umount /mnt/foo&
mount /mnt/foo

does the trick for me.

A final note is that this fix actually breaks the fstest btrfs/163, but
having investigated it, I believe that is due to a subtle flaw in how
btrfs replace works when used on a seed device. The replace target device
never gets a correct dev_item with the sprout fsid written out. This
causes several problems, but for the sake of btrfs/163, read_one_chunk
marking the device with IN_FS_METADATA was wallpapering over it, which
this patch breaks. I will be sending a subsequent fix for the seed replace
issue which will also fix btrfs/163.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/volumes.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c7a3d4d730a3..1d9bd1bbf893 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6633,9 +6633,6 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			}
 			btrfs_report_missing_device(fs_info, devid, uuid, false);
 		}
-		set_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
-				&(map->stripes[i].dev->dev_state));
-
 	}
 
 	write_lock(&map_tree->lock);
@@ -6815,6 +6812,15 @@ static int read_one_dev(struct extent_buffer *leaf,
 			return -EINVAL;
 	}
 
+	/*
+	 * It is possible for mount and umount to race in such a way that
+	 * we execute this code path, but the device is still in metadata.
+	 * If so, we don't need to call fill_device_from_item again and we
+	 * especially don't want to spuriously increment total_rw_bytes.
+	 */
+	if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state)) {
+		return 0;
+	}
 	fill_device_from_item(leaf, dev_item, device);
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
-- 
2.24.1

