Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F463973BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 15:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhFAND7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 09:03:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2437 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFAND7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 09:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622552537; x=1654088537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K51YucXN1SDaJeq05L+F9kuzqV/n5/TLR9iFKMsbsiI=;
  b=V4g0XZMgNAQqHoMKM0ky1wCMmGSSbhX03bJ1cUTbJSlr+5e2QqeK7x1I
   DiXTXJd8IYY0YwKULHBjMVPHZghrNpEqRNYFzeTOAmRIFJ5xvuXADP8w8
   fH9PS1NxsGGowyAzuFINcF3malXNJ5inZI9nWOPsaBW206j10q49FP2+M
   LxZKlpTZyxiN64CsvTYu8fXYQSH1Z9dstXevQewxxdjrYXiJfD3d4MOvQ
   PWR0Ao4fJ7nJiQJkHlf2dgabXf0oQiKjM2GxIrAcF1XeFF/kyAB/6inek
   0j7VHFcigyVUDYKPaQ27FrTn/rO3QhRHIDDqjBdckblcxSojm8OkfLopC
   A==;
IronPort-SDR: Oxhtao4emKnrBuAwRBQbvKljnxBdiG0RtvLsgp5IwZktzKWxU52LDeaXtj+mWnfrEQUbtWzc9Q
 NIFi9A/mTMTqGRC9FUDsaoslPvtu7Il3uyKth/l0ipHirueBpDXzj5DyyID1RWO5TeeO+M9NrU
 nRjGR2bFEOeZ6UR1KAIDiKimOpofVkjPOZW+wtYFndH0ydSC2peMM9lsSlJ5BiZ/fXiK4MwvHE
 /sEu8aLfVDk3FFTR95h/K+DbaGJ3h3J/UCYn2rTfJPkCrcEteJ6GBexbBhbOgAa92m/isPSJ3D
 4RM=
X-IronPort-AV: E=Sophos;i="5.83,239,1616428800"; 
   d="scan'208";a="174991974"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2021 21:02:17 +0800
IronPort-SDR: 8JqpI98VhmgzbhhyEo6L1lBcuuew3we0s8SYzavx+YeNZFJT6s9y3dhO3tHrS0DG9Bgzig/Xa8
 pnfzTZ5jol55KASZXoA2U96nXD8X43sTCs9omulrbke/eE29u7O126IxwB1yLMgIcdCbHFKYHQ
 J3m1ymnW5EROL/s1mnVzGywLTB9Q6vrB8PjVkLQQKYlXz/d436HVGDb3d9HHA1XmUOKJYiBrg0
 Rg+jFSUOvX3tSyis7L9tlr8wRSVnx39kTdppFH0kHZ7h8GfYlF3JTHIoqYDZZQN+FS8bQ6REJB
 iZYnOWxxoQpwwfDsQAMGSsD/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 05:40:10 -0700
IronPort-SDR: DOeyK+s3+KxfeF8k7kCsiUqkSb8clMHFjGg/A45Lb/J32MnNPmvfesAPjxTwcyDvPMefpdo75I
 EM6pmawrwjjYkqnQPzUxpHerwhHcmv/HStwaA8PgZSHUAYje9dG2Q3r6mWCnDTtOvdMecG9iXi
 ZWTpNGkNU41HQAufpXNV7rz6Fci5NeGa3CGAIuUDoLZsdeHncUXRyrHcbDJwccQf4EqtCL8hL+
 YVIYCHKclYnJfARW15Uhuo1LnipBpqIYweEMOYWhqJ+zImQWNQRfZ2j4Af48ucYq8bj4NjIReJ
 zRg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2021 06:02:16 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: zoned: limit max extent size to max zone append
Date:   Tue,  1 Jun 2021 22:02:08 +0900
Message-Id: <cover.1622552385.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The first patch factors out retrieving BTRFS_MAX_EXTENT_SIZE into a helper and
the second patch fixes the actual problem for zoned btrfs.

Johannes Thumshirn (2):
  btrfs: add a helper for retrieving BTRFS_MAX_EXTENT_SIZE
  btrfs: zoned: limit ordered extent to zoned append size

 fs/btrfs/ctree.h                 | 26 ++++++++++++++++++--------
 fs/btrfs/delalloc-space.c        |  6 +++---
 fs/btrfs/extent_io.c             |  2 +-
 fs/btrfs/inode.c                 | 22 ++++++++++++----------
 fs/btrfs/tests/extent-io-tests.c |  2 +-
 fs/btrfs/tests/inode-tests.c     | 31 ++++++++++++++++---------------
 6 files changed, 51 insertions(+), 38 deletions(-)

-- 
2.31.1

