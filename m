Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FA3953E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 04:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhEaC2C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 May 2021 22:28:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:41265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhEaC2B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 May 2021 22:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622427977;
        bh=QmrF6rO6JO1/1QmuitazAchHYpMtjNu1MmBvHvLHwmI=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=KWUAjBD2YKetwzD89afliG8YnlzB5oZDGDGT5BivyadSjnfAIRRmnKx5RrG4h7jGU
         G9JO3J/n/imLlu6onYy9tR51qkK50KHq2bYRSL25IeaHHgUPcSkftxWlHCY33V0uc7
         KCwfkq6/wb4UNQ9fjEl8/4UYSIaFeW9IU/uqRKS8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHG8g-1laOUa0sYS-00DJ3j; Mon, 31
 May 2021 04:26:16 +0200
To:     Neal Gompa <ngompa13@gmail.com>, Su Yue <l@damenly.su>
Cc:     Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>
References: <20210521064050.191164-1-wqu@suse.com>
 <CAEg-Je9m_Lpwq3oXOFfhrHU_OFxryrGE8-3vjMztn7tBt_uStw@mail.gmail.com>
 <35u3vfpe.fsf@damenly.su>
 <CAEg-Je_OZNb4LvOKMNgFZLJSj5wOMRDvYv0kvnaoyGk7TXn1sg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/31] btrfs: add data write support for subpage
Message-ID: <070379bf-8460-fc16-7b40-3eabeb50face@gmx.com>
Date:   Mon, 31 May 2021 10:26:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAEg-Je_OZNb4LvOKMNgFZLJSj5wOMRDvYv0kvnaoyGk7TXn1sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M4GX7i5pQgel88yrXoXZ6C4fDagF37TYuaTMzXdVPUPDM6QU3iE
 ktrk388ydWlabwKgDAOj2o2Q8MTUljBsk4xjHeamfXMfbxl8RJYJUhtEGGqgg62SranQvXh
 2KQBIQzgNaXQ5QiZrsUhwiHVgpsisdroFkZzaAks6fyrODUySgNsw0uoAvjP8FY5PqGw1Aa
 obUxC9+cb5G9AsY1H6U4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:scFEBGPX+Mo=:JmJ6whw+2qdFLO2JRl8t/1
 Pq7z95n8r+CHNnJ2iAN+VGNRhbO2pC84awPs4D5ppHifZ9eqSIT8W7/DQwYuXWxhSApkaRZ89
 sfEePt7ayRUorHzfFgRu2OEc4YHDQjLVwaEMLbZo+M3M2nuQQrv3wiOUiucwPGCe7ceX+UaNP
 luCRT90F0b4Hs5X98sOXEbhr2N4XcoWi4SlQz2NrDVPZ7Yhpx1PYB8/3V9YbMD2NhTQyxb/kO
 nMJpSCRb+Aa44dAJWiNN+jjAQFc2L0FehcbgA/nuux9chCE9RQ0z5/W5/UdafjADOn3r+XCmE
 Z+JdIq2IUc47SZl2zdhgaBWmo/LM3IiQ4F9h1or5Jt3WTYbQ0nbJdn92OfKihbPyuvTmCUm87
 sUH6Sig4Ad6jJqcLPwJRvnudT7bpS+Ci2i42wyLPXK7r9R3vU+fDo901CoH7+de5cjyT5HaHV
 /mDFgz0UEXyBZLzDtWKMeWMwQ49SglUsAAJy3z3WHdBx0x+GQOKuOOKb2aDMJ6LwhPKTXFki0
 KY97YpCzFLSb8D3v+a0nLsCQgIr0uSd1w/9BQIg9Uq7lMel29D3oWkod+Qjz1tErgey8kfXTG
 AOsdHFyGE+f7sRj0NZmURdF4455DSjbFZcYGF3YzLKHMkycWb1ad4ALXYrcvoRE4doKJ8FLS9
 sS757EahkWogmuLWI2mhaELGJZxdgLosxrDlzatGZq8/9MlXdYrTK8FaHs7NrY9UQ5rwA+Jg9
 r4iEEyaB5ZuILZdxU0U4kCcFaeKsO4QgybK6BnaWy7Qxq9u3pgRYB5EnopamOI6ydGUw4UuKK
 kLYzgVAjfpOP2XpWcQYGbqJpIv1Zqb3eo8QJc6wdn4qNW3NW+DIwy7SPcAFhHz+1SMGdD3Eoh
 U31S2t7j7lR1qSo0ZlB9837L+FiYcwJK1uFgopTMK6CGLzlbZY3b5ga/Pe1P4t57yWPc3N/iU
 7cNMLaj8XDX3HlkfvAjB6BIY2f6dsueW7djgvO1j8oDdeFhPHlsbe0fKwfewwr6Fhv04cNr41
 YlNOH+aCiZlRoPStFPpBlM5uOkrSUbvGDryh9Tt8b3/qcaeiMUCKEoNZSY0cf9RLq4cVvTnpM
 69pfBV8iqSy70T5Xq654SOEWqJcl0W0g0wu6/sf5WcVdPdluuWUKZJX/B0YlRs6WDwwJxiKXw
 sZXodYOuZ1g9huIrmcKLbw9tDrnJVXtrjYXm8ZCLLcMnt6IzfkQRJQWwybKofpOmWxLGDKOnj
 eQFGzC9AwH9IAEM5p
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/31 =E4=B8=8A=E5=8D=889:52, Neal Gompa wrote:
> On Sun, May 30, 2021 at 9:45 PM Su Yue <l@damenly.su> wrote:
>>
>>
>> On Sun 30 May 2021 at 08:12, Neal Gompa <ngompa13@gmail.com>
>> wrote:
>>
>>> On Fri, May 21, 2021 at 5:56 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> This huge patchset can be fetched from github:
>>>> https://github.com/adam900710/linux/tree/subpage
>>>>
>>>> =3D=3D=3D Current stage =3D=3D=3D
>>>> The tests on x86 pass without new failure, and generic test
>>>> group on
>>>> arm64 with 64K page size passes except known failure and defrag
>>>> group.
>>>>
>>>> For btrfs test group, all pass except compression/raid56.
>>>> (As the btrfs defrag group doesn't require that restrict defrag
>>>> result,
>>>> btrfs/defrag group also passes here)
>>>>
>>>> For anyone who is interested in testing, please apply this
>>>> patch for
>>>> btrfs-progs before testing.
>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036=
.243715-1-wqu@suse.com/
>>>> Or there will be too many false alerts.
>>>>
>>>> =3D=3D=3D Limitation =3D=3D=3D
>>>> There are several limitations introduced just for subpage:
>>>> - No compressed write support
>>>>    Read is no problem, but compression write path has more
>>>>    things left to
>>>>    be modified.
>>>>    Thus for current patchset, no matter what inode attribute or
>>>>    mount
>>>>    option is, no new compressed extent can be created for
>>>>    subpage case.
>>>>
>>>> - No inline extent will be created
>>>>    This is mostly due to the fact that
>>>>    filemap_fdatawrite_range() will
>>>>    trigger more write than the range specified.
>>>>    In fallocate calls, this behavior can make us to writeback
>>>>    which can
>>>>    be inlined, before we enlarge the isize, causing inline
>>>>    extent being
>>>>    created along with regular extents.
>>>>
>>>> - No support for RAID56
>>>>    There are still too many hardcoded PAGE_SIZE in raid56 code.
>>>>    Considering it's already considered unsafe due to its
>>>>    write-hole
>>>>    problem, disabling RAID56 for subpage looks sane to me.
>>>>
>>>> - No sector-sized defrag support
>>>>    Currently defrag is still done in PAGE_SIZE, meaning if there
>>>>    is a
>>>>    hole in a 64K page, we still write a full 64K back to disk.
>>>>    This causes more disk space usage.
>>>>
>>>> =3D=3D=3D Patchset structure =3D=3D=3D
>>>>
>>>> Patch 01~19:    Make data write path to be subpage compatible
>>>> Patch 20~21:    Make data relocation path to be subpage
>>>> compatible
>>>> Patch 22~30:    Various fixes for subpage corner cases
>>>> Patch 31:       Enable subpage data write
>>>>
>>>> =3D=3D=3D Changelog =3D=3D=3D
>>>> v2:
>>>> - Rebased to latest misc-next
>>>>    Now metadata write patches are removed from the series, as
>>>>    they are
>>>>    already merged into misc-next.
>>>>
>>>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>>>
>>>> - Use separate endio functions to subpage metadata write path
>>>>
>>>> - Re-order the patches, to make refactors at the top of the
>>>> series
>>>>    One refactor, the submit_extent_page() one, should benefit 4K
>>>>    page
>>>>    size more than 64K page size, thus it's worthy to be merged
>>>>    early
>>>>
>>>> - New bug fixes exposed by Ritesh Harjani on Power
>>>>
>>>> - Reject RAID56 completely
>>>>    Exposed by btrfs test group, which caused BUG_ON() for
>>>>    various sites.
>>>>    Considering RAID56 is already not considered safe, it's
>>>>    better to
>>>>    reject them completely for now.
>>>>
>>>> - Fix subpage scrub repair failure
>>>>    Caused by hardcoded PAGE_SIZE
>>>>
>>>> - Fix free space cache inode size
>>>>    Same cause as scrub repair failure
>>>>
>>>> v3:
>>>> - Rebased to remove write path prepration patches
>>>>
>>>> - Properly enable btrfs defrag
>>>>    Previsouly, btrfs defrag is in fact just disabled.
>>>>    This makes tons of tests in btrfs/defrag to fail.
>>>>
>>>> - More bug fixes for rare race/crashes
>>>>    * Fix relocation false alert on csum mismatch
>>>>    * Fix relocation data corruption
>>>>    * Fix a rare case of false ASSERT()
>>>>      The fix already get merged into the prepration patches,
>>>>      thus no
>>>>      longer in this patchset though.
>>>>
>>>>    Mostly reported by Ritesh from IBM.
>>>>
>>>> Qu Wenruo (31):
>>>>    btrfs: pass bytenr directly to __process_pages_contig()
>>>>    btrfs: refactor the page status update into
>>>>    process_one_page()
>>>>    btrfs: provide btrfs_page_clamp_*() helpers
>>>>    btrfs: only require sector size alignment for
>>>>      end_bio_extent_writepage()
>>>>    btrfs: make btrfs_dirty_pages() to be subpage compatible
>>>>    btrfs: make __process_pages_contig() to handle subpage
>>>>      dirty/error/writeback status
>>>>    btrfs: make end_bio_extent_writepage() to be subpage
>>>>    compatible
>>>>    btrfs: make process_one_page() to handle subpage locking
>>>>    btrfs: introduce helpers for subpage ordered status
>>>>    btrfs: make page Ordered bit to be subpage compatible
>>>>    btrfs: update locked page dirty/writeback/error bits in
>>>>      __process_pages_contig
>>>>    btrfs: prevent extent_clear_unlock_delalloc() to unlock page
>>>>    not
>>>>      locked by __process_pages_contig()
>>>>    btrfs: make btrfs_set_range_writeback() subpage compatible
>>>>    btrfs: make __extent_writepage_io() only submit dirty range
>>>>    for
>>>>      subpage
>>>>    btrfs: make btrfs_truncate_block() to be subpage compatible
>>>>    btrfs: make btrfs_page_mkwrite() to be subpage compatible
>>>>    btrfs: reflink: make copy_inline_to_page() to be subpage
>>>>    compatible
>>>>    btrfs: fix the filemap_range_has_page() call in
>>>>      btrfs_punch_hole_lock_range()
>>>>    btrfs: don't clear page extent mapped if we're not
>>>>    invalidating the
>>>>      full page
>>>>    btrfs: extract relocation page read and dirty part into its
>>>>    own
>>>>      function
>>>>    btrfs: make relocate_one_page() to handle subpage case
>>>>    btrfs: fix wild subpage writeback which does not have ordered
>>>>    extent.
>>>>    btrfs: disable inline extent creation for subpage
>>>>    btrfs: allow submit_extent_page() to do bio split for subpage
>>>>    btrfs: make defrag to be semi subpage compatible
>>>>    btrfs: reject raid5/6 fs for subpage
>>>>    btrfs: fix a crash caused by race between prepare_pages() and
>>>>      btrfs_releasepage()
>>>>    btrfs: fix a use-after-free bug in writeback subpage helper
>>>>    btrfs: fix a subpage false alert for relocating partial
>>>>    preallocated
>>>>      data extents
>>>>    btrfs: fix a subpage relocation data corruption
>>>>    btrfs: allow read-write for 4K sectorsize on 64K page size
>>>>    systems
>>>>
>>>>   fs/btrfs/ctree.h        |   2 +-
>>>>   fs/btrfs/disk-io.c      |  13 +-
>>>>   fs/btrfs/extent_io.c    | 551
>>>>   +++++++++++++++++++++++++++-------------
>>>>   fs/btrfs/file.c         |  31 ++-
>>>>   fs/btrfs/inode.c        | 147 +++++++++--
>>>>   fs/btrfs/ioctl.c        |  12 +-
>>>>   fs/btrfs/ordered-data.c |   5 +-
>>>>   fs/btrfs/reflink.c      |  14 +-
>>>>   fs/btrfs/relocation.c   | 287 +++++++++++++--------
>>>>   fs/btrfs/subpage.c      | 156 +++++++++++-
>>>>   fs/btrfs/subpage.h      |  31 +++
>>>>   fs/btrfs/super.c        |   7 -
>>>>   fs/btrfs/sysfs.c        |   5 +
>>>>   fs/btrfs/volumes.c      |   8 +
>>>>   14 files changed, 937 insertions(+), 332 deletions(-)
>>>>
>>>> --
>>>> 2.31.1
>>>>
>>>
>>> So this seems to have no impact on my system on x86_64 with the
>>> branch, which is good I guess?
>>>
>>> Unfortunately, I couldn't make a test package based on 5.13rc4
>>> for
>>> some confidence testing as the patch set from Patchwork doesn't
>>> apply...
>>>
>>> However, somewhat related to this, it seems that we're going to
>>> be
>>> seeing a need for 4K <-> 16K page interoperability because Linux
>>> will
>>> need to be configured to use 16K pages to run effectively on
>>> Apple ARM
>>> Mac systems[1][2].
>>>
>>> How difficult would it be to extend this to also handle 16K
>>> pages too?
>>> Not necessarily in this patch set, but in a follow-up one?
>>>
>>> [1]: https://twitter.com/marcan42/status/1398301930879815680
>>> [2]: https://twitter.com/marcan42/status/1398301933203431426
>>
>> As a super fan of Apple, I've noticed Hector Martin's work on M1
>> chip.
>> I'm so happy to expect a full functional M1 device running on
>> linux.
>> However as for btrfs, I'd say just let 64k pagesize subpage
>> support go
>> ahead and fix potencial bugs by real users feedbacks for sometime.
>>
>
> I wasn't proposing that we hold this back for that. In fact, I
> explicitly suggested *not* doing that. However, it's somewhat academic
> for now as M1 support isn't quite done yet, and we still don't have
> this merged either.
>
>
I think it's a good time to make sure what's the roadmap for the
incoming subpage support, that's what mostly in my mind:

- Compression support

- Other page size support

- Final fixes for selftest/integration check code

- RAID56 support

For now, I believe other page size support can be simpler than
compression, thus their order may change.

Anyway, for other page size, M1 can be a good new "toy" for me to play
around, but since it only support 16K page size, it is less flex and
since it's the devil Apple, I really don't want to waste my money on
something expensive and unexpandable.

Thus CM4 will be the way to go for a long time, until a better ARM
board/server come.
(HoneyComb LX2 may be a good new toy for me)


Here I may miss some feature, feel free to add.

Thanks,
Qu
