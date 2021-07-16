Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B33CB045
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 03:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhGPBII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 21:08:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:59755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhGPBIH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 21:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626397511;
        bh=FGGFcR7OaHy2MbLYKAaSXOg8cny85wAcbzlg35su/q8=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=TBlLv5vLgH19cj4oddbOxNNTDKIVRN0fT7eksuZ/V8y5cQTY3sHTATmE4wE8QXV2O
         Bq2ik8xCBiPWD5LbjZc9So6pOVtK4wr0mhIpccYjbr8DTGaTAGJGfYzTVvG9kf5rpS
         xw92++b3jUXfsGrH2N6I60ZHy1Z8X8e9SmW0bht4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMofW-1lndL82ttc-00Invp; Fri, 16
 Jul 2021 03:05:11 +0200
To:     Dave T <davestechshop@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com>
 <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com>
 <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com>
 <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
Message-ID: <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com>
Date:   Fri, 16 Jul 2021 09:05:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vd6tlMx75aaiqBSWgWtA20RiJcXJ5tr+u2tjE9n75mQZcGYNQth
 a+AfgJyRzLi8uDH/A/gy/tWSbPIjpfxWeDhsQrsRd2SqDjcVIXCDAyYwcZPCY6k2/+k1b5f
 kP/yiVTvjCbn8sxu7kPfSkcEpNETUOrq1WvlJM5XRN4K9UGYq31vgHw07dRia7rpFBACa9J
 r8utxFhwsXeTDrTvAe+Eg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PnJCGowJDx0=:ORHYK9f89HV0/Ivvpc5qlh
 AOFL51PwRMdk0DGehU2b6FMkpSzvrrJXD3f5cVtOri2MRnWSzFb5wVROsrPoaxTGQypbeeidx
 arLNrK72wCHOTH/AyOr9RUi0YgzJmZXFV/hW1LuhGq0XUIaPtIJOk3D6j/TVdbydTOkKMX1uF
 VGghKG383HpYjcWoXW2CsWaw/OsWCwRCDz9QSIlxDL9tXssD8Q0xmxc3Z4fZSQG+ZvI2aGqPz
 ldNLVQS0cTMF7+/6OdIZk0Kqme7PyCz8JTECcGJW2Yi4XaxcsCOEpKCTcb6ociW51WZiqgogA
 ZyA9iJ+IxhvAlr5TRg2CyvHbQ3c5bjJWcv1DtLVv0uvRwgiUZjBmlNySStGzToEsevClc+PoZ
 Y+29t7ZaMC5NxEY80wOG/NkP79FdFkNgQP253YIcMgqk8G9LTLlAKRqKNNJH5nS13E/6JzGpM
 RK9W/ajBGAvUxjlI/9oiAdZMIXR8yNgmfdKm0tG6ijucMUazOMtzc0xN5Bwem20DuA9sBA4qN
 opKyxgtvqulhRQHkjREG4mlPjWE7skylF0NKiz7zf0z6DOQa5sOCiyYWnlilrHoaBZ5bd8eL6
 UKQdfHsvJ6aG7Yqzzq6dh2UaKI1xyGIxgqpzb2s9ixCB1HOj5Te6V3nrMKSuTkn4Exfq6l65r
 rWl+DXzhE7Ms6ohkQ2pOALHxdYHUqjhl+Nj71sFVMcd5/JNVjIO8QqGOuiv98tA0k9vN1ibIg
 KE+hnTSPhvtogWotob63O7x1f7cTeJX4Xc59Y/6mxsOnL7iQOUYA2fpi2Vci2nKSqt47D+sR3
 ZuS+xWHTdfjF7Wg9AkcccwfhBH4OMe/pygmKRwjpGpqMY7t9yuj/TTAKU60xWrltYvRtgAyJM
 yrXxmiNyO8kJRlrPwjkdibXqztRpJDvXD/Z8W5Ffgix4BjifxpB1rJ7hXP4rywt1TCTl868w9
 +Q4YIPK8r/tsZFNhZBbSEYKB3JmLBR6TJE2s/aKTdBGG2eyYi3VZvyDHXB9fToWL9zJ9MlrR6
 Hu9VRiQqBFxQzL9aA8IKmpAX/4oFKHxkliZjcaIIILMm+WeuxwW1jc3M5KnHRyeT8Qsii1fhe
 hy5OYcg/SA2FR3sFgoUyF1EGuE/lVxtYIqN2wJoUW1SiCt32ZNik/bL5w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/16 =E4=B8=8A=E5=8D=886:49, Dave T wrote:
>> OK, lowmem mode indeed did a much better job.
>>
>> This is a very strange bug.
>>
>> This means:
>>
>> - The compressed extent doesn't have csum
>>     Which shouldn't be possible for recent kernels.
>>
>> - The compressed extent exists for inode which has NODATASUM flag
>>     Not possible again for recent kernels.
>>
>> But IIRC there are old kernels allowing such compression + nodatasum.
>>
>> I guess that's the reason why you got EIO when reading it.
>>
>> When we failed to find csum, we just put 0x00 as csum, and then when yo=
u
>> read the data, it's definitely going to cause csum mismatch and nothing
>> get read out.
>>
>> This can be worked around by recent "rescue=3Didatacsums" mount option.
>>
>> But to me, this really looks like some old fs, with some inodes created
>> by older kernels.
>
> I'm running:
> kernel version 5.12.15-arch1-1 (linux@archlinux)
>
> I've been running arch + btrfs since 2014. I keep arch linux fully
> updated. I'm running new kernels and new btrfs progs. However, I
> created this filesystem around 2014.

The change that don't allow allow compression if the inode has NODATASUM
option is introduced in commit 42c16da6d684 ("btrfs: inode: Don't
compress if NODATASUM or NODATACOW set"), which is from v5.2 in 2019.

Thus such old fs indeed can be affected.

>
> Is there an option to "update" my BTRFS filesystem? Is that even a thing=
?

I don't think so, but please allow me to do more testing and then I may
craft a fix in btrfs-progs to allow btrfs-check to repair such problems.

If possible I would enhance kernel to handle such existing file extents
better so that what you really need is just run "pacman -Syu" as usual,
nothing to bother.

Thanks,
Qu

>
> I have multiple devices running on BTRFS filesystems created around
> 2014 to 2016. Are those all in danger of having some problems now?
> BTRFS has been mostly problem-free for me since before 2014. I do
> regular balance and scrubs. However, I'm getting worried about my data
> now...
>
> I hope I do not need to backup every device, recreate the filesystems,
> and restore them. That would be weeks of work and I'm already
> overworked... but losing data would be worse.
>
> BTW, even my backup disks run on BTRFS filesystems that were created yea=
rs ago.
>
>>> Are any of these options appropriate?
>>>
>>> -  btrfs rescue chunk-recover /dev/mapper/xyz
>>
>> Definite no.
>>
>> Any rescue command should only be used when some developer suggested.
>
> Thank you for reminding me! There's a lot of bad BTRFS advice on all
> the various forums, and it is easy to be influenced by it when you are
> a casual user like me.
>
>
>>> - btrfs check --repair --init-csum-tree /dev/mapper/xyz
>>
>> This may solve the read error, but we will still report the NODATACSUM
>> problem for the compressed extent.
>>
>> Have you tried to remove the NODATASUM option for those involved inodes=
?
>
> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
> says:
> Note: If compression is enabled, nodatacow and nodatasum are disabled.
>
> My mount options are:
> rw,autodefrag,noatime,nodiratime,compress=3Dlzo,space_cache,subvol=3Dxyz
>
> Do I understand it correctly? My compression option should already
> "remove the NODATASUM".
>
>>
>> If it's possible to remove NODATASUM for those inodes, then
>> --init-csum-tree should be able to solve the problem.
>
> What do you recommend now?
>
