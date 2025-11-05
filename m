Return-Path: <linux-btrfs+bounces-18723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C31C34772
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 09:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B0218C31EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AE72C0285;
	Wed,  5 Nov 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CtRk2o2Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF4B292B4B
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331329; cv=none; b=TYaIMnrKsEQ4XHGkTjT/bYwYCJQLVMQsIM9CtXUiTlRE7JA7+6HwqJElmMMBJr5dGYyGgJZUzH6Bmx6i0LSYnSxVOhRf3t/LLdGFSRq/nrB88KAAkcaLLgwofe7NIWtTOvTPs8dYVSziqYohop1/IRo6nX/C5XdK7id7ae8GL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331329; c=relaxed/simple;
	bh=wUGXy7Yq4Z+JrKG+v5ZHPpIzcPzAJuhHmc4PIvfPG9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnxOpMYwrq/Hk/QzaVXGPAhX9dw7oa3vcnFEPztlLCM3x5kKpwz55DbLA1I8t87oxe5kzzq1Y9LCvtm+kR3Z9OcJo0RcUoLJDZgINby35eE1u5QQfbSVjAvVaTG5sHkpUGYsk644kWlzmRyLGsoiTS7WCDHUjKNILT1AbSb911Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CtRk2o2Z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-426f1574a14so3865568f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 00:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762331325; x=1762936125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOLMI39pZ3S9KHBf2zrQdG7I2U83xEAxxAyo9p71DVU=;
        b=CtRk2o2ZPYj/gkpdfiTmYXAYWd8yHXZqYL66VGavFYJBKMLpfF2RztswBWrJidH2VM
         0AnqumHKgatU/Y06TxtqrkzQsZJJwEtXiN4rFqmR1Ohu7/GhzgYtYRiWuSBys91ifGm3
         AqKJ45XB60GT5Qg9B7D/aFnLGmNUnifHz12OpPqmAizHKtjcjCgeg+va1uOkguRAr8Tp
         Ls5XJhl7cwltf/jQ6YkLA1PEFvokx5ImgTl23xo8Qs64zoTeAZsYXwNGO8+VVjDIi6m2
         aWRFDwoor15ptfRRlzr02Su9Tu6TcbAlAlmQBKBXTW0+TnuHHz81ghpQKxBuWoImsq7g
         qbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331325; x=1762936125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOLMI39pZ3S9KHBf2zrQdG7I2U83xEAxxAyo9p71DVU=;
        b=tAhQQjIL2q18Shmb6Uj5c5jPIKB1AtAwNbNqnuJzgzWlTY+B4LQzrMOTCgavQo+HnP
         n1KktITuPY5eAfKh/xd2VNpmGcczxmSykX6V3frXMiAnUEEQBN8F0hZRS84HehwUqNB9
         w3PDHWZT4NOj4t5IQumTJZnjM1k4ckz2qmxjtsKQHIi0bsFZaWbXZ8F2ozFg9FKSHz20
         wgHPC0vA4SiWR9iEAwzLoqNyUxgNNKOZ8j47SiKYn5jX9xs+1KftzNxFQ0pelARG0uWN
         N6UBf06Uuy/aD5TuRSoGUSIsOzcFdHs/OW8DaW1a7Rk0aahKmpGhzG7l6T94ZW7QRzkc
         Fy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVUoOGhz2zdqLSWPAl6O+CJd8HMLzXUKvC2eWP7rn7lqhq8ncL0KLnnJ9qtysbddt/A1eRMSzmTjQ46w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSD7SI6FMprcDP1kMWW3LExi4wQU0ytgELow04j2Gwg6V13f0i
	qoQNAUuTMaV/p056/ok9JH1Pcp2V9j/bMVgu1OUGMT55pfNjN5uhBE8kFJGSdKJjn2KjIsdXanA
	pJRrX1zpqmctBSXJ79HYz/6qfVSLQSnrFTfB4e0Yosg==
X-Gm-Gg: ASbGnctWmuDh+y1B7WhjieUn2MAg5/KEmGt9q5ivy9O0YX9skHkuff5UQFmPIvzk3an
	G5RXrFzSZq8HTnbjuKZ60GhyXWp3xBsLJdQKqVA+mJRev5xRUTpTTCIZWwkjvUQWAH6rpAYBwyp
	dn3y0Tkc3NL+VVGSQtcjKQPFYrjY06fOUiJPCIJzenmsrXgSnuYzV2M6/aFnBAST58JaVMUhocI
	Kiu7Fnvh47nEXP08DA0DexnmFiWGRH16uq8IDnhWdvf1yme8TbBvIYgH1hhO/yZrEiCsGBnwzoJ
	RNwDatipcw942oGXf2bo3U8ciz/AXzjtd7G/wWcz58q40Apfzh/RXBScYA==
X-Google-Smtp-Source: AGHT+IE+fEKOD+Ki77yJBzaUIYPbJvmXcUc6Oi+d/X97Oh834Ow79V/ao/BW1x1wrzODzjCPl3XNjV23Gdb67xLAB94=
X-Received: by 2002:a05:6000:615:b0:405:ed47:b22b with SMTP id
 ffacd0b85a97d-429e32c82a7mr1790980f8f.10.1762331325437; Wed, 05 Nov 2025
 00:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <20251015121157.1348124-4-neelx@suse.com>
 <20251024212920.GE20913@twin.jikos.cz> <b4398e6d-7a2d-4bea-8b03-29205d2c657e@gmx.com>
In-Reply-To: <b4398e6d-7a2d-4bea-8b03-29205d2c657e@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 09:28:33 +0100
X-Gm-Features: AWmQ_bl1aCNfgWQ6D6k5YAmPP_5NLfyW8AROzoW2-7xmW6vpouUK62iohLN-rP4
Message-ID: <CAPjX3FfSxK=erDkcgNs2Bom5jwW363jHr=gHPtCqLx6FKemjYQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] btrfs-progs: start tracking extent encryption context info
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 25 Oct 2025 at 00:43, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2025/10/25 07:59, David Sterba =E5=86=99=E9=81=93:
> > On Wed, Oct 15, 2025 at 02:11:51PM +0200, Daniel Vacek wrote:
> >> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >>
> >> This recapitulates the kernel change named 'btrfs: start tracking exte=
nt
> >> encryption context info".
> >>
> >> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >> ---
> >>   kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
> >>   kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++----=
--
> >>   kernel-shared/uapi/btrfs_tree.h | 23 +++++++++++-
> >>   3 files changed, 118 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
> >> index cb96f3e2..5d90be76 100644
> >> --- a/kernel-shared/accessors.h
> >> +++ b/kernel-shared/accessors.h
> >> @@ -935,6 +935,9 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generatio=
n, struct btrfs_super_block,
> >>   BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_b=
lock,
> >>                       nr_global_roots, 64);
> >>
> >> +/* struct btrfs_file_extent_encryption_info */
> >> +BTRFS_SETGET_FUNCS(encryption_info_size, struct btrfs_encryption_info=
, size, 32);
> >> +
> >>   /* struct btrfs_file_extent_item */
> >>   BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_e=
xtent_item,
> >>                       type, 8);
> >> @@ -973,6 +976,46 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct=
 btrfs_file_extent_item,
> >>   BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_ext=
ent_item,
> >>                 other_encoding, 16);
> >>
> >> +static inline struct btrfs_encryption_info *btrfs_file_extent_encrypt=
ion_info(
> >> +                                    const struct btrfs_file_extent_it=
em *ei)
> >> +{
> >> +    unsigned long offset =3D (unsigned long)ei;
> >> +
> >> +    offset +=3D offsetof(struct btrfs_file_extent_item, encryption_in=
fo);
> >> +    return (struct btrfs_encryption_info *)offset;
> >> +}
> >> +
> >> +static inline unsigned long btrfs_file_extent_encryption_ctx_offset(
> >> +                                    const struct btrfs_file_extent_it=
em *ei)
> >> +{
> >> +    unsigned long offset =3D (unsigned long)ei;
> >> +
> >> +    offset +=3D offsetof(struct btrfs_file_extent_item, encryption_in=
fo);
> >> +    return offset + offsetof(struct btrfs_encryption_info, context);
> >> +}
> >> +
> >> +static inline u32 btrfs_file_extent_encryption_ctx_size(
> >> +                                    const struct extent_buffer *eb,
> >> +                                    const struct btrfs_file_extent_it=
em *ei)
> >> +{
> >> +    return btrfs_encryption_info_size(eb, btrfs_file_extent_encryptio=
n_info(ei));
> >> +}
> >> +
> >> +static inline void btrfs_set_file_extent_encryption_ctx_size(
> >> +                                    struct extent_buffer *eb,
> >> +                                    struct btrfs_file_extent_item *ei=
,
> >> +                                    u32 val)
> >> +{
> >> +    btrfs_set_encryption_info_size(eb, btrfs_file_extent_encryption_i=
nfo(ei), val);
> >> +}
> >> +
> >> +static inline u32 btrfs_file_extent_encryption_info_size(
> >> +                                    const struct extent_buffer *eb,
> >> +                                    const struct btrfs_file_extent_it=
em *ei)
> >> +{
> >> +    return btrfs_encryption_info_size(eb, btrfs_file_extent_encryptio=
n_info(ei));
> >> +}
> >> +
> >>   /* btrfs_qgroup_status_item */
> >>   BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_sta=
tus_item,
> >>                 generation, 64);
> >> diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker=
.c
> >> index ccc1f1ea..93073979 100644
> >> --- a/kernel-shared/tree-checker.c
> >> +++ b/kernel-shared/tree-checker.c
> >> @@ -242,6 +242,8 @@ static int check_extent_data_item(struct extent_bu=
ffer *leaf,
> >>      u32 sectorsize =3D fs_info->sectorsize;
> >>      u32 item_size =3D btrfs_item_size(leaf, slot);
> >>      u64 extent_end;
> >> +    u8 policy;
> >> +    u8 fe_type;
> >>
> >>      if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
> >>              file_extent_err(leaf, slot,
> >> @@ -272,12 +274,12 @@ static int check_extent_data_item(struct extent_=
buffer *leaf,
> >>                              SZ_4K);
> >>              return -EUCLEAN;
> >>      }
> >> -    if (unlikely(btrfs_file_extent_type(leaf, fi) >=3D
> >> -                 BTRFS_NR_FILE_EXTENT_TYPES)) {
> >> +
> >> +    fe_type =3D btrfs_file_extent_type(leaf, fi);
> >> +    if (unlikely(fe_type >=3D BTRFS_NR_FILE_EXTENT_TYPES)) {
> >>              file_extent_err(leaf, slot,
> >>              "invalid type for file extent, have %u expect range [0, %=
u]",
> >> -                    btrfs_file_extent_type(leaf, fi),
> >> -                    BTRFS_NR_FILE_EXTENT_TYPES - 1);
> >> +                    fe_type, BTRFS_NR_FILE_EXTENT_TYPES - 1);
> >>              return -EUCLEAN;
> >>      }
> >>
> >> @@ -293,10 +295,11 @@ static int check_extent_data_item(struct extent_=
buffer *leaf,
> >>                      BTRFS_NR_COMPRESS_TYPES - 1);
> >>              return -EUCLEAN;
> >>      }
> >> -    if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
> >> +    policy =3D btrfs_file_extent_encryption(leaf, fi);
> >> +    if (unlikely(policy >=3D BTRFS_NR_ENCRYPTION_TYPES)) {
> >>              file_extent_err(leaf, slot,
> >> -                    "invalid encryption for file extent, have %u expe=
ct 0",
> >> -                    btrfs_file_extent_encryption(leaf, fi));
> >> +                    "invalid encryption for file extent, have %u expe=
ct range [0, %u]",
> >> +                    policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
> >>              return -EUCLEAN;
> >>      }
> >>      if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXTENT_INL=
INE) {
> >> @@ -325,12 +328,50 @@ static int check_extent_data_item(struct extent_=
buffer *leaf,
> >>              return 0;
> >>      }
> >>
> >> -    /* Regular or preallocated extent has fixed item size */
> >> -    if (unlikely(item_size !=3D sizeof(*fi))) {
> >> -            file_extent_err(leaf, slot,
> >> +    if (policy =3D=3D BTRFS_ENCRYPTION_FSCRYPT) {
> >> +            size_t fe_size =3D sizeof(*fi) + sizeof(struct btrfs_encr=
yption_info);
> >> +            u32 ctxsize;
> >> +
> >> +            if (unlikely(item_size < fe_size)) {
> >> +                    file_extent_err(leaf, slot,
> >> +    "invalid item size for encrypted file extent, have %u expect =3D =
%zu + size of u32",
> >> +                                    item_size, sizeof(*fi));
> >> +                    return -EUCLEAN;
> >> +            }
> >> +
> >> +            ctxsize =3D btrfs_file_extent_encryption_info_size(leaf, =
fi);
> >> +            if (unlikely(item_size !=3D (fe_size + ctxsize))) {
> >> +                    file_extent_err(leaf, slot,
> >> +    "invalid item size for encrypted file extent, have %u expect =3D =
%zu + context of size %u",
> >> +                                    item_size, fe_size, ctxsize);
> >> +                    return -EUCLEAN;
> >> +            }
> >> +
> >> +            if (unlikely(ctxsize > BTRFS_MAX_EXTENT_CTX_SIZE)) {
> >> +                    file_extent_err(leaf, slot,
> >> +    "invalid file extent context size, have %u expect a maximum of %u=
",
> >> +                                    ctxsize, BTRFS_MAX_EXTENT_CTX_SIZ=
E);
> >> +                    return -EUCLEAN;
> >> +            }
> >> +
> >> +            /*
> >> +             * Only regular and prealloc extents should have an encry=
ption
> >> +             * context.
> >> +             */
> >> +            if (unlikely(fe_type !=3D BTRFS_FILE_EXTENT_REG &&
> >> +                         fe_type !=3D BTRFS_FILE_EXTENT_PREALLOC)) {
> >> +                    file_extent_err(leaf, slot,
> >> +            "invalid type for encrypted file extent, have %u",
> >> +                                    btrfs_file_extent_type(leaf, fi))=
;
> >> +                    return -EUCLEAN;
> >> +            }
> >> +    } else {
> >> +            if (unlikely(item_size !=3D sizeof(*fi))) {
> >> +                    file_extent_err(leaf, slot,
> >>      "invalid item size for reg/prealloc file extent, have %u expect %=
zu",
> >> -                    item_size, sizeof(*fi));
> >> -            return -EUCLEAN;
> >> +                                    item_size, sizeof(*fi));
> >> +                    return -EUCLEAN;
> >> +            }
> >>      }
> >>      if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsi=
ze) ||
> >>                   CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sector=
size) ||
> >> diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrf=
s_tree.h
> >> index 7f3dffe6..4b4f45aa 100644
> >> --- a/kernel-shared/uapi/btrfs_tree.h
> >> +++ b/kernel-shared/uapi/btrfs_tree.h
> >> @@ -1066,6 +1066,24 @@ enum {
> >>      BTRFS_NR_FILE_EXTENT_TYPES =3D 3,
> >>   };
> >>
> >> +/*
> >> + * Currently just the FSCRYPT_SET_CONTEXT_MAX_SIZE, which is larger t=
han the
> >> + * current extent context size from fscrypt, so this should give us p=
lenty of
> >> + * breathing room for expansion later.
> >> + */
> >> +#define BTRFS_MAX_EXTENT_CTX_SIZE 40
> >> +
> >> +enum {
> >> +    BTRFS_ENCRYPTION_NONE,
> >> +    BTRFS_ENCRYPTION_FSCRYPT,
> >> +    BTRFS_NR_ENCRYPTION_TYPES,
> >> +};
> >> +
> >> +struct btrfs_encryption_info {
> >> +    __le32 size;
> >> +    __u8 context[0];
> >> +};
> >> +
> >>   struct btrfs_file_extent_item {
> >>      /*
> >>       * transaction id that created this extent
> >> @@ -1115,7 +1133,10 @@ struct btrfs_file_extent_item {
> >>       * always reflects the size uncompressed and without encoding.
> >>       */
> >>      __le64 num_bytes;
> >> -
> >> +    /*
> >> +     * the encryption info, if any
> >> +     */
> >> +    struct btrfs_encryption_info encryption_info[0];
> >
> > Looking at this again, adding variable length data will make it hard to
> > add more items to the file extent. We could not decide the version just
> > by the size, as done in other structures.
> >
>
> Can we put the encryption structure into a dedicated key? Like (ino,
> ENCRYPT_KEY, fileoff) key.
>
> By this we gain the ability to grab the size through btrfs_item_size(),
> and each file extent item also get their own encryption info.

Yeah, that would be definitely possible, but I'm not sure it is really
needed or we gain much this way. I'm open to suggestions here, check
the other email with further details.

> Thanks,
> Qu

