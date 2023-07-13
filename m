Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC5752C1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 23:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjGMVao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 17:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGMVam (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 17:30:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78B2D5F
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689283837; x=1689888637; i=quwenruo.btrfs@gmx.com;
 bh=MJhelfo2/7c4DAuVZdfoTSH+M/uqGGiPObfGVrS6Hbg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OEWnnRevBbzrrbGydIRK8i/nINEUTxfqUTGvY1vaf+0BYoOwLXcRKMZBzoptvSQUn6ZViHI
 CjH3YE4Lsrp34GRDTTZHQZpvZGIcXoua9h+C1U/qABhNFxUfR/mMeUqq22ZaD7Zp86N/kIamz
 nlRI4LeFdv/rdkrofHHC1PaZyUX5m9Uqdbq9X+QJB+itTznMIMKMxfz+mfgIGM0JXN/FzG088
 Hq0VjyKUu7FI4NEIrsn19ma+dNibTW+B1OL5cXhImxr+cWVGQyewfJFCBa9WDYShVLRUkEtck
 sN5SammPc1V+Juaq6ZNiZGgCOy+4JSKvPWT9khc8Zn40HIkyYI0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEm2D-1q9rfj2F8V-00GIPK; Thu, 13
 Jul 2023 23:30:37 +0200
Message-ID: <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
Date:   Fri, 14 Jul 2023 05:30:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz> <20230713163908.GW30916@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230713163908.GW30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DbicDI80bF3+sWmTPnkfHcbPl4c0g5dH/7mpWRWTJ0wkouWFtI3
 SnesZUEszpb2RVZXIHf/2hgLZ2v7s0jJuT/5lQl/HlKdGgTejdNDlelbxvnjApcsgcCg8W0
 MI+U7PFFrMLeum2/xh/D+8yoVMYjHLwQNxe3PjBsRUb8iqQuN6/cGvA1yZJI3uZY/10ZfNC
 fTuzjFr1j9quPFtBxEnXA==
UI-OutboundReport: notjunk:1;M01:P0:uC1KLXUh4jI=;txRfuq0nUcML8IPAiZflD2zvsW6
 g7OSTeU5DJVAM/PGSnZIGcMhP4F7R1PiCr7G5FYQlGOLyjCEdROE3JOTIWisK7+HuvMfrTRkV
 drx5+JOOB4DLEnWwxYHk/ke1j98qh8Uumad15Y3lLJjfLnF33/OKOctWhMi7hlzobDI5tsYlQ
 5lFQ5bOheZCqfR3XN1vFMGulPg2q41xpjfNLTf7qKsACfTOBYbFWHEwA58ETEhKDWJfacEYO8
 ZNhfZGHFlSp1NWGR04JwiWb51WzH+RytBD7Ri8xBIAAqnMouzWZPP0UPm5+NUf8xcX5/xW849
 z6jOyPpD6SUpxEpPEm4EkEUBgxI5NzdQRAYWREp0v0ScRxfsrOARzUuZS7PIn2nhvHfuPJtLK
 pLY/Up6tys6zkPV0Aj+Wfu1FwjIs3aw+GzQ4GrvQSXPAE46PlufeMm2rbdGJSl1GnuZnjAKPu
 GujCpM97Zbe03V8I9NGBT5sLzfoArfQfKVJyliUGcv2IvHQT/1avqb8yPqasxWIQ1H/6e6mFq
 N+8kfpCeDSOdorwfCE77WbpUY21sgMgpxyBvSrT3VTebn0UypInk2k0MfaRg3M0gHm5ZaKNvC
 JxIwcoBoSHKjjc8pKuGfV57DM4COlMaA1W2Mz6B5FS/i8vT1mH/74ChipR91cmRz9BwHSIKaV
 liH+Spg7SGgLJyqIGUqFcZpU3cjV4d2TIqKhQ5lfztE38Ri6rIW89XcYJQAXWSHCg52/t+/6C
 68/oCRkE5/Bo9/8xOGelGxSxUQrZk6fW5cX3806LZzuoFQQGNtVsHiBuEMAMiD+ec52iqUuXX
 Zch/QcLVvPd8jEYIhK1Y8oFQldeyyZjpWs2gb7pz3fesiqcECvrJ4T8MPnyIq2QPNaVfRMugZ
 +NTg3t6RqKD6qXWXYjBaSXJlZxnpZGrKz3Mtzq2STtigKF8Tk5xB0Ri5JdHJE1hqq7QEb4yed
 uEGOENdhAQDkxHGlxQhl7sHgdfs=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/14 00:39, David Sterba wrote:
> On Thu, Jul 13, 2023 at 02:09:35PM +0200, David Sterba wrote:
>> On Wed, Jul 12, 2023 at 02:37:40PM +0800, Qu Wenruo wrote:
>> Added to misc-next
>
> And removed again, it explodes right before the first test:

Weird, it passed my local btrfs/* tests.


>
> BTRFS: device fsid 4e9cf0f7-cdc4-4e38-9e59-de4d88122ee9 devid 1 transid =
6 /dev/vdb scanned by mkfs.btrfs (13714)
> BTRFS info (device vdb): using crc32c (crc32c-generic) checksum algorith=
m
> BTRFS info (device vdb): using free space tree
> BTRFS info (device vdb): auto enabling async discard
> BTRFS info (device vdb): checking UUID tree
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 13739 at fs/btrfs/extent-tree.c:3026 __btrfs_free_e=
xtent+0x9ac/0x1280 [btrfs]
> Modules linked in: btrfs blake2b_generic libcrc32c xor lzo_compress lzo_=
decompress raid6_pq zstd_decompress zstd_compress xxhash zstd_common loop
> CPU: 3 PID: 13739 Comm: umount Not tainted 6.5.0-rc1-default+ #2126
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0=
-gd239552-rebuilt.opensuse.org 04/01/2014
> RIP: 0010:__btrfs_free_extent+0x9ac/0x1280 [btrfs]
> RSP: 0018:ffff8880031c78a8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff88802ec71708 RCX: ffffffffc065e9ba
> RDX: dffffc0000000000 RSI: ffffffffc063f610 RDI: ffff888026511130
> RBP: ffff888002734000 R08: 0000000000000000 R09: ffffed1000638eff
> R10: ffff8880031c77ff R11: 0000000000000001 R12: 0000000000000001
> R13: ffff8880058522b8 R14: ffff8880265110e0 R15: 0000000001d24000
> FS:  00007fb5c22e9800(0000) GS:ffff88806d200000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2b194fcfc4 CR3: 000000002f32a000 CR4: 00000000000006a0
> Call Trace:
>   <TASK>
>   ? __warn+0xa1/0x200
>   ? __btrfs_free_extent+0x9ac/0x1280 [btrfs]
>   ? report_bug+0x207/0x270
>   ? handle_bug+0x65/0x90
>   ? exc_invalid_op+0x13/0x40
>   ? asm_exc_invalid_op+0x16/0x20
>   ? __btrfs_free_extent+0x39a/0x1280 [btrfs]
>   ? unlock_up+0x160/0x370 [btrfs]
>   ? __btrfs_free_extent+0x9ac/0x1280 [btrfs]
>   ? __btrfs_free_extent+0x39a/0x1280 [btrfs]
>   ? lookup_extent_backref+0xd0/0xd0 [btrfs]
>   ? __lock_release.isra.0+0x14e/0x510
>   ? reacquire_held_locks+0x280/0x280
>   run_delayed_tree_ref+0x10b/0x2d0 [btrfs]
>   btrfs_run_delayed_refs_for_head+0x630/0x960 [btrfs]
>   __btrfs_run_delayed_refs+0xce/0x160 [btrfs]
>   btrfs_run_delayed_refs+0xe7/0x2a0 [btrfs]
>   commit_cowonly_roots+0x3f1/0x4c0 [btrfs]
>   ? trace_btrfs_transaction_commit+0xd0/0xd0 [btrfs]
>   ? btrfs_commit_transaction+0xbbe/0x17e0 [btrfs]
>   btrfs_commit_transaction+0xc13/0x17e0 [btrfs]
>   ? cleanup_transaction+0x640/0x640 [btrfs]
>   ? btrfs_attach_transaction_barrier+0x1e/0x50 [btrfs]
>   sync_filesystem+0xd3/0x100
>   generic_shutdown_super+0x44/0x1f0
>   kill_anon_super+0x1e/0x40
>   btrfs_kill_super+0x25/0x30 [btrfs]
>   deactivate_locked_super+0x4c/0xc0
>   cleanup_mnt+0x13a/0x1f0
>   task_work_run+0xf2/0x170
>   ? task_work_cancel+0x20/0x20
>   ? mark_held_locks+0x1a/0x80
>   exit_to_user_mode_prepare+0x16c/0x170
>   syscall_exit_to_user_mode+0x19/0x50
>   do_syscall_64+0x49/0x90
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fb5c250f4bb
> RSP: 002b:00007ffeee578518 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 000055bf227429f0 RCX: 00007fb5c250f4bb
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055bf22742c20
> RBP: 000055bf22742b08 R08: 0000000000000073 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000055bf22742c20 R14: 0000000000000000 R15: 00007ffeee57b084
>   </TASK>
> irq event stamp: 11109
> hardirqs last  enabled at (11119): [<ffffffff841678a2>] __up_console_sem=
+0x52/0x60
> hardirqs last disabled at (11130): [<ffffffff84167887>] __up_console_sem=
+0x37/0x60
> softirqs last  enabled at (11084): [<ffffffff84cc910b>] __do_softirq+0x3=
1b/0x5ae
> softirqs last disabled at (11079): [<ffffffff840b5b09>] irq_exit_rcu+0xa=
9/0x100
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -117)
> WARNING: CPU: 3 PID: 13739 at fs/btrfs/extent-tree.c:3027 __btrfs_free_e=
xtent+0x10ff/0x1280 [btrfs]
> Modules linked in: btrfs blake2b_generic libcrc32c xor lzo_compress lzo_=
decompress raid6_pq zstd_decompress zstd_compress xxhash zstd_common loop
> CPU: 3 PID: 13739 Comm: umount Tainted: G        W          6.5.0-rc1-de=
fault+ #2126
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0=
-gd239552-rebuilt.opensuse.org 04/01/2014
> RIP: 0010:__btrfs_free_extent+0x10ff/0x1280 [btrfs]
> RSP: 0018:ffff8880031c78a8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff88802ec71708 RCX: 0000000000000000
> RDX: 0000000000000002 RSI: ffffffff841007a8 RDI: ffffffff87c9e0e0
> RBP: ffff888002734000 R08: 0000000000000001 R09: ffffed1000638eba
> R10: ffff8880031c75d7 R11: 0000000000000001 R12: 0000000000000001
> R13: ffff8880058522b8 R14: ffff8880265110e0 R15: 0000000001d24000
> FS:  00007fb5c22e9800(0000) GS:ffff88806d200000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2b194fcfc4 CR3: 000000002f32a000 CR4: 00000000000006a0
> Call Trace:
>   <TASK>
>   ? __warn+0xa1/0x200
>   ? __btrfs_free_extent+0x10ff/0x1280 [btrfs]
>   ? report_bug+0x207/0x270
>   ? handle_bug+0x65/0x90
>   ? exc_invalid_op+0x13/0x40
>   ? asm_exc_invalid_op+0x16/0x20
>   ? preempt_count_sub+0x18/0xc0
>   ? __btrfs_free_extent+0x10ff/0x1280 [btrfs]
>   ? __btrfs_free_extent+0x10ff/0x1280 [btrfs]
>   ? lookup_extent_backref+0xd0/0xd0 [btrfs]
>   ? __lock_release.isra.0+0x14e/0x510
>   ? reacquire_held_locks+0x280/0x280
>   run_delayed_tree_ref+0x10b/0x2d0 [btrfs]
>   btrfs_run_delayed_refs_for_head+0x630/0x960 [btrfs]
>   __btrfs_run_delayed_refs+0xce/0x160 [btrfs]
>   btrfs_run_delayed_refs+0xe7/0x2a0 [btrfs]
>   commit_cowonly_roots+0x3f1/0x4c0 [btrfs]
>   ? trace_btrfs_transaction_commit+0xd0/0xd0 [btrfs]
>   ? btrfs_commit_transaction+0xbbe/0x17e0 [btrfs]
>   btrfs_commit_transaction+0xc13/0x17e0 [btrfs]
>   ? cleanup_transaction+0x640/0x640 [btrfs]
>   ? btrfs_attach_transaction_barrier+0x1e/0x50 [btrfs]
>   sync_filesystem+0xd3/0x100
>   generic_shutdown_super+0x44/0x1f0
>   kill_anon_super+0x1e/0x40
>   btrfs_kill_super+0x25/0x30 [btrfs]
>   deactivate_locked_super+0x4c/0xc0
>   cleanup_mnt+0x13a/0x1f0
>   task_work_run+0xf2/0x170
>   ? task_work_cancel+0x20/0x20
>   ? mark_held_locks+0x1a/0x80
>   exit_to_user_mode_prepare+0x16c/0x170
>   syscall_exit_to_user_mode+0x19/0x50
>   do_syscall_64+0x49/0x90
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fb5c250f4bb
> RSP: 002b:00007ffeee578518 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 000055bf227429f0 RCX: 00007fb5c250f4bb
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055bf22742c20
> RBP: 000055bf22742b08 R08: 0000000000000073 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000055bf22742c20 R14: 0000000000000000 R15: 00007ffeee57b084
>   </TASK>
> irq event stamp: 11925
> hardirqs last  enabled at (11935): [<ffffffff841678a2>] __up_console_sem=
+0x52/0x60
> hardirqs last disabled at (11946): [<ffffffff84167887>] __up_console_sem=
+0x37/0x60
> softirqs last  enabled at (11084): [<ffffffff84cc910b>] __do_softirq+0x3=
1b/0x5ae
> softirqs last disabled at (11079): [<ffffffff840b5b09>] irq_exit_rcu+0xa=
9/0x100
> ---[ end trace 0000000000000000 ]---
> BTRFS: error (device vdb: state A) in __btrfs_free_extent:3027: errno=3D=
-117 Filesystem corrupted
> BTRFS info (device vdb: state EA): forced readonly
> BTRFS info (device vdb: state EA): leaf 30474240 gen 7 total ptrs 16 fre=
e space 15382 owner 2
> BTRFS info (device vdb: state EA): refs 3 lock_owner 13739 current 13739
> 	item 0 key (13631488 192 8388608) itemoff 16259 itemsize 24
> 		block group used 0 chunk_objectid 256 flags 1
> 	item 1 key (22020096 192 8388608) itemoff 16235 itemsize 24
> 		block group used 16384 chunk_objectid 256 flags 34
> 	item 2 key (22036480 169 0) itemoff 16202 itemsize 33
> 		extent refs 1 gen 6 flags 2
> 		ref#0: tree block backref root 3
> 	item 3 key (30408704 169 0) itemoff 16169 itemsize 33
> 		extent refs 1 gen 6 flags 2
> 		ref#0: tree block backref root 2
> 	item 4 key (30408704 192 268435456) itemoff 16145 itemsize 24
> 		block group used 131072 chunk_objectid 256 flags 36
> 	item 5 key (30425088 169 0) itemoff 16112 itemsize 33
> 		extent refs 1 gen 5 flags 2
> 		ref#0: tree block backref root 5
> 	item 6 key (30441472 169 0) itemoff 16079 itemsize 33
> 		extent refs 1 gen 7 flags 2
> 		ref#0: tree block backref root 1
> 	item 7 key (30457856 169 0) itemoff 16046 itemsize 33
> 		extent refs 1 gen 7 flags 2
> 		ref#0: tree block backref root 4
> 	item 8 key (30474240 169 0) itemoff 16013 itemsize 33
> 		extent refs 1 gen 7 flags 2
> 		ref#0: tree block backref root 2
> 	item 9 key (30490624 169 0) itemoff 15980 itemsize 33
> 		extent refs 1 gen 5 flags 2
> 		ref#0: tree block backref root 7
> 	item 10 key (30507008 169 0) itemoff 15947 itemsize 33
> 		extent refs 1 gen 7 flags 2
> 		ref#0: tree block backref root 10
> 	item 11 key (30523392 169 0) itemoff 15914 itemsize 33
> 		extent refs 1 gen 5 flags 2
> 		ref#0: tree block backref root 7
> 	item 12 key (30539776 169 0) itemoff 15881 itemsize 33
> 		extent refs 1 gen 5 flags 2
> 		ref#0: tree block backref root 7
> 	item 13 key (30556160 169 0) itemoff 15848 itemsize 33
> 		extent refs 1 gen 5 flags 2
> 		ref#0: tree block backref root 7
> 	item 14 key (30572544 169 0) itemoff 15815 itemsize 33
> 		extent refs 1 gen 5 flags 2
> 		ref#0: tree block backref root 7
> 	item 15 key (30588928 169 0) itemoff 15782 itemsize 33
> 		extent refs 1 gen 5 flags 2
> 		ref#0: tree block backref root 7

This looks like an error in memmove_extent_buffer() which I
intentionally didn't touch.

Anyway I'll try rebase and more tests.

Can you put your modified commits in an external branch so I can inherit
all your modifications?

Thanks,
Qu

> BTRFS critical (device vdb: state EA): unable to find ref byte nr 305561=
60 parent 0 root 4 owner 0 offset 0 slot 14
> BTRFS error (device vdb: state EA): failed to run delayed ref for logica=
l 30556160 num_bytes 16384 type 176 action 2 ref_mod 1: -2
> BTRFS: error (device vdb: state EA) in btrfs_run_delayed_refs:2102: errn=
o=3D-2 No such entry
> BTRFS warning (device vdb: state EA): Skipping commit of aborted transac=
tion.
> BTRFS: error (device vdb: state EA) in cleanup_transaction:1977: errno=
=3D-2 No such entry
