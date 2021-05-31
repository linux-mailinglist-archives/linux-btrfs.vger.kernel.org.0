Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973213953B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 03:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEaBr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 May 2021 21:47:26 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:42074 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhEaBrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 May 2021 21:47:25 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id DAF416C00700;
        Mon, 31 May 2021 04:45:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1622425545; bh=CBf6N/nnL1GzjMSLEMV65IvBAx6g2zl1uAKqpdppHHs=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=KyMNZdmpikwdw5Cjq6Uzqo+jsA6chahZAod86joqOWYZuQE1d56QjDIF+etrpGjXX
         23y5E7NzOiKUkXWsDSKYzZdwwgO5rNlTLEITVMsfZ8YQgOp4KrXkUI86QSXPTGKloG
         Y2Gug6jyODxukzK81ABaSyLrK+o+pXKejHJU5NA8=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id B4C756C00753;
        Mon, 31 May 2021 04:45:44 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id oqbWEk4Zm3-B; Mon, 31 May 2021 04:45:44 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 1E5CE6C00700;
        Mon, 31 May 2021 04:45:44 +0300 (EEST)
Received: from nas (unknown [153.127.9.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 3E7701BE00AD;
        Mon, 31 May 2021 04:45:40 +0300 (EEST)
References: <20210521064050.191164-1-wqu@suse.com>
 <CAEg-Je9m_Lpwq3oXOFfhrHU_OFxryrGE8-3vjMztn7tBt_uStw@mail.gmail.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 00/31] btrfs: add data write support for subpage
Date:   Mon, 31 May 2021 09:32:51 +0800
In-reply-to: <CAEg-Je9m_Lpwq3oXOFfhrHU_OFxryrGE8-3vjMztn7tBt_uStw@mail.gmail.com>
Message-ID: <35u3vfpe.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetdgtE0TYwPODk/uSk0R9egnLkMy6GYip+XRWr7hJ7DSP4og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sun 30 May 2021 at 08:12, Neal Gompa <ngompa13@gmail.com> 
wrote:

> On Fri, May 21, 2021 at 5:56 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> This huge patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> === Current stage ===
>> The tests on x86 pass without new failure, and generic test 
>> group on
>> arm64 with 64K page size passes except known failure and defrag 
>> group.
>>
>> For btrfs test group, all pass except compression/raid56.
>> (As the btrfs defrag group doesn't require that restrict defrag 
>> result,
>> btrfs/defrag group also passes here)
>>
>> For anyone who is interested in testing, please apply this 
>> patch for
>> btrfs-progs before testing.
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.243715-1-wqu@suse.com/
>> Or there will be too many false alerts.
>>
>> === Limitation ===
>> There are several limitations introduced just for subpage:
>> - No compressed write support
>>   Read is no problem, but compression write path has more 
>>   things left to
>>   be modified.
>>   Thus for current patchset, no matter what inode attribute or 
>>   mount
>>   option is, no new compressed extent can be created for 
>>   subpage case.
>>
>> - No inline extent will be created
>>   This is mostly due to the fact that 
>>   filemap_fdatawrite_range() will
>>   trigger more write than the range specified.
>>   In fallocate calls, this behavior can make us to writeback 
>>   which can
>>   be inlined, before we enlarge the isize, causing inline 
>>   extent being
>>   created along with regular extents.
>>
>> - No support for RAID56
>>   There are still too many hardcoded PAGE_SIZE in raid56 code.
>>   Considering it's already considered unsafe due to its 
>>   write-hole
>>   problem, disabling RAID56 for subpage looks sane to me.
>>
>> - No sector-sized defrag support
>>   Currently defrag is still done in PAGE_SIZE, meaning if there 
>>   is a
>>   hole in a 64K page, we still write a full 64K back to disk.
>>   This causes more disk space usage.
>>
>> === Patchset structure ===
>>
>> Patch 01~19:    Make data write path to be subpage compatible
>> Patch 20~21:    Make data relocation path to be subpage 
>> compatible
>> Patch 22~30:    Various fixes for subpage corner cases
>> Patch 31:       Enable subpage data write
>>
>> === Changelog ===
>> v2:
>> - Rebased to latest misc-next
>>   Now metadata write patches are removed from the series, as 
>>   they are
>>   already merged into misc-next.
>>
>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>
>> - Use separate endio functions to subpage metadata write path
>>
>> - Re-order the patches, to make refactors at the top of the 
>> series
>>   One refactor, the submit_extent_page() one, should benefit 4K 
>>   page
>>   size more than 64K page size, thus it's worthy to be merged 
>>   early
>>
>> - New bug fixes exposed by Ritesh Harjani on Power
>>
>> - Reject RAID56 completely
>>   Exposed by btrfs test group, which caused BUG_ON() for 
>>   various sites.
>>   Considering RAID56 is already not considered safe, it's 
>>   better to
>>   reject them completely for now.
>>
>> - Fix subpage scrub repair failure
>>   Caused by hardcoded PAGE_SIZE
>>
>> - Fix free space cache inode size
>>   Same cause as scrub repair failure
>>
>> v3:
>> - Rebased to remove write path prepration patches
>>
>> - Properly enable btrfs defrag
>>   Previsouly, btrfs defrag is in fact just disabled.
>>   This makes tons of tests in btrfs/defrag to fail.
>>
>> - More bug fixes for rare race/crashes
>>   * Fix relocation false alert on csum mismatch
>>   * Fix relocation data corruption
>>   * Fix a rare case of false ASSERT()
>>     The fix already get merged into the prepration patches, 
>>     thus no
>>     longer in this patchset though.
>>
>>   Mostly reported by Ritesh from IBM.
>>
>> Qu Wenruo (31):
>>   btrfs: pass bytenr directly to __process_pages_contig()
>>   btrfs: refactor the page status update into 
>>   process_one_page()
>>   btrfs: provide btrfs_page_clamp_*() helpers
>>   btrfs: only require sector size alignment for
>>     end_bio_extent_writepage()
>>   btrfs: make btrfs_dirty_pages() to be subpage compatible
>>   btrfs: make __process_pages_contig() to handle subpage
>>     dirty/error/writeback status
>>   btrfs: make end_bio_extent_writepage() to be subpage 
>>   compatible
>>   btrfs: make process_one_page() to handle subpage locking
>>   btrfs: introduce helpers for subpage ordered status
>>   btrfs: make page Ordered bit to be subpage compatible
>>   btrfs: update locked page dirty/writeback/error bits in
>>     __process_pages_contig
>>   btrfs: prevent extent_clear_unlock_delalloc() to unlock page 
>>   not
>>     locked by __process_pages_contig()
>>   btrfs: make btrfs_set_range_writeback() subpage compatible
>>   btrfs: make __extent_writepage_io() only submit dirty range 
>>   for
>>     subpage
>>   btrfs: make btrfs_truncate_block() to be subpage compatible
>>   btrfs: make btrfs_page_mkwrite() to be subpage compatible
>>   btrfs: reflink: make copy_inline_to_page() to be subpage 
>>   compatible
>>   btrfs: fix the filemap_range_has_page() call in
>>     btrfs_punch_hole_lock_range()
>>   btrfs: don't clear page extent mapped if we're not 
>>   invalidating the
>>     full page
>>   btrfs: extract relocation page read and dirty part into its 
>>   own
>>     function
>>   btrfs: make relocate_one_page() to handle subpage case
>>   btrfs: fix wild subpage writeback which does not have ordered 
>>   extent.
>>   btrfs: disable inline extent creation for subpage
>>   btrfs: allow submit_extent_page() to do bio split for subpage
>>   btrfs: make defrag to be semi subpage compatible
>>   btrfs: reject raid5/6 fs for subpage
>>   btrfs: fix a crash caused by race between prepare_pages() and
>>     btrfs_releasepage()
>>   btrfs: fix a use-after-free bug in writeback subpage helper
>>   btrfs: fix a subpage false alert for relocating partial 
>>   preallocated
>>     data extents
>>   btrfs: fix a subpage relocation data corruption
>>   btrfs: allow read-write for 4K sectorsize on 64K page size 
>>   systems
>>
>>  fs/btrfs/ctree.h        |   2 +-
>>  fs/btrfs/disk-io.c      |  13 +-
>>  fs/btrfs/extent_io.c    | 551 
>>  +++++++++++++++++++++++++++-------------
>>  fs/btrfs/file.c         |  31 ++-
>>  fs/btrfs/inode.c        | 147 +++++++++--
>>  fs/btrfs/ioctl.c        |  12 +-
>>  fs/btrfs/ordered-data.c |   5 +-
>>  fs/btrfs/reflink.c      |  14 +-
>>  fs/btrfs/relocation.c   | 287 +++++++++++++--------
>>  fs/btrfs/subpage.c      | 156 +++++++++++-
>>  fs/btrfs/subpage.h      |  31 +++
>>  fs/btrfs/super.c        |   7 -
>>  fs/btrfs/sysfs.c        |   5 +
>>  fs/btrfs/volumes.c      |   8 +
>>  14 files changed, 937 insertions(+), 332 deletions(-)
>>
>> --
>> 2.31.1
>>
>
> So this seems to have no impact on my system on x86_64 with the
> branch, which is good I guess?
>
> Unfortunately, I couldn't make a test package based on 5.13rc4 
> for
> some confidence testing as the patch set from Patchwork doesn't
> apply...
>
> However, somewhat related to this, it seems that we're going to 
> be
> seeing a need for 4K <-> 16K page interoperability because Linux 
> will
> need to be configured to use 16K pages to run effectively on 
> Apple ARM
> Mac systems[1][2].
>
> How difficult would it be to extend this to also handle 16K 
> pages too?
> Not necessarily in this patch set, but in a follow-up one?
>
> [1]: https://twitter.com/marcan42/status/1398301930879815680
> [2]: https://twitter.com/marcan42/status/1398301933203431426

As a super fan of Apple, I've noticed Hector Martin's work on M1 
chip.
I'm so happy to expect a full functional M1 device running on 
linux.
However as for btrfs, I'd say just let 64k pagesize subpage 
support go
ahead and fix potencial bugs by real users feedbacks for sometime.

--
Su
