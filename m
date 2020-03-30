Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A090D1976BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgC3Ijk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 04:39:40 -0400
Received: from mail.halfdog.net ([37.186.9.82]:51720 "EHLO mail.halfdog.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbgC3Ijk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 04:39:40 -0400
Received: from [37.186.9.82] (helo=localhost)
        by mail.halfdog.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <me@halfdog.net>)
        id 1jIpxJ-0007R8-Pt
        for linux-btrfs@vger.kernel.org; Mon, 30 Mar 2020 08:39:38 +0000
From:   halfdog <me@halfdog.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: FIDEDUPERANGE woes may continue (or unrelated issue?)
In-reply-to: <20200326132306.GG2693@hungrycats.org>
References: <2442-1582352330.109820@YWu4.f8ka.f33u> <31deea37-053d-1c8e-0205-549238ced5ac@gmx.com> <1560-1582396254.825041@rTOD.AYhR.XHry> <13266-1585038442.846261@8932.E3YE.qSfc> <20200325035357.GU13306@hungrycats.org> <3552-1585216388.633914@1bS6.I8MI.I0Ki> <20200326132306.GG2693@hungrycats.org>
Comments: In-reply-to Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
   message dated "Thu, 26 Mar 2020 09:23:06 -0400."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date:   Mon, 30 Mar 2020 08:37:26 +0000
Message-ID: <1911-1585557446.708051@Hw65.Ct0P.Jhsr>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell writes:
> On Thu, Mar 26, 2020 at 09:53:08AM +0000, halfdog wrote:
>> Thanks for your lengthy reply!
>>
>> Zygo Blaxell writes:
>>> On Tue, Mar 24, 2020 at 08:27:22AM +0000, halfdog wrote:
>>>> Hello list,
>>>>
>>>> It seems the woes really continued ... After trashing the
>>>> old, corrupted filesystem (see old message below) I started
>>>> rebuilding the storage. Synchronization from another (still
>>>> working) storage roughly should have performed the same
>>>> actions as during initial build (minus count and time of
>>>> mounts/unmounts, transfer interrupts, ...).
>>>>
>>>> It does not seem to be a mere coincidence, that the corruption
>>>> occured when deduplicating the exact same file as last time.
>>>> While corruption last time made disk completely inaccessible,
>>>> this time it just was mounted readonly with a different
>>>> error message:
>>>>
>>>> [156603.177699] BTRFS error (device dm-1): parent transid
>>>> verify failed on 6680428544 wanted 12947 found 12945
>>>> [156603.177707] BTRFS: error (device dm-1) in
>>>> __btrfs_free_extent:3080: errno=-5 IO failure [156603.177708]
>>>> BTRFS info (device dm-1): forced readonly [156603.177711]
>>>> BTRFS: error (device dm-1) in btrfs_run_delayed_refs:2188:
>>>> errno=-5 IO failure
>>>
>>> Normally those messages mean your hardware is dropping writes
>>> somewhere; however, you previously reported running kernels
>>> 5.3.0 and 5.3.9, so there may be another explanation.
>>>
>>> Try kernel 4.19.x, 5.4.19, 5.5.3, or later.  Definitely do
>>> not use kernels from 5.1-rc1 to 5.4.13 inclusive unless backported
>>> fixes are included.
>>
>> Sorry, I forgot to update on that: I used the old kernel but
>> also managed t reproduce on ii  linux-image-5.4.0-4-amd64
>>            5.4.19-1                            amd64     
>>   Linux 5.4 for 64-bit PCs (signed) Linux version 5.4.0-4-amd64
>> (debian-kernel@lists.debian.org) (gcc version 9.2.1 20200203
>> (Debian 9.2.1-28)) #1 SMP Debian 5.4.19-1 (2020-02-13)
>>
>>> I mention 5.5.3 and 5.4.19 instead of 5.5.0 and 5.4.14 because
>>> the later ones include the EOF dedupe fix.  4.19 avoids the
>>> regressions of later kernels.
>>
>> 5.4.19-1 matches your spec, but as latest Debian experimental
>> is "linux-signed-amd64 (5.5~rc5+1~exp1)", which is also above
>> your  5.5.3 recommendation, should I try again with that kernel
>> or even use the "5.5~rc5+1~exp1" config to apply it to yesterays
>> 5.5.13 LTS and build an own kernel?
>
> I would try a mainline kernel just to make sure Debian didn't
> backport something they shouldn't have.

OK, so let's go for that... If I got you right, you mentioned
two scenarios, that might yield relevant information:

* Try a mainline kernel prior to "reloc_root" to see if the bug
  could already be reproduced with that one.
* Try a new 5.5.3 or later to see if the bug still can be reproduced.

Which of both would be or higher value to you for the first test?

Could you please share a kernel.org link to the exact tarball
that should be tested? If there is a specific kernel configuration
you deem superior for tests, that would be useful too. Otherwise
I would use one from a Debian package with a kernel version quite
close and adapt it to the given kernel.

>>>> As it seems that the bug here is somehow reproducible, I
>>>> would like to try to develop a reproducer exploit and fix
>>>> for that bug as an excercise. Unfortunately the fault occurs
>>>> only after transfering and deduplicating ~20TB of data.
>>>>
>>>> Are there any recommendations e.g. how to "bisect" that
>>>> problem?
>>>
>>> Find someone who has already done it and ask.  ;)
>>
>> Seems I found someone with good recommendations already :)
>>
>> Thank you!
>>
>>> Upgrade straight from 5.0.21 to 5.4.14 (or 5.4.19 if you
>>> want the dedupe fix too).  Don't run any kernel in between
>>> for btrfs.
>>>
>>> There was a bug introduced in 5.1-rc1, fixed in 5.4.14, which
>>> corrupts metadata.  It's a UAF bug, so its behavior can be
>>> unpredictable, but quite often the symptom is corrupted metadata
>>> or write-time tree-checker errors. Sometimes you just get
>>> a harmless NULL dereference crash, or some noise warnings.
>>>
>>> There are at least two other filesystem corrupting bugs with
>>> lifetimes overlapping that range of kernel versions; however
>>> both of those were fixed by 5.3.
>>
>> So maybe leaving my 5.4.19-1 to the 5.5+ series sounds like
>> recommended anyway?
>
> I've logged an order of magnitude more testing hours on 5.4.x
> than on 5.5.x, so I can't recommend one over the other due
> to lack of symmetrical data.
>
> I'd really like to know if you can reproduce this on 4.19 or
> 5.0.21. Those kernels predate the 5.1.x reloc_root lifespan
> change that we are still debugging to this day (in addition
> to metadata corruption, that change also seems to cause the
> recent looping balance issue and possibly other issues that
> haven't been identified yet).
>
>>>> Is there a way (switch or source code modification) to log
>>>> all internal btrfs state transitions for later analysis?
>>>
>>> There are (e.g. the dm write logger), but most bugs that
>>> would be found in unit tests by such tools have been fixed
>>> by the time a kernel is released, and they'll only tell you
>>> that btrfs did something wrong, not why.
>>
>> As IO seems sane, the error reported "verify failed on 6680428544
>> wanted 12947 found 12945" seems not to point to a data structure
>> problem at a sector/page/block boundary (12947==0x3293), I
>> would also guess, that basic IO/paging is not involved in
>> it, but that the data structure is corrupted in memory and
>> used directly or written/reread ... therefore I would deem
>> write logs also as not the first way to go ..
>
> transids are _timestamps_ not _positions_.  The message is
> saying while walking the tree, we were expecting to read a
> block that was written at time 12947 (the reference item's
> timestamp), but we found one that was written at an earlier
> time 12945 (the referred block's timestamp) instead.

Thanks for explanation. So as timestamps are close, this quite
proofs that there is no bit-wise storage hardware failure involved
as that would scramble the whole cipher-block. Also a bitwise
RAM error is unlikely, would be more likely something like
12947 vs 134230675 (0x3293 vs 0x8003293).

Still silently lost writes of whole blocks could not be ruled
out. But as metadata is small compared to data and all data was
verified after write against my external checksum database, it
would be verly unlikely, that the storage hardware loses a block
wrile belonging to the same file metadata twice while the other
approximately 536870912 blocks did not suffer any such loss.

> This check is normally used to detect firmware bugs where the
> drive said sectors were written (so we wrote the referring
> block) but the sectors were not in fact written (so the referenced
> block contains old data with a good csum and some other check
> fields).
>
> transid verify also detects split-brain raid1 failures:  drive
> A completed write 12945 but drive B did not, then later we
> read drive B and due to the transid verify check, we can know
> that drive B is wrong and copy replacement data from drive
> A to correct drive B.

Good design! But here no RAID involved ...

> You can also get transid verify from host memory corruption,
> either due to RAM failure or kernel bug.  RAM failure is not
> usually so repeatable, but a kernel bug could be.

Again, would be very weird to have it corrupt the same files
metadata twice while keeping TBs of hash-verified data intact...

>>> Also, there can be tens of thousands of btrfs state transitions
>>> per second during dedupe, so the volume of logs themselves
>>> can present data wrangling challenges.
>>
>> Yes, that's why me asking. Maybe someone has already taken
>> up that challenge as such a tool-chain (generic transaction
>> logging with userspace stream compression, analysis) might
>> be quite handy for such task, but hell effort to build ...
>>
>>> The more invasively you try to track internal btrfs state,
>>> the more the tools become _part_ of that state, and introduce
>>> additional problems. e.g. there is the ref verifier, and
>>> the _bug fix history_ of the ref verifier...
>>
>> That is right. Therefore I hoped, that some minimal invasive
>> toolsets might be available already for kernel or maybe could
>> be written, e.g.
>>
>> * Install an alternative kernel page fault handler * Set
>> breakpoints on btrfs functions * When entering the function,
>> record return address, stack and register arguments, send
>> to userspace * Strip write bits kernel from page table for
>> most pages exept those needed by page fault handler * Continue
>> execution * For each pagefault, the pagefault flips back to
>> original page table, sends information about write fault (what,
>> where) to userspace, performs the faulted instruction before
>> switching back to read-only page table and continuing btrfs
>> function * When returning from the last btrfs function, also
>> switch back to standard page table.
>>
>> By being completely btrfs-agnostic, such tool should not introduce
>> any btrfs-specific issues due to the analysis process. Does
>> someone know about such a tool or a simplified version of
>> it?
>>
>> Doing similar over qemu/kernel debugging tools might be easier
>> to implement but too slow to handle that huge amount of data.
>>
>>>> Other ideas for debugging that?
>>>
>>> Run dedupe on a test machine with a few TB test corpus (or
>>> whatever your workload is) on a debug-enabled kernel, report
>>> every bug that kills the box or hurts the data, update the
>>> kernel to get fixes for the bugs that were reported.  Repeat
>>> until the box stops crapping itself, then use the kernel
>>> it stopped on (5.4.14 in this case).  Do that for every kernel
>>> upgrade because regressions are a thing.
>>
>> Well, that seems like overkill. My btrfs is not haunted by
>> a load of bugs, just one that corrupted the filesystem two
>> times when trying to deduplicate the same set of files.
>>
>> As desccribed, just creating a btrfs with only that file did
>> not trigger the corruption. If this is not a super-rare
>> coincidence, then something in the other 20TB of transferred
>> files has to have corrupted the file system or at least brought
>> it to a state, where then deduplication of exact that problematic
>> set of files triggered the final fault.
>
> The above is a description of my standard test setup, which
> in turn is a more compact version of production workloads.
>  I haven't seen a 5.4.x filesystem splat since 5.4.14, but
> OTOH that's only 2 months.
>
> You could be finding something new here, but we have to make
> sure there's nothing wrong with your test setup.  Running a
> test with an older kernel would help with that.

So I account that as a 2:1 vote for testing an older kernel instead
of a new one ...

>>>> Just creating the same number of snapshots and putting just
>>>> that single file into each of them did not trigger the bug
>>>> during deduplication.
>>>
>>> Dedupe itself is fine, but some of the supporting ioctls
>>> a deduper has to use to get information about the filesystem
>>> structure triggered a lot of bugs.
>>
>> To get rid of that, I already ripped out quite some of the
>> userspace deduping part. I now do the extent queries in a
>> Python tool using ctypes, split the dedup request into smaller
>> chunks (to improve logging granularity) and just use the deduper
>> to do that single FIDEDUPERANGE call (I was to lazy to ctype
>> that in Python too).
>>
>> Still deduplicating the same files caused corruption again.
>>
>> hd
>>
>>> ...

