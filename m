Return-Path: <linux-btrfs+bounces-12012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33723A4F7BF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 08:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FEF3AA62D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 07:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21A1DED5F;
	Wed,  5 Mar 2025 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VeNoj8uq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329A15666B
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159018; cv=none; b=RMFR6E/9l/3J/2JkvdZdHG+A4Ugoh4myIeAE8jlRY9S42A3v6rEYhJNQnAW1NTXBYk9ywq3YpdPhCcQX/fGgn4tm9hGYjhoG70S87Sm6aQ/EnWm5NjCreD+bz28cjZsrrW8KofQEkNLSKRmjcwBn8BuJiUI+BpCCSt8No9zA+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159018; c=relaxed/simple;
	bh=05JzsWVzyy9UaciccizogO/UvGDu8gOh34lYYoGb2bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYNFk70stLuIVrcJfdjtrR8+GafAYJCnBXqpbyUUwCQwpJDYk0Mtsp3VNI+2ZjINXAYpwY3RoMm5PGkaBaZaA/sRNTYJarjIUJVVEIXXSfHkIBkkArSrGFFmywRRaFENZysAtKQHCO/rApgnsujjFmFhRtypce5Cf/gf+FViBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VeNoj8uq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbb12bea54so1159644166b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Mar 2025 23:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741159014; x=1741763814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwF972mUqDnxlGTqNQX6DKp9SpNkCEAYDKOEXsUNoB0=;
        b=VeNoj8uqkGyAB3dfQvlLOG+SlCQ+pOMdSt4g8NSeZrXcvflqKiHCyvvOTAJHVydKxi
         47+3rmrGDpHjzUbVIjGslTCwb2/pt4boRFq4TH6tc55pq+3bDGODYOhAYhNtrPaEbG9m
         YarQLkVW+xrq3Cl0nXHolkfT6ql/lwdg9L1jGzPfzDHx8vobbcWcAW2biB/KkK+/ZESc
         itI7LAKzHgNKjvEDtisBysSibgFxfiwu+dC8MMDUW6cS9b2+aIwoSgtOufTiUMZLfiR7
         yIiewnAroatLJbX226O/0OdSB5PmNxRVyAespBaVzd7KAmDl/bEOcZDkJcdg3eUULN4K
         H0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159014; x=1741763814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwF972mUqDnxlGTqNQX6DKp9SpNkCEAYDKOEXsUNoB0=;
        b=su1KIK3v1u1/Ex7N+9ZNQh2V9wa41Nl9slf0Tweiucs7fIQPvBTZu50PRogcwouaOH
         8NmWr53ZHmRffV8bJ4H1iMOKbXiwpBAGjpMuTf5KMRT7dDCym7ZWtz0e1W67Ryr/s66y
         AweZIsdf2jvqEFOt1x3VVY3MfrwyfLTwRKa4DkSKOpD/804/+cIJeYhFp8g6PWdRmI7N
         D2rN6KphvwRPK69D0edhpf/wj/h9MVwW4hKZKucr3/O2dxk+UB3zUsG4RRHm0kDiw9YG
         rVKLvHcVe4qh4mbWClnrOX5VywppZFjoyFYwVs7HlQtw7Q7jc5yPnxTj7RV/rwi9IFS3
         q69Q==
X-Gm-Message-State: AOJu0Yyp7a0RT0JudHE6GvU15NvdjwgtljDjWMBgRu+fcN8Blz2vFvxF
	NNEazaM36DQmBOh46rmlT7fTVqOupjs6IMwwyUe8MM64ecJzjdkN06vxU9e1Pe6FydF1fC4Orgv
	RgYO1Dwj2Mz8W4ilAtJ4zohz7gYvW+z5wndq1nUlMkfbar3L0
X-Gm-Gg: ASbGncscMpKhIVI5vO/n6YB79RfT6yAnpcrILw9CT7Zy9kxuY3YuzdNDWFqwhO2KPWB
	7ARSST27uMMl/8qJHyfYNiCDtU82OlcCZMqBgmr7wYCw/h1uzyk2KagAFTvQohbYe3rFJXUxtfN
	yhapiYSMXU6ahdftbuETcNBf9X
X-Google-Smtp-Source: AGHT+IHILWfY1cAc4mv8VTasGp5m4AxdHIyAusPWIM6TZs7jBnw6ubvKlF5IdUe2EnIvaz630FFY+v7kOn2CAwJlwlU=
X-Received: by 2002:a17:907:7f0b:b0:abe:fa18:1fc6 with SMTP id
 a640c23a62f3a-ac20d8441f2mr194194066b.10.1741159014444; Tue, 04 Mar 2025
 23:16:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304172712.573328-1-neelx@suse.com> <e8cd2383-1466-4f4f-bc88-cf0ba8f04e60@gmx.com>
In-Reply-To: <e8cd2383-1466-4f4f-bc88-cf0ba8f04e60@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Mar 2025 08:16:43 +0100
X-Gm-Features: AQ5f1Jo8_AJCWLoP1nUdxcSBu2hnrrAd-pSgLSosUSCIRfRtRN1C9cgvfJUth_8
Message-ID: <CAPjX3FfSBC121JU1ccNad-8bNcg9JBk+kcRvV3z5ij8zY5GZxg@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: fi defrag: allow passing compression levels
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Mar 2025 at 22:40, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2025/3/5 03:57, Daniel Vacek =E5=86=99=E9=81=93:
> > zlib and zstd compression methods support using compression levels.
> > Enable defrag to pass them to kernel.
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >   Documentation/ch-compression.rst | 10 +++---
> >   cmds/filesystem.c                | 55 ++++++++++++++++++++++++++++++-=
-
> >   kernel-shared/uapi/btrfs.h       | 10 +++++-
> >   libbtrfs/ioctl.h                 |  1 +
> >   libbtrfsutil/btrfs.h             | 12 +++++--
> >   5 files changed, 77 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/ch-compression.rst b/Documentation/ch-compre=
ssion.rst
> > index a9ec8f1e..f7cdda86 100644
> > --- a/Documentation/ch-compression.rst
> > +++ b/Documentation/ch-compression.rst
> > @@ -25,8 +25,8 @@ LZO
> >           * good backward compatibility
> >   ZSTD
> >           * compression comparable to ZLIB with higher compression/deco=
mpression speeds and different ratio
> > -        * levels: 1 to 15, mapped directly (higher levels are not avai=
lable)
> > -        * since 4.14, levels since 5.1
> > +        * levels: -15 to 15, mapped directly, default is 3
> > +        * since 4.14, levels 1 to 15 since 5.1, -15 to -1 since 6.15
>
> I believe the doc updates can be a separate patch since it's not related
> to the new defrag ioctl flag.

Good point. Thanks.

> >
> >   The differences depend on the actual data set and cannot be expressed=
 by a
> >   single number or recommendation. Higher levels consume more CPU time =
and may
> > @@ -78,7 +78,7 @@ Compression levels
> >
> >   The level support of ZLIB has been added in v4.14, LZO does not suppo=
rt levels
> >   (the kernel implementation provides only one), ZSTD level support has=
 been added
> > -in v5.1.
> > +in v5.1 and negative levels since v6.15.
> >
> >   There are 9 levels of ZLIB supported (1 to 9), mapping 1:1 from the m=
ount option
> >   to the algorithm defined level. The default is level 3, which provide=
s the
> > @@ -86,8 +86,8 @@ reasonably good compression ratio and is still reason=
ably fast. The difference
> >   in compression gain of levels 7, 8 and 9 is comparable but the higher=
 levels
> >   take longer.
> >
> > -The ZSTD support includes levels 1 to 15, a subset of full range of wh=
at ZSTD
> > -provides. Levels 1-3 are real-time, 4-8 slower with improved compressi=
on and
> > +The ZSTD support includes levels -15 to 15, a subset of full range of =
what ZSTD
> > +provides. Levels -15-3 are real-time, 4-8 slower with improved compres=
sion and
> >   9-15 try even harder though the resulting size may not be significant=
ly improved.
> >
> >   Level 0 always maps to the default. The compression level does not af=
fect
> > diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> > index d2605bda..f3f93ff7 100644
> > --- a/cmds/filesystem.c
> > +++ b/cmds/filesystem.c
> > @@ -962,6 +962,7 @@ static const char * const cmd_filesystem_defrag_usa=
ge[] =3D {
> >       "",
> >       OPTLINE("-r", "defragment files recursively"),
> >       OPTLINE("-c[zlib,lzo,zstd]", "compress the file while defragmenti=
ng, optional parameter (no space in between)"),
> > +     OPTLINE("-L|--level level", "use given compression level if enabl=
ed (zlib supports levels 1-9, zstd -15-15, and 0 selects the default level)=
"),
> >       OPTLINE("-f", "flush data to disk immediately after defragmenting=
"),
> >       OPTLINE("-s start", "defragment only from byte onward"),
> >       OPTLINE("-l len", "defragment only up to len bytes"),
> > @@ -1066,6 +1067,7 @@ static int cmd_filesystem_defrag(const struct cmd=
_struct *cmd,
> >       bool recursive =3D false;
> >       int ret =3D 0;
> >       int compress_type =3D BTRFS_COMPRESS_NONE;
> > +     int compress_level =3D 0;
> >
> >       /*
> >        * Kernel 4.19+ supports defragmention of files open read-only,
> > @@ -1095,18 +1097,18 @@ static int cmd_filesystem_defrag(const struct c=
md_struct *cmd,
> >       if (bconf.verbose !=3D BTRFS_BCONF_UNSET)
> >               bconf.verbose++;
> >
> > -     defrag_global_errors =3D 0;
> >       defrag_global_errors =3D 0;
> >       optind =3D 0;
> >       while(1) {
> >               enum { GETOPT_VAL_STEP =3D GETOPT_VAL_FIRST };
> >               static const struct option long_options[] =3D {
> > +                     { "level", required_argument, NULL, 'L' },
> >                       { "step", required_argument, NULL, GETOPT_VAL_STE=
P },
> >                       { NULL, 0, NULL, 0 }
> >               };
> >               int c;
> >
> > -             c =3D getopt_long(argc, argv, "vrc::fs:l:t:", long_option=
s, NULL);
> > +             c =3D getopt_long(argc, argv, "vrc::L:fs:l:t:", long_opti=
ons, NULL);
> >               if (c < 0)
> >                       break;
> >
> > @@ -1116,6 +1118,18 @@ static int cmd_filesystem_defrag(const struct cm=
d_struct *cmd,
> >                       if (optarg)
> >                               compress_type =3D parse_compress_type_arg=
(optarg);
> >                       break;
> > +             case 'L':
> > +                     /*
> > +                      * Do not enforce any limits here, kernel will do=
 itself
> > +                      * based on what's supported by the running versi=
on.
> > +                      * Just clip to the s8 type of the API.
> > +                      */
> > +                     compress_level =3D atoi(optarg);
> > +                     if (compress_level < -128)
> > +                             compress_level =3D -128;
> > +                     else if (compress_level > 127)
> > +                             compress_level =3D 127;
> > +                     break;
> >               case 'f':
> >                       flush =3D true;
> >                       break;
> > @@ -1165,7 +1179,12 @@ static int cmd_filesystem_defrag(const struct cm=
d_struct *cmd,
> >       defrag_global_range.extent_thresh =3D (u32)thresh;
> >       if (compress_type) {
> >               defrag_global_range.flags |=3D BTRFS_DEFRAG_RANGE_COMPRES=
S;
> > -             defrag_global_range.compress_type =3D compress_type;
> > +             if (compress_level) {
> > +                     defrag_global_range.flags |=3D BTRFS_DEFRAG_RANGE=
_COMPRESS_LEVEL;
>
> Since it's a newer flag, the ioctl() may fail with -EOPNOTSUPP on older
> kernels, in that case it's better to fall back to flags without the new
> COMPRESS_LEVEL one, and try it again. (With some warning showing that
> the kernel doesn't support the new flag).

Well, we don't know if the user really wants to proceed without the
specified level. This way the defrag fails and the user can rerun
without that option if he's fine using the default level.

Ie. Do we really want to do something different than what was asked on
the command line? Let me know and I'll change that but this looks
rigorous to me.

> Thanks,
> Qu
>
> > +                     defrag_global_range.compress.type =3D compress_ty=
pe;
> > +                     defrag_global_range.compress.level=3D compress_le=
vel;
> > +             } else
> > +                     defrag_global_range.compress_type =3D compress_ty=
pe;
> >       }
> >       if (flush)
> >               defrag_global_range.flags |=3D BTRFS_DEFRAG_RANGE_START_I=
O;
> > diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
> > index 6649436c..d2609777 100644
> > --- a/kernel-shared/uapi/btrfs.h
> > +++ b/kernel-shared/uapi/btrfs.h
> > @@ -645,7 +645,9 @@ _static_assert(sizeof(struct btrfs_ioctl_clone_rang=
e_args) =3D=3D 32);
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
> > @@ -673,7 +675,13 @@ struct btrfs_ioctl_defrag_range_args {
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
> > diff --git a/libbtrfs/ioctl.h b/libbtrfs/ioctl.h
> > index 7b53a531..08681f2e 100644
> > --- a/libbtrfs/ioctl.h
> > +++ b/libbtrfs/ioctl.h
> > @@ -398,6 +398,7 @@ struct btrfs_ioctl_clone_range_args {
> >   /* flags for the defrag range ioctl */
> >   #define BTRFS_DEFRAG_RANGE_COMPRESS 1
> >   #define BTRFS_DEFRAG_RANGE_START_IO 2
> > +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
> >
> >   #define BTRFS_SAME_DATA_DIFFERS     1
> >   /* For extent-same ioctl */
> > diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
> > index 8e5681c7..ebc9fc2a 100644
> > --- a/libbtrfsutil/btrfs.h
> > +++ b/libbtrfsutil/btrfs.h
> > @@ -608,7 +608,9 @@ struct btrfs_ioctl_clone_range_args {
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
> > @@ -636,7 +638,13 @@ struct btrfs_ioctl_defrag_range_args {
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

