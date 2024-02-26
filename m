Return-Path: <linux-btrfs+bounces-2825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9FB868495
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 00:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4E41C21C1F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 23:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A9135A51;
	Mon, 26 Feb 2024 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdc9IXYW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E89130AC0
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708989952; cv=none; b=l4DH39Gx/nE+oxqHZ5EWGpq3QJ0bD43UVRaW/jiRQ40Frhn74ZnezsVUu64NKE/9s2fbYmdXwDS/vEEZz2fnGRLxV4fr4La/CAgMYuJi4hRsKkb2ksQTKETXcU65cw5UYz6v6ATlTvj8USJTOSgcybwrUJbIlfoy+GDSzBWICPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708989952; c=relaxed/simple;
	bh=yoz7FKK9VnXbpPLn6qbzLE+HSH4UTzO64Lj+qBCvNt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oui5Kqzd+zJSEqvW+g/CmCB77EZhrz2bMSrjoBKx+7kr1sO3sFFBE1Wm3KerlDN32m+SOXK7Zo4ocZO/d1uJH2vx9aOd9NBQ+iybkc8debXjLF0d7c6dQYSbd7r073RbdS3UKNS2ULfwaLPSh3dFul6yETFbx7dulUQkPeZMg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zdc9IXYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83B3C433C7
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708989951;
	bh=yoz7FKK9VnXbpPLn6qbzLE+HSH4UTzO64Lj+qBCvNt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zdc9IXYWFfPH66fRTJrUaJUVjx+g7XYl5OE40TRd8/MJ7s+/kXv0fmWhhus+3AL2v
	 gyhY6/Brm+yx9Bjadhx3IM7CFlCMXH9zlRxijL8bbIK79oEeDt2iIR62QFRhqP3BjV
	 OCvUVlL2QqNkM9xJkvzvedoXXGCu/lhAzb0zzG1V+EEgWEAEyr6zUA6dUGRhSdIrYC
	 O5gd38NGgl7l/2qFwgKGvfsHZ5HKI3VlBcJXbTJO19LPHDxfdtJtpYcLNeFyrc5SIa
	 jxSBm0HmWN8+KwI+dy6gE9EIvOhxHzLjQmbxuSTnjUuYor48or5X+gbUByqdT+iP9p
	 nvAsLgPnaaIiQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e706f50beso459639866b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 15:25:51 -0800 (PST)
X-Gm-Message-State: AOJu0YzXbAyduTZtdEKj8ychSySm4YBzm5Dw89kTU4X9gWk50Q9ksN3H
	ISpmXXOyN0DHN533JvlMLjzYuTpMifv2YNFuDUZmMNSYvWz5yhtBwkUHVR/KPKvycCNFojxGO1l
	EHMBcFBZkB5RN2+/G8yiHGmpeHXA=
X-Google-Smtp-Source: AGHT+IFoODxdwZdMI9EAqLW9B0PTTrFUWLR6hZBTIUKsL0ZyKNKGy7GJW2d/t4iu70jgUAmdQfq+u4iOhv/WKrLc/PE=
X-Received: by 2002:a17:906:48c9:b0:a43:3f37:4d88 with SMTP id
 d9-20020a17090648c900b00a433f374d88mr3411396ejt.71.1708989950168; Mon, 26 Feb
 2024 15:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b3c3fd6b5a6b9f9a7aa39cd343b233a11495bce.1708707655.git.fdmanana@suse.com>
 <20240226202610.GH17966@twin.jikos.cz>
In-Reply-To: <20240226202610.GH17966@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Feb 2024 23:25:13 +0000
X-Gmail-Original-Message-ID: <CAL3q7H70n7A7dOEKSfy4dWvroY-TFnjNLoM5VZu-_m9S8j4gUw@mail.gmail.com>
Message-ID: <CAL3q7H70n7A7dOEKSfy4dWvroY-TFnjNLoM5VZu-_m9S8j4gUw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix double free of anonymous device after snapshot
 creation failure
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:27=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Fri, Feb 23, 2024 at 05:03:19PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When creating a snapshot we may do a double free of an anonymous device
> > in case there's an error comitting the transaction. The second free may
> > result in freeing an anonymous device number that was allocated by some
> > other subsystem in the kernel or another btrfs filesystem.
> >
> > The steps that lead to this:
> >
> > 1) At ioctl.c:create_snapshot() we allocate an anonymous device number
> >    and assign it to pending_snapshot->anon_dev;
> >
> > 2) Then we call btrfs_commit_transaction() and end up at
> >    transaction.c:create_pending_snapshot();
> >
> > 3) There we call btrfs_get_new_fs_root() and pass it the anonymous devi=
ce
> >    number stored in pending_snapshot->anon_dev;
> >
> > 4) btrfs_get_new_fs_root() frees that anonymous device number because
> >    btrfs_lookup_fs_root() returned a root - someone else did a lookup
> >    of the new root already, which could some task doing backref walking=
;
> >
> > 5) After that some error happens in the transaction commit path, and at
> >    ioctl.c:create_snapshot() we jump to the 'fail' label, and after
> >    that we free again the same anonymous device number, which in the
> >    meanwhile may have been reallocated somewhere else, because
> >    pending_snapshot->anon_dev still has the same value as in step 1.
> >
> > Recently syzbot ran into this and reported the following trace:
> >
> >   ------------[ cut here ]------------
> >   ida_free called for id=3D51 which is not allocated.
> >   WARNING: CPU: 1 PID: 31038 at lib/idr.c:525 ida_free+0x370/0x420 lib/=
idr.c:525
> >   Modules linked in:
> >   CPU: 1 PID: 31038 Comm: syz-executor.2 Not tainted 6.8.0-rc4-syzkalle=
r-00410-gc02197fc9076 #0
> >   Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 01/25/2024
> >   RIP: 0010:ida_free+0x370/0x420 lib/idr.c:525
> >   Code: 10 42 80 3c 28 (...)
> >   RSP: 0018:ffffc90015a67300 EFLAGS: 00010246
> >   RAX: be5130472f5dd000 RBX: 0000000000000033 RCX: 0000000000040000
> >   RDX: ffffc90009a7a000 RSI: 000000000003ffff RDI: 0000000000040000
> >   RBP: ffffc90015a673f0 R08: ffffffff81577992 R09: 1ffff92002b4cdb4
> >   R10: dffffc0000000000 R11: fffff52002b4cdb5 R12: 0000000000000246
> >   R13: dffffc0000000000 R14: ffffffff8e256b80 R15: 0000000000000246
> >   FS:  00007fca3f4b46c0(0000) GS:ffff8880b9500000(0000) knlGS:000000000=
0000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 00007f167a17b978 CR3: 000000001ed26000 CR4: 0000000000350ef0
> >   Call Trace:
> >    <TASK>
> >    btrfs_get_root_ref+0xa48/0xaf0 fs/btrfs/disk-io.c:1346
> >    create_pending_snapshot+0xff2/0x2bc0 fs/btrfs/transaction.c:1837
> >    create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1931
> >    btrfs_commit_transaction+0xf1c/0x3740 fs/btrfs/transaction.c:2404
> >    create_snapshot+0x507/0x880 fs/btrfs/ioctl.c:848
> >    btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:998
> >    btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1044
> >    __btrfs_ioctl_snap_create+0x387/0x4b0 fs/btrfs/ioctl.c:1306
> >    btrfs_ioctl_snap_create_v2+0x1ca/0x400 fs/btrfs/ioctl.c:1393
> >    btrfs_ioctl+0xa74/0xd40
> >    vfs_ioctl fs/ioctl.c:51 [inline]
> >    __do_sys_ioctl fs/ioctl.c:871 [inline]
> >    __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:857
> >    do_syscall_64+0xfb/0x240
> >    entry_SYSCALL_64_after_hwframe+0x6f/0x77
> >   RIP: 0033:0x7fca3e67dda9
> >   Code: 28 00 00 00 (...)
> >   RSP: 002b:00007fca3f4b40c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
> >   RAX: ffffffffffffffda RBX: 00007fca3e7abf80 RCX: 00007fca3e67dda9
> >   RDX: 00000000200005c0 RSI: 0000000050009417 RDI: 0000000000000003
> >   RBP: 00007fca3e6ca47a R08: 0000000000000000 R09: 0000000000000000
> >   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >   R13: 000000000000000b R14: 00007fca3e7abf80 R15: 00007fff6bf95658
> >    </TASK>
> >
> > Where we get an explicit message where we attempt to free an anonymous
> > device number that is not currently allocated. It happens in a differen=
t
> > code path from the example below, at btrfs_get_root_ref(), so this chan=
ge
> > may not fix the case triggered by syzbot.
> >
> > To fix at least the code path from the example above, change
> > btrfs_get_root_ref() and its callers to receive a dev_t pointer argumen=
t
> > for the anonymous device number, so that in case it frees the number, i=
t
> > also resets it to 0, so that up in the call chain we don't attempt to d=
o
> > the double free.
> >
> > Link: https://lore.kernel.org/linux-btrfs/000000000000f673a1061202f630@=
google.com/
>
> The link is fine as one can go directly to the report, for the syzbot to
> auto-close the report I think it's most reliable to add
>
> Reported-by: syzbot+623a623cfed57f422be1@syzkaller.appspotmail.com

So I omitted that intentionally because, as I say in the changelog, I
don't think it's the same scenario as reported by syzbot.
There we attempt the double free in a different place from the scenario I f=
ound.

Since I mentioned that case, which I believe might be different, I
left only the Link tag and not the Reported-by.

>
> > Fixes: e03ee2fe873e ("btrfs: do not ASSERT() if the newly created subvo=
lume already got read")
>
> This has been backported up to 5.10 so we'll need
>
> CC: stable@vger.kernel.org # 5.10+
>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: David Sterba <dsterba@suse.com>

