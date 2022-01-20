Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E81494E20
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 13:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbiATMpg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 07:45:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:53927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235620AbiATMpf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 07:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642682727;
        bh=NA2isi1SIR85e+nNIG31daEyZPcGzUA2w8aZ9QXxg/M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cRZ81HyjtJ5bypzM/xectDMh3tZwgnXHh0k0NXNdERrFRJ3wJ995JhWyiyBlGHp7p
         9vlkhry/VGyEK3OamHh5ahs7ax7KDktO/hLn8P92VblLMMkw8f+ECCH47eXLewP6IO
         EdVVtj/NL98hmmFw3eQdwVEIEWEcLYFmGTtm4trw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUGe1-1mkN533Aot-00RIYI; Thu, 20
 Jan 2022 13:45:27 +0100
Message-ID: <61cb3a50-3a19-ad21-be2e-edbf55eaa91d@gmx.com>
Date:   Thu, 20 Jan 2022 20:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois-Xavier_Thomas?= <fx.thomas@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m5WSIJ4sKSJsNe7uZgfl+HAI2llzS7BQG9siT7/fBAix58eVlFe
 Mn/KsvZCPkSa/Tteoy9HPHqgV7HhnJ7n957YX4LKcWKA2X50b2sTWC9vZ/ejN6YELA/XjXI
 O5s4Pyp6CdZWXdVLU2f36bLWNEhmgEw8+BStPLY8Yy1gXM9Lt4MBqmvCQioCK31TffPiisD
 +A+YVDM2wtN8Zka/oSGLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gu6hT5kRBDw=:ktwQvpmumFA9RAxTQHi+of
 iSQtMfM+lXGwfFmKr641LkyGf1f2GUe7CVZKaF4Cba+8ltCLhQylnI7yV/FMdjx2uMUXYYU65
 CQsl83eLfuDjwo0OxcofRgLLaAJiX3ZZ6wE6hQHEc/QV1o07XmS6lLe6HjQZpQ0/q8pkhDo9O
 YhNkXz1qKWVPMicWszWa/sZ2hXExY8usVOb8ZhVPhirLTW2y54RLd+Ugl2Db2qYbqWm4J7xYE
 XdXwodMJ/4CXL1vgR+7mKbUqYOWdm1fKO4JX4zCEgOLf/jd5AnJfsD99gbFZ6FZjddVpuydqP
 b1KqR7V+RdEs0AK0aY09B9gVsV08iHt6fMV0hYPQO/wAHHYmnGdLF8xdURnF2VMpU7ZN2R0cK
 KtRnV7Sqsmpg6xENLZ/Mqyw/mUx4+GLSvcwBieRSq+PjNa8ryIBuy1YVGGr4LGnhkBFslbj9s
 54fCdq6cLvX+vBDYbncHGlq2Qngr9i6rc7sYLHBq9f+1tk8TVyPcNjKyuS650VhNz3fIaU1Cx
 8NmLGnW0h5+oZanfJ+vpFxCg/T7mXffF2cEDfHuTvEGSjL0AoWZ/zMfqlBLr4LDQy6/o4rjOD
 5FcglmDnjVR5IEyzmDFJTorO2cTJpKtjJ6OZRQK0dFB0we531sYQOrKqH+YslgjFnFVH7HT6c
 ggree9gHOrTe1Aq1fpvE2TKwIRKT3f1mfBiuKQqsIawD6JhxVcNl/+Tlksc8i7f6KYiXyC27i
 TWFAYnGUNX9NO78dtAbguW2UDYXpYOR5abuYOzCtyrIxZgrRn3eRX0L/41UrCK8+cPrLYCQQs
 xwcvpwkVTABKIC74pYlJyjfr7sUDUR8S6f15+y2iwE6FpEVbrn/OWfYdmFqmN6G1LxLdLw732
 qPMyU5ekz+UmNYidl56NkEd39FsG7AQgQWhLcNKuMui9rA9jcVwuWfhXTxtMAeZ6/59VFDe/E
 SYzWZ7oENY0X/xZ70GJGqEndvpU7M0cdE+tk+DxvZZxH88rF0g6iCe+11/re2NvCO+gyJSdrr
 548/iW4tRCgItAwf6wfjD9Oe9cQKi945lwvFOo/Sp2YreDNdQuc70qZlkEEGv85ozJnH8zO6l
 sVmTo67MnPz2hxJQBQFGH86aw048/wmC3cxrWxFCh9ITk+POYjjeIwBXkBpeMwYIe2Dp41GJm
 LAzpO/xRskxAewzdb/8xAG9GBi
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/20 20:02, Fran=C3=A7ois-Xavier Thomas wrote:
>> What if on top of those patches, you also add this one:
>> https://pastebin.com/raw/EbEfk1tF
>
> That's exactly patch 2 in my stack of patches in fact, is that the corre=
ct link?

Mind to share the full stack of patches or diffs?

I'd say for the known autodefrag, the following seems to solve the
problem for at least one reporter:

- btrfs: fix too long loop when defragging a 1 byte file

https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bbfed2=
484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/

- [v2] btrfs: defrag: fix the wrong number of defragged sectors

https://patchwork.kernel.org/project/linux-btrfs/patch/20220118071904.2999=
1-1-wqu@suse.com/

- btrfs: defrag: properly update range->start for autodefrag

https://patchwork.kernel.org/project/linux-btrfs/patch/20220118115352.5212=
6-1-wqu@suse.com/

Thanks,
Qu

>
> On Thu, Jan 20, 2022 at 12:45 PM Filipe Manana <fdmanana@kernel.org> wro=
te:
>>
>> On Thu, Jan 20, 2022 at 11:37 AM Fran=C3=A7ois-Xavier Thomas
>> <fx.thomas@gmail.com> wrote:
>>>
>>> Hi Felipe,
>>>
>>>> So, try with these two more patches on top of that:
>>>
>>> Thanks, I did just that, see graph with annotations:
>>> https://i.imgur.com/pu66nz0.png
>>>
>>> No visible improvement, average baseline I/O (for roughly similar
>>> workloads, the server I'm testing it on is not very busy I/O-wise) is
>>> still 3-4x higher in 5.16 than in 5.15 with autodefrag enabled.
>>
>> What if on top of those patches, you also add this one:
>>
>> https://pastebin.com/raw/EbEfk1tF
>>
>> Can you see if it helps?
>>
>>>
>>> The good news is that patch 2 did fix a large part of the issues 5.16.=
0 had.
>>> I also checked that disabling autodefrag immediately brings I/O rate
>>> back to how it was in 5.15.
>>
>> At least that!
>> Thanks.
>>
>>>
>>>>> Some people reported that 5.16.1 improved the situation for them, so
>>>> I don't see how that's possible, nothing was added to 5.16.1 that
>>>> involves defrag.
>>>> Might just be a coincidence.
>>>
>>> Yes, I found no evidence that official 5.16.1 is any better than the
>>> rest on my side.
>>>
>>> Fran=C3=A7ois-Xavier
>>>
>>> On Wed, Jan 19, 2022 at 11:14 AM Filipe Manana <fdmanana@kernel.org> w=
rote:
>>>>
>>>> On Wed, Jan 19, 2022 at 9:44 AM Fran=C3=A7ois-Xavier Thomas
>>>> <fx.thomas@gmail.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> More details on graph[0]:
>>>>> - First patch (1-byte file) on 5.16.0 did not have a significant imp=
act.
>>>>> - Both patches on 5.16.0 did reduce a large part of the I/O but stil=
l
>>>>> have a high baseline I/O compared to 5.15
>>>>
>>>> So, try with these two more patches on top of that:
>>>>
>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/20220118071904=
.29991-1-wqu@suse.com/
>>>>
>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/20220118115352=
.52126-1-wqu@suse.com/
>>>>
>>>>>
>>>>> Some people reported that 5.16.1 improved the situation for them, so
>>>>
>>>> I don't see how that's possible, nothing was added to 5.16.1 that
>>>> involves defrag.
>>>> Might just be a coincidence.
>>>>
>>>> Thanks.
>>>>
>>>>> I'm testing that. It's too early to tell but for now the baseline I/=
O
>>>>> still seems to be high compared to 5.15. Will update with more resul=
ts
>>>>> tomorrow.
>>>>>
>>>>> Fran=C3=A7ois-Xavier
>>>>>
>>>>> [0] https://i.imgur.com/agzAKGc.png
>>>>>
>>>>> On Mon, Jan 17, 2022 at 10:37 PM Fran=C3=A7ois-Xavier Thomas
>>>>> <fx.thomas@gmail.com> wrote:
>>>>>>
>>>>>> Hi Filipe,
>>>>>>
>>>>>> Thank you so much for the hints!
>>>>>>
>>>>>> I compiled 5.16 with the 1-byte file patch and have been running it
>>>>>> for a couple of hours now. I/O seems to have been gradually increas=
ing
>>>>>> compared to 5.15, but I will wait for tomorrow to have a clearer vi=
ew
>>>>>> on the graphs, then I'll try the both patches.
>>>>>>
>>>>>> Fran=C3=A7ois-Xavier
>>>>>>
>>>>>> On Mon, Jan 17, 2022 at 5:59 PM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>>>>>>>
>>>>>>> On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote:
>>>>>>>> On Mon, Jan 17, 2022 at 11:06:42AM +0100, Fran=C3=A7ois-Xavier Th=
omas wrote:
>>>>>>>>> Hello all,
>>>>>>>>>
>>>>>>>>> Just in case someone is having the same issue: Btrfs (in the
>>>>>>>>> btrfs-cleaner process) is taking a large amount of disk IO after
>>>>>>>>> upgrading to 5.16 on one of my volumes, and multiple other peopl=
e seem
>>>>>>>>> to be having the same issue, see discussion in [0].
>>>>>>>>>
>>>>>>>>> [1] is a close-up screenshot of disk I/O history (blue line is w=
rite
>>>>>>>>> ops, going from a baseline of some 10 ops/s to around 1k ops/s).=
 I
>>>>>>>>> downgraded from 5.16 to 5.15 in the middle, which immediately re=
stored
>>>>>>>>> previous performance.
>>>>>>>>>
>>>>>>>>> Common options between affected people are: ssd, autodefrag. No =
error
>>>>>>>>> in the logs, and no other issue aside from performance (the volu=
me
>>>>>>>>> works just fine for accessing data).
>>>>>>>>>
>>>>>>>>> One person reports that SMART stats show a massive amount of blo=
cks
>>>>>>>>> being written; unfortunately I do not have historical data for t=
hat so
>>>>>>>>> I cannot confirm, but this sounds likely given what I see on wha=
t
>>>>>>>>> should be a relatively new SSD.
>>>>>>>>>
>>>>>>>>> Any idea of what it could be related to?
>>>>>>>>
>>>>>>>> There was a big refactor of the defrag code that landed in 5.16.
>>>>>>>>
>>>>>>>> On a quick glance, when using autodefrag it seems we now can end =
up in an
>>>>>>>> infinite loop by marking the same range for degrag (IO) over and =
over.
>>>>>>>>
>>>>>>>> Can you try the following patch? (also at https://pastebin.com/ra=
w/QR27Jv6n)
>>>>>>>
>>>>>>> Actually try this one instead:
>>>>>>>
>>>>>>> https://pastebin.com/raw/EbEfk1tF
>>>>>>>
>>>>>>> Also, there's a bug with defrag running into an (almost) infinite =
loop when
>>>>>>> attempting to defrag a 1 byte file. Someone ran into this and I've=
 just sent
>>>>>>> a fix for it:
>>>>>>>
>>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e=
21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
>>>>>>>
>>>>>>> Maybe that is what you are running into when using autodefrag.
>>>>>>> Firt try that fix for the 1 byte file case, and if after that you =
still run
>>>>>>> into problems, then try with the other patch above as well (both p=
atches
>>>>>>> applied).
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>>>>> index a5bd6926f7ff..0a9f6125a566 100644
>>>>>>>> --- a/fs/btrfs/ioctl.c
>>>>>>>> +++ b/fs/btrfs/ioctl.c
>>>>>>>> @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(struct b=
trfs_inode *inode,
>>>>>>>>                  if (em->generation < newer_than)
>>>>>>>>                          goto next;
>>>>>>>>
>>>>>>>> +               /*
>>>>>>>> +                * Skip extents already under IO, otherwise we ca=
n end up in an
>>>>>>>> +                * infinite loop when using auto defrag.
>>>>>>>> +                */
>>>>>>>> +               if (em->generation =3D=3D (u64)-1)
>>>>>>>> +                       goto next;
>>>>>>>> +
>>>>>>>>                  /*
>>>>>>>>                   * For do_compress case, we want to compress all=
 valid file
>>>>>>>>                   * extents, thus no @extent_thresh or mergeable =
check.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Fran=C3=A7ois-Xavier
>>>>>>>>>
>>>>>>>>> [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_perfo=
rmance_degradation_after_upgrading/
>>>>>>>>> [1] https://imgur.com/oYhYat1
