Return-Path: <linux-btrfs+bounces-5391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 425DC8D73DA
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 06:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3F21C20A27
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 04:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81752134A8;
	Sun,  2 Jun 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlt3CIPI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3782BE47
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 04:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717303393; cv=none; b=bgkkZKpeNNhFGsQzCQPQdzAXnyJYzdNNCD3fqFjKrxBmZ0Y8R1B+F6iFUGtZ6EfFpLn8oPRhtBYwxNXLgA4OS1Pbx0wUqQ/VhJ+iSjwT4ZIWpWP+RpsEwH/PCtf5GDH1uEDY55cmq4StaUUBsanG44pfGrRWnRv/mtCOh2PIzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717303393; c=relaxed/simple;
	bh=NJOD7xb3y78hRXn/bZi9IoscM5pEJ0H0NAWrDDU1myk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdHhLXdcAgkGQtcC6I/KjCI3u07IsOvZCnVFS9TuFvI6ihsqLA+4ztx/m/ceKD9N7rBRgl52vPiAFY+23WmT5qdCD8+tcxWRDsZbUxxRezVkdMm8EIuZMGZgTDQOBO66xBRjPj7rEg+3w4T+1Y26y2QKCKmefT0dTV+OsbBPM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlt3CIPI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso3845407a12.0
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jun 2024 21:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717303390; x=1717908190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlrIlwLcuQIYBoMUicoOAHjc2NlBGPe2UzdnIY+mEzE=;
        b=Hlt3CIPIzeYIkszFIvVPOZdwEHpyeJapMNCdjkOIyM+7sjA4hXgZZhDXSerWer/nF3
         4ZsSc7NwcoSupGukHaCVEkk/G3iqILWSIzZakkibdltVjJivPyq8SJ/X+9CIPWXG6lg5
         34ly3jPj4I8jRei+Ia9+XuQvGhvZFxsuhmegloF/CXUAzUjjhHcyvGNyVidqRgfzSy2U
         Qtn/fyP72GkAbhURtzIJOauawexROHUk9emktX+wg3Nl/Cf6IZvBXMRVRvWM066eR3H2
         ZtY2epiRs4AJtHNfGKlhXsF319DefQ3cd6Qbb7iP6Ktuof1ZVnulk2JG2dXn1toJVxJN
         etnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717303390; x=1717908190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlrIlwLcuQIYBoMUicoOAHjc2NlBGPe2UzdnIY+mEzE=;
        b=logbkDGJFtLSXJIiFfE5iCvAWSjvGSzAO4RMBdjaSNrMR49A7RxyyMQflUnoXQClwl
         Lg0oiS8dLRa8GvOFyhgn075yNuFAU9b/dFAx3xvAwbo8NF2xa13jTVajMQO3YKAQLXe1
         lAdxCGV2c+2pr79HHyObb2UWn2ebTVohYTieiY1X0xQ8LLyRp0jJQ28+ddNkv/y3FVE/
         1YKJeHj2AMSQzcSxQs6iiTf6k22yOdYxpvpz1mRmbZ8oQjkNAwaFLmfwz0PiwF8LsAWa
         80KX3lbLNeFSzwudJeqZkZxkX49GhTi5VnJkyEo3laIaXTmKPFN4VQGjZG86ojNjKUrS
         W8kQ==
X-Gm-Message-State: AOJu0YznAq8J7Dd4WqARzD3KOG8tUaaMOjp36BkekkcGD6GQe7c0BNeY
	Orm50wY8FnCoP/o5pTT2wa898AaSKg3Dj/T8CU6SCiRH1r2nsRB7b5QRCPGa46rWyu0QRR5L8w7
	bvJ3pTKQo0fhjgnqgbRU5VlF1Vkc=
X-Google-Smtp-Source: AGHT+IHxcGVeeRM26s0dTgEkWx2CiTvjp4x7zNqQnJE1IA6tThqdwQ7tj0dyMhYqZMckWwBjE0nJiTNvfQGJ1miUyus=
X-Received: by 2002:a50:874f:0:b0:578:d846:fc0a with SMTP id
 4fb4d7f45d1cf-57a3654af64mr4011664a12.20.1717303389541; Sat, 01 Jun 2024
 21:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601114213.1647115-1-sunjunchao2870@gmail.com> <b1773175-9780-4bdf-a751-4df50a3f19d8@suse.com>
In-Reply-To: <b1773175-9780-4bdf-a751-4df50a3f19d8@suse.com>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Sun, 2 Jun 2024 12:42:58 +0800
Message-ID: <CAHB1NainFNy5HictfgPJ-PH59a=Gm_MMc6u7cuj0giZtTdqgxQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: use xarray to track dirty extents in transaction.
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <wqu@suse.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=882=E6=97=A5=E5=91=
=A8=E6=97=A5 06:47=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> =E5=9C=A8 2024/6/1 21:12, Junchao Sun =E5=86=99=E9=81=93:
> > Using xarray to track dirty extents can reduce the size of the
> > struct btrfs_qgroup_extent_record from 64 bytes to 40 bytes.
> > And xarray is more cache line friendly, it also reduces the
> > complexity of insertion and search code compared to rb tree.
> >
> > Another change introduced is about error handling.
> > Before this patch, the result of btrfs_qgroup_trace_extent_nolock()
> > is always success. In this patch, because of this function calls
> > the function xa_store() which has the possibility to fail, so I
> > refactored some code to handle error correctly. Even though that
> > we preallocated memory in advance, here should not return an error
> > theorily. But for the sake of logical completeness, I still
> > refactored the error handling code. If you have any questions or
> > concerns about this part, feel free to let me know.
> >
> > This patch passed the check -g qgroup tests using xfstests and
> > checkpatch tests.
>
> Thanks a lot for the work, but still some problem related to coding
> style and error handling.
>
> [...]
> > @@ -1036,18 +1043,16 @@ int btrfs_add_delayed_tree_ref(struct btrfs_tra=
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
> > +             goto fail1;
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
> > +                     goto fail2;
>
>
> > I'd prefer the old error handling.

Old error handling code would be like this:
                         record =3D kzalloc(sizeof(*record), GFP_NOFS);
                         if (!record) {

kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);

kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
                             return -ENOMEM;
                         }
                         ret =3D
xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS);
                         if (ret) {
                             kfree(qgroup);

kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);

kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
                             return -ENOMEM;
                        }
which looks a little bit redundant. So I used goto style to handle errors.

>
> > +             ret =3D xa_reserve(&delayed_refs->dirty_extents, bytenr, =
GFP_NOFS);
> > +             if (ret)
> > +                     goto fail3;
>
>
> > Qgroup record inserting error is not critical, instead you can just mar=
k
> > qgroup inconsistent and do the remaining cleanup.

Thank you for the reminder. I will mark qgroup inconsistent if error
happened here.
>
> >       }
> >
> >       if (parent)
> > @@ -1067,7 +1072,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
> >                             false, is_system, generic_ref->owning_root)=
;
> >       head_ref->extent_op =3D extent_op;
> >
> > -     delayed_refs =3D &trans->transaction->delayed_refs;
> >       spin_lock(&delayed_refs->lock);
> >
> >       /*
> > @@ -1076,6 +1080,11 @@ int btrfs_add_delayed_tree_ref(struct btrfs_tran=
s_handle *trans,
> >        */
> >       head_ref =3D add_delayed_ref_head(trans, head_ref, record,
> >                                       action, &qrecord_inserted);
> > +     if (IS_ERR(head_ref)) {
> > +             spin_unlock(&delayed_refs->lock);
> > +             ret =3D PTR_ERR(head_ref);
> > +             goto fail3;
> > +     }
>
> If you keep the error handling inside qgrou part by just marking qgroup
> inconsistent, add_delayed_ref_head() won't need to return error and no
> extra error handling.
> >
> >       merged =3D insert_delayed_ref(trans, head_ref, &ref->node);
> >       spin_unlock(&delayed_refs->lock);
> > @@ -1096,6 +1105,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_tran=
s_handle *trans,
> >               btrfs_qgroup_trace_extent_post(trans, record);
> >
> >       return 0;
> > +
> > +fail3:
> > +     kfree(record);
> > +fail2:
> > +     kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> > +fail1:
> > +     kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> > +     return ret;
>
>
> > Please do no use such naming, go with something to indicate the what's
> > going to be freed instead.

yeh. It's reasonable. I will rename it.

>
> >   }
> >
> >   /*
> > @@ -1120,6 +1137,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans=
_handle *trans,
> >       u64 owner =3D generic_ref->data_ref.ino;
> >       u64 offset =3D generic_ref->data_ref.offset;
> >       u8 ref_type;
> > +     int ret =3D -ENOMEM;
> >
> >       ASSERT(generic_ref->type =3D=3D BTRFS_REF_DATA && action);
> >       ref =3D kmem_cache_alloc(btrfs_delayed_data_ref_cachep, GFP_NOFS)=
;
> > @@ -1137,28 +1155,24 @@ int btrfs_add_delayed_data_ref(struct btrfs_tra=
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
> > +             goto fail1;
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
> > +                     goto fail2;
> > +             ret =3D xa_reserve(&delayed_refs->dirty_extents, bytenr, =
GFP_NOFS);
> > +             if (ret)
> > +                     goto fail3;
>
> The same.
>
> >       }
> >
> >       init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_ro=
ot,
> >                             reserved, action, true, false, generic_ref-=
>owning_root);
> >       head_ref->extent_op =3D NULL;
> >
> > -     delayed_refs =3D &trans->transaction->delayed_refs;
> >       spin_lock(&delayed_refs->lock);
> >
> >       /*
> > @@ -1167,6 +1181,11 @@ int btrfs_add_delayed_data_ref(struct btrfs_tran=
s_handle *trans,
> >        */
> >       head_ref =3D add_delayed_ref_head(trans, head_ref, record,
> >                                       action, &qrecord_inserted);
> > +     if (IS_ERR(head_ref)) {
> > +             ret =3D PTR_ERR(head_ref);
> > +             spin_unlock(&delayed_refs->lock);
> > +             goto fail3;
> > +     }
> >
> >       merged =3D insert_delayed_ref(trans, head_ref, &ref->node);
> >       spin_unlock(&delayed_refs->lock);
> > @@ -1187,6 +1206,14 @@ int btrfs_add_delayed_data_ref(struct btrfs_tran=
s_handle *trans,
> >       if (qrecord_inserted)
> >               return btrfs_qgroup_trace_extent_post(trans, record);
> >       return 0;
> > +
> > +fail3:
> > +     kfree(record);
> > +fail2:
> > +     kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> > +fail1:
> > +     kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> > +     return ret;
>
> The same.
>
> >   }
> >
> >   int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
> > diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> > index 62d679d40f4f..f9b20c0671c7 100644
> > --- a/fs/btrfs/delayed-ref.h
> > +++ b/fs/btrfs/delayed-ref.h
> > @@ -166,7 +166,7 @@ struct btrfs_delayed_ref_root {
> >       struct rb_root_cached href_root;
> >
> >       /* dirty extent records */
> > -     struct rb_root dirty_extent_root;
> > +     struct xarray dirty_extents;
> >
> >       /* this spin lock protects the rbtree and the entries inside */
> >       spinlock_t lock;
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 5470e1cdf10c..3241d21a7121 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1890,16 +1890,14 @@ int btrfs_limit_qgroup(struct btrfs_trans_handl=
e *trans, u64 qgroupid,
> >    *
> >    * Return 0 for success insert
> >    * Return >0 for existing record, caller can free @record safely.
> > - * Error is not possible
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
> > +     struct btrfs_qgroup_extent_record *existing;
> > +     const u64 bytenr =3D record->bytenr;
> > +     int ret;
> >
> >       if (!btrfs_qgroup_full_accounting(fs_info))
> >               return 1;
> > @@ -1907,27 +1905,26 @@ int btrfs_qgroup_trace_extent_nolock(struct btr=
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
> > +     existing =3D xa_store(&delayed_refs->dirty_extents, bytenr, recor=
d, GFP_ATOMIC);
> > +     if (xa_is_err(existing))
> > +             goto out;
> > +     else if (existing) {
> > +             if (record->data_rsv && !existing->data_rsv) {
> > +                     existing->data_rsv =3D record->data_rsv;
> > +                     existing->data_rsv_refroot =3D record->data_rsv_r=
efroot;
> >               }
> > +             existing =3D xa_store(&delayed_refs->dirty_extents, byten=
r, existing, GFP_ATOMIC);
>
>
> > Instead of such complex double xa_store to modify the values, why not
> > take xa_lock() and xa_find() so that you can easily find the existing
> > entry and modify the members?
> >
> > In fact the double xa_store() is just going to make it way harder to
> > grasp on which pointer is really stored inside the xarrary.

Yeh. The double xa_store() is unnecessary here and it's really harder
to understand the above code... I will modify it.
>
> > @@ -4664,15 +4668,14 @@ int btrfs_qgroup_trace_subtree_after_cow(struct=
 btrfs_trans_handle *trans,
> >   void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *tr=
ans)
> >   {
> >       struct btrfs_qgroup_extent_record *entry;
> > -     struct btrfs_qgroup_extent_record *next;
> > -     struct rb_root *root;
> > +     unsigned long index;
> >
> > -     root =3D &trans->delayed_refs.dirty_extent_root;
> > -     rbtree_postorder_for_each_entry_safe(entry, next, root, node) {
> > +     xa_for_each(&trans->delayed_refs.dirty_extents, index, entry) {
> >               ulist_free(entry->old_roots);
> >               kfree(entry);
> >       }
> > -     *root =3D RB_ROOT;
> > +     xa_destroy(&trans->delayed_refs.dirty_extents);
> > +     xa_init(&trans->delayed_refs.dirty_extents);
>
>
> > Do you really need to call xa_init() after xa_destory()?

Actually I passed tests using check -g qgroup without the xa_init().
But I noticed the above *root =3D RB_ROOT code, which fixed a bug. So I
thought xarray would be referenced somewhere after this function and
then I reinited the xarray. I will review the relevant code to
determine if it is truly necessary.

>
> >   }
> >
> >   void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u=
64 rsv_bytes)
> > diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> > index be18c862e64e..f8165a27b885 100644
> > --- a/fs/btrfs/qgroup.h
> > +++ b/fs/btrfs/qgroup.h
> > @@ -116,7 +116,6 @@
> >    * TODO: Use kmem cache to alloc it.
> >    */
> >   struct btrfs_qgroup_extent_record {
> > -     struct rb_node node;
> >       u64 bytenr;
> >       u64 num_bytes;
> >
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index bf8e64c766b6..006080814ee5 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -145,8 +145,8 @@ void btrfs_put_transaction(struct btrfs_transaction=
 *transaction)
> >               BUG_ON(!list_empty(&transaction->list));
> >               WARN_ON(!RB_EMPTY_ROOT(
> >                               &transaction->delayed_refs.href_root.rb_r=
oot));
> > -             WARN_ON(!RB_EMPTY_ROOT(
> > -                             &transaction->delayed_refs.dirty_extent_r=
oot));
> > +             WARN_ON(!xa_empty(
> > +                             &transaction->delayed_refs.dirty_extents)=
);
> >               if (transaction->delayed_refs.pending_csums)
> >                       btrfs_err(transaction->fs_info,
> >                                 "pending csums is %llu",
> > @@ -353,7 +353,7 @@ static noinline int join_transaction(struct btrfs_f=
s_info *fs_info,
> >       memset(&cur_trans->delayed_refs, 0, sizeof(cur_trans->delayed_ref=
s));
> >
> >       cur_trans->delayed_refs.href_root =3D RB_ROOT_CACHED;
> > -     cur_trans->delayed_refs.dirty_extent_root =3D RB_ROOT;
> > +     xa_init(&cur_trans->delayed_refs.dirty_extents);
> >       atomic_set(&cur_trans->delayed_refs.num_entries, 0);
> >
> >       /*
> > @@ -690,7 +690,7 @@ start_transaction(struct btrfs_root *root, unsigned=
 int num_items,
> >        * and then we deadlock with somebody doing a freeze.
> >        *
> >        * If we are ATTACH, it means we just want to catch the current
> > -      * transaction and commit it, so we needn't do sb_start_intwrite(=
).
> > +      * transaction and commit it, so we needn't do sb_start_intwrite(=
).
>
>
> > Is this something fixed by LSP server automatically?
> >
> > This looks exactly like a lot of my patches where whitespace errors are
> > auto-corrected...

Indeed. I have been using vscode + clangd to view the source code. It
may be fixed by clangd automatically. It is not appropriate in the
patch about functional modification, I will remove it.
Thanks a lot for your thorough review and comments. Thanks for your
time. I will send patch v2 to fix them.

>
> Thanks,
> Qu
> >        */
> >       if (type & __TRANS_FREEZABLE)
> >               sb_start_intwrite(fs_info->sb);

