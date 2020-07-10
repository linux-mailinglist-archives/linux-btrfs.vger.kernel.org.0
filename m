Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B207F21BC1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 19:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGJRXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 13:23:09 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42951 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgGJRXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 13:23:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BDBB35C0113;
        Fri, 10 Jul 2020 13:23:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Jul 2020 13:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=+ZdKq3K92m9jP
        7fMZ/mVWx2x2cAzn2r7U746oA8iIl8=; b=Y6ZmMgexIkH6sOLN6h/d5OIw44JiT
        h6glUHiazDruIpfSRQgDSmsFvgeNk3idgvDbMZt6yeJoEKlOcrbC3JR9A5aZqCiO
        RQ9hYdpZGx98kp8m6KmD4Mscl8KhB8Jebe7XyWdP42MdXmCGWpYW4vNjIvZKqxWV
        DAvBBv6tTHzDx0cv9DILPYH0UjF2rux0wqcmXK79D8Oa4sZ9GnMDx3ntZkwvYmIB
        zMUz/rjwPuJ+36pm92fV0SeVoHoXfO8eMbK69Yupgb5Ufm2SLC6cyIi7HszTWlv2
        5wdWxWk754igoJw7A7QMpSy7IK6hGdnz6zOPqdw/NaNJ9aTUQ+SlswuRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+ZdKq3K92m9jP7fMZ/mVWx2x2cAzn2r7U746oA8iIl8=; b=htq72VoQ
        HdC2l3UQS/fw7CJm8+yGBQrSMqLnVh7oblGfpKHOL3cn46psU5Y5lSnRKAEPS1UJ
        VZCfRsgzBBlKmudD+wGezxb0bHxzsVfKUR/DRfnhHlLAVInf7az04jXtE9aJaRby
        I7Sy9ioIS9C7N40qrqESjZEEqsOhDFjbrIMWGCTNVFnu2A6jXr8OhLqEXMM9W1SJ
        yAc5OsPj2UHAcd/18vedSWfTGH9alM1yp/2A0vhV/JXsTAI7txJrvqK39U0l/qB1
        hN8xbOMpAOLuaTXYohyvVO9rcZUB7Sz0nkB7S5y0Qj8YtvuzW2udJ6xQHf/RJzb/
        QmPm4TGmHdjN8g==
X-ME-Sender: <xms:-6MIXzZ8lK32toiLP40MsjguGePx18iACP9Ywyoq-QtV3AfzxFqmMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddugdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:-6MIXyaDj-10oQ8hu1_RAX20lhlIv6wdv0JGkZT_DWqpVatG7o_dag>
    <xmx:-6MIX19TV-i9xIdmgMRvvHVH5XRKwd8-jq6gx2_9qAkkUm2TieDfiQ>
    <xmx:-6MIX5pFjeRjwqmrHm2ZOPGo_IOxwtCfjNp92-q8rjXoOaAfHVqQdw>
    <xmx:-6MIX12D7xkXUXq_7X3oVI2mI45RObC2EdHIsQP5YsQe8uKMCO18yg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id B01F43280067;
        Fri, 10 Jul 2020 13:23:06 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2] btrfs: fix mount failure caused by race with umount
Date:   Fri, 10 Jul 2020 10:23:04 -0700
Message-Id: <20200710172304.139763-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <e2857658-230e-48e6-d6cf-587be4a8a0bc@toxicpanda.com>
References: <e2857658-230e-48e6-d6cf-587be4a8a0bc@toxicpanda.com>
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
 fs/btrfs/volumes.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c7a3d4d730a3..865fab39ef43 100644
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
@@ -6815,8 +6812,15 @@ static int read_one_dev(struct extent_buffer *leaf,
 			return -EINVAL;
 	}
 
+	/*
+	 * It is possible for mount and umount to race in such a way that
+	 * we execute this code path, but the device is still in metadata.
+	 * If so, we don't need to call fill_device_from_item again and we
+	 * especially don't want to spuriously increment total_rw_bytes.
+	 */
+	if (test_and_set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state))
+		return 0;
 	fill_device_from_item(leaf, dev_item, device);
-	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	   !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
 		device->fs_devices->total_rw_bytes += device->total_bytes;
-- 
2.24.1

