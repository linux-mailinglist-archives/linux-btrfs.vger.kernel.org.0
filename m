Return-Path: <linux-btrfs+bounces-5502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE25C8FE5FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 14:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DBB1F21BDA
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC0A195808;
	Thu,  6 Jun 2024 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToDLQDeJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F3C153
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675364; cv=none; b=DTb93suc3Tkyy7/B3NpxvrxXKwg5NDDdrkRUjS5JQAYrBkc0Q+ZhYrElZi1QhUO44nUxmP/qrPLVFrTgbNhKN0FlBJF5RUep6ajBXo0vHPiAAqQQhpk3QMAMHw0+glKTh3lFmOGErkubt9RvQY38WZ+jGFtA43d9Ta1kGJEv+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675364; c=relaxed/simple;
	bh=qzyx87muswqbwmRITFf1eBVGF2mE9xeCqKHUIHuyFqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKbkpP6sLYeTWOXbX4cCM9jsgg47WZ0umfxPC+IfSd22yq9GptXojI1YciIMMrTxFkbjIIPDghKkHqWBntPRyJd3eaxir7BPaKMJYnfOSOuLCFdqOzfgYU7g1HEGEQ9RaR81N5L9IsWLKOhGorMbJMNmTHumJHmS09q2pdFdAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToDLQDeJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57aa64c6bbfso801858a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717675360; x=1718280160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO6QzkIWmBfAnDMBjFCmR7gSH0l6/oVYg+i67/0BM/4=;
        b=ToDLQDeJWXC/J47Ev9/rR011OSphxkGZDZG6pUrYEGw9/wtLcXRzn/ruzSpYjlcsi7
         I75HbAoyAW7hlagVyVoXluXvPB/IDMTw0IwNkGbSZioVLn1W/ZJ33JI3E6fnNQC6u+O6
         TVScmhFbyjElyxFXO9SdmBDqkCfUMv/epc7tIlkoR6VuJ1H90gbJQrHzZRYfEbFJZXrp
         PmztIAbh3ImFvPwZro1L6jcq6EhDBCHUaQVCS/C8mPOvF0DrbZEHp6sgf+OiGqPdiR6C
         Vxz5HnL763EDuSNjo5Oc4fOErGXrzGCT6mjQ8vm2uJzJQQpSAFeKU1JJTDNkRXZSQD0i
         /37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717675360; x=1718280160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO6QzkIWmBfAnDMBjFCmR7gSH0l6/oVYg+i67/0BM/4=;
        b=GNG5vFLJ0Jo3O9VufhxHJ+9yIWKhg8hrONAbOqPWGwXl0G1V5ntSyzHObXL+hNsSTH
         31+SDQqdFd35bLCEnnw4UIn36td/hr3YJP3o8awhzB7gYJjis/PREJ5GjnWAW/loFc1r
         91xhslApd7PoCMdp3MxHORkgyugk/LFnOOSbUU6P4r2ySwpJl0vDb3J0NcI0mBVrC4Qq
         zNwv9mtrc/pNzkbPghQbFBczB3YXolZ16e1psGjrRIJ0SlKhBu8jWPegJ3PtpZkkbnmE
         qRPalUXyZCedj8SqmOa0VTZomLPWlfZDdFlGcua6jMz6X3JybZIECfqxkM9166nsrb/4
         7nzQ==
X-Gm-Message-State: AOJu0Yx+b2rfv61hrCbEspGbXGeBrxVSjLVjgroX255WmapigI+mt3LH
	6qvLNUHzavqlFj5eyTuZ90Gb03gp768WX8m8u6KOVfxNAKdoq0g2tBPDFu15EKCwftnpnph8Trj
	AMM1tW2hm0df/YX9PHUhhPt3+wS8=
X-Google-Smtp-Source: AGHT+IH9ba3L77DbswL0UYTb4vqTARz7mXMunYTFA7xqyl2bMQ8Xv7ddwB+MzgvveVTQ67KpwgwUTaPxWqiG9eoKrfE=
X-Received: by 2002:a50:d596:0:b0:572:9962:7f0 with SMTP id
 4fb4d7f45d1cf-57a8bca39f2mr3264605a12.34.1717675360150; Thu, 06 Jun 2024
 05:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603113650.279782-1-sunjunchao2870@gmail.com> <0610a1b0-78a6-4c1f-9188-69b587c8146f@gmx.com>
In-Reply-To: <0610a1b0-78a6-4c1f-9188-69b587c8146f@gmx.com>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Thu, 6 Jun 2024 20:02:28 +0800
Message-ID: <CAHB1NajCcMA_VeBndEd2HMB=wbrX4iLYZGpb_jyw7mcd0Pyhwg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: qgroup: use xarray to track dirty extents in transaction.
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=9B=9B 17:30=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> =E5=9C=A8 2024/6/3 21:06, Junchao Sun =E5=86=99=E9=81=93:
> > Changes since v1:
> >   - Use xa_load() to update existing entry instead of double
> >     xa_store().
> >   - Rename goto lables.
> >   - Remove unnecessary calls to xa_init().
> >
> > Using xarray to track dirty extents can reduce the size of the
> > struct btrfs_qgroup_extent_record from 64 bytes to 40 bytes.
> > And xarray is more cache line friendly, it also reduces the
> > complexity of insertion and search code compared to rb tree.
> >
> > Another change introduced is about error handling.
> > Before this patch, the result of btrfs_qgroup_trace_extent_nolock()
> > is always a success. In this patch, because of this function calls
> > the function xa_store() which has the possibility to fail, so mark
> > qgroup as inconsistent if error happened and then free preallocated
> > memory. Also we preallocate memory before spin_lock(), if memory
> > preallcation failed, error handling is the same the existing code.
> >
> > This patch passed the check -g qgroup tests using xfstests and
> > checkpatch tests.
> >
> > Suggested-by: Qu Wenruo <wqu@suse.com>
> > Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
>
> Sorry for the late reply, this version looks much better now, just
> something small nitpicks.
>
> > ---
> >   fs/btrfs/delayed-ref.c | 57 ++++++++++++++++++++--------------
> >   fs/btrfs/delayed-ref.h |  2 +-
> >   fs/btrfs/qgroup.c      | 69 +++++++++++++++++++++--------------------=
-
> >   fs/btrfs/qgroup.h      |  1 -
> >   fs/btrfs/transaction.c |  6 ++--
> >   5 files changed, 73 insertions(+), 62 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> > index 891ea2fa263c..e5cbc91e9864 100644
> > --- a/fs/btrfs/delayed-ref.c
> > +++ b/fs/btrfs/delayed-ref.c
> > @@ -915,8 +915,11 @@ add_delayed_ref_head(struct btrfs_trans_handle *tr=
ans,
> >       /* Record qgroup extent info if provided */
> >       if (qrecord) {
> >               if (btrfs_qgroup_trace_extent_nolock(trans->fs_info,
> > -                                     delayed_refs, qrecord))
> > +                                     delayed_refs, qrecord)) {
>
>
> > Since btrfs_qgroup_trace_extent_nolock() can return <0 for errors, I'd
> > prefer the more common handling like:
> >
> >         ret =3D btrfs_qgroup_trace_extent_nolock();
> >         /* Either error or no need to use the qrecord */
> >         if (ret) {
> >                 /* Do the cleanup */
> >         }

Ok. I will modify it.

> > +                     /* If insertion failed, free preallocated memory =
*/
> > +                     xa_release(&delayed_refs->dirty_extents, qrecord-=
>bytenr);
> >                       kfree(qrecord);
> > +             }
> >               else
> >                       qrecord_inserted =3D true;
> >       }
> > @@ -1029,6 +1032,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
> >       u8 ref_type;
> >
> >       is_system =3D (generic_ref->tree_ref.ref_root =3D=3D BTRFS_CHUNK_=
TREE_OBJECTID);
> > +     delayed_refs =3D &trans->transaction->delayed_refs;
> >
> >       ASSERT(generic_ref->type =3D=3D BTRFS_REF_METADATA && generic_ref=
->action);
> >       ref =3D kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS)=
;
> > @@ -1036,18 +1040,15 @@ int btrfs_add_delayed_tree_ref(struct btrfs_tra=
ns_handle *trans,
> >               return -ENOMEM;
> >
> >       head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
> > -     if (!head_ref) {
> > -             kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> > -             return -ENOMEM;
> > -     }
> > +     if (!head_ref)
> > +             goto free_ref;
> >
> >       if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_q=
group) {
> >               record =3D kzalloc(sizeof(*record), GFP_NOFS);
> > -             if (!record) {
> > -                     kmem_cache_free(btrfs_delayed_tree_ref_cachep, re=
f);
> > -                     kmem_cache_free(btrfs_delayed_ref_head_cachep, he=
ad_ref);
> > -                     return -ENOMEM;
> > -             }
> > +             if (!record)
> > +                     goto free_head_ref;
> > +             if (xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_=
NOFS))
> > +                     goto free_record;
>
>
> > Considering we are doing a big functional change, I'd really prefer to
> > move the error handling cleanup, for better bisection.

Got it. I will send a separated patch to do the cleanup.

>
> >       }
> >
> >       if (parent)
> > @@ -1067,7 +1068,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
> >                             false, is_system, generic_ref->owning_root)=
;
> >       head_ref->extent_op =3D extent_op;
> >
> > -     delayed_refs =3D &trans->transaction->delayed_refs;
>
> Again, not really needed to touch it in a function changing patch.
>
> >       spin_lock(&delayed_refs->lock);
> >
> >       /*
> > @@ -1096,6 +1096,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_tran=
s_handle *trans,
> >               btrfs_qgroup_trace_extent_post(trans, record);
> >
> >       return 0;
> > +
> > +free_record:
> > +     kfree(record);
> > +free_head_ref:
> > +     kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> > +free_ref:
> > +     kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> > +     return -ENOMEM;
> >   }
> >
> >   /*
> > @@ -1137,28 +1145,23 @@ int btrfs_add_delayed_data_ref(struct btrfs_tra=
ns_handle *trans,
> >       ref->objectid =3D owner;
> >       ref->offset =3D offset;
> >
> > -
> > +     delayed_refs =3D &trans->transaction->delayed_refs;
> >       head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
> > -     if (!head_ref) {
> > -             kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> > -             return -ENOMEM;
> > -     }
> > +     if (!head_ref)
> > +             goto free_ref;
> >
> >       if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_q=
group) {
> >               record =3D kzalloc(sizeof(*record), GFP_NOFS);
> > -             if (!record) {
> > -                     kmem_cache_free(btrfs_delayed_data_ref_cachep, re=
f);
> > -                     kmem_cache_free(btrfs_delayed_ref_head_cachep,
> > -                                     head_ref);
> > -                     return -ENOMEM;
> > -             }
> > +             if (!record)
> > +                     goto free_head_ref;
> > +             if (xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_=
NOFS))
> > +                     goto free_record;
>
> Same here.
>
> [...]
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 5470e1cdf10c..717e16da9679 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1890,16 +1890,13 @@ int btrfs_limit_qgroup(struct btrfs_trans_handl=
e *trans, u64 qgroupid,
> >    *
> >    * Return 0 for success insert
> >    * Return >0 for existing record, caller can free @record safely.
> > - * Error is not possible
>
>
> > Then why not add a minus return value case?
> >
> > The most common pattern would be, >0 for one common case (qrecord
> > exists), 0 for another common case (qrecord inserted), <0 for error.
> >
> > Just like btrfs_search_slot().
> > And that's my first impression on the function, but it's not the case.

Reasonable. But the handling will be the same regardless of whether
the return value is greater than 0 or less than 0, which is simply to
free the memory.

>
> >    */
> >   int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
> >                               struct btrfs_delayed_ref_root *delayed_re=
fs,
> >                               struct btrfs_qgroup_extent_record *record=
)
> >   {
> > -     struct rb_node **p =3D &delayed_refs->dirty_extent_root.rb_node;
> > -     struct rb_node *parent_node =3D NULL;
> > -     struct btrfs_qgroup_extent_record *entry;
> > -     u64 bytenr =3D record->bytenr;
> > +     struct btrfs_qgroup_extent_record *existing, *ret;
> > +     unsigned long bytenr =3D record->bytenr;
> >
> >       if (!btrfs_qgroup_full_accounting(fs_info))
> >               return 1;
> > @@ -1907,26 +1904,27 @@ int btrfs_qgroup_trace_extent_nolock(struct btr=
fs_fs_info *fs_info,
> >       lockdep_assert_held(&delayed_refs->lock);
> >       trace_btrfs_qgroup_trace_extent(fs_info, record);
> >
> > -     while (*p) {
> > -             parent_node =3D *p;
> > -             entry =3D rb_entry(parent_node, struct btrfs_qgroup_exten=
t_record,
> > -                              node);
> > -             if (bytenr < entry->bytenr) {
> > -                     p =3D &(*p)->rb_left;
> > -             } else if (bytenr > entry->bytenr) {
> > -                     p =3D &(*p)->rb_right;
> > -             } else {
> > -                     if (record->data_rsv && !entry->data_rsv) {
> > -                             entry->data_rsv =3D record->data_rsv;
> > -                             entry->data_rsv_refroot =3D
> > -                                     record->data_rsv_refroot;
> > -                     }
> > -                     return 1;
> > +     xa_lock(&delayed_refs->dirty_extents);
> > +     existing =3D xa_load(&delayed_refs->dirty_extents, bytenr);
> > +     if (existing) {
> > +             if (record->data_rsv && !existing->data_rsv) {
> > +                     existing->data_rsv =3D record->data_rsv;
> > +                     existing->data_rsv_refroot =3D record->data_rsv_r=
efroot;
> >               }
> > +             xa_unlock(&delayed_refs->dirty_extents);
> > +             return 1;
> > +     }
> > +
> > +     ret =3D __xa_store(&delayed_refs->dirty_extents, record->bytenr, =
record, GFP_ATOMIC);
> > +     xa_unlock(&delayed_refs->dirty_extents);
> > +     if (xa_is_err(ret)) {
> > +             spin_lock(&fs_info->qgroup_lock);
> > +             fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCON=
SISTENT;
>
>
> > We have qgroup_mark_inconsistent(), which would skip future accounting.

Yeh. I saw this function. But it sets the
BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING flag, which will skip some
accounting.
Do you mean that there's no need to account for this inconsistent state?

>
> > +             spin_unlock(&fs_info->qgroup_lock);
> > +
> > +             return 1;
>
>
> > It's much better just to return the xa_err() instead.

Ok. I will do this.

>
> >       }
> >
> > -     rb_link_node(&record->node, parent_node, p);
> > -     rb_insert_color(&record->node, &delayed_refs->dirty_extent_root);
> >       return 0;
> >   }
> >
> > @@ -2027,13 +2025,18 @@ int btrfs_qgroup_trace_extent(struct btrfs_tran=
s_handle *trans, u64 bytenr,
> >       struct btrfs_delayed_ref_root *delayed_refs;
> >       int ret;
> >
> > +     delayed_refs =3D &trans->transaction->delayed_refs;
> >       if (!btrfs_qgroup_full_accounting(fs_info) || bytenr =3D=3D 0 || =
num_bytes =3D=3D 0)
> >               return 0;
> >       record =3D kzalloc(sizeof(*record), GFP_NOFS);
> >       if (!record)
> >               return -ENOMEM;
> >
> > -     delayed_refs =3D &trans->transaction->delayed_refs;
>
>
> > Again, you may want to not touch unrelated code in a function changing
> > patch.
> >
> > Otherwise looks good to me.

Thanks a lot for your thorough review and comments.

>
> Thanks,
> Qu


Best regards,
--=20
Junchao Sun <sunjunchao2870@gmail.com>

