Return-Path: <linux-btrfs+bounces-5509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02338FF589
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 21:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A371C25B42
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815071749;
	Thu,  6 Jun 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFaLP8CD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A46FE21
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703830; cv=none; b=eoHQ+mJ9ZKrKfP8LiRFkSMTjFd2WDT8Cta946qPPqifWajhxWp5JyAUvwJ57jg057U4IjOUv/UaLeG06MkCugp3uY+GwNIBrd6VV0PQGItitAgV9OGb6Ju09bqKbMNHkhRj1wBh+vYEq+VJ2IOYbdZC/nPywQbdro9CkWuaKLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703830; c=relaxed/simple;
	bh=fCUVHlbP5aWXm4r60FR2GcXNrO1io7FhL5XbkGNSfKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lABSCeCs26nj/INoV31o3fpQjJu/UxUjZktWlka6KSj46uNxXSJvWC3bnXXDX59a2pGnXojWL7KTvVgtOqSWvPb4SReqsWes9PCT81NJGhj1onEYzQYRDzQ7tU8SDqtBk/zvCCAwbdTkUY2nrVFTSbdZexqFbnJ4Q7Sin4cpuAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFaLP8CD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110E8C32786
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 19:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717703830;
	bh=fCUVHlbP5aWXm4r60FR2GcXNrO1io7FhL5XbkGNSfKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GFaLP8CDY69cWQ79HsugR6vYknWIhvulg/z9pMcI+XRKdSerYO8OMDw+54DiIqU0F
	 rJl0ZIEj5POgVk/Sb49f8D8MBw2h21IwzMPEG9tEN9xfDLiaWHyOmmrm72Tf7zY6yI
	 CfDdoD8HBMQ+OlP3bHdx/Tk/ykpm3gom50iGLU7jCu0haT+jVK4ftSsTB9lAVjc8YQ
	 bTSH/jESYlxlxrEBtTZ/tZF55vJjhuYOGpdva0TJyTc3CpHsUOSCIyLB226r6XQt+K
	 ojFkQqfTxOGbMAly4MPGF8lG/GjqdToFhq5vatyJ5tKYcjHItcoo0x/kAxEnmpJGaa
	 HLDs3j6bFhsaA==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a080a171dso13958777b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 12:57:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy5cuB1EZiFsl/2v7z0V38bodXQkRSPGfK2BO4JlOCbMosw3GPA
	JSLalwFHg8Lw95ibDOKeMSC4HQLEvVq8inTqSisD8CLOk6rQeC621pR0MyXX01fp4yOdT2RP7+t
	fRYFosQhhrZSvxe3uENVUpbR6QX4=
X-Google-Smtp-Source: AGHT+IHlfBaIhI0C5glix+ly5aZhd6S/nldPffooEABnSdqWzjXvceCBNXnkzstgGGep0ojDw69kVmISUmFHtEWmBJc=
X-Received: by 2002:a81:4e0b:0:b0:61a:ccb0:7cdd with SMTP id
 00721157ae682-62cd56a9fd0mr3418287b3.46.1717703829201; Thu, 06 Jun 2024
 12:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <292b2e90e9a64cd3156b0545f6e62b253ea17b9e.1717662443.git.fdmanana@suse.com>
 <20240606190633.GA11027@zen.localdomain>
In-Reply-To: <20240606190633.GA11027@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 6 Jun 2024 20:56:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6JQG510-c3YZUBpAra8kww1bi3_yqH+NbbFJCAvG84sA@mail.gmail.com>
Message-ID: <CAL3q7H6JQG510-c3YZUBpAra8kww1bi3_yqH+NbbFJCAvG84sA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove pointless code when creating and deleting a subvolume
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 8:06=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Jun 06, 2024 at 09:30:07AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When creating and deleting a subvolume, after starting a transaction we
> > are explicitly calling btrfs_record_root_in_trans() for the root which =
we
> > passed to btrfs_start_transaction(). This is pointless because at
> > transaction.c:start_transaction() we end up doing that call, regardless
> > of whether we actually start a new transaction or join an existing one,
> > and if we were not it would mean the root item of that root would not
> > be updated in the root tree when committing the transaction, leading to
> > problems easy to spot with fstests for example.
> >
> > Remove these redundant calls. They were introduced with commit
> > 74e97958121a ("btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume
> > operations").
>
> Re-reading it now, I agree that start_transaction will ensure what we nee=
d,
> and if it fails we go to paths that result in freeing the reserved space
> here in the subvolume code.
>
> With that said, I spent like two weeks on this battling generic/269 so
> there might be something subtle that I'm forgetting and didn't explain
> well enough in the patch. Reading it now, I do think it's most likely
> that the fixes to the release path were sufficient to fix the bug.

I think it's obvious these calls are redundant.
Things would be seriously broken if start_transaction() didn't call
btrfs_record_root_in_trans().

>
> Just to be safe, can you run generic/269 with squotas turned on via mkfs
> ~10 times? It usually reproduced for me in 5-10 runs, so if it's not too
> much bother, maybe 20 to be really safe.

I tried that, yes, but the test sometimes fails qgroup cleanups with
-ENOSPC, both before and after this patch.
The failure is reported as a warning message in dmesg, it doesn't make
the test case fail:

[99872.487855] run fstests generic/269 at 2024-06-06 20:53:33
[99872.771632] BTRFS: device fsid 7a9e9120-5656-486a-8ea2-e0f7e12648b7
devid 1 transid 10 /dev/sdc (8:32) scanned by mount (2754727)
[99872.772502] BTRFS info (device sdc): first mount of filesystem
7a9e9120-5656-486a-8ea2-e0f7e12648b7
[99872.772515] BTRFS info (device sdc): using crc32c (crc32c-intel)
checksum algorithm
[99872.772519] BTRFS info (device sdc): using free-space-tree
[99872.774615] BTRFS info (device sdc): checking UUID tree
[99877.835179] btrfs_drop_snapshot: 10 callbacks suppressed
[99877.835191] BTRFS warning (device sdc): failed to cleanup qgroup 0/342: =
-28
[99901.986789] BTRFS info (device sdc): last unmount of filesystem
7a9e9120-5656-486a-8ea2-e0f7e12648b7
[99902.004561] BTRFS info (device sda): last unmount of filesystem
4dea6050-7fd2-4823-a0c6-23a321b9f183

If that's what the commit tried to fix, then it wasn't not enough or
some change after it introduced a regression.

Thanks.

>
> Thanks,
> Boris
>
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/inode.c | 5 -----
> >  fs/btrfs/ioctl.c | 3 ---
> >  2 files changed, 8 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 0610b9fa6fae..ddf96c4cc858 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -4552,11 +4552,6 @@ int btrfs_delete_subvolume(struct btrfs_inode *d=
ir, struct dentry *dentry)
> >               ret =3D PTR_ERR(trans);
> >               goto out_release;
> >       }
> > -     ret =3D btrfs_record_root_in_trans(trans, root);
> > -     if (ret) {
> > -             btrfs_abort_transaction(trans, ret);
> > -             goto out_end_trans;
> > -     }
> >       btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
> >       qgroup_reserved =3D 0;
> >       trans->block_rsv =3D &block_rsv;
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 5e3cb0210869..d00d49338ecb 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -658,9 +658,6 @@ static noinline int create_subvol(struct mnt_idmap =
*idmap,
> >               ret =3D PTR_ERR(trans);
> >               goto out_release_rsv;
> >       }
> > -     ret =3D btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
> > -     if (ret)
> > -             goto out;
> >       btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
> >       qgroup_reserved =3D 0;
> >       trans->block_rsv =3D &block_rsv;
> > --
> > 2.43.0
> >

