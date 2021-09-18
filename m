Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417B841055E
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Sep 2021 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhIRJUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Sep 2021 05:20:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:54491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236271AbhIRJUd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Sep 2021 05:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631956743;
        bh=trJoVO9liv/FmpWlRFV6LUTFYwA3bRUMw5+IUoeFYpI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fVM8rzsLPj5v5OOT+8XavhnMzreebW5xtblv2R++Jg4YkkFYYC2S+cY0afkZSTVph
         dsfiH2Rj4C97xllnnjSVRp3i0ti2R3JEjHOA7G7CWPxK6oPzEcFCicwwj7+4kWqwJ0
         EYmxsIHq6F3AE+93BAzuxCDad/DY/kNTsBQkv85U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33Ib-1msd8l3N2j-013LXc; Sat, 18
 Sep 2021 11:19:03 +0200
Message-ID: <2806d9c9-c63d-db55-0ab7-cdb385d7154f@gmx.com>
Date:   Sat, 18 Sep 2021 17:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Unable to mount btrfs subvol with a new kernel
Content-Language: en-US
To:     mailcimbi <mailcimbi@gmail.com>, linux-btrfs@vger.kernel.org
References: <9c56dfca-2551-22a8-e6eb-86f0614bc5a8@gmail.com>
 <baf97f70-9592-1a8f-972b-e77c4ef01a8c@gmx.com>
 <23c6a975-cb16-0fc0-03e4-3be45348ca1c@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <23c6a975-cb16-0fc0-03e4-3be45348ca1c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EUDIo5iBRJVzsP/1gF52Jgpw409bO/3ENwIJmBGKk7hfmB+6mn6
 VB+thHtjWCDMXmdV05vVU1yYyP5xvgOlLheh8Ttwr5bGWSlpQrSQAGLmrItTCkmHN2Dyi61
 ZRwqIycznkpdb0X6wT0QqbrY17qpTAsIqltSN3zLHnD3TGdjqe5beBerlDXRgmN25qWmKpD
 aHAsEt2pjndWx3USW6S+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/7cgce8jv4s=:lw8oeCFx8M52ToFPQdY3Or
 L8vWx/yD26+phUYasNUaFIJyIbMoqZivFy48VUcfyMvxc/ktyTjkO2YAo1TX7voiXJV0G5dk3
 3AifW+PXD+Fr54ZDCnVw4QBh0GXpR/4ufkVPvhDBhmuYtWDig8StfsvPpJAlLurzdAKvPF8pe
 +A5a6SR1QdqFDyiIfuSUzxKQmZoKUc7hwa3yu05ze1WMBEX3D5BzgNUax6twCnJJaBKLO2cnB
 rMkOe4jDZhHy7xX6AAK3QuKYdd9F8Dtl6Zc3dEprvvQFow/hbmygBu9k9Dg69u360/tBFWU29
 KDVzWuALtPWX6z/5FKI7cl+XzBb8HQIfY5grriHywI3lqabPWhFP5sUREZ6cCPfb/AgVWvVui
 KVjd1/7cKEeXZlGVU2Y5RySKK/iAeMWZVdd9zdXuPPgINmeOM2H76OLBjWx44njk5+s5tsxel
 agpIrNpazzF5E5JZSymq3IrlZ7q9y126umSjRVmqK+p9BxaWraEAqp8WxwyzT2kYK8HKlrUgu
 c5Mtw0sIlvvZbp19dl4RyIi9WqPBTndHRPjqH2+icNWnaOnwXMNRJ7GeI936yeleebqQGE9UO
 Yt/qH6DRO5WMjaHikC3QVyUhW8ohU03ga5VtRI/O05o9Sx92SNHM2CHFBgiLe2mB7+XQhTA0J
 2Ke/nJzmw2iAau5WMTTl6cMbBPCGfOxH/Ef/57vKUll9LdPfCT/aCgEUmtolw+uoJgseh591R
 Ds397LgOCtCLUdFfeJmRcNIJD67rRWx1U+CcKNgD3xUpTW3rw2xbOGbCI3fG75LT+9+fm/K7m
 CpKX8sFZ5kSOvJPV6zOgCLF1g0JF1OQXIszKeCwSIqHKZFRxrItBT+Ixuf6WllexrLWvDUtK8
 MVnswAc2dCwW6SCC04XCEyw9ThZg+QyE8qPp4LPxB/6SFIsOdObADWG9Rp6U+9HEfLSlnJLie
 iwBQeLhJqn97lImc6VvrYLz06NLC4/ji5mke77fxv1bBM58vljTj/4ADDC44fQTddti66C1VI
 +A2VYmKcIZd6la+ScVwOTinmpDzB7FRjUpgR/Dltdnpfx0XL4kA+fOh+OO3C5VvNQLxq6UJra
 YKij5XIp7NXC+8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/18 17:16, mailcimbi wrote:
> Hi Qu,
>
> Thank you for your answer. Check and repair with a new btrfs solved the
> problem. I was able to use my subvols with new kernel.

Just a final recommendation, use kernel newer than v5.11 would prevent a
lot of possible corruption in the first place, as in that kernel version
we introduced write time tree block sanity check, which would reject any
corruption (at the cost of transaction abort).

Thanks,
Qu
>
> Thanks
> Miklos
>
> On 2021. 09. 18. 0:18, Qu Wenruo wrote:
>>
>>
>> On 2021/9/18 00:17, mailcimbi wrote:
>>> Dear List,
>>>
>>> I have two btrfs subvol in my fileset. I can mount it with lubuntu 18.=
04
>>> but unable to mount with a newer version. Also unable to mount it when=
 I
>>> upgrade to the latest 18.04. By the way upgrading to 20.04 (using the
>>> older kernel after upgrading to the latest 18.04) and starting it with
>>> an older kernel it is working.
>>>
>>> I can reproduce it. Starting with lubuntu 21.04 live cd: unable to
>>> mount. Starting with lubuntu 18.04.2 live cd: I can mount it.
>>>
>>> Here are the results:
>>> lubuntu 18.04
>>> root@lubuntu:~# uname -a
>>> Linux lubuntu 4.18.0-15-generic #16~18.04.1-Ubuntu SMP Thu Feb 7
>>> 14:06:04 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
>>> mounted btrfs with live cd
>>> root@lubuntu:~# mount -t btrfs -o rw,subvol=3D@ /dev/sda3 /mnt
>>> /dev/sda3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28G=C2=A0=C2=A0 14=
G=C2=A0=C2=A0 12G=C2=A0 55% /mnt
>>> root@lubuntu:~# mount -t btrfs -o rw,subvol=3D@home /dev/sda3 /mnt/hom=
e
>>> /dev/sda3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28G=C2=A0=C2=A0 14=
G=C2=A0=C2=A0 12G=C2=A0 55% /mnt/home
>>> root@lubuntu:~# btrfs version
>>> btrfs-progs v4.15.1
>>>
>>>
>>> lubuntu 20.04
>>> root@lubuntu:~# uname -a
>>> Linux lubuntu 5.4.0-42-generic #46-Ubuntu SMP Fri Jul 10 00:24:02 UTC
>>> 2020 x86_64 x86_64 x86_64 GNU/Linux
>>> root@lubuntu:~# mount -t btrfs -o rw,subvol=3D@ /dev/sda3 /mnt
>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda3,
>>> missing codepage or helper program, or other error.
>>> root@lubuntu:~# btrfs version
>>> btrfs-progs v5.10.1
>>>
>>> =C2=A0From the log it seems there is/are corrupt leaf(s)
>>> [ 3231.406914] BTRFS critical (device sda3): corrupt leaf:
>>> block=3D1045233664 slot=3D17 extent bytenr=3D20209664 len=3D8192 inval=
id
>>> generation, have 895434752 expect (0, 3790778]
>>
>> Bad extent item generation, sometimes can be caused by older btrfs-chec=
k.
>>
>> Please compile a newer btrfs-progs, and run "btrfs check" to make sure
>> that's the only problem.
>>
>> If that's the only problem (some problems like missing csum or missing
>> holes can be ignored pretty safely), then you can use btrfs check
>> --repair to repair it.
>>
>> But please keep in mind, latest btrfs-progs is needed to do the repair.
>>
>> Thanks,
>> Qu
>>
>>> [ 3231.406922] BTRFS error (device sda3): block=3D1045233664 read time
>>> tree block corruption detected
>>> [ 3231.406971] BTRFS error (device sda3): failed to read block
>>> groups: -5
>>> [ 3231.409566] BTRFS error (device sda3): open_ctree failed
>>>
>>>
>>> Do you have an idea how to solve it. When I try to check the subvols
>>> with btrfs check all seems to be fine in 18.04.
>>>
>>> Thank you in advance.
>>> Miklos
>
