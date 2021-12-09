Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B405846E748
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhLILMD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 06:12:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:36699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhLILMD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Dec 2021 06:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639048105;
        bh=JQh/2a2QLb7sMY9RRVhzrTCboG6oJ5PkF5ZVM/fhWtQ=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=Yj0GzjtFyN9Lleehu6CiS9oqBXr+53Wsv7lWABGHy6w6GzJZVXocJoFOIP5AhO4yG
         2h1gUy7J27HJZvxxPiTBhv2AWTuKZnJUargQH01RvgpLnmPxZurrntEuNE9+yMjcmw
         UiLt3QSDw3ZjspSF/CP6kPITWacO2j/0VtBG52BA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MirjY-1mIfDY2NU4-00exgO; Thu, 09
 Dec 2021 12:08:25 +0100
Message-ID: <253c767a-4599-94dd-1c65-34d34aaaebaa@gmx.com>
Date:   Thu, 9 Dec 2021 19:08:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20211206022937.26465-1-wqu@suse.com>
 <PH0PR04MB74160D826D891E5E543603769B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416374BC39FEF504430C1D59B709@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
In-Reply-To: <PH0PR04MB7416374BC39FEF504430C1D59B709@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iUcinrCqvmFy65WC+v3ZVTSNhWLUNUDvPm3V2skpx//Y/8fmxf1
 zvJSpwo0rPj02IDdKaDYy++7ZlPf4Mvge0KcPtfOgrVzRFQbcnl+PZ8A4gBM54J9WBibpNm
 Xki5vBoCjJ6HYY1JyIn6RPbFW63W+cKNre26h4zualgeWwi5i4NzCBkKjspXd4lYVcyQCSJ
 r4SiCZLiVgWOKfkyAJlPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dMgTv9leEjc=:3aKzWhDq5J4TCruotaNL0F
 uhl/+KEdhmVkCyaf75slXDAAihwACBvkbMWddvd42mPjiYCqDTesqM0i44I9nnfsi/x630+9m
 qk+MtLwHGQ2UTBPQhXW53v43k6tJC0fYReNCNiAb8s4TvS1NWIUSdOviowg78iCVoIJ6I1LOQ
 mR2ccSHzQTObwL3LJmCUQ8HIcgpdtWop0l9za2wrjgK466xB8SypuqVx0Frc9rRsjEsAXjsIm
 ze9zGHr8WZ4YiDoXZwrQ+wYVq5dyGlWQ77ouNP584eGrBB7nPpO1I+gvUz8BaliDZp43LoLOF
 6GAD6Tlw5oiu0OD7uu5Lzz+WOa9SL28UcLhn5+xM1WApLfHsjyXfRtChjxRTaIYT/XQXanveZ
 mapUvEtNcrOUiuHGg+SkwMAkaSTQogZO46IA3CUdlZ1WP6+iV6bnZHeCTiZANGkK33rlAB2Bf
 ImRTHZD4lJOCNNTyQ66q+TX/I8CVxSLhgjAr+KuKh44xHMFq0vPpICJdcbLaG3mpyEidd9Q6L
 EWTN4JR811lC3TVQcS7Kop80Gm/7NETpKHPpKO3KSG85BBPtDjx+48hH/VqPCk6GSscmm6Dsp
 dXugqt9uptnghNyINvukjfDSgAfmGnluDXXx9YJ58p8UuagcHgjBlZGoogeOlf9n3ZGhkbYzL
 GsVNDCfM3NtPOfRBOyz8nyUV1pnREIE8W6aWx2N8Nw3zRfnRvOvW/MWnwbDJV3SI1DqU3exhT
 3VB+csW12fVraBr+zXP9RWWM8tNxbL5Jc4Yt5HJSsUImD46/VuUemnVYe75V1/oFEmIlvJ7pz
 ag8LeliV/vcagnq9XEI9MQ83OdgT4y13b7BcNnzsOC63BX6AUnt1yUbXZKWFZzgke5HN/nz1C
 tPoYXJyUg/n9iovNnM4OjK2TFd9F93CDq/8kMSHE0zj5cNJY1/1pdco7seDD23xOXKPSkpB+9
 cCFoGxl6M/6k5EG13l1KDFv3j6qOAqr1y6RO6PeE45sVdYiWYhYVq7lYkeZT2Xi+LVVjDPNYA
 xR6UeHCGYoCxi+OsZ/Fw8Um90Py9AanFdz2dmwN8fSJSBIgdIspNicdjUoyeEHM/mEdAFWDbk
 5nPgLN/GeVxClU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/9 18:52, Johannes Thumshirn wrote:
> On 09/12/2021 11:07, Johannes Thumshirn wrote:
>>
>>
>> FYI the patchset doesn't apply cleanly to misc-next anymore. I've
>> pulled your branch form github and queued it for testing on zoned
>> devices.
>>
>> I'll report any findings.
>>
>
> Unfortunately I do have something to report:
>
> generic/068     [ 2020.934379] BTRFS critical (device nullb1): corrupt l=
eaf: root=3D5 block=3D4339220480 slot=3D64 ino=3D2431 file_offset=3D962560=
, invalid disk_bytenr for file extent, have 5100404224, should be aligned =
to 4096

No more error message after this line?

I thought it should be either write time or read time tree-checker
error, but I can't see the message indicating the timing.

And yes, that disk_bytenr is indeed not aligned.

> [ 2020.938165] BTRFS: error (device nullb1) in btrfs_commit_transaction:=
2310: errno=3D-5 IO failure (Error while writing out transaction)
> [ 2020.938688] BTRFS: error (device nullb1) in btrfs_finish_ordered_io:3=
110: errno=3D-5 IO failure
> [ 2020.939982] BTRFS: error (device nullb1) in cleanup_transaction:1913:=
 errno=3D-5 IO failure
> [ 2020.941938] kernel BUG at fs/btrfs/ctree.h:3516!

And this is the most weird part, it's from assertfail(), but no line
showing the line number.

Mind to provide the full dmesg?
I guess some important lines are not included.

> [ 2020.942344] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 2020.942802] CPU: 1 PID: 26201 Comm: fstest Tainted: G        W       =
  5.16.0-rc3-qu-bio-split #30
> [ 2020.943043] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5092880384, 5092884480)

This is from btrfs_lookup_bio_sums(), meaning we're submitting a read,
while the range doesn't have the csum, and it's not NODATASUM inode.

Not sure if it's related to commit transaction error.

Thanks,
Qu
> [ 2020.943576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.14.0-4.fc34 04/01/2014
> [ 2020.944424] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5092884480, 5092888576)
> [ 2020.945191] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
> [ 2020.946076] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5092888576, 5092892672)
> [ 2020.945833] Code: e8 ea 1a a0 48 c7 c7 20 eb 1a a0 e8 1b a7 43 e1 0f =
0b 89 f1 48 c7 c2 9c 9a 1a a0 48 89 fe 48 c7 c7 48 eb 1a a0 e8 01 a7 43 e1=
 <0f> 0b be 57 00 00 00 48 c7 c7 70 eb 1a a0 e8 d5 ff ff ff be 73 00
> [ 2020.947374] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5092892672, 5092896768)
> [ 2020.945833] RSP: 0018:ffffc90004c8b890 EFLAGS: 00010296
> [ 2020.949774] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5092896768, 5092900864)
> [ 2020.945833] RAX: 0000000000000071 RBX: 0000000000001000 RCX: 00000000=
00000000
> [ 2020.945833] RDX: 0000000000000001 RSI: 00000000ffffffea RDI: 00000000=
ffffffff
> [ 2020.945833] RBP: ffff888139612700 R08: ffffffff81ca4a40 R09: 00000000=
ffffff74
> [ 2020.945833] R10: ffffffff81c35760 R11: ffffffff81c35760 R12: 00000001=
3003fe00
> [ 2020.945833] R13: 0000000000000001 R14: ffff888101a8c000 R15: 00000000=
00000004
> [ 2020.945833] FS:  00007f04d5acf740(0000) GS:ffff888627d00000(0000) knl=
GS:0000000000000000
> [ 2020.945833] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2020.945833] CR2: 0000000000d7e008 CR3: 00000001bb7f0000 CR4: 00000000=
000006a0
> [ 2020.945833] Call Trace:
> [ 2020.945833]  <TASK>
> [ 2020.945833]  btrfs_lookup_bio_sums.cold+0x3f/0x61 [btrfs]
> [ 2020.951120]  ? kmem_cache_alloc+0x100/0x1d0
> [ 2020.951120]  ? mempool_alloc+0x4d/0x150
> [ 2020.951120]  btrfs_submit_data_bio+0xeb/0x200 [btrfs]
> [ 2020.951120]  ? bio_alloc_bioset+0x228/0x300
> [ 2020.951120]  submit_one_bio+0x60/0x90 [btrfs]
> [ 2020.951120]  submit_extent_page+0x175/0x460 [btrfs]
> [ 2020.951120]  btrfs_do_readpage+0x263/0x800 [btrfs]
> [ 2020.951120]  ? btrfs_repair_one_sector+0x450/0x450 [btrfs]
> [ 2020.951120]  extent_readahead+0x296/0x380 [btrfs]
> [ 2020.951120]  ? __mod_node_page_state+0x77/0xb0
> [ 2020.951120]  ? __filemap_add_folio+0x115/0x190
> [ 2020.951120]  read_pages+0x57/0x1a0
> [ 2020.951120]  page_cache_ra_unbounded+0x15c/0x1e0
> [ 2020.951120]  filemap_get_pages+0xcf/0x640
> [ 2020.951120]  ? terminate_walk+0x5c/0xf0
> [ 2020.951120]  filemap_read+0xb9/0x2a0
> [ 2020.951120]  ? arch_stack_walk+0x77/0xb0
> [ 2020.951120]  ? do_filp_open+0x9a/0x120
> [ 2020.951120]  new_sync_read+0x103/0x170
> [ 2020.951120]  ? 0xffffffff81000000
> [ 2020.951120]  vfs_read+0x121/0x1a0
> [ 2020.951120]  __x64_sys_pread64+0x69/0xa0
> [ 2020.951120]  do_syscall_64+0x43/0x90
> [ 2020.951120]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 2020.951120] RIP: 0033:0x7f04d5cce1aa
> [ 2020.951120] Code: d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 =
0f 1e fa 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 11 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 5e c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> [ 2020.951120] RSP: 002b:00007fff31411768 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000011
> [ 2020.951120] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04=
d5cce1aa
> [ 2020.951120] RDX: 0000000000000400 RSI: 0000000000fab2b0 RDI: 00000000=
00000003
> [ 2020.951120] RBP: 0000000000fab2b0 R08: 0000000000000000 R09: 00007fff=
31411507
> [ 2020.951120] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000400
> [ 2020.951120] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000=
00fab6c0
> [ 2020.951120]  </TASK>
> [ 2020.951120] Modules linked in: dm_flakey loop btrfs blake2b_generic x=
or lzo_compress zlib_deflate raid6_pq zstd_decompress zstd_compress xxhash=
 null_blk
> [ 2020.972836] ---[ end trace ceb9e45abcff5d95 ]---
> [ 2020.973244] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
> [ 2020.973773] Code: e8 ea 1a a0 48 c7 c7 20 eb 1a a0 e8 1b a7 43 e1 0f =
0b 89 f1 48 c7 c2 9c 9a 1a a0 48 89 fe 48 c7 c7 48 eb 1a a0 e8 01 a7 43 e1=
 <0f> 0b be 57 00 00 00 48 c7 c7 70 eb 1a a0 e8 d5 ff ff ff be 73 00
> [ 2020.973854] BTRFS warning (device nullb1): csum failed root 5 ino 241=
1 off 770048 csum 0x0203b7e3 expected csum 0x00000000 mirror 1
> [ 2020.975411] RSP: 0018:ffffc90004c8b890 EFLAGS: 00010296
> [ 2020.976383] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1,=
 rd 0, flush 0, corrupt 1, gen 0
> [ 2020.976841] RAX: 0000000000000071 RBX: 0000000000001000 RCX: 00000000=
00000000
> [ 2020.977656] BTRFS warning (device nullb1): csum failed root 5 ino 241=
1 off 774144 csum 0x0203b7e3 expected csum 0x00000000 mirror 1
> [ 2020.978272] RDX: 0000000000000001 RSI: 00000000ffffffea RDI: 00000000=
ffffffff
> [ 2020.979247] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1,=
 rd 0, flush 0, corrupt 2, gen 0
> [ 2020.979853] RBP: ffff888139612700 R08: ffffffff81ca4a40 R09: 00000000=
ffffff74
> [ 2020.980629] BTRFS warning (device nullb1): csum failed root 5 ino 241=
1 off 778240 csum 0x0203b7e3 expected csum 0x00000000 mirror 1
> [ 2020.981224] R10: ffffffff81c35760 R11: ffffffff81c35760 R12: 00000001=
3003fe00
> [ 2020.982211] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1,=
 rd 0, flush 0, corrupt 3, gen 0
> [ 2020.982835] R13: 0000000000000001 R14: ffff888101a8c000 R15: 00000000=
00000004
> [ 2020.983624] BTRFS warning (device nullb1): csum failed root 5 ino 241=
1 off 782336 csum 0x0203b7e3 expected csum 0x00000000 mirror 1
> [ 2020.984226] FS:  00007f04d5acf740(0000) GS:ffff888627d00000(0000) knl=
GS:0000000000000000
> [ 2020.985216] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1,=
 rd 0, flush 0, corrupt 4, gen 0
> [ 2020.985915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2020.986683] BTRFS warning (device nullb1): csum failed root 5 ino 241=
1 off 786432 csum 0x0203b7e3 expected csum 0x00000000 mirror 1
> [ 2020.987157] CR2: 0000000000d7e008 CR3: 00000001bb7f0000 CR4: 00000000=
000006a0
> [ 2020.988150] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1,=
 rd 0, flush 0, corrupt 5, gen 0
> [ 2020.989019] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5092880384, 5092884480)
> [ 2020.990401] BTRFS warning (device nullb1): csum failed root 5 ino 241=
1 off 770048 csum 0x0203b7e3 expected csum 0x00000000 mirror 1
> [ 2020.991403] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1,=
 rd 0, flush 0, corrupt 6, gen 0
> [ 2020.992443] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5090144256, 5090148352)
> [ 2020.993277] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5090148352, 5090152448)
> [ 2020.994148] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5090152448, 5090156544)
> [ 2020.994989] BTRFS warning (device nullb1): csum hole found for disk b=
ytenr range [5090156544, 5090160640)
> [ 2020.996065] BTRFS warning (device nullb1): csum failed root 5 ino 242=
7 off 2179072 csum 0xa9788697 expected csum 0x00000000 mirror 1
> [ 2020.996156] BTRFS warning (device nullb1): csum failed root 5 ino 242=
7 off 2183168 csum 0xa9788697 expected csum 0x00000000 mirror 1
> [ 2020.997107] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1,=
 rd 0, flush 0, corrupt 7, gen 0
> [ 2020.998140] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1,=
 rd 0, flush 0, corrupt 8, gen 0
> [ 2020.999004] BTRFS warning (device nullb1): csum failed root 5 ino 242=
7 off 2187264 csum 0xa9788697 expected csum 0x00000000 mirror 1
> [ 2020.999793] BTRFS warning (device nullb1): csum failed root 5 ino 242=
7 off 2191360 csum 0xa9788697 expected csum 0x00000000 mirror 1
> [ 2021.000815] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1,=
 rd 0, flush 0, corrupt 9, gen 0
>
> Resolving btrfs_lookup_bio_sums.cold+0x3f doesn't make any sense though:
> (gdb) l *btrfs_lookup_bio_sums+0x3f
> 0x1767f is in btrfs_lookup_bio_sums (fs/btrfs/file-item.c:372).
> 367     blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct b=
io *bio, u8 *dst)
> 368     {
> 369             struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> 370             struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_t=
ree;
> 371             struct btrfs_path *path;
> 372             const u32 sectorsize =3D fs_info->sectorsize;
> 373             const u32 csum_size =3D fs_info->csum_size;
> 374             u32 orig_len =3D bio->bi_iter.bi_size;
> 375             u64 orig_disk_bytenr =3D bio->bi_iter.bi_sector << SECTO=
R_SHIFT;
> 376             u64 cur_disk_bytenr;
> (gdb)
>
