Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85B8491260
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 00:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbiAQXcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 18:32:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:52059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235399AbiAQXcb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 18:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642462346;
        bh=L7woVj7hR/HjiGOiCCojs4lFOp81eBzjaKfa7cTQLTA=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=N3D4eFT5AAiwzVG8JJGp2w6Kq4H53fhLRt2QPc82Gs/Im6D9X57eHkRu5wHnR0QCi
         Ug3Bi9b0ZR3WiNksSwPX350Z4ThYx/qigyHZ/D/SB9hmYA8VQJTsCF8c50WuOyrBpC
         HB7MUvsXMIgGC8cb6pNMsp+yHyFqsc0c2JV15XXQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpf3-1mSnck0bjr-00mHvq; Tue, 18
 Jan 2022 00:32:25 +0100
Message-ID: <e811a5b7-1ffe-b062-5c53-b3da4c26d04d@gmx.com>
Date:   Tue, 18 Jan 2022 07:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: btrfs fi defrag hangs on small files, 100% CPU thread
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 <3162e2e4-dd68-b0aa-a0d0-7ff6ce7cd5a0@gmx.com>
In-Reply-To: <3162e2e4-dd68-b0aa-a0d0-7ff6ce7cd5a0@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+xiwFfaay4Obwo+nR96Ar3MqJ5wz74iI/g44cNZq822W9VcmPCJ
 UQrwoRd/Zrt2Qx+3Eykjxv4dS7BZkROdg3fVD3c/fInXy7rI9LSobETmhfPxVT46/c6fXIH
 vdyL8Nxi2WbdlzGGOekV0abne+UWZqUpQjHqj0ADtSKV6NLmvJo2pmj/+8xnQM8QXjGXORl
 7DnK3djon15tyauJJHtCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2FwSqANdAYo=:4VXkLZxmDBDGHz/K+2kjDW
 R37im+U6TOkK84vg1Grc/iVFXOmIXlwTpZmmJGyvnCf7llckFazMsihEHOh4tqllEeEsyIO2J
 4UUdukCm/+KAGQIRnF4D5i1mj66JpG8XoGvW2qRivFEt0Qh64idaY76WZU7Uq0FDzW0tLg2S4
 ZBjteVERTM4Fd/z82+oGEcFA7PFTw35dkXy78YcIhfomWRu5x/EmffWRvTrJ4kKM7zKvOHYt9
 ERaaoxB3y6uJ2JYg5/Ziy0IyK86nIpYDDKc0bCVI1ESfbx6AXU3B9J+BvZj9lnRxxGsUKBIhL
 2634crjATm/HBbK/PbbZZncIHQJAP8LFf+RC28Toq3c2qR0+wcQBNxm9Ig3Rh8HJKPZrJMybv
 GHzf7X5sX8fMo03N6Dq95qIjV1p3OAZt2UYc849SpKDI4PYpQ0W27ROVLS0gKuO3BKQK8T0Gz
 eE+n4VYozF+1dNeDbHXPSJCeHOb5w8S5ae/kN+Z/4IVgg4H8gNKXjgPTtQDE7Ku8CCp1mYKFi
 coVWP2CwmiccDYAEwdHnZ55jnHgjoyNqwk34iyjoHSZe9F8ifzazTVN0F4wu2F8ok+MNFx4Rb
 4eOeYmSrffwO1SeRIqivTz3VkRWCiBSM9ZRj6xujk4+fKaBEr7FHansyVcHZDuqQIB/z5lIEu
 ZbFL1mnur8gYmHrOzVrBPR2XNs9fBJcJvhtAyix6PyZkqaT+meINGpcfzmGwKi9QLuCBRoDd5
 pe66CVjUV9ZMf823K3Smp+1BGbfvVWEFLw6/n9nV6mD177LmPDqk7289ARDB6OO8jjOuc18h5
 mbj0jbbqkjB4Je+NjA/Djy/+pz/rHrOAbp8dZqK91n89IZc5W+Ou2JnameM06fi9gpWHBdoMM
 IpNRyilTaiKW+yjjd3XNrkQ+Rf0YEG13CEyFjPzM+7LYmQTYZCnveCOz8RsYxgu/Koexcl+mm
 HqJisA9CxuVc9xPorbfUrXxCePgRgY+ScynYOWxuK2B1BWDDeoHUL3qQQDkeiGeT2n3XONr3+
 qzg0BMW15rckiD0zKq64rRzYqsA0mFpQddLwIKAZ/HG7chFH28UTH+LG/we7C28lKkMQjpbA6
 MPDhLhs79dzmOA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/18 07:15, Qu Wenruo wrote:
>
>
> On 2022/1/18 03:39, Anthony Ruhier wrote:
>> I have some good news and bad news: the bad news is that it didn't fix
>> the autodefrag problem (I applied the 2 patches).
>>
>> The good news is that when I enable autodefrag, I can quickly see if th=
e
>> problem is still there or not.
>> It's not super obvious compared to the amount of writes that happened
>> constantly just after my upgrade to linux 5.16, because since then the
>> problem mitigated itself a bit, but it's still noticeable.
>>
>> If I compare the write average (in total, I don't have it per process)
>> when taking idle periods on the same machine:
>> =C2=A0=C2=A0=C2=A0=C2=A0 Linux 5.16:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 without autodefrag: ~ =
10KiB/s
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with autodefrag: betwe=
en 1 and 2MiB/s.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Linux 5.15:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with autodefrag:~ 10Ki=
B/s (around the same as without
>> autodefrag on 5.16)
>>
>> Feel free to ask me anything to help your debugging, just try to be
>> quite explicit about what I should do, I'm not experimented in
>> filesystems debugging.
>
> Mind to test the following diff (along with previous two patches from
> Filipe)?
>
> I screwed up, the refactor changed how the defraged bytes accounting,
> which I didn't notice that autodefrag relies on that to requeue the inod=
e.
>
> The refactor is originally to add support for subpage defrag, but it
> looks like I pushed the boundary too hard to change some behaviors.

Sorry, previous diff has a memory leakage bug.

The autodefrag code is more complex than I thought, it has extra logic
to handle defrag.

Please try this one instead.

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 11204dbbe053..096feecf2602 100644
=2D-- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -305,26 +305,7 @@ static int __btrfs_run_defrag_inode(struct
btrfs_fs_info *fs_info,
         num_defrag =3D btrfs_defrag_file(inode, NULL, &range,
defrag->transid,
                                        BTRFS_DEFRAG_BATCH);
         sb_end_write(fs_info->sb);
-       /*
-        * if we filled the whole defrag batch, there
-        * must be more work to do.  Queue this defrag
-        * again
-        */
-       if (num_defrag =3D=3D BTRFS_DEFRAG_BATCH) {
-               defrag->last_offset =3D range.start;
-               btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
-       } else if (defrag->last_offset && !defrag->cycled) {
-               /*
-                * we didn't fill our defrag batch, but
-                * we didn't start at zero.  Make sure we loop
-                * around to the start of the file.
-                */
-               defrag->last_offset =3D 0;
-               defrag->cycled =3D 1;
-               btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
-       } else {
-               kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-       }
+       kmem_cache_free(btrfs_inode_defrag_cachep, defrag);

         iput(inode);
         return 0;

>
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 11204dbbe053..c720260f9656 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -312,7 +312,9 @@ static int __btrfs_run_defrag_inode(struct
> btrfs_fs_info *fs_info,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (num_defrag =3D=3D BTRFS_=
DEFRAG_BATCH) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 defrag->last_offset =3D range.start;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /*
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (defrag->last_offs=
et && !defrag->cycled) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we didn't fill our defrag batch, but
> @@ -321,7 +323,9 @@ static int __btrfs_run_defrag_inode(struct
> btrfs_fs_info *fs_info,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 defrag->last_offset =3D 0;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 defrag->cycled =3D 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /*
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
>
>
>> Thanks
>>
>> Le 17/01/2022 =C3=A0 18:56, Filipe Manana a =C3=A9crit=C2=A0:
>>> On Mon, Jan 17, 2022 at 5:50 PM Anthony Ruhier <aruhier@mailbox.org>
>>> wrote:
>>>> Filipe,
>>>>
>>>> Just a quick update after my previous email, your patch fixed the iss=
ue
>>>> for `btrfs fi defrag`.
>>>> Thanks a lot! I closed my bug on bugzilla.
>>>>
>>>> I'll keep you in touch about the autodefrag.
>>> Please do.
>>> The 1 byte file case was very specific, so it's probably a different
>>> issue.
>>>
>>> Thanks for testing!
>>>
>>>> Le 17/01/2022 =C3=A0 18:04, Anthony Ruhier a =C3=A9crit :
>>>>> I'm going to apply your patch for the 1B file, and quickly confirm i=
f
>>>>> it works.
>>>>> Thanks a lot for your patch!
>>>>>
>>>>> About the autodefrag issue, it's going to be trickier to check that
>>>>> your patch fixes it, because for whatever reason the problem seems t=
o
>>>>> have resolved itself (or at least, btrfs-cleaner does way less write=
s)
>>>>> after a partial btrfs balance.
>>>>> I'll try and look the amount of writes after several hours. Maybe fo=
r
>>>>> this one, see with the author of the other bug. If they can easily
>>>>> reproduce the issue then it's going to be easier to check.
>>>>>
>>>>> Thanks,
>>>>> Anthony
>>>>>
>>>>> Le 17/01/2022 =C3=A0 17:52, Filipe Manana a =C3=A9crit :
>>>>>> On Mon, Jan 17, 2022 at 03:24:00PM +0100, Anthony Ruhier wrote:
>>>>>>> Thanks for the answer.
>>>>>>>
>>>>>>> I had the exact same issue as in the thread you've linked, and hav=
e
>>>>>>> some
>>>>>>> monitoring and graphs that showed that btrfs-cleaner did constant
>>>>>>> writes
>>>>>>> during 12 hours just after I upgraded to linux 5.16. Weirdly enoug=
h,
>>>>>>> the
>>>>>>> issue almost disappeared after I did a btrfs balance by filtering =
on
>>>>>>> 10%
>>>>>>> usage of data.
>>>>>>> But that's why I initially disabled autodefrag, what has lead to
>>>>>>> discovering
>>>>>>> this bug as I switched to manual defragmentation (which, in the en=
d,
>>>>>>> makes
>>>>>>> more sense anyway with my setup).
>>>>>>>
>>>>>>> I tried this patch, but sadly it doesn't help for the initial
>>>>>>> issue. I
>>>>>>> cannot say for the bug in the other thread, as the problem with
>>>>>>> btrfs-cleaner disappeared (I can still see some writes from it, bu=
t
>>>>>>> it so
>>>>>>> rare that I cannot say if it's normal or not).
>>>>>> Ok, reading better your first mail, I see there's the case of the 1
>>>>>> byte
>>>>>> file, which is possibly not the cause from the autodefrag causing t=
he
>>>>>> excessive IO problem.
>>>>>>
>>>>>> For the 1 byte file problem, I've just sent a fix:
>>>>>>
>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e2=
1bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> It's actually trivial to trigger.
>>>>>>
>>>>>> Can you check if it also fixes your problem with autodefrag?
>>>>>>
>>>>>> If not, then try the following (after applying the 1 file fix):
>>>>>>
>>>>>> https://pastebin.com/raw/EbEfk1tF
>>>>>>
>>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>>> index a5bd6926f7ff..db795e226cca 100644
>>>>>> --- a/fs/btrfs/ioctl.c
>>>>>> +++ b/fs/btrfs/ioctl.c
>>>>>> @@ -1191,6 +1191,7 @@ static int defrag_collect_targets(struct
>>>>>> btrfs_inode *inode,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 newer_than, boo=
l do_compress,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool locked, struct=
 list_head *target_list)
>>>>>> =C2=A0=C2=A0 {
>>>>>> +=C2=A0=C2=A0=C2=A0 const u32 min_thresh =3D extent_thresh / 2;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 cur =3D start;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>>>> =C2=A0=C2=A0 @@ -1198,6 +1199,7 @@ static int defrag_collect_target=
s(struct
>>>>>> btrfs_inode *inode,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct=
 extent_map *em;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct=
 defrag_target_range *new;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool n=
ext_mergeable =3D true;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 range_start;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 ra=
nge_len;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 em =3D defrag_lookup_extent(&inode->vfs_inode, cur,
>>>>>> locked);
>>>>>> @@ -1213,6 +1215,24 @@ static int defrag_collect_targets(struct
>>>>>> btrfs_inode *inode,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em=
->generation < newer_than)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto next;
>>>>>> =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Our start offse=
t might be in the middle of an existing
>>>>>> extent
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * map, so take th=
at into account.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_len =3D em->len -=
 (cur - em->start);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If there's alre=
ady a good range for delalloc within the
>>>>>> range
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * covered by the =
extent map, skip it, otherwise we can
>>>>>> end up
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * doing on the sa=
me IO range for a long time when using
>>>>>> auto
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * defrag.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_start =3D cur;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (count_range_bits(&i=
node->io_tree, &range_start,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_start + range=
_len - 1, min_thresh,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTENT_DELALLOC, 1)=
 >=3D min_thresh)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 goto next;
>>>>>> +
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
* For do_compress case, we want to compress all valid
>>>>>> file
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
* extents, thus no @extent_thresh or mergeable check.
>>>>>> @@ -1220,8 +1240,8 @@ static int defrag_collect_targets(struct
>>>>>> btrfs_inode *inode,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (do=
_compress)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto add;
>>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip to=
o large extent */
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em->len >=3D extent=
_thresh)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip large enough ra=
nges. */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (range_len >=3D exte=
nt_thresh)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto next;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 next_mergeable =3D
>>>>>> defrag_check_next_extent(&inode->vfs_inode, em,
>>>>>>
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> Anthony
>>>>>>>
>>>>>>> Le 17/01/2022 =C3=A0 13:10, Filipe Manana a =C3=A9crit :
>>>>>>>> On Sun, Jan 16, 2022 at 08:15:37PM +0100, Anthony Ruhier wrote:
>>>>>>>>> Hi,
>>>>>>>>> Since I upgraded from linux 5.15 to 5.16, `btrfs filesystem defr=
ag
>>>>>>>>> -t128K`
>>>>>>>>> hangs on small files (~1 byte) and triggers what it seems to be =
a
>>>>>>>>> loop in
>>>>>>>>> the kernel. It results in one CPU thread running being used at
>>>>>>>>> 100%. I
>>>>>>>>> cannot kill the process, and rebooting is blocked by btrfs.
>>>>>>>>> It is a copy of the
>>>>>>>>> bughttps://bugzilla.kernel.org/show_bug.cgi?id=3D215498
>>>>>>>>>
>>>>>>>>> Rebooting to linux 5.15 shows no issue. I have no issue to run a
>>>>>>>>> defrag on
>>>>>>>>> bigger files (I filter out files smaller than 3.9KB).
>>>>>>>>>
>>>>>>>>> I had a conversation on #btrfs on IRC, so here's what we debugge=
d:
>>>>>>>>>
>>>>>>>>> I can replicate the issue by copying a file impacted by this bug=
,
>>>>>>>>> by using
>>>>>>>>> `cp --reflink=3Dnever`. I attached one of the impacted files to =
this
>>>>>>>>> bug,
>>>>>>>>> named README.md.
>>>>>>>>>
>>>>>>>>> Someone told me that it could be a bug due to the inline extent.
>>>>>>>>> So we tried
>>>>>>>>> to check that.
>>>>>>>>>
>>>>>>>>> filefrag shows that the file Readme.md is 1 inline extent. I tri=
ed
>>>>>>>>> to create
>>>>>>>>> a new file with random text, of 18 bytes (slightly bigger than t=
he
>>>>>>>>> other
>>>>>>>>> file), that is also 1 inline extent. This file doesn't trigger t=
he
>>>>>>>>> bug and
>>>>>>>>> has no issue to be defragmented.
>>>>>>>>>
>>>>>>>>> I tried to mount my system with `max_inline=3D0`, created a copy=
 of
>>>>>>>>> README.md.
>>>>>>>>> `filefrag` shows me that the new file is now 1 extent, not inlin=
e.
>>>>>>>>> This new
>>>>>>>>> file also triggers the bug, so it doesn't seem to be due to the
>>>>>>>>> inline
>>>>>>>>> extent.
>>>>>>>>>
>>>>>>>>> Someone asked me to provide the output of a perf top when the
>>>>>>>>> defrag is
>>>>>>>>> stuck:
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28.70%=C2=A0 [kernel]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] generic_bin_search
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14.90%=C2=A0 [kernel]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] free_extent_buffer
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13.17%=C2=A0 [kernel]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] btrfs_search_slot
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12.63%=C2=A0 [kernel]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] btrfs_root_node
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.33%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] btrfs_get_64
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.88%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] __down_read_com=
mon.llvm
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.00%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] up_read
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.63%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] read_block_for_=
search
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.40%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] read_extent_buf=
fer
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.38%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] memset_erms
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.11%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] find_extent_buf=
fer
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.69%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] kmem_cache_free
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.69%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] memcpy_erms
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.57%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] kmem_cache_allo=
c
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.45%=C2=A0 [kernel]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] radix_tree_look=
up
>>>>>>>>>
>>>>>>>>> I can reproduce the bug on 2 different machines, running 2
>>>>>>>>> different linux
>>>>>>>>> distributions (Arch and Gentoo) with 2 different kernel configs.
>>>>>>>>> This kernel is compiled with clang, the other with GCC.
>>>>>>>>>
>>>>>>>>> Kernel version: 5.16.0
>>>>>>>>> Mount options:
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Machine 1:
>>>>>>>>> rw,noatime,compress-force=3Dzstd:2,ssd,discard=3Dasync,space_cac=
he=3Dv2,autodefrag
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Machine 2:
>>>>>>>>> rw,noatime,compress-force=3Dzstd:3,nossd,space_cache=3Dv2
>>>>>>>>>
>>>>>>>>> When the error happens, no message is shown in dmesg.
>>>>>>>> This is very likely the same issue as reported at this thread:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/linux-btrfs/YeVawBBE3r6hVhgs@debian9.Home=
/T/#ma1c8a9848c9b7e4edb471f7be184599d38e288bb
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Are you able to test the patch posted there?
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Anthony Ruhier
>>>>>>>>>
>>>>>>
>>>>>>
>>>>>>
