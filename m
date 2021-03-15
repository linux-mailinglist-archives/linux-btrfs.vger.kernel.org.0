Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E599133AB47
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 06:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCOFyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 01:54:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23255 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCOFys (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 01:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615787688; x=1647323688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F9aPMtuPoCsdoJGnsyABRxGeNRNcNChskKXEJEqpkr4=;
  b=XgpNhH1/oMtwJdSDH+jlvEBQ72HwlfqnyncDolYx6tRyUziaYXxJegDV
   Et04BSUuVZOBqdDHhsHTfWz7pE3NH9/lCaCvelFbvPLUvXEp5RFF/gRXC
   9FSltSmEK4YvTQUvKz+GsrCc5YA+qYT2+sDRTypY1/jXAFx8qQM9g5svM
   0vUue/GZnwNXQHNqq++5pYcJ1sJeVFzFgiIZSaxLK8JsbzF1uEvIb0w5l
   tjRr2tPSpjKFw+EVrn0UaYYWamjRlQQE3eSiQ2n90rO+1P6Y+YThSEEXb
   ghNPDpZ3uQpgkhH9+RwzCBH80aX/XRqagCYF4H40cge3XMfSEyXZ0Q+9r
   Q==;
IronPort-SDR: mXvMdAVUpgmJQauTuFrYW1SrX+km3x36BF/FSVj7NlnwJ4rqECncMjH+cae+JKC8lW4QvpgfP2
 EWvpn+eZCQNMcxrcUPhJE4nowsHK6iBZmLAwURzbx+4S0iflF34+uG81AfFLDaiunVmZ5Bu1f5
 zb5tc14s96eALEQifdPcqkP4XtHHQJd/yv/Yz5FNVrFXf7v6sJKk/hTQ/GlxVi8Kcc2uCo954K
 Uu3/ocNxyCq7K4/373t5ISZbq13cpMXiCH9x5EkYkWG3u/eBch590GOJKAcvFqjxnIPW6vASLP
 U+8=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="272850825"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 13:54:45 +0800
IronPort-SDR: Vjx0rLoXEtNtq3luppBSrCfKyx+fIzi5ymrb0c15b6swDVydL9PmCkAGTuqUDhvrhmj1R4XrRH
 JsyvxSe+YmUxbOV5aub8Q/zIzD6Q0QSp5cLnNUYSrJm9NI/DvZcgc/QuJ+JSr+XHAbKYT/j1uT
 ZlKZUYvTagBTjfAuBSavSnDr1/mch+YJ6uiZjC3+nDWj5m2cl1M4HX7Q2kNKQnnYWD6zJWqPT9
 aOMe4OmZub4/3JGK2dSoO6ghRANYjo26do5fhoYHNT3RWfh8ScqerSVN3oeu1lt0PnUl4+yiLm
 y5e9eN2K8XiofeKW+QdsXqig
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 22:37:15 -0700
IronPort-SDR: BjP8+K2faFrYXwnxDHLYEdht4zIcLOwna64Dk2BsU55X7zGHLCXoZXv7rd7Vt0nGMLJxF4VJc5
 5qWKuyl/5V4AIF41V9Jay+unlCAR7dydMp8hZGGONGsJ/8vfPaCoEaCwF5Xw/NW5PUvyvfgS+7
 1Of9eH2SiVDPCL7i2ks7mhRJbEKAL/J+DuoD+xg1U3aMRYgE1yciHLJ44qiGrItTzW59VeF5/g
 3Y8VxZ3vTd43rORXS0SD3mRIbwamGYCTOoCBo2fAvjsQEtIkcLqtFMh20qheJAURcNWOnxQ3Bp
 2K8=
WDCIronportException: Internal
Received: from ind007401.ad.shared (HELO naota-xeon.wdc.com) ([10.225.51.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Mar 2021 22:54:45 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/1] zoned: moving superblock logging zones
Date:   Mon, 15 Mar 2021 14:53:02 +0900
Message-Id: <cover.1615773143.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following patch will change the superblock logging zones' location from
fixed zone number to fixed LBAs.

Here is a background of how the superblock is working on zoned btrfs.

This document will be promoted to btrfs-dev-docs in the future.

# Superblock logging for zoned btrfs

The superblock and its copies are the only data structures in btrfs with a
fixed location on a device. Since we cannot overwrite these blocks if they
are placed in sequential write required zones, we cannot use the regular
method of updating superblocks with zoned btrfs. We also cannot limit the
position of superblocks to conventional zones as that would prevent using
zoned block devices that do not have this zone type (e.g. NVMe ZNS SSDs).

To solve this problem, we use superblock log writing. This method uses two
sequential write required zones as a circular buffer to write updated
superblocks. Once the first zone is filled up, start writing into the
second zone. When both zones are filled up and before start writing to the
first zone again, the first zone is reset and writing continues in the
first zone. Once the first zone is full, reset the second zone, and write
the latest superblock in the second zone. With this logging, we can always
determine the position of the latest superblock by inspecting the zones'
write pointer information provided by the device. One corner case is when
both zones are full. For this situation, we read out the last superblock of
each zone and compare them to determine which copy is the latest one.

## Placement of superblock logging zones

We use the following three pairs of zones containing fixed offset
locations, regardless of the device zone size.

  - Primary superblock: zone starting at offset 0 and the following zone
  - First copy: zone containing offset 64GB and the following zone
  - Second copy: zone containing offset 256GB and the following zone

These zones are reserved for superblock logging and never used for data or
metadata blocks. Zones containing the offsets used to store superblocks in
a regular btrfs volume (no zoned case) are also reserved to avoid
confusion.

The first copy position is much larger than for a regular btrfs volume
(64M).  This increase is to avoid overlapping with the log zones for the
primary superblock. This higher location is arbitrary but allows supporting
devices with very large zone size, up to 32GB. But we only allow zone sizes
up to 8GB for now.

## Writing superblock in conventional zones

Conventional zones do not have a write pointer. This zone type thus cannot
be used with superblock logging since determining the position of the
latest copy of the superblock in a zone pair would be impossible.

To address this problem, if either of the zones containing the fixed offset
locations for zone logging is a conventional zone, superblock updates are
done in-place using the first block of the conventional zone.

## Reading zoned btrfs dump image without zone information

Reading a zoned btrfs image without zone information is challenging but
possible.

We can always find a superblock copy at or after the fixed offset locations
determining the logging zones position. With such copy, the superblock
incompatible flags indicates if the volume is zoned or not. With a chunk
item in the sys_chunk_array, we can determine the zone size from the size
of a device extent, itself determined from the chunk length, num_stripes,
and sub_stripes.  With this information, all blocks within the 2 logging
zones containing the fixed locations can be inspected to find the newest
superblock copy.

The first zone of a log pair may be empty and have no superblock copy. This
can happen if a system crashes after resetting the first zone of a pair and
before writing out a new superblock. In this case, a superblock copy can be
found in the second zone of a log pair. The start of this second zone can
be found by inspecting the blocks located at the fixed offset of the log
pair plus the possible zone size (4M [1], 8M, 16M, 32M, 64M, 128M, 256M,
512M, 1G, 2G, 4G, 8G [2])[3]. Once we find a superblock, we can follow the
same instruction above to find the latest superblock copy within the zone
log pair.

[1] 4M = BTRFS_MKFS_SYSTEM_GROUP_SIZE. We cannot mkfs on a device with a
zone size less than 4MB because we cannot create the initial temporary
system chunk with the size.
[2] The maximum size we support for now.
[3] The zone size is limited to these 11 cases, as it must be a power of 2.

Once we find the latest superblock, it is no different than reading a
regular btrfs image. You can further confirm the determined zone size by
comparing it with the size of a device extent because it is the same as the
zone size.

Actually, since the writing offset within the logging buffer is different
from the primary to copies [4], the timing when resetting the former zone
will become different. So, we can also try reading the head of the buffer
of a copy in case of missing superblock at offset 0.

[4] Because mkfs update the primary in the initial process, advancing only
the write pointer of the primary log buffer

## Superblock writing on an emulated zoned device

By mounting a regular device in zoned mode, btrfs emulates conventional
zones by slicing the device with a fixed size. In this case, however, we do
not follow the above rule of writing superblocks at the head of the logging
zones if they are conventional. Doing so would introduce a chicken-and-egg
problem. To know the given btrfs is zoned btrfs, we need to read a
superblock to see the incompatible flags. But, to read a superblock
properly from a zoned position, we need to know the file-system is zoned a
priori (e.g. resided in a zoned device), leading to a recursive dependency.

We can use the regular super block update method on an emulated zoned
device to break the recursion. Since the zones containing the regular
locations are always reserved, it is safe to do so. Then, we can naturally
read a regular superblock on a regular device and determine the file-system
is zoned or not.

Naohiro Aota (1):
  btrfs: zoned: move superblock logging zone location

 fs/btrfs/zoned.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

-- 
2.30.2

