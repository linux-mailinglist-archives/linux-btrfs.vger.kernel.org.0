Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0836234C1D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 04:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhC2CCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 22:02:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:44841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231426AbhC2CCF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 22:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616983322;
        bh=jOKaL+BO90LTfEZNYFE/1g8YYdm5JnCNRQxKTQLxRM4=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=JbQXK/ZYfrJiLDyoFNcn+HXHEessMDRBE1EhxKdS8Xm7g94RW+twIg9LvxCGh/UWb
         3xhT73aaO4xEuoNF2RDbdgddf/6FIQrILw4O9XHBcNnrV9nNDInVkqgVAmgfK5CZBZ
         WBC94uRt5bO9aIXRrJxZ0gxDJYPDC4+DPuRpEHOI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5fMe-1lXq5r0itO-007FX1; Mon, 29
 Mar 2021 04:02:02 +0200
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210325071445.90896-1-wqu@suse.com>
 <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
 <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
Date:   Mon, 29 Mar 2021 10:01:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o7xoAPVej/93OqzNkvlkrvzHf3Sw/5dZNi9NYPukul84wbDTOBw
 xO2HNDTad6aBIGppndITfWqQH+2pdQhLeauncQiN5bh71TBJ2N8OdV1cdaRKJFcY4NEMBVF
 2iw4hMTLFy0/fk81NgNb3GtfXdMRmpXCTitAH7SG87/IDYxMgsO3AJ+wDM3LHKRS5r+IvzG
 qqF+kISUpC1UN2Mv8K0hA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TVp4jVAoUkg=:E3Hf+49GycRl+eyOXPDHvL
 5O388U3dgolrwAE9wBDGSg3A6ikzwWX87FOjReuegnHsHJT8qRGWocVoXjuQ0R4dfiGThqLh6
 asS6GG/Md0CbcwC7BuP80SlO9vF2lkgp9CFLDh4hQ/MpoUl815OJBX2ZwwzrGWdKfeG+7+jAw
 tXI4xxlBjPrEvqKCp65I1bQqsw7gex1dq4MPXYNfu+p+AUNfXJye06kffAjndzwx20lEP0sL7
 oppUvQkK0LdiW7/MIOfw0Wgoec6H7jJSkiGq8p3ckqMYGpk7GPpWIlzPnZwgncJR71KsMzSNA
 dqPH3xkZaW2UBMUlBCwM4huYYzv8KDm1f/cMAGvJ10PVU3Th6dOv2VRrVdeHtu1rLIOmfWbxd
 0VfnhRLkE+hz8Ls4UvF77vJpy0MTQtrwRcQGYhS7GxEkqRt5Tr1szkTJ/bbubh4PFBzRJhE+1
 RU+LPMfxePikO3BybAB+EJzv5WW2R4GmgU9Ytc7pF5RByvVfJMPYzGYWp0/WEhEwvFfDLfwic
 wL/TooAthu9c3cMfYF0517KOmvyH2kCL9fdG2rPS75vVZDX0gqLEdDVNiJWE3MS7o1fHH+mvU
 m+5Efyb283aH+aCQ836lArTWVg+ZeV/dHD373ysM0GFrh3VJ+gkMcOtAq6PCNMyYzUBX6HbE2
 6iuCB4Ojtq39fbGk6LeWWzVPM3+m4fIi2evprUvOgmbKseR0kVAokOA3tIgTVoMoGmYIuy6Ab
 vO101MXBDJ7xVbRW7NHCHEEBkOQnfwEjJuI3P2WW8DIg3u+7GBPdwS6HePEWSMXX0LgTtpp7G
 BPMDxOeNl3nU3+gDPPCNA4z5l4YJlt6OgiJKN8lNbRNPEvplD+zpzgTr9fW4Mqp4kghQVvx3b
 QU0c9p4PtaJfV4VRb3K/q9OLWTP7e5a8gwFM9DRdMwmFsHLwpppuLPjRYDEgiJC5t8CH+1pRt
 5Q1Fra7PfjAD+/F7SsmW0V2LJVyjzFm8Wd4W2bzHY4oYxl5eKxiDdtwswOvnxNvb8+Nh7n1Ai
 7230pdHLrq3D47ZF0IL39CmC9KU4Hwpu1YXlNgJf78hWzhTWUwmBwpMKC2l3OM7N1IAcaO+qC
 2PN9555iJBuGMVJ9+yGeVt8vgt6sncCp4QZrMhcX3xnvfAZpQIM0eyDIx7UaG2ifvyug4ZQFJ
 alq7lfi9BqvIPWTXRGLrp0L7gQBHRAtN4rq9VGLeUWXFiwmVAX8eLpcevoeTtR+7MDsPvxfO8
 mWAQYMXATH4gYP44P
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/29 =E4=B8=8A=E5=8D=884:02, Ritesh Harjani wrote:
> On 21/03/25 09:16PM, Qu Wenruo wrote:
>>
>>
>> On 2021/3/25 =E4=B8=8B=E5=8D=888:20, Neal Gompa wrote:
>>> On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> This patchset can be fetched from the following github repo, along wi=
th
>>>> the full subpage RW support:
>>>> https://github.com/adam900710/linux/tree/subpage
>>>>
>>>> This patchset is for metadata read write support.
>>>>
>>>> [FULL RW TEST]
>>>> Since the data write path is not included in this patchset, we can't
>>>> really test the patchset itself, but anyone can grab the patch from
>>>> github repo and do fstests/generic tests.
>>>>
>>>> But at least the full RW patchset can pass -g generic/quick -x defrag
>>>> for now.
>>>>
>>>> There are some known issues:
>>>>
>>>> - Defrag behavior change
>>>>     Since current defrag is doing per-page defrag, to support subpage
>>>>     defrag, we need some change in the loop.
>>>>     E.g. if a page has both hole and regular extents in it, then defr=
ag
>>>>     will rewrite the full 64K page.
>>>>
>>>>     Thus for now, defrag related failure is expected.
>>>>     But this should only cause behavior difference, no crash nor hang=
 is
>>>>     expected.
>>>>
>>>> - No compression support yet
>>>>     There are at least 2 known bugs if forcing compression for subpag=
e
>>>>     * Some hard coded PAGE_SIZE screwing up space rsv
>>>>     * Subpage ASSERT() triggered
>>>>       This is because some compression code is unlocking locked_page =
by
>>>>       calling extent_clear_unlock_delalloc() with locked_page =3D=3D =
NULL.
>>>>     So for now compression is also disabled.
>>>>
>>>> - Inode nbytes mismatch
>>>>     Still debugging.
>>>>     The fastest way to trigger is fsx using the following parameters:
>>>>
>>>>       fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file > /tmp/f=
sx
>>>>
>>>>     Which would cause inode nbytes differs from expected value and
>>>>     triggers btrfs check error.
>>>>
>>>> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
>>>> The metadata part in fact has more new code than data part, as it has
>>>> some different behaviors compared to the regular sector size handling=
:
>>>>
>>>> - No more page locking
>>>>     Now metadata read/write relies on extent io tree locking, other t=
han
>>>>     page locking.
>>>>     This is to allow behaviors like read lock one eb while also try t=
o
>>>>     read lock another eb in the same page.
>>>>     We can't rely on page lock as now we have multiple extent buffers=
 in
>>>>     the same page.
>>>>
>>>> - Page status update
>>>>     Now we use subpage wrappers to handle page status update.
>>>>
>>>> - How to submit dirty extent buffers
>>>>     Instead of just grabbing extent buffer from page::private, we nee=
d to
>>>>     iterate all dirty extent buffers in the page and submit them.
>>>>
>>>> [CHANGELOG]
>>>> v2:
>>>> - Rebased to latest misc-next
>>>>     No conflicts at all.
>>>>
>>>> - Add new sysfs interface to grab supported RO/RW sectorsize
>>>>     This will allow mkfs.btrfs to detect unmountable fs better.
>>>>
>>>> - Use newer naming schema for each patch
>>>>     No more "extent_io:" or "inode:" schema anymore.
>>>>
>>>> - Move two pure cleanups to the series
>>>>     Patch 2~3, originally in RW part.
>>>>
>>>> - Fix one uninitialized variable
>>>>     Patch 6.
>>>>
>>>> v3:
>>>> - Rename the sysfs to supported_sectorsizes
>>>>
>>>> - Rebased to latest misc-next branch
>>>>     This removes 2 cleanup patches.
>>>>
>>>> - Add new overview comment for subpage metadata
>>>>
>>>> Qu Wenruo (13):
>>>>     btrfs: add sysfs interface for supported sectorsize
>>>>     btrfs: use min() to replace open-code in btrfs_invalidatepage()
>>>>     btrfs: remove unnecessary variable shadowing in btrfs_invalidatep=
age()
>>>>     btrfs: refactor how we iterate ordered extent in
>>>>       btrfs_invalidatepage()
>>>>     btrfs: introduce helpers for subpage dirty status
>>>>     btrfs: introduce helpers for subpage writeback status
>>>>     btrfs: allow btree_set_page_dirty() to do more sanity check on su=
bpage
>>>>       metadata
>>>>     btrfs: support subpage metadata csum calculation at write time
>>>>     btrfs: make alloc_extent_buffer() check subpage dirty bitmap
>>>>     btrfs: make the page uptodate assert to be subpage compatible
>>>>     btrfs: make set/clear_extent_buffer_dirty() to be subpage compati=
ble
>>>>     btrfs: make set_btree_ioerr() accept extent buffer and to be subp=
age
>>>>       compatible
>>>>     btrfs: add subpage overview comments
>>>>
>>>>    fs/btrfs/disk-io.c   | 143 ++++++++++++++++++++++++++++++++++-----=
----
>>>>    fs/btrfs/extent_io.c | 127 ++++++++++++++++++++++++++++----------
>>>>    fs/btrfs/inode.c     | 128 ++++++++++++++++++++++----------------
>>>>    fs/btrfs/subpage.c   | 127 ++++++++++++++++++++++++++++++++++++++
>>>>    fs/btrfs/subpage.h   |  17 +++++
>>>>    fs/btrfs/sysfs.c     |  15 +++++
>>>>    6 files changed, 441 insertions(+), 116 deletions(-)
>>>>
>>>> --
>>>> 2.30.1
>>>>
>>>
>>> Why wouldn't we just integrate full read-write support with the
>>> caveats as described now? It seems to be relatively reasonable to do
>>> that, and this patch set is essentially unusable without the rest of
>>> it that does enable full read-write support.
>>
>> The metadata part is much more stable than data path (almost not touche=
d
>> for several months), and the metadata part already has some difference
>> in its behavior, which needs review.
>>
>> You point makes some sense, but I still don't believe pushing a super
>> large patchset does any help for the review.
>>
>> If you want to test, you can grab the branch from the github repo.
>> If you want to review, the mails are all here for review.
>>
>> In fact, we used to have subpage support sent as a big patchset from IB=
M
>> guys, but the result is only some preparation patches get merged, and
>> nothing more.
>>
>> Using this multi-series method, we're already doing better work and
>> received more testing (to ensure regular sectorsize is not affected at
>> least).
>
> Hi Qu Wenruo,
>
> Sorry about chiming in late on this. I don't have any strong objection o=
n either
> approach. Although sometime back when I tested your RW support git tree =
on
> Power, the unmount patch itself was crashing. I didn't debug it that tim=
e
> (this was a month back or so), so I also didn't bother testing xfstests =
on Power.
>
> But we do have an interest in making sure this patch series work on bs <=
 ps
> on Power platform. I can try helping with testing, reviewing (to best of=
 my
> knowledge) and fixing anything is possible :)

That's great!

One of my biggest problem here is, I don't have good enough testing
environment.

Although SUSE has internal clouds for ARM64/PPC64, but due to the
f**king Great Firewall, it's super slow to access, no to mention doing
proper debugging.

Currently I'm using two ARM SBCs, RK3399 and A311D based, to do the test.
But their computing power is far from ideal, only generic/quick can
finish in hours.

Thus real world Power could definitely help.
>
> Let me try and pull your tree and test it on Power. Please let me know i=
f there
> is anything needs to be taken care apart from your github tree and btrfs=
-progs
> branch with bs < ps support.

If you're going to test the branch, here are some small notes:

- Need to use latest btrfs-progs
   As it fixes a false alert on crossing 64K page boundary.

- Need to slightly modify btrfs-progs to avoid false alerts
   For subpage case, mkfs.btrfs will output a warning, but that warning
   is outputted into stderr, which will screw up generic test groups.
   It's recommended to apply the following diff:

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 569208a9..21976554 100644
=2D-- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -341,8 +341,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
                 return -EINVAL;
         }
         if (page_size !=3D sectorsize)
-               warning(
-"the filesystem may not be mountable, sectorsize %u doesn't match page
size %u",
+               printf(
+"the filesystem may not be mountable, sectorsize %u doesn't match page
size %u\n",
                         sectorsize, page_size);
         return 0;
  }

- Xfstest/btrfs group will crash at btrfs/143
   Still investigating, but you can ignore btrfs group for now.

- Very rare hang
   There is a very low change to hang, with "bad ordered accounting"
   dmesg.
   If you can hit, please let me know.
   I had something idea to fix it, but not yet in the branch.

- btrfs inode nbytes mismatch
   Investigating, as it will make btrfs-check to report error.

The last two bugs are the final show blocker, I'll give you extra
updates when those are fixed.

Thanks,
Qu

>
> -ritesh
>
>
