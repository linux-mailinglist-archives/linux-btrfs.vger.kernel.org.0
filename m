Return-Path: <linux-btrfs+bounces-22030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBdiB5W8oGnrmAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22030-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 22:35:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857D1AFE27
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 22:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5773135EB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 21:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E31B27A10F;
	Thu, 26 Feb 2026 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmlEAB7d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99129BD80
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141458; cv=none; b=JH0kQj0V/0W3FDqOLt7YAaV7HSqdSRhP3elCzIhSFr7/W0VH5YvrtRul3JZc9ykDkZEF8WRcj3+78hC9dIOFy9oRPZCJ4bv0QZgxJ4cyZ7oJcrHPIZT8XHEGYq3HUCpDLvzXR1C1iMdJmnKcpXsZvKJjwfjXIGBjCyK8aeaupaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141458; c=relaxed/simple;
	bh=d7+DgNW3dT+Evc9CKoEe4vf01ifItfAdU0z4OQpzExc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhLK/SDrdjswLROQxifKjs1r6/998GnQyK5wKRyB3r2iWXHcvQyUqL0idlDEZiWxPVT2/4piGi83FI3CUZdfytrL/lO2vDKoe02xWzssEHfqWi+fNCfhzljy9THNyi0iobEonudk+ZvQI0N38y8W1cSyk82jXPmr6CNeDn/Kp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmlEAB7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01132C116C6
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 21:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772141458;
	bh=d7+DgNW3dT+Evc9CKoEe4vf01ifItfAdU0z4OQpzExc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TmlEAB7duXUpm5eh1kxTKZ7iuCGfL+61a3mEUrMnwZAfllHk3f9v+mYUvienQv8kH
	 EAQGgX3bbMib2Biy/Ip4JLG2Djq6AO+Q5PZKOEYhYAcXH1m9VfglmrT3hJNWH4yPCU
	 ju/+lzgXD4CAXeGn4ffSJePLE2lHWi+RBMlw6K8trD74Pk+jErjqGr1ZKXHhaC5Sb/
	 Ym2372+4Q9FAQx7vQK2ImMzb89HTmhbH/VHeXNEuMoIm1o0W2QdornnV5Btx5f6zQY
	 SxaBqWuQtZ5elZkdAufnJyZJvneaIOvuF9ijWGr8kpFXvLcu3vc9WpF3MqCutey1zt
	 NQvitDgs5tgjA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8d7f22d405so207633266b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 13:30:57 -0800 (PST)
X-Gm-Message-State: AOJu0Yw7UwxmJV1hlC4pnjda0gKCmmIcM2cWVzt+Ud5VVu2x6jz0oXpx
	onoESJHurA18q3wY2ekDeLBpfAMjBMtTIbxeO1Nugj7yjb73l59Y8a9UB0fo94o+ef+WVdVDOQ5
	r9I52PeYn9ENSOd8a8qVDEZY+vaOAAqE=
X-Received: by 2002:a17:907:3fa6:b0:b87:6b9c:6386 with SMTP id
 a640c23a62f3a-b93765a11cbmr22546666b.56.1772141456371; Thu, 26 Feb 2026
 13:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772105193.git.fdmanana@suse.com> <b99cee6ce652b926463a080ef052a2e8e37bff33.1772105193.git.fdmanana@suse.com>
 <3abf7b28-7404-4e1d-93e4-490e610655fd@gmx.com>
In-Reply-To: <3abf7b28-7404-4e1d-93e4-490e610655fd@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Feb 2026 21:30:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7DBqV+KE4QHi=Mv3=49Ep8v_J6CEXoZ2ZpJ5hb79ZpOQ@mail.gmail.com>
X-Gm-Features: AaiRm530NcjILrfzpnUABo1f2x7FN0lM5N6QG8Wh-SazGQBnWMr-8-rUjioJsNE
Message-ID: <CAL3q7H7DBqV+KE4QHi=Mv3=49Ep8v_J6CEXoZ2ZpJ5hb79ZpOQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: fix transaction abort when snapshotting
 received subvolumes
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22030-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email,qemu.org:url]
X-Rspamd-Queue-Id: 6857D1AFE27
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 8:40=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2026/2/27 01:03, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently a user can trigger a transaction abort by snapshotting a
> > previously received snapshot a bunch of times until we reach a
> > BTRFS_UUID_KEY_RECEIVED_SUBVOL item overflow (the maximum item size we
> > can store in a leaf). This is very likely not common in practice, but
> > if it happens, it turns the filesystem into RO mode. The snapshot, send
> > and set_received_subvol and subvol_setflags (used by receive) don't
> > require CAP_SYS_ADMIN, just inode_owner_or_capable(). A malicious user
> > could use this to turn a filesystem into RO mode and disrupt a system.
> >
> > Reproducer script:
> >
> >    $ cat test.sh
> >    #!/bin/bash
> >
> >    DEV=3D/dev/sdi
> >    MNT=3D/mnt/sdi
> >
> >    # Use smallest node size to make the test faster.
> >    mkfs.btrfs -f --nodesize 4K $DEV
> >    mount $DEV $MNT
> >
> >    # Create a subvolume and set it to RO so that it can be used for sen=
d.
> >    btrfs subvolume create $MNT/sv
> >    touch $MNT/sv/foo
> >    btrfs property set $MNT/sv ro true
> >
> >    # Send and receive the subvolume into snaps/sv.
> >    mkdir $MNT/snaps
> >    btrfs send $MNT/sv | btrfs receive $MNT/snaps
> >
> >    # Now snapshot the received subvolume, which has a received_uuid, a
> >    # lot of times to trigger the leaf overflow.
> >    total=3D500
> >    for ((i =3D 1; i <=3D $total; i++)); do
> >        echo -ne "\rCreating snapshot $i/$total"
> >        btrfs subvolume snapshot -r $MNT/snaps/sv $MNT/snaps/sv_$i > /de=
v/null
> >    done
> >    echo
> >
> >    umount $MNT
> >
> > When running the test:
> >
> >    $ ./test.sh
> >    (...)
> >    Create subvolume '/mnt/sdi/sv'
> >    At subvol /mnt/sdi/sv
> >    At subvol sv
> >    Creating snapshot 496/500ERROR: Could not create subvolume: Value to=
o large for defined data type
> >    Creating snapshot 497/500ERROR: Could not create subvolume: Read-onl=
y file system
> >    Creating snapshot 498/500ERROR: Could not create subvolume: Read-onl=
y file system
> >    Creating snapshot 499/500ERROR: Could not create subvolume: Read-onl=
y file system
> >    Creating snapshot 500/500ERROR: Could not create subvolume: Read-onl=
y file system
> >
> > And in dmesg/syslog:
> >
> >    $ dmesg
> >    (...)
> >    [251067.627338] BTRFS warning (device sdi): insert uuid item failed =
-75 (0x4628b21c4ac8d898, 0x2598bee2b1515c91) type 252!
> >    [251067.629212] ------------[ cut here ]------------
> >    [251067.630033] BTRFS: Transaction aborted (error -75)
> >    [251067.630871] WARNING: fs/btrfs/transaction.c:1907 at create_pendi=
ng_snapshot.cold+0x52/0x465 [btrfs], CPU#10: btrfs/615235
> >    [251067.632851] Modules linked in: btrfs dm_zero (...)
> >    [251067.644071] CPU: 10 UID: 0 PID: 615235 Comm: btrfs Tainted: G   =
     W           6.19.0-rc8-btrfs-next-225+ #1 PREEMPT(full)
> >    [251067.646165] Tainted: [W]=3DWARN
> >    [251067.646733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> >    [251067.648735] RIP: 0010:create_pending_snapshot.cold+0x55/0x465 [b=
trfs]
> >    [251067.649984] Code: f0 48 0f (...)
> >    [251067.653313] RSP: 0018:ffffce644908fae8 EFLAGS: 00010292
> >    [251067.653987] RAX: 00000000ffffff01 RBX: ffff8e5639e63a80 RCX: 000=
00000ffffffd3
> >    [251067.655042] RDX: ffff8e53faa76b00 RSI: 00000000ffffffb5 RDI: fff=
fffffc0919750
> >    [251067.656077] RBP: ffffce644908fbd8 R08: 0000000000000000 R09: fff=
fce644908f820
> >    [251067.657068] R10: ffff8e5adc1fffa8 R11: 0000000000000003 R12: fff=
f8e53c0431bd0
> >    [251067.658050] R13: ffff8e5414593600 R14: ffff8e55efafd000 R15: 000=
00000ffffffb5
> >    [251067.659019] FS:  00007f2a4944b3c0(0000) GS:ffff8e5b27dae000(0000=
) knlGS:0000000000000000
> >    [251067.660115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    [251067.660943] CR2: 00007ffc5aa57898 CR3: 00000005813a2003 CR4: 000=
0000000370ef0
> >    [251067.661972] Call Trace:
> >    [251067.662292]  <TASK>
> >    [251067.662653]  create_pending_snapshots+0x97/0xc0 [btrfs]
> >    [251067.663413]  btrfs_commit_transaction+0x26e/0xc00 [btrfs]
> >    [251067.664257]  ? btrfs_qgroup_convert_reserved_meta+0x35/0x390 [bt=
rfs]
> >    [251067.665238]  ? _raw_spin_unlock+0x15/0x30
> >    [251067.665837]  ? record_root_in_trans+0xa2/0xd0 [btrfs]
> >    [251067.666531]  btrfs_mksubvol+0x330/0x580 [btrfs]
> >    [251067.667145]  btrfs_mksnapshot+0x74/0xa0 [btrfs]
> >    [251067.667827]  __btrfs_ioctl_snap_create+0x194/0x1d0 [btrfs]
> >    [251067.668595]  btrfs_ioctl_snap_create_v2+0x107/0x130 [btrfs]
> >    [251067.669479]  btrfs_ioctl+0x1580/0x2690 [btrfs]
> >    [251067.670093]  ? count_memcg_events+0x6d/0x180
> >    [251067.670849]  ? handle_mm_fault+0x1a0/0x2a0
> >    [251067.671652]  __x64_sys_ioctl+0x92/0xe0
> >    [251067.672406]  do_syscall_64+0x50/0xf20
> >    [251067.673129]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >    [251067.674096] RIP: 0033:0x7f2a495648db
> >    [251067.674812] Code: 00 48 89 (...)
> >    [251067.678227] RSP: 002b:00007ffc5aa57840 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000010
> >    [251067.679691] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000=
07f2a495648db
> >    [251067.681145] RDX: 00007ffc5aa588b0 RSI: 0000000050009417 RDI: 000=
0000000000004
> >    [251067.682511] RBP: 0000000000000002 R08: 0000000000000000 R09: 000=
0000000000000
> >    [251067.683842] R10: 000000000000000a R11: 0000000000000246 R12: 000=
07ffc5aa59910
> >    [251067.685176] R13: 00007ffc5aa588b0 R14: 0000000000000004 R15: 000=
0000000000006
> >    [251067.686524]  </TASK>
> >    [251067.686972] ---[ end trace 0000000000000000 ]---
> >    [251067.687890] BTRFS: error (device sdi state A) in create_pending_=
snapshot:1907: errno=3D-75 unknown
> >    [251067.689049] BTRFS info (device sdi state EA): forced readonly
> >    [251067.689054] BTRFS warning (device sdi state EA): Skipping commit=
 of aborted transaction.
> >    [251067.690119] BTRFS: error (device sdi state EA) in cleanup_transa=
ction:2043: errno=3D-75 unknown
> >    [251067.702028] BTRFS info (device sdi state EA): last unmount of fi=
lesystem 46dc3975-30a2-4a69-a18f-418b859cccda
> >
> > Fix this by ignoring -EOVERFLOW errors from btrfs_uuid_tree_add() in th=
e
> > snapshot creation code when attempting to add the
> > BTRFS_UUID_KEY_RECEIVED_SUBVOL item. This is ok because it's not critic=
al
> > and we are still able to delete the snapshot, as snapshot/subvolume
> > deletion ignores if a BTRFS_UUID_KEY_RECEIVED_SUBVOL is missing (see
> > inode.c:btrfs_delete_subvolume()). As for send/receive, we can still do
> > send/receive operations since it always peeks the first root ID in the
> > existing BTRFS_UUID_KEY_RECEIVED_SUBVOL (it could peek any since all
> > snapshots have the same content), and even if the key is missing, it
> > fallsback to searching by BTRFS_UUID_KEY_SUBVOL key.
> >
> > A test case for fstests will be sent soon.
> >
> > Fixes: dd5f9615fc5c ("Btrfs: maintain subvolume items in the UUID tree"=
)
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/transaction.c | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> >
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 3112bd5520b7..1a0daf2c68fb 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -1902,6 +1902,22 @@ static noinline int create_pending_snapshot(stru=
ct btrfs_trans_handle *trans,
> >               ret =3D btrfs_uuid_tree_add(trans, new_root_item->receive=
d_uuid,
> >                                         BTRFS_UUID_KEY_RECEIVED_SUBVOL,
> >                                         objectid);
>
> I'm just checking all other btrfs_uuid_tree_add() callsites, and
> wondering if other call sites are also affected:
>
> - _btrfs_ioctl_set_received_subvol()
>
>    Would this be affected too?

Can be abused too, but that will require a different fix and out of
the scope of this patch.
And besides btrfs-prog's receive command, there are no wrappers for
the ioctl that I know of.
Will need to create a C program in fstests to craft a reproducer.

Thanks.

>
> Thanks,
> Qu
>
> > +             /*
> > +              * We are creating of lot of snapshots of the same root t=
hat was
> > +              * received (has a received UUID) and reached a leaf's li=
mit for
> > +              * an item. We can safefly ignore this and avoid a transa=
ction
> > +              * abort. A deletion of this snapshot will still work sin=
ce we
> > +              * ignore if an item with a BTRFS_UUID_KEY_RECEIVED_SUBVO=
L key
> > +              * is missing (see btrfs_delete_subvolume()). Send/receiv=
e will
> > +              * work too since it peeks the first root id from the exi=
sting
> > +              * item (it could peek any), and in case it's missing it
> > +              * falls back to search by BTRFS_UUID_KEY_SUBVOL keys.
> > +              * Creation of a snapshot does not require CAP_SYS_ADMIN,=
 so
> > +              * we don't want users triggering transaction aborts, eit=
her
> > +              * intentionally or not.
> > +              */
> > +             if (ret =3D=3D -EOVERFLOW)
> > +                     ret =3D 0;
> >               if (unlikely(ret && ret !=3D -EEXIST)) {
> >                       btrfs_abort_transaction(trans, ret);
> >                       goto fail;
>

