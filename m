Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B749B2B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 12:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380649AbiAYLIX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 06:08:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:56823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbiAYLFi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 06:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643108723;
        bh=cy866l5ZLCYWb7Vzh7PD5G1vQyb1xTTeIWWO5LqOkXA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XUvKqbr13atQITblbM1BE0gR9/d+nUt7nnjR5zWE8c5m+LLGaa91cHoLAOk4/bn73
         m/X9VbZ+tVYSRQTfN+jHv5xqtyB+j+7S0V8Iqt5SjM/8LYf1e2UqsRHHo8vOjUVM1F
         +XDfV4s1nAIDDfj17NuRFS+P+6Atojmydrv8wIsE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7QxL-1mDLmY0SdR-017o01; Tue, 25
 Jan 2022 12:05:23 +0100
Message-ID: <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
Date:   Tue, 25 Jan 2022 19:05:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper
 defrag
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?Q?Fran=c3=a7ois-Xavier_Thomas?= <fx.thomas@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220125065057.35863-1-wqu@suse.com>
 <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZkoYmOTrlcwvwn0FnIISrlw/Ucg9Ek2yyd8tVcokeZlzXj/pnep
 ED4rO62Lce7yYqxLjLfovykq3wy1WwxhP+YByKl80tOpvednxDpzZOgTRRHslBIjcnHwhRz
 olekAxJIaw4WhSO7vx3K7ry68Yqj3zu+uVv1wr2leFKT9DzqvtUkjSGapYjha7yZNJNJTtC
 VEAxY8jD9ktPEvqka2zKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F2xwhQi0+Rc=:l3knY3DujOU0912fbelff9
 LrbloiMR3dqjsc5Ig73wmegIITRxw5DZlorxEkBLYYPEfa2cp1esg7vas4pr8kw1stBCizug2
 2wWgocjL8SnbOExxVRnAxrkYlPtN41P1yrM4maN/0OTJMHZYxgas0SFNKtbB7fgx3ZhS2rVNa
 BOcNTG2ASp21VurbwEMzS5UDDVJSO0tv9CeOm5C3/hMYx/nX/MQ/eeqnJHk8eYgfsuDnjjzP5
 k2zNiHpLHgHEEle2fZL+kp1RgNj6i855kQtqNT/V0tawHnUxwO01Uk4ry+f4cV8nl42SWpymy
 HqbcV1Acb+mttXhbSI3q+3nJCN2QoHVx0rRDhF36voblMucjaHgt9i/AU8+KZFFj7vfQLQQuo
 OHo18PPomphjM7trVQ1HY/Jedj0REPHjl4zjBN3pqFzf8qSdow5IIrEbLijIgIrwsiqQrgXHB
 simAqinPq0JchBEWqkCf+njBf34o10fhMDXeMqGBfltYHsvwRlYCj84E3EdyiVKPrRwmMzArM
 YKyTx420xb2aCYN+6lz9eI5ETBUjjLm69aGi9CiIsiLz32jRPNiKR7TlZmJ6M97lw1wmvRL8q
 QLtq8aRQ/X4oA6rQSZpeMehxFZ39AIoYAqacdKTwHMtCH+eMGJC7t6x4kOIRzSucA7e/uPYqM
 ng4LFZ+yr+jx3+Hx7IdgzK9sEu2R6mpzRF8i9OKFEOkyWotbGLj828/AOCYSotLjBWn1n/kfH
 cOhEzBpM1Y9gRkq4fiayh6gOZ69OftF6A86thIUATTxcZNZCgm609SYHjtcQH4u6rzS/pXQ/m
 gHfyBNrSWNg4FChLFUC4+3F1zIngzc0wM24jF/3P6mn5zHQHUkhFw9PVlppcnKwQVWvAHzJFR
 pacuNumuta8W5flDbFu3mAT8h22e721wFmD7/2vU5qaTJgKDPR4i03zwmJi13U4t+Xxh5X/JG
 Ya/ifM8D5khzMXMwX45ZkDCkJT8uZ/tE6fCMf6k27N9HgI0GI1vmEl0P191giiAzAZcWvAko3
 847m3WrwtxvkML7j9xFQJYg/WesNw/EELV/erNVhFMx/e3vcPi+ZAc5zVNLmvAK67cdELeV6n
 v1q0hFvVHbikUA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/25 18:55, Qu Wenruo wrote:
>
>
> On 2022/1/25 18:37, Filipe Manana wrote:
>> On Tue, Jan 25, 2022 at 02:50:55PM +0800, Qu Wenruo wrote:
>>> ** DON'T MERGE, THIS IS JUST A PROOF OF CONCEPT **
>>>
>>> There are several reports about v5.16 btrfs autodefrag is causing more
>>> IO than v5.15.
>>>
>>> But it turns out that, commit f458a3873ae ("btrfs: fix race when
>>> defragmenting leads to unnecessary IO") is making defrags doing less
>>> work than it should.
>>> Thus damping the IO for autodefrag.
>>>
>>> This POC series is to make v5.15 kernel to do proper defrag of all goo=
d
>>> candidates while still not defrag any hole/preallocated range.
>>>
>>> The test script here looks like this:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0wipefs -fa $dev
>>> =C2=A0=C2=A0=C2=A0=C2=A0mkfs.btrfs -f $dev -U $uuid > /dev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0mount $dev $mnt -o autodefrag
>>> =C2=A0=C2=A0=C2=A0=C2=A0$fsstress -w -n 2000 -p 1 -d $mnt -s 164231951=
7
>>> =C2=A0=C2=A0=C2=A0=C2=A0sync
>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=3D=3D=3D baseline =3D=3D=3D"
>>> =C2=A0=C2=A0=C2=A0=C2=A0cat /sys/fs/btrfs/$uuid/debug/io_accounting/da=
ta_write
>>> =C2=A0=C2=A0=C2=A0=C2=A0echo 0 > /sys/fs/btrfs/$uuid/debug/cleaner_tri=
gger
>>> =C2=A0=C2=A0=C2=A0=C2=A0sleep 3
>>> =C2=A0=C2=A0=C2=A0=C2=A0sync
>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=3D=3D=3D after autodefrag =3D=3D=3D"
>>> =C2=A0=C2=A0=C2=A0=C2=A0cat /sys/fs/btrfs/$uuid/debug/io_accounting/da=
ta_write
>>> =C2=A0=C2=A0=C2=A0=C2=A0umount $mnt
>>>
>>> <uuid>/debug/io_accounting/data_write is the new debug features showin=
g
>>> how many bytes has been written for a btrfs.
>>> The numbers are before chunk mapping.
>>> cleaer_trigger is the trigger to wake up cleaner_kthread so autodefrag
>>> can do its work.
>>>
>>> Now there is result:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Data bytes written | Diff to baseline
>>> ----------------+--------------------+------------------
>>> no autodefrag=C2=A0=C2=A0 | 36896768=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 0
>>> v5.15 vanilla=C2=A0=C2=A0 | 40079360=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | +8.6%
>>> v5.15 POC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42491904=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | +15.2%
>>> v5.16 fixes=C2=A0=C2=A0=C2=A0 | 42536960=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | +15.3%
>>>
>>> The data shows, although v5.15 vanilla is really causing the least
>>> amount of IO for autodefrag, if v5.15 is patched with POC to do proper
>>> defrag, the final IO is almost the same as v5.16 with submitted fixes.
>>>
>>> So this proves that, the v5.15 has lower IO is not a valid default, bu=
t
>>> a regression which leads to less efficient defrag.
>>>
>>> And the IO increase is in fact a proof of a regression being fixed.
>>
>> Are you sure that's the only thing?
>
> Not the only thing, but it's proving the baseline of v5.15 is not a
> reliable one.
>
>> Users report massive IO difference, 15% more does not seem to be massiv=
e.
>> Fran=C3=A7ois for example reported a difference of 10 ops/s vs 1k ops/s=
 [1]
>
> This is just for the seed I'm using.
> As it provides a reliable and constant baseline where all my previous
> testing and debugging are based on.
>
> It can be definitely way more IO if the load involves more full cluster
> rejection.
>
>>
>> It also does not explain the 100% cpu usage of the cleaner kthread.
>> Scanning the whole file based on extent maps and not using
>> btrfs_search_forward() anymore, as discussed yesterday on slack, can
>> however contribute to much higher cpu usage.
>
> That's definitely one possible reason.
>
> But this particular analyse has io_accounting focused on data_write,
> thus metadata can definitely have its part in it.

BTW, with the io_accounting debugging feature, we can easily distinguish
metadata read/write from data read/write caused by the fsstress and
autodefrag.

Although in my environment, the nr_ops are pretty small, thus the whole
metadata can be easily cached in memory, thus the btrfs_search_forward()
problem is not that observable here.

For the real world proof, Fran=C3=A7ois, mind to test v5.15 with these two
patches applied to see if there is a difference in IO, compared to v5.15
vanilla?

Thanks,
Qu

>
> Nevertheless, this has already shows there are problems in the old
> autodefrag path and not really exposed.
>
> Thanks,
> Qu
>
>>
>> [1]
>> https://lore.kernel.org/linux-btrfs/CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk=
2iK1X6OyyEWG5-mg@mail.gmail.com/
>>
>>
>> Thanks.
>>
>>>
>>> Qu Wenruo (2):
>>> =C2=A0=C2=A0 btrfs: defrag: don't defrag preallocated extents
>>> =C2=A0=C2=A0 btrfs: defrag: limit cluster size to the first hole/preal=
loc range
>>>
>>> =C2=A0 fs/btrfs/ioctl.c | 48 +++++++++++++++++++++++++++++++++++++++++=
+------
>>> =C2=A0 1 file changed, 42 insertions(+), 6 deletions(-)
>>>
>>> --
>>> 2.34.1
>>>
