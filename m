Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF90A3B4DD3
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFZJfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 05:35:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:39283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZJfp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 05:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624700001;
        bh=NCAPGm9dppnsmcF/X0mfAkk0gOMsnVgzi3wAMZhWQtw=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=gcWYf//gShsze0KN1ykGuntVpihV4mqoObjfaAHH1T69arm0SEnWwcuutaFwOMnwf
         tavdIbcOYRYlMVseay1f6CL/F8SHUaG1WdWA+bGsj7j7kYzN5AUKuw/QajtA+y1RIa
         fRW0PFF3bJDTuEpXDDOUVmLp7KaKEjiWBbCX3I9Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1Obh-1lGm1z1o8x-012p9e; Sat, 26
 Jun 2021 11:33:21 +0200
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <41661070.mPYKQbcTYQ@ananda>
 <fe83dadc-bbcf-2f85-6664-bad3fcd83553@gmx.com> <2009039.b04VgvrTqe@ananda>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search
 Baloo
Message-ID: <d24989e1-c8e0-d6c7-706e-2b5b8e9b124c@gmx.com>
Date:   Sat, 26 Jun 2021 17:33:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2009039.b04VgvrTqe@ananda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AF7eYwB4MX7xBzhk5hth5JoW6d9iIOpU9oKPN1GWnuhNcahrU6u
 k4d2uu6EJ6PYYCVztsoWxL7PCEUKsU/xcU3uvWHaFAzja0ePeTlFu5HjRVWWsF3CZu2FzF7
 Xvi5OrSEf/CY7FoJh/flovEF/UXPoLWDJEsRsEYVQaLiXXxbqcSeQKX4sgY6GiEusn8GvM7
 695X/m0bnjtx3D/hFJk0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4oNhUN++2h4=:qONbgXt9pigzk0tJwDzePV
 WSELfVKaGVqityDf8OacUgIokJa3Of00gvwEjCkWnikwJHarySTkomuTIponHB0cvhZuECHZc
 /IlrUt3xxE880g7QrR3g9BzMpPja8Gnr37p1rXlr3juOQN+CFwvIsRtQUxs2/+MKh38oM1Cp0
 PxM1ClZ+dFvLM8RBdKi2ama0JufrFCAl/X5Q76htO1tsz+uknq2ge6O3JfeJRBkCPvFHOKtzD
 cKKOmwPTNmFTZF/d9rhK/3ccki5IDr1mus+89bETQe0CowLgUTOXz0DUjvJFHDf8ZHX0ejYRm
 58PbmkmqUT7lfHolEAxO8Y0hDOXOz3d7fO2DDngks0FOOJRIl9seM+VL+0KAYfDAa/iGX60tO
 fmaQtMw6B1sjtzbYG7l8Ne24O2rm9fXkgvjAtmDRamYvq7kXztm0jGxy3gs3ele/hRU5xINUx
 Nsz6+qNHU3eQRVQgsguFrOT4IwojTxGbUYcjjS9LWV6l2iL4WNlgITZ9+z5y+sv8o7ALPuRCI
 S3MaXeBNFfOAGIZxkhFX1qqdmwCpz8lNwjfvHRDcffDUbldYroaeIOa5UZndK9OfSYjkjxgsl
 mmfZ75jlwH/fP1gK7NwMNGJ0lxYYxOlgZl3b2VEDC5BsohbNrtlMwM+q1zZG+ubmoRFGldwCo
 w4yXk0sMUxLrsjMPeG/XQudRuwRp49NL/J15CtG2aRSvzZhcrV5bjnA2ObZtSMX/4xg5JZ4xC
 EbrxiCENttFc5VL/fQDY/6+lbPyN8NtnSMiZy/rKvvTMjhBSulxaAVoElDBEyGjyOFGmuPehn
 42DOGPOfmkbSvQOlWInB9x8WB1sZ86/VqoqxwwwR2/UUzaqk2VBURraLDBkjEtrHwMkW1yXVO
 0wluNpr9HcTboNIZWSXowhkfFRa4ohkf3utrKD3O0at4ppj/yk1g25zSWyTPuu79+ifa+CSXh
 nQJC3aOFKt0FSS12yAhBbFZKnuPwAXwsrxY0W2KY4ldL29aR8sU+OZLuNK8HDiJ1jlgulC+qo
 cXMBfCgfqgj4b9I7c7jtsNnHRGK1wXZybLQNZAbklxXOXamQQLa9lZ+PCwQcWoKkaGO/Txex+
 8TtGM+R/Bfn2KxniZDfP+dYFnAIdAOQGmFROw3Y+AkW6KcSR+t1YLfQWA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/26 =E4=B8=8B=E5=8D=884:49, Martin Steigerwald wrote:
> Qu Wenruo - 26.06.21, 02:27:54 CEST:
>> On 2021/6/26 =E4=B8=8A=E5=8D=883:06, Martin Steigerwald wrote:
>>> Hi!
>>>
>>> I found repeatedly that Baloo indexes the same files twice or even
>>> more often after a while.
>>>
>>> I reported this upstream in:
>>>
>>> Bug 438434 - Baloo appears to be indexing twice the number of files
>>> than are actually in my home directory
>>>
>>> https://bugs.kde.org/show_bug.cgi?id=3D438434
>>>
>>> And got back that if the device number changes, Baloo will think it
>>> has new files even tough the path is still the same. And found over
>>> time that the device number for the single BTRFS filesystem on a
>>> NVMe SSD in a ThinkPad T14 Gen1 AMD can change. It is not (maybe
>>> yet) RAID 1. I do have BTRFS RAID 1 in another laptop and there I
>>> also had this issue already.
>>
>> Since btrfs has multi-device support by default, it reports anonymous
>> device number, just as if you use a filesystem over LVM.
>
> Ah, this!
>
> I forgot to mention that: I use BTRFS on top of LVM on top of LUKS based
> dm-crypt on a partition on the NVMe SSD. Sorry, somehow I forgot to
> mention that here. I mentioned it in the bug report. I'd use a different
> approach if there would be one that give me full disk encryption. I am
> not willing to use ecryptfs on top of BTRFS and as far as I know BTRFS
> cannot yet encrypt by itself.
>
> I still think this could give a fixed order of loading:
>
> 1. Unlock LUKS.
>
> 2. Activate LVM logical volumes. No idea whether that happens in a fixed
> order though or whether it can have a different order on each boot.

LVM/LUKS normally isn't a big deal, as most of them are initialized
before btrfs, and have a pretty fixed initialization sequence.

Unless you change the LVM setup, then at least all your LVs should have
a fixed device number.
(But there are still cases where kernel update may change them)

>
> 3. Mount BTRFS. /home is always on the same subvolume. So that should
> not change.

Normally it won't change.

But it's more dependent on the btrfs behavior.

Thus I'm not that confident it won't change forever.

But at this point I guess you already get the point, under normal cases,
no config change then device number won't change.

However any change in kernel/storage stack/config can lead to different
device number.

>
>> The problem is why the anonymous device number change.
>
> Good question. Maybe I have an idea about that. See below.
>
>>> I argued that a desktop application has no business to rely on a
>>> device number and got back that search/indexing is in the middle
>>> between an application and system software. And that Baloo needs an
>>> "invariant" for a file. See comment #11 of that bug report:
>>>
>>> https://bugs.kde.org/show_bug.cgi?id=3D438434#c11
>>
>> Well, a lot of tools relies on device number to distinguish filesystem
>> boundary, like find.
>> Thus it's a little hard to argue.
>>
>> But on the other hand, it also means baloo can't handle regular fs
>> over LVM cases well neither.
>
> Yes. Also it could not handle the case of a driver loading race
> condition with two or more different controllers in a desktop machine.

Thus the idea from Neil should help, instead of using device number,
using f_fsid from statfs() should provide a way more stable result.

And f_fsid can also handle btrfs subvolumes pretty well.

But this also means, if one day you change your default/mounted
subvolume, baloo will again rebuild the cache using the new f_fsid.

>
>>> I got the suggestion to try to find a way to tell the kernel to use
>>> a fixed device number.
>>
>> I don't think it's possible for btrfs, as each subvolume get its
>> anonymous device number assigned when it gets first read.
>>
>> Thus it's really hard to make it fixed, as the reason for anonymous
>> device number is to avoid conflicts.
>
> Fair enough.
>
>>> I still think, an application or an infrastructure service for a
>>> desktop environment or even anything else in user space should not
>>> rely on a device number to be fixed and never change upon reboots.
>>
>> Well, LVM/device mapper is doing the same thing, a lot of behavior
>> change is never a good idea for the kernel.
>>
>> Thus for use cases where we really need a proper mapping, we use
>> hashes, not just device number, like what we did in dupremover.
>
> I think I suggested that some time ago.
>
>>> Another question would be whether I could somehow make sure that the
>>> device number does not change, even if just as a work-around.
>>
>> If you really just want a fixed device number, you can ensure that by:
>>
>> - Make sure all users of anonymous devices get fixed sequence
>>     Things like device mapper/LVM, btrfs should get loaded/initialized
>>     in a fixed order.
>
> Ah, I see.
>
>> - Make sure the subvolume you care always get mounted/read before any
>>     other subvolumes
>>     So that the target subvolume always get the first device number in
>> the pool.
>
> Hmm, that may be a pointer. This is what I currently have in fstab:
>
> /dev/nvme/home /home btrfs lazytime,compress=3Dzstd 0 0
> /dev/nvme/home /zeit/home btrfs subvol=3Dzeit 0 0
>
> In the first line the default subvolume is used which I changed
> accordingly after creating this BTRFS. I use the approach to keep
> (temporary) snapshots separated from the directory tree in /home.
>
> Could it be that this order between these two mounts is not the same on
> every boot?
> I use Devuan with Runit, so the mounting would happen by
> some init scripts (instead of Systemd).

Then it's out of the scope of btrfs.

I was just wondering if systemd is involved, but you just ruled it out.
But still if the init tool choose to shuffle the mount sequence to do
more parallel mounts, then device number will be even more unreliable.

>
> I am not aware of an option for fstab to mount this one first and then
> the other second, but I could set the second mount to noauto and mount
> it when I need it.
>
>>     But this also means, all later subvolumes not in the fixed
>> mount/read sequence can not get a fixed number.
>
> I somehow thought this would get complicated.

It's already complicated.

So this just proves Neil is right, device number is only reliable at the
lifespan of the fs, nothing else.

Thanks,
Qu

>
> Best,
>
