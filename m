Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95090549BCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbiFMSj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345810AbiFMSi7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 14:38:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21567CEF
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 08:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB6C0B80D3A
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 15:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35B2C34114;
        Mon, 13 Jun 2022 15:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655134401;
        bh=HVDN9ICidX+gzni0KEleENeRdU+P5lBtMSgEA1otSNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVSU4JFME3ez+a/RFHuQz6YVKlmGldPlb/NLZsXLAf0ATY7/A+eDyTLDOEYdQbz6m
         MZyJ5mQSnvSbzeOP0aufIywiTqjbPAgGyaWIR3iuhlNMLMSfxkSrQeuLcfgO15Nkrz
         gobwldVvtIPQlTfHlcr/QoyZ9nXTE2kEmhPV5F3YnnZc5pJImgCEYOak4HJc3AD5vW
         KXYKRULAcVr01Of6yhoxhAI7CylAyTAvNsSITtgdjhvQaODa8BtOTcbynFZyTHT8cD
         Z+I3BZm+IiHCxWwlZWdedG7ERyRLnY8DJtAUUBan20wKLTlmPoCeSHdgNocMpd6+GW
         la6fnEO86DW4w==
Date:   Mon, 13 Jun 2022 16:33:18 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Message-ID: <20220613153318.GA3829367@falcondesktop>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
 <PH0PR04MB741660777362929B7E3D11DB9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220519133850.GA2735952@falcondesktop>
 <20220613122110.6pg6q274wy4er7ri@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613122110.6pg6q274wy4er7ri@naota-xeon>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 12:21:11PM +0000, Naohiro Aota wrote:
> On Thu, May 19, 2022 at 02:38:50PM +0100, Filipe Manana wrote:
> > On Thu, May 19, 2022 at 12:24:00PM +0000, Johannes Thumshirn wrote:
> > > What's the status of this patch? It fixes actual errors 
> > > (hung_tasks) for me.
> > 
> > Well, there was previous review about it, and nothing was addressed in the
> > meanwhile.
> > 
> > It may happen to fix the hang for some test case for fstests on zoned mode.
> > But there's a fundamental problem with the error handling as Josef pointed
> > before - this is an existing problem, and not a problem with this patch or
> > exclusive to zoned mode.
> > 
> > The problem is if we fail on the second iteration of the while loop, when
> > reserving an extent for example, we leave the loop and with an ordered
> > extent created in the previous iteration, and return an error to the caller.
> > After that we end up never submitting a bio for that ordered extent's range,
> > which means we end up with an ordered extent that will never be completed.
> > So something like an fsync after that will hang forever for example, or
> > anything else calling btrfs_wait_ordered_range().
> 
> I'm recently revisiting this patch and I think this is not true. The
> ordered extents instantiated in the previous loops (before an error by
> btrfs_reserve_extent) are then cleaned up by
> btrfs_cleanup_ordered_extents() calling in btrfs_run_delalloc_range(), no?
> So, btrfs_wait_ordered_range() never hang for the ordered extents.

You are right, we are doing the proper cleanup of ordered extents.
I missed that we had this function btrfs_cleanup_ordered_extents() that is
run for all delalloc cases. In older days we had that only for the error
path of direct IO writes, but it was later refactored and added for the
dealloc cases too. And I had the very old days in my mind, sorry.

> 
> Well, there is a path not calling btrfs_cleanup_ordered_extents(), which is
> submit_uncompressed_range(). So, this path needs to call it.

Sounds right.

> 
> Or should we do the clean-up within cow_file_range()? It is more
> understandable to clean the extents where it is created in the error
> case. But then, run_delalloc_nocow() should also clean the ordered extents
> created by itself (BTRFS_ORDERED_PREALLOC or BTRFS_ORDERED_NOCOW extents).

I think it's fine as it is.
In case it confuses someone, we could just leave a comment at cow_file_range(),
etc, telling we do cleanup of previously created ordered extents at
btrfs_run_delalloc_range().


> 
> > So on error we need to go through previously created ordered extents, set
> > the IOERR flag on them, complete them to wake up any waiters and remove it,
> > which also takes care or adding the reserved extent back to the free space
> > cache/tree.
> 
> I think this is exactly done by btrfs_cleanup_ordered_extents() +
> end_extent_writepage() in __extent_writepage(). No?
> 
> So, in the end, we just need to unlock the pages except locked_page in the
> error case.

So I'm back to my initial review, where everything seems fine except for
the small mistake in the comment.

Thanks.

> 
> > 
> > 
> > > 
> > > On 13/12/2021 04:43, Naohiro Aota wrote:
> > > > There is a hung_task report regarding page lock on zoned btrfs like below.
> > > > 
> > > > https://github.com/naota/linux/issues/59
> > > > 
> > > > [  726.328648] INFO: task rocksdb:high0:11085 blocked for more than 241 seconds.
> > > > [  726.329839]       Not tainted 5.16.0-rc1+ #1
> > > > [  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > [  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085 ppid: 11082 flags:0x00000000
> > > > [  726.331608] Call Trace:
> > > > [  726.331611]  <TASK>
> > > > [  726.331614]  __schedule+0x2e5/0x9d0
> > > > [  726.331622]  schedule+0x58/0xd0
> > > > [  726.331626]  io_schedule+0x3f/0x70
> > > > [  726.331629]  __folio_lock+0x125/0x200
> > > > [  726.331634]  ? find_get_entries+0x1bc/0x240
> > > > [  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40
> > > > [  726.331642]  truncate_inode_pages_range+0x5b2/0x770
> > > > [  726.331649]  truncate_inode_pages_final+0x44/0x50
> > > > [  726.331653]  btrfs_evict_inode+0x67/0x480
> > > > [  726.331658]  evict+0xd0/0x180
> > > > [  726.331661]  iput+0x13f/0x200
> > > > [  726.331664]  do_unlinkat+0x1c0/0x2b0
> > > > [  726.331668]  __x64_sys_unlink+0x23/0x30
> > > > [  726.331670]  do_syscall_64+0x3b/0xc0
> > > > [  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > [  726.331677] RIP: 0033:0x7fb9490a171b
> > > > [  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
> > > > [  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb9490a171b
> > > > [  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 00007fb94400d300
> > > > [  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 0000000000000000
> > > > [  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 00007fb943ffb000
> > > > [  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 00007fb943ffd260
> > > > [  726.331693]  </TASK>
> > > > 
> > > > While we debug the issue, we found running fstests generic/551 on 5GB
> > > > non-zoned null_blk device in the emulated zoned mode also had a
> > > > similar hung issue.
> > > > 
> > > > The hang occurs when cow_file_range() fails in the middle of
> > > > allocation. cow_file_range() called from do_allocation_zoned() can
> > > > split the give region ([start, end]) for allocation depending on
> > > > current block group usages. When btrfs can allocate bytes for one part
> > > > of the split regions but fails for the other region (e.g. because of
> > > > -ENOSPC), we return the error leaving the pages in the succeeded regions
> > > > locked. Technically, this occurs only when @unlock == 0. Otherwise, we
> > > > unlock the pages in an allocated region after creating an ordered
> > > > extent.
> > > > 
> > > > Theoretically, the same issue can happen on
> > > > submit_uncompressed_range(). However, I could not make it happen even
> > > > if I modified the code to go always through
> > > > submit_uncompressed_range().
> > > > 
> > > > Considering the callers of cow_file_range(unlock=0) won't write out
> > > > the pages, we can unlock the pages on error exit from
> > > > cow_file_range(). So, we can ensure all the pages except @locked_page
> > > > are unlocked on error case.
> > > > 
> > > > In summary, cow_file_range now behaves like this:
> > > > 
> > > > - page_started == 1 (return value)
> > > >   - All the pages are unlocked. IO is started.
> > > > - unlock == 0
> > > >   - All the pages except @locked_page are unlocked in any case
> > > > - unlock == 1
> > > >   - On success, all the pages are locked for writing out them
> > > >   - On failure, all the pages except @locked_page are unlocked
> > > > 
