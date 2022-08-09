Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D758D4BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 09:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiHIHiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiHIHiP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 03:38:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E551CC0
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660030529;
        bh=YOQH8cIrX6nCFE2LQ5aCucY0lFj+ykgy47V0F9coJg8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=RC7BuEDA887Wp9YpiUhx1jW8ywlIcjH6jVw0TPkL/yEQ3Zx3KXb5f4GOY2WIV6+gr
         YA3orLexh0QzOKizn924SgBn/c4LeUWr7IIhkwM5u26NAaL5rzAo6E9aukpqwhh6fr
         5TTPd4R0Sle5vtO0i3P46xq8ZZwZFJEBXn73G/nY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1oJfcU3FWw-008Gzg; Tue, 09
 Aug 2022 09:35:29 +0200
Message-ID: <d3a3fea9-a260-dcdc-d3a0-70b1d1f0fb2d@gmx.com>
Date:   Tue, 9 Aug 2022 15:35:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YvHVJ8t5vzxH9fS9@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tan6Jg0e85YrFMdw5EpzX8JAnUwAM2nMbZ7pz6YWUQcZRuqiUp1
 j/fxQ+ake1MW3Z+pLcFG9RyhQWWTvAd7xoEGW/cA8ATNIefT4RbQTpF/JwSstS4kGT7qWle
 P6xsNlz4apb/1xa8sthvYfKL9WQAsx0Glj/g94Mkz/IgkQV1k7RnqM/1FzMUOOFZ3Ym/HQc
 btRRoVovNBrgt6HKxDp5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ma3UPSwUiWs=:kBRdawFkokhGWDgE+DIpjx
 f0SKFfXPzP+Pci08atpS7S/9f877RMOi0WD1IW6r8G6dS/MmwP1myKqZtTP6RlMM9f6sGhmNJ
 NLreRjxyU8heM2bvqIsUL2WhyX9TjRgHFtI3/cBjvam+nYAmnldTjt2sva93oJIJHORG0Qp+S
 h0W9WdaVCXLmVJF52RiMuWccEFvIvEnId2Y57KOevzGub70hWwVxN3AiDpiWy/TXLnwKtsdzd
 6FkWy83JXBpbK/p0j7VpSQce90RZo2jTQSYY1O0VdxbG8y3C3OxIkJQ3p+7ITSV8kGoZGmetA
 YeQPx8sfkVFWSj5/ekijIsYvsjOtAqu4ltk1u2mbqS32sPPk20nI6zttSvqWj8bmjOMg/dnty
 bo4lWUkhtqFXK4Is4EuYHBCQJmRM4k/3uxLz5C8BOWlHnPkrRHsr05yeE2pj5aeIOYQobVYxe
 3kdrnsf8WWkWiKzcRhOG0sFKvWcRGSXOxCWgXDsX2EtwaWcAN12A8NBRMNTNJyRwmvoxEiQY+
 NTqP3kLTahkysr1ioajn6+sarJmb0KOe/FMY37cUcYvHuO1DM1NQ2qrX01am+ngLSEGdkRJRp
 HT0CMAGjBUfg8Fqd4qcIxvIe9uUeZ9e4eWs5Qa9IXigEFVhUPwUWrlxrjeZQqSCjpuEtMQjwH
 FBpXrQONCEe6v9hBptORUdzRz51rciXA+3lKl213iO01XH83kvoj0otMujwcnx7vl93tAhSqs
 M3kuZJd0xhvzvx2QpZhhO6LPEehDRHrqinzwvSChDkPjb0e3uG4Ro+YEmGxkiM3YDj3lTMQgO
 4F/KafaH9RBAiatQJZN4efwJ63Rvb43p6ZUK8VsELIWxTb6BfJLY+lXE7FjA3Gn3GL1fbe1K4
 wm8oMn7CSgB3aa31Lm/QpWmGWp5Vrg/+pTDWV1umO9SSE3+sTgjXWp40Vt6XZsxPL0Xcby7hU
 x6Y57WxrKSv8BZdvyy7H/RRzivQupa72PE6h2Kd2BlioeHujAVZ5NlQ8w8dYQpGMg3S80ukaa
 NdGwOFinwqlCA3jTFp1KJiosJu5yCrsG7vAzFH4mRXVix4SiIdm67WmyLrNvECL+LaHApfJWj
 GNsO0nryHhIwA1RfewJclHLdByaD1Fju8iS2kdPreS7V8isSzEUjPfbgw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/9 11:31, Zygo Blaxell wrote:
> Test case is:
>
> 	- start with a -draid5 -mraid1 filesystem on 2 disks
>
> 	- run assorted IO with a mix of reads and writes (randomly
> 	run rsync, bees, snapshot create/delete, balance, scrub, start
> 	replacing one of the disks...)
>
> 	- cat /dev/zero > /dev/vdb (device 1) in the VM guest, or run
> 	blkdiscard on the underlying SSD in the VM host, to simulate
> 	single-disk data corruption

One thing to mention is, this is going to cause destructive RMW to happen.

As currently substripe write will not verify if the on-disk data stripe
matches its csum.

Thus if the wipeout happens while above workload is still running, it's
going to corrupt data eventually.

Thanks,
Qu
>
> 	- repeat until something goes badly wrong, like unrecoverable
> 	read error or crash
>
> This test case always failed quickly before (corruption was rarely
> if ever fully repaired on btrfs raid5 data), and it still doesn't work
> now, but now it doesn't work for a new reason.  Progress?
>
> There is now a BUG_ON arising from this test case:
>
> 	[  241.051326][   T45] btrfs_print_data_csum_error: 156 callbacks suppr=
essed
> 	[  241.100910][   T45] ------------[ cut here ]------------
> 	[  241.102531][   T45] kernel BUG at fs/btrfs/extent_io.c:2350!
> 	[  241.103261][   T45] invalid opcode: 0000 [#2] PREEMPT SMP PTI
> 	[  241.104044][   T45] CPU: 2 PID: 45 Comm: kworker/u8:4 Tainted: G    =
  D           5.19.0-466d9d7ea677-for-next+ #85 89955463945a81b56a449b1f12=
383cf0d5e6b898
> 	[  241.105652][   T45] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.14.0-2 04/01/2014
> 	[  241.106726][   T45] Workqueue: btrfs-endio-raid56 raid_recover_end_i=
o_work
> 	[  241.107716][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
> 	[  241.108569][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85 48 =
c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e9 f6=
 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
> 	7 c7 b0 1d 45 88 e8 d0 8e 98
> 	[  241.111990][   T45] RSP: 0018:ffffbca9009f7a08 EFLAGS: 00010246
> 	[  241.112911][   T45] RAX: 0000000000000000 RBX: 0000000000000000 RCX:=
 0000000000000000
> 	[  241.115676][   T45] RDX: 0000000000000000 RSI: 0000000000000000 RDI:=
 0000000000000000
> 	[  241.118009][   T45] RBP: ffffbca9009f7b00 R08: 0000000000000000 R09:=
 0000000000000000
> 	[  241.119484][   T45] R10: 0000000000000000 R11: 0000000000000000 R12:=
 ffff9cd1b9da4000
> 	[  241.120717][   T45] R13: 0000000000000000 R14: ffffe60cc81a4200 R15:=
 ffff9cd235b4dfa4
> 	[  241.122594][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b7600000(=
0000) knlGS:0000000000000000
> 	[  241.123831][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> 	[  241.125003][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 CR4:=
 0000000000170ee0
> 	[  241.126226][   T45] Call Trace:
> 	[  241.126646][   T45]  <TASK>
> 	[  241.127165][   T45]  ? __bio_clone+0x1c0/0x1c0
> 	[  241.128354][   T45]  clean_io_failure+0x21a/0x260
> 	[  241.128384][   T45]  end_compressed_bio_read+0x2a9/0x470
> 	[  241.128411][   T45]  bio_endio+0x361/0x3c0
> 	[  241.128427][   T45]  rbio_orig_end_io+0x127/0x1c0
> 	[  241.128447][   T45]  __raid_recover_end_io+0x405/0x8f0
> 	[  241.128477][   T45]  raid_recover_end_io_work+0x8c/0xb0
> 	[  241.128494][   T45]  process_one_work+0x4e5/0xaa0
> 	[  241.128528][   T45]  worker_thread+0x32e/0x720
> 	[  241.128541][   T45]  ? _raw_spin_unlock_irqrestore+0x7d/0xa0
> 	[  241.128573][   T45]  ? process_one_work+0xaa0/0xaa0
> 	[  241.128588][   T45]  kthread+0x1ab/0x1e0
> 	[  241.128600][   T45]  ? kthread_complete_and_exit+0x40/0x40
> 	[  241.128628][   T45]  ret_from_fork+0x22/0x30
> 	[  241.128659][   T45]  </TASK>
> 	[  241.128667][   T45] Modules linked in:
> 	[  241.129700][   T45] ---[ end trace 0000000000000000 ]---
> 	[  241.152310][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
> 	[  241.153328][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85 48 =
c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e9 f6=
 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
> 	7 c7 b0 1d 45 88 e8 d0 8e 98
> 	[  241.156882][   T45] RSP: 0018:ffffbca902487a08 EFLAGS: 00010246
> 	[  241.158103][   T45] RAX: 0000000000000000 RBX: 0000000000000000 RCX:=
 0000000000000000
> 	[  241.160072][   T45] RDX: 0000000000000000 RSI: 0000000000000000 RDI:=
 0000000000000000
> 	[  241.161984][   T45] RBP: ffffbca902487b00 R08: 0000000000000000 R09:=
 0000000000000000
> 	[  241.164067][   T45] R10: 0000000000000000 R11: 0000000000000000 R12:=
 ffff9cd1b9da4000
> 	[  241.165979][   T45] R13: 0000000000000000 R14: ffffe60cc7589740 R15:=
 ffff9cd1f45495e4
> 	[  241.167928][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b7600000(=
0000) knlGS:0000000000000000
> 	[  241.169978][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> 	[  241.171649][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 CR4:=
 0000000000170ee0
>
> KFENCE and UBSAN aren't reporting anything before the BUG_ON.
>
> KCSAN complains about a lot of stuff as usual, including several issues
> in the btrfs allocator, but it doesn't look like anything that would
> mess with a bio.
>
> 	$ git log --no-walk --oneline FETCH_HEAD
> 	6130a25681d4 (kdave/for-next) Merge branch 'for-next-next-v5.20-2022080=
4' into for-next-20220804
>
> 	repair_io_failure at fs/btrfs/extent_io.c:2350 (discriminator 1)
> 	 2345           u64 sector;
> 	 2346           struct btrfs_io_context *bioc =3D NULL;
> 	 2347           int ret =3D 0;
> 	 2348
> 	 2349           ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
> 	>2350<          BUG_ON(!mirror_num);
> 	 2351
> 	 2352           if (btrfs_repair_one_zone(fs_info, logical))
> 	 2353                   return 0;
> 	 2354
> 	 2355           map_length =3D length;
