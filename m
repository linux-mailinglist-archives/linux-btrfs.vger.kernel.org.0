Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124FD406884
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhIJIdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 04:33:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:42315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231502AbhIJIdF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 04:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631262713;
        bh=eflDe3QyLunncDKpEt/h2BBCvTPiQWwTxhklwhWTfTo=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=RGAL84rP3wNuUvW+5bNggkUMYFUvwZpPFqg9PdA9u947QC7cN1uJSgAFPLDIRKaog
         N/iVBKgIVsgi2/8SSo+CYG6GYrFRoe5WyWf1Rt90ZxNT09Nthfg2K1lvFo1qDo/hN0
         HdzdGXwV+vXEmw4oxhzKDoyyEuSJgRPegDN40XFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS9C-1mmRAQ3Ele-00kz1B; Fri, 10
 Sep 2021 10:31:53 +0200
To:     Sam Edwards <cfsworks@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
 <aed0ec2b-3fe0-3574-b7e5-24f2e3da27ce@gmx.com>
 <CAH5Ym4gd7UhT=cSAjb-zMQ3baU08+SzKnGmXmAVD_8FdhzqF9w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
Message-ID: <c9c46006-32d3-7de7-bd0b-ff7380c684e6@gmx.com>
Date:   Fri, 10 Sep 2021 16:31:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAH5Ym4gd7UhT=cSAjb-zMQ3baU08+SzKnGmXmAVD_8FdhzqF9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xQA9VA+jkUHG3adTpWfWbhInyJSdfkSd79PoMKtdGms2H6JrZtx
 EnCDjfKEoFATtVv/qK8m/bg7g7Q+urOdo9FlqmN/O49My9P4npVV+D2ytN1awC95iqI5je2
 BXiob0+Ux33SXV+trVysZMb4XVy1IxWWdwoBW5JoagBM0nrBRTmgWpU83UVKIOUG0eoFBs0
 xgYS9v1XZKKfOSSakOusQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ax5uWoaA4mc=:kW2s6eIiAMC9zlyTNJB6Wn
 CmuwdoNmt+JIbMG4gXl9X4MLh0nnjlXR0wVODnjUZeATpu86FHv8mTE5NBjv/JQz+rLtS4Dd8
 Rg4pHbp9vYWu2JH+0SN6Ko4v5rjbqVbrQBYVBZ1JdkTzbiKtlqEFBuQ5MdMeKirs6vPmk7QXY
 Kww9un4NPsz43l2xIKfWRY+gmnmNBzpDxJ1NdyrdKglHCxVOWNn5p3k8zTf78zVdH63xpApe3
 lzxweXYPWOaMubCkhdych4psfcs4Xvh6dJ1HHCWk9qYRrH1R7+AjFmXKKS0rl0oWdS/U9fIMl
 EaoQPulzcEdBOXKkM0ZwqLnjEv2j4ufwPIjaY+cr2D9QO/RDr+8Hj21K8+VjW1UmPFYocIhyo
 VjPS8R/fYQLrYQIBsBQyIi4rTaRpREBW22R1ZNleZCFAC3fTnpCzGmtsp77SCUkNaoE1oHsHx
 51Hgw7YI7PIuqz/BPkcu62LQGcKjwodAeA0uTYicJ203CydCXjKW7L8oP65QOjosPcxaSP+RB
 a2NNp6Pl98lAafW9r1oWULAqM6uctuye93mwUfSTZZ8wmA9n+rsjMD1cZ9bqMNOUQYYYhZony
 8SNftm6vvin0VKvI+quxRzjNT1g7dEhsWw2x2Wo8y8PWe7DC2UUvcfCQHWJgrHR63boUDW58d
 l/qdQNobE4KMDcdN9IBMisZoZkbRLdHBB0x1XZwtkFkNvRwZ3aFfL3/u8yrfKMRoFZTm2AU2L
 xfpp5Lqs01VKiHGhZEvaN/V9Wic9M6kqVRC2t5var8kRsvmErllSWBEIPZ3vju6s3RCp5Dqof
 KRC4lqGftEn/PPyTnVX7HMcWvwsfCJpQGuYnqm5Z+IA3vD8Z/gfFQ4En3Aqtyrs1pnsqLiUPZ
 kEINhlUWzOVFjAamTzUceN7eZr8jsnatTUoU0HbjbBICjqCjaaWIlR6O7kPUTjE357M3H9HVe
 JKoMxtE9LTnNF9xXiZ1tf4OGk7Nz6LSg+AF6PTNLfC0A97/7buxusQNKtqr5CVEhq3SgPIbqM
 FaviI8Mb8IpeV5q+YnGgur6DoUAm8ww0S5cYAhsUHrzjlN/m+RzlCP/HYFt74gA97Wj+xgP15
 JbmhKyddtsCNIQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/10 =E4=B8=8B=E5=8D=883:44, Sam Edwards wrote:
> Hi Qu,
>
> Thank you very much for your insight. It is also helpful to know that
> I appear to be understanding the btrfs internals properly. :)
>
> On Fri, Sep 10, 2021 at 12:17 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> But for SSD/HDD, we're more cautious about any transid error.
>>
>> There are already known bad disks which don't follow FLUSH requests,
>> thus leads to super easy transid mismatch on powerloss:
>>
>> https://btrfs.wiki.kernel.org/index.php/Hardware_bugs
>
> I strongly believe now that the SSD hardware/firmware is not the
> issue. Not only was the last "power loss"-type event on the 5th (which
> appears to have caused no damage), the issue appeared while the system
> was running -- a SSD firmware problem of that magnitude should have
> been apparent long before I upgraded to 5.14.1.
>
>>> So, question: does the btrfs module use 256 MiB as a default size for
>>> write-back cache pages anywhere?
>>
>> No.
>>
>>> Or might this problem reside deeper
>>> in the block storage system?
>>
>> So if possible, please test without dm-crypto to make sure it's really
>> btrfs causing the problem.
>
> Since you don't find the 256 MiB size evocative of any component of
> btrfs, I am also willing to say that this likely isn't a fault in
> btrfs.

If you have hit read-only problem, then it's definitely btrfs' problem,
and we're very interesting to see what's the cause.

> So, I think this is now an exercise in ruling out btrfs
> completely (before I move on to investigating devicemapper, the crypto
> target, the NVMe driver, and the block storage system as a whole) and
> further studying the filesystem to gain insight as to how this
> happened.
>
>>> Also, for what it's worth: the last generation to be written before
>>> these inconsistencies seems to be 66303. Files written as part of that
>>> transaction have a birth date of Sep. 7. That's during the same boot
>>> as the failure to read-only,
>>
>> That's interesting.
>>
>> Btrfs aborts transaction when it hits critical metadata problems to
>> prevent further damage, but I still remember some possible corruption
>> caused by aborting transaction in the old days.
>> But those corruptions should not exist in v5.14.
>
> I understand "aborts" to mean, "if btrfs is in the middle of a write
> transaction, and in the process discovers existing metadata corruption
> (e.g. tree node generation mismatch) already on-disk, it will undo any
> earlier modifications already written to disk as part of that
> transaction"

Btrfs doesn't need to undo anything, just don't writeback the super block.

As metadata is protected by COW, it means the old metadata from previous
transaction is not touched at all.

As long as the super block points to old metadata, everything is safe
and just old metadata.

The already written metadata is not referred by any old metadata, thus
it appears just nothing happened.


But all these means, btrfs needs a completely correct view of which part
of space is free.
Thus if by somehow, such view is not correct, it means metadata is not
protected, and can be overwritten and screwed by powerloss.

But in that case, the found transid should be larger than expected, not
smaller you reported.

Smaller transid normally means missing writes.

> -- is this correct? If so, I don't believe there was any
> existing metadata corruption on the disk beforehand, so I doubt the
> abort mechanism is at fault here.

Normally abort itself is an indicator of something wrong already.

>
>> Furthermore, the read-only flips itself is more important, do you have
>> the dmesg of that incident?
>
> Sadly, I wasn't able to save the dmesg (for obvious reasons), but I do
> recall logs complaining of checksum failures and transid mismatches.

Checksum error doesn't sound correct. Can be another indication of
missing writes.

But this also means, the corruption is even older.

> I
> did make note of the block bytenrs, which were in the interval
> [1065332047872, 1065391243264] which itself appears to be part of the
> same 256 MiB "slice" as I found before.
>
>> Recently we also see some corrupted free space cache causing problems.
>
> I infer "problems" to mean, "free space cache indicates block X is
> free though it is not, so btrfs allocates a new tree node or extent at
> that location, overwriting necessary data"?

Exactly.

>
> If so, I don't think this is the case here either. If an older node is
> overwritten with a newer one, I would expect the transid mismatches to
> be that the found IDs are *greater* than the wanted IDs. I am finding
> valid, but *older*, tree nodes in the affected region. This seems like
> a "lost writes" kind of problem to me, not overwrites.

You're right, I also forgot the transid is smaller than expected...

>
> However I did note some free space cache errors in my timeline.txt
> file over on the Github Gist. If you believe that this is still a
> likelihood, I can investigate further.

Now v1 cache is not the direct cause the missing writes, but it may
still be something.

As long as you don't do forced shutdown, nor btrfs check --repair, the
v1 cache should not mismatch.

>
>> If you're going to re-test this, mind to use space cache v2 to do the
>> tests?
>>
>>> which suggests that the cached buffer
>>> wasn't merely "not saved before a previous shutdown" but rather
>>> "discarded without being written back." Thoughts?
>>
>> This should not be a thing for btrfs.
>>
>> Btrfs COW protects its metadata, as long as there is no problem in btrf=
s
>> itself allocating new tree blocks to ex you're reporting some RO
>> incidents, then I guess the COW mechanism may be broken at that time
>> alreadyisting blocks in the same transaction, we're completely safe.
>
> Again, making sure I understand you correctly: Btrfs, by design,
> *never* modifies an active tree node/leaf. It will instead copy the
> node/leaf it wishes to modify into memory, perform the modifications
> there, save the modified copy at a free location on disk, and then
> recursively modify parents (using the same process) all the way back
> to the superblock(s).

Yes.

>
> And so, if power is lost in the middle of this process (i.e. before
> the superblock is updated), then the old paths down the trees are
> intact. The transaction is lost, but existing metadata is protected.
> Correct?

Yes.

>
>> But considering you're reporting some RO incidents, then I guess the CO=
W
>> mechanism may be broken at that time already.
>> (Maybe abort leads to some corrupted free space cache?)
>
> Hypothetically, suppose one were to try this experiment:
> 1. Set up a brand-new machine, which has 2 independent but equally-sized=
 disks.
> 2. On disk A, create a btrfs and mount it. Use it as a normal rootfs
> for a while, and then unmount it.
> 3. Image disk A to disk B (perhaps obfuscating the image so that it
> doesn't confuse btrfs's RAID logic).
> 4. Remount disk A and begin using it heavily (reads and writes). At a
> random moment, instantly copy a 256 MiB slice from disk B onto disk A,
> choosing an offset that has recently been written on disk A, while
> disk A is still mounted.

This is too crazy that I can't even imagine what could survive.

But if you mean disk B contains the exactly data of disk A, and there is
no balance executed on either disk, then the copied metadata is
completely valid to btrfs.

Btrfs has fsid to distinguish different fs, in your idea experiment,
it's the same, so no way to distinguish them. So is the checksum.

The final protection is the logical bytenr, where btrfs can map its
chunks at any logical bytenr, thus even at the same physical location,
they can have different logical bytenr.

But if no balance executed, the chunk mapping is still the same, thus we
can't use logical bytenr to distinguish the metadata.

But to me, this is really too crazy...

>
> Would this cause csum failures, transid mismatches, a RO incident, and
> the general output from "btrfs check" that I posted?

It won't cause csum failure.
Transid mismatch is possible.
RO incident is almost for sure.

>
> If so, I think the problem is that a write-back cache, somewhere
> deeper in the block storage stack (i.e. not btrfs) simply...
> *discarded* a contiguous 256 MiB worth of data that btrfs thought had
> been successfully written, and the RO incident was due to btrfs
> suddenly seeing old data resurface. Does this seem like the best
> working hypothesis currently?

But isn't there only dm-crypto (LUKS) between btrfs and the hardware?

If it's LUKS, I guess it's possible to cause missing writes.

BTW, if you have never hit a sudden power loss, nor do any btrfs check
=2D-repair between, the "wrong amount of free space" warning at Aug 10 is
already an indicator of something went wrong.

>
> Also: Per your expert opinion, what would be the best way to repair
> disk A (without the benefit of disk B, heh) in the experiment above? I
> imagine the affected slice itself is not salvageable, and will have to
> be forcibly marked as free space, and in the process throwing out any
> references to tree nodes that happened to reside there, meaning I'll
> lose a whole bunch of extents, inodes, csum tree entries, and so on...
> and in turn I'd a sudden power loss, nor do any btrfs check --repair bet=
ween, the "wrong amount of free space" warning is already an indicator of =
somelose a random assortment of files. I'm actually okay
> with that, because I can diff the surviving files against my last
> backup and restore whatever was deleted.

I'd say, there is no way to repair.
Only data salvage is possible for generic transid mismatch.

>
> Or is the whole a sudden power loss, nor do any btrfs check --repair bet=
ween, the "wrong amount of free space" warning is already an indicator of =
something FUBAR at this point and I should just zero the
> partition and restore from backups?

I guess so.

The repair for transid is never ensured to be safe, as core btrfs
mechanism is already broken.

Thanks,
Qu

>
> Thank you for your time,
> Sam
>
>> Thanks,
>> Qu
>>
>>>
>>> Cheers,
>>> Sam
>>>
>>>
>>> On Wed, Sep 8, 2021 at 6:47 PM Sam Edwards <cfsworks@gmail.com> wrote:
>>>>
>>>> Hello list,
>>>>
>>>> First, I should say that there's no urgency here on my part.
>>>> Everything important is very well backed up, and even the
>>>> "unimportant" files (various configs) seem readable. I imaged the
>>>> partition without even attempting a repair. Normally, my inclination
>>>> would be to shrug this off and recreate the filesystem.
>>>>
>>>> However, I'd like to help investigate the root cause, because:
>>>> 1. This happened suspiciously soon (see my timeline in the link below=
)
>>>> after upgrading to kernel 5.14.1, so may be a serious regression.
>>>> 2. The filesystem was created less than 5 weeks ago, so the possible
>>>> causes are relatively few.
>>>> 3. My last successful btrfs scrub was just before upgrading to 5.14.1=
,
>>>> hopefully narrowing possible root causes even more.
>>>> 4. I have imaged the partition and am thus willing to attempt risky
>>>> experimental repairs. (Mostly for the sake of reporting if they work.=
)
>>>>
>>>> Disk setup: NVMe SSD, GPT partition, dm-crypt, btrfs as root fs (no L=
VM)
>>>> OS: Gentoo
>>>> Earliest kernel ever used: 5.10.52-gentoo
>>>> First kernel version used for "real" usage: 5.13.8
>>>> Relevant information: See my Gist,
>>>> https://gist.github.com/CFSworks/650280371fc266b2712d02aa2f4c24e8
>>>> Misc. notes: I have run "fstrim /" on occasion, but don't have
>>>> discards enabled automatically. I doubt TRIM is the culprit, but I
>>>> can't rule it out.
>>>>
>>>> My primary hypothesis is that there's some write bug in Linux 5.14.1.
>>>> I installed some package updates right before btrfs detected the
>>>> problem, and most of the files in the `btrfs check` output look like
>>>> they were created as part of those updates.
>>>>
>>>> My secondary hypothesis is that creating and/or using the swapfile
>>>> caused some kind of silent corruption that didn't become a detectable
>>>> issue until several further writes later.
>>>>
>>>> Let me know if there's anything else I should try/provide!
>>>>
>>>> Regards,
>>>> Sam
