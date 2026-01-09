Return-Path: <linux-btrfs+bounces-20315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C27DD07324
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 06:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 961E23044C07
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 05:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115CA262D0B;
	Fri,  9 Jan 2026 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCNW4zBK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3022576E
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767936385; cv=none; b=Gep3ZA6CY+ASrSdG7AVTmhvlhnf31j0mJqmJ2UP4GKsCKTGsSdMV7GJJUrcJLYBZIB5BhD9/5a4DIlQtHtfUPGCk6y9nbjqE+2ImEy/tQhBZ+59yDr1H3O2WtDUxAryzz2MbzIqOkP0K5vtjkjNWeX2ZNdk9j+EYvBlZldjNoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767936385; c=relaxed/simple;
	bh=SMlm1Zj+VPtmhO+U2BlswVGk3VmIYNq8C/pi+eNGgFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvN749WA9semtUY8U8R4YqU8NjiT7yDIMhrNYsUQ73TgLN9iFPI+wBqJe91F5ahKtWsRmuFMPL2fGlykYV+JKdJoMbSwSNT2lHAhuHfV7hwrwOMv+gJWzKYL+RibdnO40aUrWRpdsdlZhM8okN5Im6oyKG7qVRK399xwzXq2DCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCNW4zBK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-382fea4a160so23998101fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 21:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767936380; x=1768541180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEF8CAf2dAOD+neWtLdI+w7NxCIZ2WohswMXxqPrdck=;
        b=FCNW4zBKvwe06rYcMueAfiJkXaVx77askqwvwX7CaEFH+6L3KlGJSk+bEnT7twnFlu
         P/yPNDuhFF9KldguIgfQJUEYrjzXBpzGr9ymhPd8+54KoK8cbP5kMcMedYnuV8Kj4agV
         DY0xjwrqP/6J413PUFdioqjbYLqYGCmxXPgnNCdMLjil7XqO5qmH5efBobLJT6gh3OGz
         VE+LNRMzj1W0betHwvCbJtPCcXjicJ4dWKL9ELgIHdLGNeHo8bGeEw3mOVIMRWPnhzPQ
         gBNuDOAwxH6WtvQg2uVaK+Xg7hl16AIP+FUkv3+pddWPJlc9FSeriHsKVG5oPAPuqF32
         hcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767936380; x=1768541180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EEF8CAf2dAOD+neWtLdI+w7NxCIZ2WohswMXxqPrdck=;
        b=IezCnP+k4+3/46KxY20dVZIlDdAGUlq2eCZpu4wdLSE93zgldGaPpJh9Px6eFHMvqr
         xFEOxuIAX3vFS9x4YIJi1eZyp5tpGWHM3QFQtcBc4zUUAPNy+AzlEhLsjnpxGtJ9e4hy
         kdp7ISTL8YXr/+xIUkH4UuQ7AiisLpAG+iP34w5LyGyBszyeFDRO4wXNRVx5hxI6Y+An
         p7wC13HQtx3mlKf1/2V1VYKx3aVl2AmL1lzGZ0chX8v1Oua/RZ5wWDgwhdQOm6OOgYiR
         6SsIJnhpjtHKVaAk49n3bwVMHeHCwgU2f9Iuyn7IlmtYw7mNfe/Q8Vx/B+Zrep7ZNVsx
         14vA==
X-Forwarded-Encrypted: i=1; AJvYcCV9J/EQpx+xevN8B0fnN3gzP8tQQgfIlbgk5Hn52hOIlAm5skuo3yNwnZshEYWj6X58E/yaLU52ReB8Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgvWQrUu4in0AMgiu3bBu8bdnJ3C3JYAB7zNqAqDglZfELbMI
	5jINzuCKAl2STWgE2ASDQdeWQ1rn0oL3MjSQaCJeXZ1pOFuXTi/On3llCV9t3uQIGoGBNO1CCxy
	kc6cx+PLVaJP1ev47cpb6K1iPl7akRIM=
X-Gm-Gg: AY/fxX7yGKUnpPqR2zM0Wh+Rj7MkT7zoqPxqm5ewUrGN4hTtg8J6rn2+llanfgiu0Dx
	DHYXBUboh/FUxkIIF+YjR6sC9jMXbk6qU2DjC34Z+X3Gb9aPy0YVP7Cdt60iezSiSrC+3UfoyoJ
	KnXSHA6QObCtFo8qnRI+r+VPb3Gv2+TCR9WR8u8Mn3E5NkPFXvMuB485rRexgx3Qr+NI7oSYrA7
	qDMjPzuBQgcbwuciJNKBECZZcrcLqmzbk3mjQcRqX6imbwVuXEossieSs6chQhiBHQmSd7o
X-Google-Smtp-Source: AGHT+IFacKbx/HloTRDyL3KNE+dISSFeSIeO5gnLVmi9ry+Gc3uB4ma+c7Q9oZoxnNZINjg1j054MzA1urN4ujLkRdE=
X-Received: by 2002:a05:651c:419b:b0:378:e3f9:2d26 with SMTP id
 38308e7fff4ca-382ff823bdamr21702801fa.39.1767936379607; Thu, 08 Jan 2026
 21:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org> <20260108-setlease-6-20-v1-13-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-13-ea4dec9b67fa@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 9 Jan 2026 14:26:03 +0900
X-Gm-Features: AQt7F2pmUKGJKWpVwxhIrI-U32G4ALuqYGKPCGsBpfUc51GGTfk1sxJMQ_5a6zs
Message-ID: <CAKFNMok9FG=hhzr8YrHYws5z3jTWOf2TXtFWvSfYbNy6+XLHxw@mail.gmail.com>
Subject: Re: [PATCH 13/24] nilfs2: add setlease file operation
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	gfs2@lists.linux.dev, linux-doc@vger.kernel.org, v9fs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:15=E2=80=AFAM Jeff Layton wrote:
>
> Add the setlease file_operation to nilfs_file_operations and
> nilfs_dir_operations, pointing to generic_setlease.  A future patch
> will change the default behavior to reject lease attempts with -EINVAL
> when there is no setlease file operation defined. Add generic_setlease
> to retain the ability to set leases on this filesystem.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good, Thanks!

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Ryusuke Konishi

> ---
>  fs/nilfs2/dir.c  | 3 ++-
>  fs/nilfs2/file.c | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
> index 6ca3d74be1e16d5bc577e2520f1e841287a2511f..b243199036dfa1ab2299efaaa=
5bdf5da2d159ff2 100644
> --- a/fs/nilfs2/dir.c
> +++ b/fs/nilfs2/dir.c
> @@ -30,6 +30,7 @@
>   */
>
>  #include <linux/pagemap.h>
> +#include <linux/filelock.h>
>  #include "nilfs.h"
>  #include "page.h"
>
> @@ -661,5 +662,5 @@ const struct file_operations nilfs_dir_operations =3D=
 {
>         .compat_ioctl   =3D nilfs_compat_ioctl,
>  #endif /* CONFIG_COMPAT */
>         .fsync          =3D nilfs_sync_file,
> -
> +       .setlease       =3D generic_setlease,
>  };
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index 1b8d754db44d44d25dcd13f008d266ec83c74d3f..f93b68c4877c5ed369e90b723=
517e117142335de 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/fs.h>
> +#include <linux/filelock.h>
>  #include <linux/mm.h>
>  #include <linux/writeback.h>
>  #include "nilfs.h"
> @@ -150,6 +151,7 @@ const struct file_operations nilfs_file_operations =
=3D {
>         .fsync          =3D nilfs_sync_file,
>         .splice_read    =3D filemap_splice_read,
>         .splice_write   =3D iter_file_splice_write,
> +       .setlease       =3D generic_setlease,
>  };
>
>  const struct inode_operations nilfs_file_inode_operations =3D {
>
> --
> 2.52.0
>

