Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43277D2CEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 10:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjJWIju (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 04:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjJWIjt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 04:39:49 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F9910F9
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1698050363; x=1698309563;
        bh=lrF4G/huVZ+a9EzcH9++PpAv7zE2cenTuKrGWW2Q1E8=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dyYrscQzyN4FXRToJR+VHuK1Tu4LAWEesH+upacK0heeTRur/V32Q7UC+7YFd85+Y
         8UMPyB9zjQSydiF+Ozk+hGKnCOEdS+CQAzxY97RPN8+eA22rtmup1lNhMxlNqw2GIh
         udEpE+QMSwouMQLgi6iRinj7dLCrxRupNrsQ27vNzxedWXrJn1Y5SwCZa+53BkFHjx
         IrEB5n7Ti9kYcpYu+NASm6JzG/+NjYwF0f2kYfCgj1/SQ8I3gU32iUjoCQKuqf08tz
         aUd2rZh5Xsf14EAV2DQaMO2PxeWdQMgtuKY4WiibljBTOzXIsUWkzPR5lzMEr6uGbb
         9oPOV5m6S44ag==
Date:   Mon, 23 Oct 2023 08:39:05 +0000
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   nzb_tuxxx <nzb_tuxxx@proton.me>
Subject: Re: fs readonly after few minutes
Message-ID: <8CvkAdqbFRMhFiFbP1CYJ_6WRqNY_F_dTuGayo44LVbo05Rxxu59JobViGgFofNy2b5NrUpzULhzEQKHZiAI7-FGozqJF_-DIPQAbIS9OP4=@proton.me>
In-Reply-To: <c6c6a985-9817-46ef-85c6-e9fd6baa9478@gmx.com>
References: <o9XJJu0qMzbW4Iiu4eBNXZZscccGRCC0lpf_tUMBA7Mlxmlba4yfx27_7W29DfGvZAByVGSyul3dxcPwpLrPBWiUx0B-AJU-L-vyKKMyjO8=@proton.me> <c6c6a985-9817-46ef-85c6-e9fd6baa9478@gmx.com>
Feedback-ID: 85519586:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks, did a repair and it seems to work fine.

Both memory tests (lenovo internal and 1 pass memtest) were fine - i will d=
o some more intense tests but i think it could be related to some kernel fr=
eezes i had in the past after loading a faulty kernel module.

------- Original Message -------
On Sunday, October 22nd, 2023 at 23:29, Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:


>=20
> On 2023/10/23 03:47, nzb_tuxxx wrote:
>=20
> > hello,
> >=20
> > my root btrfs fs mounts to readonly after a few minutes uptime. any ide=
as? thanks.
> >=20
> > Linux T14s 6.1.55-1-MANJARO #1 SMP PREEMPT_DYNAMIC Sat Sep 23 12:13:56 =
UTC 2023 x86_64 GNU/Linux
> >=20
> > btrfs-progs v6.5.2
> >=20
> > Label: none uuid: a9754b40-2b24-4756-84de-9286a3eee35a Total devices 1 =
FS bytes used 571.27GiB
> > devid 1 size 1.82TiB used 591.02GiB path /dev/nvme0n1p2
> >=20
> > Data, single: total=3D585.01GiB, used=3D568.73GiB
> > System, DUP: total=3D8.00MiB, used=3D80.00KiB
> > Metadata, DUP: total=3D3.00GiB, used=3D2.55GiB
> > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >=20
> > [ 6029.069758] Hardware name: LENOVO 20UH001QGE/20UH001QGE, BIOS R1CET7=
6W(1.45 ) 07/31/2023
> > [ 6029.069758] RIP: 0010:__btrfs_free_extent.cold+0x91e/0xa24 [btrfs]
> > [ 6029.069798] Code: 50 e8 ad dd ff ff e9 20 ff ff ff bf fe ff ff ff e8=
 1c ed ff ff 84 c0 74 67 be fe ff ff ff 48 c7
> > c7 60 62 76 c0 e8 5d 62 36 ed <0f> 0b c6 44 24 14 01 44 8b 44 24 14 48 =
8b 7c 24 08 b9 fe ff ff ff
> > [ 6029.069799] RSP: 0018:ffffa53f02f67c40 EFLAGS: 00010282
> > [ 6029.069800] RAX: 0000000000000000 RBX: 0000004315d84000 RCX: 0000000=
000000027
> > [ 6029.069801] RDX: ffff8e456fa21668 RSI: 0000000000000001 RDI: ffff8e4=
56fa21660
> > [ 6029.069802] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa53=
f02f67ab8
> > [ 6029.069802] R10: 0000000000000003 R11: ffffffffaf8cc7c8 R12: 0000000=
000000001
> > [ 6029.069803] R13: 0000000000000000 R14: 00000000000001b5 R15: ffff8e4=
0174201c0
> > [ 6029.069804] FS: 0000000000000000(0000) GS:ffff8e456fa00000(0000) knl=
GS:0000000000000000
> > [ 6029.069805] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 6029.069806] CR2: 0000557e4481c000 CR3: 00000001f5010000 CR4: 0000000=
000350ee0
> > [ 6029.069807] Call Trace:
> > [ 6029.069808] <TASK>
> > [ 6029.069808] ? __btrfs_free_extent.cold+0x91e/0xa24 [btrfs 6809b4e7ee=
b39a12924341f62dfed6044ab567f0]
> > [ 6029.069847] ? __warn+0x7d/0xd0
> > [ 6029.069848] ? __btrfs_free_extent.cold+0x91e/0xa24 [btrfs 6809b4e7ee=
b39a12924341f62dfed6044ab567f0]
> > [ 6029.069887] ? report_bug+0xe6/0x150
> > [ 6029.069888] ? handle_bug+0x3c/0x80
> > [ 6029.069890] ? exc_invalid_op+0x17/0x70
> > [ 6029.069892] ? asm_exc_invalid_op+0x1a/0x20
> > [ 6029.069894] ? __btrfs_free_extent.cold+0x91e/0xa24 [btrfs 6809b4e7ee=
b39a12924341f62dfed6044ab567f0]
> > [ 6029.069934] __btrfs_run_delayed_refs+0x2be/0x1080 [btrfs 6809b4e7eeb=
39a12924341f62dfed6044ab567f0]
> > [ 6029.069972] ? psi_task_switch+0xd6/0x230
> > [ 6029.069974] ? __switch_to_asm+0x3e/0x60
> > [ 6029.069976] ? finish_task_switch.isra.0+0x94/0x2f0
> > [ 6029.069978] btrfs_run_delayed_refs+0x62/0x1b0 [btrfs 6809b4e7eeb39a1=
2924341f62dfed6044ab567f0]
> > [ 6029.070015] btrfs_commit_transaction+0x66/0xc60 [btrfs 6809b4e7eeb39=
a12924341f62dfed6044ab567f0]
> > [ 6029.070052] ? start_transaction+0xc3/0x5f0 [btrfs 6809b4e7eeb39a1292=
4341f62dfed6044ab567f0]
> > [ 6029.070089] transaction_kthread+0x141/0x1b0 [btrfs 6809b4e7eeb39a129=
24341f62dfed6044ab567f0]
> > [ 6029.070125] ? btrfs_cleanup_transaction.isra.0+0x5e0/0x5e0 [btrfs 68=
09b4e7eeb39a12924341f62dfed6044ab567f0]
> > [ 6029.070161] kthread+0xde/0x110
> > [ 6029.070163] ? kthread_complete_and_exit+0x20/0x20
> > [ 6029.070164] ret_from_fork+0x22/0x30
> > [ 6029.070168] </TASK>
> > [ 6029.070168] ---[ end trace 0000000000000000 ]---
> > [ 6029.070169] BTRFS: error (device nvme0n1p2: state A) in __btrfs_free=
_extent:3072: errno=3D-2 No such entry
> > [ 6029.070172] BTRFS info (device nvme0n1p2: state EA): forced readonly
> > [ 6029.070173] BTRFS error (device nvme0n1p2: state EA): failed to run =
delayed ref for logical 288129302528 num_byte
> > s 16384 type 182 action 2 ref_mod 1: -2
> > [ 6029.070175] BTRFS: error (device nvme0n1p2: state EA) in btrfs_run_d=
elayed_refs:2149: errno=3D-2 No such entry
> >=20
> > btrfs check --readonly /dev/nvme0n1p2
> > Opening filesystem to check...
> > Checking filesystem on /dev/nvme0n1p2
> > UUID: a9754b40-2b24-4756-84de-9286a3eee35a
> > [1/7] checking root items
> > [2/7] checking extents
> > tree extent[288129302528, 16384] parent 626657099776 has no backref ite=
m in extent tree
> > tree extent[288129302528, 16384] parent 557937623040 has no tree block =
found
>=20
>=20
> This is the cause of that RO flip.
>=20
> Tree block has incorrect backref, thus above btrfs_run_delayed_refs()
> can not update the backref and results transaction abort.
>=20
> Furthermore, this looks like a bitflip of your hardware memory:
>=20
> 626657099776 =3D 0x91e7ac8000
> 557937623040 =3D 0x81e7ac8000
>=20
> Exactly one bit flipped.
>=20
> Please verify your hardware memory by memtest, and repair the offending
> stick if possible.
>=20
> Only after the physical memory is fully verified, then you can run
> "btrfs check --repair" on the unmounted fs.
>=20
> This problem is repairable by btrfs-check.
>=20
> > incorrect global backref count on 288129302528 found 9 wanted 8
> > backpointer mismatch on [288129302528 16384]
> > ERROR: errors found in extent allocation tree or chunk allocation
> > [3/7] checking free space tree
> > [4/7] checking fs roots
> > root 257 inode 2898321 errors 1, no inode item
> > unresolved ref dir 8303 index 334 namelen 36 name 7c03a3d8-ad08-4634-9a=
14-09a3d6bc5866 filetype 2 errors 5, no dir item, no inode ref
> > unresolved ref dir 8303 index 334 namelen 36 name 9e2e9865-2cd5-44b9-97=
1e-e5912c0c3357 filetype 2 errors 2, no dir index
>=20
>=20
> This is another minor problem, but should not cause any transaction abort=
.
>=20
> And it's also fixable.
>=20
> Thanks,
> Qu
>=20
> > ERROR: errors found in fs roots
> > found 613545406464 bytes used, error(s) found
> > total csum bytes: 589807276
> > total tree bytes: 2773516288
> > total fs tree bytes: 1971666944
> > total extent tree bytes: 100712448
> > btree space waste bytes: 478904078
> > file data blocks allocated: 1129657352192 referenced 722378301440
