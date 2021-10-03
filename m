Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDD141FF34
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Oct 2021 04:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhJCCYn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Oct 2021 22:24:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:50495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhJCCYn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 Oct 2021 22:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633227774;
        bh=R1wdH3OfGsbi1zf+iDNUWeB42TbwPjwBry6A0LjKIVk=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=hZiPI9zV/CLRQPt1olvvuEpNIQhBeS8eeR0Fz1sWHLgrcHxwDCmHp1U9mhpF9H67R
         bAne0GuLPUIwwq/DjwuI1p+fih1Ot2fr5XeZPziRusoQD4wdsw17QgpNLqxBgEiOeD
         qH43oPIQXU2fBBeS6sLtBN/fwCRjs+umASQLkbFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MI5UD-1mceIU45Lj-00FAQ4; Sun, 03
 Oct 2021 04:22:54 +0200
Message-ID: <7df50802-a70a-d468-0b6f-de08edceab33@gmx.com>
Date:   Sun, 3 Oct 2021 10:22:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     dmzlaamx@gmail.com, linux-btrfs@vger.kernel.org
References: <001201d7b77f$74fa76a0$5eef63e0$@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Filesystem Degradation and transid Verification Failure
In-Reply-To: <001201d7b77f$74fa76a0$5eef63e0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:byUXo+EFJKzodDBhlvk7cNOQ06NpW2jYtANrtqWL6uHGHWx9EDC
 kpPDU5PVyGDSuEfwkVm7Va0aSmTOpjJJKo69khzQLrKSVW9EcCsyMhi90TvdnW0ybjWDjD6
 /dQwo5fQpOAhb8wgKehHm8NxRMV1ORuAEPQG+OS3HRR5eV0l+xxTMbZNuVK8gzktS/2yLzY
 xnLG6U1xA4FBFUq2SIEgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7RXrIEip7s0=:ehYuNnNkGoMDI/8gKypm0q
 1Huauex5v1eppuB7NiEy8TBypxT8XqFUrfp/ICO0csR9dehKqsDz0xf9WLVwsnkyedJlNfJQ6
 Id7ZPNK6pacF4TG+9aAuE1F96mC4Hq4frMXyGzpcySGdSm7FiPiYf2AzYRBLHV3JSLtQgAFBP
 Hyz7eEskta3hxBYdFM0ixllLwjs/v+fzER1LH2S++0bIn42Gy0wI1w6ygk0ENIXSc8wk7nil3
 8fMQaKMaUYfNcWjW6PU3aec9pTbzcgOGM8afQ9mfL6MfPcauy1kK1kWrtUnftyEXQuewTLmVE
 SBCsxkD5VluWWXKb5RaemMMMH05BrLp85fy4n6LwHi4qYdz749beMWDc3kfXGFsIAL4BjZzqN
 E8NQKJXB9kIYL8hExnCAmjhMk2BedBD5Ps03V3ysBOHVlgQJzpanPZ6jAYj2W9Qmi+d1qe1SL
 TzW+2/d2snOk3U/955UkAIMC5u23J/7T3S6X4zfrg3fIgw0r+v9F7u3mUUaFrWZC8mP8tqskf
 VS3JnTcdSPW5j4Bj/IbfWyGcs4DqaJawSIllSWT2aEIzXjdqoaJu41Nw1LUxvtlBfiQBKzz78
 A5tlQWoeX6b7IByi+1ncmO147BEGUsXk+FSGsEFGKtxihVKL4aKr7GmMvIsGZTFUhQDDwxWry
 fZ65r41YlRtjvC7gEN0JFhpJIkodZFT83ne+19pskb8/if8QEbyYDj+HzxedJCidwFOrrp+99
 jlXJ6S4QIvhtxp/UFpYZRayGL8FxGd7tc9cUA7Y8ea+MoEtyknrsJj7iVQ/1MJfj3kZ3FO5xn
 t0H+MPBQ89LqNva7+bUenC4IxtMs+BBHCFpa/dhE4ECGKnv+byvvrypedg2CXhaXQR2aqeHkZ
 /Bv/pXSr1UZemUSbwPsdpL1gFMkzxnqQNV5FEXsEx4d0scjqb+8s7ecXYMdeKjtjE5CyAcBiW
 UIfS6vkeWWukngZs8Rx4aCUbzdYwol3JVSSVls+Q80RAl3vOzpYgc24nWYXT7IMn9fUjeH4Vx
 2/Bg3vAaiyBbhcoeTl5NDsyVYCwQ/YImv/UGbOgovPyIz6yMZyBdmXXIwlUYQwYsBbKKOTyjV
 T2dAz72gyAn0GA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/2 19:20, dmzlaamx@gmail.com wrote:
> Hello,
> I must preface this by saying I have never used a mailing list before so
> please forgive any lack of understanding of the protocols and standards.
>
> I have been having a lot of trouble attempting to recover the filesystem=
 on
> a single 6TB disk. The drive can be mounted, but certain folders return
> =E2=80=9CInput/output error=E2=80=9D when attempting to access them.

The error is caused by transid, and according to the expected transid,
it's a missing write.

This seems to happen either you have mounted with "nobarrier" mount
option, or the device has non-reliable firmware handling FLUSH/FUA command=
s.

In above cases, a power loss can lead to such problem.

Mind to share the hardware model and firmware version?
We're trying to collect such known bad HDDs.

> I have attempted btrfs check, recover, restore, and rescue, and have man=
aged
> to recover some of the data =E2=80=93 although the folders which present=
ed issues
> have not been recovered.
> Btrfs restore returns transid errors even with alternate roots.
>
> I want to run btrfs check --repair, =C2=A0but before that I want to chec=
k if
> there=E2=80=99s anything else I should do before resorting to that.
>
> Supplementary info
> 	uname:		Linux eros-station 5.12.9-arch1-1 #1 SMP PREEMPT
> Thu, 03 Jun 2021 11:36:13 +0000 x86_64 GNU/Linux
> 	Btrfs version:	btrfs-progs v5.14.1
>
> The results from the two other btrfs commands are attached, including th=
e
> first few hundred lines from dmesg.
>
> Should I attempt repairing the filesystem, or are there other options I
> should try first?

No much thing can be done if you have already tried btrfs-restore and
got nothing you want.

If you still plan to use that HDD, then we recommend to disable write cach=
e:
https://btrfs.wiki.kernel.org/index.php/FAQ#I_see_a_warning_in_dmesg_about=
_barriers_being_disabled_when_mounting_my_filesystem._What_does_that_mean.=
3F

Thanks,
Qu

> Thank you
>
