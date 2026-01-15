Return-Path: <linux-btrfs+bounces-20548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2CD26502
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 18:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BA91304120D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41473C1969;
	Thu, 15 Jan 2026 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryOmMl/I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40F3BF303
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497271; cv=none; b=cBrg+GYa2HGp3UDs35dd9Fv5rj5UM5vqBuFK259h30c9K1Sgx3/k721GXeKUeSP4LtS2Og7jgxaawUOidW9yudbsBY2UZR4lIl2rw8hpvuuOIk3iq+xc/vcik1tDkV6uhy+wkgNAdTMHvIrE7j/lZtlfMZiOM6hThUP5rOzmBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497271; c=relaxed/simple;
	bh=Zy2XBOUl06E2ewXUBBUdQH8ukWVFc56huSYjwSnhf9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INGF+YqNzPo3XvIXY1C2bJbWobUEeUie1ly71krq7ARV7jiV/g/RzHbb8NtRe7qZhdkuLBtx88ZUO0PHsAF0xQFwzdxXQvzZfOWiZTw81yUrTWUatn7ZWlndR8V4LnGj8Dw2aiEm4Xj6lcb3SfFBiokEtE0WplF6we76tuF2jBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryOmMl/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C453BC116D0
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768497270;
	bh=Zy2XBOUl06E2ewXUBBUdQH8ukWVFc56huSYjwSnhf9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ryOmMl/IJtK1fWhTLazjXj9/2gvtvHuBjO5LBQFVf90unQF3AFCUAFGqbsgHj5Y4W
	 oN4FVU5PgDwQfZt1RJao6DH1BMMTWjY3tf5fzAWicPgOr4tAygKsEr0rz47Ux4yPQ3
	 NGqdf+PePZVv7qlIBjOnsON0pC1y2QMbPqmBgL1sHhath9SFUOrRJ7+bocn7PGCZyW
	 Ew3KMOBmetCY4lcB+AX5PIuZj0B9TqjlViEH222lMkN/k7qjHYcWmGxVN1HYRfbTDQ
	 R8zEeiMGikMfFkfDxWkbIufjcHwmt+BqaIo9Yu80z32RLf7kBLueHqTVnK9IIg5SMe
	 GBbcgtEweY3qA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so2027577a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 09:14:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZ1HoP8L97e4K7Ei9Nf7XIvixf0BJmSaB34nbtEcbE+V6rxpppCi8WAoOcxXI6fG2XANBQlKdmI22beA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjri6hFCeBmzcSGfV4fs37eF8pwmnLT9eeODFsExb8878TNn6
	P6TkXfjVJoTjc8XUBNd8IIdZ42eQ8jb+Wfw3cWtoZUw0X38bgX764URb4LknpMVztY4BDQ+kT08
	+Oi03iYoeF3Azfn4PWIh5nKO5uaYYJ0M=
X-Received: by 2002:a17:907:a41:b0:b86:f558:ecaa with SMTP id
 a640c23a62f3a-b8792dc7e5amr32993366b.27.1768497269315; Thu, 15 Jan 2026
 09:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SA1PR18MB56922F690C5EC2D85371408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com>
 <f53f9520-9168-49a3-8354-33d90d2ee3e5@gmx.com> <SA1PR18MB5692EBE3FFC7694F733E6007998FA@SA1PR18MB5692.namprd18.prod.outlook.com>
 <12a4bcff-0cd5-4c20-8e15-67d9e6e854b5@gmx.com> <SA1PR18MB569257A1B797A511E68D458C998CA@SA1PR18MB5692.namprd18.prod.outlook.com>
 <CAL3q7H5uz2uLnZOTHOH0oC2vB39m5w9yhBzcFp0NJyMYCnSQ9w@mail.gmail.com>
In-Reply-To: <CAL3q7H5uz2uLnZOTHOH0oC2vB39m5w9yhBzcFp0NJyMYCnSQ9w@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Jan 2026 17:13:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7z+GMe4xEcQe7yEr1jiiqPaHAyvub-7797qEcPrvetow@mail.gmail.com>
X-Gm-Features: AZwV_Qj0rAaToqbt8xkdufV4rfUkeLNDnpBeK_k3kHC9AF19PFp2zE0r8B-pBX8
Message-ID: <CAL3q7H7z+GMe4xEcQe7yEr1jiiqPaHAyvub-7797qEcPrvetow@mail.gmail.com>
Subject: Re: btrfs stopps working when stressed
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:47=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Thu, Jan 15, 2026 at 9:03=E2=80=AFAM Aleksandar Gerasimovski
> <Aleksandar.Gerasimovski@belden.com> wrote:
> >
> >
> >
> > From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> >
> > =E5=9C=A8 2026/1/15 00:34, Aleksandar Gerasimovski =E5=86=99=E9=81=93:
> > > Hi Qu,
> > >
> > > Many thanks for answering:
> > >
> > > No, our setup has single device (btrfs output is posted below).
> > >
> > > We are on an embedded device so the specific partition with btrfs is =
1GiB, so if you really suggest 10GiB minimum than do we indeed do wrong FS =
selection?
> >
> > >> OK, there is a real bug.
> > If you could give us some starting pointers we would try to go on with =
debugging.
>
> No need to, this is reproducible with a 1G device on latest kernel.


Try this (also at https://pastebin.com/raw/xqeHDVEU):

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 96cf7a162987..ddb43a5b3efd 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -532,6 +532,11 @@ struct btrfs_block_rsv
*btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
                                           BTRFS_RESERVE_NO_FLUSH);
        if (!ret)
                return block_rsv;
+
+       /* TODO explain why. */
+       if (btrfs_root_id(root) =3D=3D BTRFS_TREE_LOG_OBJECTID)
+               return ERR_PTR(ret);
+
        /*
         * If we couldn't reserve metadata bytes try and use some from
         * the global reserve if its space type is the same as the global
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 857e4fd2c77e..bd6fdee8cf2d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -512,6 +512,10 @@ static inline bool can_overcommit(const struct
btrfs_space_info *space_info,
        if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
                return false;

+       /* TODO: explain. */
+       if (data_race(space_info->fs_info->global_block_rsv.full))
+               return false;
+
        return check_can_overcommit(space_info, space_info_used_bytes,
bytes, flush);
 }


For me it fixes the -ENOSPC with that bonnie++ test on a 1G device.
I have been meaning to test and submit the first chunk for a while.
After some more testing, I'll split that into two patches and write
some change logs and submit them to the list.

Thanks.

>
> >
> > >> The problem is, when the failure happened, there are only around 350=
MiB
> > >> utilized, not 1GiB.
> >
> > >> The metadata over-allocation decision is correct as we should be abl=
e to
> > >> allocate new metadata chunks.
> > Looks mixed-bg option helps in this case, thanks for the hint.
> >
> >
> > >> Thanks,
> > >> Qu
> >
> > >
> > > We could for sure try if mixed-bg improves the robustness.
> > > Is this known limitation of the btrfs?
> > >
> > > BTRFS status before the test:
> > > ------------------------------------------------------------
> > > # btrfs filesystem usage /mnt/data
> > > Overall:
> > >      Device size:                   1.00GiB
> > >      Device allocated:            350.38MiB
> > >      Device unallocated:          673.62MiB
> > >      Device missing:                  0.00B
> > >      Device slack:                    0.00B
> > >      Used:                         20.80MiB
> > >      Free (estimated):            885.20MiB      (min: 548.39MiB)
> > >      Free (statfs, df):           884.20MiB
> > >      Data ratio:                       1.00
> > >      Metadata ratio:                   2.00
> > >      Global reserve:                5.50MiB      (used: 0.00B)
> > >      Multiple profiles:                  no
> > >
> > > Data,single: Size:232.00MiB, Used:20.43MiB (8.80%)
> > >     /dev/mmcblk1p9        232.00MiB
> > >
> > > Metadata,DUP: Size:51.19MiB, Used:176.00KiB (0.34%)
> > >     /dev/mmcblk1p9        102.38MiB
> > >
> > > System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
> > >     /dev/mmcblk1p9         16.00MiB
> > >
> > > Unallocated:
> > >     /dev/mmcblk1p9        673.62MiB
> > > -------------------------------------------------------
> > >
> > > ------------------------------------------------------
> > > # btrfs filesystem df /mnt/data/
> > > Data, single: total=3D232.00MiB, used=3D20.43MiB
> > > System, DUP: total=3D8.00MiB, used=3D16.00KiB
> > > Metadata, DUP: total=3D51.19MiB, used=3D176.00KiB
> > > GlobalReserve, single: total=3D5.50MiB, used=3D0.00B
> > >
> > > Running the test:
> > > # bonnie++ -d test/ -m NITROC -u 0 -s 256M -r 128M -b
> > > Using uid:0, gid:0.
> > > Writing a byte at a time...done
> > > Writing intelligently...done
> > > Rewriting...done
> > > Reading a byte at a time...done
> > > Reading intelligently...done
> > > start 'em...done...done...done...done...done...
> > > Create files in sequential order...[  971.162957] BTRFS warning (devi=
ce mmcblk1p9): Skipping commit of aborted transaction.
> > > [  971.170964] ------------[ cut here ]------------
> > > [  971.175668] BTRFS: Transaction aborted (error -28)
> > > [  971.180579] WARNING: CPU: 2 PID: 845 at /fs/btrfs/transaction.c:20=
27 btrfs_commit_transaction+0x9ec/0xb34
> > > [  971.190238] Modules linked in: omap_rng rng_core mac80211(O) cfg80=
211(O) firmware_class compat(O)
> > > [  971.199251] CPU: 2 UID: 0 PID: 845 Comm: bonnie++ Tainted: G      =
     O       6.12.62-coreos-cn913x-tiny #1
> > > [  971.209161] Tainted: [O]=3DOOT_MODULE
> > > [  971.212684] Hardware name: belden nitroc VNX/NetModule CN9131 base=
d NITROC platform V1, BIOS 2024.10-g97cd8f3422eb 10/01/2024
> > > [  971.224059] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> > > [  971.231082] pc : btrfs_commit_transaction+0x9ec/0xb34
> > > [  971.236182] lr : btrfs_commit_transaction+0x9ec/0xb34
> > > [  971.241281] sp : ffff8000822a3c70
> > > [  971.244628] x29: ffff8000822a3ca0 x28: ffff0001012a3000 x27: ffff0=
001012a3c9c
> > > [  971.251854] x26: ffff0001012a3000 x25: ffff000100432b90 x24: ffff0=
00100432b90
> > > [  971.259076] x23: ffff000100432a78 x22: ffff0001012a3000 x21: ffff0=
00100432b28
> > > [  971.266294] x20: 00000000ffffffe4 x19: ffff0001012e4c00 x18: 00000=
0000000000a
> > > [  971.273513] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8=
000822a36d0
> > > [  971.280732] x14: 0000000000000000 x13: 2938322d20726f72 x12: 72652=
82064657472
> > > [  971.287951] x11: 0000000000000293 x10: ffff800080f0a730 x9 : ffff8=
00080f62760
> > > [  971.295170] x8 : ffff00013f795708 x7 : ffff00013f795708 x6 : ffff0=
0013f7976f0
> > > [  971.302387] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000=
00000000000
> > > [  971.309604] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0=
0010f911e00
> > > [  971.316821] Call trace:
> > > [  971.319298]  btrfs_commit_transaction+0x9ec/0xb34
> > > [  971.324051]  btrfs_sync_file+0x43c/0x488
> > > [  971.328028]  vfs_fsync_range+0x68/0x84
> > > [  971.331833]  vfs_fsync+0x1c/0x28
> > > [  971.335108]  do_fsync+0x30/0x58
> > > [  971.338296]  __arm64_sys_fsync+0x18/0x28
> > > [  971.342272]  invoke_syscall.constprop.0+0x74/0xc8
> > > [  971.347034]  do_el0_svc+0x90/0xb0
> > > [  971.350396]  el0_svc+0xbc/0x104
> > > [  971.353581]  el0t_64_sync_handler+0x84/0x12c
> > > [  971.357899]  el0t_64_sync+0x190/0x194
> > > [  971.361604] ---[ end trace 0000000000000000 ]---
> > > [  971.366654] BTRFS info (device mmcblk1p9 state A): dumping space i=
nfo:
> > > [  971.373230] BTRFS info (device mmcblk1p9 state A): space_info DATA=
 has 562245632 free, is not full
> > > [  971.382247] BTRFS info (device mmcblk1p9 state A): space_info tota=
l=3D583663616, used=3D21417984, pinned=3D0, reserved=3D0, may_use=3D0, read=
only=3D0 zone_unusable=3D0
> > > [  971.396066] BTRFS info (device mmcblk1p9 state A): space_info META=
DATA has -5767168 free, is full
> > > [  971.404994] BTRFS info (device mmcblk1p9 state A): space_info tota=
l=3D53673984, used=3D475136, pinned=3D53116928, reserved=3D16384, may_use=
=3D5767168, readonly=3D65536 zone_unusable=3D0
> > > [  971.420375] BTRFS info (device mmcblk1p9 state A): space_info SYST=
EM has 8355840 free, is not full
> > > [  971.429389] BTRFS info (device mmcblk1p9 state A): space_info tota=
l=3D8388608, used=3D16384, pinned=3D16384, reserved=3D0, may_use=3D0, reado=
nly=3D0 zone_unusable=3D0
> > > [  971.443110] BTRFS info (device mmcblk1p9 state A): global_block_rs=
v: size 5767168 reserved 5767168
> > > [  971.452117] BTRFS info (device mmcblk1p9 state A): trans_block_rsv=
: size 0 reserved 0
> > > [  971.459991] BTRFS info (device mmcblk1p9 state A): chunk_block_rsv=
: size 0 reserved 0
> > > [  971.467865] BTRFS info (device mmcblk1p9 state A): delayed_block_r=
sv: size 0 reserved 0
> > > [  971.475915] BTRFS info (device mmcblk1p9 state A): delayed_refs_rs=
v: size 0 reserved 0
> > > [  971.483876] BTRFS: error (device mmcblk1p9 state A) in cleanup_tra=
nsaction:2027: errno=3D-28 No space left
> > > [  971.493414] BTRFS info (device mmcblk1p9 state EA): forced readonl=
y
> > > Can't sync directory, turning off dir-sync.
> > > Can't create file 000000028fIyc
> > > Cleaning up test directory after error.
> > > Bonnie: drastic I/O error (rmdir): Read-only file system
> > > ---------------------------------------------------------------------=
---
> > >
> > > BTRFS status after the failing test:
> > > ---------------------------------------------
> > > # btrfs filesystem usage /mnt/data
> > > Overall:
> > >      Device size:                   1.00GiB
> > >      Device allocated:            675.00MiB
> > >      Device unallocated:          349.00MiB
> > >      Device missing:                  0.00B
> > >      Device slack:                    0.00B
> > >      Used:                         21.36MiB
> > >      Free (estimated):            885.20MiB      (min: 710.70MiB)
> > >      Free (statfs, df):           884.20MiB
> > >      Data ratio:                       1.00
> > >      Metadata ratio:                   2.00
> > >      Global reserve:                5.50MiB      (used: 0.00B)
> > >      Multiple profiles:                  no
> > >
> > > Data,single: Size:556.62MiB, Used:20.43MiB (3.67%)
> > >     /dev/mmcblk1p9        556.62MiB
> > >
> > > Metadata,DUP: Size:51.19MiB, Used:464.00KiB (0.89%)
> > >     /dev/mmcblk1p9        102.38MiB
> > >
> > > System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
> > >     /dev/mmcblk1p9         16.00MiB
> > >
> > > Unallocated:
> > >     /dev/mmcblk1p9        349.00MiB
> > > -------------------------------------------------
> > >
> > > Regards,
> > > Aleksandar
> > >
> > > From: Qu Wenruo <mailto:quwenruo.btrfs@gmx.com>
> > > Sent: Wednesday, January 14, 2026 11:06 AM
> > > To: Aleksandar Gerasimovski <mailto:Aleksandar.Gerasimovski@belden.co=
m>; mailto:linux-btrfs@vger.kernel.org
> > > Subject: Re: btrfs stopps working when stressed
> > >
> > > =E5=9C=A8 2026/1/14 19:=E2=80=8A55, Aleksandar Gerasimovski =E5=86=99=
=E9=81=93: > Hello everyone, > > I'm looking for a solution for a problem t=
hat we have with the btrfs. > > We have tried to do some initial investigat=
ion on our side however we have limited
> > >
> > >
> > >
> > > =E5=9C=A8 2026/1/14 19:55, Aleksandar Gerasimovski =E5=86=99=E9=81=93=
:
> > >> Hello everyone,
> > >>
> > >> I'm looking for a solution for a problem that we have with the btrfs=
.
> > >>
> > >> We have tried to do some initial investigation on our side however w=
e have limited knowledge and experience in this area.
> > >> I hope you can give us some pointers how to investigate this further=
 and in what corners we shall start looking.
> > >>
> > >> So, on our products using the btrfs we see that the filesystem somet=
imes stops working when we stress it with bonnie++ tool.
> > >> We see the problem with mainstream 6.12 and 6.18 Kernels, our curren=
t guess from the debugging done so far is that
> > >> we run in kind of a concurrency      and/or scheduling issue were th=
e asynchron meta data space reclaiming is not executed on time,
> > >> and this leads to metadata space to not be free up on time for the n=
ew data. We can even see that adding a printk trace in a specific
> > >> point is covering the problem.
> > >
> > > Did your setup have multiple devices involved?
> > >
> > > If so there is a known bug that slightly unbalanced device size can
> > > trick btrfs into it can still over-commit metadata, but it can not in
> > > fact and error out at one of the critical path that we can not do
> > > anything but aborting the transaction.
> > >
> > >
> > > Although even without that specific quirk, it's still known that btrf=
s
> > > has some other problems related to metadata space reservation.
> > >
> > >>
> > >> To reproduce the problem, we run: "bonnie++ -d test/ -m BTRFS -u 0 -=
s 256M -r 128M -b"
> > >> Note that the tested partition is for sure not full we have 800MB sp=
ace there and we test with 256MB so it's not a space issue.
> > >
> > > Unfortunately it's too small for btrfs.
> > >
> > > Btrfs has the requirement to strictly split metadata and data space,
> > > thus it's possible to let unbalanced metadata and data chunk usage to
> > > exhaust one while the other has a lot of free space.
> > >
> > > You can consider it as the ext4/xfs inode number limits vs data space
> > > usage. One can exhaust all the available inodes way before exhausting
> > > the available data.
> > >
> > > It's just way worse in btrfs for smaller fses.
> > >
> > > [...]
> > >> [ 174.013001] BTRFS info (device mmcblk0p7 state A): space_info DATA=
 has 234418176 free, is not full
> > >> [ 174.022018] BTRFS info (device mmcblk0p7 state A): space_info tota=
l=3D255852544, used=3D21434368, pinned=3D0, reserved=3D0, may_use=3D0, read=
only=3D0 zone_unusable=3D0
> > >
> > > You have only 244MiB of data chunk, which is already tiny for btrfs.
> > > The worse part is, there is only 20MiB utilized
> > >
> > >> [ 174.035829] BTRFS info (device mmcblk0p7 state A): space_info META=
DATA has -5767168 free, is full
> > >> [ 174.044752] BTRFS info (device mmcblk0p7 state A): space_info tota=
l=3D53673984, used=3D1146880, pinned=3D52445184, reserved=3D16384, may_use=
=3D5767168, readonly=3D65536 zone_unusable=3D0
> > >
> > > Your metadata is tiny, only less than 52MiB (and will be doubled by t=
he
> > > default DUP profile for single dev setup).
> > >
> > > This means your fs is only around 350MiB?
> > >
> > > This is definitely not a good disk size for btrfs.
> > >
> > > My recommendation for any btrfs is at least 10GiB.
> > >
> > > This will allow btrfs to use 1Gib chunk stripe size (the max), so tha=
t
> > > we won't have those tiny metadata blocks, and greatly reduce the prob=
lem
> > > caused by unbalacned data/metadata.
> > >
> > >
> > > But still, flipping RO is not a good behavior, although in such small
> > > fs, you may have a better experience using mixed-bg feature, which wi=
ll
> > > let data and metadata share the same block groups, resolving the
> > > unbalance problem (but introducing more limits).
> > >
> > > Thanks,
> > > Qu
> > >
> > >> [ 174.060221] BTRFS info (device mmcblk0p7 state A): space_info SYST=
EM has 8355840 free, is not full
> > >> [ 174.069252] BTRFS info (device mmcblk0p7 state A): space_info tota=
l=3D8388608, used=3D16384, pinned=3D16384, reserved=3D0, may_use=3D0, reado=
nly=3D0 zone_unusable=3D0
> > >> [ 174.082979] BTRFS info (device mmcblk0p7 state A): global_block_rs=
v: size 5767168 reserved 5767168
> > >> [ 174.091989] BTRFS info (device mmcblk0p7 state A): trans_block_rsv=
: size 0 reserved 0
> > >> [ 174.099865] BTRFS info (device mmcblk0p7 state A): chunk_block_rsv=
: size 0 reserved 0
> > >> [ 174.107739] BTRFS info (device mmcblk0p7 state A): delayed_block_r=
sv: size 0 reserved 0
> > >> [ 174.115794] BTRFS info (device mmcblk0p7 state A): delayed_refs_rs=
v: size 0 reserved 0
> > >> [ 174.123787] BTRFS: error (device mmcblk0p7 state A) in cleanup_tra=
nsaction:2027: errno=3D-28 No space left
> > >> [ 174.133336] BTRFS info (device mmcblk0p7 state EA): forced readonl=
y
> > >> Can't sync file.
> > >> Cleaning up test directory after error.
> > >> Bonnie: drastic I/O error (rmdir): Read-only file system
> > >> ------------------------------------------------
> > >>
> > >> Trying to follow the "btrfs_add_bg_to_space_info" that is in "async_=
reclaim_work" context:
> > >> -------------------------------------------------
> > >> @@ -322,15 +322,21 @@ void btrfs_add_bg_to_space_info(struct btrfs_f=
s_info *info,
> > >>           struct btrfs_space_info *found;
> > >>           int factor, index;
> > >>
> > >>           factor =3D btrfs_bg_type_to_factor(block_group->flags);
> > >>
> > >>           found =3D btrfs_find_space_info(info, block_group->flags);
> > >>           ASSERT(found);
> > >>           spin_lock(&found->lock);
> > >> +       pr_info("%s(%d): %s %lld %lld\n", __func__, __LINE__, space_=
info_flag_to_str(found), found->total_bytes, block_group->length);
> > >> +       // OK: trigger twice free space is freed at second attempt.
> > >> +       // METADATA 53673984 6291456
> > >> +       // ..
> > >> +       // METADATA 59965440 117440512
> > >> +
> > >> +       // KO: triggered one, no space
> > >> +       // METADATA 53673984 6291456
> > >> +       // crash...
> > >> -------------------------------------------------
> > >>
> > >> Also maybe interesting to know is that trying to trace (printk) "btr=
fs_add_bg_to_space_info" influence the reproducibility.
> > >>
> > >> Any hints to resolve this problem are welcome.
> > >>
> > >> Regards,
> > >> Aleksandar
> > >>
> > >>
> > >>
> > >>
> > >> ********************************************************************=
**
> > >> DISCLAIMER:
> > >> Privileged and/or Confidential information may be contained in this =
message. If you are not the addressee of this message, you may not copy, us=
e or deliver this message to anyone. In such event, you should destroy the =
message and kindly notify the sender by reply e-mail. It is understood that=
 opinions or conclusions that do not relate to the official business of the=
 company are neither given nor endorsed by the company. Thank You.
> > >>
> > >
> > > *********************************************************************=
*
> > > DISCLAIMER:
> > > Privileged and/or Confidential information may be contained in this m=
essage. If you are not the addressee of this message, you may not copy, use=
 or deliver this message to anyone. In such event, you should destroy the m=
essage and kindly notify the sender by reply e-mail. It is understood that =
opinions or conclusions that do not relate to the official business of the =
company are neither given nor endorsed by the company. Thank You.
> > >
> >
> >
> > **********************************************************************
> > DISCLAIMER:
> > Privileged and/or Confidential information may be contained in this mes=
sage. If you are not the addressee of this message, you may not copy, use o=
r deliver this message to anyone. In such event, you should destroy the mes=
sage and kindly notify the sender by reply e-mail. It is understood that op=
inions or conclusions that do not relate to the official business of the co=
mpany are neither given nor endorsed by the company. Thank You.

