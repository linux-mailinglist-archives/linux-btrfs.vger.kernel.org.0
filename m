Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE79591E59
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Aug 2022 06:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiHNEwy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Aug 2022 00:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiHNEwx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Aug 2022 00:52:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0129318B21
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 21:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660452748;
        bh=Fc8Y0hd+ywG6ibwc78ak6EbylyNyn6UDDl2nxg07jS0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fkdI00mAGmtcpoCS/cg1B5hZn2KOvUMHWT0M2Gyd17PqLt+l/qPf/cbPiFWRakyDa
         gCZNSrsRM6751h6276I6POLVuGTWGdWQMBzINcDWhRrEmvoRiz4QifKztvX+OLNpe4
         iduB9TEa4ig5jmEd+IdiTmF0T44p8+cXj5aYlfjw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBUqF-1oDxsC3N7v-00Cxqg; Sun, 14
 Aug 2022 06:52:28 +0200
Message-ID: <5b29a8ec-2308-a58a-8754-0e2b0ecd0b36@gmx.com>
Date:   Sun, 14 Aug 2022 12:52:24 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YvK5oY6ctbDFspCm@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VB8yoLfimn6HelSBf9KH06z3kJqqBb/PMSfKnfTCsOGy5Mcf2FV
 J4+nAM+uoIOzSuI/q8pZ+DIwLTsfM3IETfjGl7ENtmJNRI/lxLNnvrE9QCdpobyuPuMGKPu
 g9Rp0eSyEEDXYuKYmkckKF9afeMsg22OFma5hjvXS3uGMf5ayU5cE93Pyf94ywEUvaBRo/+
 f+MsFROaNCkIRkRCtegxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0n+8mCsG2ak=:0MvpD313FGEK3ul0kF8KBB
 jeQMiFk0u0pCEYVfC9/WHFAj5YR6cbC0e3VVtOQmdJ7VUQKjRIqTuvr9xirDddJjStENi/gLG
 y50PMD5w9pvYQSun4XviSeB3Bgd8ghJBsXL/m/5ZXEQ2sk7t8izP3djuWG/EpqJYWcmQbM06T
 1m9A0ESycxIyfpoibsA+fnevwKKx0ZlpdPg+qaWyJ2MDTnk8LZk6FZi00/8u3xqJ5Y45Czkak
 X0TsoKwK76u+Nh8N6fJyCNoiOzWkU+cSVmj95rFL8/4/Xxh6CZVJnx/KAJfgfgmICAamFXdVE
 JPlO5mACLuCDETo6+gAHuIeWiRX7tiz80xoJZ9V01y64FLl4Wf/fSSsFmB49mk7yu+kz389N1
 8UQNlseP0xX1nV945ZjX6LcKIMNL1HiZ8lBe2x2ljVoOr3KG3lh73OzPLIbw3oxHidpnf7c5H
 /0BoY3g8Aj0gSrUGsgrkXoSbr3xEXob7/8PYIaZbrMiHnteqfflo7UuYY2y3Qj3nYrYaXa92i
 E1D8/W+7y9TvnJldnJSEdFff1QB60XQvKFVlb4a99Fj5h2q/84mACr48kqvUZhjHxzYZO7VJq
 QV6krWFTXc2ROHaRB/olrzr0CYYy6YF0TocbcAPnnA91YGAtuzvz3ML+uS38RW8lF7HF7HdFp
 XV6/TTb4u4dWI/4G25fnLNtDpJzzK3nRI2Lpjxw0970dDl6nqkyDEvctaH0aS+FrIab+XJXXT
 Sy4X/QU7Be5k84GYgN4mqmIWKZQFUiM+iNCsG558+3PxLqJNjGdq2l4VyFf72V+tnZe5ifizz
 GtYWTfvYRcnYOLOx3kr2XwhFlbrA5vasqAlyzpj2wGd4hcyzJYV0AUnNyxE6BNMTyUzL2cQkB
 fFp5+tNN2P1s3Ar5X57yifyLLx+L4iS/bh5ea+wrV/xOE71/LkD3BGyrjOKh+xi5oUo+12Y15
 dUgfWMjiSoz8S2jfXFfwgBIAe+FwSe0hLtqizy4qUjsGOg2C66QaHCAz9JOQtX4z18/w3s445
 q9/RM32JxTukH05zlt0CvOYq5NLK4YERA1efKskKjprSx1KbPMneivAYq7tE/i0l5P7hknbJr
 AeV1gegv+rwjLuRv5OFTIJlMnrEAXkW8H0ARMdm3U8X3mAGYAtU2CbKFA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Zygo,

We have pinned down the root cause of the crash, and got a quick fix for i=
t.

https://lore.kernel.org/linux-btrfs/1d9b69af6ce0a79e54fbaafcc65ead8f71b54b=
60.1660377678.git.wqu@suse.com/

Mind to test above patch to see if this can solve your crash?
(Don't expect this to improve the RAID56 recovery though, the bug itself
is not in RAID56).

For the RAID56 recovery, unfortunately we don't have any better way to
enhance it during writes yet.

So your tests will still lead to data corruption anyway.

Thanks,
Qu

On 2022/8/10 03:46, Zygo Blaxell wrote:
> On Tue, Aug 09, 2022 at 12:36:44PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/8/9 11:31, Zygo Blaxell wrote:
>>> Test case is:
>>>
>>> 	- start with a -draid5 -mraid1 filesystem on 2 disks
>>>
>>> 	- run assorted IO with a mix of reads and writes (randomly
>>> 	run rsync, bees, snapshot create/delete, balance, scrub, start
>>> 	replacing one of the disks...)
>>>
>>> 	- cat /dev/zero > /dev/vdb (device 1) in the VM guest, or run
>>> 	blkdiscard on the underlying SSD in the VM host, to simulate
>>> 	single-disk data corruption
>>>
>>> 	- repeat until something goes badly wrong, like unrecoverable
>>> 	read error or crash
>>>
>>> This test case always failed quickly before (corruption was rarely
>>> if ever fully repaired on btrfs raid5 data), and it still doesn't work
>>> now, but now it doesn't work for a new reason.  Progress?
>>
>> The new read repair work for compressed extents, adding HCH to the thre=
ad.
>>
>> But just curious, have you tested without compression?
>
> All of the ~200 BUG_ON stack traces in my logs have the same list of
> functions as above.  If the bug affected uncompressed data, I'd expect
> to see two different stack traces.  It's a fairly decent sample size,
> so I'd say it's most likely not happening with uncompressed extents.
>
> All the production workloads have compression enabled, so we don't
> normally test with compression disabled.  I can run a separate test for
> that if you'd like.
>
>> Thanks,
>> Qu
>>>
>>> There is now a BUG_ON arising from this test case:
>>>
>>> 	[  241.051326][   T45] btrfs_print_data_csum_error: 156 callbacks sup=
pressed
>>> 	[  241.100910][   T45] ------------[ cut here ]------------
>>> 	[  241.102531][   T45] kernel BUG at fs/btrfs/extent_io.c:2350!
>>> 	[  241.103261][   T45] invalid opcode: 0000 [#2] PREEMPT SMP PTI
>>> 	[  241.104044][   T45] CPU: 2 PID: 45 Comm: kworker/u8:4 Tainted: G  =
    D           5.19.0-466d9d7ea677-for-next+ #85 89955463945a81b56a449b1f=
12383cf0d5e6b898
>>> 	[  241.105652][   T45] Hardware name: QEMU Standard PC (i440FX + PIIX=
, 1996), BIOS 1.14.0-2 04/01/2014
>>> 	[  241.106726][   T45] Workqueue: btrfs-endio-raid56 raid_recover_end=
_io_work
>>> 	[  241.107716][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
>>> 	[  241.108569][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85 4=
8 c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e9 =
f6 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
>>> 	7 c7 b0 1d 45 88 e8 d0 8e 98
>>> 	[  241.111990][   T45] RSP: 0018:ffffbca9009f7a08 EFLAGS: 00010246
>>> 	[  241.112911][   T45] RAX: 0000000000000000 RBX: 0000000000000000 RC=
X: 0000000000000000
>>> 	[  241.115676][   T45] RDX: 0000000000000000 RSI: 0000000000000000 RD=
I: 0000000000000000
>>> 	[  241.118009][   T45] RBP: ffffbca9009f7b00 R08: 0000000000000000 R0=
9: 0000000000000000
>>> 	[  241.119484][   T45] R10: 0000000000000000 R11: 0000000000000000 R1=
2: ffff9cd1b9da4000
>>> 	[  241.120717][   T45] R13: 0000000000000000 R14: ffffe60cc81a4200 R1=
5: ffff9cd235b4dfa4
>>> 	[  241.122594][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b760000=
0(0000) knlGS:0000000000000000
>>> 	[  241.123831][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
>>> 	[  241.125003][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 CR=
4: 0000000000170ee0
>>> 	[  241.126226][   T45] Call Trace:
>>> 	[  241.126646][   T45]  <TASK>
>>> 	[  241.127165][   T45]  ? __bio_clone+0x1c0/0x1c0
>>> 	[  241.128354][   T45]  clean_io_failure+0x21a/0x260
>>> 	[  241.128384][   T45]  end_compressed_bio_read+0x2a9/0x470
>>> 	[  241.128411][   T45]  bio_endio+0x361/0x3c0
>>> 	[  241.128427][   T45]  rbio_orig_end_io+0x127/0x1c0
>>> 	[  241.128447][   T45]  __raid_recover_end_io+0x405/0x8f0
>>> 	[  241.128477][   T45]  raid_recover_end_io_work+0x8c/0xb0
>>> 	[  241.128494][   T45]  process_one_work+0x4e5/0xaa0
>>> 	[  241.128528][   T45]  worker_thread+0x32e/0x720
>>> 	[  241.128541][   T45]  ? _raw_spin_unlock_irqrestore+0x7d/0xa0
>>> 	[  241.128573][   T45]  ? process_one_work+0xaa0/0xaa0
>>> 	[  241.128588][   T45]  kthread+0x1ab/0x1e0
>>> 	[  241.128600][   T45]  ? kthread_complete_and_exit+0x40/0x40
>>> 	[  241.128628][   T45]  ret_from_fork+0x22/0x30
>>> 	[  241.128659][   T45]  </TASK>
>>> 	[  241.128667][   T45] Modules linked in:
>>> 	[  241.129700][   T45] ---[ end trace 0000000000000000 ]---
>>> 	[  241.152310][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
>>> 	[  241.153328][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85 4=
8 c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e9 =
f6 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
>>> 	7 c7 b0 1d 45 88 e8 d0 8e 98
>>> 	[  241.156882][   T45] RSP: 0018:ffffbca902487a08 EFLAGS: 00010246
>>> 	[  241.158103][   T45] RAX: 0000000000000000 RBX: 0000000000000000 RC=
X: 0000000000000000
>>> 	[  241.160072][   T45] RDX: 0000000000000000 RSI: 0000000000000000 RD=
I: 0000000000000000
>>> 	[  241.161984][   T45] RBP: ffffbca902487b00 R08: 0000000000000000 R0=
9: 0000000000000000
>>> 	[  241.164067][   T45] R10: 0000000000000000 R11: 0000000000000000 R1=
2: ffff9cd1b9da4000
>>> 	[  241.165979][   T45] R13: 0000000000000000 R14: ffffe60cc7589740 R1=
5: ffff9cd1f45495e4
>>> 	[  241.167928][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b760000=
0(0000) knlGS:0000000000000000
>>> 	[  241.169978][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
>>> 	[  241.171649][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 CR=
4: 0000000000170ee0
>>>
>>> KFENCE and UBSAN aren't reporting anything before the BUG_ON.
>>>
>>> KCSAN complains about a lot of stuff as usual, including several issue=
s
>>> in the btrfs allocator, but it doesn't look like anything that would
>>> mess with a bio.
>>>
>>> 	$ git log --no-walk --oneline FETCH_HEAD
>>> 	6130a25681d4 (kdave/for-next) Merge branch 'for-next-next-v5.20-20220=
804' into for-next-20220804
>>>
>>> 	repair_io_failure at fs/btrfs/extent_io.c:2350 (discriminator 1)
>>> 	 2345           u64 sector;
>>> 	 2346           struct btrfs_io_context *bioc =3D NULL;
>>> 	 2347           int ret =3D 0;
>>> 	 2348
>>> 	 2349           ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
>>> 	>2350<          BUG_ON(!mirror_num);
>>> 	 2351
>>> 	 2352           if (btrfs_repair_one_zone(fs_info, logical))
>>> 	 2353                   return 0;
>>> 	 2354
>>> 	 2355           map_length =3D length;
