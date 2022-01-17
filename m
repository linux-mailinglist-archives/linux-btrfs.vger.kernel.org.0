Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8017149123F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 00:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbiAQXPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 18:15:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:37347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234551AbiAQXPy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 18:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642461348;
        bh=ELnHXUsolMrmG7K1ai2AuZ/RcYdfZpt2G2Ff+AuWDqU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Zs9MY1EibDJWPBcgVnNTAcMEwMWqIAtb6hKn5pyIoO75ErKYurUBYw8l5meerHGYw
         U98HuCyxqVQL0Qnp8O++m1GSga45OB2qXdhvL+CGzJhPh7jXFeAgvI5ArC9/C46wC3
         FN25UUOi/rPytzjeackpGbwbnL8wPICPpLRZvIho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9o1v-1nCc2I2scP-005oMv; Tue, 18
 Jan 2022 00:15:48 +0100
Message-ID: <3162e2e4-dd68-b0aa-a0d0-7ff6ce7cd5a0@gmx.com>
Date:   Tue, 18 Jan 2022 07:15:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: btrfs fi defrag hangs on small files, 100% CPU thread
Content-Language: en-US
To:     Anthony Ruhier <aruhier@mailbox.org>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org>
 <YeVc0r7lLtns0Bch@debian9.Home>
 <fa7b6afd-9646-898c-7a0e-1536fc2f94b9@mailbox.org>
 <YeWetp7/1q/4bU1O@debian9.Home>
 <254c8e30-6692-3f3c-59ea-e3456ca9a266@mailbox.org>
 <6c1b26b8-3af0-83e9-6260-33394ee8d883@mailbox.org>
 <CAL3q7H5UhQCnsGd25Jd=x5rfhgPkzdDPpO_4iLdj73qSeFUzKg@mail.gmail.com>
 <231bb827-de3e-570d-f5f5-e0698877d3f1@mailbox.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <231bb827-de3e-570d-f5f5-e0698877d3f1@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Y/IpdCvasLIcP866oYZCjH9lGyyrMrzmrLnwnvovDv0zgwCY9O
 sGZymAj162NqJjbSdCk8iOX7Cst6r9cHRi6pRXlETHDiG5rcFJtKwseNpd1Q8Jyotff7Xfe
 Ux8pu9Uqzec2G0iaQhQSsDE+iFs9Lxj0TiIzYkfy7gt9Faufq8xJPywyNiiOngfXlmlWIuD
 S8RicIOBmzFkloUFZpKEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xIpkOwJOUn0=:dvHMujSNye1I7cIWK0ZaxA
 sJtsh1v2ybAiSTBKN8Y2HAPeQiT+0LaJV7CG1sZSE/uT2e9gJ0AOZkwvTrE3spQlcRojwZZMI
 yFgEh/V0CfDEZQSdcP1jp9CNtsJTnZNm1CzST4aJQAs++vreVwta6wgB3a2rX3Nx50mr2ahg2
 gxyFe+HSI4vomUBiaO4KfY3yvQqzwUTqLiVzsnJ855tleG+b+OLywPKonUvXIAsFLW6Zu1eSD
 EmnQxMaf57TsW+z1rqFAKa+TEZsWMhFtnwno+phbgqqaUiBde1ATuQJwQG6lnJbuVqEKzRLMw
 mHM1WcfUn2teZv1D/q6+SWjp9WdHBbUWq8v6mJdm8fdacO0yX7Xg020s6rPDBRXHbamASfwNg
 EYht56mFDdVYa1dbazofZ9R4FPgTJy1d5pAoSuPfbgP0R8NbFNqexsWG8OOqc8iyJJ49SUEPI
 Y9kLuoZYYFQrbEXrBSZnS+f5vO++enRbP9jACYE4ybzZ2yMvfEVAFMpTikl1Q+9bMub78azHh
 MmV+UQv2BuIKPdLDkECUmj/j+m50wvclbo4ovbHoujl5vQ7jvvnEcv5rmPE1C+FRpnYWI7vwJ
 o7JX74OcmMGhYmPsNiPMhz1knsxxh0ChVOp/x46oMPThIqXMx88Ro8BvZ+S5P/xATw/todnHl
 qLiUpWJ6N656ZRzRCZ4RH0YoUHlBJd4WCby+B7n0I2cNM8W523fIk8mjiIVHKSOZ/PheiEdgd
 G2Txlroq/CZvHrYiAkHDTpR3r3rRsa8MVYNqi+QoIGmKy4S11zIudqHm1BqNKg+ZgRUfWuxu4
 qo80D509BdRj3w0/AtT2MjAlCQhHLxisaQdUIe076BE/asP/HHKeg+Eu3I9TFV+4v47vWa7sF
 y+vMfZ9I32bfeJH3TPn/464V/yYbUGJzu+3LYM/w2raCVOITfOnY/1KwEzUcvqu7GUKvdCCll
 J8RuV0W/Sz+QAMwHhy7VU7NvH/1N/yuuEgAwK4GSY5MS4UAt9aqhyrifZopEZVFqz++GOLKrP
 keKOVKPFwAWNsqW60Tzs1wb0Rzhx+M6Yv2RYhD1+EKqTzvEoLc5DXK+VJsch2OP91nAvoPtZt
 /ZWFX83Y34eGsA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/18 03:39, Anthony Ruhier wrote:
> I have some good news and bad news: the bad news is that it didn't fix
> the autodefrag problem (I applied the 2 patches).
>
> The good news is that when I enable autodefrag, I can quickly see if the
> problem is still there or not.
> It's not super obvious compared to the amount of writes that happened
> constantly just after my upgrade to linux 5.16, because since then the
> problem mitigated itself a bit, but it's still noticeable.
>
> If I compare the write average (in total, I don't have it per process)
> when taking idle periods on the same machine:
>  =C2=A0=C2=A0=C2=A0 Linux 5.16:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 without autodefrag: ~ 10KiB/=
s
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with autodefrag: between 1 a=
nd 2MiB/s.
>
>  =C2=A0=C2=A0=C2=A0 Linux 5.15:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with autodefrag:~ 10KiB/s (a=
round the same as without
> autodefrag on 5.16)
>
> Feel free to ask me anything to help your debugging, just try to be
> quite explicit about what I should do, I'm not experimented in
> filesystems debugging.

Mind to test the following diff (along with previous two patches from
Filipe)?

I screwed up, the refactor changed how the defraged bytes accounting,
which I didn't notice that autodefrag relies on that to requeue the inode.

The refactor is originally to add support for subpage defrag, but it
looks like I pushed the boundary too hard to change some behaviors.


diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 11204dbbe053..c720260f9656 100644
=2D-- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -312,7 +312,9 @@ static int __btrfs_run_defrag_inode(struct
btrfs_fs_info *fs_info,
          */
         if (num_defrag =3D=3D BTRFS_DEFRAG_BATCH) {
                 defrag->last_offset =3D range.start;
+               /*
                 btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
+               */
         } else if (defrag->last_offset && !defrag->cycled) {
                 /*
                  * we didn't fill our defrag batch, but
@@ -321,7 +323,9 @@ static int __btrfs_run_defrag_inode(struct
btrfs_fs_info *fs_info,
                  */
                 defrag->last_offset =3D 0;
                 defrag->cycled =3D 1;
+               /*
                 btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
+               */
         } else {
                 kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
         }



> Thanks
>
> Le 17/01/2022 =C3=A0 18:56, Filipe Manana a =C3=A9crit=C2=A0:
>> On Mon, Jan 17, 2022 at 5:50 PM Anthony Ruhier <aruhier@mailbox.org>
>> wrote:
>>> Filipe,
>>>
>>> Just a quick update after my previous email, your patch fixed the issu=
e
>>> for `btrfs fi defrag`.
>>> Thanks a lot! I closed my bug on bugzilla.
>>>
>>> I'll keep you in touch about the autodefrag.
>> Please do.
>> The 1 byte file case was very specific, so it's probably a different
>> issue.
>>
>> Thanks for testing!
>>
>>> Le 17/01/2022 =C3=A0 18:04, Anthony Ruhier a =C3=A9crit :
>>>> I'm going to apply your patch for the 1B file, and quickly confirm if
>>>> it works.
>>>> Thanks a lot for your patch!
>>>>
>>>> About the autodefrag issue, it's going to be trickier to check that
>>>> your patch fixes it, because for whatever reason the problem seems to
>>>> have resolved itself (or at least, btrfs-cleaner does way less writes=
)
>>>> after a partial btrfs balance.
>>>> I'll try and look the amount of writes after several hours. Maybe for
>>>> this one, see with the author of the other bug. If they can easily
>>>> reproduce the issue then it's going to be easier to check.
>>>>
>>>> Thanks,
>>>> Anthony
>>>>
>>>> Le 17/01/2022 =C3=A0 17:52, Filipe Manana a =C3=A9crit :
>>>>> On Mon, Jan 17, 2022 at 03:24:00PM +0100, Anthony Ruhier wrote:
>>>>>> Thanks for the answer.
>>>>>>
>>>>>> I had the exact same issue as in the thread you've linked, and have
>>>>>> some
>>>>>> monitoring and graphs that showed that btrfs-cleaner did constant
>>>>>> writes
>>>>>> during 12 hours just after I upgraded to linux 5.16. Weirdly enough=
,
>>>>>> the
>>>>>> issue almost disappeared after I did a btrfs balance by filtering o=
n
>>>>>> 10%
>>>>>> usage of data.
>>>>>> But that's why I initially disabled autodefrag, what has lead to
>>>>>> discovering
>>>>>> this bug as I switched to manual defragmentation (which, in the end=
,
>>>>>> makes
>>>>>> more sense anyway with my setup).
>>>>>>
>>>>>> I tried this patch, but sadly it doesn't help for the initial
>>>>>> issue. I
>>>>>> cannot say for the bug in the other thread, as the problem with
>>>>>> btrfs-cleaner disappeared (I can still see some writes from it, but
>>>>>> it so
>>>>>> rare that I cannot say if it's normal or not).
>>>>> Ok, reading better your first mail, I see there's the case of the 1
>>>>> byte
>>>>> file, which is possibly not the cause from the autodefrag causing th=
e
>>>>> excessive IO problem.
>>>>>
>>>>> For the 1 byte file problem, I've just sent a fix:
>>>>>
>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21=
bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
>>>>>
>>>>>
>>>>>
>>>>> It's actually trivial to trigger.
>>>>>
>>>>> Can you check if it also fixes your problem with autodefrag?
>>>>>
>>>>> If not, then try the following (after applying the 1 file fix):
>>>>>
>>>>> https://pastebin.com/raw/EbEfk1tF
>>>>>
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index a5bd6926f7ff..db795e226cca 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -1191,6 +1191,7 @@ static int defrag_collect_targets(struct
>>>>> btrfs_inode *inode,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 newer_than, boo=
l do_compress,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool locked, struct=
 list_head *target_list)
>>>>> =C2=A0=C2=A0 {
>>>>> +=C2=A0=C2=A0=C2=A0 const u32 min_thresh =3D extent_thresh / 2;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 cur =3D start;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>>> =C2=A0=C2=A0 @@ -1198,6 +1199,7 @@ static int defrag_collect_targets=
(struct
>>>>> btrfs_inode *inode,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
extent_map *em;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
defrag_target_range *new;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool ne=
xt_mergeable =3D true;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 range_start;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 ran=
ge_len;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 em =3D defrag_lookup_extent(&inode->vfs_inode, cur,
>>>>> locked);
>>>>> @@ -1213,6 +1215,24 @@ static int defrag_collect_targets(struct
>>>>> btrfs_inode *inode,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em-=
>generation < newer_than)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto next;
>>>>> =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Our start offset=
 might be in the middle of an existing
>>>>> extent
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * map, so take tha=
t into account.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_len =3D em->len - =
(cur - em->start);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If there's alrea=
dy a good range for delalloc within the
>>>>> range
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * covered by the e=
xtent map, skip it, otherwise we can
>>>>> end up
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * doing on the sam=
e IO range for a long time when using auto
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * defrag.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_start =3D cur;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (count_range_bits(&in=
ode->io_tree, &range_start,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_start + range=
_len - 1, min_thresh,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTENT_DELALLOC, 1)=
 >=3D min_thresh)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto next;
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
 For do_compress case, we want to compress all valid file
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
 extents, thus no @extent_thresh or mergeable check.
>>>>> @@ -1220,8 +1240,8 @@ static int defrag_collect_targets(struct
>>>>> btrfs_inode *inode,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (do_=
compress)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto add;
>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip too=
 large extent */
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em->len >=3D extent_=
thresh)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip large enough ran=
ges. */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (range_len >=3D exten=
t_thresh)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto next;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 next_mergeable =3D
>>>>> defrag_check_next_extent(&inode->vfs_inode, em,
>>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Anthony
>>>>>>
>>>>>> Le 17/01/2022 =C3=A0 13:10, Filipe Manana a =C3=A9crit :
>>>>>>> On Sun, Jan 16, 2022 at 08:15:37PM +0100, Anthony Ruhier wrote:
>>>>>>>> Hi,
>>>>>>>> Since I upgraded from linux 5.15 to 5.16, `btrfs filesystem defra=
g
>>>>>>>> -t128K`
>>>>>>>> hangs on small files (~1 byte) and triggers what it seems to be a
>>>>>>>> loop in
>>>>>>>> the kernel. It results in one CPU thread running being used at
>>>>>>>> 100%. I
>>>>>>>> cannot kill the process, and rebooting is blocked by btrfs.
>>>>>>>> It is a copy of the
>>>>>>>> bughttps://bugzilla.kernel.org/show_bug.cgi?id=3D215498
>>>>>>>>
>>>>>>>> Rebooting to linux 5.15 shows no issue. I have no issue to run a
>>>>>>>> defrag on
>>>>>>>> bigger files (I filter out files smaller than 3.9KB).
>>>>>>>>
>>>>>>>> I had a conversation on #btrfs on IRC, so here's what we debugged=
:
>>>>>>>>
>>>>>>>> I can replicate the issue by copying a file impacted by this bug,
>>>>>>>> by using
>>>>>>>> `cp --reflink=3Dnever`. I attached one of the impacted files to t=
his
>>>>>>>> bug,
>>>>>>>> named README.md.
>>>>>>>>
>>>>>>>> Someone told me that it could be a bug due to the inline extent.
>>>>>>>> So we tried
>>>>>>>> to check that.
>>>>>>>>
>>>>>>>> filefrag shows that the file Readme.md is 1 inline extent. I trie=
d
>>>>>>>> to create
>>>>>>>> a new file with random text, of 18 bytes (slightly bigger than th=
e
>>>>>>>> other
>>>>>>>> file), that is also 1 inline extent. This file doesn't trigger th=
e
>>>>>>>> bug and
>>>>>>>> has no issue to be defragmented.
>>>>>>>>
>>>>>>>> I tried to mount my system with `max_inline=3D0`, created a copy =
of
>>>>>>>> README.md.
>>>>>>>> `filefrag` shows me that the new file is now 1 extent, not inline=
.
>>>>>>>> This new
>>>>>>>> file also triggers the bug, so it doesn't seem to be due to the
>>>>>>>> inline
>>>>>>>> extent.
>>>>>>>>
>>>>>>>> Someone asked me to provide the output of a perf top when the
>>>>>>>> defrag is
>>>>>>>> stuck:
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28.70%=C2=A0 [kernel]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] generic_bin_search
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14.90%=C2=A0 [kernel]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] free_extent_buffer
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13.17%=C2=A0 [kernel]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] btrfs_search_slot
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12.63%=C2=A0 [kernel]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] btrfs_root_node
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.33%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] btrfs_get_64
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.88%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] __down_read_com=
mon.llvm
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.00%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] up_read
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.63%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] read_block_for_=
search
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.40%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] read_extent_buf=
fer
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.38%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] memset_erms
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.11%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] find_extent_buf=
fer
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.69%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] kmem_cache_free
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.69%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] memcpy_erms
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.57%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] kmem_cache_allo=
c
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.45%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] radix_tree_look=
up
>>>>>>>>
>>>>>>>> I can reproduce the bug on 2 different machines, running 2
>>>>>>>> different linux
>>>>>>>> distributions (Arch and Gentoo) with 2 different kernel configs.
>>>>>>>> This kernel is compiled with clang, the other with GCC.
>>>>>>>>
>>>>>>>> Kernel version: 5.16.0
>>>>>>>> Mount options:
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Machine 1:
>>>>>>>> rw,noatime,compress-force=3Dzstd:2,ssd,discard=3Dasync,space_cach=
e=3Dv2,autodefrag
>>>>>>>>
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Machine 2:
>>>>>>>> rw,noatime,compress-force=3Dzstd:3,nossd,space_cache=3Dv2
>>>>>>>>
>>>>>>>> When the error happens, no message is shown in dmesg.
>>>>>>> This is very likely the same issue as reported at this thread:
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-btrfs/YeVawBBE3r6hVhgs@debian9.Home/=
T/#ma1c8a9848c9b7e4edb471f7be184599d38e288bb
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Are you able to test the patch posted there?
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Anthony Ruhier
>>>>>>>>
>>>>>
>>>>>
>>>>>
