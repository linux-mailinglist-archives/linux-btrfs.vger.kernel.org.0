Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA1CDE02
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfJGJLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:11:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfJGJLJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 05:11:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68580B1A3;
        Mon,  7 Oct 2019 09:11:07 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/4] Add xxhash64 and sha256 as possible new checksums
Date:   Mon,  7 Oct 2019 11:11:00 +0200
Message-Id: <20191007091104.18095-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series adds support for two additional checksum algorithms to btrfs. These
algorithms are xxhash64[1] and sha256[2].

xxhash64 is a fast non-cryptographic hash function with good collision resistance.
It has a constant output length of 8 Byte (64 Bit), it provides a good
trade-off between collision resistance and speed compared to the currently
used crc32c.

sha256 is the 32 Byte (256 Bit) variant of the SHA-2 cryptographic hash. It
provides cryptographically secure collision resistance with a trade off in
speed.

Support for xxhash64 in mkfs.btrfs is in the current devel branch and sha256
support will be sent separately after this patch-set.

In addition to adding these two hash algorithms two sysfs files are
implemented, one being /sys/fs/btrfs/features/supported_checksums showing the
in kernel support for different checksumming algorithms. The other one is
/sys/fs/btrfs/$FSID/checksum showing the checksum used for a specific
file-system and the used in-kernel driver for this checksum.

Here is an example in a qemu vm:
host:/# cat /sys/fs/btrfs/features/supported_checksums
crc32c, xxhash64, sha256
host:/# cat /sys/fs/btrfs/3cf09516-5bb8-498f-834d-e9ec54043546/checksum
sha256 (sha256-generic)

This series has survived the usual regression testing with xfstests.

I could not observe any performance differences between any of these hashes in
my test setup 256K mixed read-write IO to a single file from a single process
on both a 5700rpm SATA 3G Disk behind a HPE SmartArray RAID HBA and RAM Disk.

Here's the raw numbers for the spinning rust behind SATA:
CRC32C Buffered Read (KiB/s): Avg: 7881, Min: 7495, Max: 8744, Stdev: 508
CRC32C Buffered Write (KiB/s): Avg: 7883, Min: 7497, Max: 8746, Stdev: 508
                               
CRC32C Direct Read (KiB/s): Avg: 331, Min: 319, Max: 339, Stdev: 7
CRC32C Direct Write (KiB/s): Avg: 331, Min: 319, Max: 339, Stdev: 7

XXHASH64 Buffered Read (KiB/s): Avg: 8143, Min: 7748, Max: 8721, Stdev: 355
XXHASH64 Buffered Write (KiB/s): Avg: 8145, Min: 7750, Max: 8722, Stdev: 355

XXHASH64 Direct Read (KiB/s): Avg: 311, Min: 248, Max: 336, Stdev: 36
XXHASH64 Direct Write (KiB/s): Avg: 311, Min: 248, Max: 336, Stdev: 36
                               
SHA256 Buffered Read (KiB/s): Avg: 7997, Min: 7665, Max: 8336, Stdev: 273
SHA256 Buffered Write (KiB/s): Avg: 7998, Min: 7666, Max: 8337, Stdev: 273

SHA256 Direct Read (KiB/s): Avg: 312, Min: 248, Max: 336, Stdev: 36
SHA256 Direct Write (KiB/s): Avg: 312, Min: 248, Max: 336, Stdev: 36

The reason I could not observe any changes in performance is the fact that the
btrfs checksumming process takes only 0.04% of the IO path. This also explains
the very small standard deviation in the above table as I stooped benchmarking
after 5 benchmark runs.

The hottest call chain (according to perf) is this:

17.08%     0.00%  kworker/u128:9-  [kernel.vmlinux]  [k] btrfs_finish_ordered_io
 |
 ---btrfs_finish_ordered_io
    |          
     --17.04%--insert_reserved_file_extent.constprop.75
       |          
        --17.02%--__btrfs_drop_extents
     	   |          
     	    --16.94%--btrfs_free_extent
     		|          
     		 --16.94%--btrfs_add_delayed_data_ref
     		   |          
     		    --16.90%--btrfs_qgroup_trace_extent_post
     			      btrfs_find_all_roots
     			      |          
     			       --16.90%--btrfs_find_all_roots_safe
     				 |          
     				  --16.89%--find_parent_nodes
     				    |          
     				     --16.68%--resolve_indirect_refs
					       [snip]

[1] https://cyan4973.github.io/xxHash
[2] https://en.wikipedia.org/wiki/SHA-2

David Sterba (1):
  btrfs: sysfs: export supported checksums

Johannes Thumshirn (3):
  btrfs: add xxhash64 to checksumming algorithms
  btrfs: add sha256 to checksumming algorithms
  btrfs: show used checksum driver per filesystem in sysfs

 fs/btrfs/Kconfig                |  2 ++
 fs/btrfs/ctree.c                |  7 ++++++
 fs/btrfs/ctree.h                |  2 ++
 fs/btrfs/disk-io.c              |  2 ++
 fs/btrfs/super.c                |  2 ++
 fs/btrfs/sysfs.c                | 48 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h |  2 ++
 7 files changed, 65 insertions(+)

-- 
2.16.4

