Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4C428030
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Oct 2021 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhJJJXw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Oct 2021 05:23:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:60109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhJJJXv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Oct 2021 05:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633857712;
        bh=Bl/vCBm8jZ1FVSyNaON5bDlIrC3OfPDh5y1xLuqOQRU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=EEvHA8YvXV3pppgK8Hc276CynwLuZtOGwlZMYunq2UqPfzR1QPW5IwRwJl9PIfWC0
         2alXvpzzI2ha2niVJ9RhzaSCrEGpyZCx+PC6E93W3HwUrmGcouATKymtZ0uHsuzMMn
         JDY6JDYwXNYas4U9zN1V9QNyKpvcgPFIKiuI17i8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE27-1mJuFQ1xxT-00Kgfk; Sun, 10
 Oct 2021 11:21:52 +0200
Message-ID: <fe7552d5-b9a9-fb61-dd6f-7058537549f8@gmx.com>
Date:   Sun, 10 Oct 2021 17:21:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Bug / Suspected regression. Multiple block group profiles
 detected on newly created raid1.
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     FireFish5000 <firefish5000@gmail.com>, linux-btrfs@vger.kernel.org
References: <CADNS_H6MvByBaYQ7h94DMVQUU9ZjANN8bz90km_6DZykBh6mxw@mail.gmail.com>
 <08f71656-b775-3fe0-62f7-f04c44501858@gmx.com>
In-Reply-To: <08f71656-b775-3fe0-62f7-f04c44501858@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Av8UT90UHZyXWejcvQyWINFOkaiEhD8otY24L09w6+jwQoj4pge
 wwQgfPyOgO3S7X6nPu4sfc74yet4G4+WxRlAgriZWMrTEF9c3IRHS4/zJPk70U8SvKVeSY1
 G2elU0mJE1vza7vxdcq9Oq0xWcrvM45+Oet1v5/5pkKKx5efQJWp62W72MR6ikmH/SAFxxH
 q/TspvOoUur2qMKAYzMGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WXegw+2iTXw=:HybzIU6ePU81NUehkyuq/D
 Am2I95VxratKIg3C+FyHUPerdtVZVj2SiE3t1MVb3lgto5aP29TEcrG/6tT6MRCeWqQN6AYAX
 Cb12Sh6JuOVBiiGutCs0VtND+j4bsfEuBfxys/BIUqu8/5ytaXqtf5H8sXrSBmcFhAUUmRkZi
 y2fmmXG6Lln0K1yJettgHYw3huTVZ8hEitszXKyVhHE/4penU3QqCUo5c1eIFxTB3AyG8+ys1
 LofeL9hRsOKmER9+/XMi0ZYxaorDYXN/8HBJzi/goB1fCuzJ4q25RpjMeUwCnNPWfQfDtGLSD
 1ZsptCiWxofBx6SKTmcyhvklEnWt9p4KgZxSaFRx1PAbZzE6a4CNmbrs6++H+d41g6L96M4Rh
 JPX8CqVmbT0VR6wHvPA24JChuiYF8DA11oAUCrowimeTYSakkY/ozgrSbeicTgs91iDxqXoGk
 Oo1MMrccdNeQ02sJ1n3f77vqT0yj493sz4ZgQ7eCh+4OIp6EzEED7ylIsQqCkNoW/6Xg0ybuQ
 bXx4OKtyqh0fXXXqeYwCfNjLdvJscR4KoBeUF5HnPzI3YwrVx3sEXU9isAEqhLfThqky2opTS
 k7zqr/0SK6vmzQAZc+OawQsON917RwsBsF5j1YO1yFCdroVDe3H+7JnkSit6aHhMIp5/YoqMa
 7ULIRMfSlbsNM7g5208IP5LexKeRsNO5o9zg7rZAaUBEvDLphMUZNhvz9QEB4xAmAC4VzmnRc
 pcPVJwCeflHVPYeY6/VWj5r2brh6Hi0aOf6OaZgGce4ADJiWQdsT+rWaRdNOXOrA4dMPr5+5Q
 +KlVbak00drnx549kYledE3bJDia7uBDD/AXmTOyBKIJdvgKIgL2J6QkhrtxlDGJCPIfRSXO6
 Zrjat62OacJFbw9165DH5uo4pNZcUgVXvk3/JNwgiczVH0IpgoL+h8ebJiwSXzyq/KHeqAUh2
 HfzA9UDkb/sM+a43BjTZGF4IJeOWbCXDiajM24wvk3WuaN3/dYyJ9YSHr9vWMd2uLxiQuCBet
 HKPiitkJgI5RPRlRYlduq1xSnLEX/G/6tJgUOzTNZgR6+fEWder7NrK7QwmDAAh5ol28saXdi
 RcXkNSFH9YAHMU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/9 20:19, Qu Wenruo wrote:
>
>
> On 2021/10/9 19:44, FireFish5000 wrote:
>> After creating a new btrfs raid1 and was surprised to be greeted with
>> the warning
>>
>> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
>> WARNING:=C2=A0=C2=A0 Metadata: single, raid1
>>
>> I asked on the IRC, and darkling directed me to the mailing list
>> suspecting this was a regression.
>> I am on 5.14.8-gentoo-dist with btrfs-progs v5.14.1
>>
>> I have attached a script to reproduce this with temporary images/loop
>> devices,
>> Along with the full output I received when running the script.
>>
>> A shortened version of the commands that I ran on my *real drives* and
>> the relevant output is also provided below for convenience. P at the
>> end of the device path was inserted incase sleepy joe copies it
>> thinking its the reproduction script:
>>
>> # mkfs.btrfs --force -R free-space-tree -L BtrfsRaid1Test -d raid1 -m
>
> This seems to be a recent bug in btrfs-progs which doesn't remove the
> temporary chunk.
>
> You can try the latest v5.14.2 to see if it's solved.
>
> If you want to use the fs, just do a btrfs balance with "start
> -musage=3D0" should remove that SINGLE metadata chunk.

OK, I also confirmed the bug locally.

My initial suspect is the recent rework on free-space-tree creation, but
simple "-R free-space-cache -m raid1" won't create it.

Surprisingly it needs both metadata and data to be another profile to
trigger it.

With it reproduced, it should be pretty soon for me to find the root cause=
.

Thanks,
Qu
>
> Thanks,
> Qu
>> raid1 /dev/sdaP /dev/sdbP; mount /dev/sda /mnt/tmp; btrfs filesystem
>> df /mnt/tmp
>> btrfs-progs v5.14.1
>> ....truncated....
>> ....truncated....
>> Data, RAID1: total=3D1.00GiB, used=3D0.00B
>> System, RAID1: total=3D8.00MiB, used=3D16.00KiB
>> Metadata, RAID1: total=3D1.00GiB, used=3D176.00KiB
>> Metadata, single: total=3D8.00MiB, used=3D0.00B
>> GlobalReserve, single: total=3D3.25MiB, used=3D0.00B
>> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
>> WARNING:=C2=A0=C2=A0 Metadata: single, raid1
>>
