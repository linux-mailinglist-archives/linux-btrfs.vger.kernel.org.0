Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B503B418E18
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 06:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhI0ERm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 00:17:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56793 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhI0ERm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 00:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632716165; x=1664252165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j4If32lWwt97s1tRc/6iK2Edg3p9niY7UCcZFY0Y330=;
  b=a/MtQnm8PoFiw8x3f4E0RxTgUyipotGCanB7XCe/sStzTPGbQu4X87VM
   y+GCg7jIw1BUszgEWyBTy5LwA+585vEEt61uHYhR0/yvUnZ7pFm1kkaPw
   r5WtotjJo+8DCJ0bDTI9x4XxSxDQ4MmHQBpll+WJHNs8rlpH2+5qkPFrL
   7++0hQYcnKmwevW6bHwXbr2BlRd+oCrw4IU3FFIHgaCrazseAlbmRt+Dz
   5zgp5xDygValmzWqqq0Ex66u23lUqrT84LW0ZagwHqt4KxBiyIoz518sO
   8g6MSgrxAGCpmb7MdFDxVuSuadbc3CBs8+jtRGuiWje3h9YmwlyRKc0Sm
   w==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="180095504"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 12:16:04 +0800
IronPort-SDR: Je2GLErd5h3Jm8csZK1vJtY8nnaeyzlRygMKtkuRtcYJp4DpfecKYJeN5ymkQLYhThVpbgv1NH
 GRAuLkGU9Ru+ZzNmSLqpE8qRe5f+WKhAKuSu8oZ3fBHpj1A8EUBvM3Ie/EITYp8YlEUcM/RqkD
 wdbZyqIMGGYrv9jG2S9rXMNoDlC3mk+tC6qQETKVjtxBBsj47EfQesRauEAMgnj4bsGm/vgUxH
 5ElwrnqQal9bJgBuPNYC0nkPJsTTMHnI47FIo03flW/NtQgD9ostpeOD0wnAYxwbmEh4nLB49t
 6zYPPa5uXg8T8pwTxzZEnlUw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 20:50:38 -0700
IronPort-SDR: kKxreRO9gxEuo0U6DOg6umiThOVUi0JCSPFi1F+0ZjDX9anHtXAhitGZfAkxQNg/EXODP0gxs2
 PgftTpucrrqv1Y3ns2MEXp+nONDggRMPWgMnjt+Ygsq5YnIoKkR+k4dtNemhCSCrNRnj+OzhS+
 l1zbsGOxxcBa/Jhda/h3S6k1wHelTm2BMOD/AvAkXx0hQaDUrG11lh5CYgFS+mmF5R410fZCVW
 pQKojjJCjU/MBrz7aEAgyEWkgquimqQVW8lNPRQDGj4neURhKBIEiwgm+M7tCZz63DkZ+gTOWI
 8xE=
WDCIronportException: Internal
Received: from 1r3v0f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2021 21:16:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Date:   Mon, 27 Sep 2021 13:15:49 +0900
Message-Id: <20210927041554.325884-1-naohiro.aota@wdc.com>
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

Patch 1 is a preparation not to set an emulated zone_size value when not
needed.

Patches 2 and 3 wraps pread/pwrite with newly introduced function
btrfs_pread/btrfs_pwrite.

Patches 4 deals with the zoned flag while reading the initial trees.

Patch 5 finally opens a zoned device with O_DIRECT.

Naohiro Aota (5):
  btrfs-progs: mkfs: do not set zone size on non-zoned mode
  btrfs-progs: introduce btrfs_pwrite wrapper for pwrite
  btrfs-progs: introduce btrfs_pread wrapper for pread
  btrfs-progs: temporally set zoned flag for initial tree reading
  btrfs-progs: use direct-IO for zoned device

 common/device-utils.c     | 76 ++++++++++++++++++++++++++++++++++++---
 common/device-utils.h     | 29 ++++++++++++++-
 kernel-shared/disk-io.c   | 19 +++++++++-
 kernel-shared/extent_io.c | 14 +++++---
 kernel-shared/volumes.c   |  4 +++
 kernel-shared/zoned.c     |  6 ++--
 mkfs/common.c             | 14 +++++---
 mkfs/main.c               | 12 +++++--
 8 files changed, 153 insertions(+), 21 deletions(-)

-- 
2.33.0

