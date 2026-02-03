Return-Path: <linux-btrfs+bounces-21336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM67N9pvgmlkUAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21336-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 22:59:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B037DF0DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 22:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 735A2303ABCB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 21:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267238886D;
	Tue,  3 Feb 2026 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ3Oeriq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96E38887A
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155231; cv=none; b=P44KD0ZX5bK0YO+qztM9b5LSvAGbN3k31DgBLKev/FsTm4xuMNPN/zEjfrKtnIHvTDWQaTbJSlCR2xQ5HFIOqnEUMeCMOeuz7SwHAjbjYjD8qD8eqJmdM2sJznzLgRYAKGEOaa6R+ty4TKfLhRpD83ovkZ8A2gkqz9602w3Upfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155231; c=relaxed/simple;
	bh=/0W9Ysl8fi09j3Uj4wkBkI/z5RW4bWTyfRnCrQ4LJIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adN6y5ogu0hw1vBKB2Sha41e8yryS5qJhxJDIGj9Mu0eAXX8UO0ZUlt/ODwIMsaFHLut86LrwJ103qJcoNUlhSA8EICcLPM8WdwSD9j8d9b9Ut+6BmiCImbhG9zwpckueYXFnT0tWp6UyhUqHYH9uaL4MUskg3WWefuL9DCSF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ3Oeriq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8580BC19425
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 21:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770155230;
	bh=/0W9Ysl8fi09j3Uj4wkBkI/z5RW4bWTyfRnCrQ4LJIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cQ3OeriqIEbJ6bbo/l5/TMQZJnKawQOKv9XapMlRwfFsdJ+D/EbzkyikbMh97hXzk
	 8YBYbrVfSTegkwUMztEycYVtffBrAL87pQl8Jp8y42EL16DGn6QL10nwuLuqukuYbx
	 B8TGdu6q5/Kx0UO+hmSF9JpWLwRRXXLy+idbWyCE1BjwdPqppPvh32+lWPCsZQpixw
	 iM7+tMP9p4kN1euyWJ6AigsuvDL2oNb8BAzXodU4O3pHVt3jZDs67xL3oAN20LYeDk
	 zLBfR8WlB8EasvE8rjrvyA/wepmb7EyOlKCA4X4Ki6d7NwFA06saJzYbJd3Vlu+pH3
	 KhzJPSMy4G2Gw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b885e8c6700so1001133466b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 13:47:10 -0800 (PST)
X-Gm-Message-State: AOJu0Ywxwq0jO6n82Ino9MjOqZv96eZvxc+cUb3/5F4Psc3jKFxrCFjw
	6ZOckjDbsfGuP2JvEiI20HZ2P1rRuiTxZtD9BoPPM5cZ98T8i31m2nMkXMf/uhtCyYZ3kkgbDFS
	nRk4euurucYpG3hAHOAIztSjwzaJ9JYQ=
X-Received: by 2002:a17:906:fe48:b0:b88:5957:2d65 with SMTP id
 a640c23a62f3a-b8e9f39674fmr59871566b.37.1770155228995; Tue, 03 Feb 2026
 13:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770123544.git.fdmanana@suse.com> <213736b4ab22e6ecdd6a10513eaed5d85b4053bc.1770123545.git.fdmanana@suse.com>
 <a3b63027-9e17-41b3-bc7f-477d1e59381a@suse.com>
In-Reply-To: <a3b63027-9e17-41b3-bc7f-477d1e59381a@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Feb 2026 21:46:30 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5_Q=na-W+uPm88yWAtPxYFd_t3kP1WK-9YhnFMr8uoZA@mail.gmail.com>
X-Gm-Features: AZwV_Qg3Q0TylrdTNzpRpy2H-6u5q-yK3-bt4pRTv-Q5eliH1wT6tQXnBblJQHQ
Message-ID: <CAL3q7H5_Q=na-W+uPm88yWAtPxYFd_t3kP1WK-9YhnFMr8uoZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: be less agressive with metadata overcommit
 when we can do full flushing
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21336-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,belden.com:email,qemu.org:url,test.sh:url]
X-Rspamd-Queue-Id: 0B037DF0DD
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 9:02=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2026/2/3 23:32, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Over the years we often get reports of some -ENOSPC failure while updat=
ing
> > metadata that leads to a transaction abort. I have seen this happen for
> > filesystems of all sizes and with workloads that are very user/customer
> > specific and unable to reproduce, but Aleksandar recently reported a
> > simple way to reproduce this with a 1G filesystem and using the bonnie+=
+
> > benchmark tool. The following test script reproduces the failure:
> >
> >      $ cat test.sh
> >      #!/bin/bash
> >
> >      # Create and use a 1G null block device, memory backed, otherwise
> >      # the test takes a very long time.
> >      modprobe null_blk nr_devices=3D"0"
> >      null_dev=3D"/sys/kernel/config/nullb/nullb0"
> >      mkdir "$null_dev"
> >      size=3D$((1 * 1024)) # in MB
> >      echo 2 > "$null_dev/submit_queues"
> >      echo "$size" > "$null_dev/size"
> >      echo 1 > "$null_dev/memory_backed"
> >      echo 1 > "$null_dev/discard"
> >      echo 1 > "$null_dev/power"
> >
> >      DEV=3D/dev/nullb0
> >      MNT=3D/mnt/nullb0
> >
> >      mkfs.btrfs -f $DEV
> >      mount $DEV $MNT
> >
> >      mkdir $MNT/test/
> >      bonnie++ -d $MNT/test/ -m BTRFS -u 0 -s 256M -r 128M -b
> >
> >      umount $MNT
> >
> >      echo 0 > "$null_dev/power"
> >      rmdir "$null_dev"
> >
> > When running this bonnie++ fails in the phase where it deletes test
> > directories and files:
> >
> >      $ ./test.sh
> >      (...)
> >      Using uid:0, gid:0.
> >      Writing a byte at a time...done
> >      Writing intelligently...done
> >      Rewriting...done
> >      Reading a byte at a time...done
> >      Reading intelligently...done
> >      start 'em...done...done...done...done...done...
> >      Create files in sequential order...done.
> >      Stat files in sequential order...done.
> >      Delete files in sequential order...done.
> >      Create files in random order...done.
> >      Stat files in random order...done.
> >      Delete files in random order...Can't sync directory, turning off d=
ir-sync.
> >      Can't delete file 9Bq7sr0000000338
> >      Cleaning up test directory after error.
> >      Bonnie: drastic I/O error (rmdir): Read-only file system
> >
> > And in the syslog/dmesg we can see the following transaction abort trac=
e:
> >
> >      [161915.501506] BTRFS warning (device nullb0): Skipping commit of =
aborted transaction.
> >      [161915.502983] ------------[ cut here ]------------
> >      [161915.503832] BTRFS: Transaction aborted (error -28)
> >      [161915.504748] WARNING: fs/btrfs/transaction.c:2045 at btrfs_comm=
it_transaction+0xa21/0xd30 [btrfs], CPU#11: bonnie++/3377975
> >      [161915.506786] Modules linked in: btrfs dm_zero dm_snapshot (...)
> >      [161915.518759] CPU: 11 UID: 0 PID: 3377975 Comm: bonnie++ Tainted=
: G        W           6.19.0-rc7-btrfs-next-224+ #4 PREEMPT(full)
> >      [161915.520857] Tainted: [W]=3DWARN
> >      [161915.521405] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> >      [161915.523414] RIP: 0010:btrfs_commit_transaction+0xa24/0xd30 [bt=
rfs]
> >      [161915.524630] Code: 48 8b 7c 24 (...)
> >      [161915.526982] RSP: 0018:ffffd3fe8206fda8 EFLAGS: 00010292
> >      [161915.527707] RAX: 0000000000000002 RBX: ffff8f4886d3c000 RCX: 0=
000000000000000
> >      [161915.528723] RDX: 0000000002040001 RSI: 00000000ffffffe4 RDI: f=
fffffffc088f780
> >      [161915.529691] RBP: ffff8f4f5adae7e0 R08: 0000000000000000 R09: f=
fffd3fe8206fb90
> >      [161915.530842] R10: ffff8f4f9c1fffa8 R11: 0000000000000003 R12: 0=
0000000ffffffe4
> >      [161915.532027] R13: ffff8f4ef2cf2400 R14: ffff8f4f5adae708 R15: f=
fff8f4f62d18000
> >      [161915.533229] FS:  00007ff93112a780(0000) GS:ffff8f4ff63ee000(00=
00) knlGS:0000000000000000
> >      [161915.534611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >      [161915.535575] CR2: 00005571b3072000 CR3: 0000000176080005 CR4: 0=
000000000370ef0
> >      [161915.536758] Call Trace:
> >      [161915.537185]  <TASK>
> >      [161915.537575]  btrfs_sync_file+0x431/0x530 [btrfs]
> >      [161915.538473]  do_fsync+0x39/0x80
> >      [161915.539042]  __x64_sys_fsync+0xf/0x20
> >      [161915.539750]  do_syscall_64+0x50/0xf20
> >      [161915.540396]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >      [161915.541301] RIP: 0033:0x7ff930ca49ee
> >      [161915.541904] Code: 08 0f 85 f5 (...)
> >      [161915.544830] RSP: 002b:00007ffd94291f38 EFLAGS: 00000246 ORIG_R=
AX: 000000000000004a
> >      [161915.546152] RAX: ffffffffffffffda RBX: 00007ff93112a780 RCX: 0=
0007ff930ca49ee
> >      [161915.547263] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0=
000000000000003
> >      [161915.548383] RBP: 0000000000000dab R08: 0000000000000000 R09: 0=
000000000000000
> >      [161915.549853] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
0007ffd94291fb0
> >      [161915.551196] R13: 00007ffd94292350 R14: 0000000000000001 R15: 0=
0007ffd94292340
> >      [161915.552161]  </TASK>
> >      [161915.552457] ---[ end trace 0000000000000000 ]---
> >      [161915.553232] BTRFS info (device nullb0 state A): dumping space =
info:
> >      [161915.553236] BTRFS info (device nullb0 state A): space_info DAT=
A (sub-group id 0) has 12582912 free, is not full
> >      [161915.553239] BTRFS info (device nullb0 state A): space_info tot=
al=3D12582912, used=3D0, pinned=3D0, reserved=3D0, may_use=3D0, readonly=3D=
0 zone_unusable=3D0
> >      [161915.553243] BTRFS info (device nullb0 state A): space_info MET=
ADATA (sub-group id 0) has -5767168 free, is full
> >      [161915.553245] BTRFS info (device nullb0 state A): space_info tot=
al=3D53673984, used=3D6635520, pinned=3D46956544, reserved=3D16384, may_use=
=3D5767168, readonly=3D65536 zone_unusable=3D0
> >      [161915.553251] BTRFS info (device nullb0 state A): space_info SYS=
TEM (sub-group id 0) has 8355840 free, is not full
> >      [161915.553254] BTRFS info (device nullb0 state A): space_info tot=
al=3D8388608, used=3D16384, pinned=3D16384, reserved=3D0, may_use=3D0, read=
only=3D0 zone_unusable=3D0
> >      [161915.553257] BTRFS info (device nullb0 state A): global_block_r=
sv: size 5767168 reserved 5767168
> >      [161915.553261] BTRFS info (device nullb0 state A): trans_block_rs=
v: size 0 reserved 0
> >      [161915.553263] BTRFS info (device nullb0 state A): chunk_block_rs=
v: size 0 reserved 0
> >      [161915.553265] BTRFS info (device nullb0 state A): remap_block_rs=
v: size 0 reserved 0
> >      [161915.553268] BTRFS info (device nullb0 state A): delayed_block_=
rsv: size 0 reserved 0
> >      [161915.553270] BTRFS info (device nullb0 state A): delayed_refs_r=
sv: size 0 reserved 0
> >      [161915.553272] BTRFS: error (device nullb0 state A) in cleanup_tr=
ansaction:2045: errno=3D-28 No space left
> >      [161915.554463] BTRFS info (device nullb0 state EA): forced readon=
ly
> >
> > The problem is that we allow for a very agressive metadata overcommit,
> > about 1/8th of the currently available space, even when the task
> > attempting the reservation allows for full flushing. Over time this all=
ows
> > more and more tasks to overcommit without getting a transaction commit =
to
> > release pinned extents, joining the same transaction and eventually lea=
d
> > to the transaction abort when attempting some tree update, as the exten=
t
> > allocator is not able to find any available metadata extent and it's no=
t
> > able to allocate a new metadata block group either (not enough unalloca=
ted
> > space for that).
>
> I'm a little curious about why we are unable to allocate a metadata bg.
>
> Both the original report and your backtrace only shows a very small
> data/metadata/sys space info.
>
> Data is only 12M, metadata is around 52MiB, system is 8MiB, even with
> DUP for metadata and system, they are still very tiny.
> (Add up to less than 128MiB, vs 1GiB of the device size)
>
>
> Thus I'm wondering if it's some other reason, like at certain locations
> we're not allowed to allocate new bgs?

We can allocate when we attempt to allocate a metadata extent.
However here it fails because we really have no space:

at calc_available_free_space() we subtract the data chunk size, and
that leaves us at around 300M, which is not enough to allocate a
metadata chunk in DUP profile (256M * 2 =3D 512M).

>
> Thanks,
> Qu
>
> >
> > Fix this by allowing the overcommit to be up to 1/64th of the available
> > (unallocated) space instead and for that limit to apply to both types o=
f
> > full flushing, BTRFS_RESERVE_FLUSH_ALL and BTRFS_RESERVE_FLUSH_ALL_STEA=
L.
> > This way we get more frequent transaction commits to release pinned
> > extents in case our caller is in a context where full flushing is allow=
ed.
> >
> > Reported-by: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.co=
m>
> > Link: https://lore.kernel.org/linux-btrfs/SA1PR18MB56922F690C5EC2D85371=
408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/space-info.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index bb5aac7ee9d2..8192edf92d26 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -489,10 +489,11 @@ static u64 calc_available_free_space(const struct=
 btrfs_space_info *space_info,
> >       /*
> >        * If we aren't flushing all things, let us overcommit up to
> >        * 1/2th of the space. If we can flush, don't let us overcommit
> > -      * too much, let it overcommit up to 1/8 of the space.
> > +      * too much, let it overcommit up to 1/64th of the space.
> >        */
> > -     if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL)
> > -             avail >>=3D 3;
> > +     if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL ||
> > +         flush =3D=3D BTRFS_RESERVE_FLUSH_ALL_STEAL)
> > +             avail >>=3D 6;
> >       else
> >               avail >>=3D 1;
> >
>

