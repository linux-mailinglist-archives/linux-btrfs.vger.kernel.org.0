Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C227979B065
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355885AbjIKWCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbjIKMw3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:29 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7213CEB;
        Mon, 11 Sep 2023 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436745; x=1725972745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/GWruwMj73XrJmk+0WNQIqaqY58Qcl6UowfZNG3AlVk=;
  b=cNfwXJi7omRs7uUIlB6YcPoUnYXiXOf2wGzYFovoz6bf4daAvBxSPJv4
   EBF/AJ2cWQZwfFVG1U0WkVdUQ1Yupz+0ErTuXvRhPeZJTEyNlbWjbvI5M
   HiiNVsSYJKB7YNa+cwVsBI/Bi7/xGn1DSkjHYW6vN6CqpoKrAC95Nw2Vg
   DLs2VhQo6zPSqVY4UVvyyYkzEsGuzQGfQXLZ/auXu836MYQxsbMXE7fFk
   0Qks0D7wdIwxLsLIEgJ+xCyR21fW9EogxRUc4hrGw19/VjVBLNXuucXje
   sLxvv6LKOjC1HFu1hN8xbH0SSdBJ3drZBeZruEIhzSiYTuyo6wu8nrdGs
   g==;
X-CSE-ConnectionGUID: ojPVaRudQ3avWpHJkgnG+A==
X-CSE-MsgGUID: JEBuHoT6QzemH19c36MuHA==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594375"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:24 +0800
IronPort-SDR: hYA10h37euADM+ETY8OtkOMabkyDKCfyP4TjVLzowV49sx5s2cHlz26+Chv5QYbzC61PXeV7tZ
 CKG7fL9twmu4r5yq6DDyyqkentfXLI7bMuI27D5TjmxEJLThsoVCgGCNSFchc67L0D1JsFcrMO
 cxTOi0+yL2IQDjXGIZUtre7rEtiZBesu7FZ2EUzpJRFZlaCCoZeaEkkO/Kysyuq3coTb9vAwox
 iKy5+/LfEFq1WTh2jlAX0nBbXyUmYw6m+GxXZ/VoHgS2HouAnvZ59H+1WKNCk43RfimFwl3yUk
 1Ms=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 04:59:29 -0700
IronPort-SDR: xbQpaGrf4GErrvRFnpsK4EFMtmV3NmvhPqKqq0eqHeyKDzX3K5xLrM8VpRbU/vdwCddIG0f4VX
 tA2t8I1SqQo1PUcqcKoIq38But9m7Y084ow1rZY7/WWXS+FW6aNDN9f9ruIKqZJP4EnNp6JYrx
 mA9efDL6Hw1Ycam6HQ8rj86gv0/CKXgMBTEUf/Kqhp6Xz8zWRItaj1UzoVwx/vIAD/EtVT534S
 WrGxRVkzzzD+B7JR/OrM6Y6hmUgVZYf4O0LTOxqkyMphsdolxfyBOc84P7ElKYWtXsFV7aYdPN
 Ws8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:22 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v8 00/11] btrfs: introduce RAID stripe tree
Date:   Mon, 11 Sep 2023 05:52:01 -0700
Message-ID: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=6155; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=/GWruwMj73XrJmk+0WNQIqaqY58Qcl6UowfZNG3AlVk=; b=Bj/hqP8Mk+eRtZYYKYKNEk0DMizMpZkr+94No3mkh1qvdY3oZIsE+pX12WXVT0VbmYJ01W80M UeQgqWKECMmDNlFLs6uYX6gThfzVwyp0ulIc85wFNV8r3BbnOJ4Bab4
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Updates of the raid-stripe-tree are done at ordered extent write time to safe
on bandwidth while for reading we do the stripe-tree lookup on bio mapping
time, i.e. when the logical to physical translation happens for regular btrfs
RAID as well.

The stripe tree is keyed by an extent's disk_bytenr and disk_num_bytes and
it's contents are the respective physical device id and position.

For an example 1M write (split into 126K segments due to zone-append)
rapido2:/home/johannes/src/fstests# xfs_io -fdc "pwrite -b 1M 0 1M" -c fsync /mnt/test/test
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0065 sec (151.538 MiB/sec and 151.5381 ops/sec)

The tree will look as follows (both 128k buffered writes to a ZNS drive):

RAID0 case:
bash-5.2# btrfs inspect-internal dump-tree -t raid_stripe /dev/nvme0n1
btrfs-progs v6.3
raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
leaf 805535744 items 1 free space 16218 generation 8 owner RAID_STRIPE_TREE
leaf 805535744 flags 0x1(WRITTEN) backref revision 1
checksum stored 2d2d2262
checksum calced 2d2d2262
fs uuid ab05cfc6-9859-404e-970d-3999b1cb5438
chunk uuid c9470ba2-49ac-4d46-8856-438a18e6bd23
        item 0 key (1073741824 RAID_STRIPE_KEY 131072) itemoff 16243 itemsize 40
                        encoding: RAID0
                        stripe 0 devid 1 offset 805306368
                        stripe 1 devid 2 offset 536870912
total bytes 42949672960
bytes used 294912
uuid ab05cfc6-9859-404e-970d-3999b1cb5438

RAID1 case:
bash-5.2# btrfs inspect-internal dump-tree -t raid_stripe /dev/nvme0n1
btrfs-progs v6.3
raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
leaf 805535744 items 1 free space 16218 generation 8 owner RAID_STRIPE_TREE
leaf 805535744 flags 0x1(WRITTEN) backref revision 1
checksum stored 56199539
checksum calced 56199539
fs uuid 9e693a37-fbd1-4891-aed2-e7fe64605045
chunk uuid 691874fc-1b9c-469b-bd7f-05e0e6ba88c4
        item 0 key (939524096 RAID_STRIPE_KEY 131072) itemoff 16243 itemsize 40
                        encoding: RAID1
                        stripe 0 devid 1 offset 939524096
                        stripe 1 devid 2 offset 536870912
total bytes 42949672960
bytes used 294912
uuid 9e693a37-fbd1-4891-aed2-e7fe64605045

A design document can be found here:
https://docs.google.com/document/d/1Iui_jMidCd4MVBNSSLXRfO7p5KmvnoQL/edit?usp=sharing&ouid=103609947580185458266&rtpof=true&sd=true

The user-space part of this series can be found here:
https://lore.kernel.org/linux-btrfs/20230215143109.2721722-1-johannes.thumshirn@wdc.com

Changes to v7:
- Huge rewrite

v7 of the patchset can be found here:
https://lore.kernel.org/linux-btrfs/cover.1677750131.git.johannes.thumshirn@wdc.com/

Changes to v6:
- Fix degraded RAID1 mounts
- Fix RAID0/10 mounts

v6 of the patchset can be found here:
https://lore/kernel.org/linux-btrfs/cover.1676470614.git.johannes.thumshirn@wdc.com

Changes to v5:
- Incroporated review comments from Josef and Christoph
- Rebased onto misc-next

v5 of the patchset can be found here:
https://lore/kernel.org/linux-btrfs/cover.1675853489.git.johannes.thumshirn@wdc.com

Changes to v4:
- Added patch to check for RST feature in sysfs
- Added RST lookups for scrubbing 
- Fixed the error handling bug Josef pointed out
- Only check if we need to write out a RST once per delayed_ref head
- Added support for zoned data DUP with RST

Changes to v3:
- Rebased onto 20221120124734.18634-1-hch@lst.de
- Incorporated Josef's review
- Merged related patches

v3 of the patchset can be found here:
https://lore/kernel.org/linux-btrfs/cover.1666007330.git.johannes.thumshirn@wdc.com

Changes to v2:
- Bug fixes
- Rebased onto 20220901074216.1849941-1-hch@lst.de
- Added tracepoints
- Added leak checker
- Added RAID0 and RAID10

v2 of the patchset can be found here:
https://lore.kernel.org/linux-btrfs/cover.1656513330.git.johannes.thumshirn@wdc.com

Changes to v1:
- Write the stripe-tree at delayed-ref time (Qu)
- Add a different write path for preallocation

v1 of the patchset can be found here:
https://lore.kernel.org/linux-btrfs/cover.1652711187.git.johannes.thumshirn@wdc.com/

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Johannes Thumshirn (11):
      btrfs: add raid stripe tree definitions
      btrfs: read raid-stripe-tree from disk
      btrfs: add support for inserting raid stripe extents
      btrfs: delete stripe extent on extent deletion
      btrfs: lookup physical address from stripe extent
      btrfs: implement RST version of scrub
      btrfs: zoned: allow zoned RAID
      btrfs: add raid stripe tree pretty printer
      btrfs: announce presence of raid-stripe-tree in sysfs
      btrfs: add trace events for RST
      btrfs: add raid-stripe-tree to features enabled with debug

 fs/btrfs/Makefile               |   2 +-
 fs/btrfs/accessors.h            |  10 +
 fs/btrfs/bio.c                  |  23 ++
 fs/btrfs/block-rsv.c            |   6 +
 fs/btrfs/disk-io.c              |  18 ++
 fs/btrfs/disk-io.h              |   5 +
 fs/btrfs/extent-tree.c          |   7 +
 fs/btrfs/fs.h                   |   4 +-
 fs/btrfs/inode.c                |   8 +-
 fs/btrfs/locking.c              |   5 +-
 fs/btrfs/ordered-data.c         |   1 +
 fs/btrfs/ordered-data.h         |   2 +
 fs/btrfs/print-tree.c           |  49 ++++
 fs/btrfs/raid-stripe-tree.c     | 493 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h     |  52 +++++
 fs/btrfs/scrub.c                |  56 +++++
 fs/btrfs/sysfs.c                |   3 +
 fs/btrfs/volumes.c              |  43 +++-
 fs/btrfs/volumes.h              |  15 +-
 fs/btrfs/zoned.c                | 113 ++++++++-
 include/trace/events/btrfs.h    |  75 ++++++
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  33 ++-
 23 files changed, 999 insertions(+), 25 deletions(-)
---
base-commit: 133da717263112d81bb95b5535ceb2c1eeddd4e7
change-id: 20230613-raid-stripe-tree-e330c9a45cc3

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

