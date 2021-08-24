Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14653F5598
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 03:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhHXBzl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 21:55:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:49669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhHXBzk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 21:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629770095;
        bh=d+A5181v5lnGNMvCoWerOA3udcTE2YHCtVeehtSSO8Y=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=Xh/J214LuacPKpOcvJcboEtInwem+IO1/xcATBSVA0yn4LVEB0rMfrlBOsug1lRJD
         hqQmdyYcj/Txk1MqCk0+n4BhLjpAAUt5jJPRsQ/gT3nfotPs+732sHPQcvmFMipMnY
         zHx5XP8ZPFiX/JEOu2zoJvDvjuEFKREw7X5sDFUA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My36N-1nFXFJ2N6V-00zVh5; Tue, 24
 Aug 2021 03:54:55 +0200
To:     weldon@newfietech.com, linux-btrfs@vger.kernel.org
References: <005201d79860$befd1b60$3cf75220$@newfietech.com>
 <0be8ec2b-7226-f3d1-a02b-608e757bda24@gmx.com>
 <001401d7987c$7bb81ff0$73285fd0$@newfietech.com>
 <3dd47d33-7a85-7cec-ca36-f949a3a43b8a@gmx.com>
 <002001d79882$5d855ab0$18901010$@newfietech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: BTRFS fails mount after power failure
Message-ID: <baf8e19a-8d47-b8d4-47eb-6673ea1e2408@gmx.com>
Date:   Tue, 24 Aug 2021 09:54:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <002001d79882$5d855ab0$18901010$@newfietech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CQL4seTTucBhU6ISHwTbU8kRa40zhfUi73BFpIQz87X8rJxZd3+
 YZGhjcpNbdQg8NkZIEehDnsPyxzKIQE9RnhkueWPtcD2hQsELvkUjwZOEli12T0/C0kODFS
 V4mE2T0F7xTdNuKy24eA/zdVdBlJHVR8gcmsi0jg7O9RyZoOWbcF0bL7maqx8jo8gt7exq8
 +45VF0I7UOFbOeNIVrOjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJ8HVMN2N2Y=:lqgo8NTjvnsHTljFqH9ASG
 YzCL/cmCctcIVJN6bvL6Ie7CTloQYiI7xaB9ALqIWwoSg8/GcR3xWxFLoAklAZ8Nh+cp7/mvI
 miGfAhs0RyRntEkYpZNAkC2J9UDwjeQn243eIDuj4U8+5FncsZbtKFw5Vjxi0DF9ykExRwIuN
 FFECfVwFcnOKJBsdtkyrMtz34B9CowxwdnYX7MvUEWxwGj1W2J5OQigTljrt+XWa7ZTeGX4O2
 jjt0qHChBdXNPMRMtVI8y9wpy98ecWDsz2hFNEL8b49y+S8yE9D6PRRPKZlRiN5N94WJ+p+57
 dSJNB/4z5R0dVS+MTmhj8LJXykZLqlvkcjKO1bbUD6Q4uIiQMih8HsGI4QNAfHnNbl1BBpPtN
 WAs6RXWS/hMM3nfur1EIkmEICCc/4oiTBWjz9IcEJtY6bvPbrzn/f29AlmDiKSjLFen/JYg3g
 zaMceU93ikmToMqO78yumTNP+WemM6WNu7zg1rx34/QJThXhME7qhtvJPS+HdKQdCBAIinArg
 GYxsH8bGF6QkuT7k8200W2nkNFah/Uc3dLi7B9haCNpZR8l9SiOrgmdchT98moVstYbEmWeRb
 WgwJaF1th61QL/M0oNbS6kfR5wxA1hO3uTds2vZS85T/K8NXkuZs2SgsqNOtJUcDfPenUHiq3
 8oRYmYkGrZNgEcI4W1iuC7EUKg33GV06pUnCFm6ycoGR1NmgocpZvkw0ffLOju2Qy99fv4v7u
 Y1B3thFXF7nQEIVor/s9CJhK7+CSfeLw1hsdYmtfQdAkwtb92WS4385JXFB4Y+8Vl8XAqgqBr
 i2F+U0V2cjinIyDRIBeTOooVMKjzVP4eQaWJlLkjEGGl2BPHiY9AcmUcjp/MplGlx4PEEkhZz
 /z9JF2oaF12sKy9VhfNhnLJ2srm3G25U5rtfIr1qmMRe+O+xo2h9AbhVHEn90gX8skdvcKF26
 vVtJZNzqpgzpf+qDbsH7TMbThT7MVYPyoMyOskIGgzmebOVHJ/q0RZd9zHE6WrvER4jzirrdg
 7xgBd6RAhuOHDMvYc1tCMk7VLTNG23LqHzSqqm5FXv4ym8rqySL1SB8IPFZx3CGwg80Ev4F2Z
 8kmuzgD3YOt1e2KznZkzQL2yhkq2Opx5HQNh+rJgi3IE1b9GzluWC9neg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=888:52, weldon@newfietech.com wrote:
> I've attached the complete results of the btrfs-find-root command.
>
> If I understood your directions correctly, below is the result:
>
> root@onyx:/home# btrfs check -r 7939758882816 /dev/sdb1
> Opening filesystem to check...
> parent transid verify failed on 7939758882816 wanted 120260 found 120264
> parent transid verify failed on 7939758882816 wanted 120260 found 120264
> parent transid verify failed on 7939758882816 wanted 120260 found 120264
> Ignoring transid failure
> parent transid verify failed on 7939751723008 wanted 120264 found 120262
> parent transid verify failed on 7939751723008 wanted 120264 found 120266
> parent transid verify failed on 7939751723008 wanted 120264 found 120266
> Ignoring transid failure
> parent transid verify failed on 7939735683072 wanted 120264 found 120263
> parent transid verify failed on 7939735683072 wanted 120261 found 120264
> Ignoring transid failure
> parent transid verify failed on 7939734437888 wanted 120264 found 120253

Well, there are more transid errors than I thought.

This mostly means the RAID controller is not resilvering the correct
data out.
Thus metadata COW is broken.

Thus the only thing we can do is data salvaging using btrfs-restore,
which is far from ideal.
Thus it's recommended to restore from backup.


In this particular case, since the RAID5 controller is involved, there
isn't much thing we can do from btrfs realm.

Thus I'd recommend to not to use the RAID5 controller, but connect all
those disks directly so the kernel can manage them directly.


Then build btrfs RAID10 on top of these disks.
The cost is obvious, only half of the disks can really be utilized, but
it should get rid of the unreliable RAID5 controller.

Thanks,
Qu
> Checking filesystem on /dev/sdb1
> UUID: 7f500ee1-32b7-45a3-b1e9-deb7e1f59632
> [1/7] checking root items
> Error: could not find extent items for root 18446744073709551607
> ERROR: failed to repair root items: No such file or directory
> root@onyx:/home#
>
> root@onyx:/home# btrfs check -r 7939747938304 /dev/sdb1
> Opening filesystem to check...
> parent transid verify failed on 7939747938304 wanted 120260 found 120263
> parent transid verify failed on 7939747938304 wanted 120260 found 120265
> parent transid verify failed on 7939747938304 wanted 120260 found 120265
> Ignoring transid failure
> ERROR: could not setup extent tree
> ERROR: cannot open file system
> root@onyx:/home#
>
> root@onyx:/home# btrfs check -r 7939756146688 /dev/sdb1
> Opening filesystem to check...
> parent transid verify failed on 7939756146688 wanted 120260 found 120262
> parent transid verify failed on 7939756146688 wanted 120260 found 120264
> parent transid verify failed on 7939756146688 wanted 120260 found 120264
> Ignoring transid failure
> ERROR: could not setup extent tree
> ERROR: cannot open file system
> root@onyx:/home#
>
> root@onyx:/home# btrfs check -r 7939751559168  /dev/sdb1
> Opening filesystem to check...
> parent transid verify failed on 7939751559168 wanted 120260 found 120261
> parent transid verify failed on 7939751559168 wanted 120260 found 120261
> parent transid verify failed on 7939751559168 wanted 120260 found 120261
> Ignoring transid failure
> ERROR: could not setup extent tree
> ERROR: cannot open file system
> root@onyx:/home#
>
> Thanks again,
> Weldon
>
>
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Sent: August 23, 2021 6:39 PM
> To: weldon@newfietech.com; linux-btrfs@vger.kernel.org
> Subject: Re: BTRFS fails mount after power failure
>
>
>
> On 2021/8/24 =E4=B8=8A=E5=8D=888:10, weldon@newfietech.com wrote:
>> Thank you for the reply Qu.
>>
>> The hardware setup is a bit wonky in a home lab, but is as follows:
>>
>> Dell PowerEdge R510 Chassis
>> Dell PERC H700
>> 6 * 4TB SATA Disks in a RAID 5 configuration
>
> The RAID5 is not provided by btrfs, but some hardware RAID controller?
>
> Then we don't need to bother the btrfs RAID5 bug.
>
> But still, this means the RAID controller or the hdd is not doing proper=
 flush/fua.
>
> This means, next time your UPS went down or a kernel crash happens, you =
may still hit a similar problem.
>
> And this time, we're pretty sure it's less possible to blame btrfs code.
>
>
>> ESXi 6.5 hypervisor sees storage as local DELL Disk, 18.19TB
>>
>> 17.66TB Provisioned as a Datastore on the hypervisor, VMFS5.
>> - 14.5TB provisioned as a vmdk and presented as local disk to Ubuntu
>> virtual machine, mounted as /data (btrfs)
>> - 200GB provisioned as vmdk and presented as local disk to Ubuntu
>> virtual machine, mounted as / (ext4)
>>
>> Happy and willing to try any suggestions you may have.
>>
>> root@onyx:/home# btrfs ins dump-tree /dev/sdb1
>
> My bad, I mean "btrfs ins dump-super -fFa", but that's for the case of b=
trfs RAID5 setup.
>
> Since you're using hardware RAID5 controller, we can go direct to the re=
covery part.
>
> Your previous find-root output would be pretty helpful.
>
> You can try btrfs-check with -r option:
>
> # btrfs check -r 7939758882816 /dev/sdb1
>
> To see how many errors it throws. if it had almost no error, then it has=
 a pretty high chance to recover the data.
>
> You can also try other bytenr from your find-root output, but I guess yo=
u only need to try the first 4 bytenrs.
>
> Thanks,
> Qu
>
>> btrfs-progs v5.4.1
>> parent transid verify failed on 7939752886272 wanted 120260 found
>> 120262 parent transid verify failed on 7939752886272 wanted 120260
>> found 120265 parent transid verify failed on 7939752886272 wanted
>> 120260 found 120265 Ignoring transid failure
>> WARNING: could not setup extent tree, skipping it Couldn't setup
>> device tree
>> ERROR: unable to open /dev/sdb1
>> root@onyx:/home#
>>
>>
>> Thanks in advance,
>> Weldon
>>
>>
>> -----Original Message-----
>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Sent: August 23, 2021 5:55 PM
>> To: weldon@newfietech.com; linux-btrfs@vger.kernel.org
>> Subject: Re: BTRFS fails mount after power failure
>>
>>
>>
>> On 2021/8/24 =E4=B8=8A=E5=8D=884:52, weldon@newfietech.com wrote:
>>> Good day folks,
>>>
>>> I awoke this morning to find that my UPS had died overnight and my
>>> Ubuntu server with a 14.5TB (Raid 5) BTRFS volume went down with it.
>>
>> RAID5 has known write hole bug, and although that bug won't cause immed=
iate problems, it slowly degrades the whole array with each corrupted sect=
or or unexpected power loss.
>>
>> This would eventually bring down the array with enough degradation.
>>
>>>    The machine
>>> rebooted fine and the hardware reports no errors, however the BTRFS
>>> volume  will no longer mount.  The OS boots fine, the 14.5TB volume
>>> is for data  storage only.  gparted shows the volume/partition,  and
>>> correctly reports  space used as well as total size.  I've never
>>> encountered this type of issue  over the past year while using btrfs
>>> and I'm not sure where to start.  A  number of google search results
>>> express caution when attempting to  recover/repair, so I'm hoping for =
some expert advice.
>>>
>>> My dmesg log exceeds the 100,000 bytes restriction, so I'm unable to
>>> attach it, so please ask if there's anything specific I can include ot=
herwise.
>>>
>>> # uname -a
>>> Linux onyx 5.4.0-81-generic #91-Ubuntu SMP Thu Jul 15 19:09:17 UTC
>>> 2021
>>> x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> # btrfs --version
>>> btrfs-progs v5.4.1
>>>
>>> # btrfs fi show
>>> Label: 'Data'  uuid: 7f500ee1-32b7-45a3-b1e9-deb7e1f59632
>>>            Total devices 1 FS bytes used 7.17TiB
>>>            devid    1 size 14.50TiB used 7.40TiB path /dev/sdb1
>>>
>>> # dmesg | grep sdb
>>> [    2.312875] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
>>> CAPACITY(16).
>>> [    2.313010] sd 32:0:1:0: [sdb] 31138512896 512-byte logical blocks:=
 (15.9
>>> TB/14.5 TiB)
>>> [    2.313062] sd 32:0:1:0: [sdb] Write Protect is off
>>> [    2.313065] sd 32:0:1:0: [sdb] Mode Sense: 61 00 00 00
>>> [    2.313116] sd 32:0:1:0: [sdb] Cache data unavailable
>>> [    2.313119] sd 32:0:1:0: [sdb] Assuming drive cache: write through
>>> [    2.333321] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
>>> CAPACITY(16).
>>> [    2.396761]  sdb: sdb1
>>> [    2.397170] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
>>> CAPACITY(16).
>>> [    2.397261] sd 32:0:1:0: [sdb] Attached SCSI disk
>>> [    4.709963] BTRFS: device label Data devid 1 transid 120260 /dev/sd=
b1
>>> [   21.849570] BTRFS info (device sdb1): disk space caching is enabled
>>> [   21.849573] BTRFS info (device sdb1): has skinny extents
>>> [   22.023224] BTRFS error (device sdb1): parent transid verify failed=
 on
>>> 7939752886272 wanted 120260 found 120262
>>> [   22.047940] BTRFS error (device sdb1): parent transid verify failed=
 on
>>> 7939752886272 wanted 120260 found 120265
>>
>> This already shows some mismatch in on-disk data and recovered data fro=
m parity.
>>
>> This shows the on-disk data and parity have drifted from each other, ex=
actly the write hole problem.
>>
>> Furthermore, the disk has newer data than what we expect.
>>
>> What's the device model? It looks like a misbehavior, not sure if it's =
from the hardware, or the btrfs code.
>> As RAID56 is already marked as unsafe for a while, not that much love n=
or code fix is directed to RAID56, thus both cases are possible.
>>
>>> [   22.047949] BTRFS warning (device sdb1): failed to read tree root
>>> [   22.089003] BTRFS error (device sdb1): open_ctree failed
>>>
>>> root@onyx:/home/weldon# btrfs-find-root /dev/sdb1 parent transid
>>> verify failed on 7939752886272 wanted 120260 found 120262 parent
>>> transid verify failed on 7939752886272 wanted 120260 found 120265
>>> parent transid verify failed on 7939752886272 wanted 120260 found
>>> 120265 Ignoring transid failure
>>> WARNING: could not setup extent tree, skipping it Couldn't setup
>>> device tree Superblock thinks the generation is 120260 Superblock
>>> thinks the level is 1 Well block 7939758882816(gen: 120264 level: 1)
>>> seems good, but generation/level doesn't match, want gen: 120260
>>> level: 1 Well block 7939747938304(gen: 120263 level: 1) seems good,
>>> but generation/level doesn't match, want gen: 120260 level: 1 Well
>>> block 7939756146688(gen: 120262 level: 1) seems good, but
>>> generation/level doesn't match, want gen: 120260 level: 1 Well block
>>> 7939751559168(gen: 120261 level: 0) seems good, but generation/level
>>> doesn't match, want gen: 120260 level: 1
>>>
>>> *** A large selection of block references was removed due to
>>> character count... if needed, I can resend with the full output.
>>>
>>> Well block 1316967743488(gen: 1293 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 120260 level: 1 Well block
>>> 1316909662208(gen: 1283 level: 0) seems good, but generation/level
>>> doesn't match, want gen: 120260 level: 1 Well block 1316908711936(gen:
>>> 1283 level: 0) seems good, but generation/level doesn't match, want
>>> gen: 120260 level: 1 root@onyx:/home#
>>>
>>> Any help or assistance would be greatly appreciated.  Important data
>>> has been backed up, however if it's possible to recover without
>>> thrashing the entire volume, that would be preferred.
>>
>> First thing first, don't expect too much about magically turning the fs=
 back to fully functional status.
>> Transid error is always tricky for btrfs.
>>
>>
>> But for your case, I'm guessing your sdb1 does not have the latest supe=
r block.
>> We have newer tree roots on disk, but older super block.
>>
>> Maybe you would like to try "btrfs ins dump-tree" on all the involved d=
isks, and find if there is newer super blocks.
>>
>> Thanks,
>> Qu
>>>
>>> Regards,
>>> Weldon
>>>
>>
