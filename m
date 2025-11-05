Return-Path: <linux-btrfs+bounces-18730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D2C35412
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 11:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2FB192405E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F29030C628;
	Wed,  5 Nov 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X4rxnmpt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE630C62B
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340132; cv=none; b=I8MJy472n/XYXQ/mJBTb2yxxEwroSGRNwcRCLqWwSdd6HZFxyK71cqDxJGBmm/zuz8EZDqgGB8xOgJ35pc0X4mF44NYeX2B94NH6CFc99IUgB03OgIi779w7ZJnP9fD4QS+/S/PD0FfzahzHsCUKjZr8PSdbPQ+NOvbpaep0jfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340132; c=relaxed/simple;
	bh=ZqFNBG5BY97lF/BNfaILQ6xjSLF80BjoMsb47BPuhdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/n0XI/37xBv7hBxVDU15h+P4Jd3IhGkZNFzWBvBQ6QvnZkbGJX2/yJiTRKa8DQeHIyv9pFVaBBuGe1SMILLd9lhgTlpYIjQdCVECc9k8ZPJi3/sHb4ZeuDyLZO0gvH00nEASnK2vnaqAaQZLFbtR143YvjK4QTcQpm+0t/EJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X4rxnmpt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ece1102998so4502214f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 02:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762340127; x=1762944927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaA3HV4lGJtR9IY7U/dPcSDrxFzojmcrgLhhrfGRpEs=;
        b=X4rxnmptP/jftqyLjQmjMWmY7/NY4Ax3CIb6YKBIiSrKPiH01cWbBONKmEwlRm0TCL
         EvzZWqqx4dcQaMot1ADDV2aXRfDp9DYmFtqRgMRHQ65Egxldx4B5adG17D5fAVjywcLR
         KqO8IUWJu6o/9oBeZoBvz0/1MrB+IHafZOv6GAszbV/Nrvy7ojoI/BKkYI3oagCLi97o
         VQwLHJMMM/ECbMjQoUDESj35u0T7nrSICu99OY4IGS1mnvuorMuUnZaL9YsuHJhgOkKQ
         C1FSmmw0ZtIUkaWj88/SG/d9CAumhC4DAGPyr8PnJOIb2RUVjMCNYvuAPeoyuoZ0nfr3
         ly6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762340127; x=1762944927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaA3HV4lGJtR9IY7U/dPcSDrxFzojmcrgLhhrfGRpEs=;
        b=wqCraty/EJAGG1ie6hw00PZe4dRx+0/thbjmfJVNW5bhR/UXkNsK13fuSku9EQOCgz
         idAOZfNRb2DbZWV53SaosEZuABbE27S6RIzkSwCU80nAUHLKntQazlSvvS/5CdVfiHyU
         wHCY3uNXlnhGE5qdEU0o8LXHgC5h9hu+kiu+d1F0dRIlMyeatZGmKl20hyRVPaaFOzEK
         y4YoEMef326ndEBcwndi3Gvmd6WCQ/H0Pvd/LyOS0Xh+TETPrvsmZyQRZJ7x+kw7S2RL
         cQ4f5r8hTSrJUs2yVaNukCnKrv1r1R0FFP2yvX4KCvTIA6yuMR2bsRNOjs/XtYJM7rOU
         RCFw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4bjxALqWOSjpb2mR9zmUbMMrwtFL7qa/H7m/quicwRVb69HNpPm0igycHHYFTGkX+hT5GRCm+XKkDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUt6P/6Id7SAyz5QajY1o0BO1xNhVx05ROElyXKEjYPMAvU2QP
	O7G76Z44MJOeFhb4mqjxAs/rK9AmDfhFHFDEk8+gqhlO01Vsv3g/Vkt5ZPPL6modiCqnqZiy9lE
	NoQ8VR+Gwh4ycPxBFosSq/JV164L6NU90n67hRbJJsg==
X-Gm-Gg: ASbGncthFiaVnF0KPVMuguLePAdgTkE1qYiH1++Wokqakh0FKP6n4jlSMjJ1cVw6A43
	RI82umibD8fVySZJQHoTkhiNa1jFZIRPB1ycq6N6qWA4mlMlS2qW5KrepfOvvwQb2K2V1/L7Cfa
	aDx9mtZq7D01Vy3cDfReY3Wl0yAmfpkuqrqzTkEkfE0rIGKQtPIE8LDZw0CS1k0ppOgiWyQ6amL
	iYGkwSHLTgNxz90qFy4mJy7doixV4xZq8qedwA3JoVEJhINx87gJTEmX1F6sz9VoVn17SCaSA21
	8sJRm0qRhp/KmQAQZReTjl0CvC+bDgDJJDU6ZV1VxdOofD3fhgHagtKo/g==
X-Google-Smtp-Source: AGHT+IEC6a5h132I0l0LiBjFbTZkFYmU4/1X57TkQN8FgmRMsz1kDXHCZwGDfNlMNIEfxJMg6kC9YJ4z5elW4iu1sXA=
X-Received: by 2002:a05:6000:184e:b0:429:bc68:6c95 with SMTP id
 ffacd0b85a97d-429e330ab3dmr2257656f8f.47.1762340126866; Wed, 05 Nov 2025
 02:55:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <20251015121157.1348124-4-neelx@suse.com>
 <20251024212920.GE20913@twin.jikos.cz> <CAPjX3Fc6abzXgE+_S6tKjmh9uUmsYo+UUE+5V8uGMK0QqLAKbg@mail.gmail.com>
 <f0f633d6-f0e0-4d4c-98cb-096afe77f330@gmx.com>
In-Reply-To: <f0f633d6-f0e0-4d4c-98cb-096afe77f330@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 11:55:15 +0100
X-Gm-Features: AWmQ_bkB1bX-GeKVSNWBemaP_x5lpB90-CMKrzIuGS9aboDQZHrUqz7H-TfQ68Q
Message-ID: <CAPjX3FfqvOMndYY6Ai9qVgaHX_y8PV=8i4_aMGGOvGcUCOj9ig@mail.gmail.com>
Subject: Re: [PATCH 3/8] btrfs-progs: start tracking extent encryption context info
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Nov 2025 at 10:12, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> =E5=9C=A8 2025/11/5 18:52, Daniel Vacek =E5=86=99=E9=81=93:
> > On Fri, 24 Oct 2025 at 23:29, David Sterba <dsterba@suse.cz> wrote:
> >>
> >> On Wed, Oct 15, 2025 at 02:11:51PM +0200, Daniel Vacek wrote:
> >>> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >>>
> >>> This recapitulates the kernel change named 'btrfs: start tracking ext=
ent
> >>> encryption context info".
> >>>
> >>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >>> ---
> >>>   kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
> >>>   kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++---=
---
> >>>   kernel-shared/uapi/btrfs_tree.h | 23 +++++++++++-
> >>>   3 files changed, 118 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
> >>> index cb96f3e2..5d90be76 100644
> >>> --- a/kernel-shared/accessors.h
> >>> +++ b/kernel-shared/accessors.h
> >>> @@ -935,6 +935,9 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generati=
on, struct btrfs_super_block,
> >>>   BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_=
block,
> >>>                         nr_global_roots, 64);
> >>>
> >>> +/* struct btrfs_file_extent_encryption_info */
> >>> +BTRFS_SETGET_FUNCS(encryption_info_size, struct btrfs_encryption_inf=
o, size, 32);
> >>> +
> >>>   /* struct btrfs_file_extent_item */
> >>>   BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_=
extent_item,
> >>>                         type, 8);
> >>> @@ -973,6 +976,46 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struc=
t btrfs_file_extent_item,
> >>>   BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_ex=
tent_item,
> >>>                   other_encoding, 16);
> >>>
> >>> +static inline struct btrfs_encryption_info *btrfs_file_extent_encryp=
tion_info(
> >>> +                                     const struct btrfs_file_extent_=
item *ei)
> >>> +{
> >>> +     unsigned long offset =3D (unsigned long)ei;
> >>> +
> >>> +     offset +=3D offsetof(struct btrfs_file_extent_item, encryption_=
info);
> >>> +     return (struct btrfs_encryption_info *)offset;
> >>> +}
> >>> +
> >>> +static inline unsigned long btrfs_file_extent_encryption_ctx_offset(
> >>> +                                     const struct btrfs_file_extent_=
item *ei)
> >>> +{
> >>> +     unsigned long offset =3D (unsigned long)ei;
> >>> +
> >>> +     offset +=3D offsetof(struct btrfs_file_extent_item, encryption_=
info);
> >>> +     return offset + offsetof(struct btrfs_encryption_info, context)=
;
> >>> +}
> >>> +
> >>> +static inline u32 btrfs_file_extent_encryption_ctx_size(
> >>> +                                     const struct extent_buffer *eb,
> >>> +                                     const struct btrfs_file_extent_=
item *ei)
> >>> +{
> >>> +     return btrfs_encryption_info_size(eb, btrfs_file_extent_encrypt=
ion_info(ei));
> >>> +}
> >>> +
> >>> +static inline void btrfs_set_file_extent_encryption_ctx_size(
> >>> +                                     struct extent_buffer *eb,
> >>> +                                     struct btrfs_file_extent_item *=
ei,
> >>> +                                     u32 val)
> >>> +{
> >>> +     btrfs_set_encryption_info_size(eb, btrfs_file_extent_encryption=
_info(ei), val);
> >>> +}
> >>> +
> >>> +static inline u32 btrfs_file_extent_encryption_info_size(
> >>> +                                     const struct extent_buffer *eb,
> >>> +                                     const struct btrfs_file_extent_=
item *ei)
> >>> +{
> >>> +     return btrfs_encryption_info_size(eb, btrfs_file_extent_encrypt=
ion_info(ei));
> >>> +}
> >>> +
> >>>   /* btrfs_qgroup_status_item */
> >>>   BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_st=
atus_item,
> >>>                   generation, 64);
> >>> diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checke=
r.c
> >>> index ccc1f1ea..93073979 100644
> >>> --- a/kernel-shared/tree-checker.c
> >>> +++ b/kernel-shared/tree-checker.c
> >>> @@ -242,6 +242,8 @@ static int check_extent_data_item(struct extent_b=
uffer *leaf,
> >>>        u32 sectorsize =3D fs_info->sectorsize;
> >>>        u32 item_size =3D btrfs_item_size(leaf, slot);
> >>>        u64 extent_end;
> >>> +     u8 policy;
> >>> +     u8 fe_type;
> >>>
> >>>        if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
> >>>                file_extent_err(leaf, slot,
> >>> @@ -272,12 +274,12 @@ static int check_extent_data_item(struct extent=
_buffer *leaf,
> >>>                                SZ_4K);
> >>>                return -EUCLEAN;
> >>>        }
> >>> -     if (unlikely(btrfs_file_extent_type(leaf, fi) >=3D
> >>> -                  BTRFS_NR_FILE_EXTENT_TYPES)) {
> >>> +
> >>> +     fe_type =3D btrfs_file_extent_type(leaf, fi);
> >>> +     if (unlikely(fe_type >=3D BTRFS_NR_FILE_EXTENT_TYPES)) {
> >>>                file_extent_err(leaf, slot,
> >>>                "invalid type for file extent, have %u expect range [0=
, %u]",
> >>> -                     btrfs_file_extent_type(leaf, fi),
> >>> -                     BTRFS_NR_FILE_EXTENT_TYPES - 1);
> >>> +                     fe_type, BTRFS_NR_FILE_EXTENT_TYPES - 1);
> >>>                return -EUCLEAN;
> >>>        }
> >>>
> >>> @@ -293,10 +295,11 @@ static int check_extent_data_item(struct extent=
_buffer *leaf,
> >>>                        BTRFS_NR_COMPRESS_TYPES - 1);
> >>>                return -EUCLEAN;
> >>>        }
> >>> -     if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
> >>> +     policy =3D btrfs_file_extent_encryption(leaf, fi);
> >>> +     if (unlikely(policy >=3D BTRFS_NR_ENCRYPTION_TYPES)) {
> >>>                file_extent_err(leaf, slot,
> >>> -                     "invalid encryption for file extent, have %u ex=
pect 0",
> >>> -                     btrfs_file_extent_encryption(leaf, fi));
> >>> +                     "invalid encryption for file extent, have %u ex=
pect range [0, %u]",
> >>> +                     policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
> >>>                return -EUCLEAN;
> >>>        }
> >>>        if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXTENT_=
INLINE) {
> >>> @@ -325,12 +328,50 @@ static int check_extent_data_item(struct extent=
_buffer *leaf,
> >>>                return 0;
> >>>        }
> >>>
> >>> -     /* Regular or preallocated extent has fixed item size */
> >>> -     if (unlikely(item_size !=3D sizeof(*fi))) {
> >>> -             file_extent_err(leaf, slot,
> >>> +     if (policy =3D=3D BTRFS_ENCRYPTION_FSCRYPT) {
> >>> +             size_t fe_size =3D sizeof(*fi) + sizeof(struct btrfs_en=
cryption_info);
> >>> +             u32 ctxsize;
> >>> +
> >>> +             if (unlikely(item_size < fe_size)) {
> >>> +                     file_extent_err(leaf, slot,
> >>> +     "invalid item size for encrypted file extent, have %u expect =
=3D %zu + size of u32",
> >>> +                                     item_size, sizeof(*fi));
> >>> +                     return -EUCLEAN;
> >>> +             }
> >>> +
> >>> +             ctxsize =3D btrfs_file_extent_encryption_info_size(leaf=
, fi);
> >>> +             if (unlikely(item_size !=3D (fe_size + ctxsize))) {
> >>> +                     file_extent_err(leaf, slot,
> >>> +     "invalid item size for encrypted file extent, have %u expect =
=3D %zu + context of size %u",
> >>> +                                     item_size, fe_size, ctxsize);
> >>> +                     return -EUCLEAN;
> >>> +             }
> >>> +
> >>> +             if (unlikely(ctxsize > BTRFS_MAX_EXTENT_CTX_SIZE)) {
> >>> +                     file_extent_err(leaf, slot,
> >>> +     "invalid file extent context size, have %u expect a maximum of =
%u",
> >>> +                                     ctxsize, BTRFS_MAX_EXTENT_CTX_S=
IZE);
> >>> +                     return -EUCLEAN;
> >>> +             }
> >>> +
> >>> +             /*
> >>> +              * Only regular and prealloc extents should have an enc=
ryption
> >>> +              * context.
> >>> +              */
> >>> +             if (unlikely(fe_type !=3D BTRFS_FILE_EXTENT_REG &&
> >>> +                          fe_type !=3D BTRFS_FILE_EXTENT_PREALLOC)) =
{
> >>> +                     file_extent_err(leaf, slot,
> >>> +             "invalid type for encrypted file extent, have %u",
> >>> +                                     btrfs_file_extent_type(leaf, fi=
));
> >>> +                     return -EUCLEAN;
> >>> +             }
> >>> +     } else {
> >>> +             if (unlikely(item_size !=3D sizeof(*fi))) {
> >>> +                     file_extent_err(leaf, slot,
> >>>        "invalid item size for reg/prealloc file extent, have %u expec=
t %zu",
> >>> -                     item_size, sizeof(*fi));
> >>> -             return -EUCLEAN;
> >>> +                                     item_size, sizeof(*fi));
> >>> +                     return -EUCLEAN;
> >>> +             }
> >>>        }
> >>>        if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, secto=
rsize) ||
> >>>                     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sec=
torsize) ||
> >>> diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btr=
fs_tree.h
> >>> index 7f3dffe6..4b4f45aa 100644
> >>> --- a/kernel-shared/uapi/btrfs_tree.h
> >>> +++ b/kernel-shared/uapi/btrfs_tree.h
> >>> @@ -1066,6 +1066,24 @@ enum {
> >>>        BTRFS_NR_FILE_EXTENT_TYPES =3D 3,
> >>>   };
> >>>
> >>> +/*
> >>> + * Currently just the FSCRYPT_SET_CONTEXT_MAX_SIZE, which is larger =
than the
> >>> + * current extent context size from fscrypt, so this should give us =
plenty of
> >>> + * breathing room for expansion later.
> >>> + */
> >>> +#define BTRFS_MAX_EXTENT_CTX_SIZE 40
> >>> +
> >>> +enum {
> >>> +     BTRFS_ENCRYPTION_NONE,
> >>> +     BTRFS_ENCRYPTION_FSCRYPT,
> >>> +     BTRFS_NR_ENCRYPTION_TYPES,
> >>> +};
> >>> +
> >>> +struct btrfs_encryption_info {
> >>> +     __le32 size;
> >>> +     __u8 context[0];
> >>> +};
> >>> +
> >>>   struct btrfs_file_extent_item {
> >>>        /*
> >>>         * transaction id that created this extent
> >>> @@ -1115,7 +1133,10 @@ struct btrfs_file_extent_item {
> >>>         * always reflects the size uncompressed and without encoding.
> >>>         */
> >>>        __le64 num_bytes;
> >>> -
> >>> +     /*
> >>> +      * the encryption info, if any
> >>> +      */
> >>> +     struct btrfs_encryption_info encryption_info[0];
> >>
> >> Looking at this again, adding variable length data will make it hard t=
o
> >> add more items to the file extent. We could not decide the version jus=
t
> >> by the size, as done in other structures.
> >
> > Checking the details of btrfs_file_extent_item I understand the item
> > is already variable size in case of inline extent.
>
> Yeah, but I'm not sure if that is a good example to follow, or a bad
> example to avoid.
>
> The biggest concern is for encrypted inline data extents.
> We need to put two variable sized data into a single item.
> (I know there are examples like btrfs_dir_item for XATTR, but again not
> sure if we should really follow that)

Just for the record, with the state of the patches as of now, inline
extent encryption is not supported. And for example ext4 also merges
the encryption context with the inline data.
But if we wanted to implement encrypted inline extents it may be
easier for us to just add a new key storing the context. So perhaps we
can do it right away to cover all the cases in a generic way.

> In that case the structure definition will not help, and you have to
> determine where to put the appended encryption info, either before the
> inlined data, or before it.
>
> And all the extra sequence info must be implemented in extra comments,
> which is way harder to read/understand.
>  From this point of view, the original inline extent usage of
> btrfs_file_extent_item is already an example to avoid.
>
>
> But sure, the appending solution will save us 25 bytes per file extent
> item, thus it definitely has its benefit.
>
> I belive David will do final call, trading off between readability or
> space saving (and more locality and less key search for encrypted file
> extents).
>
> Although I prefer the dedicated key solution for readability, I'm fine
> to accept either solution.
>
> Thanks,
> Qu
>
>
> > IIUC, that means that versioning based purely on item size is already
> > not possible for inline file extents.
> > So in the case of regular one optionally adding the encryption context
> > seems similar to adding the file data for the inline case.
> > And it still makes sense to me keeping the
> >
> > Perhaps the spare field `other_encoding` could eventually be used for
> > versioning if ever needed?
> >
> > Let me know if you'd rather add a dedicated key for the encryption
> > context as Qu suggested. To me it still kind of makes sense to keep it
> > packed after the file extent info, but I'll be happy with both ways.
> >
>

