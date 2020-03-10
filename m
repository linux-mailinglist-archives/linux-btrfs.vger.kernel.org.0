Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD617EE7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 03:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgCJCSq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 22:18:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:36219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgCJCSp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Mar 2020 22:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583806718;
        bh=tlZDJfP/4Uep1REJOHjJ8t3rWJkZuals4yw6EusfX10=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k6Kqhn+EIbhs/+Z8PTTvRAKCuTKhddnCVCF3Cla2PAh4lwRmAPkWLopN+kyqQMQ+3
         3EDv1RZIYEtJOSZhbeN3Vbs7QgjdbwQuAEfpZswIE8gUQzMdQysxo0ZOEs2hzhdzpJ
         V+3CiQAlQB3wT61SsVu8SQS7a3dOFLfGdVEDmAAM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mk0JW-1jduKb2wS8-00kNUF; Tue, 10
 Mar 2020 03:18:38 +0100
Subject: Re: ENOSPC in btrfs_drop_snapshot with 5.4.21
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <01020170c1c26e04-031eb2cc-f2da-4ba3-b259-986730cfae7a-000000@eu-west-1.amazonses.com>
 <f44d3ea5-7ec5-60c2-f0cb-bb9654bf7d47@gmx.com>
 <01020170c22e02f3-0fac99b3-1cb9-4d17-88e8-4d6bab41d934-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <fd1e84e2-c360-8089-3ac3-eed2cf73ec2a@gmx.com>
Date:   Tue, 10 Mar 2020 10:18:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <01020170c22e02f3-0fac99b3-1cb9-4d17-88e8-4d6bab41d934-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gjf+5K9LEJB7/LMDkRpVkF06mhn+tWRcUvvFLWmd19YFszs+jdb
 +C+KCtvGIGEo3MkGUn8zEe6C4s/kIJyL32U2gW+cChuOBD6+ZesJq4yUyON9SIJD8ah9hgF
 NXxStFbT1+qLv2ENK3KE044c0DAAZt9XNBZzqxbGnenUPiSCErrny2YJz3o+AOorCdwnScD
 lz7UrlYd5kq5ee9ZHJDsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MO8pA2p30II=:aE2qPaEgt2w7INuNNLBl58
 hZNbbLz341XqSISlzSjnhoRl7ChN0/1EjmE2ZJTmkI5vHg4Zz69qGljV2zhF2LPfoYmUc0+n2
 AblacCklVor1IKvwF1Xk65r9PW2FPdbxSBO06wPMWhcQFpSHL/IiupkvZpNc8db0hW2McXhr/
 5n4hYp+JCj+ycL/smE3+072g9H44qf+Tkry5GTwX1o/BTV144gjRUyJpZy/YqWPRnw5+2IM8Y
 43mQWFgwMpil/lseSYuiNJTa8jYxlO3QeMtTdPJU3cv75oq8KTPG+DLj5s235RzIWwUJJHr+P
 ey7nf3eFePD1K1ZUZnuDxPu4QsjsL4d5XReH2mU8a9EJMu8ooukng7AY6A0N0xo7IHSbGP6Rz
 v/tpNKxHNCvyryqQvEOepmBpurpfhjqNOc0YRkvCzYs1ya5TWqWiviCH0WkxQ0wufP8LQbkpc
 f/p4KQF56SOUXuyYozxD7O4rCcQsE8Xv74G0qg2irWHj4U8a/HYJ2csCzicetdRzgeq38yxdE
 nyR7/ywHTLxuxDqy5zouX2ddVqXL9VdXw6n9IfIZgIsjeSlPWiyuF+79vYhh8R0tFyP9CP1ym
 /pcLJXJF1icuAPJmy7JGBtg5R6G8q4fYPc4mK5ebMg4TawsSwHa9LDkjgBqEgII7iR5gWfTl/
 B/T76ucn3Up9jqCyQ/E4Kn936OTxob+xsJogdhR1q+AflgOqugtomxfYSJ/zsWqj1rbh9JKEa
 Obo36WbGdPG4spTMGKfwp/6MEy+/rueoOFSkPoDRLBbofuNZs7YVlnH6Iv3kOLbTUuEXqcWO3
 l/cnec8SlAhyAOrX76TH8sKbUFWEN/z0gOsI8hk/v3yQD/lE4Gg21MGA/3ZtDGYa+7GrHGtu7
 aVQof22ZZA0yauTi7/QBMLlyTPkIOpqnlMShq3XV2hCxajA5/Ez34kZhuiZNiGWlTIB5ZQmrr
 /fIAVLaB/VID3qmxW8OjsVjlhJowEzbdJkHXqAKEDjGOOd7uxUsBNfD0XH+4hVa5NmDKKskHU
 Pv72OpQmnja10WFLXg9xNySSB+wUcFBaCOWwWn5RFdaF8VLFplrohbwpmqlN/Y7AWbSX6wNZB
 jcyAMF0e2sFY7Fx49fozL5x+xq8EBkGj+NIrVENGcPPsfeWsBRKS7DNnbq5iZBNZ035MrFEPA
 t3I8dWB2OdsFhvH82UO8VX8/FHoSdHU7VdAVxytng+kFus3FruxQ8McUyAKzmbg9eMxzp9M2D
 TDJnkm5RZJeQ8p6d5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/3/10 =E4=B8=8A=E5=8D=8810:02, Martin Raiber wrote:
> On 10.03.2020 02:41 Qu Wenruo wrote:
>>
>> On 2020/3/10 =E4=B8=8A=E5=8D=888:05, Martin Raiber wrote:
>>> Hi,
>>>
>>> I get a enospc to remount-ro with 5.4.21. Details:
>> Sorry, the attached dmesg doesn't contain the transaction abort message=
.
>>
>> It only has the flooded ENOSPC from enospc_debug option.
>
> This isn't it?
>
> [76641.627535] BTRFS: error (device dm-0) in btrfs_drop_snapshot:5419:
> errno=3D-28 No space left
> [76641.627549] BTRFS info (device dm-0): forced readonly
> [...]

Sorry, forgot it's not calling btrfs_abort_transaction() but
btrfs_handle_fs_error(), thus no backtrace.

Then it's too many pinned bytes from dropped snapshot caused the problem.

And since we're holding one transaction without ending it, it prevents
ticketed space system to flush and free space.

It looks like the check in should_end_transaction() is not good enough.

Maybe Josef and Nikolay could have some better ideas on this?

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>>> Linux 5.4.21 #1 SMP Fri Feb 21 03:20:26 CET 2020 x86_64 GNU/Linux
>>>
>>> btrfs fi usage /media/btrfs (after remount-ro)
>>> Overall:
>>> =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 511.99GiB
>>> =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 511.99GiB
>>> =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>>> =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>>> =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 443.68GiB
>>> =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 54.94GiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (min: 54.94GiB)
>>> =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 1.00
>>> =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
.00
>>> =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (used: 0.00B)
>>>
>>> Data,single: Size:490.98GiB, Used:436.04GiB (88.81%)
>>> =C2=A0=C2=A0 /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc=C2=
=A0 490.98GiB
>>>
>>> Metadata,single: Size:21.01GiB, Used:7.65GiB (36.40%)
>>> =C2=A0=C2=A0 /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc=C2=
=A0=C2=A0 21.01GiB
>>>
>>> System,single: Size:4.00MiB, Used:80.00KiB (1.95%)
>>> =C2=A0=C2=A0 /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc=C2=
=A0=C2=A0=C2=A0 4.00MiB
>>>
>>> Unallocated:
>>> =C2=A0=C2=A0 /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>>>
>>> Mount options:
>>> /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc on /media/btrfs
>>> type btrfs
>>> (ro,noatime,compress-force=3Dzstd:3,nossd,space_cache=3Dv2,enospc_debu=
g,skip_balance,metadata_ratio=3D8,subvolid=3D5,subvol=3D/)
>>>
>>> btrfs fi df /media/btrfs
>>> Data, single: total=3D490.98GiB, used=3D436.04GiB
>>> System, single: total=3D4.00MiB, used=3D80.00KiB
>>> Metadata, single: total=3D21.01GiB, used=3D7.65GiB
>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>
>>> dmesg attached.
>>>
>
