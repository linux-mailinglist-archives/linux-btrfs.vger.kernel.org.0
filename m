Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244D03CB0CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 04:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhGPCfr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 22:35:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:60569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233114AbhGPCfq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 22:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626402769;
        bh=GNi8uYmr20CFwfcvJWRFpBOPFVUhbDnk0E05HM/yEF4=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=B6Y1rKNm+M6itqHTt+tb+J5gCX0ulnqaibdDJR3uPDIJ462nvyDVMCtpiifGGmXH3
         jf1ciu4FdjI2A9nqUdsF6V/bZlk8HmurEEDmOL99yo9Zz7mgm3y0MQpV5/U3zBkxZ/
         F7GqDL2UvJ2MYpVPs78fRjmALEL2tjrhcHMsEIak=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mj8mV-1lRs1s0iBx-00fADL; Fri, 16
 Jul 2021 04:32:49 +0200
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
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
Message-ID: <7001bb2d-86a3-cf43-dfcc-ea29c49a041f@gmx.com>
Date:   Fri, 16 Jul 2021 10:32:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oS6T4S0K37nEMOkyGh7AA2oXrXpIlqpTZCys8ULGzjmZkiJpmkp
 Wfpg/JBRtJVNiAdhlvqrTDtLwvbxLSctPh9zUPHYr809Mho32pDlUtR540rtfaI+K2x3fdJ
 3C+ilor15psA0JLCTLxt8SwRRVPUef0qSQUzJfXiLFzijWcMq5BZLEZZNN7LQNe4D2blgMV
 G3x2VBHWC8gbCYkT7WX0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8H15dhGAb6o=:gWXS4SiUcEMZz3rId+jN/R
 c8QqwlCgmeZfu3BWGfZIqhy4FSi7lGCDZ3lMH+9mEtaEnIYWKufbN9bRwXC1/qf/OBbqNyAJU
 PVslt5LyiuKTclkVEKgwn0AVnDhmm6SG3+W6LBHqtdtx/NIItY1Tr+W3bC+Xv6u+3RhdpG4iE
 WYfIvIvRuqfAVLl55UFVe9z9U5YI1hvxpaUUxPk9cvXy7iSJRbLScbtl7j5zmfodPRGZKmGXh
 OXy228HRvH0+15uILPoIqmJdYQVzrZhCq8VE+dlEsYX2jnnIEnGlv/C9rUWPJe9Bu4N3Y35Hg
 fcVvWir5NBqZMpnF4/CyHhoKNRGS43GG8dFgjJmRGh+vf8yc5YixITWtSYi8CrRi8XStwjNEU
 8Bhy2HzuIC1OUGIYrWW/GkCT77SVcnezay9aBTBcbvCVtgj8zPlMAmmDZo4z3Ab1orGv5A01G
 R+8O2Z8Q46ZtWd3lF16KaNVbSd2N7qpXU9y/Wws3Mj0gYivBaMcjeZDbVUDmSQ8+mcTsJuMnt
 oSEK2/IATux5QciGKtldydfdpfY2Iy1DoaOmD1aCwcBiarDkNznYUsA8p+wudoZCo/64a/M3Y
 S2/KKt+aYk1aBSoKLpr4pNJNqSN2KYO+IEB6Em20wZTsEwA6Xrcd/LbJgSz0JfDNXvih2xPWt
 X6F/zpOy5ZXzkBuAHnZJxKBhDq0Fxv/MEkviKHWRwRflAHBDwnxN00iQWuAq7FTLn868GirQS
 yiAbTJvuqJ1l1ECKg7omN90BBFu8PGa8tsJo0djgMhm2WBfh2E+hunfbh/Rvnp6SVFZDXq6cs
 FTPrntrndTeVSGthSkQPU9aMvZtLNR17gYXGyabYzXtdXNY2UC3G8DvjfopIDRhM7Hva0Cg6g
 ++32EalqdCYsjtUfdbathP01eRMEDQCcLxvljNU+Yj7Jax4QC/wvTJVLfISS4KUtIvppsKbqU
 8clbRXCdp7tYT5urkHuRif2kRzJ6G6JkOf3yv+No4Jcbf7ICQd/vd6SJKVkcCWv05FzpRo0w7
 cGmoyXlMXUOUfT4EZ+RaDPRFd2Jlnp0gmRU65h204iKOGQYC+71L0ZVIJaxs8oC7iASwbKd/4
 DsAEJ3xptHAYnp2SYjPINbRVcWi7YCoJPaeHqQ6xWA6S3mJYthuMWLBWA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/16 =E4=B8=8A=E5=8D=889:05, Qu Wenruo wrote:
>
>
> On 2021/7/16 =E4=B8=8A=E5=8D=886:49, Dave T wrote:
>>> OK, lowmem mode indeed did a much better job.
>>>
>>> This is a very strange bug.
>>>
>>> This means:
>>>
>>> - The compressed extent doesn't have csum
>>> =C2=A0=C2=A0=C2=A0 Which shouldn't be possible for recent kernels.
>>>
>>> - The compressed extent exists for inode which has NODATASUM flag
>>> =C2=A0=C2=A0=C2=A0 Not possible again for recent kernels.
>>>
>>> But IIRC there are old kernels allowing such compression + nodatasum.
>>>
>>> I guess that's the reason why you got EIO when reading it.
>>>
>>> When we failed to find csum, we just put 0x00 as csum, and then when y=
ou
>>> read the data, it's definitely going to cause csum mismatch and nothin=
g
>>> get read out.
>>>
>>> This can be worked around by recent "rescue=3Didatacsums" mount option=
.
>>>
>>> But to me, this really looks like some old fs, with some inodes create=
d
>>> by older kernels.
>>
>> I'm running:
>> kernel version 5.12.15-arch1-1 (linux@archlinux)
>>
>> I've been running arch + btrfs since 2014. I keep arch linux fully
>> updated. I'm running new kernels and new btrfs progs. However, I
>> created this filesystem around 2014.
>
> The change that don't allow allow compression if the inode has NODATASUM
> option is introduced in commit 42c16da6d684 ("btrfs: inode: Don't
> compress if NODATASUM or NODATACOW set"), which is from v5.2 in 2019.
>
> Thus such old fs indeed can be affected.
>
>>
>> Is there an option to "update" my BTRFS filesystem? Is that even a thin=
g?
>
> I don't think so, but please allow me to do more testing and then I may
> craft a fix in btrfs-progs to allow btrfs-check to repair such problems.

There is something wrong.

I created an btrfs image which has exactly the same layout as yours,
with compressed extent and inode has NODATASUM flag, and no csum for
those extents.

The btrfs check reports the same error as yours:

[4/7] checking fs roots
ERROR: root 5 EXTENT_DATA[257 0] compressed extent must have csum, but
only 0 bytes have, expect 4096
ERROR: root 5 EXTENT_DATA[257 0] is compressed, but inode flag doesn't
allow it
...
ERROR: root 5 EXTENT_DATA[257 917504] is compressed, but inode flag
doesn't allow it
ERROR: errors found in fs roots
found 163840 bytes used, error(s) found

But current kernel (v5.13-rc7) has no problem reading such extents.

As check_compressed_extent() will skip the csum verification if the
inode has NODATASUM flag.
The check is there for a long long time.

So I'm afraid there is something different involved for your read error
problem.

When the read error happens, is there really no extra kernel error message=
?

Thanks,
Qu
>
> If possible I would enhance kernel to handle such existing file extents
> better so that what you really need is just run "pacman -Syu" as usual,
> nothing to bother.
>
> Thanks,
> Qu
>
>>
>> I have multiple devices running on BTRFS filesystems created around
>> 2014 to 2016. Are those all in danger of having some problems now?
>> BTRFS has been mostly problem-free for me since before 2014. I do
>> regular balance and scrubs. However, I'm getting worried about my data
>> now...
>>
>> I hope I do not need to backup every device, recreate the filesystems,
>> and restore them. That would be weeks of work and I'm already
>> overworked... but losing data would be worse.
>>
>> BTW, even my backup disks run on BTRFS filesystems that were created
>> years ago.
>>
>>>> Are any of these options appropriate?
>>>>
>>>> -=C2=A0 btrfs rescue chunk-recover /dev/mapper/xyz
>>>
>>> Definite no.
>>>
>>> Any rescue command should only be used when some developer suggested.
>>
>> Thank you for reminding me! There's a lot of bad BTRFS advice on all
>> the various forums, and it is easy to be influenced by it when you are
>> a casual user like me.
>>
>>
>>>> - btrfs check --repair --init-csum-tree /dev/mapper/xyz
>>>
>>> This may solve the read error, but we will still report the NODATACSUM
>>> problem for the compressed extent.
>>>
>>> Have you tried to remove the NODATASUM option for those involved inode=
s?
>>
>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>> says:
>> Note: If compression is enabled, nodatacow and nodatasum are disabled.
>>
>> My mount options are:
>> rw,autodefrag,noatime,nodiratime,compress=3Dlzo,space_cache,subvol=3Dxy=
z
>>
>> Do I understand it correctly? My compression option should already
>> "remove the NODATASUM".
>>
>>>
>>> If it's possible to remove NODATASUM for those inodes, then
>>> --init-csum-tree should be able to solve the problem.
>>
>> What do you recommend now?
>>
