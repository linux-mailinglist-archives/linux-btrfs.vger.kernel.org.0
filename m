Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2763616B840
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgBYD44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:56:56 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgBYD44 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603015; x=1614139015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uILRrPT6F2Uc0myrJ4A+oMV7zhLCTjHloANmC/48ydk=;
  b=SfdqhvnOx8uV7P40WkizyVZOJaRmrdDU2M+ghfvVkwdbmY+3wjzOArg4
   o28aTPYn+2GazK24RdJjFjbfzaJ6XcBm4WPTAeiJJdtWjZxmvu/TGsDq5
   nc34qeuQebVfF/SeuKjrR2V/ApBsfyfmCpCR856rQWyIn8M5tSSbQa8xY
   QpBKD3RZaCcESA+uU6CMIWf51Rk+thbpmTgoc2sQ7eIX+SsvQjfgL1uB8
   x1B73Vot5BAzZqi1WW4kesIlnxKD+4nQnSHxz7S4bgR96nzqQj4uFb3gp
   Rc9H18vttuGxF+2B955BXrSWdlV8i1S1YIuEDWLTTh8ImpChG6YIAnwL2
   Q==;
IronPort-SDR: MAQzQ1NJd0OtNHAPkfYasRd7V0HrVSGsNhAc4MttP8i94k1GbdachFnULOyizo3vn91PaL1ff3
 VE3h3s1rlsKxiTT7gz2b9ymnGnNjUeauhqo/O88wlp83q/Me+w4yIJ4vTQPH28fdiPQLVkuyy8
 mmBa2V3bsAXWFLnfNlzFy6re5K1U0Pkj0q/4JxsESsZheuVlkRMS9/QrTgoR5X7lflaTVMVbPq
 wH2BhuP5rH/HKUvjZ6KOa//OwNOmpdkhl7mcGM1KO4dX2/5+UvWeF8xgp1rkf+8l2GDq4vCGCU
 F/s=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168255"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:56:55 +0800
IronPort-SDR: UlCKseKzp75B0e3nGubJXwECD5Nu2NULOp9Rxl9Kwphpxg7uNEvoLhRYHm4Br/8y7fQg5uuF2f
 kD7YVSuAElhVemcl4YpWZw4qck80dslI0BZXTxJaHkDC8t3SLFwCU/ESVeEuEi0SKeW4ZXJCU9
 AT72rJjFBcwwWWFAF0viZ9u0wlIY4OORiYC9AR6QvAJQ87IiknCyqPqkLmu5gAT3adH+Q0uc3g
 BIpV7fWRssnhq3fRi3RqrojFh7Eu+4YCImG0JdUyVdcrBlV1LPXuioBANJGdmTBs4LrWBbKARc
 6U6J1Loax9bIRgWCuzfarS5y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:23 -0800
IronPort-SDR: P32aT38C78Fk0MNTjNGWOTpg31c4R/ao1Jd0GsBSgZWVEba6Ag+7w/MgUA74tmaJnQhrVJ4BvD
 z9IP3Tci0nXyNr0oXrCBNilAAu7KNEdvrVvKvYXlhMy/tYQH/cCEeTysLICE0V8XVJ3W12qctI
 IfYbfGY02j/s4WhHv/aZfOZ6SOYaQ0dBHTT348Kyva/a19Plnr1F9OB5xTd/62Hs5Wp0bnXPmu
 7zZs7ae8q7LGWKYEnJjpOVIdsyWL8c+cUItaQkYnO6Xjsb+4B6YLsReJ0HKj5pQ5z9A4uskDyU
 yQU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:56:55 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 00/21] btrfs: refactor and generalize chunk/dev_extent/extent allocation
Date:   Tue, 25 Feb 2020 12:56:05 +0900
Message-Id: <20200225035626.1049501-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series refactors chunk allocation, device_extent allocation and
extent allocation functions and make them generalized to be able to
implement other allocation policy easily.

On top of this series, we can simplify some part of the "btrfs: zoned
block device support" series as adding a new type of chunk allocator
and extent allocator for zoned block devices. Furthermore, we will be
able to implement and test some other allocator in the idea page of
the wiki e.g. SSD caching, dedicated metadata drive, chunk allocation
groups, and so on.

This series has no functional changes except introducing "enum
btrfs_chunk_allocation_policy" and "enum
btrfs_extent_allocation_policy".

* Refactoring chunk/dev_extent allocator

Two functions are separated from find_free_dev_extent_start().
dev_extent_search_start() decides the starting position of the search.
dev_extent_hole_check() checks if a hole found is suitable for device
extent allocation.

__btrfs_alloc_chunk() is split into four functions. set_parameters()
initializes the parameters of an allocation. gather_device_info()
loops over devices and gather information of
them. decide_stripe_size() decides the size of chunk and
device_extent. And, create_chunk() creates a chunk and device extents.

* Refactoring extent allocator

Three functions are introduced in
find_free_extent(). prepare_allocation() initializes the parameters
and gives a hint byte to start the allocation with. do_allocation()
handles the actual allocation in a given block group.
release_block_group() is called when it gives up an allocation from a
block group, so the allocation context should be reset.

Two functions are introduced in find_free_extent_update_loop().
found_extent() is called when the allocator finally find a proper
extent. chunk_allocation_failed() is called when it failed to allocate
a new chunk. An allocator implementation can use this hook to set the
next stage to try e.g. LOOP_NO_EMPTY_SIZE.

Furthermore, LOOP_NO_EMPTY_SIZE stage is tweaked so that other
allocator than the current clustered allocator skips this stage.

* Patch organization

Patch 1 is a trivial patch to fix the type of an argument of
find_free_extent_update_loop().

Patch 2 removes a BUG_ON from __btrfs_alloc_chunk().

Patches 3-10 refactors chunk and device_extent allocation functions:
find_free_dev_extent_start() and __btrfs_alloc_chunk().

Patches 11-21 refactors extent allocation function: find_free_extent()
and find_free_extent_update_loop().

* Changelog

 - v3
   - Fix handling of btrfs_chunk_alloc()'s return value
   - Drop LOOP_GIVEUP, which is not currently useful
   - Convert another BUG_ON to ASSERT and -EINVAL in patch 6
   - Subtle typo and wording fix

 - v2
   - Stop separating "clustered_alloc_info" from find_free_extent_ctl
   - Change return type of dev_extent_hole_check() to bool
   - Rename set_parameters() to init_alloc_chunk_ctl()
   - Add a patch to remove BUG_ON from __btrfs_alloc_chunk()

Naohiro Aota (21):
  btrfs: change type of full_search to bool
  btrfs: do not BUG_ON with invalid profile
  btrfs: introduce chunk allocation policy
  btrfs: refactor find_free_dev_extent_start()
  btrfs: introduce alloc_chunk_ctl
  btrfs: factor out init_alloc_chunk_ctl
  btrfs: factor out gather_device_info()
  btrfs: factor out decide_stripe_size()
  btrfs: factor out create_chunk()
  btrfs: parameterize dev_extent_min
  btrfs: introduce extent allocation policy
  btrfs: move hint_byte into find_free_extent_ctl
  btrfs: move variables for clustered allocation into
    find_free_extent_ctl
  btrfs: factor out do_allocation()
  btrfs: drop unnecessary arguments from clustered allocation functions
  btrfs: factor out release_block_group()
  btrfs: factor out found_extent()
  btrfs: drop unnecessary arguments from find_free_extent_update_loop()
  btrfs: factor out chunk_allocation_failed()
  btrfs: skip LOOP_NO_EMPTY_SIZE if not clustered allocation
  btrfs: factor out prepare_allocation()

 fs/btrfs/extent-tree.c | 313 +++++++++++++++++++++-----------
 fs/btrfs/volumes.c     | 399 +++++++++++++++++++++++++++--------------
 fs/btrfs/volumes.h     |   6 +
 3 files changed, 481 insertions(+), 237 deletions(-)

-- 
2.25.1

