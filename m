Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59644DED0
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 01:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhKLAJM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 19:09:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:50327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233817AbhKLAJL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 19:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636675578;
        bh=Yt7X/ThVJM6nNxFXiN5wGZW50ZI68BS7QpY+dKwTszA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ND4RhsL6lSwPuVmnkyLLsR5KJ0MeH4bZ7DjHAogHsjFrcN5zSCVyJDUG48VykRv5/
         VfEH1AJQdLkwt5AWJFxpf8rVXqGENIggL3xzftwu19JcoMpaqmacMxc7Ved4+qBGxy
         FDoQZXnX7hH+DkY+Jiut71mfPeh/MJwQ/IZBF2PM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGN2-1n2Qxg0jZO-00JIxA; Fri, 12
 Nov 2021 01:06:18 +0100
Message-ID: <873ea73d-c3ab-9471-de22-5555980ce1ee@gmx.com>
Date:   Fri, 12 Nov 2021 08:06:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
To:     "S." <sb56637@gmail.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
 <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
 <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
 <1f4db1f5-2f37-0074-cbe8-e78ba7836587@gmx.com>
 <4f7be37a-502c-6ee1-2519-29b84810999c@gmail.com>
 <725543aa-029d-c22e-0ac8-bc77637c0474@suse.com>
 <e19518ec-a885-4a1d-1dda-a5be645a1d73@gmail.com>
 <73fb26b3-932c-9592-bced-6a3fda3456f0@gmx.com>
 <fdcac254-e169-7aba-7a12-c828aaab3231@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <fdcac254-e169-7aba-7a12-c828aaab3231@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lpxjnmbVl4pUvR1VT7VM8XnjdO41ttbrdSVWhBHPmU8JWHHM5Gi
 f1FXZuj39/Ercry1kSqQin3uhHd9SAQTcK9oQG3dITFttKotAnHmqYZLq1st/jz1LCDGWQh
 ksRx8QgQ98nH+BzRlUyybn+FBwvsvg+MqHdVr+vXmr+JVq5iSOG6pI86N9dlQujbt1fyl6+
 dfXdTSEuaA5hkEE1Aa2jA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UP4kajLpfsI=:F2lHfLkUVJ/y1lAS4zO+qI
 kwE5pNAigZg9dXYddIzIJNXqua8PjLKSkbUn7FXKN2qaiH7Sdn/zQu5fykOmc7pQKj6WnHy+q
 ZTc8jVMAQvhel5cUO5TXKCHhCHflM+16P7bFFn2gkY4u8JA9HKKZl8gSUQy/BqyP6EjCgT2Lc
 6R4f54uQLwff2H3iqhsnbh6zgCyIu5+cN82w9nRobe8zv8zUQbGPs3GNF/U4iJpPPAnRVZ75I
 mF6U00NuAXF4abTHDp/MEvoClzzEh4dOfXSMo39MC5gzCCNOW+Ae3Mu9wSI3ljegf+LpuprWG
 KnP0NynlStqtusm9AICOd+Ct6xeG0PxPXpL15Xo849eH4nsLUy1QH0IAoemKzduQRGBAyamt4
 9g7JdetV1x5Phy/L5BdqpwvifdvtstCLvhO0fEQTMVIhGG6VJGWqosoJRQT2X33D2QE1JnDqc
 MaRIJEQIpcWedaGypZ5UDt4ZzOionEt0stV5Fb5U0a6s9N4KOxqNDAfako5kq/XrG1Puis6Kc
 fBNdYM3M8tATQWBp6jl9OgJHjMnaldloTu872rxMOEELM74/XN83IfBZoPFZJ6MvbvxcCfhsD
 BI+o519BtLA2RUTA5RjouLuWH8Y+VFtHFsJkurU0wDzbgVA9XdC3p6I5U+o1midxpkuz/94Oa
 In2hKhpNB/c/ZyxFnfAt8NyKNB2ZsqC//PXmw5YJq8xIxQwZs6m5aAbpc7V5op+rfcAbebC9M
 uEa7HvwfBICiXT+32ksdUwZFh1HZCNWeZFrxFQ0umKB5YYpw4hxlTPdzqZ4WJZ7Jehr/IuLJZ
 qAvrdnGP/l8RT9NZSwqRE0FnZB14dCuz/aDXBfrk625V0jSTNyTEWyYE+INphUdIt8H+MNQFm
 8oTtOjpjYFgCz3esGgXfpG9NjeiY4VA6g2f0CJ3Y4uYP8IrDx2pmJQ/HahJeg3sBirrveQyfX
 4h4qqiBRFunOuLoed0UUG4p6QxA1vzqbHZvrzAJVfpCvUmOboCo8cZCWwnNvlj2Prk2ZyLXXf
 NohYJekEUZoeJbc6qDFJbP9KiDVWwprZGPiddlkz1OTqytAKU0inhP5c8WMxKsBTbo7P+KRlF
 jqBmYJTWp4v1nA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/11 21:55, S. wrote:
> On 11/11/21 02:11, Qu Wenruo wrote:
>
>>> root@OpenMediaVault:~# dd if=3D/dev/sda3 of=3D/tmp/mirror1 bs=3D1 coun=
t=3D16k
>>> skip=3D149487616
>>> 16384+0 records in
>>> 16384+0 records out
>>> 16384 bytes (16 kB, 16 KiB) copied, 0.305711 s, 53.6 kB/s
>>
>> My bad, this copy should be from /dev/sdb2, not /dev/sda3.
>>
>> No wonder both copy doesn't match.
>
> Hi, I really appreciate your help to fix this. I am attaching the new
> `mirror1` image, generated like this:
>
> ------------------------
> root@OpenMediaVault:~# dd if=3D/dev/sdb2 of=3D/tmp/mirror1 bs=3D1 count=
=3D16k

You missed the "skip=3D" parameter.

> 16384+0 records in
> 16384+0 records out
> 16384 bytes (16 kB, 16 KiB) copied, 0.274943 s, 59.6 kB/s
> root@OpenMediaVault:~# rsync -avh /tmp/mirror1
> sully@192.168.1.14:/home/sully/Desktop/
> Password:
> sending incremental file list
> mirror1
>
> sent 16.49K bytes=C2=A0 received 35 bytes=C2=A0 3.67K bytes/sec
> total size is 16.38K=C2=A0 speedup is 0.99
> ------------------------
>
>
>> # dd if=3Dmirror2 of=3D/dev/sdb2 bs=3D1 count=3D16k skip=3D149487616
>> # dd if=3Dmirror2 of=3D/dev/sda3 bs=3D1 count=3D16k skip=3D170459136

All my bad.

The correct command line should be:

# dd if=3Dmirror2 of=3D/dev/sdb2 bs=3D1 count=3D16k seek=3D149487616
# dd if=3Dmirror2 of=3D/dev/sda3 bs=3D1 count=3D16k seek=3D170459136

Thankfully, even with the wrong command, btrfs has enough space reserved
at its beginning, so your fs is still untouched and very safe.

Thanks,
Qu
>
> After writing out your fixed `mirror2` image with the above commands I
> get these dmesg errors when attempting to mount it:
>
> -------------------------
> [=C2=A0=C2=A0 28.859193] BTRFS info (device sda3): flagging fs with big =
metadata
> feature
> [=C2=A0=C2=A0 28.866209] BTRFS info (device sda3): disk space caching is=
 enabled
> [=C2=A0=C2=A0 28.872507] BTRFS info (device sda3): has skinny extents
> [=C2=A0=C2=A0 29.053000] BTRFS critical (device sda3): corrupt leaf: roo=
t=3D9
> block=3D170459136 slot=3D0, invalid key objectid, have 11018354394740573=
44
> expect to be aligned to 4096
> [=C2=A0=C2=A0 29.067527] BTRFS error (device sda3): block=3D170459136 re=
ad time tree
> block corruption detected
> [=C2=A0=C2=A0 29.120141] BTRFS critical (device sda3): corrupt leaf: roo=
t=3D9
> block=3D170459136 slot=3D0, invalid key objectid, have 11018354394740573=
44
> expect to be aligned to 4096
> [=C2=A0=C2=A0 29.134781] BTRFS error (device sda3): block=3D170459136 re=
ad time tree
> block corruption detected
> [=C2=A0=C2=A0 29.143568] BTRFS warning (device sda3): failed to read roo=
t
> (objectid=3D9): -5
> [=C2=A0=C2=A0 29.239873] BTRFS error (device sda3): open_ctree failed
> -------------------------
>
> Please let me know if you need anything else. Thanks a lot!
