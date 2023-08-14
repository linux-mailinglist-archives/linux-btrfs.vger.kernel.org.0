Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A85277B585
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjHNJb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjHNJbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 05:31:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C76AB;
        Mon, 14 Aug 2023 02:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692005495; x=1692610295; i=quwenruo.btrfs@gmx.com;
 bh=z4pX8tYeHKNb4BJDdAcgbKFxVbO8bj10iDUMzhH/XHs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ZWlFuwUpqZqR5oI2Q6KV/OhkVMh6csZsQsSOQyq8GWkS3MGx3m3ht82orF/f7NKZAM5jyll
 LgKD1Qm3qkbvkp2zC51o6TZ1FD/whl2GdjFCfAnMcx1IEfhXHpQRAeyDvXBp3264swx1PqcTx
 zHZ1axBZXbTAglT2mpIV4nUvf/0tozVgdXqPeoaaAsXEqEMIdknPvK4Z6qbIkoQvMJqnmkZho
 78KbiM4QwDijdxGwEq16Sj5H6u7v+uFLytORJ3eiH9hXXOvBdwo9g0fTdI011DNw/vkyP2R/6
 GQIszv5s4wvGuMX4L3o3kNq9mgSUUSDW08XmqjM4T4hS5oXg3KhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbivG-1pvbTM4AZC-00dGOi; Mon, 14
 Aug 2023 11:31:35 +0200
Message-ID: <2ffff901-81fc-476e-9bcd-8d351b25e07c@gmx.com>
Date:   Mon, 14 Aug 2023 17:31:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG in set_state_bits
Content-Language: en-US
To:     Yikebaer Aizezi <yikebaer61@gmail.com>, clm@fb.com,
        dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <CALcu4rZGym6uSKJqgMJpSmGgiGX=8sHRrukqR85VCiEPDFddkA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CALcu4rZGym6uSKJqgMJpSmGgiGX=8sHRrukqR85VCiEPDFddkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0AF3eXA4cmOuP/l6EErMsqIsOOE/LszHiQtsq4g6y4EbZpJsQZl
 Dc/fEAndAhYTN0q4blZEdQsv+mp7ZvVRrLrqnS4aDSMp/vBPX8nUkvShzb7Auh3wPHXBCYS
 17SsWAg526IE11Xq3NOs+WhFq2R0YSbIT25e2TDKxBoaqwuYZ84aQCr5ulnzyx38yVlzsQC
 /aZowgT8+d8+1aO3QCRVQ==
UI-OutboundReport: notjunk:1;M01:P0:9z0IUxil94Y=;cqZKMgwWxm03lxx/Zq/KXg6cTxA
 rQ2iMzyK2/sJYOEWjmrCZafaD8j4UpCsG7+aipNFVt22ibKIEOxec+YHJDXbE6fGV904EuvMY
 C0GWTTwJkSzUTogDKXjJIBXSbSh3dM2U7MDiDQ9eydEDXsnWHlpKKhkX55ODfj+RS+9Nj3HSG
 J/7izIdJE3fCxFJ/fTEBVVMmf14ba7CqiHoDQCoHXZqwmYcWET3XBPqZgQdvpBq64Gc3PlLvA
 l6qndEEAXWVOnEdVsXsGsxKcfUoDXKbLLQ10hoRZV0dSVl0kWAh9Otcj5SVQ351kirUdP0+Px
 pzz1gBmXReGfkQZ0/FVhq2F87VZdABMkdWtGj0wUKD36N9/q135M/qOs3Gm0LPiPQ9jgH6Pu0
 48VZ7QwnT7VIuFCWZvB7oJsCGomu1lxvVnng4tMOHAugOhw+h3UXsnnuyquCRLa/op1FR5/tx
 UJvkFZgKZH7O5H+cPbUetgSG1vbhFJlyxNORmsjj43vULw0zLIjBfofj4PHeVaB4eDMSA0HS0
 1E5h0malDiUTRTKsRafN4kzOd4CnlI7Ol1ak5WbK2x1WQULqLwZoqRKM50nFdSl8TXMajU4qC
 j77Npd5eeED/X7MFe4QO++KBahKk1y42OsFuw+7O4mndjMuPyn9l8Hd1ARL9/TISf0CZL6pjH
 IizuMN4qECN/eAMR+ffkeJiyadQ4YB81XKYhnOrcSBZ84N1cXWhOlISLeXQRafqZ2NLUiOdFx
 sSGVTlR60jPL1hWqL6v7iQlEoDlPLWdUrsDkTw3FgetVeYSEQo0vd31Pwa/4Otf9hcp2xYuJ5
 MPweqei34d65DHofe9qYzw4WJS8rE/LkQqvZFCDV1symPfPD3nHyh6I2VeWwH0/4fPaem0AfH
 tWvH768f1A9V3Gg+8CcrFT3VZHyyDjaGwaOtnSg98i+fq568UDhBn/yXBvuv57Nu/QcqQzGeY
 Z3+4HunwB6Ue3Cm5Qy9XtC14arU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/14 14:23, Yikebaer Aizezi wrote:
> Hello,
>
> When using Healer to fuzz the Linux-6.5-rc5,  the following crash
> was triggered.
>
> HEAD commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f (tag: v6.5-rc5)
> git tree: upstream
>
> console output:
> https://drive.google.com/file/d/1KuE7x7TW_pt_aNWWr2GAdehfYixsgeOO/view?u=
sp=3Ddrive_link
> kernel config:https://drive.google.com/file/d/1b_em6R2Zl98np83b818BzE1Fr=
xbiaGuh/view?usp=3Ddrive_link
> C reproducer:https://drive.google.com/file/d/1HlzFbWr3wqzlLi8I2_ZCQumS71=
WDLXj1/view?usp=3Ddrive_link
> Syzlang reproducer:
> https://drive.google.com/file/d/1Bu70LrWxOzsbkilELLuxo8VnjcAFiH1Y/view?u=
sp=3Ddrive_link
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
>
>
> memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3D8428 'syz-exe=
cutor'
> loop1: detected capacity change from 0 to 32768
> BTRFS: device fsid 84eb0a0b-d357-4bc1-8741-9d3223c15974 devid 1
> transid 7 /dev/loop1 scanned by syz-executor (8428)
> BTRFS info (device loop1): using xxhash64 (xxhash64-generic) checksum al=
gorithm
> BTRFS info (device loop1): disk space caching is enabled
> BTRFS info (device loop1): enabling ssd optimizations
> BTRFS info (device loop1): auto enabling async discard
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 1
> CPU: 0 PID: 8428 Comm: syz-executor Not tainted 6.5.0-rc5 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x132/0x150 lib/dump_stack.c:106
>   fail_dump lib/fault-inject.c:52 [inline]
>   should_fail_ex+0x49f/0x5b0 lib/fault-inject.c:153
>   should_failslab+0x5/0x10 mm/slab_common.c:1471
>   slab_pre_alloc_hook mm/slab.h:711 [inline]
>   slab_alloc_node mm/slub.c:3452 [inline]
>   __kmem_cache_alloc_node+0x61/0x350 mm/slub.c:3509
>   kmalloc_trace+0x22/0xd0 mm/slab_common.c:1076
>   kmalloc include/linux/slab.h:582 [inline]
>   ulist_add_merge fs/btrfs/ulist.c:210 [inline]
>   ulist_add_merge+0x16f/0x660 fs/btrfs/ulist.c:198
>   add_extent_changeset fs/btrfs/extent-io-tree.c:191 [inline]

If you checked the call site, it is doing GFP_ATOMIC allocation inside a
critical section.

Doing such error injection without any clue is not really helping here.
You can even inject error to NOFAIL call sites, and everyone would not
really treat it serious.

IIRC even syzbot is no longer reporting errors with blind error
injection anymore.

Thanks,
Qu
>   add_extent_changeset fs/btrfs/extent-io-tree.c:178 [inline]
>   set_state_bits.isra.0+0x11f/0x1c0 fs/btrfs/extent-io-tree.c:378
>   insert_state_fast fs/btrfs/extent-io-tree.c:437 [inline]
>   __set_extent_bit+0x418/0x15b0 fs/btrfs/extent-io-tree.c:1034
>   set_record_extent_bits+0x53/0x90 fs/btrfs/extent-io-tree.c:1705
>   qgroup_reserve_data+0x233/0xa80 fs/btrfs/qgroup.c:3800
>   btrfs_qgroup_reserve_data+0x2b/0xc0 fs/btrfs/qgroup.c:3843
>   btrfs_check_data_free_space+0x114/0x290 fs/btrfs/delalloc-space.c:154
>   btrfs_buffered_write+0x4ec/0x1330 fs/btrfs/file.c:1250
>   btrfs_do_write_iter+0xb75/0x11c0 fs/btrfs/file.c:1670
>   call_write_iter include/linux/fs.h:1877 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x989/0xdb0 fs/read_write.c:584
>   ksys_pwrite64 fs/read_write.c:699 [inline]
>   __do_sys_pwrite64 fs/read_write.c:709 [inline]
>   __se_sys_pwrite64 fs/read_write.c:706 [inline]
>   __x64_sys_pwrite64+0x1ef/0x240 fs/read_write.c:706
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x47959d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4717e0f068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
> RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
> R13: 000000000000000b R14: 0000000000437250 R15: 00007f4717def000
>   </TASK>
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/extent-io-tree.c:379!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8428 Comm: syz-executor Not tainted 6.5.0-rc5 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:37=
9
> Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
> 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
> 4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
> RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
> RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
> RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
> RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
> R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
> FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   insert_state_fast fs/btrfs/extent-io-tree.c:437 [inline]
>   __set_extent_bit+0x418/0x15b0 fs/btrfs/extent-io-tree.c:1034
>   set_record_extent_bits+0x53/0x90 fs/btrfs/extent-io-tree.c:1705
>   qgroup_reserve_data+0x233/0xa80 fs/btrfs/qgroup.c:3800
>   btrfs_qgroup_reserve_data+0x2b/0xc0 fs/btrfs/qgroup.c:3843
>   btrfs_check_data_free_space+0x114/0x290 fs/btrfs/delalloc-space.c:154
>   btrfs_buffered_write+0x4ec/0x1330 fs/btrfs/file.c:1250
>   btrfs_do_write_iter+0xb75/0x11c0 fs/btrfs/file.c:1670
>   call_write_iter include/linux/fs.h:1877 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x989/0xdb0 fs/read_write.c:584
>   ksys_pwrite64 fs/read_write.c:699 [inline]
>   __do_sys_pwrite64 fs/read_write.c:709 [inline]
>   __se_sys_pwrite64 fs/read_write.c:706 [inline]
>   __x64_sys_pwrite64+0x1ef/0x240 fs/read_write.c:706
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x47959d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4717e0f068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
> RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
> R13: 000000000000000b R14: 0000000000437250 R15: 00007f4717def000
>   </TASK>
> Modules linked in:
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:37=
9
> Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
> 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
> 4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
> RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
> RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
> RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
> RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
> R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
> FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
>
>
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8428 Comm: syz-executor Not tainted 6.5.0-rc5 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:37=
9
> Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
> 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
> 4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
> RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
> RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
> RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
> RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
> R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
> FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   insert_state_fast fs/btrfs/extent-io-tree.c:437 [inline]
>   __set_extent_bit+0x418/0x15b0 fs/btrfs/extent-io-tree.c:1034
>   set_record_extent_bits+0x53/0x90 fs/btrfs/extent-io-tree.c:1705
>   qgroup_reserve_data+0x233/0xa80 fs/btrfs/qgroup.c:3800
>   btrfs_qgroup_reserve_data+0x2b/0xc0 fs/btrfs/qgroup.c:3843
>   btrfs_check_data_free_space+0x114/0x290 fs/btrfs/delalloc-space.c:154
>   btrfs_buffered_write+0x4ec/0x1330 fs/btrfs/file.c:1250
>   btrfs_do_write_iter+0xb75/0x11c0 fs/btrfs/file.c:1670
>   call_write_iter include/linux/fs.h:1877 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x989/0xdb0 fs/read_write.c:584
>   ksys_pwrite64 fs/read_write.c:699 [inline]
>   __do_sys_pwrite64 fs/read_write.c:709 [inline]
>   __se_sys_pwrite64 fs/read_write.c:706 [inline]
>   __x64_sys_pwrite64+0x1ef/0x240 fs/read_write.c:706
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x47959d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4717e0f068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
> RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
> R13: 000000000000000b R14: 0000000000437250 R15: 00007f4717def000
>   </TASK>
> Modules linked in:
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:37=
9
> Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
> 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
> 4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
> RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
> RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
> RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
> RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
> R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
> FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
>
> RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
> RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
> R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
> FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   insert_state_fast fs/btrfs/extent-io-tree.c:437 [inline]
>   __set_extent_bit+0x418/0x15b0 fs/btrfs/extent-io-tree.c:1034
>   set_record_extent_bits+0x53/0x90 fs/btrfs/extent-io-tree.c:1705
>   qgroup_reserve_data+0x233/0xa80 fs/btrfs/qgroup.c:3800
>   btrfs_qgroup_reserve_data+0x2b/0xc0 fs/btrfs/qgroup.c:3843
>   btrfs_check_data_free_space+0x114/0x290 fs/btrfs/delalloc-space.c:154
>   btrfs_buffered_write+0x4ec/0x1330 fs/btrfs/file.c:1250
>   btrfs_do_write_iter+0xb75/0x11c0 fs/btrfs/file.c:1670
>   call_write_iter include/linux/fs.h:1877 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x989/0xdb0 fs/read_write.c:584
>   ksys_pwrite64 fs/read_write.c:699 [inline]
>   __do_sys_pwrite64 fs/read_write.c:709 [inline]
>   __se_sys_pwrite64 fs/read_write.c:706 [inline]
>   __x64_sys_pwrite64+0x1ef/0x240 fs/read_write.c:706
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x47959d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4717e0f068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
> RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
> R13: 000000000000000b R14: 0000000000437250 R15: 00007f4717def000
>   </TASK>
> Modules linked in:
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:37=
9
> Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
> 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
> 4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
> RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
> RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
> RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
> RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
> R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
> FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 1 seconds..
