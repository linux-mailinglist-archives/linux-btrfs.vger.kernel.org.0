Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B73492549
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbiARL6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 06:58:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:38131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237808AbiARL6P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 06:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642507089;
        bh=iNa2L8vcXrJsySphU6I1kvDAc31ywIbiZzwzyy8hWz8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Im4s72IG9GxAvEVitAjO1z0rx3hyLRTVM6ToF6KMVsVXDYMI0qwcdA3Boagt4lmJm
         puqkUhs4BmuNpQvhmLFewODw+MUDUmSK+u9bCR0FD4bTlt23iei1y+uPBQOCNQkbsD
         VSiXZE/HDwjpo9rHINscSo1iBnci2mZ2gHe7QKUk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE6F-1muAqx14Pr-00KhpD; Tue, 18
 Jan 2022 12:58:09 +0100
Message-ID: <b3c35945-6ec3-a086-d33e-c8596db12e18@gmx.com>
Date:   Tue, 18 Jan 2022 19:58:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: btrfs fi defrag hangs on small files, 100% CPU thread
Content-Language: en-US
To:     Anthony Ruhier <aruhier@mailbox.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>
References: <0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org>
 <YeVc0r7lLtns0Bch@debian9.Home>
 <fa7b6afd-9646-898c-7a0e-1536fc2f94b9@mailbox.org>
 <YeWetp7/1q/4bU1O@debian9.Home>
 <254c8e30-6692-3f3c-59ea-e3456ca9a266@mailbox.org>
 <6c1b26b8-3af0-83e9-6260-33394ee8d883@mailbox.org>
 <CAL3q7H5UhQCnsGd25Jd=x5rfhgPkzdDPpO_4iLdj73qSeFUzKg@mail.gmail.com>
 <231bb827-de3e-570d-f5f5-e0698877d3f1@mailbox.org>
 <3162e2e4-dd68-b0aa-a0d0-7ff6ce7cd5a0@gmx.com>
 <e811a5b7-1ffe-b062-5c53-b3da4c26d04d@gmx.com>
 <8ecb84e1-b8da-20f2-8730-8c1403ac7d00@mailbox.org>
 <2d4ed9ca-52a7-3a39-1a4f-995c6ed0d070@gmx.com>
 <8d08b05d-4632-2bbd-7021-f79ee0fc2796@mailbox.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8d08b05d-4632-2bbd-7021-f79ee0fc2796@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BngOxcYC8rYnJkV4LJ7c42LSKdunnCfP/bsOCISzRxFxSUDdg+u
 8QPS1wNDSfNM88UHKRrVmF5tvZQ2lWZiieh+ng7/XcfJaNGBA1On5JcpILVqSwA+Haqul8r
 gXGpmTOFWdMIOA35gEfKSsm/aUD3FhMZVUXnm4e2xI/wHXpD74wYZ9Ck5XE5OokhehUjPK6
 gpcdcIfNgKhVTx+Ev9fEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EGTUU7kPtGY=:qeSeXtxZOVczDAk6WDmICK
 XY3j/jRzgJWB7WpYmFIIyOKT5dsI/pKg0dyOshORauGCIBAhJoNgIhJuG1nVYcZS/HonPL+F3
 fv1xyooh6x0M7Keg/pVEcPkOS8xuOu8qi52yVfxbP8/16/csCa8BUwmhCGo7w69OQtFWSqgK5
 m7lLeEOGvy/q2T6KyYoD3MY8S1va7oqo2D2Dftv6N/5J1c9fehBIXLDR+K5ZvMmCYAm1PhKys
 dl6MSgwUDkpLhD5E7T1M0WHghS8r0ndvFnEoxHYntA5qwmA+FjOmpUEjPfyAO5ooLNzPQYd69
 C2Xpfdp2yWa3pfCfAD1AwXx4maBI/2xkStvI/76wrM/EtXqTEePKFafEVms2V84SOb94xN2uJ
 U637IqNnfAVt+wuxGhBmClNTaOQ7kuNOT4xB0w7sCGU+tH2GVDDjxNK5EAWb2ljYg7rXxdcJu
 swytZRNsr62zM6vozeMcKj/Qpq3bYrBH6XIA87rOgRYwIV6O3AtyyEaZtUFbtmraOrPJnPln0
 r5xoEG5PqRE+2mjCb21cuKd6ob619ruuCjVqa7Ci7NkhmiU4i6WrToow9/HjocLwkrSVySmPm
 fi3skicNB5vBasDnkL8FfVwLv6AfH3R9Ba+ndxAhrQLGs1qBjDzGXy5Y2EMXyzzt1RISUYnkx
 UBtU32PV9gJyZD5HwpaTjt3tS2+guFBbkAj2z3bwc0bj88YcsS5UJF9PPO8C2I26+BoeSN/eS
 EOd8rYYey+bSgT8+tyqGCWvruEui3dVY7qjhxrmmN7I0Sgb2XtzF4nVMNapyDpoi3HzGCvzxP
 xsIoFjc+xnPWuK55BZGTG2DE1n8hmZtvfvg/mBEqPgXgkKHpxPRh+kyCSAvM3fC8ulKIvZhBf
 znbxdYwP8v5G2nJe8Qy0rIIFsw8DgXAOJ+9IZRUoP6VeGCYQ72sGhQF2x9T/TS2B3kVfcTcTX
 qCeY+Irj3cSF+FLTQjHN5hIDwuqw3RO6rQUT5PQkFc/AXBHoxN+vOQaVR7MJwMjj/XVyN1MgA
 FyxlWmUBIHwkZTnKTOK+jYRjdcKoFK+nIgBrO96hwKXTaMFKPkW+7K0bisnbjJ6l/WXC3qXh1
 QCRdUL2pBQOS9g=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/18 18:57, Anthony Ruhier wrote:
> Indeed, the problem took just a longer time to appear with your previous
> patch. It wasn't from btrfs-cleaner itself, this time, but I had a lot
> of writes.
> I'm trying the last one and keep you in touch!

And another autodefrag related problem exposed...

Thankfully, the involved fixes are all small enough.

So would you please try the following patches? (The first one from
Filipe is not touched, the 2nd one is mostly the same but with minor
tweaks for commit message, the the final one is the new one):

https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bbfed2=
484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/

https://patchwork.kernel.org/project/linux-btrfs/patch/20220118071904.2999=
1-1-wqu@suse.com/

https://lore.kernel.org/linux-btrfs/20220118115352.52126-1-wqu@suse.com/T/=
#u

Thanks,
Qu

>
> Thanks
>
> Le 18/01/2022 =C3=A0 03:22, Qu Wenruo a =C3=A9crit=C2=A0:
>>
>>
>> On 2022/1/18 09:58, Anthony Ruhier wrote:
>>> Hi Qu,
>>>
>>> No problem, thanks a lot for your patch! After a quick look on a 10min
>>> period, it looks like your patch fixed the issue. I've applied the 2
>>> patches from Filipe and yours.
>>> I'll let my NAS run over the night and watch the writes average on a
>>> longer period. I'll send an update in ~10 hours.
>>
>> I'm really sorry for all the problems.
>>
>> Currently I believe the root cause is I changed the return value of
>> btrfs_defrag_file(), which should return the number of sectors defragge=
d.
>>
>> Even I renamed the variable to "sectors_defragged", I still return it i=
n
>> bytes instead.
>>
>> (Furthermore it tends to report more bytes than really defragged).
>>
>> The diff I mentioned is not really to solve the problem, but to help us
>> to pin down the problem.
>> (The diff itself will make autodefrag to do a little less work, thus it
>> may not defrag as hard as previously)
>>
>> Thank you very much helping fixing the mess I caused.
>>
>>
>> BTW, if you have spare machines, mind to test the following two patches=
?
>> (if everything works as expected, they should be the final fixes, thus
>> please test without other patches)
>>
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20220118021544.1=
8543-1-wqu@suse.com/
>>
>> https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bbf=
ed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
>>
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>> Thanks a lot for your help,
>>> Anthony
>>>
>>> Le 18/01/2022 =C3=A0 00:32, Qu Wenruo a =C3=A9crit=C2=A0:
>>>>
>>>>
>>>> On 2022/1/18 07:15, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/1/18 03:39, Anthony Ruhier wrote:
>>>>>> I have some good news and bad news: the bad news is that it didn't
>>>>>> fix
>>>>>> the autodefrag problem (I applied the 2 patches).
>>>>>>
>>>>>> The good news is that when I enable autodefrag, I can quickly see i=
f
>>>>>> the
>>>>>> problem is still there or not.
>>>>>> It's not super obvious compared to the amount of writes that happen=
ed
>>>>>> constantly just after my upgrade to linux 5.16, because since then
>>>>>> the
>>>>>> problem mitigated itself a bit, but it's still noticeable.
>>>>>>
>>>>>> If I compare the write average (in total, I don't have it per
>>>>>> process)
>>>>>> when taking idle periods on the same machine:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Linux 5.16:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 without autodefrag=
: ~ 10KiB/s
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with autodefrag: b=
etween 1 and 2MiB/s.
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Linux 5.15:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with autodefrag:~ =
10KiB/s (around the same as without
>>>>>> autodefrag on 5.16)
>>>>>>
>>>>>> Feel free to ask me anything to help your debugging, just try to be
>>>>>> quite explicit about what I should do, I'm not experimented in
>>>>>> filesystems debugging.
>>>>>
>>>>> Mind to test the following diff (along with previous two patches fro=
m
>>>>> Filipe)?
>>>>>
>>>>> I screwed up, the refactor changed how the defraged bytes accounting=
,
>>>>> which I didn't notice that autodefrag relies on that to requeue the
>>>>> inode.
>>>>>
>>>>> The refactor is originally to add support for subpage defrag, but it
>>>>> looks like I pushed the boundary too hard to change some behaviors.
>>>>
>>>> Sorry, previous diff has a memory leakage bug.
>>>>
>>>> The autodefrag code is more complex than I thought, it has extra logi=
c
>>>> to handle defrag.
>>>>
>>>> Please try this one instead.
>>>>
>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>> index 11204dbbe053..096feecf2602 100644
>>>> --- a/fs/btrfs/file.c
>>>> +++ b/fs/btrfs/file.c
>>>> @@ -305,26 +305,7 @@ static int __btrfs_run_defrag_inode(struct
>>>> btrfs_fs_info *fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_defrag =3D btrfs_defra=
g_file(inode, NULL, &range,
>>>> defrag->transid,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BTRFS_DEFRAG_BATCH);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sb_end_write(fs_info->sb);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if we filled the whole =
defrag batch, there
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must be more work to do=
.=C2=A0 Queue this defrag
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * again
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (num_defrag =3D=3D BTRFS_DEF=
RAG_BATCH) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 defrag->last_offset =3D range.start;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (defrag->last_offset =
&& !defrag->cycled) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /*
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * we didn't fill our defrag batch, but
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * we didn't start at zero.=C2=A0 Make sure we loo=
p
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * around to the start of the file.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 defrag->last_offset =3D 0;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 defrag->cycled =3D 1;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(btrfs_inode_def=
rag_cachep, defrag);
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iput(inode);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>
>>>>>
>>>>>
>>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>>> index 11204dbbe053..c720260f9656 100644
>>>>> --- a/fs/btrfs/file.c
>>>>> +++ b/fs/btrfs/file.c
>>>>> @@ -312,7 +312,9 @@ static int __btrfs_run_defrag_inode(struct
>>>>> btrfs_fs_info *fs_info,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (num_defrag =3D=
=3D BTRFS_DEFRAG_BATCH) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defrag->last_offset =3D range.start;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_requeue_inode_defrag(BTRFS_I(inode), =
defrag);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (defrag->=
last_offset && !defrag->cycled) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we didn't fill our defrag batch, bu=
t
>>>>> @@ -321,7 +323,9 @@ static int __btrfs_run_defrag_inode(struct
>>>>> btrfs_fs_info *fs_info,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defrag->last_offset =3D 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defrag->cycled =3D 1;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_requeue_inode_defrag(BTRFS_I(inode), =
defrag);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(btrfs_inode_defrag_cachep, =
defrag);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>>
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Le 17/01/2022 =C3=A0 18:56, Filipe Manana a =C3=A9crit=C2=A0:
>>>>>>> On Mon, Jan 17, 2022 at 5:50 PM Anthony Ruhier <aruhier@mailbox.or=
g>
>>>>>>> wrote:
>>>>>>>> Filipe,
>>>>>>>>
>>>>>>>> Just a quick update after my previous email, your patch fixed the
>>>>>>>> issue
>>>>>>>> for `btrfs fi defrag`.
>>>>>>>> Thanks a lot! I closed my bug on bugzilla.
>>>>>>>>
>>>>>>>> I'll keep you in touch about the autodefrag.
>>>>>>> Please do.
>>>>>>> The 1 byte file case was very specific, so it's probably a differe=
nt
>>>>>>> issue.
>>>>>>>
>>>>>>> Thanks for testing!
>>>>>>>
>>>>>>>> Le 17/01/2022 =C3=A0 18:04, Anthony Ruhier a =C3=A9crit :
>>>>>>>>> I'm going to apply your patch for the 1B file, and quickly
>>>>>>>>> confirm if
>>>>>>>>> it works.
>>>>>>>>> Thanks a lot for your patch!
>>>>>>>>>
>>>>>>>>> About the autodefrag issue, it's going to be trickier to check
>>>>>>>>> that
>>>>>>>>> your patch fixes it, because for whatever reason the problem
>>>>>>>>> seems to
>>>>>>>>> have resolved itself (or at least, btrfs-cleaner does way less
>>>>>>>>> writes)
>>>>>>>>> after a partial btrfs balance.
>>>>>>>>> I'll try and look the amount of writes after several hours. Mayb=
e
>>>>>>>>> for
>>>>>>>>> this one, see with the author of the other bug. If they can easi=
ly
>>>>>>>>> reproduce the issue then it's going to be easier to check.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Anthony
>>>>>>>>>
>>>>>>>>> Le 17/01/2022 =C3=A0 17:52, Filipe Manana a =C3=A9crit :
>>>>>>>>>> On Mon, Jan 17, 2022 at 03:24:00PM +0100, Anthony Ruhier wrote:
>>>>>>>>>>> Thanks for the answer.
>>>>>>>>>>>
>>>>>>>>>>> I had the exact same issue as in the thread you've linked, and
>>>>>>>>>>> have
>>>>>>>>>>> some
>>>>>>>>>>> monitoring and graphs that showed that btrfs-cleaner did
>>>>>>>>>>> constant
>>>>>>>>>>> writes
>>>>>>>>>>> during 12 hours just after I upgraded to linux 5.16. Weirdly
>>>>>>>>>>> enough,
>>>>>>>>>>> the
>>>>>>>>>>> issue almost disappeared after I did a btrfs balance by
>>>>>>>>>>> filtering on
>>>>>>>>>>> 10%
>>>>>>>>>>> usage of data.
>>>>>>>>>>> But that's why I initially disabled autodefrag, what has lead =
to
>>>>>>>>>>> discovering
>>>>>>>>>>> this bug as I switched to manual defragmentation (which, in th=
e
>>>>>>>>>>> end,
>>>>>>>>>>> makes
>>>>>>>>>>> more sense anyway with my setup).
>>>>>>>>>>>
>>>>>>>>>>> I tried this patch, but sadly it doesn't help for the initial
>>>>>>>>>>> issue. I
>>>>>>>>>>> cannot say for the bug in the other thread, as the problem wit=
h
>>>>>>>>>>> btrfs-cleaner disappeared (I can still see some writes from it=
,
>>>>>>>>>>> but
>>>>>>>>>>> it so
>>>>>>>>>>> rare that I cannot say if it's normal or not).
>>>>>>>>>> Ok, reading better your first mail, I see there's the case of
>>>>>>>>>> the 1
>>>>>>>>>> byte
>>>>>>>>>> file, which is possibly not the cause from the autodefrag
>>>>>>>>>> causing the
>>>>>>>>>> excessive IO problem.
>>>>>>>>>>
>>>>>>>>>> For the 1 byte file problem, I've just sent a fix:
>>>>>>>>>>
>>>>>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0f=
f7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> It's actually trivial to trigger.
>>>>>>>>>>
>>>>>>>>>> Can you check if it also fixes your problem with autodefrag?
>>>>>>>>>>
>>>>>>>>>> If not, then try the following (after applying the 1 file fix):
>>>>>>>>>>
>>>>>>>>>> https://pastebin.com/raw/EbEfk1tF
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>>>>>>> index a5bd6926f7ff..db795e226cca 100644
>>>>>>>>>> --- a/fs/btrfs/ioctl.c
>>>>>>>>>> +++ b/fs/btrfs/ioctl.c
>>>>>>>>>> @@ -1191,6 +1191,7 @@ static int defrag_collect_targets(struct
>>>>>>>>>> btrfs_inode *inode,
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 newer_than, =
bool do_compress,
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool locked, str=
uct list_head *target_list)
>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 const u32 min_thresh =3D extent_thresh / 2;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 cur =3D start;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>>>>>>>> =C2=A0=C2=A0 @@ -1198,6 +1199,7 @@ static int defrag_collect_ta=
rgets(struct
>>>>>>>>>> btrfs_inode *inode,
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct extent_map *em;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct defrag_target_range *new;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo=
ol next_mergeable =3D true;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 range_start;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u6=
4 range_len;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 em =3D defrag_lookup_extent(&inode->vfs_inode, cur,
>>>>>>>>>> locked);
>>>>>>>>>> @@ -1213,6 +1215,24 @@ static int defrag_collect_targets(struct
>>>>>>>>>> btrfs_inode *inode,
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (em->generation < newer_than)
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto next;
>>>>>>>>>> =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Our start o=
ffset might be in the middle of an
>>>>>>>>>> existing
>>>>>>>>>> extent
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * map, so tak=
e that into account.
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_len =3D em->l=
en - (cur - em->start);
>>>>>>>>>> +
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If there's =
already a good range for delalloc
>>>>>>>>>> within the
>>>>>>>>>> range
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * covered by =
the extent map, skip it, otherwise we can
>>>>>>>>>> end up
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * doing on th=
e same IO range for a long time when using
>>>>>>>>>> auto
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * defrag.
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_start =3D cur=
;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (count_range_bit=
s(&inode->io_tree, &range_start,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_start +=
 range_len - 1, min_thresh,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTENT_DELALL=
OC, 1) >=3D min_thresh)
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto next;
>>>>>>>>>> +
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * For do_compress case, we want to compress all valid
>>>>>>>>>> file
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * extents, thus no @extent_thresh or mergeable check.
>>>>>>>>>> @@ -1220,8 +1240,8 @@ static int defrag_collect_targets(struct
>>>>>>>>>> btrfs_inode *inode,
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (do_compress)
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto add;
>>>>>>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ski=
p too large extent */
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em->len >=3D ex=
tent_thresh)
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip large enoug=
h ranges. */
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (range_len >=3D =
extent_thresh)
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto next;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 next_mergeable =3D
>>>>>>>>>> defrag_check_next_extent(&inode->vfs_inode, em,
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Anthony
>>>>>>>>>>>
>>>>>>>>>>> Le 17/01/2022 =C3=A0 13:10, Filipe Manana a =C3=A9crit :
>>>>>>>>>>>> On Sun, Jan 16, 2022 at 08:15:37PM +0100, Anthony Ruhier wrot=
e:
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>> Since I upgraded from linux 5.15 to 5.16, `btrfs filesystem
>>>>>>>>>>>>> defrag
>>>>>>>>>>>>> -t128K`
>>>>>>>>>>>>> hangs on small files (~1 byte) and triggers what it seems to
>>>>>>>>>>>>> be a
>>>>>>>>>>>>> loop in
>>>>>>>>>>>>> the kernel. It results in one CPU thread running being used =
at
>>>>>>>>>>>>> 100%. I
>>>>>>>>>>>>> cannot kill the process, and rebooting is blocked by btrfs.
>>>>>>>>>>>>> It is a copy of the
>>>>>>>>>>>>> bughttps://bugzilla.kernel.org/show_bug.cgi?id=3D215498
>>>>>>>>>>>>>
>>>>>>>>>>>>> Rebooting to linux 5.15 shows no issue. I have no issue to
>>>>>>>>>>>>> run a
>>>>>>>>>>>>> defrag on
>>>>>>>>>>>>> bigger files (I filter out files smaller than 3.9KB).
>>>>>>>>>>>>>
>>>>>>>>>>>>> I had a conversation on #btrfs on IRC, so here's what we
>>>>>>>>>>>>> debugged:
>>>>>>>>>>>>>
>>>>>>>>>>>>> I can replicate the issue by copying a file impacted by this
>>>>>>>>>>>>> bug,
>>>>>>>>>>>>> by using
>>>>>>>>>>>>> `cp --reflink=3Dnever`. I attached one of the impacted files=
 to
>>>>>>>>>>>>> this
>>>>>>>>>>>>> bug,
>>>>>>>>>>>>> named README.md.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Someone told me that it could be a bug due to the inline
>>>>>>>>>>>>> extent.
>>>>>>>>>>>>> So we tried
>>>>>>>>>>>>> to check that.
>>>>>>>>>>>>>
>>>>>>>>>>>>> filefrag shows that the file Readme.md is 1 inline extent. I
>>>>>>>>>>>>> tried
>>>>>>>>>>>>> to create
>>>>>>>>>>>>> a new file with random text, of 18 bytes (slightly bigger
>>>>>>>>>>>>> than the
>>>>>>>>>>>>> other
>>>>>>>>>>>>> file), that is also 1 inline extent. This file doesn't
>>>>>>>>>>>>> trigger the
>>>>>>>>>>>>> bug and
>>>>>>>>>>>>> has no issue to be defragmented.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I tried to mount my system with `max_inline=3D0`, created a
>>>>>>>>>>>>> copy of
>>>>>>>>>>>>> README.md.
>>>>>>>>>>>>> `filefrag` shows me that the new file is now 1 extent, not
>>>>>>>>>>>>> inline.
>>>>>>>>>>>>> This new
>>>>>>>>>>>>> file also triggers the bug, so it doesn't seem to be due to
>>>>>>>>>>>>> the
>>>>>>>>>>>>> inline
>>>>>>>>>>>>> extent.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Someone asked me to provide the output of a perf top when th=
e
>>>>>>>>>>>>> defrag is
>>>>>>>>>>>>> stuck:
>>>>>>>>>>>>>
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28.70%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] generic_bin_sea=
rch
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14.90%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] free_extent_buf=
fer
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13.17%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] btrfs_search_sl=
ot
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12.63%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] btrfs_root_node
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.33%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] btrfs_get_64
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.88%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] __down_read_=
common.llvm
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.00%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] up_read
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.63%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] read_block_f=
or_search
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.40%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] read_extent_=
buffer
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.38%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] memset_erms
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.11%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] find_extent_=
buffer
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.69%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] kmem_cache_f=
ree
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.69%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] memcpy_erms
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.57%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] kmem_cache_a=
lloc
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.45%=C2=A0 [kern=
el]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] radix_tree_l=
ookup
>>>>>>>>>>>>>
>>>>>>>>>>>>> I can reproduce the bug on 2 different machines, running 2
>>>>>>>>>>>>> different linux
>>>>>>>>>>>>> distributions (Arch and Gentoo) with 2 different kernel
>>>>>>>>>>>>> configs.
>>>>>>>>>>>>> This kernel is compiled with clang, the other with GCC.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Kernel version: 5.16.0
>>>>>>>>>>>>> Mount options:
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Machine 1:
>>>>>>>>>>>>> rw,noatime,compress-force=3Dzstd:2,ssd,discard=3Dasync,space=
_cache=3Dv2,autodefrag
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Machine 2:
>>>>>>>>>>>>> rw,noatime,compress-force=3Dzstd:3,nossd,space_cache=3Dv2
>>>>>>>>>>>>>
>>>>>>>>>>>>> When the error happens, no message is shown in dmesg.
>>>>>>>>>>>> This is very likely the same issue as reported at this thread=
:
>>>>>>>>>>>>
>>>>>>>>>>>> https://lore.kernel.org/linux-btrfs/YeVawBBE3r6hVhgs@debian9.=
Home/T/#ma1c8a9848c9b7e4edb471f7be184599d38e288bb
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Are you able to test the patch posted there?
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks.
>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> Anthony Ruhier
>>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
