Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7473492F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 14:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhCYNRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 09:17:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:37845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhCYNRE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 09:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616678221;
        bh=cvBT8CLEHpgVcBimAnQUipXlys5dR0AFKgnYi30Kdog=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Vx1t2xwl/FLvGX0i7MuKk4YBd3jEvEjxKqcTD4s6mOD+I5L3HhrqDlohATSdYB81O
         IYTimOdL46jrxLEFVqkTjsNiyJOm/k37oOcxUjPPN4fif4qCMq79Uh2ofFaAxM1FNZ
         1StAEp6zh3NR0zvmXw7PHyTwdgX6lwGP/7pGn/5A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvK0R-1lhDiv2LQn-00rDC6; Thu, 25
 Mar 2021 14:17:01 +0100
To:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210325071445.90896-1-wqu@suse.com>
 <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
Date:   Thu, 25 Mar 2021 21:16:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QViGSXW1zoyH5rsogXnvnhmnHCEOVaqiloaSo94ZW1Kj70O+uSH
 lqJgOvslIJTHWI7fgr3Iq59EikGK3PKllM0FXmNCw7MBEA0XWIj6AYRjlbigQjcVMnaFuaq
 FG8NizdiyO2wuZinbvQ4z4xc/aC7iZyzy+dTP1Rd8grjjG9dCrhZuY2wAZsliR0AGryLU3f
 ruUOr4UVSR6KGw+0Ov+/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6XxzNSHlO/g=:nCygW5MGyM4usNKjg0BKvt
 u/BtMT99LrCLYV6effWNxTyG9pt7+Mo7EEsi0N1mfcmIjvwSd7Jh5HqJp/4QjP0Kez3Gqfm0s
 PObY0BXQh1g9bpK973JuFhgCqxBvdAo7KIH/ia3a4zLhwheMIGrVJSge0A61YL42F1twUSFhy
 /WtPkbkimrGrco77zQ1waESQmr425blKfy/r40vPLNq9Saj1OZc2uXuFAB3FH+07GTM4z9gVe
 NCzrxoadOTcSMYOpZw8TQoEf1sCaoe4Z1DEkyVM099F+N+UcsuMeoKez+v1fKz0fQShvFw+JR
 /Lc6b78XFk3eraxhyNEUImnSBr5VF9zHlFaAxMkUcOUUFhS4TRUgZKGX4FWheQI71e/PbBQAJ
 WM5/8RRA+4+y1sG/L3NWpWFnDg+tSITQhbvHXDWrpDrjvvPQQDcFVi7eejkmTsgmXHlZoiLMR
 zdbgrxljF/pxN1vkD3j3GFgx4U2TbqBeFhl2LoR5JVGP0H1QL8wZrrNVmdq8N+KSNvLSEaaU8
 MQIdEn2NBLgjXjdj3FDdA/hlxylrYJoXooRO/dsGDW7OV0hGfOpOjEaObdM/N+qSjUUfxeTFC
 sbii5Rw9bBOc7VSlUZTzm8Hait+uT1duN0qcQlE2YVMvqstGiisDPJ8r2vXlT9IogpLNq/wej
 JkYW9y3lC4FdzVmt1+wSE3c2wSuSiUPdUr1UtXpAj4UFWBtTA/n7frp6Kae3YNJpwQ3kJsLGV
 crKvDJxk5upzwXV+xu5cFV+KWx0+Nk0nALW3NxkzSeEK3wF21LKt6zBoQ1kEMS028CN56BODh
 zOfIBYOxolNGCgicElQXiTH30GjF+0Lvs9bieCvnWecEcTtb1f+fmbkxo/kXcMc2du4je06AP
 0bjBmjqFE2djZYhfe2OWfqD7ICrPzunNn+L47LVQldB0qrMqh89mdQ7935hvSoa4V05vA7QZ7
 94pZnJhSIuH4VTv3zK/YsbpgGKuc3p23pIFCqf2gFUBLde207qEqJzJ3YcsJo03at02rvsTeJ
 /aVK51VPYpLMPWd176SAxI6Ii+Urymt4xnb1v/koZPLjJCsvQK0gSMMO069ccY/Oxg5TJEUF7
 8pKpIJlccbagjMG5XzOBqRywGAiMjgfuR1pSCELI+kfNogz6UYDa9xAytYFgSTfjzm9WhInV4
 mFpCi5jGtrBN96O6G6BIgUeWj1b0myEOovrV/2h+S/zRmHWqeTNROldBv3NS/zdBXMHFoKX2H
 lZ/szZkXOXlf/dIlU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/25 =E4=B8=8B=E5=8D=888:20, Neal Gompa wrote:
> On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> This patchset can be fetched from the following github repo, along with
>> the full subpage RW support:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> This patchset is for metadata read write support.
>>
>> [FULL RW TEST]
>> Since the data write path is not included in this patchset, we can't
>> really test the patchset itself, but anyone can grab the patch from
>> github repo and do fstests/generic tests.
>>
>> But at least the full RW patchset can pass -g generic/quick -x defrag
>> for now.
>>
>> There are some known issues:
>>
>> - Defrag behavior change
>>    Since current defrag is doing per-page defrag, to support subpage
>>    defrag, we need some change in the loop.
>>    E.g. if a page has both hole and regular extents in it, then defrag
>>    will rewrite the full 64K page.
>>
>>    Thus for now, defrag related failure is expected.
>>    But this should only cause behavior difference, no crash nor hang is
>>    expected.
>>
>> - No compression support yet
>>    There are at least 2 known bugs if forcing compression for subpage
>>    * Some hard coded PAGE_SIZE screwing up space rsv
>>    * Subpage ASSERT() triggered
>>      This is because some compression code is unlocking locked_page by
>>      calling extent_clear_unlock_delalloc() with locked_page =3D=3D NUL=
L.
>>    So for now compression is also disabled.
>>
>> - Inode nbytes mismatch
>>    Still debugging.
>>    The fastest way to trigger is fsx using the following parameters:
>>
>>      fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file > /tmp/fsx
>>
>>    Which would cause inode nbytes differs from expected value and
>>    triggers btrfs check error.
>>
>> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
>> The metadata part in fact has more new code than data part, as it has
>> some different behaviors compared to the regular sector size handling:
>>
>> - No more page locking
>>    Now metadata read/write relies on extent io tree locking, other than
>>    page locking.
>>    This is to allow behaviors like read lock one eb while also try to
>>    read lock another eb in the same page.
>>    We can't rely on page lock as now we have multiple extent buffers in
>>    the same page.
>>
>> - Page status update
>>    Now we use subpage wrappers to handle page status update.
>>
>> - How to submit dirty extent buffers
>>    Instead of just grabbing extent buffer from page::private, we need t=
o
>>    iterate all dirty extent buffers in the page and submit them.
>>
>> [CHANGELOG]
>> v2:
>> - Rebased to latest misc-next
>>    No conflicts at all.
>>
>> - Add new sysfs interface to grab supported RO/RW sectorsize
>>    This will allow mkfs.btrfs to detect unmountable fs better.
>>
>> - Use newer naming schema for each patch
>>    No more "extent_io:" or "inode:" schema anymore.
>>
>> - Move two pure cleanups to the series
>>    Patch 2~3, originally in RW part.
>>
>> - Fix one uninitialized variable
>>    Patch 6.
>>
>> v3:
>> - Rename the sysfs to supported_sectorsizes
>>
>> - Rebased to latest misc-next branch
>>    This removes 2 cleanup patches.
>>
>> - Add new overview comment for subpage metadata
>>
>> Qu Wenruo (13):
>>    btrfs: add sysfs interface for supported sectorsize
>>    btrfs: use min() to replace open-code in btrfs_invalidatepage()
>>    btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage=
()
>>    btrfs: refactor how we iterate ordered extent in
>>      btrfs_invalidatepage()
>>    btrfs: introduce helpers for subpage dirty status
>>    btrfs: introduce helpers for subpage writeback status
>>    btrfs: allow btree_set_page_dirty() to do more sanity check on subpa=
ge
>>      metadata
>>    btrfs: support subpage metadata csum calculation at write time
>>    btrfs: make alloc_extent_buffer() check subpage dirty bitmap
>>    btrfs: make the page uptodate assert to be subpage compatible
>>    btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
>>    btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
>>      compatible
>>    btrfs: add subpage overview comments
>>
>>   fs/btrfs/disk-io.c   | 143 ++++++++++++++++++++++++++++++++++--------=
-
>>   fs/btrfs/extent_io.c | 127 ++++++++++++++++++++++++++++----------
>>   fs/btrfs/inode.c     | 128 ++++++++++++++++++++++----------------
>>   fs/btrfs/subpage.c   | 127 ++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/subpage.h   |  17 +++++
>>   fs/btrfs/sysfs.c     |  15 +++++
>>   6 files changed, 441 insertions(+), 116 deletions(-)
>>
>> --
>> 2.30.1
>>
>
> Why wouldn't we just integrate full read-write support with the
> caveats as described now? It seems to be relatively reasonable to do
> that, and this patch set is essentially unusable without the rest of
> it that does enable full read-write support.

The metadata part is much more stable than data path (almost not touched
for several months), and the metadata part already has some difference
in its behavior, which needs review.

You point makes some sense, but I still don't believe pushing a super
large patchset does any help for the review.

If you want to test, you can grab the branch from the github repo.
If you want to review, the mails are all here for review.

In fact, we used to have subpage support sent as a big patchset from IBM
guys, but the result is only some preparation patches get merged, and
nothing more.

Using this multi-series method, we're already doing better work and
received more testing (to ensure regular sectorsize is not affected at
least).

Thanks,
Qu
>
>
