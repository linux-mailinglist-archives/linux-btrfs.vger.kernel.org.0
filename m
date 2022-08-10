Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A177358E7B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiHJHR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiHJHR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 03:17:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C55D61D6D
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660115829;
        bh=VfncnKW2/HdcQyJNgRQ/OMdL02NjBivq7jyVqI8uOT4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FEpV2J+MJxBH2OMBEGh8UVc7BQGwEEfnNoRvdLoJbz86TnW4BjaCqCQnjZUDtn91I
         5GNk9jMvSzGf5M9Tz8NVwbOzxjystKU+EstJZlF6U0FF/vDPYb9NfOnV2YTCzAPCsq
         BSkIObYiBHKuNVXc+/Gbik8axubwAcx7MKGGMgqE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6llE-1oK0CY2Jag-008Mt3; Wed, 10
 Aug 2022 09:17:09 +0200
Message-ID: <8d633158-a786-8438-e0ef-e355dd84401a@gmx.com>
Date:   Wed, 10 Aug 2022 15:17:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
X-Provags-ID: V03:K1:YSnVk06M33MsoNWYGGoSgnPrPwcFVcrXjJ/CZdtpmE1GIJCvlvw
 cCV73Q2bc3218QRhQQzK4fzwqoyTty2PloVcqGDH2tJwQ2adg0OFwh8vA8OTV6tNabJor4B
 ZwbwcUX0NQI7se35Bv+giQf0DK/BxYSVDXRIJoY2QF/p3qc7kB7s54TX7q9O4NXc1eK/R09
 Rh67Nl6l8Z9O6yP1aCUYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zYLyO+Ot2Pc=:tJdDtey3oEPf6jEE5UDLY/
 ZF3IWfwBRTdpn1SMTdb9JDcjXvaf6Cg7YXFylCXgMsjNHTgfHPsDao9P5bPCsgmN9g77xU2Es
 pvI9L8/JvXDnoki/tORXgcxAVvZMqu9J4MHAt61+nnlchEYUX3n6zMoRUu1L+Y3v9OuvkCVHG
 rpM/GIgkpckZ4k3IvjGKpjbCAWx2AU/YE5hrVv2DJMZFLvS1aO0F/eY/hMbZxbKA51iPsPX5U
 uN7xZRJubhtx/cOjDwrN57G8C5s+8ZdZdKM3Z8FzhjRAU3/ZXWc7lzGAgCbuYkApsZKs0msT/
 6kCaWyJ7bkCGJzniWNYZ+T+IQDM/AdlOsXtcgl2FpJLDhC7Wkw6G/P8uANCoSGcQQtz/8FlGe
 40XEh9g6wOFi7GVBna/Udtqs6ScsPxL8ZcT3IVukI+w91j8RKSAP7LVMrnmcAHnGOpIaAhGzS
 32GYZvvMc0BhndycVa6rfRcWiVdHc2cWLN/x6mUsBeuXM031EDh2k3OT2EtzgIKHgKpv1VmFs
 BbWKSlOGdMRAv6KL7csZkDR0o8aORiyM4XiP2P7vqnE/ubtwXSEFGa0D8dOZTtcgND2yqMwxT
 XTJjs3hSBnjVfpam2fVnsa7IGgShWNIiwurtLkHubEYxmlLjoOZS1fmsCdWXM8UJ0EblkFPCZ
 LhgnnfnJknS3LrWA3KskYixV30gdk3SoQz5FvEN3AsxyJPVq6Os5LPAAplYLMeIGp5o8wrsPr
 E2X0lRTM1tNfb456jLXya4NMSovhVK+O3EJeY4JvEWw3bDSVg5iVmiNhZe3gDpOYi+3UvYSE6
 rEpaeoyB15fkyMddvWgNnDkwfo1zxZYdJ6xnAkkg4swMz73dcsOKUobATjt6F9exdezKAa+IF
 /iqmeK8ewY8l24yedOkvGskTU8GWaVHGTlDaA5NJ7EvgL4GfWNcvTzN4nK24Q09K/ngmMKIEI
 18RnXNROjfuC9B75x7TQRC2HCaw+DJUUJNGOT8EQss7rA02iwJSKx0CN4msu5KOzDx/ZZWXUk
 MdHb0slGWPevRYInL4TTasWOjmpk45GWLRAS+o2y91Mz4/urtL01NGmC0h+s/l5YBj1fk47iO
 EuJuOKXF7MmPmOT8XvambbGmJXrgQqCoE/ZAM4+gFKFMPMLiH9MbnWe/g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



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

Please do a uncompressed run, as we want to isolate the problem first.

Thanks,
Qu

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
