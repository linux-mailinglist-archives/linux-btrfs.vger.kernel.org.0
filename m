Return-Path: <linux-btrfs+bounces-18721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F859C34712
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 09:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249D218C2681
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C328A1E6;
	Wed,  5 Nov 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BdCk/b3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88459253B52
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330975; cv=none; b=GXee+SGA5cRe+LmY71C2hhkBe9Ngwf1dYpt4ffAzLv+Ypaz7WZC9gN32o/LZhd2Qwvz4Q8X6krwdBmJy/m+cBtZboKj/r+6A/qk9GlOTe7r6FZ3JoSDzKBWPKJEbU/DTf1n98ZQmycJymrRod9/MIe1I2OmIDq1Mou+MaJtI1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330975; c=relaxed/simple;
	bh=nqqcRSUGSdeq/2CR8egpYKSrsUABMcCv5Uy4CK97muo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsP74nYk33V5q1FnWIe8Nm07E9g7quCVyRibb4foVKPGpsPEys4apvqPs58PBckCXIaPUdWyG3AKa4HP3gzX5r/TntrxnQZEyRXIIU8g7svE3AQanQVxEPqrI110swGQAoTy7ZvNaU1vS+8ixP29PkCLmuNtftFTXH1RXqVpbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BdCk/b3r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112a73785so41395165e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 00:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762330972; x=1762935772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FAJaRmnk94mOJlM+A0FGtntBdKh41yED2Gdb/s5VerA=;
        b=BdCk/b3rgSVS5SrKa+VcsG+lCw+9QBVfkfUdh8oRe6w4yXlCJBwfrHwR96xnb5s9HS
         yK4zWfDDupyOjlbbdusxwHGtOdjXqQK8CejyEZd7EQiv3LeDOSSvLjFjBvsFW4+jHmVx
         oYSDPk5r/L2MWzKUxMuTpverebjI1MGCQBA+o8wxY/xrSc47aE+3+6y3ahRWIWyrS/dM
         vcuonZptgfxVyXI5b/r1zKkO0zpgh3MjrNi8OTmXy3LRbllHz5idyh4EnuCOlN100Ld9
         EbNmEq+/OBi4s2YLwlA3zjSF9LF3vbHF4HURTja1stE2LnPj+jjbemesAr5CPmTtoxxA
         nTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762330972; x=1762935772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAJaRmnk94mOJlM+A0FGtntBdKh41yED2Gdb/s5VerA=;
        b=oeVKHmCiNIYm3lAeQw47iE336Cb0RuF05/DyGNl5ckwtX1IEAhZCTlsaYzCU4llnKZ
         RjALkAj/fSGCigb2jav2oqg6esbTq5K7bWPtxJbjVA4QnpRIdTy+Eo1yt0GCAwt5tpYb
         iAi0KsFi7RXD0dDIvpayRymuc84UUQ+k7NpSw2d04w3kSWa+FgakRqJ4HPLU74X1UVbF
         cIuHiJcPOHnDrJ0A2q979bSA8EDzJ9DzGyXGB4AvpoXkrnN9MQ4kaJkPskmkWhn/m1HK
         CELJTnYL7rx666asrSb6UQP/srpFcrzqSSUH8qMf7pM3QSxAPpDyGDnGxquJSzxG4Amq
         Sj2g==
X-Forwarded-Encrypted: i=1; AJvYcCUqqeHlenepuQQOklgZ5gn2GaeZzm1i7e3VRzXPQpTJE48e2XFU0c5aa4LToq3fi5VO1gkXxQUQt2Yd1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWDzw5J2//irBICJS+UBKScZ3RS5gQjD8t3WVrHOnEoxtYgcv
	n6/Rj5EQGEnIenNxI9XuDyPx5sJsBbKo10HlVv8UyM51pBPC84YEphDXPe0mDUeSC37atb++9uW
	RZ9SptunxJJkmfMQ52+ImTFMHupuPmhyu3HCpYLzU1Q==
X-Gm-Gg: ASbGncslcBsBdyWwp4tWVZasysMzJGmAt9jOCQTk2CfJq8JEIDU++4hGXny/Qi11VFO
	ubdMjHZxyva6VouR30+E301emOUIonfAjXon2J8tPCLtD0Mv/c/T+gA7k2uf8eo3dM5JOjsFMHv
	tkrWurfGPmhvHqEC5bl1ONmgP9oEp1IQ3mPlqlnIW75jXoFP0f7lPfaOYTYNWm2JObTmoUzI4k/
	vHDOcApd1yW2twkPeE8yKN+pj0qSdkLc2eWKtuELHhKF8L+Kz9IVfbhZe7bWyR3aSqj5MdOSMFM
	Ssh+JUnF55+q0SSmjzEXgXMereyptljaLYEbrxfuraslTaXiRoj9wUmkSQ==
X-Google-Smtp-Source: AGHT+IG2BPYjMpAcFWDav7oNLJadTbPT/OsrMhEYC6kfOMKBLGwVD0l8m8RT5D9cTzFJ6FOyfxyiRx/t0V/o/KX9Ba8=
X-Received: by 2002:a05:600c:46ce:b0:471:d2d:ac42 with SMTP id
 5b1f17b1804b1-4775cdc8e30mr15694135e9.14.1762330971691; Wed, 05 Nov 2025
 00:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <20251015121157.1348124-4-neelx@suse.com>
 <20251024212920.GE20913@twin.jikos.cz>
In-Reply-To: <20251024212920.GE20913@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 09:22:40 +0100
X-Gm-Features: AWmQ_blksoI4BuCeYI-bot_nVxnp5r2H7SMeKvevVhwlMJrb_cmQP-oL1mr5pW4
Message-ID: <CAPjX3Fc6abzXgE+_S6tKjmh9uUmsYo+UUE+5V8uGMK0QqLAKbg@mail.gmail.com>
Subject: Re: [PATCH 3/8] btrfs-progs: start tracking extent encryption context info
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Oct 2025 at 23:29, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Oct 15, 2025 at 02:11:51PM +0200, Daniel Vacek wrote:
> > From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >
> > This recapitulates the kernel change named 'btrfs: start tracking extent
> > encryption context info".
> >
> > Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > ---
> >  kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
> >  kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++------
> >  kernel-shared/uapi/btrfs_tree.h | 23 +++++++++++-
> >  3 files changed, 118 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
> > index cb96f3e2..5d90be76 100644
> > --- a/kernel-shared/accessors.h
> > +++ b/kernel-shared/accessors.h
> > @@ -935,6 +935,9 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
> >  BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
> >                        nr_global_roots, 64);
> >
> > +/* struct btrfs_file_extent_encryption_info */
> > +BTRFS_SETGET_FUNCS(encryption_info_size, struct btrfs_encryption_info, size, 32);
> > +
> >  /* struct btrfs_file_extent_item */
> >  BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
> >                        type, 8);
> > @@ -973,6 +976,46 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
> >  BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
> >                  other_encoding, 16);
> >
> > +static inline struct btrfs_encryption_info *btrfs_file_extent_encryption_info(
> > +                                     const struct btrfs_file_extent_item *ei)
> > +{
> > +     unsigned long offset = (unsigned long)ei;
> > +
> > +     offset += offsetof(struct btrfs_file_extent_item, encryption_info);
> > +     return (struct btrfs_encryption_info *)offset;
> > +}
> > +
> > +static inline unsigned long btrfs_file_extent_encryption_ctx_offset(
> > +                                     const struct btrfs_file_extent_item *ei)
> > +{
> > +     unsigned long offset = (unsigned long)ei;
> > +
> > +     offset += offsetof(struct btrfs_file_extent_item, encryption_info);
> > +     return offset + offsetof(struct btrfs_encryption_info, context);
> > +}
> > +
> > +static inline u32 btrfs_file_extent_encryption_ctx_size(
> > +                                     const struct extent_buffer *eb,
> > +                                     const struct btrfs_file_extent_item *ei)
> > +{
> > +     return btrfs_encryption_info_size(eb, btrfs_file_extent_encryption_info(ei));
> > +}
> > +
> > +static inline void btrfs_set_file_extent_encryption_ctx_size(
> > +                                     struct extent_buffer *eb,
> > +                                     struct btrfs_file_extent_item *ei,
> > +                                     u32 val)
> > +{
> > +     btrfs_set_encryption_info_size(eb, btrfs_file_extent_encryption_info(ei), val);
> > +}
> > +
> > +static inline u32 btrfs_file_extent_encryption_info_size(
> > +                                     const struct extent_buffer *eb,
> > +                                     const struct btrfs_file_extent_item *ei)
> > +{
> > +     return btrfs_encryption_info_size(eb, btrfs_file_extent_encryption_info(ei));
> > +}
> > +
> >  /* btrfs_qgroup_status_item */
> >  BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
> >                  generation, 64);
> > diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
> > index ccc1f1ea..93073979 100644
> > --- a/kernel-shared/tree-checker.c
> > +++ b/kernel-shared/tree-checker.c
> > @@ -242,6 +242,8 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >       u32 sectorsize = fs_info->sectorsize;
> >       u32 item_size = btrfs_item_size(leaf, slot);
> >       u64 extent_end;
> > +     u8 policy;
> > +     u8 fe_type;
> >
> >       if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
> >               file_extent_err(leaf, slot,
> > @@ -272,12 +274,12 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >                               SZ_4K);
> >               return -EUCLEAN;
> >       }
> > -     if (unlikely(btrfs_file_extent_type(leaf, fi) >=
> > -                  BTRFS_NR_FILE_EXTENT_TYPES)) {
> > +
> > +     fe_type = btrfs_file_extent_type(leaf, fi);
> > +     if (unlikely(fe_type >= BTRFS_NR_FILE_EXTENT_TYPES)) {
> >               file_extent_err(leaf, slot,
> >               "invalid type for file extent, have %u expect range [0, %u]",
> > -                     btrfs_file_extent_type(leaf, fi),
> > -                     BTRFS_NR_FILE_EXTENT_TYPES - 1);
> > +                     fe_type, BTRFS_NR_FILE_EXTENT_TYPES - 1);
> >               return -EUCLEAN;
> >       }
> >
> > @@ -293,10 +295,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >                       BTRFS_NR_COMPRESS_TYPES - 1);
> >               return -EUCLEAN;
> >       }
> > -     if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
> > +     policy = btrfs_file_extent_encryption(leaf, fi);
> > +     if (unlikely(policy >= BTRFS_NR_ENCRYPTION_TYPES)) {
> >               file_extent_err(leaf, slot,
> > -                     "invalid encryption for file extent, have %u expect 0",
> > -                     btrfs_file_extent_encryption(leaf, fi));
> > +                     "invalid encryption for file extent, have %u expect range [0, %u]",
> > +                     policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
> >               return -EUCLEAN;
> >       }
> >       if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
> > @@ -325,12 +328,50 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >               return 0;
> >       }
> >
> > -     /* Regular or preallocated extent has fixed item size */
> > -     if (unlikely(item_size != sizeof(*fi))) {
> > -             file_extent_err(leaf, slot,
> > +     if (policy == BTRFS_ENCRYPTION_FSCRYPT) {
> > +             size_t fe_size = sizeof(*fi) + sizeof(struct btrfs_encryption_info);
> > +             u32 ctxsize;
> > +
> > +             if (unlikely(item_size < fe_size)) {
> > +                     file_extent_err(leaf, slot,
> > +     "invalid item size for encrypted file extent, have %u expect = %zu + size of u32",
> > +                                     item_size, sizeof(*fi));
> > +                     return -EUCLEAN;
> > +             }
> > +
> > +             ctxsize = btrfs_file_extent_encryption_info_size(leaf, fi);
> > +             if (unlikely(item_size != (fe_size + ctxsize))) {
> > +                     file_extent_err(leaf, slot,
> > +     "invalid item size for encrypted file extent, have %u expect = %zu + context of size %u",
> > +                                     item_size, fe_size, ctxsize);
> > +                     return -EUCLEAN;
> > +             }
> > +
> > +             if (unlikely(ctxsize > BTRFS_MAX_EXTENT_CTX_SIZE)) {
> > +                     file_extent_err(leaf, slot,
> > +     "invalid file extent context size, have %u expect a maximum of %u",
> > +                                     ctxsize, BTRFS_MAX_EXTENT_CTX_SIZE);
> > +                     return -EUCLEAN;
> > +             }
> > +
> > +             /*
> > +              * Only regular and prealloc extents should have an encryption
> > +              * context.
> > +              */
> > +             if (unlikely(fe_type != BTRFS_FILE_EXTENT_REG &&
> > +                          fe_type != BTRFS_FILE_EXTENT_PREALLOC)) {
> > +                     file_extent_err(leaf, slot,
> > +             "invalid type for encrypted file extent, have %u",
> > +                                     btrfs_file_extent_type(leaf, fi));
> > +                     return -EUCLEAN;
> > +             }
> > +     } else {
> > +             if (unlikely(item_size != sizeof(*fi))) {
> > +                     file_extent_err(leaf, slot,
> >       "invalid item size for reg/prealloc file extent, have %u expect %zu",
> > -                     item_size, sizeof(*fi));
> > -             return -EUCLEAN;
> > +                                     item_size, sizeof(*fi));
> > +                     return -EUCLEAN;
> > +             }
> >       }
> >       if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
> >                    CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
> > diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
> > index 7f3dffe6..4b4f45aa 100644
> > --- a/kernel-shared/uapi/btrfs_tree.h
> > +++ b/kernel-shared/uapi/btrfs_tree.h
> > @@ -1066,6 +1066,24 @@ enum {
> >       BTRFS_NR_FILE_EXTENT_TYPES = 3,
> >  };
> >
> > +/*
> > + * Currently just the FSCRYPT_SET_CONTEXT_MAX_SIZE, which is larger than the
> > + * current extent context size from fscrypt, so this should give us plenty of
> > + * breathing room for expansion later.
> > + */
> > +#define BTRFS_MAX_EXTENT_CTX_SIZE 40
> > +
> > +enum {
> > +     BTRFS_ENCRYPTION_NONE,
> > +     BTRFS_ENCRYPTION_FSCRYPT,
> > +     BTRFS_NR_ENCRYPTION_TYPES,
> > +};
> > +
> > +struct btrfs_encryption_info {
> > +     __le32 size;
> > +     __u8 context[0];
> > +};
> > +
> >  struct btrfs_file_extent_item {
> >       /*
> >        * transaction id that created this extent
> > @@ -1115,7 +1133,10 @@ struct btrfs_file_extent_item {
> >        * always reflects the size uncompressed and without encoding.
> >        */
> >       __le64 num_bytes;
> > -
> > +     /*
> > +      * the encryption info, if any
> > +      */
> > +     struct btrfs_encryption_info encryption_info[0];
>
> Looking at this again, adding variable length data will make it hard to
> add more items to the file extent. We could not decide the version just
> by the size, as done in other structures.

Checking the details of btrfs_file_extent_item I understand the item
is already variable size in case of inline extent.
IIUC, that means that versioning based purely on item size is already
not possible for inline file extents.
So in the case of regular one optionally adding the encryption context
seems similar to adding the file data for the inline case.
And it still makes sense to me keeping the

Perhaps the spare field `other_encoding` could eventually be used for
versioning if ever needed?

Let me know if you'd rather add a dedicated key for the encryption
context as Qu suggested. To me it still kind of makes sense to keep it
packed after the file extent info, but I'll be happy with both ways.

