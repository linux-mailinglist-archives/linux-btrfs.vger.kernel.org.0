Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B04091554D9
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 10:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgBGJjG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 04:39:06 -0500
Received: from mail.synology.com ([211.23.38.101]:60584 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbgBGJjG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 04:39:06 -0500
From:   ethanwu <ethanwu@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1581068343; bh=GsUfnREs6CiEEfvBy8qnT0Lxg/buKiHcNgwTslkTtv0=;
        h=From:To:Cc:Subject:Date;
        b=TnUtM4uIw/p2pfXp4GVPdfWV7uuAxUg8CDrYyAZxXnZeYJCEUYXl7WusDNl7bk788
         lveQLQq9lI5JOdCleH7dmWHPw/E7G9F45xzkFNvXzySL1/TnQoxGp0Y3GxtUZ0Sgqb
         lNAN9287z6krf2kZdv0Bm3E6Iucx+iEmMiVD0H00=
To:     linux-btrfs@vger.kernel.org
Cc:     ethanwu <ethanwu@synology.com>
Subject: [PATCH 0/4] btrfs: improve normal backref walking
Date:   Fri,  7 Feb 2020 17:38:14 +0800
Message-Id: <20200207093818.23710-1-ethanwu@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs has two types of data backref.
For BTRFS_EXTENT_DATA_REF_KEY type of backref, we don't have the
exact block number. Therefore, we need to call resolve_indirect_refs.
It uses btrfs_search_slot to locate the leaf block. Then
we need to walk through the leaves to search for the EXTENT_DATA items
that have disk bytenr matching the extent item(add_all_parents).

When resolving indirect refs, we could take entries that don't
belong to the backref entry we are searching for right now.
For that reason when searching backref entry, we always use total
refs of that EXTENT_ITEM rather than individual count.

For example:
item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize
  extent refs 24 gen 7302 flags DATA
  shared data backref parent 394985472 count 10 #1
  extent data backref root 257 objectid 260 offset 1048576 count 3 #2
  extent data backref root 256 objectid 260 offset 65536 count 6 #3
  extent data backref root 257 objectid 260 offset 65536 count 5 #4

For example, when searching backref entry #4, we'll use total_refs
24, a very loose loop ending condition, instead of total_refs = 5.

But using total_refs=24 is not accurate. Sometimes, we'll never find
all the refs from specific root.
As a result, the loop keeps on going until we reach the end of that inode.

The first 3 patches, handle 3 different types refs we might encounter.
These refs do not belong to the normal backref we are searching, and
hence need to be skipped.

The last patch changes the total_refs to correct number so that we could
end loop as soon as we find all the refs we want.

btrfs send uses backref to find possible clone sources, the following
is a simple test to compare the results with and without this patch

btrfs subvolume create /volume1/sub1
for i in `seq 1 163840`; do dd if=/dev/zero of=/volume1/sub1/file bs=64K count=1 seek=$((i-1)) conv=notrunc oflag=direct 2>/dev/null; done
btrfs subvolume snapshot /volume1/sub1 /volume1/sub2
for i in `seq 1 163840`; do dd if=/dev/zero of=/volume1/sub1/file bs=4K count=1 seek=$(((i-1)*16+10)) conv=notrunc oflag=direct 2>/dev/null; done
btrfs subvolume snapshot -r /volume1/sub1 /volume1/snap1
time btrfs send /volume1/snap1 | btrfs receive /volume2

without this patch
real 69m48.124s
user 0m50.199s
sys  70m15.600s

with this patch
real    1m59.683s
user    0m35.421s
sys     2m42.684s


ethanwu (4):
  btrfs: backref, only collect file extent items matching backref offset
  btrfs: backref, not adding refs from shared block when resolving
    normal backref
  btrfs: backref, only search backref entries from leaves of the same
    root
  btrfs: backref, use correct count to resolve normal data refs

 fs/btrfs/backref.c | 156 +++++++++++++++++++++++++++++----------------
 1 file changed, 100 insertions(+), 56 deletions(-)

-- 
2.17.1

