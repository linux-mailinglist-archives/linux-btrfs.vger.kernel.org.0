Return-Path: <linux-btrfs+bounces-12009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A381A4F790
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 08:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A0516EF55
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 07:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7F1E5B74;
	Wed,  5 Mar 2025 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eL2S3cyn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0F1C5F13
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158164; cv=none; b=neKKt3nz2GcPGs0DsQYja6Z30D3WBbTCmdk7NNRbGjMlgOpff3z+Y4cfvpnoaokcf3iUWq4dh/6Gbt62iPO6RXMcnYOD6WFVLiiOgyUrkmkqmSXBblUF4PEUAa7begUQ3WK4Y1Odjo3yxQPYy/iova99guyhkF+L8D4N7P3fEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158164; c=relaxed/simple;
	bh=CA3noS0KFeluZ2pLvltfZMdIWvYnaiUAKLBld55KqhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRdIbajUXqIM2fzYGrE3JPjzzsITS5adO5OfNXK7wQ5D/jytjQMG5axEMYownNR9pUZJaaxx+nuS8ybsfe1yK7JgGYXDFUvd4xY0nvscaoqYTgUPAi6Kbg43t2meKBpTptqoyWdfmAnFWIsCxwu2Hxg49W1tWYz2yLqiXcdl2dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eL2S3cyn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5050d19e9so8256153a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Mar 2025 23:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741158160; x=1741762960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/89VcL4o2IORG4LK3l3dkQHPeS2GoSKMM8yqnTe+6w=;
        b=eL2S3cynW4tfiDTtsPQra9uIW4qQqbszVPzOxLTmaacf/bHzeeoZnLq26Paf5IO99u
         sBb/ZgRsfmKuDPYtIPodcRq6cLcY4FBnDlZzGVkdKXiyYz3mn1wA7PakdZwODO1dNihL
         +G+gosPfF7sm1dJ+JyosREkxfZqT6c9mdBWeN/cFSa+qmnqIxgsePlm/nM0RQx1S2/IK
         9z9nsNDvjDd8i69Y5qGa/jT28t+rH+/OwKeILOFR/Q58qOhsuKs0SvbdXOTvGd3r6p4U
         Gx4H2zb/Nn7VNxoeycwYUMPV/1aJIs/Vkzmf0nUh4a15iQv+w+xLELKf6hUPAvDCgBIC
         ekbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741158160; x=1741762960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/89VcL4o2IORG4LK3l3dkQHPeS2GoSKMM8yqnTe+6w=;
        b=emZam/kQD2eWoMnOzbWRhmJwJ3QqjW5filYu1Q+BrNcCLZgegcXjCQdWsKAMqd2Gq+
         79BfgkA0ITfqR7K03QaTf6eg6zYYbA6A6SD88fFHb+/ztZC5gPGD6ptzvldmLfUStR98
         2lNLzVoU3NJppawOM1Wgy2KBN1rsT1CfPq2C9ujakteFoP7gvN7kr9DZ70oxC5Rriat/
         k9XvhFof0xnqCsAEShtMXsXX65FncuzFB72qlMY1fdLoXgOR4aG3nfG/CirOthBpuVa4
         b92pg93eQeaFrVgBHyHULLFxCgy8cz7wLQiCbT62YkqvXqZkxecglmrW7mIAy1OZOSJp
         fdag==
X-Forwarded-Encrypted: i=1; AJvYcCX777dLRpKkiq6aV+aKweDI8gMetxQvkB9nHuIrKlh5re1HarJ4JJpJL7Lcsz5qRHXjm/woJF1146dD4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCeo0eeCnubW2SjNyLb5Rh/lbuMcmNgmdIxMGg8OsZZtv7/u80
	2cOLgaTS00XdEi7ym4C1mvJ52RimgEYQ1euKaIyjxOv5uQGgx5q2iDYWZOVcbY5jX/JSJC7F4pW
	o9Qz3zCZcFtI68GulvgjHUzhvQ/GS08+AafD6B1peVFUNr1hv
X-Gm-Gg: ASbGnctADKGmU8iHp0QptseClvihJHhGn6SPMJJXPKFwLR40p3Z14ysJnbCCAuV0t2s
	1D1OQz2OZBvqqQuOyM/wm/DqQWPmYn+Q5B8V3iXi0bCutIa7o9aCm0jf4pVG1T7d7wXOKO+RMDT
	fS6SPTlYoCG12/oZclf2myM9B+
X-Google-Smtp-Source: AGHT+IGIIgqjVyDZW4/Ols9OIZe07V2W62/11Brg6QiJW0at8363ju49p3wJjCP4RV7cH39KnBlGT2+Cqgfwkziv7/w=
X-Received: by 2002:a17:907:9451:b0:ac1:ef3c:61d4 with SMTP id
 a640c23a62f3a-ac20d8bcc75mr163310666b.21.1741158159570; Tue, 04 Mar 2025
 23:02:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304171403.571335-1-neelx@suse.com> <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
In-Reply-To: <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Mar 2025 08:02:28 +0100
X-Gm-Features: AQ5f1Jpd-GaOlgBsn1u5cEwCfvBU3onwxOKl6ZsqVu6TLjcNVpq5EnwXFtTiE1c
Message-ID: <CAPjX3FcZ6TJZnHNf3sm00F49BVsDzQaZr5fJHMXRUXne3gLZ2w@mail.gmail.com>
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Mar 2025 at 22:31, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> The feature itself looks good to me.
>
> Although not sure if a blank commit message is fine for this case.

Sigh, that's a mistake. I'll send a v2 with a few sentences.

> =E5=9C=A8 2025/3/5 03:44, Daniel Vacek =E5=86=99=E9=81=93:
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >   fs/btrfs/btrfs_inode.h     |  2 ++
> >   fs/btrfs/defrag.c          | 22 +++++++++++++++++-----
> >   fs/btrfs/fs.h              |  2 +-
> >   fs/btrfs/inode.c           | 10 +++++++---
> >   include/uapi/linux/btrfs.h | 10 +++++++++-
> >   5 files changed, 36 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index aa1f55cd81b79..5ee9da0054a74 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -145,6 +145,7 @@ struct btrfs_inode {
> >        * different from prop_compress and takes precedence if set.
> >        */
> >       u8 defrag_compress;
> > +     s8 defrag_compress_level;
> >
> >       /*
> >        * Lock for counters and all fields used to determine if the inod=
e is in
> > diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> > index 968dae9539482..03a0287a78ea0 100644
> > --- a/fs/btrfs/defrag.c
> > +++ b/fs/btrfs/defrag.c
> > @@ -1363,6 +1363,7 @@ int btrfs_defrag_file(struct inode *inode, struct=
 file_ra_state *ra,
> >       u64 last_byte;
> >       bool do_compress =3D (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS)=
;
> >       int compress_type =3D BTRFS_COMPRESS_ZLIB;
> > +     int compress_level =3D 0;
> >       int ret =3D 0;
> >       u32 extent_thresh =3D range->extent_thresh;
> >       pgoff_t start_index;
> > @@ -1376,10 +1377,19 @@ int btrfs_defrag_file(struct inode *inode, stru=
ct file_ra_state *ra,
> >               return -EINVAL;
> >
> >       if (do_compress) {
> > -             if (range->compress_type >=3D BTRFS_NR_COMPRESS_TYPES)
> > -                     return -EINVAL;
> > -             if (range->compress_type)
> > -                     compress_type =3D range->compress_type;
> > +             if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> > +                     if (range->compress.type >=3D BTRFS_NR_COMPRESS_T=
YPES)
> > +                             return -EINVAL;
> > +                     if (range->compress.type) {
> > +                             compress_type =3D range->compress.type;
> > +                             compress_level=3D range->compress.level;
> > +                     }
>
> I am not familiar with the compress level, but
> btrfs_compress_set_level() does extra clamping, maybe we also want to do
> that too?

This is intentionally left to be limited later. There's no need to do
it at this point and the code is simpler. It's also compression
type/method agnostic.

> > +             } else {
> > +                     if (range->compress_type >=3D BTRFS_NR_COMPRESS_T=
YPES)
> > +                             return -EINVAL;
> > +                     if (range->compress_type)
> > +                             compress_type =3D range->compress_type;
> > +             }
> >       }
> >
> >       if (extent_thresh =3D=3D 0)
> > @@ -1430,8 +1440,10 @@ int btrfs_defrag_file(struct inode *inode, struc=
t file_ra_state *ra,
> >                       btrfs_inode_unlock(BTRFS_I(inode), 0);
> >                       break;
> >               }
> > -             if (do_compress)
> > +             if (do_compress) {
> >                       BTRFS_I(inode)->defrag_compress =3D compress_type=
;
> > +                     BTRFS_I(inode)->defrag_compress_level =3D compres=
s_level;
> > +             }
> >               ret =3D defrag_one_cluster(BTRFS_I(inode), ra, cur,
> >                               cluster_end + 1 - cur, extent_thresh,
> >                               newer_than, do_compress, &sectors_defragg=
ed,
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index be6d5a24bd4e6..2dae7ffd37133 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -485,7 +485,7 @@ struct btrfs_fs_info {
> >       u64 last_trans_log_full_commit;
> >       unsigned long long mount_opt;
> >
> > -     unsigned long compress_type:4;
> > +     int compress_type;
> >       int compress_level;
> >       u32 commit_interval;
> >       /*
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index fa04b027d53ac..156a9d4603391 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -925,6 +925,7 @@ static void compress_file_range(struct btrfs_work *=
work)
> >       unsigned int poff;
> >       int i;
> >       int compress_type =3D fs_info->compress_type;
> > +     int compress_level=3D fs_info->compress_level;
> >
> >       inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
> >
> > @@ -1007,13 +1008,15 @@ static void compress_file_range(struct btrfs_wo=
rk *work)
> >               goto cleanup_and_bail_uncompressed;
> >       }
> >
> > -     if (inode->defrag_compress)
> > +     if (inode->defrag_compress) {
> >               compress_type =3D inode->defrag_compress;
> > -     else if (inode->prop_compress)
> > +             compress_level=3D inode->defrag_compress_level;
> > +     } else if (inode->prop_compress) {
> >               compress_type =3D inode->prop_compress;
> > +     }
> >
> >       /* Compression level is applied here. */
> > -     ret =3D btrfs_compress_folios(compress_type, fs_info->compress_le=
vel,
> > +     ret =3D btrfs_compress_folios(compress_type, compress_level,
> >                                   mapping, start, folios, &nr_folios, &=
total_in,
> >                                   &total_compressed);
> >       if (ret)
> > diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> > index d3b222d7af240..3540d33d6f50c 100644
> > --- a/include/uapi/linux/btrfs.h
> > +++ b/include/uapi/linux/btrfs.h
> > @@ -615,7 +615,9 @@ struct btrfs_ioctl_clone_range_args {
> >    */
> >   #define BTRFS_DEFRAG_RANGE_COMPRESS 1
> >   #define BTRFS_DEFRAG_RANGE_START_IO 2
> > +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
> >   #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP       (BTRFS_DEFRAG_RANGE_COMPR=
ESS |          \
> > +                                      BTRFS_DEFRAG_RANGE_COMPRESS_LEVE=
L |    \
> >                                        BTRFS_DEFRAG_RANGE_START_IO)
> >
> >   struct btrfs_ioctl_defrag_range_args {
> > @@ -643,7 +645,13 @@ struct btrfs_ioctl_defrag_range_args {
> >        * for this defrag operation.  If unspecified, zlib will
> >        * be used
> >        */
> > -     __u32 compress_type;
> > +     union {
> > +             __u32 compress_type;
> > +             struct {
> > +                     __u8 type;
> > +                     __s8 level;
> > +             } compress;
> > +     };
> >
> >       /* spare for later */
> >       __u32 unused[4];
>
> We have enough space left here, although u32 is overkilled for
> compress_type, using the unused space for a new s8/s16/s32 member should
> be fine.

That is what I did originally, but discussing with Dave he suggested
this solution.

>
> Thanks,
> Qu

