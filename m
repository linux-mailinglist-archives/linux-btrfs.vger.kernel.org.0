Return-Path: <linux-btrfs+bounces-13540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F0AA45F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 10:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC6B9C3CCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095021ADB0;
	Wed, 30 Apr 2025 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OVaDr1ZX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E92DC78E
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003028; cv=none; b=nAyQJNFxlqKlJobeMy5ZK5TNt9fioS68WlQupDkee+oy+DZAlJf2tHuGdn+xDFQMdaJFnkOT4ciy+Ed1rnQsXR2iJVbvQJoSc8g9S/rv3wePi1ZHi0Kxoc4ftfFvVCSS2uUzlFEEhjB/euM1xeWMlHXrJIEObCwnAT2dE2NYg/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003028; c=relaxed/simple;
	bh=KZiPh+jRGVVuwEx0FU2/2McJu83o3gk6dXloyQM80/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siD2fke+77FUcovTQpyNB0kfpHlTDvdWMcllPalDIJEE/3/e62IgqbOTthkMmpPc3/S29T/xKon+APV7d+etzPptGBMDrWp25kACo/OXvG7zMIfGkP7kX8KfkZ/RrqiT7CZEkYhippsJ8rh9izY+N+qhiWKoNDznOhELjkbBpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OVaDr1ZX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2aeada833so145793866b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746003023; x=1746607823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUN6hd/jLVTzUcwZi9qPF7fcgQud5ruYQAAVONaSdcQ=;
        b=OVaDr1ZXdXMxe+ZHulNa/eWTmGTMi0Wk0M3jC8JlmNsTrO6JMb012hIyOL9Eot/45P
         CGkb4LwLVmrJnjwlEdveAf9VuPJ2/aG58ECa6g49qots+82n43GtWwWR97x3LXIW4kkh
         c9XqnSmdMbxfN3IrfsPUyZHPSsakRqUkKsOmmQsql4ANfAohD7JaPgsXa9UVk6IB+Ybq
         NCAHzb59ZZEGVa1CRsAz4zZPovLt7SwrIqMfeUBlh6a/cQKoYgKc3sVRTy7zQpCfRo07
         pUqR8dDKBEyqYuTyBfi5m1tCao1tGdOMGf35kgptdF5Nw8bYkSYCEbjJfUezBRzAvQRP
         Corg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003023; x=1746607823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUN6hd/jLVTzUcwZi9qPF7fcgQud5ruYQAAVONaSdcQ=;
        b=ucXf6B3qnNzrz+yFWLSu+cu4Hd09v1XSm+++YC+PurQGdZRhX5W7D/EFPRJtFJWfTY
         BeKgm9H9TpkzvQgX1YQW6GLv8eAfuSjB/Oc/ZPXkzvgLkQJTBbBiGyJAA19K9ZrOIEXx
         E5kw4HcmWH8SG86c4Voz7PoAAS0wZlF9LTYPJU7mAMLAO6mIb05rwyNQTxMckeDGJl01
         HC1YeX2DDP6xbu/OfS+d1h+IuzmPeDB6V3vJ4IcgzzDzhrlDyriCnf6k4OsLuMcnMjig
         ueejwWV6GpYI06V9r+4qbnTEMHqh0cKEzsawnOaMkIfUECMwXPla0F4xPGWcv0otJFKu
         Q38w==
X-Forwarded-Encrypted: i=1; AJvYcCVLqLPTA4qFZOc9qOVcerwtOYzrgZFPYnI3SHvm69Pjnm1F5DKMmVGdZnXlPwhK3j2rJquCTCoebhramA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+CbNdHsWNKemWEG+mJwSXPXujqVY8uTqHFsBZ4B3rCb5Ktrfi
	iIvvIWZ3l4/7wf+MPRrPNyuynJats9NKfOsrq8pneBmzapp51VAVpPw3TnkRpmeL8714U7ZjPN5
	MLUoznzuB61u55rsdUodB41mGgQHF/fF1EC+CgA==
X-Gm-Gg: ASbGnctF4Y7ZdACodCXEtTWl1Mr5Q/z+I2N/C1zPbDa8XDxxXEnFJOZ2NfpQ4ps3RZB
	XBsAHggio1/dAVQN34/ECBdxp8A6/IOkukUy6hn8txX3c6Oqhm/DGf78oDFLR4WMVOnF+x5h5zb
	FJvg2ObclPka0+6lFss2jx
X-Google-Smtp-Source: AGHT+IEOgcitmnU31xYDLXy9pxn5zGYhgzhPwDo0V/IxZGHT+IXg+K7s9zFmsSJae31Oqki9g5PXRtwtw6mByFE5KLM=
X-Received: by 2002:a17:906:7307:b0:ac7:3441:79aa with SMTP id
 a640c23a62f3a-acedf6bd27bmr189832466b.13.1746003023311; Wed, 30 Apr 2025
 01:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <CAL3q7H7WPE+26v1uCKa5C=BwcGpUN3OjnaPUkexPGD=mpJbkSA@mail.gmail.com>
 <CAPjX3FevwHRzyHzgLjcZ8reHtJ3isw3eREYrMvNCPLMDR=NJ4g@mail.gmail.com> <CAL3q7H56LC5ro+oshGaVVCV9Gvxfnz4dLaq6bwVW=t0P=tLUCg@mail.gmail.com>
In-Reply-To: <CAL3q7H56LC5ro+oshGaVVCV9Gvxfnz4dLaq6bwVW=t0P=tLUCg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 30 Apr 2025 10:50:12 +0200
X-Gm-Features: ATxdqUGvXwB-fBMgOInyguiglMnKf9ohZJn3GLM0Jiv3MAFsI-AwEqHiRtleSPM
Message-ID: <CAPjX3Fe3BZ8OB2ZVMn58pY5E9k9j=uNAmuqM4R1tO=sPvx7-pA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: Filipe Manana <fdmanana@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 at 10:34, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Wed, Apr 30, 2025 at 9:26=E2=80=AFAM Daniel Vacek <neelx@suse.com> wro=
te:
> >
> > On Wed, 30 Apr 2025 at 10:06, Filipe Manana <fdmanana@kernel.org> wrote=
:
> > >
> > > On Tue, Apr 29, 2025 at 4:19=E2=80=AFPM Daniel Vacek <neelx@suse.com>=
 wrote:
> > > >
> > > > Even super block nowadays uses nodesize for eb->len. This is since =
commits
> > > >
> > > > 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer(=
)")
> > > > da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and=
 into fs_info")
> > > > ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> > > > a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create=
_tree_block")
> > > >
> > > > With these the eb->len is not really useful anymore. Let's use the =
nodesize
> > > > directly where applicable.
> > > >
> > > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > > ---
> > > > [RFC]
> > > >  * Shall the eb_len() helper better be called eb_nodesize()? Or eve=
n rather
> > > >    opencoded and not used at all?
> > > >
> > > >  fs/btrfs/accessors.c             |  4 +--
> > > >  fs/btrfs/disk-io.c               | 11 ++++---
> > > >  fs/btrfs/extent-tree.c           | 28 +++++++++--------
> > > >  fs/btrfs/extent_io.c             | 54 ++++++++++++++--------------=
----
> > > >  fs/btrfs/extent_io.h             | 11 +++++--
> > > >  fs/btrfs/ioctl.c                 |  2 +-
> > > >  fs/btrfs/relocation.c            |  2 +-
> > > >  fs/btrfs/subpage.c               |  8 ++---
> > > >  fs/btrfs/tests/extent-io-tests.c | 12 +++----
> > > >  fs/btrfs/zoned.c                 |  2 +-
> > > >  10 files changed, 67 insertions(+), 67 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> > > > index e3716516ca387..a2bdbc7990906 100644
> > > > --- a/fs/btrfs/accessors.c
> > > > +++ b/fs/btrfs/accessors.c
> > > > @@ -14,10 +14,10 @@ static bool check_setget_bounds(const struct ex=
tent_buffer *eb,
> > > >  {
> > > >         const unsigned long member_offset =3D (unsigned long)ptr + =
off;
> > > >
> > > > -       if (unlikely(member_offset + size > eb->len)) {
> > > > +       if (unlikely(member_offset + size > eb_len(eb))) {
> > > >                 btrfs_warn(eb->fs_info,
> > > >                 "bad eb member %s: ptr 0x%lx start %llu member offs=
et %lu size %d",
> > > > -                       (member_offset > eb->len ? "start" : "end")=
,
> > > > +                       (member_offset > eb_len(eb) ? "start" : "en=
d"),
> > > >                         (unsigned long)ptr, eb->start, member_offse=
t, size);
> > > >                 return false;
> > > >         }
> > > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > > index 3592300ae3e2e..31eb7419fe11f 100644
> > > > --- a/fs/btrfs/disk-io.c
> > > > +++ b/fs/btrfs/disk-io.c
> > > > @@ -190,7 +190,7 @@ static int btrfs_repair_eb_io_failure(const str=
uct extent_buffer *eb,
> > > >         for (int i =3D 0; i < num_extent_folios(eb); i++) {
> > > >                 struct folio *folio =3D eb->folios[i];
> > > >                 u64 start =3D max_t(u64, eb->start, folio_pos(folio=
));
> > > > -               u64 end =3D min_t(u64, eb->start + eb->len,
> > > > +               u64 end =3D min_t(u64, eb->start + fs_info->nodesiz=
e,
> > > >                                 folio_pos(folio) + eb->folio_size);
> > > >                 u32 len =3D end - start;
> > > >                 phys_addr_t paddr =3D PFN_PHYS(folio_pfn(folio)) +
> > > > @@ -230,7 +230,7 @@ int btrfs_read_extent_buffer(struct extent_buff=
er *eb,
> > > >                         break;
> > > >
> > > >                 num_copies =3D btrfs_num_copies(fs_info,
> > > > -                                             eb->start, eb->len);
> > > > +                                             eb->start, fs_info->n=
odesize);
> > > >                 if (num_copies =3D=3D 1)
> > > >                         break;
> > > >
> > > > @@ -260,6 +260,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bi=
o *bbio)
> > > >  {
> > > >         struct extent_buffer *eb =3D bbio->private;
> > > >         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> > > > +       u32 nodesize =3D fs_info->nodesize;
> > > >         u64 found_start =3D btrfs_header_bytenr(eb);
> > > >         u64 last_trans;
> > > >         u8 result[BTRFS_CSUM_SIZE];
> > > > @@ -268,7 +269,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bi=
o *bbio)
> > > >         /* Btree blocks are always contiguous on disk. */
> > > >         if (WARN_ON_ONCE(bbio->file_offset !=3D eb->start))
> > > >                 return BLK_STS_IOERR;
> > > > -       if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size !=3D eb->len))
> > > > +       if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size !=3D nodesize))
> > > >                 return BLK_STS_IOERR;
> > > >
> > > >         /*
> > > > @@ -277,7 +278,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bi=
o *bbio)
> > > >          * ordering of I/O without unnecessarily writing out data.
> > > >          */
> > > >         if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
> > > > -               memzero_extent_buffer(eb, 0, eb->len);
> > > > +               memzero_extent_buffer(eb, 0, nodesize);
> > > >                 return BLK_STS_OK;
> > > >         }
> > > >
> > > > @@ -883,7 +884,7 @@ struct btrfs_root *btrfs_create_tree(struct btr=
fs_trans_handle *trans,
> > > >         btrfs_set_root_generation(&root->root_item, trans->transid)=
;
> > > >         btrfs_set_root_level(&root->root_item, 0);
> > > >         btrfs_set_root_refs(&root->root_item, 1);
> > > > -       btrfs_set_root_used(&root->root_item, leaf->len);
> > > > +       btrfs_set_root_used(&root->root_item, fs_info->nodesize);
> > > >         btrfs_set_root_last_snapshot(&root->root_item, 0);
> > > >         btrfs_set_root_dirid(&root->root_item, 0);
> > > >         if (is_fstree(objectid))
> > > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > > index e0811a86d0cbd..25560a162d93e 100644
> > > > --- a/fs/btrfs/extent-tree.c
> > > > +++ b/fs/btrfs/extent-tree.c
> > > > @@ -2211,7 +2211,7 @@ int btrfs_set_disk_extent_flags(struct btrfs_=
trans_handle *trans,
> > > >         extent_op->update_flags =3D true;
> > > >         extent_op->update_key =3D false;
> > > >
> > > > -       ret =3D btrfs_add_delayed_extent_op(trans, eb->start, eb->l=
en,
> > > > +       ret =3D btrfs_add_delayed_extent_op(trans, eb->start, eb_le=
n(eb),
> > > >                                           btrfs_header_level(eb), e=
xtent_op);
> > > >         if (ret)
> > > >                 btrfs_free_delayed_extent_op(extent_op);
> > > > @@ -2660,10 +2660,10 @@ int btrfs_pin_extent_for_log_replay(struct =
btrfs_trans_handle *trans,
> > > >         if (ret)
> > > >                 goto out;
> > > >
> > > > -       pin_down_extent(trans, cache, eb->start, eb->len, 0);
> > > > +       pin_down_extent(trans, cache, eb->start, eb_len(eb), 0);
> > > >
> > > >         /* remove us from the free space cache (if we're there at a=
ll) */
> > > > -       ret =3D btrfs_remove_free_space(cache, eb->start, eb->len);
> > > > +       ret =3D btrfs_remove_free_space(cache, eb->start, eb_len(eb=
));
> > > >  out:
> > > >         btrfs_put_block_group(cache);
> > > >         return ret;
> > > > @@ -3436,13 +3436,14 @@ int btrfs_free_tree_block(struct btrfs_tran=
s_handle *trans,
> > > >  {
> > > >         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> > > >         struct btrfs_block_group *bg;
> > > > +       u32 nodesize =3D fs_info->nodesize;
> > > >         int ret;
> > > >
> > > >         if (root_id !=3D BTRFS_TREE_LOG_OBJECTID) {
> > > >                 struct btrfs_ref generic_ref =3D {
> > > >                         .action =3D BTRFS_DROP_DELAYED_REF,
> > > >                         .bytenr =3D buf->start,
> > > > -                       .num_bytes =3D buf->len,
> > > > +                       .num_bytes =3D nodesize,
> > > >                         .parent =3D parent,
> > > >                         .owning_root =3D btrfs_header_owner(buf),
> > > >                         .ref_root =3D root_id,
> > > > @@ -3478,7 +3479,7 @@ int btrfs_free_tree_block(struct btrfs_trans_=
handle *trans,
> > > >         bg =3D btrfs_lookup_block_group(fs_info, buf->start);
> > > >
> > > >         if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> > > > -               pin_down_extent(trans, bg, buf->start, buf->len, 1)=
;
> > > > +               pin_down_extent(trans, bg, buf->start, nodesize, 1)=
;
> > > >                 btrfs_put_block_group(bg);
> > > >                 goto out;
> > > >         }
> > > > @@ -3502,17 +3503,17 @@ int btrfs_free_tree_block(struct btrfs_tran=
s_handle *trans,
> > > >
> > > >         if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags)
> > > >                      || btrfs_is_zoned(fs_info)) {
> > > > -               pin_down_extent(trans, bg, buf->start, buf->len, 1)=
;
> > > > +               pin_down_extent(trans, bg, buf->start, nodesize, 1)=
;
> > > >                 btrfs_put_block_group(bg);
> > > >                 goto out;
> > > >         }
> > > >
> > > >         WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
> > > >
> > > > -       btrfs_add_free_space(bg, buf->start, buf->len);
> > > > -       btrfs_free_reserved_bytes(bg, buf->len, 0);
> > > > +       btrfs_add_free_space(bg, buf->start, nodesize);
> > > > +       btrfs_free_reserved_bytes(bg, nodesize, 0);
> > > >         btrfs_put_block_group(bg);
> > > > -       trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->=
len);
> > > > +       trace_btrfs_reserved_extent_free(fs_info, buf->start, nodes=
ize);
> > > >
> > > >  out:
> > > >         return 0;
> > > > @@ -4768,7 +4769,7 @@ int btrfs_pin_reserved_extent(struct btrfs_tr=
ans_handle *trans,
> > > >                 return -ENOSPC;
> > > >         }
> > > >
> > > > -       ret =3D pin_down_extent(trans, cache, eb->start, eb->len, 1=
);
> > > > +       ret =3D pin_down_extent(trans, cache, eb->start, eb_len(eb)=
, 1);
> > > >         btrfs_put_block_group(cache);
> > > >         return ret;
> > > >  }
> > > > @@ -5050,6 +5051,7 @@ btrfs_init_new_buffer(struct btrfs_trans_hand=
le *trans, struct btrfs_root *root,
> > > >         struct btrfs_fs_info *fs_info =3D root->fs_info;
> > > >         struct extent_buffer *buf;
> > > >         u64 lockdep_owner =3D owner;
> > > > +       u32 nodesize =3D fs_info->nodesize;
> > > >
> > > >         buf =3D btrfs_find_create_tree_block(fs_info, bytenr, owner=
, level);
> > > >         if (IS_ERR(buf))
> > > > @@ -5107,16 +5109,16 @@ btrfs_init_new_buffer(struct btrfs_trans_ha=
ndle *trans, struct btrfs_root *root,
> > > >                  */
> > > >                 if (buf->log_index =3D=3D 0)
> > > >                         btrfs_set_extent_bit(&root->dirty_log_pages=
, buf->start,
> > > > -                                            buf->start + buf->len =
- 1,
> > > > +                                            buf->start + nodesize =
- 1,
> > > >                                              EXTENT_DIRTY, NULL);
> > > >                 else
> > > >                         btrfs_set_extent_bit(&root->dirty_log_pages=
, buf->start,
> > > > -                                            buf->start + buf->len =
- 1,
> > > > +                                            buf->start + nodesize =
- 1,
> > > >                                              EXTENT_NEW, NULL);
> > > >         } else {
> > > >                 buf->log_index =3D -1;
> > > >                 btrfs_set_extent_bit(&trans->transaction->dirty_pag=
es, buf->start,
> > > > -                                    buf->start + buf->len - 1, EXT=
ENT_DIRTY, NULL);
> > > > +                                    buf->start + nodesize - 1, EXT=
ENT_DIRTY, NULL);
> > > >         }
> > > >         /* this returns a buffer locked for blocking */
> > > >         return buf;
> > > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > > index 20cdddd924852..e4050fd5db285 100644
> > > > --- a/fs/btrfs/extent_io.c
> > > > +++ b/fs/btrfs/extent_io.c
> > > > @@ -76,8 +76,8 @@ void btrfs_extent_buffer_leak_debug_check(struct =
btrfs_fs_info *fs_info)
> > > >                 eb =3D list_first_entry(&fs_info->allocated_ebs,
> > > >                                       struct extent_buffer, leak_li=
st);
> > > >                 pr_err(
> > > > -       "BTRFS: buffer leak start %llu len %u refs %d bflags %lu ow=
ner %llu\n",
> > > > -                      eb->start, eb->len, atomic_read(&eb->refs), =
eb->bflags,
> > > > +       "BTRFS: buffer leak start %llu refs %d bflags %lu owner %ll=
u\n",
> > > > +                      eb->start, atomic_read(&eb->refs), eb->bflag=
s,
> > > >                        btrfs_header_owner(eb));
> > > >                 list_del(&eb->leak_list);
> > > >                 WARN_ON_ONCE(1);
> > > > @@ -1746,8 +1746,8 @@ static noinline_for_stack bool lock_extent_bu=
ffer_for_io(struct extent_buffer *e
> > > >
> > > >                 btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN=
);
> > > >                 percpu_counter_add_batch(&fs_info->dirty_metadata_b=
ytes,
> > > > -                                        -eb->len,
> > > > -                                        fs_info->dirty_metadata_ba=
tch);
> > > > +                                        -fs_info->nodesize,
> > > > +                                         fs_info->dirty_metadata_b=
atch);
> > > >                 ret =3D true;
> > > >         } else {
> > > >                 spin_unlock(&eb->refs_lock);
> > > > @@ -1953,7 +1953,7 @@ static unsigned int buffer_tree_get_ebs_tag(s=
truct btrfs_fs_info *fs_info,
> > > >         rcu_read_lock();
> > > >         while ((eb =3D find_get_eb(&xas, end, tag)) !=3D NULL) {
> > > >                 if (!eb_batch_add(batch, eb)) {
> > > > -                       *start =3D (eb->start + eb->len) >> fs_info=
->sectorsize_bits;
> > > > +                       *start =3D (eb->start + fs_info->nodesize) =
>> fs_info->sectorsize_bits;
> > > >                         goto out;
> > > >                 }
> > > >         }
> > > > @@ -2020,7 +2020,7 @@ static void prepare_eb_write(struct extent_bu=
ffer *eb)
> > > >         nritems =3D btrfs_header_nritems(eb);
> > > >         if (btrfs_header_level(eb) > 0) {
> > > >                 end =3D btrfs_node_key_ptr_offset(eb, nritems);
> > > > -               memzero_extent_buffer(eb, end, eb->len - end);
> > > > +               memzero_extent_buffer(eb, end, eb_len(eb) - end);
> > > >         } else {
> > > >                 /*
> > > >                  * Leaf:
> > > > @@ -2056,7 +2056,7 @@ static noinline_for_stack void write_one_eb(s=
truct extent_buffer *eb,
> > > >                 struct folio *folio =3D eb->folios[i];
> > > >                 u64 range_start =3D max_t(u64, eb->start, folio_pos=
(folio));
> > > >                 u32 range_len =3D min_t(u64, folio_pos(folio) + fol=
io_size(folio),
> > > > -                                     eb->start + eb->len) - range_=
start;
> > > > +                                     eb->start + fs_info->nodesize=
) - range_start;
> > > >
> > > >                 folio_lock(folio);
> > > >                 btrfs_meta_folio_clear_dirty(folio, eb);
> > > > @@ -2171,7 +2171,7 @@ int btree_write_cache_pages(struct address_sp=
ace *mapping,
> > > >                         if (ctx.zoned_bg) {
> > > >                                 /* Mark the last eb in the block gr=
oup. */
> > > >                                 btrfs_schedule_zone_finish_bg(ctx.z=
oned_bg, eb);
> > > > -                               ctx.zoned_bg->meta_write_pointer +=
=3D eb->len;
> > > > +                               ctx.zoned_bg->meta_write_pointer +=
=3D fs_info->nodesize;
> > > >                         }
> > > >                         write_one_eb(eb, wbc);
> > > >                 }
> > > > @@ -2807,7 +2807,6 @@ static struct extent_buffer *__alloc_extent_b=
uffer(struct btrfs_fs_info *fs_info
> > > >
> > > >         eb =3D kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GF=
P_NOFAIL);
> > > >         eb->start =3D start;
> > > > -       eb->len =3D fs_info->nodesize;
> > > >         eb->fs_info =3D fs_info;
> > > >         init_rwsem(&eb->lock);
> > > >
> > > > @@ -2816,8 +2815,6 @@ static struct extent_buffer *__alloc_extent_b=
uffer(struct btrfs_fs_info *fs_info
> > > >         spin_lock_init(&eb->refs_lock);
> > > >         atomic_set(&eb->refs, 1);
> > > >
> > > > -       ASSERT(eb->len <=3D BTRFS_MAX_METADATA_BLOCKSIZE);
> > > > -
> > > >         return eb;
> > > >  }
> > > >
> > > > @@ -3505,7 +3502,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_tr=
ans_handle *trans,
> > > >                 return;
> > > >
> > > >         buffer_tree_clear_mark(eb, PAGECACHE_TAG_DIRTY);
> > > > -       percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -e=
b->len,
> > > > +       percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -f=
s_info->nodesize,
> > > >                                  fs_info->dirty_metadata_batch);
> > > >
> > > >         for (int i =3D 0; i < num_extent_folios(eb); i++) {
> > > > @@ -3557,8 +3554,8 @@ void set_extent_buffer_dirty(struct extent_bu=
ffer *eb)
> > > >                 if (subpage)
> > > >                         folio_unlock(eb->folios[0]);
> > > >                 percpu_counter_add_batch(&eb->fs_info->dirty_metada=
ta_bytes,
> > > > -                                        eb->len,
> > > > -                                        eb->fs_info->dirty_metadat=
a_batch);
> > > > +                                         eb_len(eb),
> > > > +                                         eb->fs_info->dirty_metada=
ta_batch);
> > > >         }
> > > >  #ifdef CONFIG_BTRFS_DEBUG
> > > >         for (int i =3D 0; i < num_extent_folios(eb); i++)
> > > > @@ -3670,7 +3667,7 @@ int read_extent_buffer_pages_nowait(struct ex=
tent_buffer *eb, int mirror_num,
> > > >                 struct folio *folio =3D eb->folios[i];
> > > >                 u64 range_start =3D max_t(u64, eb->start, folio_pos=
(folio));
> > > >                 u32 range_len =3D min_t(u64, folio_pos(folio) + fol=
io_size(folio),
> > > > -                                     eb->start + eb->len) - range_=
start;
> > > > +                                     eb->start + eb_len(eb)) - ran=
ge_start;
> > > >
> > > >                 bio_add_folio_nofail(&bbio->bio, folio, range_len,
> > > >                                      offset_in_folio(folio, range_s=
tart));
> > > > @@ -3698,8 +3695,8 @@ static bool report_eb_range(const struct exte=
nt_buffer *eb, unsigned long start,
> > > >                             unsigned long len)
> > > >  {
> > > >         btrfs_warn(eb->fs_info,
> > > > -               "access to eb bytenr %llu len %u out of range start=
 %lu len %lu",
> > > > -               eb->start, eb->len, start, len);
> > > > +               "access to eb bytenr %llu out of range start %lu le=
n %lu",
> > > > +               eb->start, start, len);
> > > >         DEBUG_WARN();
> > > >
> > > >         return true;
> > > > @@ -3717,8 +3714,8 @@ static inline int check_eb_range(const struct=
 extent_buffer *eb,
> > > >  {
> > > >         unsigned long offset;
> > > >
> > > > -       /* start, start + len should not go beyond eb->len nor over=
flow */
> > > > -       if (unlikely(check_add_overflow(start, len, &offset) || off=
set > eb->len))
> > > > +       /* start, start + len should not go beyond nodesize nor ove=
rflow */
> > > > +       if (unlikely(check_add_overflow(start, len, &offset) || off=
set > eb_len(eb)))
> > > >                 return report_eb_range(eb, start, len);
> > > >
> > > >         return false;
> > > > @@ -3774,8 +3771,8 @@ int read_extent_buffer_to_user_nofault(const =
struct extent_buffer *eb,
> > > >         unsigned long i =3D get_eb_folio_index(eb, start);
> > > >         int ret =3D 0;
> > > >
> > > > -       WARN_ON(start > eb->len);
> > > > -       WARN_ON(start + len > eb->start + eb->len);
> > > > +       WARN_ON(start > eb_len(eb));
> > > > +       WARN_ON(start + len > eb->start + eb_len(eb));
> > > >
> > > >         if (eb->addr) {
> > > >                 if (copy_to_user_nofault(dstv, eb->addr + start, le=
n))
> > > > @@ -3866,8 +3863,8 @@ static void assert_eb_folio_uptodate(const st=
ruct extent_buffer *eb, int i)
> > > >                 folio =3D eb->folios[0];
> > > >                 ASSERT(i =3D=3D 0);
> > > >                 if (WARN_ON(!btrfs_subpage_test_uptodate(fs_info, f=
olio,
> > > > -                                                        eb->start,=
 eb->len)))
> > > > -                       btrfs_subpage_dump_bitmap(fs_info, folio, e=
b->start, eb->len);
> > > > +                                                        eb->start,=
 fs_info->nodesize)))
> > > > +                       btrfs_subpage_dump_bitmap(fs_info, folio, e=
b->start, fs_info->nodesize);
> > > >         } else {
> > > >                 WARN_ON(!folio_test_uptodate(folio));
> > > >         }
> > > > @@ -3960,12 +3957,10 @@ void copy_extent_buffer_full(const struct e=
xtent_buffer *dst,
> > > >         const int unit_size =3D src->folio_size;
> > > >         unsigned long cur =3D 0;
> > > >
> > > > -       ASSERT(dst->len =3D=3D src->len);
> > > > -
> > > > -       while (cur < src->len) {
> > > > +       while (cur < eb_len(src)) {
> > > >                 unsigned long index =3D get_eb_folio_index(src, cur=
);
> > > >                 unsigned long offset =3D get_eb_offset_in_folio(src=
, cur);
> > > > -               unsigned long cur_len =3D min(src->len, unit_size -=
 offset);
> > > > +               unsigned long cur_len =3D min(eb_len(src), unit_siz=
e - offset);
> > > >                 void *addr =3D folio_address(src->folios[index]) + =
offset;
> > > >
> > > >                 write_extent_buffer(dst, addr, cur, cur_len);
> > > > @@ -3980,7 +3975,6 @@ void copy_extent_buffer(const struct extent_b=
uffer *dst,
> > > >                         unsigned long len)
> > > >  {
> > > >         const int unit_size =3D dst->folio_size;
> > > > -       u64 dst_len =3D dst->len;
> > > >         size_t cur;
> > > >         size_t offset;
> > > >         char *kaddr;
> > > > @@ -3990,8 +3984,6 @@ void copy_extent_buffer(const struct extent_b=
uffer *dst,
> > > >             check_eb_range(src, src_offset, len))
> > > >                 return;
> > > >
> > > > -       WARN_ON(src->len !=3D dst_len);
> > > > -
> > > >         offset =3D get_eb_offset_in_folio(dst, dst_offset);
> > > >
> > > >         while (len > 0) {
> > > > @@ -4266,7 +4258,7 @@ static int try_release_subpage_extent_buffer(=
struct folio *folio)
> > > >                         xa_unlock_irq(&fs_info->buffer_tree);
> > > >                         break;
> > > >                 }
> > > > -               cur =3D eb->start + eb->len;
> > > > +               cur =3D eb->start + fs_info->nodesize;
> > > >
> > > >                 /*
> > > >                  * The same as try_release_extent_buffer(), to ensu=
re the eb
> > > > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > > > index 1415679d7f88c..9a842eea47d6d 100644
> > > > --- a/fs/btrfs/extent_io.h
> > > > +++ b/fs/btrfs/extent_io.h
> > > > @@ -16,6 +16,7 @@
> > > >  #include "messages.h"
> > > >  #include "ulist.h"
> > > >  #include "misc.h"
> > > > +#include "fs.h"
> > > >
> > > >  struct page;
> > > >  struct file;
> > > > @@ -80,7 +81,6 @@ void __cold extent_buffer_free_cachep(void);
> > > >  #define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSI=
ZE / PAGE_SIZE)
> > > >  struct extent_buffer {
> > > >         u64 start;
> > > > -       u32 len;
> > > >         u32 folio_size;
> > > >         unsigned long bflags;
> > > >         struct btrfs_fs_info *fs_info;
> > > > @@ -263,17 +263,22 @@ void btrfs_readahead_tree_block(struct btrfs_=
fs_info *fs_info,
> > > >                                 u64 bytenr, u64 owner_root, u64 gen=
, int level);
> > > >  void btrfs_readahead_node_child(struct extent_buffer *node, int sl=
ot);
> > > >
> > > > +static inline u32 eb_len(const struct extent_buffer *eb)
> > > > +{
> > > > +       return eb->fs_info->nodesize;
> > > > +}
> > >
> > > Please always add a "btrfs_" prefix to the name of exported functions=
.
> >
> > It's static inline, not exported. But I'm happy just opencoding it
> > instead. Thanks.
>
> Exported in the sense that it's in a header and visible to any C files
> that include it, not in the sense of being exported with
> EXPORT_SYMBOL_GPL() for example.
> This is our coding style convention:
>
> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#functio=
n-declarations
>
> static functions inside a C file can omit the prefix.

Nah, thanks again. I was not aware of that. Will keep it in mind.

Still, it doesn't make sense to me to be honest. I mean specifically
with this example. The header file is also private to btrfs, no public
API. Personally I wouldn't differentiate if it's a source or a header
file. The code can be freely moved around. And with the prefix the
code would end up more bloated and less readable, IMO. But let's not
start any flamewars here.

> >
> > > In this case I don't think adding this helper adds any value.
> > > We can just do eb->fs_info->nodesize everywhere and in some places we
> > > already have fs_info in a local variable and can just do
> > > fs_info->nodesize.
> > >
> > > Thanks.
> > >
> > > > +
> > > >  /* Note: this can be used in for loops without caching the value i=
n a variable. */
> > > >  static inline int __pure num_extent_pages(const struct extent_buff=
er *eb)
> > > >  {
> > > >         /*
> > > >          * For sectorsize =3D=3D PAGE_SIZE case, since nodesize is =
always aligned to
> > > > -        * sectorsize, it's just eb->len >> PAGE_SHIFT.
> > > > +        * sectorsize, it's just nodesize >> PAGE_SHIFT.
> > > >          *
> > > >          * For sectorsize < PAGE_SIZE case, we could have nodesize =
< PAGE_SIZE,
> > > >          * thus have to ensure we get at least one page.
> > > >          */
> > > > -       return (eb->len >> PAGE_SHIFT) ?: 1;
> > > > +       return (eb_len(eb) >> PAGE_SHIFT) ?: 1;
> > > >  }
> > > >
> > > >  /*
> > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > index 68fac77fb95d1..6be2d56d44917 100644
> > > > --- a/fs/btrfs/ioctl.c
> > > > +++ b/fs/btrfs/ioctl.c
> > > > @@ -598,7 +598,7 @@ static noinline int create_subvol(struct mnt_id=
map *idmap,
> > > >         btrfs_set_root_generation(root_item, trans->transid);
> > > >         btrfs_set_root_level(root_item, 0);
> > > >         btrfs_set_root_refs(root_item, 1);
> > > > -       btrfs_set_root_used(root_item, leaf->len);
> > > > +       btrfs_set_root_used(root_item, fs_info->nodesize);
> > > >         btrfs_set_root_last_snapshot(root_item, 0);
> > > >
> > > >         btrfs_set_root_generation_v2(root_item,
> > > > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > > > index 6287e71ebad5f..5086485a4ae21 100644
> > > > --- a/fs/btrfs/relocation.c
> > > > +++ b/fs/btrfs/relocation.c
> > > > @@ -4352,7 +4352,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_=
handle *trans,
> > > >                         mark_block_processed(rc, node);
> > > >
> > > >                 if (first_cow && level > 0)
> > > > -                       rc->nodes_relocated +=3D buf->len;
> > > > +                       rc->nodes_relocated +=3D fs_info->nodesize;
> > > >         }
> > > >
> > > >         if (level =3D=3D 0 && first_cow && rc->stage =3D=3D UPDATE_=
DATA_PTRS)
> > > > diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> > > > index d4f0192334936..711792f32e9ce 100644
> > > > --- a/fs/btrfs/subpage.c
> > > > +++ b/fs/btrfs/subpage.c
> > > > @@ -631,7 +631,7 @@ void btrfs_meta_folio_set_##name(struct folio *=
folio, const struct extent_buffer
> > > >                 folio_set_func(folio);                             =
     \
> > > >                 return;                                            =
     \
> > > >         }                                                          =
     \
> > > > -       btrfs_subpage_set_##name(eb->fs_info, folio, eb->start, eb-=
>len); \
> > > > +       btrfs_subpage_set_##name(eb->fs_info, folio, eb->start, eb_=
len(eb)); \
> > > >  }                                                                 =
     \
> > > >  void btrfs_meta_folio_clear_##name(struct folio *folio, const stru=
ct extent_buffer *eb) \
> > > >  {                                                                 =
     \
> > > > @@ -639,13 +639,13 @@ void btrfs_meta_folio_clear_##name(struct fol=
io *folio, const struct extent_buff
> > > >                 folio_clear_func(folio);                           =
     \
> > > >                 return;                                            =
     \
> > > >         }                                                          =
     \
> > > > -       btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start, e=
b->len); \
> > > > +       btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start, e=
b_len(eb)); \
> > > >  }                                                                 =
     \
> > > >  bool btrfs_meta_folio_test_##name(struct folio *folio, const struc=
t extent_buffer *eb) \
> > > >  {                                                                 =
     \
> > > >         if (!btrfs_meta_is_subpage(eb->fs_info))                   =
     \
> > > >                 return folio_test_func(folio);                     =
     \
> > > > -       return btrfs_subpage_test_##name(eb->fs_info, folio, eb->st=
art, eb->len); \
> > > > +       return btrfs_subpage_test_##name(eb->fs_info, folio, eb->st=
art, eb_len(eb)); \
> > > >  }
> > > >  IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, folio_clea=
r_uptodate,
> > > >                          folio_test_uptodate);
> > > > @@ -765,7 +765,7 @@ bool btrfs_meta_folio_clear_and_test_dirty(stru=
ct folio *folio, const struct ext
> > > >                 return true;
> > > >         }
> > > >
> > > > -       last =3D btrfs_subpage_clear_and_test_dirty(eb->fs_info, fo=
lio, eb->start, eb->len);
> > > > +       last =3D btrfs_subpage_clear_and_test_dirty(eb->fs_info, fo=
lio, eb->start, eb_len(eb));
> > > >         if (last) {
> > > >                 folio_clear_dirty_for_io(folio);
> > > >                 return true;
> > > > diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/exte=
nt-io-tests.c
> > > > index 00da54f0164c9..657f8f1d9263e 100644
> > > > --- a/fs/btrfs/tests/extent-io-tests.c
> > > > +++ b/fs/btrfs/tests/extent-io-tests.c
> > > > @@ -342,7 +342,7 @@ static int check_eb_bitmap(unsigned long *bitma=
p, struct extent_buffer *eb)
> > > >  {
> > > >         unsigned long i;
> > > >
> > > > -       for (i =3D 0; i < eb->len * BITS_PER_BYTE; i++) {
> > > > +       for (i =3D 0; i < eb_len(eb) * BITS_PER_BYTE; i++) {
> > > >                 int bit, bit1;
> > > >
> > > >                 bit =3D !!test_bit(i, bitmap);
> > > > @@ -411,7 +411,7 @@ static int test_bitmap_clear(const char *name, =
unsigned long *bitmap,
> > > >  static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_=
buffer *eb)
> > > >  {
> > > >         unsigned long i, j;
> > > > -       unsigned long byte_len =3D eb->len;
> > > > +       unsigned long byte_len =3D eb_len(eb);
> > > >         u32 x;
> > > >         int ret;
> > > >
> > > > @@ -670,7 +670,7 @@ static int test_find_first_clear_extent_bit(voi=
d)
> > > >  static void dump_eb_and_memory_contents(struct extent_buffer *eb, =
void *memory,
> > > >                                         const char *test_name)
> > > >  {
> > > > -       for (int i =3D 0; i < eb->len; i++) {
> > > > +       for (int i =3D 0; i < eb_len(eb); i++) {
> > > >                 struct page *page =3D folio_page(eb->folios[i >> PA=
GE_SHIFT], 0);
> > > >                 void *addr =3D page_address(page) + offset_in_page(=
i);
> > > >
> > > > @@ -686,7 +686,7 @@ static void dump_eb_and_memory_contents(struct =
extent_buffer *eb, void *memory,
> > > >  static int verify_eb_and_memory(struct extent_buffer *eb, void *me=
mory,
> > > >                                 const char *test_name)
> > > >  {
> > > > -       for (int i =3D 0; i < (eb->len >> PAGE_SHIFT); i++) {
> > > > +       for (int i =3D 0; i < (eb_len(eb) >> PAGE_SHIFT); i++) {
> > > >                 void *eb_addr =3D folio_address(eb->folios[i]);
> > > >
> > > >                 if (memcmp(memory + (i << PAGE_SHIFT), eb_addr, PAG=
E_SIZE) !=3D 0) {
> > > > @@ -703,8 +703,8 @@ static int verify_eb_and_memory(struct extent_b=
uffer *eb, void *memory,
> > > >   */
> > > >  static void init_eb_and_memory(struct extent_buffer *eb, void *mem=
ory)
> > > >  {
> > > > -       get_random_bytes(memory, eb->len);
> > > > -       write_extent_buffer(eb, memory, 0, eb->len);
> > > > +       get_random_bytes(memory, eb_len(eb));
> > > > +       write_extent_buffer(eb, memory, 0, eb_len(eb));
> > > >  }
> > > >
> > > >  static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
> > > > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > > > index 9d42bf2bfd746..c7a8cdd87c509 100644
> > > > --- a/fs/btrfs/zoned.c
> > > > +++ b/fs/btrfs/zoned.c
> > > > @@ -2422,7 +2422,7 @@ void btrfs_schedule_zone_finish_bg(struct btr=
fs_block_group *bg,
> > > >                                    struct extent_buffer *eb)
> > > >  {
> > > >         if (!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &bg->runtim=
e_flags) ||
> > > > -           eb->start + eb->len * 2 <=3D bg->start + bg->zone_capac=
ity)
> > > > +           eb->start + eb_len(eb) * 2 <=3D bg->start + bg->zone_ca=
pacity)
> > > >                 return;
> > > >
> > > >         if (WARN_ON(bg->zone_finish_work.func =3D=3D btrfs_zone_fin=
ish_endio_workfn)) {
> > > > --
> > > > 2.47.2
> > > >
> > > >

