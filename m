Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB563D04BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 00:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhGTWAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 18:00:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:36363 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhGTWAM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 18:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626820839;
        bh=D6DbahDlGfp0EzpRmi8/r/JhWvV1R8uS2gLao9qq9qE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Jz0NDh1z7mJaMlrEkdOiDW1y7QaFmrKBEyMHxblBV6ho6jk3/zX5ATb7msiPAawp6
         gtpe0C7+JdHy8Fjd+R0s2tFVnfffxH4I32bvo6teJ/wlNtYrWHYZY5TFolTvXMpAIF
         Nj5tFiIYIaGNct0G9clPwFSkhQ00nuGaZnJDLNyo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6UZv-1m3UVz1w9B-006vVi; Wed, 21
 Jul 2021 00:40:39 +0200
Subject: Re: [PATCH 0/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove
 ghost subvolume
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20210628101637.349718-1-wqu@suse.com>
 <20210720040542.GB10170@hungrycats.org>
 <306e11d5-60c7-3a30-fd9c-deaddc4eb21d@gmx.com>
 <20210720154107.GC10170@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7ac2a08f-794d-94d0-9c2c-b5b68793b3d9@gmx.com>
Date:   Wed, 21 Jul 2021 06:40:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720154107.GC10170@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VtxUcfF2bRd1CIWqt4BOFjPU045jcCVz2T4j1yPbP5jIEkuNDcK
 DhiwJMbpbOBFDuCevUGHl1OfrEGekIAERHq0bghdSUx7OI3RevTZNA5ljIUWgRCDY79s7pw
 QhSp1mGFSeH2Rl+bmY/TggRoJuM722uCFHywfUd2jRCpcdqN2ZT7+OR4Bp3zgLiWI8hiMFP
 CI1qz+zvVFoPlseEk+ONg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E0SQbBP4W6I=:Qf/ZEESpIU56PRou+XV75j
 kbYeT4PjSgZgh36Q2fBv/amXbD+VfQ4bKuhh9H8ovKorI4znXs/atUhk+nyZlPaf6km/WrgbX
 +1K1+w9o8m/TDYia4ABPtRSyhm1RtAT2Y+FCCcGJJwbzU44u9FxLo+jRppZDZReyJEOM3SLc6
 Da8zT2LxFyh1mLDdJqv7wSm0cVcwPiX2vROsNDPv/zC7d2zWibRc2L/uaBtToiK+6s9Mir+0q
 XbE76gGWMEBo9eiWjnMQeGAXPjchXiwNc2V3rwlfn0zPcZDJuBUDkN4gfVAfCtPPYDSJg26nd
 aAGmv8pxq7SqmrjIOKrv5jt9g5yzCbuP9bqyoB8a/p8MyKpwUIjTLPogzJT3Oce0cMxjXz+pz
 6wlcWweavb4nT2I4q1/M4CLFJScol+9yZAC3oOkis1V5bzM9EhogC1GGnBfdnEAqTeFHyTkSt
 wKHoZWdmiz2bu1EY76+q7RgHt/jE+Ospdre1FNvzEPKKoqp2n+iqQ20317KvFfN1V3rTtaPY1
 PyLCDgy5NhZMvUzEQfXhRhSXadfjgBTqQ5cROGMtgCRFx0Wca8o4NzGPs8Whfp69NZNVVJ7ss
 KL2D+62j4mAzAgtOj1jB2n9pepsMn2giNkoOa0mZhiuN9SuGT5bw4SAZeYmwnZF+BBvHIm3os
 XoI6XmVXrc8/FWQMRiaDjkXrFd0H7bkgC+2B17VYSbS4+OvoqhSbnAbYJd4oqiUMB/6m8TRuq
 /OTvFf4ZymQkABxtYFGiSfTIiOfvs6WY5ivEOZokbOVBbVTsniBBtswR2ZXSH5/5pTFocrWR/
 NSwk5rqkE7FQ1FQNr0GUlmcb9wGmrWzOU2Z6uHqIZaiYp7PXm6MUlKpmuH5xn58G4mz7hlx5L
 iFvmuuZZsOsc3mgqdKu4RE0eZN2qd5LlJW7chrevSqotlSgHOB2sJamBnQFfjy15KmvIGUOpu
 hsSUyaLzsnySPneXy7t5XDDrnlGgvjmvSfR2zx29jR5fzoqip9Fi1NY61xNcPazNii57O+Cwd
 qWiChX2l0UUHxixhZtIsCUfJp5Joo8RSSytOmOMAislsbdJL87X7lM8ohHZHMDOZOBxD1P9tp
 LNJxyNprndxA488B4Ms5OfqHgNVTsHpI1xfUzZSBqfVmc5PVVyef38Avw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8B=E5=8D=8811:41, Zygo Blaxell wrote:
> On Tue, Jul 20, 2021 at 12:33:47PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/20 =E4=B8=8B=E5=8D=8812:05, Zygo Blaxell wrote:
>>> On Mon, Jun 28, 2021 at 06:16:34PM +0800, Qu Wenruo wrote:
>>>> Since we're busting ghost subvolumes, the branch is now called
>>>> ghost_busters:
>>>> https://github.com/adam900710/linux/tree/ghost_busters
>>>>
>>>> The first two patches are just cleanup found during the development.
>>>>
>>>> The first is a missing check for subvolid range, the missing check
>>>> itself won't cause any harm, just returning -ENOENT from dentry looku=
p,
>>>> other than the expected -EINVAL.
>>>>
>>>> The 2nd is a super old dead comment from the early age of btrfs.
>>>>
>>>> The final patch is the real work to allow patched "btrfs subvolume de=
lete -i"
>>>> to delete ghost subvolume.
>>>> Tested with the image dump of previous submitted btrfs-progs patchset=
.
>>>>
>>>> Qu Wenruo (3):
>>>>     btrfs: return -EINVAL if some user wants to remove uuid/data_relo=
c
>>>>       tree
>>>>     btrfs: remove dead comment on btrfs_add_dead_root()
>>>>     btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove ghost subvolume
>>>
>>> I hit this bug on several machines while they were running 5.11.  The
>>> ghost subvols seem to occur naturally--I didn't change my usual worklo=
ads
>>> to get them, they just showed up in fairly normal snapshot rotation.
>>
>> And there is no powerloss involved?
>
> There could be.  The test VMs have frequent simulated powerloss events
> because we're testing for regressions in post-powerloss behavior (I
> guess this is one?).  It also affected laptops that probably did have
> a forced shutdown or two (WiFi and Bluetooth are huge crash generators
> on new hardware).
>
> Nothing running 5.11 on stable power seems to have been affected so far.
>
>> Then it's a much serious problem than I thought.
>>
>> Thanks,
>> Qu
>>>
>>> They don't seem to occur on 5.10 (up to .46) or on 5.12 and later, but
>>> once they are created, they don't go away without using this patch to
>>> remove them.
>
> It's odd that it doesn't seem to happen on kernels other than 5.11.
> That would suggest it was broken in 5.11-rc and fixed in 5.12, which
> might be a useful range to search for regressions and accidental fixes.
>
> In any case, if a user has been running 5.11, they're going to have
> ghost subvols lying around on their filesystem, so we might as well get
> ready to deal with them in the kernel and tools.


So my previous guess on subvolume unlink and orphan item insert get into
two different transaction could be true.

The last time I checked the code, I'm checking the latest upstream,
which is already v5.14-rc kernels.

Let me try to pin down the offending patch, but at least it's a good
news it only happens in v5.11.

Thanks,
Qu
>
>>> This patch does get rid of the ghost subvols after the fact, quite nic=
ely.
>>>
>>> Some users on IRC have hit the same problem.  One was running Debian's
>>> backported 5.10, which doesn't fit the pattern of kernel versions I've
>>> observed, but maybe Debian backported something?
>>>
>>>>    fs/btrfs/ioctl.c       | 81 ++++++++++++++++++++++++++++++++++++++=
+++-
>>>>    fs/btrfs/transaction.c |  7 ++--
>>>>    2 files changed, 84 insertions(+), 4 deletions(-)
>>>>
>>>> --
>>>> 2.32.0
>>>>
>>>
