Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C27407450
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Sep 2021 03:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhIKBHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 21:07:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:47357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234989AbhIKBHJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 21:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631322355;
        bh=6LyJP+ATekVIXE0UmR/3qGMukJ/WkD28SCg/TYYYA0o=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=CsaKncJEBIJPvzsUm7JULivJYrznPXahtNwWZ1m38AGq9Pd3clJgczBPBSMoSzKOA
         iGMteN691g1BAgkfhBMCTAtbZfRjJfHsFvfdyIazN4xNxOq+Yogg00C/lGrag0XnJd
         q50hDUbOB5/DMRCvAHRL86qxiRQ2bypGZXogvFEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MoO6M-1mirCE1dwO-00oq6z; Sat, 11
 Sep 2021 03:05:55 +0200
To:     Sam Edwards <cfsworks@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
 <aed0ec2b-3fe0-3574-b7e5-24f2e3da27ce@gmx.com>
 <CAH5Ym4gd7UhT=cSAjb-zMQ3baU08+SzKnGmXmAVD_8FdhzqF9w@mail.gmail.com>
 <c9c46006-32d3-7de7-bd0b-ff7380c684e6@gmx.com>
 <CAH5Ym4gZgGLuL8svHLmOaqACLfQJpXCGLmfP3bK0NCic9E_LdQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
Message-ID: <1c042ec5-c3f1-bb57-6f90-1a209aa60579@gmx.com>
Date:   Sat, 11 Sep 2021 09:05:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAH5Ym4gZgGLuL8svHLmOaqACLfQJpXCGLmfP3bK0NCic9E_LdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R7wxsYnfm5zYDKfym49VC/3T3ojDxWLx989zBjsIRRqJM45Tntz
 y19RImYSNKUclTYoPyRw2qhTlnW6GpZvdSCwu0GypQk/JQsiCfQ932T9UKYHtbK+UivHPGt
 S8Ba4qGnkguPHRpg+fodHTqZcEeqhaND5lLIqomKPAxhEEneDktVd8ulFjgvRnqQe9uiZPZ
 0SLJu/ISPkQdfl9NGJarA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a4c3lzja45g=:TGSMRjJPJPAXPH/EYZrLzg
 xUqrSkshm+CrIonmltgLplsYe1QPpdz1FElFq5q5I0I3No3PX4+h0I46FqTEPOeWDfTA+jiEO
 y4VPgRW9QoqUquzc1OVaVmA9OMhwvHTUnlr5ghVRj+fE0QXvYLiZO/73AOnZJADSliDx8Hqti
 tNQlN/+o+uh/vpjLRNNecA1idR5ncGuBYVnr01poc5K02jA0nxjDDYp7WIpWJEwiol4DLCAUt
 ye05n8e7Na6THD9LxLvJPzd9yjdpspPKf88Z/Ei/0uSLAVyJu73x31WaoVaVM7SwKfqtQ0uvh
 mDp8nrIEce1hUwNoonmU/x1iwhb4OqtrQU4X7rVXa0kJcDd20VnUWxIF8CxCqtkNpaEWlxmB7
 fpAXJ0vwkJb/m8yUjDPtN3aR/dARPs1X0md0nvfaCYNzd5woRE5KB8pdqKzRdoeGGvQ0iVzJZ
 6BsEE7Ki4aqFwHYB9xYJ+HB34sQijGtwqjwobB66gAwCFKXe5h3fmOd2TGe8l6OhMGirFBJLE
 JShONfsppbvTAw1op/FXPAg/PVfYJviXvtKjCqDmkaL91fCzuqyYKj1973HSs7d0+xyHDZC3J
 Cj8QyLWZ+nG722VGc5NZqvP8O024skifR66advLIILdoxKQrTcHr8hJyvia9tpCi0zdaKixcS
 TJfOQyMsWmz/qCt4mZAJ5qWqqCuJX5lpGQ1QBB8zHrxb8EdzsNgzwVPHzmKLJCIodLEWf1Ry3
 2K6bUL8H68wkwZMWiIqNJdjqEEo67c7k5lu0eIWSFZ68mqz5sthiLxV/HVK/c6ffG2Xl4K0Rx
 fv2uT3DdG1pFYB42Uk7lYPThoVo2mKrnRZKvPiY7L3WLQAyz+BTwEN9QDGEKVEDrhV7uR0Wl6
 v/iJC725DKVORnPA0OeS5W0TXbGkjLUUODWKjSJktG1mQcOd3izXgJHr0ULhex9pj9Yl3psQM
 lRKXt9XJ6onoyR8oDf3Y8CWbvUsFMbW47MTqpuxkOeGCl/fXZ1CyDD8VfnQD9YpZEuaQRbw4O
 gO0CiN0sTb/toOH1nKY0qvFP0g+pK/jyICQ7C0afP5M8RMdgVu+CPYWAUFuH0pT5DD2sm877n
 z9eg3qBPmKKie0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/11 =E4=B8=8A=E5=8D=886:34, Sam Edwards wrote:
> On Fri, Sep 10, 2021 at 2:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>> If you have hit read-only problem, then it's definitely btrfs' problem,
>> and we're very interesting to see what's the cause.
>
> I'm in full agreement that RO is a sign of a malfunction; but I was
> saying that the malfunction may be deeper in the stack, meaning the RO
> is not necessarily due to a design/implementation error in btrfs, but
> is rather the only sensible course of action when faced with certain
> circumstances outside of its control.
>
>> Checksum error doesn't sound correct. Can be another indication of
>> missing writes.
>>
>> But this also means, the corruption is even older.
>
> Here is the checksum error (the very first indication of something
> amiss on the day in question):
> BTRFS warning (device dm-0): checksum verify failed on 1065332064256
> wanted 0x04ca393a found 0xd5f0b823 level 0
> BTRFS error (device dm-0): parent transid verify failed on
> 1065332064256 wanted 66552 found 66543

This is something more weird.

Firstly, this message is for the same block, then it means, the first
copy is not correct, but it's not completely garbage.

If it's completely garbage, its logical bytenr would not match (btrfs
checks the very basic things like logical bytenr/fsid, then check the csum=
).

Thus it looks like either the data is not correct, or the bytenr check
just passes by pure coincident (which I don't believe, as it also passed
fsid check).

Then the 2nd copy passed all other checks, but transid.

This looks very weird.
If it's btrfs causing the problem, both copy should have the same
problem, not just one copy with csum mismatch, another with transid
mismatch.

>
> Since it's coupled directly with a transid mismatch, I think this just
> means the csum tree is current while the node is not.

For metadata, the csum is inlined into the header, not in csum tree.
Csum tree is only for data.
Thus it's not possible for csum to mismatch with its data.

> That is,
> 0x04ca393a is the correct checksum for generation 66552 of leaf
> 1065332064256, but that generation has gone missing and instead we
> find generation 66543, which has checksum 0xd5f0b823.

Nope, the csum is inside the tree block (along with its bytenr and fsid).
It looks more like the latter part of the tree block mirror 1 got
overwritten or corrupted.

>
>> As long as you don't do forced shutdown, nor btrfs check --repair, the
>> v1 cache should not mismatch.
>
> I have never even heard of btrfs check --repair until this incident (a
> testament to btrfs's general durability).
>
> I checked and both shutdowns immediately before the "has wrong amount
> of free space" warnings were clean. On the 10th, there was an unclean
> shutdown a little earlier in the day - there may have been some
> leftover issues from that.

I guess all the problems happens at that unclean shutdown.

>
>> This is too crazy that I can't even imagine what could survive.
>>
>> [...]
>>
>> But to me, this is really too crazy...
>
> It is a contrived idea, yes. :)
>
> But the subject it explores is relevant: how btrfs would react to a
> slice of an active partition spontaneously reverting to the data it
> held several minutes prior.

That means the disks are not respecting FLUSH.

Flush commands mean, the disk should only return after all the data in
volatile cache has been written to disk or non-volatile cache.

If the disks (including dm-layer) just return without really writing
back all the data to non-volatile storage, then a power loss happens,
that's exactly what the transid mismatch would happen.

>
> That is, a "missing writes" problem where the writes don't go missing
> until a few minutes *after* they succeed.
>
>> The final protection is the logical bytenr, where btrfs can map its
>> chunks at any logical bytenr, thus even at the same physical location,
>> they can have different logical bytenr.
>
> THIS is an interesting lead. Until this point I had been interpreting
> bytenr as a physical partition offset. Now that I've learned about the
> chunk tree, I found that all missing writes were to chunk
> 1065173909504.

That can be caused by the fact that all the newer metadata writes were
just allocated inside chunk 1065173909504.


>
> That chunk has a physical offset of 999675658240. So, there is exactly
> a 61 GiB difference between bytenr and partition offset. (This seems
> to be true of the neighboring chunks as well, and as that's a nice
> round number, I think this is the correct offset.) >
> However, if the physical offset were to change momentarily (i.e. for a
> few minutes), then writes to that chunk would end up diverted to some
> other location on disk. Once the physical offset changes back, the
> chunk will appear to revert back to the same data it held a few
> minutes prior. In effect, causing the "retroactive missing writes"
> phenomenon I'm seeing.

I don't think there is anything related to sudden physical offset
change, or kernel will report things like "bad tree block start, want
%llu have %llu".

Thus I still think there are something between btrfs and the disks, that
causes FLUSH commands to be incorrectly executed.

Thanks,
Qu

>
> This would also leave behind evidence, in that the missing writes
> would have to have gone *somewhere* on disk, and as long as they
> weren't overwritten, I can track them down by scanning the whole disk
> for tree nodes with the proper bytenr/transid. I think I'll spend some
> time today trying to do that, as that would confirm this idea.
>
> The only remaining question is why the physical offset would have
> changed for only a few minutes. I didn't do a rebalance, although I
> think I was running low on available space around the time, so maybe
> btrfs was making some last-minute adjustments to the chunk tree to
> compensate for that? The transid of the chunk tree node describing
> this chunk is 58325, which is well before the problems started
> happening. Perhaps the chunk tree was updated in-memory, used for
> physical writes, but then reverted? Does this sound like something
> btrfs might do?
>
> Or maybe a cosmic ray flipped a bit in the in-memory copy of the
> physical offset of the chunk. Unlikely, but possible. :)
>
>> I'd say, there is no way to repair.
>> Only data salvage is possible for generic transid mismatch.
>
> Bah. Well, not a problem -- but that will take me a fair amount of
> time. I'll want to investigate this and figure out what went wrong
> *before* I go through the trouble of recreating my filesystem. I don't
> want to spend a day restoring backups only to have the same problem
> happen again a week later.
>
>>>
>>> Or is the whole a sudden power loss, nor do any btrfs check --repair b=
etween, the "wrong amount of free space" warning is already an indicator o=
f something FUBAR at this point and I should just zero the
>>> partition and restore from backups?
>>
>> I guess so.
>>
>> The repair for transid is never ensured to be safe, as core btrfs
>> mechanism is already broken.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thank you for your time,
>>> Sam
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Cheers,
>>>>> Sam
>>>>>
>>>>>
>>>>> On Wed, Sep 8, 2021 at 6:47 PM Sam Edwards <cfsworks@gmail.com> wrot=
e:
>>>>>>
>>>>>> Hello list,
>>>>>>
>>>>>> First, I should say that there's no urgency here on my part.
>>>>>> Everything important is very well backed up, and even the
>>>>>> "unimportant" files (various configs) seem readable. I imaged the
>>>>>> partition without even attempting a repair. Normally, my inclinatio=
n
>>>>>> would be to shrug this off and recreate the filesystem.
>>>>>>
>>>>>> However, I'd like to help investigate the root cause, because:
>>>>>> 1. This happened suspiciously soon (see my timeline in the link bel=
ow)
>>>>>> after upgrading to kernel 5.14.1, so may be a serious regression.
>>>>>> 2. The filesystem was created less than 5 weeks ago, so the possibl=
e
>>>>>> causes are relatively few.
>>>>>> 3. My last successful btrfs scrub was just before upgrading to 5.14=
.1,
>>>>>> hopefully narrowing possible root causes even more.
>>>>>> 4. I have imaged the partition and am thus willing to attempt risky
>>>>>> experimental repairs. (Mostly for the sake of reporting if they wor=
k.)
>>>>>>
>>>>>> Disk setup: NVMe SSD, GPT partition, dm-crypt, btrfs as root fs (no=
 LVM)
>>>>>> OS: Gentoo
>>>>>> Earliest kernel ever used: 5.10.52-gentoo
>>>>>> First kernel version used for "real" usage: 5.13.8
>>>>>> Relevant information: See my Gist,
>>>>>> https://gist.github.com/CFSworks/650280371fc266b2712d02aa2f4c24e8
>>>>>> Misc. notes: I have run "fstrim /" on occasion, but don't have
>>>>>> discards enabled automatically. I doubt TRIM is the culprit, but I
>>>>>> can't rule it out.
>>>>>>
>>>>>> My primary hypothesis is that there's some write bug in Linux 5.14.=
1.
>>>>>> I installed some package updates right before btrfs detected the
>>>>>> problem, and most of the files in the `btrfs check` output look lik=
e
>>>>>> they were created as part of those updates.
>>>>>>
>>>>>> My secondary hypothesis is that creating and/or using the swapfile
>>>>>> caused some kind of silent corruption that didn't become a detectab=
le
>>>>>> issue until several further writes later.
>>>>>>
>>>>>> Let me know if there's anything else I should try/provide!
>>>>>>
>>>>>> Regards,
>>>>>> Sam
>
