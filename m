Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC27C32B1AF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbhCCBzm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:55:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:58927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381445AbhCBHcz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Mar 2021 02:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614670267;
        bh=RyMiRwE+xvJzglLAopMZQGkqL3gmSoc1A7c2zNYOuec=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=VneZ8NozsV3oN5YQNnz4VYdhHyFtrI0DuNM5bEBEGZCmcWTC/DX5fuKgGlWPluIsU
         qls4kh4tr+WQfZV3SpRAf8y5OLZzzMimUTtNnxt/bDkYbUJF8AGY5K2wxlefu9pkET
         y52teXi/ks0ZzWplJe3+YG35uShW+QLOEmMLCs+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6m4-1ldudj0gvs-00lR67; Tue, 02
 Mar 2021 08:31:07 +0100
To:     =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
 <4744a69e-0adb-7cad-577e-7f17741519be@knebb.de>
 <6e37dc95-cca7-a7fc-774a-87068f03c16b@gmx.com>
 <4890dd37-3ef1-e589-9fd1-543a993436c4@knebb.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Adding Device Fails - Why?
Message-ID: <f2237d9e-bd3a-f694-b64e-f229b67a1064@gmx.com>
Date:   Tue, 2 Mar 2021 15:31:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <4890dd37-3ef1-e589-9fd1-543a993436c4@knebb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jZBMwQjdmLnk+F2QdorEMug44LFxv8MssTMAj7Zd01JCbDO/ec8
 M+Py/28U6lVTC7cZvHUr/5wASKpXM2NAyW9VrYJdwoSwLYDMoe6vZYCtDzW3kPOf7wEyhZ5
 IYMxZW9TvHCtR2WYJEeXRaZc9RWviZpx/lJx6nfk2NahHqGhSSCrtvjRENlkRqwCWgs2dO9
 uPeI4PxUt9m5Px39S++bg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MYTqOE8INJ4=:OXxgo7RP/FfzqJag+ryZA+
 BlrOW/jjk9pohZfBsZ5Aec6EuQ9OS2JqKRTNP1Nh/8vWljFoxMuSGikLikqr4e5+WpP5Glpv0
 piQHim7egkKGQYCbUSRGQ9fDbzKBUvbzhHZXWnOemx1befFO7uh+LOTbUjPNJUpbdJmosij0u
 HczVDr5HaysRV6AvyjKaXEONCnI1CuJxpBP44FjluwR5/Wku+WDVwcoA71ppwl5v0rd3FDnZE
 tH9j8w6YvdJZSXpH1dUnsrf4+l5EBJQfxNHKFQMF1HCg1Vu0dXc5JhFSDl4yuehvZQKZ/OAIW
 9Uytw73lARrdf5jvdQbIlzAFZhX1ctC0v1IwGbYjQAmh4NBeNUiGczBT/a7ZSLh1b7uOye9Ss
 /5D8KhLgCp8Mt3yeTqb/22Y/JEI0pxWopfDHyWASoOTZz+tBGAOleNz6nsfs869j6mgMXIlWJ
 0m6qkHgDZ8ScOM6OpSx6mOglSL/QI9uh2bDMJvut+xdaipM4BGxm99iKOVbScYcxWUf6rb1Xf
 4cVpRqbQN5dnVOub1Mo4PAaeFYIA6PIfTDkcrJ7n+2tR2C6LHFjPhsOpdRHwWf3k375tIIwBr
 aCUeAz/gqqZLQPAXSWl60N5A+Bwa88Kf1KK00fdl6ZhJv5TYJ88UyHlFfigpMx5cMSm28+hYm
 mLznWEjyPTy7w0CqF5fxWQ+G19iFnuuUm93G59SlLuSLTGxSxSPF3of6on0kxcuDO6DbzpIVq
 46XMNErgB3y/CzzzDeh1SFcL7YEf1CdVr29HvzcHUJ83qZpHScO1+WRUhaTtgFeTtjNoUhAKK
 F9A+2mf/InnEiZbpoLcUoSe+ldniWYHnG+1SMSvR0Onf54ukA/Kx3q92ZuvPFFQXemAAEGSD7
 9ssBv8WRkIU3yK1ojhEg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/2 =E4=B8=8B=E5=8D=883:09, Christian V=C3=B6lker wrote:
> Hi Qu Wenro,
>
> thanks for debugging this. What I am wondering- why did it work when
> creating the initial device?

Fs creation (mkfs) doesn't canonicalize the path, and it all happens in
user space, so no problem.

Only device add is affected, and if the device to be added is not a
device mapped dev (aka /dev/dm-*) then even with the offending v5.10.1
you can still add the device, just like what you tried by using drbd
over luks.

> For Debian it looks like there is no other version of btrfs-progs
> available, so I used this version (5.10.1-1) to create the btrfs device.
>
> And may I workaround this issue by manually creating a softlink
> /dev/manualdevice to /dev/mappper/crypt_drbd3? The link will be gone
> after reboot but btrfs should then find the device by it's UUID,
> shouldn't it?

I just tried, that, it doesn't work.

The path canonicalization happens by following the softlink until it
reaches the final /dev/dm-* block file, and then cut the "/dev/" prefix
wrongly, leaving just "dm-*".

So even you added a softlink, it won't help.
I just tried that, and it failed:
  $ sudo ln -sf /dev/test/scratch2  /dev/whatever
  $ sudo btrfs dev add /dev/whatever /mnt/btrfs/ -f
  ERROR: error adding device 'dm-5': No such file or directory


But, if you manually create a block device file, with the same device
major/minor number, then you can add it using the newly created block
device file, just like this:

  $ ls -alh /dev/dm-5
  brw-rw---- 1 root disk 253, 5 Mar  2 15:24 /dev/dm-5
  $ sudo mknod ~/whatever b 253 5
  $ sudo btrfs dev add ~/whatever /mnt/btrfs/ -f
  $ sudo btrfs fi show /mnt/btrfs/
  Label: none  uuid: 82631967-0b16-40f2-b545-0039fe9b9653
         Total devices 2 FS bytes used 192.00KiB
         devid    1 size 10.00GiB used 536.00MiB path dm-4
         devid    2 size 10.00GiB used 0.00B path /home/adam/whatever

Thanks,
Qu

>
> Greetings
>
> /KNEBB
>
>
>
>
> Am 02.03.2021 um 02:18 schrieb Qu Wenruo:
>>
>>
>> On 2021/3/2 =E4=B8=8A=E5=8D=881:24, Christian V=C3=B6lker wrote:
>>> Hi,
>>>
>>> just a little update on the issue.
>>>
>>> As soon as I omit the encryption part I can easily add the device to t=
he
>>> btrfs filesystem. It does not matter if the crypted device is on top o=
f
>>> DRBD or directly on the /dev/sdc. In both cases btrs refuses to add th=
e
>>> device when a luks-encrypted device is on top.
>>>
>>> In case I am swapping my setup (drbd on top of encryption) and add the
>>> drbd device to btrfs it works without any issues.
>>>
>>> However, I prefer the other way round- and as the other two btrfs
>>> devices are both encryption on top of drbd it should work...
>>>
>>> It appears it does not like to add a third device-mapper device...
>>>
>>> Let me know how I can help in debugging. If i have some time I will
>>> setup a machine trying to reproduce this.
>>
>> Got the problem reproduced here.
>>
>> And surprisingly, it's something related to btrfs-progs, not the kernel=
.
>>
>> I just added one debug info in btrfs-progs, it shows:
>>
>> $ sudo ./btrfs dev add /dev/test/scratch2=C2=A0 /mnt/btrfs
>> cmd_device_add: path=3Ddm-5
>> ERROR: error adding device 'dm-5': No such file or directory
>>
>> See the problem?
>>
>> The path which should be passed to kernel lacks the "/dev/test/" prefix=
,
>> thus it's not pointing to correct path and cause the ENOENT error, sinc=
e
>> there is no "dm-5" in current path.
>>
>> Thankfully it's already fixed in devel branch with commit 2347b34af4d8
>> ("btrfs-progs: fix device mapper path canonicalization").
>>
>> The offending patch is 922eaa7b5472 ("btrfs-progs: build: fix linking
>> with static libmount"), which is in v5.10.1.
>>
>> You can revert back to v5.10 to workaroud it.
>>
>>
>> TO David,
>>
>> Would you consider to add a new v5.10.2 to fix the problem? As it seems
>> to affect the end user quite badly.
>>
>> Thanks,
>> Qu
>>>
>>> any ideas otherwise? Let me know!
>>>
>>> Thanks!
>>>
>>> /KNEBB
>>>
>
