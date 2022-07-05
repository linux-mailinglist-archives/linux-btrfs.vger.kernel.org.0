Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880F9566451
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGEHjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiGEHje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:39:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43945FA
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:39:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05BE22249A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mG/pY01DXxAXPQ39CC3AGv7ub7UnyP+Vd/Chw9Kj10E=;
        b=MTdzyrLvs8rwo+SO1gdYj1sWqLaYdXEd78jzbXF/i0Pmrigmt3id5C7pyMgUX8g5v1GShm
        zjdYLYKu/vWTe9MuAQDoD2qScuBS/71KmjqlpYkVyDnlDIDsTYYf5QlIjgqV0fnIdMZAX7
        nGXdwVmumIsXajSCLItEnk7z2wGcol8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 582571339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jWLQCLPqw2L6OwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:39:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 00/11] btrfs: introduce write-intent bitmaps for RAID56
Date:   Tue,  5 Jul 2022 15:39:02 +0800
Message-Id: <cover.1657004556.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
Unlike md-raid, btrfs RAID56 has nothing to sync its devices when power
loss happens.

For pure mirror based profiles it's fine as btrfs can utilize its csums
to find the correct mirror the repair the bad ones.

But for RAID56, the repair itself needs the data from other devices,
thus any out-of-sync data can degrade the tolerance.

Even worse, incorrect RMW can use the stale data to generate P/Q,
removing the possibility of recovery the data.


For md-raid, it goes with write-intent bitmap, to do faster resilver,
and goes journal (partial parity log for RAID5) to ensure it can even
stand a powerloss + device lose.

[OBJECTIVE]

This patchset will introduce a btrfs specific write-intent bitmap.

The bitmap will locate at physical offset 1MiB of each device, and the
content is the same between all devices.

When there is a RAID56 write (currently all RAID56 write, including full
stripe write), before submitting all the real bios to disks,
write-intent bitmap will be updated and flushed to all writeable
devices.

So even if a powerloss happened, at the next mount time we know which
full stripes needs to check, and can start a scrub for those involved
logical bytenr ranges.

[NO RECOVERY CODE YET]

Unfortunately, this patchset only implements the write-intent bitmap
code, the recovery part is still a place holder, as we need some scrub
refactor to make it only scrub a logical bytenr range.

[ADVANTAGE OF BTRFS SPECIFIC WRITE-INTENT BITMAPS]

Since btrfs can utilize csum for its metadata and CoWed data, unlike
dm-bitmap which can only be used for faster re-silver, we can fully
rebuild the full stripe, as long as:

1) There is no missing device
   For missing device case, we still need to go full journal.

2) Untouched data stays untouched
   This should be mostly sane for sane hardware.

And since the btrfs specific write-intent bitmaps are pretty small (4KiB
in size), the overhead much lower than full journal.

In the future, we may allow users to choose between just bitmaps or full
journal to meet their requirement.

[BITMAPS DESIGN]

The bitmaps on-disk format looks like this:

 [ super ][ entry 1 ][ entry 2 ] ... [entry N]
 |<---------  super::size (4K) ------------->|

Super block contains how many entires are in use.

Each entry is 128 bits (16 bytes) in size, containing one u64 for
bytenr, and u64 for one bitmap.

And all utilized entries will be sorted in their bytenr order, and no
bit can overlap.

The blocksize is now fixed to BTRFS_STRIPE_LEN (64KiB), so each entry
can contain at most 4MiB, and the whole bitmaps can contain 224 entries.

For the worst case, it can contain 14MiB dirty ranges.
(1 bits set per bitmap, also means 2 disks RAID5 or 3 disks RAID6).

For the best case, it can contain 896MiB dirty ranges.
(all bits set per bitmap)

[WHY NOT BTRFS BTREE]

Current write-intent structure needs two features:

- Its data needs to survive cross stripe boundary
  Normally this means write-intent btree needs to acts like a proper
  tree root, has METADATA_ITEMs for all its tree blocks.

- Its data update must be outside of a transaction
  Currently only log tree can do such thing.
  But unfortunately log tree can not survive across transaction
  boundary.

Thus write-intent btree can only meet one of the requirement, not a
suitable solution here.

[TESTING AND BENCHMARK]

For performance benchmark, unfortunately I don't have 3 HDDs to test.
Will do the benchmark after secured enough hardware.

For testing, it can survive volume/raid/dev-replace test groups, and no
write-intent bitmap leakage.

Unfortunately there is still a warning triggered in btrfs/070, still
under investigation, hopefully to be a false alert in bitmap clearing
path.

[TODO]
- Scrub refactor to allow us to do proper recovery at mount time
  Need to change scrub interface to scrub based on logical bytenr.

  This can be a super big work, thus currently we will focus only on
  RAID56 new scrub interface for write-intent recovery only.

- Extra optimizations
  * Skip full stripe writes
  * Enlarge the window between btrfs_write_intent_mark_dirty() and
    btrfs_write_intent_writeback()

- Bug hunts and more fstests runs

- Proper performance benchmark
  Needs hardware/baremetal VMs, since I don't have any physical machine
  large enough to contian 3 3.5" HDDs.


Qu Wenruo (11):
  btrfs: introduce new compat RO flag, EXTRA_SUPER_RESERVED
  btrfs: introduce a new experimental compat RO flag,
    WRITE_INTENT_BITMAP
  btrfs: introduce the on-disk format of btrfs write intent bitmaps
  btrfs: load/create write-intent bitmaps at mount time
  btrfs: write-intent: write the newly created bitmaps to all disks
  btrfs: write-intent: introduce an internal helper to set bits for a
    range.
  btrfs: write-intent: introduce an internal helper to clear bits for a
    range.
  btrfs: write back write intent bitmap after barrier_all_devices()
  btrfs: update and writeback the write-intent bitmap for RAID56 write.
  btrfs: raid56: clear write-intent bimaps when a full stripe finishes.
  btrfs: warn and clear bitmaps if there is dirty bitmap at mount time

 fs/btrfs/Makefile          |   2 +-
 fs/btrfs/ctree.h           |  24 +-
 fs/btrfs/disk-io.c         |  54 +++
 fs/btrfs/raid56.c          |  16 +
 fs/btrfs/sysfs.c           |   2 +
 fs/btrfs/volumes.c         |  34 +-
 fs/btrfs/write-intent.c    | 962 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/write-intent.h    | 288 +++++++++++
 fs/btrfs/zoned.c           |   8 +
 include/uapi/linux/btrfs.h |  17 +
 10 files changed, 1399 insertions(+), 8 deletions(-)
 create mode 100644 fs/btrfs/write-intent.c
 create mode 100644 fs/btrfs/write-intent.h

-- 
2.36.1

