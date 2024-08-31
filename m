Return-Path: <linux-btrfs+bounces-7706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5A19670F9
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 12:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E251F22973
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 10:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F1217C7C1;
	Sat, 31 Aug 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swrVab4N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982354279;
	Sat, 31 Aug 2024 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725101791; cv=none; b=XE/w+obP3HUCIXbk7fC8Wsjq4z9UwZi2WwFOAmg8TCx0YW2raZFS7x1gimdJgrKnOhpcU45a5Mc0sgp2EXwxilgySN1efMaoUbjrzh3xHGsnbemYFpq7MS9wE4s1QSd7XFJNUuRVDvybTxAU3qAui3RGmzim41X1mH+DHIEDnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725101791; c=relaxed/simple;
	bh=eZGDBYMVexRHIcH994o+4ojxQhi7d011CzKVeC7HGc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQmU4OhsaUvaEGd/P9UaMmYtMHZI3bWgC8PCm61+3ThIuTUEENNKYtUYPSmmBiykRT2uibhSaV5A9K0F7Ts6pXGqAynaQY5wYbB8jIEHx+XJP6TvsYn+8PSf/66vXJE5lba9w9UDBHMSyiXmk3Q2ogqz9bmLL2sww3GymJqWhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swrVab4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EB6C4CEC8;
	Sat, 31 Aug 2024 10:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725101791;
	bh=eZGDBYMVexRHIcH994o+4ojxQhi7d011CzKVeC7HGc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=swrVab4NlDqQlVOZEpYw/OCgz7xvjtLAyOJhXL1nTUa1ZQU2KCRSm9FXJSATTA8H/
	 N5HsSoKNNZVCiMG+Ao/KDAWzKDk5/5mvrAt77UtypwZRIeKJC9ZUdnwFsJ/xUTNHfd
	 hEgKP6RxhcYV5B1GoNIVWCL+hzzb9K3PyvmvWom/tLpYSPsW1PkFkG/jZWFP9nz5jF
	 FG9VvGzvOCLyShK0KeP5eI6xLx8ec/MZDdPhakhOL870A1MencRydsa1DuUZ8tOC25
	 7Y+Wad6drGH1uL8O2xmKWsMmobr2dl0sWA4OtM3yHdX2IsjFZ4FTPmoBZ+jsACLTb7
	 0TP/v8wezciTA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a866cea40c4so299671566b.0;
        Sat, 31 Aug 2024 03:56:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXb4DSdj+12MUnbnuVGQOPxLWsGkqB2lIeOkmdCJMyOsBX/aLL1DcSZsTNQtelotBwlrTHW7q1rrvIWog==@vger.kernel.org, AJvYcCXep8nqASUhYmKOvZ/SQlNUEPlZxyvG0Uj3nfZwljlnSee3sIOYHZlpQSIynI0dkKuyuSaHDUopuxc0v/ug@vger.kernel.org
X-Gm-Message-State: AOJu0YynaLqaBdgoU0YiJSU3rvDO2vKsdx4eRXN5VKR0cQJIk5dLED00
	4uMMBEo07jU9iI79D58mgbxT6ACAvYEbGNUTWvw6CkFvRTYJ0Kx80XnrCQ+bU3x9jMs0EyaAliB
	3H3z2v4o4YX3PyQlXZhq0Hpr17eo=
X-Google-Smtp-Source: AGHT+IHJlZsip/+Ny0E3t9tMQN7th0liWZn7SYcTiIaIY07pp0aP0/3vZOUTcsKhZz1I1TUjxm13yX59HK+7wvEW+fA=
X-Received: by 2002:a17:907:971b:b0:a77:c364:c4f2 with SMTP id
 a640c23a62f3a-a897fa6a925mr629272166b.52.1725101789830; Sat, 31 Aug 2024
 03:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000044ff540620d7dee2@google.com> <20240831002222.2275740-1-lizhi.xu@windriver.com>
In-Reply-To: <20240831002222.2275740-1-lizhi.xu@windriver.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 31 Aug 2024 11:55:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5p4vmBs-ES08dkY7z4sjE_k3970CkJRAjiy0MhpXjYWw@mail.gmail.com>
Message-ID: <CAL3q7H5p4vmBs-ES08dkY7z4sjE_k3970CkJRAjiy0MhpXjYWw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Add assert or condition
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 1:36=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> When the value of fsync_skip_inode_lock is true, i_mmap_lock is used,
> so add it or condition in the ASSERT.
>
> Reported-and-tested-by: syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4704b3cc972bd76024f1
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/btrfs/ordered-data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 82a68394a89c..d0187e1fb941 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -1015,7 +1015,8 @@ void btrfs_get_ordered_extents_for_logging(struct b=
trfs_inode *inode,
>  {
>         struct rb_node *n;
>
> -       ASSERT(inode_is_locked(&inode->vfs_inode));
> +       ASSERT(inode_is_locked(&inode->vfs_inode) ||
> +              rwsem_is_locked(&inode->i_mmap_lock));

This definitely fixes the syzbot report, in the sense the assertion
won't fail anymore.
But it's wrong, very, very, very, very wrong.

The inode must be locked during the course of the fsync, that's why
the assertion is there.

Why do you think it's ok to not have the inode locked?
Have you done any analysis about that?

You mention "fsync_skip_inode_lock is true" in the changelog, but have
you checked where and why it's set to true?

Where we set it to true, at btrfs_direct_write(), there's a comment
which explains it's to avoid a deadlock on the inode lock at
btrfs_sync_file().

This is a perfect example of trying a patch not only without having
any idea how the code works but also being very lazy,
as there's a very explicit comment in the code about why the variable
is set to true, and even much more detailed in the
change log of the commit that introduced it.

And btw, there's already a patch to fix this issue:

https://lore.kernel.org/linux-btrfs/717029440fe379747b9548a9c91eb7801bc5a81=
3.1724972507.git.fdmanana@suse.com/

>
>         spin_lock_irq(&inode->ordered_tree_lock);
>         for (n =3D rb_first(&inode->ordered_tree); n; n =3D rb_next(n)) {
> --
> 2.43.0
>
>

