Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165665952B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 08:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiHPGl1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 02:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiHPGlJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 02:41:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90F1B728E
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660613162;
        bh=C0jYnTschSOXB4KO1yyES3kdXc7Bb51h0Yq2tMByBKU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MGTfCh/tnkGWDAOMH7JN91hP09XTyx2PEbQ0zfz0LKeSo1anchAJZHs9E6S23sq50
         M/CHXoMnuocYoq1gshDkQlqqI8pdCKQa2fYkcRA277g1b1/rcWSVmQzT3yIVO+bRiR
         e8kq5xhYNkJcICedzF6KPb4lSz9fbaIU2vib92bs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MatVh-1nlxcA185z-00cUoF; Tue, 16
 Aug 2022 03:26:02 +0200
Message-ID: <9bc5ff22-12b1-3e67-9cec-944dcc7bfc7a@gmx.com>
Date:   Tue, 16 Aug 2022 09:25:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
 <aac1dade-646a-8bf9-6b63-754b03bf1cd1@gmx.com>
 <YvK5oY6ctbDFspCm@hungrycats.org>
 <5b29a8ec-2308-a58a-8754-0e2b0ecd0b36@gmx.com>
 <Yvrsggjtc67YvTig@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yvrsggjtc67YvTig@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:56/O2jp/fnj61A5SvzxFEuYU2+nuk7DBBqyl+f6cx4bObdCW9MR
 eR9QxxhZqExR6bThyNiqoLe7cogGTnQTl0Ma/vIbAy2u0IhrbAfAMNDiWmsKDzPtuu4P/BU
 rUHj2QSjsgvaMGG6dFDHz+eipQeQgYhIelxmyBPi4raMfWPG/ZPAQQiWGMpR1/h2Csq24Aq
 tCwVNVY8jXjpBzTsl0gTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1y1rgnzzuVM=:d+T0ImZEcS8CfHV4oFeZif
 89VjjajO0D+17+xcnVN9SsbJuzfOCdMOsbnfYwuRhFbj6oAd67KEzUHc712M+p1ms7HtpIBhW
 Y+QEN8eQkyDYtyjI+Gt7htRwC5f0YGXOZtwZbOYfW9I8AlGRgLmq6Ltafog6cD3daq60XidPP
 /5/ozKY0A0913GjpqJZkrBDy4Gv7Ap6bqy9u1rjsoSmu2KA2211J61eJvlNZYh7wLGBMOurEO
 al/FhVsbNRqvQhasvRYfdqJWLYZFGopyb9cJu0Osv3oL4BqV085qnUfNTrRr3zrZbP8zzQQ8T
 O1VEyOuy6ZHMqvXqr6wW1bSFNfete3YIOVbP1JiTtR5WU/NjHJh6FbAjIZ0tx7uvh/us74c13
 F3n6NlKjC4KRR0/wLw+5a+ofLADfSFDj9Ov91nD/DTkMJ83gUdf9TXNlU0VPA3ch5zKtb1rwS
 NArbDyIdZDeqdpKQ+cb5I47G1SGj+WIitmM7jUAqRN7+mp9aszw2a+rUSQYqK+avsKC2lkk5U
 NlK+qOjWtU4lLaqr3rT+cA7uDPM6ZRQs12rtMhMOaPlCtAieu3JbwRVbeZLKvrhU+oz5m34mz
 FWdDqg+10duSBArZb+5U+ecf7s29RQ3VoWgqRdVbetv/flxTZ0GKML74l50gn4s+AUtwm39Kl
 d9vjzsWda6p/dPSen2+XVEtUv53ibASCJpmMbhMHgLT+RQm46wEEXKUhCvYwu/nA9B3r8VyU+
 ROe/Rc672E+AkRv5gKQgAqh/sMVi2v2rp12UDos3fhUy8fFFjAK9lCVMVBaTqm3zSVy9qTjuL
 Sg0q/nB2+hsMRPHCm9i2bFfUkraHdrmd1pbkcgFOPlQHyM9fn0kiAFv5li/zE9V4BI8oBuw9+
 lDT9VOTjCb92w3HTER7EvYrBfkHbttQlHrdOkzYxQZbJdJjm+JNih3HlksF3l5xQEysGswFfE
 pt4GG1IXjJa8aflZY3g9v9Y3p19S1p9b3pjV1YoTSSmtv5aSiPfjU+Yb5vaVGrLhGSt1lYOwc
 QR2qCopqL4um0hVYM16Z5CwW7z21bH0UQ72jxRYBWqzJ8W0wVLche+TNL88a9g0d5TOaY4Am2
 A97rzLAcZC8kc+EmjXiJRp9Mjd+UzTWHM5BI0qu7z/bnnPcN0KMEitaJQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/16 09:01, Zygo Blaxell wrote:
> On Sun, Aug 14, 2022 at 12:52:24PM +0800, Qu Wenruo wrote:
>> Hi Zygo,
>>
>> We have pinned down the root cause of the crash, and got a quick fix fo=
r it.
>>
>> https://lore.kernel.org/linux-btrfs/1d9b69af6ce0a79e54fbaafcc65ead8f71b=
54b60.1660377678.git.wqu@suse.com/
>>
>> Mind to test above patch to see if this can solve your crash?
>
> Without the patch, tests using compressed data and uncompressed data
> both lead to crashes:
>
> 	Compressed data hits the BUG_ON from end_compressed_bio_read
> 	as previously reported, in less than 30 minutes.
>
> 	Uncompressed data hits a BUG at fs/btrfs/tree-mod-log.c:675 about
> 	once every 2 hours.
>
> Since applying the patch, neither of these crashes has occurred so far
> (37 hours).
>
> The BUG in tree-mod-log doesn't seem to be related to the raid5 corrupti=
on
> issues.

To be more clear, the crash on end_compressed_bio_read() is not even
related to btrfs RAID56.

In theory other RAID profiles with extra duplication should also hit that.

>  The BUG starts happening before I corrupt any of the disk data.
> It might have been present before, but obscured by the much more frequen=
t
> end_compressed_bio_read crashes.
>
> I find it very interesting that the tree-mod-log BUG seems to have
> stopped immediately after applying this patch.  Could they have the same
> root cause, or a related cause?

For the tree-mod-log one, I have no clue at all why the fix can even help.=
..

>
> I'll treat the tree-mod-log thing as a separate bug for now, and start
> a new thread if I can still reproduce it on up-to-date for-next or
> misc-next.

That would help a lot.

>
>> For the RAID56 recovery, unfortunately we don't have any better way to
>> enhance it during writes yet.
>>
>> So your tests will still lead to data corruption anyway.
>
> One bug at a time...  ;)
>
> I've adapted my setup for future tests to stop writes, sync, inject the
> corruption on one drive, then either run scrub or a readonly test to
> correct errors, before resuming writes.  If I understand the constraints
> correctly, all errors should be recoverable.

Yes, that's correct.

If with that you can still hit unrecoverable errors, I'll spare no time
to fix those bugs.

Thanks,
Qu

>
> Thanks
>
>> Thanks,
>> Qu
>>
>> On 2022/8/10 03:46, Zygo Blaxell wrote:
>>> On Tue, Aug 09, 2022 at 12:36:44PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/8/9 11:31, Zygo Blaxell wrote:
>>>>> Test case is:
>>>>>
>>>>> 	- start with a -draid5 -mraid1 filesystem on 2 disks
>>>>>
>>>>> 	- run assorted IO with a mix of reads and writes (randomly
>>>>> 	run rsync, bees, snapshot create/delete, balance, scrub, start
>>>>> 	replacing one of the disks...)
>>>>>
>>>>> 	- cat /dev/zero > /dev/vdb (device 1) in the VM guest, or run
>>>>> 	blkdiscard on the underlying SSD in the VM host, to simulate
>>>>> 	single-disk data corruption
>>>>>
>>>>> 	- repeat until something goes badly wrong, like unrecoverable
>>>>> 	read error or crash
>>>>>
>>>>> This test case always failed quickly before (corruption was rarely
>>>>> if ever fully repaired on btrfs raid5 data), and it still doesn't wo=
rk
>>>>> now, but now it doesn't work for a new reason.  Progress?
>>>>
>>>> The new read repair work for compressed extents, adding HCH to the th=
read.
>>>>
>>>> But just curious, have you tested without compression?
>>>
>>> All of the ~200 BUG_ON stack traces in my logs have the same list of
>>> functions as above.  If the bug affected uncompressed data, I'd expect
>>> to see two different stack traces.  It's a fairly decent sample size,
>>> so I'd say it's most likely not happening with uncompressed extents.
>>>
>>> All the production workloads have compression enabled, so we don't
>>> normally test with compression disabled.  I can run a separate test fo=
r
>>> that if you'd like.
>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> There is now a BUG_ON arising from this test case:
>>>>>
>>>>> 	[  241.051326][   T45] btrfs_print_data_csum_error: 156 callbacks s=
uppressed
>>>>> 	[  241.100910][   T45] ------------[ cut here ]------------
>>>>> 	[  241.102531][   T45] kernel BUG at fs/btrfs/extent_io.c:2350!
>>>>> 	[  241.103261][   T45] invalid opcode: 0000 [#2] PREEMPT SMP PTI
>>>>> 	[  241.104044][   T45] CPU: 2 PID: 45 Comm: kworker/u8:4 Tainted: G=
      D           5.19.0-466d9d7ea677-for-next+ #85 89955463945a81b56a449b=
1f12383cf0d5e6b898
>>>>> 	[  241.105652][   T45] Hardware name: QEMU Standard PC (i440FX + PI=
IX, 1996), BIOS 1.14.0-2 04/01/2014
>>>>> 	[  241.106726][   T45] Workqueue: btrfs-endio-raid56 raid_recover_e=
nd_io_work
>>>>> 	[  241.107716][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
>>>>> 	[  241.108569][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85=
 48 c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e=
9 f6 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
>>>>> 	7 c7 b0 1d 45 88 e8 d0 8e 98
>>>>> 	[  241.111990][   T45] RSP: 0018:ffffbca9009f7a08 EFLAGS: 00010246
>>>>> 	[  241.112911][   T45] RAX: 0000000000000000 RBX: 0000000000000000 =
RCX: 0000000000000000
>>>>> 	[  241.115676][   T45] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: 0000000000000000
>>>>> 	[  241.118009][   T45] RBP: ffffbca9009f7b00 R08: 0000000000000000 =
R09: 0000000000000000
>>>>> 	[  241.119484][   T45] R10: 0000000000000000 R11: 0000000000000000 =
R12: ffff9cd1b9da4000
>>>>> 	[  241.120717][   T45] R13: 0000000000000000 R14: ffffe60cc81a4200 =
R15: ffff9cd235b4dfa4
>>>>> 	[  241.122594][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b7600=
000(0000) knlGS:0000000000000000
>>>>> 	[  241.123831][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
>>>>> 	[  241.125003][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 =
CR4: 0000000000170ee0
>>>>> 	[  241.126226][   T45] Call Trace:
>>>>> 	[  241.126646][   T45]  <TASK>
>>>>> 	[  241.127165][   T45]  ? __bio_clone+0x1c0/0x1c0
>>>>> 	[  241.128354][   T45]  clean_io_failure+0x21a/0x260
>>>>> 	[  241.128384][   T45]  end_compressed_bio_read+0x2a9/0x470
>>>>> 	[  241.128411][   T45]  bio_endio+0x361/0x3c0
>>>>> 	[  241.128427][   T45]  rbio_orig_end_io+0x127/0x1c0
>>>>> 	[  241.128447][   T45]  __raid_recover_end_io+0x405/0x8f0
>>>>> 	[  241.128477][   T45]  raid_recover_end_io_work+0x8c/0xb0
>>>>> 	[  241.128494][   T45]  process_one_work+0x4e5/0xaa0
>>>>> 	[  241.128528][   T45]  worker_thread+0x32e/0x720
>>>>> 	[  241.128541][   T45]  ? _raw_spin_unlock_irqrestore+0x7d/0xa0
>>>>> 	[  241.128573][   T45]  ? process_one_work+0xaa0/0xaa0
>>>>> 	[  241.128588][   T45]  kthread+0x1ab/0x1e0
>>>>> 	[  241.128600][   T45]  ? kthread_complete_and_exit+0x40/0x40
>>>>> 	[  241.128628][   T45]  ret_from_fork+0x22/0x30
>>>>> 	[  241.128659][   T45]  </TASK>
>>>>> 	[  241.128667][   T45] Modules linked in:
>>>>> 	[  241.129700][   T45] ---[ end trace 0000000000000000 ]---
>>>>> 	[  241.152310][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
>>>>> 	[  241.153328][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85=
 48 c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e=
9 f6 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
>>>>> 	7 c7 b0 1d 45 88 e8 d0 8e 98
>>>>> 	[  241.156882][   T45] RSP: 0018:ffffbca902487a08 EFLAGS: 00010246
>>>>> 	[  241.158103][   T45] RAX: 0000000000000000 RBX: 0000000000000000 =
RCX: 0000000000000000
>>>>> 	[  241.160072][   T45] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: 0000000000000000
>>>>> 	[  241.161984][   T45] RBP: ffffbca902487b00 R08: 0000000000000000 =
R09: 0000000000000000
>>>>> 	[  241.164067][   T45] R10: 0000000000000000 R11: 0000000000000000 =
R12: ffff9cd1b9da4000
>>>>> 	[  241.165979][   T45] R13: 0000000000000000 R14: ffffe60cc7589740 =
R15: ffff9cd1f45495e4
>>>>> 	[  241.167928][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b7600=
000(0000) knlGS:0000000000000000
>>>>> 	[  241.169978][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
>>>>> 	[  241.171649][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 =
CR4: 0000000000170ee0
>>>>>
>>>>> KFENCE and UBSAN aren't reporting anything before the BUG_ON.
>>>>>
>>>>> KCSAN complains about a lot of stuff as usual, including several iss=
ues
>>>>> in the btrfs allocator, but it doesn't look like anything that would
>>>>> mess with a bio.
>>>>>
>>>>> 	$ git log --no-walk --oneline FETCH_HEAD
>>>>> 	6130a25681d4 (kdave/for-next) Merge branch 'for-next-next-v5.20-202=
20804' into for-next-20220804
>>>>>
>>>>> 	repair_io_failure at fs/btrfs/extent_io.c:2350 (discriminator 1)
>>>>> 	 2345           u64 sector;
>>>>> 	 2346           struct btrfs_io_context *bioc =3D NULL;
>>>>> 	 2347           int ret =3D 0;
>>>>> 	 2348
>>>>> 	 2349           ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
>>>>> 	>2350<          BUG_ON(!mirror_num);
>>>>> 	 2351
>>>>> 	 2352           if (btrfs_repair_one_zone(fs_info, logical))
>>>>> 	 2353                   return 0;
>>>>> 	 2354
>>>>> 	 2355           map_length =3D length;
>>
>> enhance it during writes yet.
>>
>> So your tests will still lead to data corruption anyway.
>>
>> Thanks,
>> Qu
>>
>> On 2022/8/10 03:46, Zygo Blaxell wrote:
>>> On Tue, Aug 09, 2022 at 12:36:44PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/8/9 11:31, Zygo Blaxell wrote:
>>>>> Test case is:
>>>>>
>>>>> 	- start with a -draid5 -mraid1 filesystem on 2 disks
>>>>>
>>>>> 	- run assorted IO with a mix of reads and writes (randomly
>>>>> 	run rsync, bees, snapshot create/delete, balance, scrub, start
>>>>> 	replacing one of the disks...)
>>>>>
>>>>> 	- cat /dev/zero > /dev/vdb (device 1) in the VM guest, or run
>>>>> 	blkdiscard on the underlying SSD in the VM host, to simulate
>>>>> 	single-disk data corruption
>>>>>
>>>>> 	- repeat until something goes badly wrong, like unrecoverable
>>>>> 	read error or crash
>>>>>
>>>>> This test case always failed quickly before (corruption was rarely
>>>>> if ever fully repaired on btrfs raid5 data), and it still doesn't wo=
rk
>>>>> now, but now it doesn't work for a new reason.  Progress?
>>>>
>>>> The new read repair work for compressed extents, adding HCH to the th=
read.
>>>>
>>>> But just curious, have you tested without compression?
>>>
>>> All of the ~200 BUG_ON stack traces in my logs have the same list of
>>> functions as above.  If the bug affected uncompressed data, I'd expect
>>> to see two different stack traces.  It's a fairly decent sample size,
>>> so I'd say it's most likely not happening with uncompressed extents.
>>>
>>> All the production workloads have compression enabled, so we don't
>>> normally test with compression disabled.  I can run a separate test fo=
r
>>> that if you'd like.
>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> There is now a BUG_ON arising from this test case:
>>>>>
>>>>> 	[  241.051326][   T45] btrfs_print_data_csum_error: 156 callbacks s=
uppressed
>>>>> 	[  241.100910][   T45] ------------[ cut here ]------------
>>>>> 	[  241.102531][   T45] kernel BUG at fs/btrfs/extent_io.c:2350!
>>>>> 	[  241.103261][   T45] invalid opcode: 0000 [#2] PREEMPT SMP PTI
>>>>> 	[  241.104044][   T45] CPU: 2 PID: 45 Comm: kworker/u8:4 Tainted: G=
      D           5.19.0-466d9d7ea677-for-next+ #85 89955463945a81b56a449b=
1f12383cf0d5e6b898
>>>>> 	[  241.105652][   T45] Hardware name: QEMU Standard PC (i440FX + PI=
IX, 1996), BIOS 1.14.0-2 04/01/2014
>>>>> 	[  241.106726][   T45] Workqueue: btrfs-endio-raid56 raid_recover_e=
nd_io_work
>>>>> 	[  241.107716][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
>>>>> 	[  241.108569][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85=
 48 c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e=
9 f6 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
>>>>> 	7 c7 b0 1d 45 88 e8 d0 8e 98
>>>>> 	[  241.111990][   T45] RSP: 0018:ffffbca9009f7a08 EFLAGS: 00010246
>>>>> 	[  241.112911][   T45] RAX: 0000000000000000 RBX: 0000000000000000 =
RCX: 0000000000000000
>>>>> 	[  241.115676][   T45] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: 0000000000000000
>>>>> 	[  241.118009][   T45] RBP: ffffbca9009f7b00 R08: 0000000000000000 =
R09: 0000000000000000
>>>>> 	[  241.119484][   T45] R10: 0000000000000000 R11: 0000000000000000 =
R12: ffff9cd1b9da4000
>>>>> 	[  241.120717][   T45] R13: 0000000000000000 R14: ffffe60cc81a4200 =
R15: ffff9cd235b4dfa4
>>>>> 	[  241.122594][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b7600=
000(0000) knlGS:0000000000000000
>>>>> 	[  241.123831][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
>>>>> 	[  241.125003][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 =
CR4: 0000000000170ee0
>>>>> 	[  241.126226][   T45] Call Trace:
>>>>> 	[  241.126646][   T45]  <TASK>
>>>>> 	[  241.127165][   T45]  ? __bio_clone+0x1c0/0x1c0
>>>>> 	[  241.128354][   T45]  clean_io_failure+0x21a/0x260
>>>>> 	[  241.128384][   T45]  end_compressed_bio_read+0x2a9/0x470
>>>>> 	[  241.128411][   T45]  bio_endio+0x361/0x3c0
>>>>> 	[  241.128427][   T45]  rbio_orig_end_io+0x127/0x1c0
>>>>> 	[  241.128447][   T45]  __raid_recover_end_io+0x405/0x8f0
>>>>> 	[  241.128477][   T45]  raid_recover_end_io_work+0x8c/0xb0
>>>>> 	[  241.128494][   T45]  process_one_work+0x4e5/0xaa0
>>>>> 	[  241.128528][   T45]  worker_thread+0x32e/0x720
>>>>> 	[  241.128541][   T45]  ? _raw_spin_unlock_irqrestore+0x7d/0xa0
>>>>> 	[  241.128573][   T45]  ? process_one_work+0xaa0/0xaa0
>>>>> 	[  241.128588][   T45]  kthread+0x1ab/0x1e0
>>>>> 	[  241.128600][   T45]  ? kthread_complete_and_exit+0x40/0x40
>>>>> 	[  241.128628][   T45]  ret_from_fork+0x22/0x30
>>>>> 	[  241.128659][   T45]  </TASK>
>>>>> 	[  241.128667][   T45] Modules linked in:
>>>>> 	[  241.129700][   T45] ---[ end trace 0000000000000000 ]---
>>>>> 	[  241.152310][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
>>>>> 	[  241.153328][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85=
 48 c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e=
9 f6 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
>>>>> 	7 c7 b0 1d 45 88 e8 d0 8e 98
>>>>> 	[  241.156882][   T45] RSP: 0018:ffffbca902487a08 EFLAGS: 00010246
>>>>> 	[  241.158103][   T45] RAX: 0000000000000000 RBX: 0000000000000000 =
RCX: 0000000000000000
>>>>> 	[  241.160072][   T45] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: 0000000000000000
>>>>> 	[  241.161984][   T45] RBP: ffffbca902487b00 R08: 0000000000000000 =
R09: 0000000000000000
>>>>> 	[  241.164067][   T45] R10: 0000000000000000 R11: 0000000000000000 =
R12: ffff9cd1b9da4000
>>>>> 	[  241.165979][   T45] R13: 0000000000000000 R14: ffffe60cc7589740 =
R15: ffff9cd1f45495e4
>>>>> 	[  241.167928][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b7600=
000(0000) knlGS:0000000000000000
>>>>> 	[  241.169978][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
>>>>> 	[  241.171649][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 =
CR4: 0000000000170ee0
>>>>>
>>>>> KFENCE and UBSAN aren't reporting anything before the BUG_ON.
>>>>>
>>>>> KCSAN complains about a lot of stuff as usual, including several iss=
ues
>>>>> in the btrfs allocator, but it doesn't look like anything that would
>>>>> mess with a bio.
>>>>>
>>>>> 	$ git log --no-walk --oneline FETCH_HEAD
>>>>> 	6130a25681d4 (kdave/for-next) Merge branch 'for-next-next-v5.20-202=
20804' into for-next-20220804
>>>>>
>>>>> 	repair_io_failure at fs/btrfs/extent_io.c:2350 (discriminator 1)
>>>>> 	 2345           u64 sector;
>>>>> 	 2346           struct btrfs_io_context *bioc =3D NULL;
>>>>> 	 2347           int ret =3D 0;
>>>>> 	 2348
>>>>> 	 2349           ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
>>>>> 	>2350<          BUG_ON(!mirror_num);
>>>>> 	 2351
>>>>> 	 2352           if (btrfs_repair_one_zone(fs_info, logical))
>>>>> 	 2353                   return 0;
>>>>> 	 2354
>>>>> 	 2355           map_length =3D length;
>>
