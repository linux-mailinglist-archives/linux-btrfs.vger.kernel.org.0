Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C215658E020
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 21:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbiHITYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 15:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242993AbiHITYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 15:24:23 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F51CA8
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 12:24:22 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 3B57349009E; Tue,  9 Aug 2022 15:24:09 -0400 (EDT)
Date:   Tue, 9 Aug 2022 15:24:08 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
Message-ID: <YvK0WPtEVzXwv3p1@hungrycats.org>
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
 <YvIbB5l4gtG4f/S9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvIbB5l4gtG4f/S9@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 09, 2022 at 01:29:59AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 08, 2022 at 11:31:51PM -0400, Zygo Blaxell wrote:
> > There is now a BUG_ON arising from this test case:
> > 
> > 	[  241.051326][   T45] btrfs_print_data_csum_error: 156 callbacks suppressed
> > 	[  241.100910][   T45] ------------[ cut here ]------------
> > 	[  241.102531][   T45] kernel BUG at fs/btrfs/extent_io.c:2350!
> 
> This
> 
>         BUG_ON(!mirror_num);
> 
> so repair_io_failure gets called with a mirror_num of 0..
> 
> > 	[  241.128354][   T45]  clean_io_failure+0x21a/0x260
> 
> .. from clean_io_failure.  Which starts from failrec->this_mirror and
> tries to go back to failrec->failed_mirror using the prev_mirror
> helper.  prev_mirror looks like:
> 
> static int prev_mirror(const struct io_failure_record *failrec, int cur_mirror)
> {
>         if (cur_mirror == 1)
> 		return failrec->num_copies;
> 	return cur_mirror - 1;
> }
> 
> So the only way we could end up with a mirror = 0 is if
> failrec->num_copies is 0.  -failrec->num_copies is initialized
> in btrfs_get_io_failure_record by doing:
> 
>         failrec->num_copies = btrfs_num_copies(fs_info, failrec->logical, sectorsize);
> 
> just adter allocating the failrec.  I can't see any obvious way how
> btrfs_num_copies would return 0, though, as for raid5 it just copies
> from btrfs_raid_array.

Judging from prior raid5 testing behavior, it looks like there's a race
condition specific to btrfs raid5 IO.  Previous kernel versions have had
assorted UAF bugs from time to time that KASAN tripped over, and btrfs
replace almost never works on the first try on a real raid5 array.
These issues were reported years ago, but nobody seems to have been
working on them until recently.

A similar test setup previously produced data corruption during raid5
recovery, even on an otherwise idle filesystem, at a low rate (~1
error per 100 GB).  I expect whatever bug was leading to that hasn't
been entirely fixed yet.

> Any chance you could share a script for your reproducer?

The simplest reproducer is some variant of:

	mkfs.btrfs -draid5 -mraid1 /dev/vdb /dev/vdc /dev/vdd
	mount /dev/vdb /mnt -ocompress=zstd,noatime
	cd /mnt
	cp -a /40gb-test-data .
	sync
	while true; do
		find -type f -exec cat {} + > /dev/null
	done &
	while true; do
		cat /dev/zero > /dev/vdb
	done &
	while true; do
		btrfs scrub start -Bd /mnt
	done &
	wait

but it can take a long time to hit a failure with something that gentle.
I throw on some extra test workload (e.g. lots of rsyncs) to keep the
page cache full and under memory pressure, which seems to speed up the
failure rate to once every few hours.
