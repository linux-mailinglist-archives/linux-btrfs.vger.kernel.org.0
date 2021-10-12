Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E81429E4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 09:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhJLHJJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 03:09:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:53913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhJLHJI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 03:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634022425;
        bh=8Gr83iPktynhmp7CKIXzknprrhd8S1Tkc7Fsq6lmoOE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=I+q57zioRjiEZgR4H2bIqhG5YokQ6DttBUOnmF3LRVGDL5XVPtSnLsmmO8Uh3ZTFt
         qmw/igcsBIi9nyHCDXye0v6p6ZZYanBMxdtIV4mxr6aL51C9eUEI+1XS9wqhNLTQ0s
         QUMQFRXTcaHedjC4gHNLNhQ9rqxu986BmttHSnCc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQIv-1n4FVX2qzn-00oVIi; Tue, 12
 Oct 2021 09:07:05 +0200
Message-ID: <81faed76-e644-3d71-2021-3bee0a93913a@gmx.com>
Date:   Tue, 12 Oct 2021 15:07:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 0/3] btrfs-progs: mkfs: make sure we can clean up all
 temporary chunks
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011120650.179017-1-wqu@suse.com>
 <c97120d6-d599-5882-57ef-6f7534660dda@suse.com>
 <057ae017-d79f-183b-719e-7d8c11cb6600@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <057ae017-d79f-183b-719e-7d8c11cb6600@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jKMeNgLJ6uuRt0DguE6Qbb8kNHPE/Yt1k7YG4HClKahC4OvFXCW
 LwlhbfH59lbLnS38lDzz1vIYI0FxoYEs37Fv36ikO3GU2SPw2ykp5FMKm0cSC1KqkT12Cdg
 aXIuIpGnzCA0WE7iaNuPdUv/KZIR381JGJL7V3zZKR87zDqAVE9qwMmuWuQ/lm1go5ie+li
 vH0p8ijaTLhSMMVI93ZGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CZhgv8QnG4E=:rbY3Yfo0Hm0ABimI9FpyHI
 VKI0hLCbCyO1KRJIqBBpFNurvV9GpuZYWAt7Jjh6ONw3/FONOb/w/tzx9WdNAnMYJSz2O/4ug
 lAvuzBPLtBpRffkGL3bfCHolyG9E5euXHD3AAVfrWD77bcEGUuTigC+yMwFXbvUKjLn/3COY6
 HrOqoGbW2ZYYrZvKV5SnBIkiwwdNY/wYPwhLRQkBwx6H3snoBjMsnG8sTtNdXu9Qe5McJaXkn
 ZjH6C5Up17bgXDAVR8h2I6y0CFFg9nYSV1jDiCXDTMKYujrOG65TSO+AMEGFX/Jca3QqlRxqT
 lNqML2SrwshC/HoFWINu+Sva07U5AWcN5PfUP2HUFut11KWPsefn4tI2uwEj+9qs6q+RVh+u5
 dcTucyfznUDcuLjendFAPA93Z+5IaWLhDgnWUx5qrssXlZ/CuI9KP6nUbJwH1r2GK5T75FDnd
 HZy7R2AJnV1qlDCyUaQ2kwQ7pZUxMqBmtLJ2W5OHLpPVl88I3OvOZu2WbGNmKlOEQmUz7n5Nk
 Ni9MVWOLzSI0saQBpU9T6TldM0hOPoaFEF9JNGu64bIS+i27m1oYiV8z1utGTau55spWg/8Td
 wDoOROGFiWCHA3aB/xgO1JV6nIc6xDpzSJS2tIXbTuJh045t2IP/0NS7MAI/TT1KUdHYjfOtZ
 EwX0bmynnTb7cdAJbsWlhxN+AIUZVGOuQXodjAe4eJeldv9L3uLiMdiIHvmDLzaeFq5uyJ613
 KmqaYa6ure80G6oe7QHnI0tr9ax9551V4R2TOX0z33BxeZHrcbRtYx6pVbRnF3CUGCnyJhhIM
 Nf+95vk7jbqbHjRNpdkU+A2yFdqG6a1PeYZ3pgtV177lguczA43TADSN36YlhWCveqCowDVj5
 JtqcccJkmF1jTwmDWwFHZE80f+bHRo5Yvy7gw4oESe4xyRqKotxuxT+r6Vin59bG0oWJoTQON
 Y+r0Dua/l+5dvcqpsenyKBxFn/x/tKIfZr3GyOxC/RTjWd/GG3T5BCLm3lIF5NWPMlbmlp9Ml
 NDney7wfvXBIYtid7oRK6HPd2GxWxjMw7ai3n0fwywQrjrfeRWVhPgmXeKUJxppH32R6eB/UY
 wijT55IMFaJBkE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/11 20:14, Qu Wenruo wrote:
>
>
> On 2021/10/11 20:10, Nikolay Borisov wrote:
>>
>>
>> On 11.10.21 =D0=B3. 15:06, Qu Wenruo wrote:
>>> There is a bug report that with certain mkfs options, mkfs.btrfs may
>>> fail to cleanup some temporary chunks, leading to "btrfs filesystem df=
"
>>> warning about multiple profiles:
>>>
>>> =C2=A0=C2=A0 WARNING: Multiple block group profiles detected, see 'man=
 btrfs(5)'.
>>> =C2=A0=C2=A0 WARNING:=C2=A0=C2=A0 Metadata: single, raid1
>>>
>>> The easiest way to reproduce is "mkfs.btrfs -f -R free-space-tree -m d=
up
>>> -d dup".
>>>
>>> It turns out that, the old _recow_root() can not handle tree levels > =
0,
>>> while with newer free space tree creation timing, the free space tree
>>> can reach level 1 or higher.
>>>
>>> To fix the problem, Patch 2 will do the proper full tree re-CoW, with
>>> extra transaction commitment to make sure all free space tree get
>>> re-CoWed.
>>>
>>> The 3rd patch will do the extra verification during mkfs-tests.
>>>
>>> The first patch is just to fix a confusing parameter which also caused
>>> u64 -> int width reduction and can be problematic in the future.
>>>
>>> Changelog:
>>> v2:
>>> - Remove a duplicated recow_roots() call in create_raid_groups()
>>> =C2=A0=C2=A0 This call makes no difference as we will later commit tra=
nsaction
>>> =C2=A0=C2=A0 and manually call recow_roots() again.
>>> =C2=A0=C2=A0 Remove such duplicated call to save some time.
>>>
>>> - Replace the btrfs_next_sibling_tree_block() with btrfs_next_leaf()
>>> =C2=A0=C2=A0 Since we're always handling leaves, there is no need for
>>> =C2=A0=C2=A0 btrfs_next_sibling_tree_block()
>>>
>>> - Work around a kernel bug which may cause false alerts
>>> =C2=A0=C2=A0 For single device RAID0, btrfs kernel is not respecting i=
t, and will
>>> =C2=A0=C2=A0 allocate new chunks using SINGLE instead.
>>> =C2=A0=C2=A0 This can be very noisy and cause false alerts, and not al=
ways
>>> =C2=A0=C2=A0 reproducible, depending on how fast kernel creates new ch=
unks.
>>>
>>> =C2=A0=C2=A0 Work around it by mounting the RO before calling "btrfs f=
i df".
>>>
>>> =C2=A0=C2=A0 The kernel bug needs to be investigated and fixed.
>> It's better to see the kernel bug fixed rather than papering over it.

The truth is, this is more like a kernel behavior change.

Before commit b2f78e88052b ("btrfs: allow degenerate raid0/raid10"),
kernel can only create RAID0 chunks with at least two devices.

Thus older kernel (when tested under my host, it's still v5.14) will
create SINGLE chunk as it has no other choice.

So false alert.

Thanks,
Qu

>
> That's for sure.
>
> Just get overloaded by so many small bugs in one day.
>
> Will investigate and fix the bug soon.
>
> For the test case itself, mounting with RO in fact makes sense, we just
> want to the initial chunk layout created by mkfs.
>
> If later we choose to compare the total chunk size against the reported
> values, such RO mount is a hard requirement to avoid chunk preallocation=
.
>
> Thanks,
> Qu
>>
>>>
>>>
>>> Qu Wenruo (3):
>>> =C2=A0=C2=A0 btrfs-progs: rename @data parameter to @profile in extent=
 allocation
>>> =C2=A0=C2=A0=C2=A0=C2=A0 path
>>> =C2=A0=C2=A0 btrfs-progs: mkfs: recow all tree blocks properly
>>> =C2=A0=C2=A0 btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans up t=
emporary
>>> =C2=A0=C2=A0=C2=A0=C2=A0 chunks
>>>
>>> =C2=A0 kernel-shared/extent-tree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26 +++---
>>> =C2=A0 mkfs/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 90=
 ++++++++++++++++++---
>>> =C2=A0 tests/mkfs-tests/001-basic-profiles/test.sh | 16 +++-
>>> =C2=A0 3 files changed, 104 insertions(+), 28 deletions(-)
>>>
