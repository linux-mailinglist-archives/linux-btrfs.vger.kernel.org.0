Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC18421ECD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhJEGZS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:25:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61147 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEGZR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633415007; x=1664951007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZuoKY84wBCUqxtvuMCgQpL4XzmVoYsJkV/UfU9sv/Q4=;
  b=ieKXuFhpyW417OXublqj3YGvKgn3kEZ6HnwoADRSECBvjEK8izh2NJQs
   K77ZVTtslnRzywQ+lRp7C12Ba/xsYjWB1PV00PiwvzFbppsskTX1mUmM2
   xqW1F2/KnSTDjDmaRCUlztwKLMlpHxTFlSmQ/nzcbgIOxyCdOUO/tQI0M
   MPRh+Y2ZhtOwPLm/AQVQejc6pbsOhg0ZNS80GjtWjgNOHUUxY1nCdnxq4
   NGnETwmvGR5fHCzvSIGOIhFLS3cMq80sYn/WZoshGVNFwY6Uo4e7IiG9V
   VznbutugMQJL3yZ0+uQ0vpS8X0nd+P0HZDH6inFVFlVY3V7DnMrHAWLX/
   A==;
X-IronPort-AV: E=Sophos;i="5.85,347,1624291200"; 
   d="scan'208";a="186648909"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2021 14:23:27 +0800
IronPort-SDR: 3eksaIUJ1idVcxIBMapEsA1A+92P+ZGLXQuALSU4RPRdtdBY1oz4K5cUETb51QIgE4/e7/9VhM
 rWXUsfXoTbyW/dI4Rc5SZ+j3txiA0BYbKMV25R3eYqwYPpSyfCqNtB42CHmdxvFiQ9m8bNnkLA
 AP8/SpGCl9IlJ6ZSnxAeLnSdjasNqdRXX+rDVrbxwjIyCWwnKLoiPZIsKjxULtxWIFf1FPGui9
 O+w3ZVRAGdX0GfrCvJE0uOzkgucWUdy75iydpdIta2dJCQtuO3vPKpDJXEliUnPtxRLzUV7FpZ
 XfdYgYbEyZBShxjR/xDtZkdX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 22:57:51 -0700
IronPort-SDR: Gs3ua5bM5095mmJZbeuTzvyJCNtP5aJ2QCYlE8+zTbeh9VJ+lv4zhAzsoG57FLM+0MkHM2mil+
 wE+NMftOklHlgxtDml5NkmHqEn0g/GCeL5lOaTJIsQEnRVqR77ljHNCqm91q+aCzzQvAuOzE4i
 Usjmjmv4zOFp+yAdi6VP9UAnRkDiM9CenRitrVZqpExbwBfebgkYOXQwBdoIiJBMxGYpUdxfQv
 NJDM9p/UFHd1qCl1efgZyqVXe1GG3K/asIgt6oqHQRKt3KeUj6aYBtFgiVV8/NmJgna2tsMUnz
 9As=
WDCIronportException: Internal
Received: from g8961f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2021 23:23:27 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/7] btrfs-progs: use direct-IO for zoned device
Date:   Tue,  5 Oct 2021 15:22:58 +0900
Message-Id: <20211005062305.549871-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As discussed in the Zoned Storage page [1],  the kernel page cache does not
guarantee that cached dirty pages will be flushed to a block device in
sequential sector order. Thus, we must use O_DIRECT for writing to a zoned
device to ensure the write ordering.

[1] https://zonedstorage.io/linux/overview/#zbd-support-restrictions

As a writng buffer is embedded in some other struct (e.g., "char data[]" in
struct extent_buffer), it is difficult to allocate the struct so that the
writng buffer is aligned.

This series introduces btrfs_{pread,pwrite} to wrap around pread/pwrite,
which allocates an aligned bounce buffer, copy the buffer contents, and
proceeds the IO. And, it now opens a zoned device with O_DIRECT.

Since the allocation and copying are costly, it is better to do them only
when necessary. But, it is cumbersome to call fcntl(F_GETFL) to determine
the file is opened with O_DIRECT or not every time doing an IO.

As zoned device forces to use zoned btrfs, I decided to use the zoned flag
to determine if it is direct-IO or not. This can cause a false-positive (to
use the bounce buffer when a file is *not* opened with O_DIRECT) in case of
emulated zoned mode on a non-zoned device or a regular file. Considering
the emulated zoned mode is mostly for debugging or testing, I believe this
is acceptable.

* Changes
v2
  - Rebased on the latest "devel" branch
  - Add patch to fix segfault in several cases
  - drop ZONED flag from BTRFS_CONVERT_ALLOWED_FEATURES

Patches 1 to 3 are preparation to fix some issues in the current code.

Patches 4 and 5 wraps pread/pwrite with newly introduced function
btrfs_pread/btrfs_pwrite.

Patch 6 deals with the zoned flag while reading the initial trees.

Patch 7 finally opens a zoned device with O_DIRECT.

Naohiro Aota (7):
  btrfs-progs: mkfs: do not set zone size on non-zoned mode
  btrfs-progs: set eb->fs_info properly
  btrfs-progs: drop ZONED flag from BTRFS_CONVERT_ALLOWED_FEATURES
  btrfs-progs: introduce btrfs_pwrite wrapper for pwrite
  btrfs-progs: introduce btrfs_pread wrapper for pread
  btrfs-progs: temporally set zoned flag for initial tree reading
  btrfs-progs: use direct-io for zoned device

 common/device-utils.c     | 76 ++++++++++++++++++++++++++++++++++++---
 common/device-utils.h     | 29 ++++++++++++++-
 common/fsfeatures.h       |  3 +-
 convert/main.c            |  1 +
 kernel-shared/disk-io.c   | 19 +++++++++-
 kernel-shared/extent_io.c | 14 +++++---
 kernel-shared/volumes.c   |  6 ++++
 kernel-shared/zoned.c     |  6 ++--
 mkfs/common.c             | 14 +++++---
 mkfs/main.c               | 12 +++++--
 mkfs/rootdir.c            |  1 +
 11 files changed, 158 insertions(+), 23 deletions(-)

-- 
2.33.0

