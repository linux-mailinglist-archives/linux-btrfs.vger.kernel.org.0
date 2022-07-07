Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB38569941
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 06:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiGGEZl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 00:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiGGEZj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 00:25:39 -0400
Received: from out20-38.mail.aliyun.com (out20-38.mail.aliyun.com [115.124.20.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAA72FFE2
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 21:25:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04559524|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.657614-0.000173854-0.342212;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OM7olW5_1657167885;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OM7olW5_1657167885)
          by smtp.aliyun-inc.com;
          Thu, 07 Jul 2022 12:24:46 +0800
Date:   Thu, 07 Jul 2022 12:24:47 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH RFC 00/11] btrfs: introduce write-intent bitmaps for RAID56
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <cover.1657004556.git.wqu@suse.com>
References: <cover.1657004556.git.wqu@suse.com>
Message-Id: <20220707122446.98D1.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> [BACKGROUND]
> Unlike md-raid, btrfs RAID56 has nothing to sync its devices when power
> loss happens.
> 
> For pure mirror based profiles it's fine as btrfs can utilize its csums
> to find the correct mirror the repair the bad ones.
> 
> But for RAID56, the repair itself needs the data from other devices,
> thus any out-of-sync data can degrade the tolerance.
> 
> Even worse, incorrect RMW can use the stale data to generate P/Q,
> removing the possibility of recovery the data.
> 
> 
> For md-raid, it goes with write-intent bitmap, to do faster resilver,
> and goes journal (partial parity log for RAID5) to ensure it can even
> stand a powerloss + device lose.
> 
> [OBJECTIVE]
> 
> This patchset will introduce a btrfs specific write-intent bitmap.
> 
> The bitmap will locate at physical offset 1MiB of each device, and the
> content is the same between all devices.
> 
> When there is a RAID56 write (currently all RAID56 write, including full
> stripe write), before submitting all the real bios to disks,
> write-intent bitmap will be updated and flushed to all writeable
> devices.
> 
> So even if a powerloss happened, at the next mount time we know which
> full stripes needs to check, and can start a scrub for those involved
> logical bytenr ranges.
> 
> [NO RECOVERY CODE YET]
> 
> Unfortunately, this patchset only implements the write-intent bitmap
> code, the recovery part is still a place holder, as we need some scrub
> refactor to make it only scrub a logical bytenr range.
> 
> [ADVANTAGE OF BTRFS SPECIFIC WRITE-INTENT BITMAPS]
> 
> Since btrfs can utilize csum for its metadata and CoWed data, unlike
> dm-bitmap which can only be used for faster re-silver, we can fully
> rebuild the full stripe, as long as:
> 
> 1) There is no missing device
>    For missing device case, we still need to go full journal.
> 
> 2) Untouched data stays untouched
>    This should be mostly sane for sane hardware.
> 
> And since the btrfs specific write-intent bitmaps are pretty small (4KiB
> in size), the overhead much lower than full journal.
> 
> In the future, we may allow users to choose between just bitmaps or full
> journal to meet their requirement.
> 
> [BITMAPS DESIGN]
> 
> The bitmaps on-disk format looks like this:
> 
>  [ super ][ entry 1 ][ entry 2 ] ... [entry N]
>  |<---------  super::size (4K) ------------->|
> 
> Super block contains how many entires are in use.
> 
> Each entry is 128 bits (16 bytes) in size, containing one u64 for
> bytenr, and u64 for one bitmap.
> 
> And all utilized entries will be sorted in their bytenr order, and no
> bit can overlap.
> 
> The blocksize is now fixed to BTRFS_STRIPE_LEN (64KiB), so each entry
> can contain at most 4MiB, and the whole bitmaps can contain 224 entries.

Can we skip the write-intent bitmap log if we already log it in last N records
(logrotate aware) to improve the write performance?  because HDD sync
IOPS is very small.

And a bigger blocksize help this case too.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/07/07


> For the worst case, it can contain 14MiB dirty ranges.
> (1 bits set per bitmap, also means 2 disks RAID5 or 3 disks RAID6).
> 
> For the best case, it can contain 896MiB dirty ranges.
> (all bits set per bitmap)
> 
> [WHY NOT BTRFS BTREE]
> 
> Current write-intent structure needs two features:
> 
> - Its data needs to survive cross stripe boundary
>   Normally this means write-intent btree needs to acts like a proper
>   tree root, has METADATA_ITEMs for all its tree blocks.
> 
> - Its data update must be outside of a transaction
>   Currently only log tree can do such thing.
>   But unfortunately log tree can not survive across transaction
>   boundary.
> 
> Thus write-intent btree can only meet one of the requirement, not a
> suitable solution here.
> 
> [TESTING AND BENCHMARK]
> 
> For performance benchmark, unfortunately I don't have 3 HDDs to test.
> Will do the benchmark after secured enough hardware.
> 
> For testing, it can survive volume/raid/dev-replace test groups, and no
> write-intent bitmap leakage.
> 
> Unfortunately there is still a warning triggered in btrfs/070, still
> under investigation, hopefully to be a false alert in bitmap clearing
> path.
> 
> [TODO]
> - Scrub refactor to allow us to do proper recovery at mount time
>   Need to change scrub interface to scrub based on logical bytenr.
> 
>   This can be a super big work, thus currently we will focus only on
>   RAID56 new scrub interface for write-intent recovery only.
> 
> - Extra optimizations
>   * Skip full stripe writes
>   * Enlarge the window between btrfs_write_intent_mark_dirty() and
>     btrfs_write_intent_writeback()
> 
> - Bug hunts and more fstests runs
> 
> - Proper performance benchmark
>   Needs hardware/baremetal VMs, since I don't have any physical machine
>   large enough to contian 3 3.5" HDDs.
> 
> 
> Qu Wenruo (11):
>   btrfs: introduce new compat RO flag, EXTRA_SUPER_RESERVED
>   btrfs: introduce a new experimental compat RO flag,
>     WRITE_INTENT_BITMAP
>   btrfs: introduce the on-disk format of btrfs write intent bitmaps
>   btrfs: load/create write-intent bitmaps at mount time
>   btrfs: write-intent: write the newly created bitmaps to all disks
>   btrfs: write-intent: introduce an internal helper to set bits for a
>     range.
>   btrfs: write-intent: introduce an internal helper to clear bits for a
>     range.
>   btrfs: write back write intent bitmap after barrier_all_devices()
>   btrfs: update and writeback the write-intent bitmap for RAID56 write.
>   btrfs: raid56: clear write-intent bimaps when a full stripe finishes.
>   btrfs: warn and clear bitmaps if there is dirty bitmap at mount time
> 
>  fs/btrfs/Makefile          |   2 +-
>  fs/btrfs/ctree.h           |  24 +-
>  fs/btrfs/disk-io.c         |  54 +++
>  fs/btrfs/raid56.c          |  16 +
>  fs/btrfs/sysfs.c           |   2 +
>  fs/btrfs/volumes.c         |  34 +-
>  fs/btrfs/write-intent.c    | 962 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/write-intent.h    | 288 +++++++++++
>  fs/btrfs/zoned.c           |   8 +
>  include/uapi/linux/btrfs.h |  17 +
>  10 files changed, 1399 insertions(+), 8 deletions(-)
>  create mode 100644 fs/btrfs/write-intent.c
>  create mode 100644 fs/btrfs/write-intent.h
> 
> -- 
> 2.36.1


