Return-Path: <linux-btrfs+bounces-20580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB3ED27A00
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 19:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD4363059459
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 18:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E583C0091;
	Thu, 15 Jan 2026 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTkqxTTn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34872D7D30
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501332; cv=none; b=Il5quxT/07kH2TPV0oQOweEs/xwV0/Gcyte4SLe5DRuZp4bsmhX0jswi9JTJVn1nim+BkqsTbhXh89l2ZT+OqfwNzZob/622GZcID8zGibFTKwbovXzj6EE0NLpkXt9dISO73J2TGbk1pKQuRxVwqHDgT3GMVNgZj4tMQkcJWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501332; c=relaxed/simple;
	bh=1cnJvM86J6ZtD0hbHWYgXyV/1EjumZkd5A95it/praY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgdkFcoiKq6bhCYY62hEVdApOpG5tvMKQzCze1OP0VZzntOpN/NaiejngoN0yrQ66xBZ3ypmzcufX1nFf0e2EXafgi1mEsDU7xU6mz9linuyXOxPETYI5QEBgZPHrfS6r/abX6kZuDjhlUkLjjXZoDKyLcz0RNK9dDGSdWbY6bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTkqxTTn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so1907066a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 10:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501328; x=1769106128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7IY8l2+i1WeuEXvkGd5lYKI5+uHV9G4YufUEOTseco=;
        b=QTkqxTTnzvBGx4dAggYvCIz9QKtD+mn9WdF+/1UHfRc4XCYx4DoMQjWMLmlXGPAnjN
         Dui67cs9p6RchjoT0BPMpncL4SdZJDJhoUJVAwND1teh2hjE1gCaYyAKfsk2bZJzykdQ
         L6uCN6Rg2rcRh3nMIwNe70A+QLQXP7yab/UPzxRFWqiQD4aYIOsD9+OT5oPW3ivMarE6
         XKDmVma2RYUKogkbJqhCmLLLgqkoAg/T6ZBkhjvezg7DgHhQ65OCiO8UtoczEsgALaXy
         KlKdAWINUFksbES/YE55UdY6vScaYcwKVvzv/Yl7J0d4wXr1PT0RX8gE4+l55V6+LYk/
         wmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501328; x=1769106128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7IY8l2+i1WeuEXvkGd5lYKI5+uHV9G4YufUEOTseco=;
        b=c98H+vG4LyUNgxkQBCcRG46qVhDF/9j9D/p47U5iciapH45XYbN4xt37/9UygsJPH6
         RdfCm7zZCJD6xZ7Bmy7S6RG0aJZOi4dVXv9q5is0Ix29i2dPfBREmuBh6wlqVH1Y8BYd
         V3p8dkaj/x6Hk1jacL9qDtZBC94Pq9vbo5U2CaFqZYmKc9Rf33GR6xGayibjAvC8ywPG
         WFgqWnqjiUOV0yIuztefw+VA5yQn5ngFT2Z16pDG9eDBdocSTl2PYWnnxA/J8NSJFejw
         bO6mlUmSBSMnwHmQ/Ye0YwVBqLfNuq9DnGU/keWLZxRYpVr8n0mDRmmbeWyg5uhTvWek
         dFfw==
X-Forwarded-Encrypted: i=1; AJvYcCUap7E9jb+9xxoREDuVVL0ZGZqc7OYldzQiPZvImsNt3G+BOp0oqKcUC264ekyXkVFoT/nA3JVIf+AwnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEXsTJpzHVzgPKiwOFHMQbuiA3npa8UrVeV5afPTqwDuKSXCr
	6bqn/0K7RAcHUgRZxZoY7E970wQA66DFO9g0ncsVczDKW10fSKjEeyvyJhmVOnwAzYFjqxt/+pw
	aypBRjRzpxQXfhbAmBp4CF8rnz6iwQ2k=
X-Gm-Gg: AY/fxX5I1lqxe6UInVsZOtXf/ue/j6IjFuVV5oFKRIHIW5b/o0QY+l2+D8PVHLxayeJ
	hqNCPQlaCefdpOaVsEem3Zm0sIZaRbvFN05fxcZwZfEWqYWzi+khKlGwL+onATLUNJiBnEfONcQ
	hWVTTUSSLLOaJ9uuNUCcrvyDnKbmn922gevLDd8dJ81khcC0j2Q9K0m5Matx5vIHyCuVVMv7Fbg
	Q6PpEc5EKnc9tUOditQKaVmD7+D80KhAqjlVwN/1KKop7c7ui11Gyo7JTOEMVzS9f0hpXiVFSfi
	oVQIvrNwCFsNiSAKoUiFcWSscrfCnw==
X-Received: by 2002:a05:6402:2812:b0:64b:3f56:55c9 with SMTP id
 4fb4d7f45d1cf-65452cca336mr319308a12.26.1768501327990; Thu, 15 Jan 2026
 10:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-16-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-16-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 19:21:56 +0100
X-Gm-Features: AZwV_Qjyapjv6JnFBHXmI5sSMthIqKsr1O8J34VK_oMMrDctP8UVkm6G-xvI8HQ
Message-ID: <CAOQ4uxhnxipJcjznEoa_D2R91NDZRgT_TTouGA4PGJO-7R9spw@mail.gmail.com>
Subject: Re: [PATCH 16/29] ovl: add EXPORT_OP_STABLE_HANDLES flag to export operations
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:49=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to overlayfs export operations to i=
ndicate
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/overlayfs/export.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb156749e65a4ea0ab708cbff338dacdad..17c92a228120e1803135cc2b4=
fe4180f5e343f88 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -865,9 +865,11 @@ const struct export_operations ovl_export_operations=
 =3D {
>         .fh_to_parent   =3D ovl_fh_to_parent,
>         .get_name       =3D ovl_get_name,
>         .get_parent     =3D ovl_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  /* encode_fh() encodes non-decodable file handles with nfs_export=3Doff =
*/
>  const struct export_operations ovl_export_fid_operations =3D {
>         .encode_fh      =3D ovl_encode_fh,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>

Actually, see comment above:
/* encode_fh() encodes non-decodable file handles with nfs_export=3Doff */

That's the variant of export_ops when overlayfs cannot be nfs exported
because its encoded file handles can change after copyup+reboot.

Thanks,
Amir.

