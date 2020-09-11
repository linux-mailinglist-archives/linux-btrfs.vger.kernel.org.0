Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F008266797
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgIKRpS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 13:45:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38370 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgIKMds (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 08:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827629; x=1631363629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywQO90banmK5vgfCCjoWfPgF4IzmbOYq+kE/QmK9wrk=;
  b=lma5ajmMxMQev1NeQsoc0RuQwB9MnXuyrw8DEYVJk83IfrFaqeCJkd4a
   9sPieZNX1t9hXg480gCpB47t3sxRgW/UNARUWTcnPCWL6Dz5CPf9Kwx+6
   ntvLV5WquwiAWOsosBumXO1l8rdVMwN4E93DaMOWQ2NpfgETZb/jbmDNI
   xhAhES94RpW7a85bahusxyoxchdsap7LInHssUWjqmU7N+C/BVZQLT9yP
   GAbxhUy3ShX/A24GlRyCcCzSUOUDCiV5pWL/vTOn0vkYYGsUnNPlTaDRZ
   E/bpTukJoCd+qmgeZiwzHzESSOq5pesFRtE/ZAQ0DFjalB6CUJt1bJXsT
   w==;
IronPort-SDR: hb7Jblh2teSMvw9pz8aRAoDSBw9603tZetVW3Xaw9flPA7vJ0D03xTxlNzEtYRRC1wdq0dQ3WG
 /S6LzuPptkaME/PNIWjlQKfrNzEg7Zj2sjRcyMM9i5IVafhEhzs6NX//pCizzp216/LuhAqEol
 +WXaoVz8NCVi27Djfke85iOqiJ61RpZlkzy71/wL5pwhg832aq2U8SIQlII7rheSw89SMpsHI8
 OYDagca+oumjGGcteaPXaUr7I5bQ4y1egerj0m8S5LEc1NwYGsZ5IwNGxDWJ4P3axCriIrrh8P
 uAA=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125943"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:08 +0800
IronPort-SDR: 7SDwQOag7UTpm6SvOc17nKoo4/rq/1m9PyutabZDXV+lNOF0na3cdMX/J2O1KYqmvX++/TNqc+
 qicGK2bpi13A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:28 -0700
IronPort-SDR: 3df3d5wXzEqdg69RgkJjKAwD7K5BJnBR5W+ad4gevxKx/MiesOut8iPmLX0ZGrckHsWuPDyFAg
 dY38m1LGtjzg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 00/39] btrfs: zoned block device support
Date:   Fri, 11 Sep 2020 21:32:20 +0900
Message-Id: <20200911123259.3782926-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series adds zoned block device support to btrfs.

Changes from v6:
 - Use zone append write command instead of normal write command
   - Bio issuing order does not matter
   - No need to use lock anymore
   - Can use asynchronous checksum
 - Removed RAID support for now
 - Rename HMZONED to ZONED
 - Split some patches
 - Rebased on kdave/for-5.9-rc3 + iomap direct IO

Userland series will follow.

This version of ZONED btrfs switched from normal write command to zone
append write command. You do not need to specify LBA (at the write pointer)
to write for zone append write command. Instead, you only select a zone to
write with its start LBA. Then the device (NVMe ZNS), or the emulation of
zone append command in the sd driver in the case of SAS or SATA HDDs,
automatically writes the data at the write pointer position and return the
written LBA as a command reply.

The benefit of using the zone append write command is that write command
issuing order does not matter. So, we can eliminate block group lock and
utilize asynchronous checksum, which can reorder the IOs.

Eliminating the lock improves performance. In particular, on a workload
with massive competing to the same zone [1], we observed 36% performance
improvement compared to normal write.

[1] Fio running 16 jobs with 4KB random writes for 5 minutes

However, there are some limitations. We cannot use the non-SINGLE profile.
Supporting non-SINGLE profile with zone append writing is not trivial. For
example, in the DUP profile, we send a zone append writing IO to two zones
on a device. The device reply with written LBAs for the IOs. If the offsets
of the returned addresses from the beginning of the zone are different,
then it results in different logical addresses.

For the same reason, we cannot issue multiple IOs for one ordered extent.
Thus, the size of an ordered extent is limited under max_zone_append_size.
This limitation will cause fragmentation and increased usage of metadata.
In the future, we can add optimization to merge ordered extents after
end_bio.

* Patch series description

A zoned block device consists of a number of zones. Zones are either
conventional and accepting random writes or sequential and requiring
that writes be issued in LBA order from each zone write pointer
position. This patch series ensures that the sequential write
constraint of sequential zones is respected while fundamentally not
changing BtrFS block and I/O management for block stored in
conventional zones.

To achieve this, the default chunk size of btrfs is changed on zoned
block devices so that chunks are always aligned to a zone. Allocation
of blocks within a chunk is changed so that the allocation is always
sequential from the beginning of the chunks. To do so, an allocation
pointer is added to block groups and used as the allocation hint.  The
allocation changes also ensure that blocks freed below the allocation
pointer are ignored, resulting in sequential block allocation
regardless of the chunk usage.

The zone of a chunk is reset to allow reuse of the zone only when the
block group is being freed, that is, when all the chunks of the block
group are unused.

For btrfs volumes composed of multiple zoned disks, a restriction is
added to ensure that all disks have the same zone size. This
restriction matches the existing constraint that all chunks in a block
group must have the same size.

* Enabling tree-log

The tree-log feature does not work on ZONED mode as is. Blocks for a
tree-log tree are allocated mixed with other metadata blocks, and btrfs
writes and syncs the tree-log blocks to devices at the time of fsync(),
which is different timing than a global transaction commit. As a result,
both writing tree-log blocks and writing other metadata blocks become
non-sequential writes which ZONED mode must avoid.

This series introduces a dedicated block group for tree-log blocks to
create two metadata writing streams, one for tree-log blocks and the
other for metadata blocks. As a result, each write stream can now be
written to devices separately and sequentially.

* Log-structured superblock

Superblock (and its copies) is the only data structure in btrfs which
has a fixed location on a device. Since we cannot overwrite in a
sequential write required zone, we cannot place superblock in the
zone.

This series implements superblock log writing. It uses two zones as a
circular buffer to write updated superblocks. Once the first zone is filled
up, start writing into the second zone. The first zone will be reset once
both zones are filled. We can determine the postion of the latest
superblock by reading the write pointer information from a device.

* Patch series organization

Patch 1 introduces the ZONED incompatible feature flag to indicate that the
btrfs volume was formatted for use on zoned block devices.

Patches 2 to 4 implement functions to gather information on the zones of
the device (zones type, write pointer position, and max_zone_append_size).

Patches 5 to 9 disable features which are not compatible with the
sequential write constraints of zoned block devices. These includes
space_cache, NODATACOW, fallocate, MIXED_BG and inode cache.

Patch 10 implements the log-structured superblock writing.

Patches 11 and 12 tweak the device extent allocation for ZONED mode and add
verification to check if a device extent is properly aligned to zones.

Patches 13 to 16 implements sequential block allocator for ZONED mode.

Patch 17 implement a zone reset for unused block groups.

Patches 18 to 28 implement the writing path for several types of IO
(non-compressed data, direct IO, and metadata). These include re-dirtying
once-freed metadata blocks to prevent write holes.

Patches 29 to 38 tweak some btrfs features work with ZONED mode. These
include device-replace, relocation, repairing IO error, and tree-log.

Finally, patch 28 adds the ZONED feature to the list of supported features.

* Patch testing note

This series is based on kdave/for-5.5.

** Zone-aware util-linux

Since the log-structured superblock feature changed the location of
superblock magic, the current util-linux (libblkid) cannot detect ZONED
btrfs anymore. You need to apply a to-be posted patch to util-linux to make
it "zone aware".

** Testing device

You need devices with zone append writing command support to run ZONED
btrfs.

Other than real devices, null_blk supports zone append write command. You
can use memory backed null_blk to run the test on it. Following script
creates 12800 MB /dev/nullb0.

    sysfs=/sys/kernel/config/nullb/nullb0
    size=12800 # MB
    
    # drop nullb0
    if [[ -d $sysfs ]]; then
            echo 0 > "${sysfs}"/power
            rmdir $sysfs
    fi
    lsmod | grep -q null_blk && rmmod null_blk
    modprobe null_blk nr_devices=0
    
    mkdir "${sysfs}"
    
    echo "${size}" > "${sysfs}"/size
    echo 1 > "${sysfs}"/zoned
    echo 0 > "${sysfs}"/zone_nr_conv
    echo 1 > "${sysfs}"/memory_backed
    
    echo 1 > "${sysfs}"/power
    udevadm settle

Zoned SCSI devices such as SMR HDDs or scsi_debug also support the zone
append command as an emulated command within the SCSI sd driver. This
emulation is completely transparent to the user and provides the same
semantic as a NVMe ZNS native drive support.

Also, there is a qemu patch available to enable NVMe ZNS device.

** xfstests

We ran xfstests on ZONED btrfs, and, if we omit some cases that are known
to fail currently, all test cases pass.

Cases that can be ignored:
1) failing also with the regular btrfs on regular devices,
2) trying to test fallocate feature without testing with
   "_require_xfs_io_command "falloc"",
3) trying to test incompatible features for ZONED btrfs (e.g. RAID5/6)
4) trying to use incompatible setup for ZONED btrfs (e.g. dm-linear not
   aligned to zone boundary, swap)
5) trying to create a file system with too small size, (we require at least
   9 zones to initiate a ZONED btrfs)
6) dropping original MKFS_OPTIONS ("-O zoned"), so it cannot create ZONED
   btrfs (btrfs/003)
7) having ENOSPC which incurred by larger metadata block group size

I will send a patch series for xfstests to handle these cases (2-6)
properly.

Also, you need to apply the following patch if you run xfstests with
tcmu devices. xfstests btrfs/003 failed to "_devmgt_add" after
"_devmgt_remove" without this patch.

https://marc.info/?l=linux-scsi&m=156498625421698&w=2

v6 https://lore.kernel.org/linux-btrfs/20191213040915.3502922-1-naohiro.aota@wdc.com/
v5 https://lore.kernel.org/linux-btrfs/20191204082513.857320-1-naohiro.aota@wdc.com/
v4 https://lwn.net/Articles/797061/
v3 https://lore.kernel.org/linux-btrfs/20190808093038.4163421-1-naohiro.aota@wdc.com/
v2 https://lore.kernel.org/linux-btrfs/20190607131025.31996-1-naohiro.aota@wdc.com/
v1 https://lore.kernel.org/linux-btrfs/20180809180450.5091-1-naota@elisp.net/

Changelog
v6:
 - Use bitmap helpers (Johannes)
 - Code cleanup (Johannes)
 - Rebased on kdave/for-5.5
 - Enable the tree-log feature.
 - Treat conventional zones as sequential zones, so we can now allow
   mixed allocation of conventional zone and sequential write required
   zone to construct a block group.
 - Implement log-structured superblock
   - No need for one conventional zone at the beginning of a device.
 - Fix deadlock of direct IO writing
 - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)
 - Fix leak of zone_info (Johannes)
v5:
 - Rebased on kdave/for-5.5
 - Enable the tree-log feature.
 - Treat conventional zones as sequential zones, so we can now allow
   mixed allocation of conventional zone and sequential write required
   zone to construct a block group.
 - Implement log-structured superblock
   - No need for one conventional zone at the beginning of a device.
 - Fix deadlock of direct IO writing
 - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)
 - Fix leak of zone_info (Johannes)
v4:
 - Move memory allcation of zone informattion out of
   btrfs_get_dev_zones() (Anand)
 - Add disabled features table in commit log (Anand)
 - Ensure "max_chunk_size >= devs_min * data_stripes * zone_size"
v3:
 - Serialize allocation and submit_bio instead of bio buffering in
   btrfs_map_bio().
 -- Disable async checksum/submit in HMZONED mode
 - Introduce helper functions and hmzoned.c/h (Josef, David)
 - Add support for repairing IO failure
 - Add support for NOCOW direct IO write (Josef)
 - Disable preallocation entirely
 -- Disable INODE_MAP_CACHE
 -- relocation is reworked not to rely on preallocation in HMZONED mode
 - Disable NODATACOW
 -Disable MIXED_BG
 - Device extent that cover super block position is banned (David)
v2:
 - Add support for dev-replace
 -- To support dev-replace, moved submit_buffer one layer up. It now
    handles bio instead of btrfs_bio.
 -- Mark unmirrored Block Group readonly only when there are writable
    mirrored BGs. Necessary to handle degraded RAID.
 - Expire worker use vanilla delayed_work instead of btrfs's async-thread
 - Device extent allocator now ensure that region is on the same zone type.
 - Add delayed allocation shrinking.
 - Rename btrfs_drop_dev_zonetypes() to btrfs_destroy_dev_zonetypes
 - Fix
 -- Use SECTOR_SHIFT (Nikolay)
 -- Use btrfs_err (Nikolay)


Naohiro Aota (39):
  btrfs: introduce ZONED feature flag
  btrfs: Get zone information of zoned block devices
  btrfs: Check and enable ZONED mode
  btrfs: introduce max_zone_append_size
  btrfs: disallow space_cache in ZONED mode
  btrfs: disallow NODATACOW in ZONED mode
  btrfs: disable fallocate in ZONED mode
  btrfs: disallow mixed-bg in ZONED mode
  btrfs: disallow inode_cache in ZONED mode
  btrfs: implement log-structured superblock for ZONED mode
  btrfs: implement zoned chunk allocator
  btrfs: verify device extent is aligned to zone
  btrfs: load zone's alloction offset
  btrfs: emulate write pointer for conventional zones
  btrfs: track unusable bytes for zones
  btrfs: do sequential extent allocation in ZONED mode
  btrfs: reset zones of unused block groups
  btrfs: redirty released extent buffers in ZONED mode
  btrfs: limit bio size under max_zone_append_size
  btrfs: limit ordered extent size to max_zone_append_size
  btrfs: extend btrfs_rmap_block for specifying a device
  btrfs: use ZONE_APPEND write for ZONED btrfs
  btrfs: handle REQ_OP_ZONE_APPEND as writing
  btrfs: enable zone append writing for direct IO
  btrfs: introduce dedicated data write path for ZONED mode
  btrfs: serialize meta IOs on ZONED mode
  btrfs: wait existing extents before truncating
  btrfs: avoid async metadata checksum on ZONED mode
  btrfs: mark block groups to copy for device-replace
  btrfs: implement cloning for ZONED device-replace
  btrfs: implement copying for ZONED device-replace
  btrfs: support dev-replace in ZONED mode
  btrfs: enable relocation in ZONED mode
  btrfs: relocate block group to repair IO failure in ZONED
  btrfs: split alloc_log_tree()
  btrfs: extend zoned allocator to use dedicated tree-log block group
  btrfs: serialize log transaction on ZONED mode
  btrfs: reorder log node allocation
  btrfs: enable to mount ZONED incompat flag

 fs/btrfs/Makefile           |    1 +
 fs/btrfs/block-group.c      |   85 ++-
 fs/btrfs/block-group.h      |   13 +
 fs/btrfs/ctree.h            |   12 +-
 fs/btrfs/dev-replace.c      |  187 +++++
 fs/btrfs/dev-replace.h      |    3 +
 fs/btrfs/disk-io.c          |   82 ++-
 fs/btrfs/disk-io.h          |    2 +
 fs/btrfs/extent-tree.c      |  206 +++++-
 fs/btrfs/extent_io.c        |   48 +-
 fs/btrfs/extent_io.h        |    2 +
 fs/btrfs/file.c             |    4 +
 fs/btrfs/free-space-cache.c |   58 ++
 fs/btrfs/free-space-cache.h |    4 +
 fs/btrfs/inode.c            |   72 +-
 fs/btrfs/ioctl.c            |    3 +
 fs/btrfs/ordered-data.c     |    3 +
 fs/btrfs/ordered-data.h     |    4 +
 fs/btrfs/relocation.c       |   35 +-
 fs/btrfs/scrub.c            |  145 ++++
 fs/btrfs/space-info.c       |   13 +-
 fs/btrfs/space-info.h       |    4 +-
 fs/btrfs/super.c            |   13 +-
 fs/btrfs/sysfs.c            |    4 +
 fs/btrfs/transaction.c      |   10 +
 fs/btrfs/transaction.h      |    3 +
 fs/btrfs/tree-log.c         |   50 +-
 fs/btrfs/volumes.c          |  307 ++++++++-
 fs/btrfs/volumes.h          |    7 +
 fs/btrfs/zoned.c            | 1279 +++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h            |  281 ++++++++
 include/uapi/linux/btrfs.h  |    1 +
 32 files changed, 2864 insertions(+), 77 deletions(-)
 create mode 100644 fs/btrfs/zoned.c
 create mode 100644 fs/btrfs/zoned.h

-- 
2.27.0

