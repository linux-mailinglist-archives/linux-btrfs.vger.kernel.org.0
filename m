Return-Path: <linux-btrfs+bounces-12011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E37A4F7AC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 08:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06843AC4E4
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 07:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3461EA7EF;
	Wed,  5 Mar 2025 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uke+EYg7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE33F1C8635
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158529; cv=none; b=WU+txKg33irFZyRNNEcg08w8nVUjPimvCZ5+ihu3sEF18XISDPTnQqgIbVyHDN3tIodd1XR4SnvuzSfxhcylFjiOk7GXu9EbgEG9i2UYKZ9Dj0fUpLbOJvR3wZrZCyLVFYyM8pO6MSdRzjbHnHlBAX4A3pZGGaksSl4BL5zCQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158529; c=relaxed/simple;
	bh=hNy+VmiwB1/ze3G+2KPUuxwNTSDwkKTQDOqTcuoy5BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VY3q5ozdwwPbRbcPLDSH3IW0BW7ylp+oPC4G+YubDKfKDTErF1spGD2LVNXgU/bm6OgJ+uEJWMJIAib2oVEdrRHgT1CTHEXZgJeL2R5H16XMUqlHAuz5El7QW9zT8HETFzu5I/Sztj9HYjAaN7VLWZo//naAjhWwQSKJRmlVGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uke+EYg7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbb12bea54so1158548766b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Mar 2025 23:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741158526; x=1741763326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+yijvXm5ZDn7LDTm1xM049gYEoLE/xp0pe1BT45gf0=;
        b=Uke+EYg7UTHvj1q7ivclMXnv6NddyYJEjLmojvLsU1FiX+8CNadjwFMCWIvZk1myGO
         D2C9QXZhx+5Xtmg1l8JW8j5APwp3V140VikHTwxbZfLCnCDIW0LJyaJzFD4F5bqz0xX6
         8Jb2cafk5/wNi3CW1gGG0Oawj7xGZnvgfLt+BCwizYevpfpwB6O+kkLJWKJeI+F1lgTO
         8jA1N6SDiTbnrqm0s/oVrNEAe8S4H3Q/CUBqBHVuwHihlroxJ8rInxLNBpr/4p4+CGLX
         V1YFv9f4BVjoNriMLuA/F4NllTzOV106PEycbMNuWSwOySQOsoDxigXj9aQKdHOgAGZj
         RR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741158526; x=1741763326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+yijvXm5ZDn7LDTm1xM049gYEoLE/xp0pe1BT45gf0=;
        b=bWz3LzFcBJSNWtwpBRRPadaW6CfDKI8Rn42d2sgMF9i15d74hu9gkOU91692fKDDBl
         Y8F2MoFEeNNN/e3uKxn4NImHd+RKhKJZod4pmYpmDrBPNLpko+fRdi9rARGz2CMGVbAG
         UpoUCEFTgUDJT4JG5UOP8UFOMDf5z/fMDm8GilvweQIsblb/2JGbtTGN4kdqy7rIzm0y
         QhLM/RHCGJ4bm2sPViQikJOEX/+CHzfEvMnjE8lz10pE30TaqMNRwQB9/auakO6hRCF2
         7+TqzedM/CPYdUgcDzFZuQq+ixysA3rfhTcc+7gMfOve5Er7uQV9uupbH2YKLZo3RZeW
         BQKA==
X-Forwarded-Encrypted: i=1; AJvYcCVXavUr5h0t1+9AwpSiOtE5WnG4guXfjlpt9uFCslCI1FWyhx4M18NC1QffDpVPl1dE3OsUL3koVfGGOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2dOIvP+r5Wj2xsLMXV3/xaaSEu7NoKu9+1l/owxMRDe1pMtm
	gKS0bPU326AibGvGpSN2sIzYrDc7NHhnagLtuIYf++dNpzItXpsjCDTE4wRkkRb5vO9WBE6GdYV
	oDb2u5XKgE1VLoOB9iBv0FFpxd6oCD/uoJhTTPw==
X-Gm-Gg: ASbGncs/DXaykL2GHySEuY8RW2sVNQOKjWko+ljTfkvYisIRKV17pgQNNSS1Jn9w5NG
	Uqkt/INshbXkYzhdiEnj+reexTMRlqoUBTFnt/0D919L9u8SAkAGsjMetgBj4+e2D5H8/nGCGk8
	hBlqMKge6wHnHVfUzRZmpzCbWH
X-Google-Smtp-Source: AGHT+IF7SpFKB1skYwYO2rns8DxIMQmy4/IIYr9g6yuUeA/6XyFLxnh4ne8RYqJRqrwC83FjXGniDGMs0w16f3tcAwk=
X-Received: by 2002:a17:907:3dab:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-ac20dafe7b2mr188424866b.49.1741158526027; Tue, 04 Mar 2025
 23:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304171403.571335-1-neelx@suse.com> <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
 <20250305070200.GY5777@suse.cz>
In-Reply-To: <20250305070200.GY5777@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Mar 2025 08:08:35 +0100
X-Gm-Features: AQ5f1JrCnQgQHbTadgVgDNejV3N9VOm52FS-vlWnlLzI0sBxQUx73ezl7M-SBSc
Message-ID: <CAPjX3FfYmbdPLYTS5N5WUimqh=Dz41nVXbwm47iRW=Q3E7Wnhg@mail.gmail.com>
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 at 08:02, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Mar 05, 2025 at 08:01:24AM +1030, Qu Wenruo wrote:
> > The feature itself looks good to me.
> >
> > Although not sure if a blank commit message is fine for this case.
> >
> > =E5=9C=A8 2025/3/5 03:44, Daniel Vacek =E5=86=99=E9=81=93:
> > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > ---
> > >   fs/btrfs/btrfs_inode.h     |  2 ++
> > >   fs/btrfs/defrag.c          | 22 +++++++++++++++++-----
> > >   fs/btrfs/fs.h              |  2 +-
> > >   fs/btrfs/inode.c           | 10 +++++++---
> > >   include/uapi/linux/btrfs.h | 10 +++++++++-
> > >   5 files changed, 36 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > > index aa1f55cd81b79..5ee9da0054a74 100644
> > > --- a/fs/btrfs/btrfs_inode.h
> > > +++ b/fs/btrfs/btrfs_inode.h
> > > @@ -145,6 +145,7 @@ struct btrfs_inode {
> > >      * different from prop_compress and takes precedence if set.
> > >      */
> > >     u8 defrag_compress;
> > > +   s8 defrag_compress_level;
> > >
> > >     /*
> > >      * Lock for counters and all fields used to determine if the inod=
e is in
> > > diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> > > index 968dae9539482..03a0287a78ea0 100644
> > > --- a/fs/btrfs/defrag.c
> > > +++ b/fs/btrfs/defrag.c
> > > @@ -1363,6 +1363,7 @@ int btrfs_defrag_file(struct inode *inode, stru=
ct file_ra_state *ra,
> > >     u64 last_byte;
> > >     bool do_compress =3D (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS)=
;
> > >     int compress_type =3D BTRFS_COMPRESS_ZLIB;
> > > +   int compress_level =3D 0;
> > >     int ret =3D 0;
> > >     u32 extent_thresh =3D range->extent_thresh;
> > >     pgoff_t start_index;
> > > @@ -1376,10 +1377,19 @@ int btrfs_defrag_file(struct inode *inode, st=
ruct file_ra_state *ra,
> > >             return -EINVAL;
> > >
> > >     if (do_compress) {
> > > -           if (range->compress_type >=3D BTRFS_NR_COMPRESS_TYPES)
> > > -                   return -EINVAL;
> > > -           if (range->compress_type)
> > > -                   compress_type =3D range->compress_type;
> > > +           if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> > > +                   if (range->compress.type >=3D BTRFS_NR_COMPRESS_T=
YPES)
> > > +                           return -EINVAL;
> > > +                   if (range->compress.type) {
> > > +                           compress_type =3D range->compress.type;
> > > +                           compress_level=3D range->compress.level;
> > > +                   }
> >
> > I am not familiar with the compress level, but
> > btrfs_compress_set_level() does extra clamping, maybe we also want to d=
o
> > that too?
>
> Yes the level needs to be validated here as well.

The level is passed to btrfs_compress_folios() in
compress_file_range() and the first thing it does is precisely
btrfs_compress_set_level(). So I thought it's not needed to be done
twice.

> > > @@ -643,7 +645,13 @@ struct btrfs_ioctl_defrag_range_args {
> > >      * for this defrag operation.  If unspecified, zlib will
> > >      * be used
> > >      */
> > > -   __u32 compress_type;
> > > +   union {
> > > +           __u32 compress_type;
> > > +           struct {
> > > +                   __u8 type;
> > > +                   __s8 level;
> > > +           } compress;
> > > +   };
> > >
> > >     /* spare for later */
> > >     __u32 unused[4];
> >
> > We have enough space left here, although u32 is overkilled for
> > compress_type, using the unused space for a new s8/s16/s32 member shoul=
d
> > be fine.
>
> I suggested to do it like that, u32 is wasting space and the union trick
> reusing existing space was already done e.g. in the balance filters.

