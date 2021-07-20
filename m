Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138AE3CF359
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 06:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbhGTDxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 23:53:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:36883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236132AbhGTDxT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 23:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626755631;
        bh=5KT1+4dq8N0owxyYnK1PfmyM3qLm1AUHhoh9kXdmwjk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YSibK7eFBjNTzKSz57aB73Zv2OivcGfpDcB2L9RskBmY+XF/fGgAlvRoBY59eN6Z3
         7uoQdbpLx+E7mkRxq0NrgQWcmTpskAJBrBKEG3LFIli10i/Jt9/3LvesFwF/e0uT6T
         v3VUi9+Ew0r5oPvhqgq0vG7jDNNEJbubxmafd4vE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MN5iZ-1lnDGF0pEL-00J3fi; Tue, 20
 Jul 2021 06:33:50 +0200
Subject: Re: [PATCH 0/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove
 ghost subvolume
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20210628101637.349718-1-wqu@suse.com>
 <20210720040542.GB10170@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <306e11d5-60c7-3a30-fd9c-deaddc4eb21d@gmx.com>
Date:   Tue, 20 Jul 2021 12:33:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720040542.GB10170@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qbm5UUHy2pQVE+e+ryd3HdwUpwp+xy5NWbJlTfSKFzVJCNZlkC0
 AhL4HHzfYoSMEEWkRUgKeBKycmvUhGUpwNxOvBlawMmRIj75jbjSmPp7OynxSmYh3VsKZR2
 vsldy1kh53v+OZxXYFna1bx1yI/FPns7VPYnzEKteOVmYorsV1hvSS7YL52wV6TXlf2D/Fd
 nhRrl9y0z90keG0Em0Qhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgKPUVdmHug=:C1C3IOsERJN9TsSYF4KD+I
 scRLpulwd17PueKUBoH9X7c3AP0CCGKgdhA3hJ2N/oEK844oBcSEYcIfppWYTHhkv4+bmyBen
 E/fzZyZFX7uP6mJFbCItivg/oM0V1j1ehMmODEUFD87dLtZcDbRx9JfZ0BY64i7Cw9L40fCoA
 fo0ay8i24aaR/vmp/PcQKlr+dUfihkO4+214GpdqCdyWsmicMJNaHF0zZs8tYUdgaAO+X1pRW
 FLw/Yx24O9FcCORWmsepYsUIU39WCQCK+i7aiAZbTVWpRJeIgZpBqZoPcKZNEGLSLENT/klbg
 Do5uSZiz4dFXCqGcZy/g25qtgsKFiVKwhm3zMGWj1G4MFzyMvCneQI/Ug2YexkA3IM/W19RjH
 ltn1J0FDdPNZhcPAX0GqcLq5r9Opa+t6dk+CyfJOv/0HdwmaPKACGAHtV4cKoezstni6h/JpN
 02jtY1aIfw0WmUqb0VTTSK8Rr1UBY16B2O0a5ZGycG9boB9rIJYuYiKV1MlgIcR2yFlZ2BEpM
 qXwuNX6ue/0B1hwrXXZ+VEbI3kRzCXuV+uXWj6g+O7aPAjCxW0wfKb8xPtRSDtQPMWZi78ta3
 4jCZoPJwAFGOqdD+EYfNZC2mWHKQYorITRN3N4HeOztcWXoCUUwGmVXrSmyRGUWcO4MNHHzzg
 FkLMbYNHOuP5IVqTOrwk/WxO0Fs2O3+dOvhLZEutSTiCTr5Q+Y6nHZihZk9EWsXRUfksAkf9G
 rCAExUiNHV05udh5IGFWR78SQ/iAOtdzEWQycgpbuFu4f/J3BCUu7yvO+sj2d2PX7fMxZk0B/
 nHhqZUQI6H+9H+73k467f+Y24HdqFkCY8Rt/mshV6NyyHQxVsWvZ2BiMryMOypfDGEpaQfPhl
 BBhMGZToYb/yBgyVIdgzDd1q8qSB1R9sI3nZuaYl+5xy9AJ3cPysQVzZW2Bd7z9NsQ1G+Cna2
 ov3YRZzenGUQdE8u+a40GhTS1o8AHEGy6VSWgdo9i4kDgtRXP0Q3bIs43bBKl6EZgF2trBqbo
 /Df3Cp+5dOi4rL1TFD9Mp8ewgnoLgHBwQ4o+2S7QSLQbHJdqWWX8neaQ4Elbpb1kjkGmb8ccz
 4gKbIeuVXBMWHp0BBLdlfBEEZDJl0R1vi0bkks2zMqU+JW8q/IDvWbKpQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8B=E5=8D=8812:05, Zygo Blaxell wrote:
> On Mon, Jun 28, 2021 at 06:16:34PM +0800, Qu Wenruo wrote:
>> Since we're busting ghost subvolumes, the branch is now called
>> ghost_busters:
>> https://github.com/adam900710/linux/tree/ghost_busters
>>
>> The first two patches are just cleanup found during the development.
>>
>> The first is a missing check for subvolid range, the missing check
>> itself won't cause any harm, just returning -ENOENT from dentry lookup,
>> other than the expected -EINVAL.
>>
>> The 2nd is a super old dead comment from the early age of btrfs.
>>
>> The final patch is the real work to allow patched "btrfs subvolume dele=
te -i"
>> to delete ghost subvolume.
>> Tested with the image dump of previous submitted btrfs-progs patchset.
>>
>> Qu Wenruo (3):
>>    btrfs: return -EINVAL if some user wants to remove uuid/data_reloc
>>      tree
>>    btrfs: remove dead comment on btrfs_add_dead_root()
>>    btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove ghost subvolume
>
> I hit this bug on several machines while they were running 5.11.  The
> ghost subvols seem to occur naturally--I didn't change my usual workload=
s
> to get them, they just showed up in fairly normal snapshot rotation.

And there is no powerloss involved?

Then it's a much serious problem than I thought.

Thanks,
Qu
>
> They don't seem to occur on 5.10 (up to .46) or on 5.12 and later, but
> once they are created, they don't go away without using this patch to
> remove them.
>
> This patch does get rid of the ghost subvols after the fact, quite nicel=
y.
>
> Some users on IRC have hit the same problem.  One was running Debian's
> backported 5.10, which doesn't fit the pattern of kernel versions I've
> observed, but maybe Debian backported something?
>
>>   fs/btrfs/ioctl.c       | 81 +++++++++++++++++++++++++++++++++++++++++=
-
>>   fs/btrfs/transaction.c |  7 ++--
>>   2 files changed, 84 insertions(+), 4 deletions(-)
>>
>> --
>> 2.32.0
>>
>
