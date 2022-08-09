Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D313858D2FA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 06:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiHIEhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 00:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiHIEhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 00:37:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CDF1CB1E
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 21:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660019811;
        bh=opzIK3oGeh5rSazrir+3TXyjtrLS4f/TCOVcQTXfA6c=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=if/KZD3VDKzyLVLM3p+3sz7kVBX7e/pESViAKjP/YRf6fjrhkm3vcay2qAmsvmoi4
         eYo2gCG7+4qL4BYYSVfHEYEwxF3MjD6kTq3jt0SQbypGp6sfSKsDPgJWc6nQY/R99b
         FrZVmt2DA6Z9r+V7fBL6mLfklie2+VEw+fpVamJg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MO9z7-1o19o31Dg1-00OaZA; Tue, 09
 Aug 2022 06:36:51 +0200
Message-ID: <aac1dade-646a-8bf9-6b63-754b03bf1cd1@gmx.com>
Date:   Tue, 9 Aug 2022 12:36:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YvHVJ8t5vzxH9fS9@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qA+6s8Y4yoleXHsoTRLDiOVhzOnwWyqnnKtoHvMKYU7xzUmKde6
 fZI9ZsXe/ocDkSSfhDjzEU8Dz9UtBLjImOY9ZCAHmYo8y5v0B4YbuvHfAe2Hl10pqZBNsgw
 Rl2M5tcD474Upa218FI1Ckr38V2RNQMYK3i+SWe8s5a3TsadF7YOkino+sJq/6jciF5UbuJ
 NWqUVTVZWHDErkHIC8ktg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aXqpvmcFv4k=:jAi1LueD7gXTJa0nsLivXQ
 ZxdZn4jYO0ie6hRYvaqi5Vi5kAIhM4tHGXmxUZF7J2qhmHQaM2SlmxxT5X3LSmJ2S8nCbpU23
 VS7nlAXVEV69l/ppqAc3MBtm5nias9FCs1OLVUaYqH/w+CLB1X46Jp34+ZytH2gTRUqxtihn/
 fVs0+GNS2pN8lapqwg/ZQPAE3dGi5ZqBVKUlBlMKDX+nZYV3qjrynATWWJC3sjAm4bs5QKKH3
 4rpFxn6XMDY2wRWdV/E5N/IwjysL5V8D3MTsgYJIJiHKbcz4MBP7HAQx0F146wA2CFeFQNUGb
 0kZu1O2UebL/9eDpxN2thHhEwhCQ/vEQhyDPsmMJStKNqPaLLZLpwmE/Ecz092UHpaPbVxcxj
 I4vKQSDMO3Xo0dAPdHDW+N1UvQslyH/wKyeDGFLZ7mmQvhVJH5wk8Skw0zJOGp8pIBMVLD/Vp
 bwcLOYj95R4w2YQ9vgrx2GmzgJvEDUcW78LsdCuFpepV+DkaWRxcBllc+oCsgzlAnbojL5lCI
 VpQ94+7RHsAuDF3gae85Ha/RwYX6+GdidhsbbKPBq5odhoorIJIqwex638giQVYAYeIFajmwa
 ksl5+LOTJQDlUiBSpBJV8Bh1oqpEO74Tq4z5QNK1RELU5LxO6cjFniEy8RV6+PHMG8gFuvDCk
 Ucl/bD2H6wdBJhnFgrJND+3SqlekwNd+TtEKxdQ3br/2qT8g36WNvK8d2qPOOK+W/LP2lbAAz
 hkr/+/Tnp75TsKjNrkv9BYRXnqhLXuVfurYatQeeBio1XuJaR/Iain0SAtCQuoRMf7Z2/+nLY
 Kr/v/2CY9qSOtIp21H23IbHHcCZN3VsOtp2C8kCYN1LDLeAohGIrxbAeFR1uG2meECV83Y3vz
 8fv2m1/nrig3jEw+cTwDOuisij472riLUsYsHPgBr/Lt/fqnxT+sXgxPoqMHkm8JoaeIIjI91
 4notizeurMqUnZB2MkRb8WcQHBfACjkG3U2FETW+LIDcg37HNbVPWsVVV+MUU1nGYEp4rt+f8
 Z6Eg7F00PFzG0iJz7EeW6UkeHGzGU6N5h+nfWHJIVpJAOtBloqmFGWGdUpo2KjFyz0Ai2GThS
 OL1lde1Hc3iTbGv4zI4Bx4rlLfS/MgwLE3axG6VV3h8TlahbzQy1DUeig==
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
>
> 	- repeat until something goes badly wrong, like unrecoverable
> 	read error or crash
>
> This test case always failed quickly before (corruption was rarely
> if ever fully repaired on btrfs raid5 data), and it still doesn't work
> now, but now it doesn't work for a new reason.  Progress?

The new read repair work for compressed extents, adding HCH to the thread.

But just curious, have you tested without compression?

Thanks,
Qu
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
