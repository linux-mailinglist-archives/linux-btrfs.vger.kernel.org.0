Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75BE7D24D9
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 19:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjJVRSL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Oct 2023 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjJVRSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Oct 2023 13:18:10 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0967E4
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=gqduiwshhja3nl5eq3yyp5uo4m.protonmail; t=1697995083; x=1698254283;
        bh=UussBwdtfLCDcv3QF1L98D5VcOOg486D95N+IattleE=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Tm2qsmUO2JfT9aMWofbrPEWfaSnxePorKu4XLi9XDQ7yWuGbu8XnLFep0pBFflztE
         bL9LagkhPonbWNfbN6fyWVLE5lnaD5hxWgd80thtnCnkWKwjh2obVO1lGOsLuoYc/6
         NX6u9ha1d+t2S9Sb9X5g67yNmaI1nG8CpZhHXCsdJqIxtDZ+CQC5U3+d+NzcGddWT0
         AqLn1HeWr7qyX5nXdGcTXPgrGrsg3SnFOR/Wfmd39Vr2RkVHt6bH6TD2H9pXCeD05m
         VZN3gh9BcAb1NsZGnQWJHfy4PvikIE4CB18jwUKoHMLg388YAP1w8duyWzcylHBuRR
         ht99SCpU9jvmA==
Date:   Sun, 22 Oct 2023 17:17:57 +0000
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   nzb_tuxxx <nzb_tuxxx@proton.me>
Subject: fs readonly after few minutes
Message-ID: <o9XJJu0qMzbW4Iiu4eBNXZZscccGRCC0lpf_tUMBA7Mlxmlba4yfx27_7W29DfGvZAByVGSyul3dxcPwpLrPBWiUx0B-AJU-L-vyKKMyjO8=@proton.me>
Feedback-ID: 85519586:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hello,

my root btrfs fs mounts to readonly after a few minutes uptime. any ideas? =
thanks.

Linux T14s 6.1.55-1-MANJARO #1 SMP PREEMPT_DYNAMIC Sat Sep 23 12:13:56 UTC =
2023 x86_64 GNU/Linux

btrfs-progs v6.5.2

Label: none =C2=A0uuid: a9754b40-2b24-4756-84de-9286a3eee35a=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 571.27GiB
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 1.82TiB used 591.02Gi=
B path /dev/nvme0n1p2

Data, single: total=3D585.01GiB, used=3D568.73GiB
System, DUP: total=3D8.00MiB, used=3D80.00KiB
Metadata, DUP: total=3D3.00GiB, used=3D2.55GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

[ 6029.069758] Hardware name: LENOVO 20UH001QGE/20UH001QGE, BIOS R1CET76W(1=
.45 ) 07/31/2023
[ 6029.069758] RIP: 0010:__btrfs_free_extent.cold+0x91e/0xa24 [btrfs]
[ 6029.069798] Code: 50 e8 ad dd ff ff e9 20 ff ff ff bf fe ff ff ff e8 1c =
ed ff ff 84 c0 74 67 be fe ff ff ff 48 c7
c7 60 62 76 c0 e8 5d 62 36 ed <0f> 0b c6 44 24 14 01 44 8b 44 24 14 48 8b 7=
c 24 08 b9 fe ff ff ff
[ 6029.069799] RSP: 0018:ffffa53f02f67c40 EFLAGS: 00010282
[ 6029.069800] RAX: 0000000000000000 RBX: 0000004315d84000 RCX: 00000000000=
00027
[ 6029.069801] RDX: ffff8e456fa21668 RSI: 0000000000000001 RDI: ffff8e456fa=
21660
[ 6029.069802] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa53f02f=
67ab8
[ 6029.069802] R10: 0000000000000003 R11: ffffffffaf8cc7c8 R12: 00000000000=
00001
[ 6029.069803] R13: 0000000000000000 R14: 00000000000001b5 R15: ffff8e40174=
201c0
[ 6029.069804] FS: =C2=A00000000000000000(0000) GS:ffff8e456fa00000(0000) k=
nlGS:0000000000000000
[ 6029.069805] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6029.069806] CR2: 0000557e4481c000 CR3: 00000001f5010000 CR4: 00000000003=
50ee0
[ 6029.069807] Call Trace:
[ 6029.069808] =C2=A0<TASK>
[ 6029.069808] =C2=A0? __btrfs_free_extent.cold+0x91e/0xa24 [btrfs 6809b4e7=
eeb39a12924341f62dfed6044ab567f0]
[ 6029.069847] =C2=A0? __warn+0x7d/0xd0
[ 6029.069848] =C2=A0? __btrfs_free_extent.cold+0x91e/0xa24 [btrfs 6809b4e7=
eeb39a12924341f62dfed6044ab567f0]
[ 6029.069887] =C2=A0? report_bug+0xe6/0x150
[ 6029.069888] =C2=A0? handle_bug+0x3c/0x80
[ 6029.069890] =C2=A0? exc_invalid_op+0x17/0x70
[ 6029.069892] =C2=A0? asm_exc_invalid_op+0x1a/0x20
[ 6029.069894] =C2=A0? __btrfs_free_extent.cold+0x91e/0xa24 [btrfs 6809b4e7=
eeb39a12924341f62dfed6044ab567f0]
[ 6029.069934] =C2=A0__btrfs_run_delayed_refs+0x2be/0x1080 [btrfs 6809b4e7e=
eb39a12924341f62dfed6044ab567f0]
[ 6029.069972] =C2=A0? psi_task_switch+0xd6/0x230
[ 6029.069974] =C2=A0? __switch_to_asm+0x3e/0x60
[ 6029.069976] =C2=A0? finish_task_switch.isra.0+0x94/0x2f0
[ 6029.069978] =C2=A0btrfs_run_delayed_refs+0x62/0x1b0 [btrfs 6809b4e7eeb39=
a12924341f62dfed6044ab567f0]
[ 6029.070015] =C2=A0btrfs_commit_transaction+0x66/0xc60 [btrfs 6809b4e7eeb=
39a12924341f62dfed6044ab567f0]
[ 6029.070052] =C2=A0? start_transaction+0xc3/0x5f0 [btrfs 6809b4e7eeb39a12=
924341f62dfed6044ab567f0]
[ 6029.070089] =C2=A0transaction_kthread+0x141/0x1b0 [btrfs 6809b4e7eeb39a1=
2924341f62dfed6044ab567f0]
[ 6029.070125] =C2=A0? btrfs_cleanup_transaction.isra.0+0x5e0/0x5e0 [btrfs =
6809b4e7eeb39a12924341f62dfed6044ab567f0]
[ 6029.070161] =C2=A0kthread+0xde/0x110
[ 6029.070163] =C2=A0? kthread_complete_and_exit+0x20/0x20
[ 6029.070164] =C2=A0ret_from_fork+0x22/0x30
[ 6029.070168] =C2=A0</TASK>
[ 6029.070168] ---[ end trace 0000000000000000 ]---
[ 6029.070169] BTRFS: error (device nvme0n1p2: state A) in __btrfs_free_ext=
ent:3072: errno=3D-2 No such entry
[ 6029.070172] BTRFS info (device nvme0n1p2: state EA): forced readonly
[ 6029.070173] BTRFS error (device nvme0n1p2: state EA): failed to run dela=
yed ref for logical 288129302528 num_byte
s 16384 type 182 action 2 ref_mod 1: -2
[ 6029.070175] BTRFS: error (device nvme0n1p2: state EA) in btrfs_run_delay=
ed_refs:2149: errno=3D-2 No such entry


btrfs check --readonly /dev/nvme0n1p2
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: a9754b40-2b24-4756-84de-9286a3eee35a
[1/7] checking root items
[2/7] checking extents
tree extent[288129302528, 16384] parent 626657099776 has no backref item in=
 extent tree
tree extent[288129302528, 16384] parent 557937623040 has no tree block foun=
d
incorrect global backref count on 288129302528 found 9 wanted 8
backpointer mismatch on [288129302528 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space tree
[4/7] checking fs roots
root 257 inode 2898321 errors 1, no inode item
unresolved ref dir 8303 index 334 namelen 36 name 7c03a3d8-ad08-4634-9a14-0=
9a3d6bc5866 filetype 2 errors 5, no dir item, no inode ref
unresolved ref dir 8303 index 334 namelen 36 name 9e2e9865-2cd5-44b9-971e-e=
5912c0c3357 filetype 2 errors 2, no dir index
ERROR: errors found in fs roots
found 613545406464 bytes used, error(s) found
total csum bytes: 589807276
total tree bytes: 2773516288
total fs tree bytes: 1971666944
total extent tree bytes: 100712448
btree space waste bytes: 478904078
file data blocks allocated: 1129657352192 referenced 722378301440
