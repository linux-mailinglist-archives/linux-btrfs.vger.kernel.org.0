Return-Path: <linux-btrfs+bounces-19377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D2C8D60E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 09:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 673964E6F50
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1874320A2E;
	Thu, 27 Nov 2025 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RzezFmla"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4FD31DDA4
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232817; cv=none; b=fSbjhjyD7l7z7JEBWxI/WbraE5Eq4/OYhcO/5Od7ZYYLakYbDZjdcd2nG2pq8tXwu+v63NO1qjlXcpRaKfktQJDJP7YOT288xO9ytFt6c/iwgcpnf5jYCqzj5sR3EbVXG2g58jjZtycs+4JVuz6QKz7ygZgxOS/4anV7VKbbNQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232817; c=relaxed/simple;
	bh=bHIxcWK83IPlUjvTYyNnd0G/cf8mv10scmwaMLEvI7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/aCVrDoY7rMk3EN17M9yv4lWz1pqvfkaymbH7CY8LhzzYF2XqdpwgkD6AMZ/PykH0Mk+q+3K0a7ofRBORupjqvgFquWrlBwKpNs+BqVQBfgw8xraYw5pRz7r966Zquh0w5hG7DgtOgrdhFG/BNyWDqt1jmvbmK3KSnX+/SVssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RzezFmla; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso384573f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764232813; x=1764837613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dR/rI0k27VpjFJyKIKVrmsZByrDSxYf4xOQvDAiKNU=;
        b=RzezFmlaaLC1M8DuY/srtSKfOJ3oLDoamLSwgNFjB/Jrg6fYgmMTU2APKiCYkbtJ/8
         Tucbf5LFkJeFj9cWLUw7FQ+fy9O744ME0F1k2L0P0PyqNDExVmVGyuoP+G1HNAW62Jl6
         lWuYLiKTDRDrbbVrMKsyyIsX9C3llDtfSLv40tG5/SVxqJroY503jEsXIbMfYEYhkPBc
         BPpp7RXpQrWLrhAITnrx8rsw63EimmDeknXytOtMoBa1pMJhcgt1RYnAQgzTOgwjv9/e
         anI+oY5LASlQMjgrCHVjaD4mMZfQvdOJMKC8xsdy2mPcx1fp0RLnZ/SOsMcYt+h574QF
         VRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764232813; x=1764837613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dR/rI0k27VpjFJyKIKVrmsZByrDSxYf4xOQvDAiKNU=;
        b=F2ZSLczKM3MHJezm370AaMrcJzHu65VlQHNIkHb4F145mJa5UnDccqahChoHZ6+91c
         t/xBmO6GeRb0enp0LqAzezBmnLKpFWmrJXlnRDZI3qgKljkwLMZAXgpnpUUBWNpb3b0e
         JY8DFti8FW/KHE7LNZRivNKjI6eFYuK1fVqCF+hdb+OXC3upZ6AAfl9KYRzVBYYXk1TL
         4GrBOJaSoi0qxBDFhMq/paO4hh60+5Zx10KcvpG+X9Lq6Otb0mzC5ONe9/2uHsoHYiWb
         i5LmiszxJtxpQbn6sarE6npinQZGZTZTrz5UKfEw2S50YAsKMjPQAObmiiUNLYmjFaiD
         fMuw==
X-Forwarded-Encrypted: i=1; AJvYcCXyibVl7BmcQV8ULyxFVwF8FziwSZ3QWv3Yie1xaUC4zpUhfE0bkCFVND51ai5ZqPttRAJQujgyTviW8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPC2VGV2HgGBRaUntBramDnKhMTdJU3MapjV4KLZaf+fpM4ZC
	lFYsZkLEty4/9ZpeVqLSVekVJvh+nzW7YFGezSRu3nrRo15dS842ik5ElbQxv1kS3ZqkgPKfAgm
	8EUoLih38/FXV8km6q1l4E23rY4Otoqme1m+tEjPU6Q==
X-Gm-Gg: ASbGnctgg94zz0z5J75mdMftDLL6gh1nQUqsAVndUt0wwXERn9Pr+qZX6KHQ0DbCoZC
	3JrTGvaJDVElklfWgRM0Y8CZ77gvUtpfQZTX3/FaC14MALs8S/0ytQRchhpzfxJD/tdjRAacQ39
	Fwg6NzKCGSpGmkw+UQyfLBFtOFipmeQbyLZwYMpwTfS3a6V+iZHMZiiE/tixuwzfOGc4AMINkc0
	hnWfTACVXkbBRnr2W4pCI715EW2e5Ry1lJ9aNTbwZxzhlxhBZyqBR443zahW9xR/eu5w1o9RTDs
	W5fTFQHd11EIxXtdWZlbakSXf+D1NNPfrLuJ+OL6Rfn1ElkZAL4SNYj3CZA/Zo+i9uE0
X-Google-Smtp-Source: AGHT+IH7okXbSZWmASINvtHenAOWTGIJifTNK+4K84aArU7mw5Kcqrx+ZoQieon4aJW2YCC8HURi3JS9jVIc6Q5ZGas=
X-Received: by 2002:a05:6000:2681:b0:429:d0f0:6dd1 with SMTP id
 ffacd0b85a97d-42cc1d618b2mr23691493f8f.58.1764232812739; Thu, 27 Nov 2025
 00:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <20251015121157.1348124-4-neelx@suse.com>
 <20251024212920.GE20913@twin.jikos.cz> <CAPjX3Fc6abzXgE+_S6tKjmh9uUmsYo+UUE+5V8uGMK0QqLAKbg@mail.gmail.com>
 <f0f633d6-f0e0-4d4c-98cb-096afe77f330@gmx.com> <CAPjX3FfqvOMndYY6Ai9qVgaHX_y8PV=8i4_aMGGOvGcUCOj9ig@mail.gmail.com>
 <20251126141142.GB13846@suse.cz>
In-Reply-To: <20251126141142.GB13846@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 27 Nov 2025 09:40:01 +0100
X-Gm-Features: AWmQ_bmV7o0P8vBFQs1GarIbYvXPZ_tt6cviIt1QtsC8FmQ4Il4z__YseZNSr_Y
Message-ID: <CAPjX3FevTcNtE8yFVJR8xFa0K_-iFDqbw1tWg=tn9==XHPQgbg@mail.gmail.com>
Subject: Re: [PATCH 3/8] btrfs-progs: start tracking extent encryption context info
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 at 15:11, David Sterba <dsterba@suse.cz> wrote:
> On Wed, Nov 05, 2025 at 11:55:15AM +0100, Daniel Vacek wrote:
> > On Wed, 5 Nov 2025 at 10:12, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > =E5=9C=A8 2025/11/5 18:52, Daniel Vacek =E5=86=99=E9=81=93:
> > > > On Fri, 24 Oct 2025 at 23:29, David Sterba <dsterba@suse.cz> wrote:
> > > >>
> > > >> On Wed, Oct 15, 2025 at 02:11:51PM +0200, Daniel Vacek wrote:
> > > >>> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > > >>>
> > > >>> This recapitulates the kernel change named 'btrfs: start tracking=
 extent
> > > >>> encryption context info".
> > > >>>
> > > >>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > > >>> ---
> > > >>>   kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
> > > >>>   kernel-shared/tree-checker.c    | 65 ++++++++++++++++++++++++++=
+------
> > > >>>   kernel-shared/uapi/btrfs_tree.h | 23 +++++++++++-
> > > >>>   3 files changed, 118 insertions(+), 13 deletions(-)
> > > >>>
> > > >>> diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.=
h
> > > >>> index cb96f3e2..5d90be76 100644
> > > >>> --- a/kernel-shared/accessors.h
> > > >>> +++ b/kernel-shared/accessors.h
> > > >>> @@ -935,6 +935,9 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_gene=
ration, struct btrfs_super_block,
> > > >>>   BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_su=
per_block,
> > > >>>                         nr_global_roots, 64);
> > > >>>
> > > >>> +/* struct btrfs_file_extent_encryption_info */
> > > >>> +BTRFS_SETGET_FUNCS(encryption_info_size, struct btrfs_encryption=
_info, size, 32);
> > > >>> +
> > > >>>   /* struct btrfs_file_extent_item */
> > > >>>   BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_f=
ile_extent_item,
> > > >>>                         type, 8);
> > > >>> @@ -973,6 +976,46 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, s=
truct btrfs_file_extent_item,
> > > >>>   BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_fil=
e_extent_item,
> > > >>>                   other_encoding, 16);
> > > >>>
> > > >>> +static inline struct btrfs_encryption_info *btrfs_file_extent_en=
cryption_info(
> > > >>> +                                     const struct btrfs_file_ext=
ent_item *ei)
> > > >>> +{
> > > >>> +     unsigned long offset =3D (unsigned long)ei;
> > > >>> +
> > > >>> +     offset +=3D offsetof(struct btrfs_file_extent_item, encrypt=
ion_info);
> > > >>> +     return (struct btrfs_encryption_info *)offset;
> > > >>> +}
> > > >>> +
> > > >>> +static inline unsigned long btrfs_file_extent_encryption_ctx_off=
set(
> > > >>> +                                     const struct btrfs_file_ext=
ent_item *ei)
> > > >>> +{
> > > >>> +     unsigned long offset =3D (unsigned long)ei;
> > > >>> +
> > > >>> +     offset +=3D offsetof(struct btrfs_file_extent_item, encrypt=
ion_info);
> > > >>> +     return offset + offsetof(struct btrfs_encryption_info, cont=
ext);
> > > >>> +}
> > > >>> +
> > > >>> +static inline u32 btrfs_file_extent_encryption_ctx_size(
> > > >>> +                                     const struct extent_buffer =
*eb,
> > > >>> +                                     const struct btrfs_file_ext=
ent_item *ei)
> > > >>> +{
> > > >>> +     return btrfs_encryption_info_size(eb, btrfs_file_extent_enc=
ryption_info(ei));
> > > >>> +}
> > > >>> +
> > > >>> +static inline void btrfs_set_file_extent_encryption_ctx_size(
> > > >>> +                                     struct extent_buffer *eb,
> > > >>> +                                     struct btrfs_file_extent_it=
em *ei,
> > > >>> +                                     u32 val)
> > > >>> +{
> > > >>> +     btrfs_set_encryption_info_size(eb, btrfs_file_extent_encryp=
tion_info(ei), val);
> > > >>> +}
> > > >>> +
> > > >>> +static inline u32 btrfs_file_extent_encryption_info_size(
> > > >>> +                                     const struct extent_buffer =
*eb,
> > > >>> +                                     const struct btrfs_file_ext=
ent_item *ei)
> > > >>> +{
> > > >>> +     return btrfs_encryption_info_size(eb, btrfs_file_extent_enc=
ryption_info(ei));
> > > >>> +}
> > > >>> +
> > > >>>   /* btrfs_qgroup_status_item */
> > > >>>   BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgrou=
p_status_item,
> > > >>>                   generation, 64);
> > > >>> diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-ch=
ecker.c
> > > >>> index ccc1f1ea..93073979 100644
> > > >>> --- a/kernel-shared/tree-checker.c
> > > >>> +++ b/kernel-shared/tree-checker.c
> > > >>> @@ -242,6 +242,8 @@ static int check_extent_data_item(struct exte=
nt_buffer *leaf,
> > > >>>        u32 sectorsize =3D fs_info->sectorsize;
> > > >>>        u32 item_size =3D btrfs_item_size(leaf, slot);
> > > >>>        u64 extent_end;
> > > >>> +     u8 policy;
> > > >>> +     u8 fe_type;
> > > >>>
> > > >>>        if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
> > > >>>                file_extent_err(leaf, slot,
> > > >>> @@ -272,12 +274,12 @@ static int check_extent_data_item(struct ex=
tent_buffer *leaf,
> > > >>>                                SZ_4K);
> > > >>>                return -EUCLEAN;
> > > >>>        }
> > > >>> -     if (unlikely(btrfs_file_extent_type(leaf, fi) >=3D
> > > >>> -                  BTRFS_NR_FILE_EXTENT_TYPES)) {
> > > >>> +
> > > >>> +     fe_type =3D btrfs_file_extent_type(leaf, fi);
> > > >>> +     if (unlikely(fe_type >=3D BTRFS_NR_FILE_EXTENT_TYPES)) {
> > > >>>                file_extent_err(leaf, slot,
> > > >>>                "invalid type for file extent, have %u expect rang=
e [0, %u]",
> > > >>> -                     btrfs_file_extent_type(leaf, fi),
> > > >>> -                     BTRFS_NR_FILE_EXTENT_TYPES - 1);
> > > >>> +                     fe_type, BTRFS_NR_FILE_EXTENT_TYPES - 1);
> > > >>>                return -EUCLEAN;
> > > >>>        }
> > > >>>
> > > >>> @@ -293,10 +295,11 @@ static int check_extent_data_item(struct ex=
tent_buffer *leaf,
> > > >>>                        BTRFS_NR_COMPRESS_TYPES - 1);
> > > >>>                return -EUCLEAN;
> > > >>>        }
> > > >>> -     if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
> > > >>> +     policy =3D btrfs_file_extent_encryption(leaf, fi);
> > > >>> +     if (unlikely(policy >=3D BTRFS_NR_ENCRYPTION_TYPES)) {
> > > >>>                file_extent_err(leaf, slot,
> > > >>> -                     "invalid encryption for file extent, have %=
u expect 0",
> > > >>> -                     btrfs_file_extent_encryption(leaf, fi));
> > > >>> +                     "invalid encryption for file extent, have %=
u expect range [0, %u]",
> > > >>> +                     policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
> > > >>>                return -EUCLEAN;
> > > >>>        }
> > > >>>        if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXT=
ENT_INLINE) {
> > > >>> @@ -325,12 +328,50 @@ static int check_extent_data_item(struct ex=
tent_buffer *leaf,
> > > >>>                return 0;
> > > >>>        }
> > > >>>
> > > >>> -     /* Regular or preallocated extent has fixed item size */
> > > >>> -     if (unlikely(item_size !=3D sizeof(*fi))) {
> > > >>> -             file_extent_err(leaf, slot,
> > > >>> +     if (policy =3D=3D BTRFS_ENCRYPTION_FSCRYPT) {
> > > >>> +             size_t fe_size =3D sizeof(*fi) + sizeof(struct btrf=
s_encryption_info);
> > > >>> +             u32 ctxsize;
> > > >>> +
> > > >>> +             if (unlikely(item_size < fe_size)) {
> > > >>> +                     file_extent_err(leaf, slot,
> > > >>> +     "invalid item size for encrypted file extent, have %u expec=
t =3D %zu + size of u32",
> > > >>> +                                     item_size, sizeof(*fi));
> > > >>> +                     return -EUCLEAN;
> > > >>> +             }
> > > >>> +
> > > >>> +             ctxsize =3D btrfs_file_extent_encryption_info_size(=
leaf, fi);
> > > >>> +             if (unlikely(item_size !=3D (fe_size + ctxsize))) {
> > > >>> +                     file_extent_err(leaf, slot,
> > > >>> +     "invalid item size for encrypted file extent, have %u expec=
t =3D %zu + context of size %u",
> > > >>> +                                     item_size, fe_size, ctxsize=
);
> > > >>> +                     return -EUCLEAN;
> > > >>> +             }
> > > >>> +
> > > >>> +             if (unlikely(ctxsize > BTRFS_MAX_EXTENT_CTX_SIZE)) =
{
> > > >>> +                     file_extent_err(leaf, slot,
> > > >>> +     "invalid file extent context size, have %u expect a maximum=
 of %u",
> > > >>> +                                     ctxsize, BTRFS_MAX_EXTENT_C=
TX_SIZE);
> > > >>> +                     return -EUCLEAN;
> > > >>> +             }
> > > >>> +
> > > >>> +             /*
> > > >>> +              * Only regular and prealloc extents should have an=
 encryption
> > > >>> +              * context.
> > > >>> +              */
> > > >>> +             if (unlikely(fe_type !=3D BTRFS_FILE_EXTENT_REG &&
> > > >>> +                          fe_type !=3D BTRFS_FILE_EXTENT_PREALLO=
C)) {
> > > >>> +                     file_extent_err(leaf, slot,
> > > >>> +             "invalid type for encrypted file extent, have %u",
> > > >>> +                                     btrfs_file_extent_type(leaf=
, fi));
> > > >>> +                     return -EUCLEAN;
> > > >>> +             }
> > > >>> +     } else {
> > > >>> +             if (unlikely(item_size !=3D sizeof(*fi))) {
> > > >>> +                     file_extent_err(leaf, slot,
> > > >>>        "invalid item size for reg/prealloc file extent, have %u e=
xpect %zu",
> > > >>> -                     item_size, sizeof(*fi));
> > > >>> -             return -EUCLEAN;
> > > >>> +                                     item_size, sizeof(*fi));
> > > >>> +                     return -EUCLEAN;
> > > >>> +             }
> > > >>>        }
> > > >>>        if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, s=
ectorsize) ||
> > > >>>                     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr,=
 sectorsize) ||
> > > >>> diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi=
/btrfs_tree.h
> > > >>> index 7f3dffe6..4b4f45aa 100644
> > > >>> --- a/kernel-shared/uapi/btrfs_tree.h
> > > >>> +++ b/kernel-shared/uapi/btrfs_tree.h
> > > >>> @@ -1066,6 +1066,24 @@ enum {
> > > >>>        BTRFS_NR_FILE_EXTENT_TYPES =3D 3,
> > > >>>   };
> > > >>>
> > > >>> +/*
> > > >>> + * Currently just the FSCRYPT_SET_CONTEXT_MAX_SIZE, which is lar=
ger than the
> > > >>> + * current extent context size from fscrypt, so this should give=
 us plenty of
> > > >>> + * breathing room for expansion later.
> > > >>> + */
> > > >>> +#define BTRFS_MAX_EXTENT_CTX_SIZE 40
> > > >>> +
> > > >>> +enum {
> > > >>> +     BTRFS_ENCRYPTION_NONE,
> > > >>> +     BTRFS_ENCRYPTION_FSCRYPT,
> > > >>> +     BTRFS_NR_ENCRYPTION_TYPES,
> > > >>> +};
> > > >>> +
> > > >>> +struct btrfs_encryption_info {
> > > >>> +     __le32 size;
> > > >>> +     __u8 context[0];
> > > >>> +};
> > > >>> +
> > > >>>   struct btrfs_file_extent_item {
> > > >>>        /*
> > > >>>         * transaction id that created this extent
> > > >>> @@ -1115,7 +1133,10 @@ struct btrfs_file_extent_item {
> > > >>>         * always reflects the size uncompressed and without encod=
ing.
> > > >>>         */
> > > >>>        __le64 num_bytes;
> > > >>> -
> > > >>> +     /*
> > > >>> +      * the encryption info, if any
> > > >>> +      */
> > > >>> +     struct btrfs_encryption_info encryption_info[0];
> > > >>
> > > >> Looking at this again, adding variable length data will make it ha=
rd to
> > > >> add more items to the file extent. We could not decide the version=
 just
> > > >> by the size, as done in other structures.
> > > >
> > > > Checking the details of btrfs_file_extent_item I understand the ite=
m
> > > > is already variable size in case of inline extent.
> > >
> > > Yeah, but I'm not sure if that is a good example to follow, or a bad
> > > example to avoid.
> > >
> > > The biggest concern is for encrypted inline data extents.
> > > We need to put two variable sized data into a single item.
> > > (I know there are examples like btrfs_dir_item for XATTR, but again n=
ot
> > > sure if we should really follow that)
> >
> > Just for the record, with the state of the patches as of now, inline
> > extent encryption is not supported. And for example ext4 also merges
> > the encryption context with the inline data.
> > But if we wanted to implement encrypted inline extents it may be
> > easier for us to just add a new key storing the context. So perhaps we
> > can do it right away to cover all the cases in a generic way.
>
> For the record, I think separate key/item is a better option.

I have got this implemented. Though I'm not sure I like the end
result. Basically each extent now creates two items for the meta
needed for an extent. This doubles tree operations and example result
looks like this (with patched btrfs-progs):

>         item 105 key (257 INODE_ITEM 0) itemoff 11219 itemsize 160
>                 generation 9 transid 9 size 86016 nbytes 81920
>                 block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>                 sequence 95 flags 0x1000(UNKNOWN: 0x1000)
>                 atime 1764179848.703684571 (2025-11-26 18:57:28)
>                 ctime 1764179848.789259149 (2025-11-26 18:57:28)
>                 mtime 1764179848.789259149 (2025-11-26 18:57:28)
>                 otime 1764179848.703684571 (2025-11-26 18:57:28)
>         item 106 key (257 INODE_REF 256) itemoff 11193 itemsize 26
>                 index 2 namelen 16 name: \270\2439\t\005\342\230\243\301~=
\363\f$\3608g
>         item 107 key (257 FSCRYPT_INODE_CTX 0) itemoff 11153 itemsize 40
>                 value: 020104020000000069b2f6edeee720cce0577937eb8a675177=
d5a7f82d59cb4c7c8c5a33fde3c603
>         item 108 key (257 FSCRYPT_CTX 4096) itemoff 11119 itemsize 34
>                 value: 010169b2f6edeee720cce0577937eb8a6751d0dd42ea7ba43e=
e8c55a2f79cbc890bd
>         item 109 key (257 FSCRYPT_CTX 8192) itemoff 11085 itemsize 34
>                 value: 010169b2f6edeee720cce0577937eb8a6751c49b3ed9999cfb=
684992b30e01cabab2
> <snip>
>         item 124 key (257 FSCRYPT_CTX 69632) itemoff 10575 itemsize 34
>                 value: 010169b2f6edeee720cce0577937eb8a6751da3728d22c66c1=
ae40d92d8b283cb393
>         item 125 key (257 FSCRYPT_CTX 73728) itemoff 10541 itemsize 34
>                 value: 010169b2f6edeee720cce0577937eb8a675189848f22c27c6b=
bbfb06fe521571658c
>         item 126 key (257 FSCRYPT_CTX 77824) itemoff 10507 itemsize 34
>                 value: 010169b2f6edeee720cce0577937eb8a67516c546baab142d3=
c37e64439c5d90f609
>         item 127 key (257 FSCRYPT_CTX 81920) itemoff 10473 itemsize 34
>                 value: 010169b2f6edeee720cce0577937eb8a6751d1a28c6fcd2ce1=
6b02858d614645f314
>         item 128 key (257 EXTENT_DATA 4096) itemoff 10420 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13787136 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>                 extent encryption 1 (fscrypt)
>         item 129 key (257 EXTENT_DATA 8192) itemoff 10367 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13778944 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>                 extent encryption 1 (fscrypt)
>         item 130 key (257 EXTENT_DATA 12288) itemoff 10314 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13770752 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>                 extent encryption 1 (fscrypt)
>         item 131 key (257 EXTENT_DATA 16384) itemoff 10261 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13762560 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>                 extent encryption 1 (fscrypt)
> <snip>
>         item 144 key (257 EXTENT_DATA 69632) itemoff 9572 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13656064 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>                 extent encryption 1 (fscrypt)
>         item 145 key (257 EXTENT_DATA 73728) itemoff 9519 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13647872 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>                 extent encryption 1 (fscrypt)
>         item 146 key (257 EXTENT_DATA 77824) itemoff 9466 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13639680 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>                 extent encryption 1 (fscrypt)
>         item 147 key (257 EXTENT_DATA 81920) itemoff 9413 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13631488 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>                 extent encryption 1 (fscrypt)

Basically the metadata needed for each extent is split into two keys.
That means that in some cases (which could actually be many cases)
getting the needed data for a given extent would end up reading from
two leaf nodes.

With this insight it actually makes more sense to append the
encryption context to the file extent item itself. We do this in a lot
of other keys as well. xattr dir items for another example. inode ref
itself as well. inlined data. Plain (not file) extent items, metadata
items... And so on and so on.

It seems to me we do this all the time, I'm not sure why the
opposition in this case?

The call is on you. I can send this version (after I make sure nothing
else broke) or the former one.

I'll also be happy to hear opinions from others. Qu expressed concerns
against inline crypt context before (the btrfs-progs implementation
needs to be further debugged for sure). Does it still hold with the
above being said?

--nX

