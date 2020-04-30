Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8CD1BEF6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 06:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgD3Evg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 30 Apr 2020 00:51:36 -0400
Received: from mail.halfdog.net ([37.186.9.82]:65071 "EHLO mail.halfdog.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3Evg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 00:51:36 -0400
Received: from [37.186.9.82] (helo=localhost)
        by mail.halfdog.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <me@halfdog.net>)
        id 1jU1Ad-0001TR-0k
        for linux-btrfs@vger.kernel.org; Thu, 30 Apr 2020 04:51:35 +0000
From:   halfdog <me@halfdog.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: FIDEDUPERANGE woes may continue (or unrelated issue?)
In-reply-to: <20200401233109.GF13306@hungrycats.org>
References: <2442-1582352330.109820@YWu4.f8ka.f33u> <31deea37-053d-1c8e-0205-549238ced5ac@gmx.com> <1560-1582396254.825041@rTOD.AYhR.XHry> <13266-1585038442.846261@8932.E3YE.qSfc> <20200325035357.GU13306@hungrycats.org> <3552-1585216388.633914@1bS6.I8MI.I0Ki> <20200326132306.GG2693@hungrycats.org> <1911-1585557446.708051@Hw65.Ct0P.Jhsr> <3800-1585642410.029742@bHdF.V1R4.bmTu> <20200401233109.GF13306@hungrycats.org>
Comments: In-reply-to Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
   message dated "Wed, 01 Apr 2020 19:31:09 -0400."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date:   Thu, 30 Apr 2020 04:49:38 +0000
Message-ID: <931-1588222178.700169@TiJM.Dd4o.D3m->
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell writes:
> On Tue, Mar 31, 2020 at 08:13:30AM +0000, halfdog wrote:
>> halfdog writes:
>>> Zygo Blaxell writes:
>>>> ... I would try a mainline kernel just to make sure Debian
>>>> didn't backport something they shouldn't have.
>>>
>>> OK, so let's go for that... If I got you right, you mentioned
>>> two scenarios, that might yield relevant information:
>>>
>>> * Try a mainline kernel prior to "reloc_root" to see if the
>>> bug could already be reproduced with that one. * Try a new
>>> 5.5.3 or later to see if the bug still can be reproduced.
>>>
>>> Which of both would be or higher value to you for the first
>>> test?
>>>
>>> Could you please share a kernel.org link to the exact tarball
>>> that should be tested? If there is a specific kernel configuration
>>> you deem superior for tests, that would be useful too. Otherwise
>>> I would use one from a Debian package with a kernel version
>>> quite close and adapt it to the given kernel.
>>
>> Yesterday I started preparing test infrastructure and to see
>> if my old test documentation still works with current software.
>> I ran a modified trinity test on a 128MB btrfs loop mount.
>> The test started at 12:02, at 14:30 trinity was OOM killed.
>> As I did not monitor the virtual machine, over the next hours
>> without trinity running any more also other processes were
>> killed one after another until at 21:13 finally also init
>> was killed.
>>
>> As I run similar tests for many days on ext4 filesystems,
>> could this be related to a btrfs memory leak even leaking
>> just due to the btrfs kernel workers?
>
> How big is the test VM?  I run btrfs on machines as small as
> 512M, but no smaller--and I don't try to do memory-hungry things
> like dedupe or balance on such machines.  Some kernel debug
> options use a lot of memory too, or break it up into pieces
> too small to use (e.g. KASAN and the btrfs ref verifier).

Sorry, I failed to run more VM test since my last mail. My VM
is also 512MB...

>> If so, when compiling a test kernel, is there any option you
>> recommend setting to verify/rule out/ pin-point btrfs leakage
>> with trinity?
>
> There is kmemleak.

I will try to run/analyze this, when there is more time, as I
assume to be quite slow due to being unexperienced.

> You can also run 'slabtop' and just watch the numbers grow.
> 'slabtop' usually names the thing that is leaking.
>
> If the thing you've got too much of is btrfs_delayed_ref_head,
> you should definitely go back to 4.19 for now.
>
>>> ...
>>

What I had time for (as all the steps were scripted already from
previous testing) was to rerun the deduplication tests after Debian
released a new kernel:

Linux version 5.5.0-1-amd64 (debian-kernel@lists.debian.org) (gcc version 9.3.0 (Debian 9.3.0-8)) #1 SMP Debian 5.5.13-2 (2020-03-30)
ii  linux-image-5.5.0-1-amd64            5.5.13-2                            amd64        Linux 5.5 for 64-bit PCs (signed)

As I noticed last time, that the deduplication process died quite hard
and might not flush stderr/stdout in that situation, I added
flush instructions after each successful file deduplication.

Result this time:

[39391.950277] BTRFS error (device dm-1): bad tree block start, want 1723369025536 have 17869752742738540124
[39391.950291] BTRFS: error (device dm-1) in btrfs_start_dirty_block_groups:2472: errno=-5 IO failure
[39391.950294] BTRFS info (device dm-1): forced readonly
[39392.021961] BTRFS warning (device dm-1): Skipping commit of aborted transaction.

want: 0x19140cc7000 (1723369025536) vs 0xf7fe1d7106fe365c (17869752742738540124)

The deduplication failure happened after more than 100hrs of deduplication
IO. With improvements from flushing/logging it could be pinpointed
to have happened exactly some seconds AFTER the very same file,
that cause the last 3 file system corruption events.

With the old logging structure, the logging would have reported the
exact same file as with all the previous events.

Currently I am running a tool to search for the source of the
"0xf7fe1d7106fe365c" value on disk and in file content as it
does not seem to be kernel or userspace address, machine code,
... Maybe this give a hint, what had happened. Is this value
a stored hashsum of a block/entry?

The "want" value is found easly (multiple tree/superblocks?):

Searching for 2 patterns, maximum length 8.
0x13ff0459e: found want
0x14032a59e: found want
0x192d401d4: found want

Just weird is the page/block/sector-wise alignment: 0x59e vs 0x1d4

As it seems, that the crash happens after deduping ~100 small files
after that large one, I will try to create a test case with same
structure. Last time my test case was just to emulate the situation
with the large file, which did not trigger any filesystem corruption.

hd

