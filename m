Return-Path: <linux-btrfs+bounces-20737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5C3D3B2BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26DAE31191F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD783A785B;
	Mon, 19 Jan 2026 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkkHIwzb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420E3A782A
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841017; cv=none; b=qB8EBtj8X3SNV/d98LhkIf7dL0DymfCiX5emqSd0gNawRMzh1JO0DgzR7on80fhyVhAzUBqYz2a3Vpo6GRZbxsjdil6NE+z0f1GPrXhbHoSgvGc6Qsba9Sb7SCXU+PzV/yIx73dowhSAcPtTHtmcZ2ZYCfC9y4Avgnf7KaKUm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841017; c=relaxed/simple;
	bh=CQ3IL8fqKnWIgvRv+IOv0Cfz8J1ZjzxNV5oCIJJcLY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Udpbg5Esb1pm4RoFn5bykhcDVwvTZPbm5JhA6SbjCI7xn+umHWr7h2Yy04RYUoH1Lt1kofASB2clZppkf/EJKWXyCLmFY5D5GeLn/zb1QmBbhFk2Z3F9S39ZFRtBoT6kBpqJVtjS37QFYffby/x2splJG+wXQRuZqXnJflKSuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkkHIwzb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so7600358a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768841012; x=1769445812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7xapJC59KqqTTsHRvPEloTsuOjJhUfycEcUpCAL4U8=;
        b=EkkHIwzbfTJKzshmxlDOiaxtn4vBhGJ8hV4EprnGWkmuC/r1b41pPCDsLJyiC5AW5r
         CLWhGZucaUydM6cEu+YJNQ5errSDWpQMGa4luhsuFC6Ded7q3E2uHG5piLmTpyaABJ5c
         MeVpTUfm05SLfpHgXfRlKQ6y5fwlEypURJCR9owfvjJtiQLYKgBpQhhUqOBuqI4ZbVP9
         AlKzmFKgcTyQq1tExcoY8jyWZQuleBSdMijvUXJCRjmQgiKX6YuNKehKm76YncoVewKJ
         tTFHR0K6sL38se/gLII2739FwexAo8CVaidTZSlCOXo9zz3u6rXjjqqsloC6fgpkPenc
         uVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841012; x=1769445812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7xapJC59KqqTTsHRvPEloTsuOjJhUfycEcUpCAL4U8=;
        b=X1dhqRQETvnTo6qq4eFGfPIwEKVJwZPdNEjlY8gFm8jHxWmneuBn4WPFVZk63+KQG+
         jU+eLhFgBxneNtMkaJ+NjVYWLc/OCZKG6kKk8dEx4rN30wMEKWGhs62HIJNDvMIwz7ph
         JNqScYrSLjDHlo64By14AJi4l4c4H5nPmt74xk5Mvv68tCLMiijnqg2cAW8bCyQCDVTb
         dKo9HR7MkVFzYez8dx4+SzO+dVnOuSf5+S9Qts/iGYQvVNIPLn1CLOZf4WIL0qOjo2dy
         UGpwA7C+4+9zOLCQv46HhZSrzoHEoa5732aV7P00YUqc9oalDOVo6xDfy38r5jZomG/u
         KAHw==
X-Forwarded-Encrypted: i=1; AJvYcCWn0FArecpLk3tagwFfehaQQCm4FjuCocAoR4QhgQxVs9i+jK7yYgRmUrtLHF/loUS/NZKjpwhL6q8ybg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+MqRAXJxvLl4sQihf5bxTzhQ75pcxWP0wilIrcKRJV/vu7pD
	t+9MwhFPys4vvwTTKF4aHXHIOXpc/c0SZA5EOMST4R2Mm17zAmy4SpRXM4Y8vy624qK3tV6bUj2
	YKlfT3WRn3FALDKyvwMLDsjrQEX0eMZ0=
X-Gm-Gg: AZuq6aJjiuyrb+NPHsph8fqnRaACKB0jiReRDfISuQsc1HZVFfkl2N4gXqbLsAPante
	0DT8OxRZkbVBu2bKF1AKP5PcSytyRBEgdsJ10pBwRhM+EWjlhfNyQdizZpI6wnTUDC4OH5t5dZI
	wr32fpxSfkgTp24La1IXpct8lr+HVmoo0WjevxbGpvVSOSjEa8w9tgphzcn5xeagzzVKqqwyLHk
	KvkxJZ1FcYW/UGpXI6OiZtbtb+R4OMnLikqFXlJNn7XR+3R0h0gzND4EMBdY3GIV2tcvyLuDl52
	pJUd63l29C6r+YxVcembVMxJxTXvkjzv6DLIqFcE
X-Received: by 2002:a05:6402:5106:b0:64c:584c:556c with SMTP id
 4fb4d7f45d1cf-654bb6192admr8530585a12.30.1768841011353; Mon, 19 Jan 2026
 08:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:43:19 +0100
X-Gm-Features: AZwV_QgQ6YFmczFqASwqjyOa509PoCTPsOB-sET1G173IBHOd4X5kFjH9N6z5MI
Message-ID: <CAOQ4uxjyTdf21G1Y=_5Eox58drVPA0gAMeSQZxh=T36_yzssNw@mail.gmail.com>
Subject: Re: [PATCH v2 27/31] fuse: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
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
	Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Laight <david.laight.linux@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:30=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indica=
te
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d666224a6201cfc7f450e0bd37bfe32810..df92414e903b200fedb9dc777=
b913dae1e2d0741 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1215,6 +1215,7 @@ static const struct export_operations fuse_export_o=
perations =3D {
>         .fh_to_parent   =3D fuse_fh_to_parent,
>         .encode_fh      =3D fuse_encode_fh,
>         .get_parent     =3D fuse_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  static const struct super_operations fuse_super_operations =3D {
>
> --
> 2.52.0
>

