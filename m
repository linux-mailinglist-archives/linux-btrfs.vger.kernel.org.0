Return-Path: <linux-btrfs+bounces-11041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBDA192F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 14:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC385165A54
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF8213E77;
	Wed, 22 Jan 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WUlvRJyf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59314F70
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553885; cv=none; b=TiVfN3vsgBD8PIypy+WuNxfAskFfRA80C4knEBsWk2139v+oqL7LpwsZ3XVObRMwGOPTPvbHg34tFG9OOpLqwPCZ7SpJjrEJEE1+6FcSqgfIW9Gs/LXzrGVHD+gZvUmfu5ZfQ9ryqwqF3xNbJ2iEje2QKR8Me2aQXodl6yRFfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553885; c=relaxed/simple;
	bh=/BDqDGmQW1XcxUNZtH2npFNkG+N2rLLHH7xKUEAy8KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbmKhCrkFQD2h/OcmnG6Y0pXbCvNsRbxU/yH0pEkvy7yZMlMDu+nH7b2ob+gIcAmUmeXElYxcvcGwdZATg/rjoBVqHmjwEUDAzd2wHJnMvfc3I6j1uL86ukTRK8GRqSQ+9lTDRnQc8Tz2wBES4gwwIg49ssiBY8TX7puG2l3r3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WUlvRJyf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa679ad4265so194237366b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 05:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737553881; x=1738158681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ3qzmtuL4tBu1fXg/3SFLsptS468PCDwDDNAIsrKyM=;
        b=WUlvRJyfzhc0TcotUpmb7sa0Ap3nSS3HYfMQthugBU3N0U9lXRAAVpzOBUafdYuAwX
         3EVlBEE7Gu4o5VQhFI2R8615dBZ/cL44aTdrw3Ix1erruV1w+SFNtX9CUA7fscN8cwv8
         aKldKjA7eR98yFtBQcLcOycqZjpg+fIowWHHospgJDnESPKwZsvV6sMALtNtIA22pory
         XldLBWDd2FdOSCzV8pau9wk2Sr91mnNzfnfpDRsgRvAYYiBqCHvolYMjHpsMaoyctkTs
         Eh4CPJvTtcfSHXuZ4xp7UcQOQoJKaQ920Fk/0a5ShaJcWGTbAzQggv+ASRUTfY2UdDpd
         kDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737553881; x=1738158681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ3qzmtuL4tBu1fXg/3SFLsptS468PCDwDDNAIsrKyM=;
        b=wuy5f8LupQsbTNFzd9mhr6YPbA5bf22VyIebG8i7hJndKIyZZuOicZkrKeXREaGHrI
         h6ANzL4CPdqUF9u2RSQnpBbppwNBgL85JYtAiapewUp12NhiQ5hPfNbxneTyNfMnswoc
         ct/bZ3KzRDiYL9H/kcDmrPeEDKO8rhMOhVe/iNT6GccMrJL+DF2DInBQzVsgxu53bpEb
         0bGgfpwvcMN4FnKJlFsBUMRvgwQuGADceVm+K1mJEk2qiXmByo0FAiwixgS4uxcD/RK+
         PKvv+0ZzCGBLMI864MgoCWtnQXbqtuV02/F68mNaCGyocEYak1DTRtB6uPF4WujNpsQo
         yHEA==
X-Forwarded-Encrypted: i=1; AJvYcCVuFmBkyr4/nciphWR4beTx9ocLlz+j0fQ/MpspnLxcS2iEavmhcGIIkD71DLuRDkQ5o7RdKNpfTfxKtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoWDKDXOh/eA/j9ZNAT8flDaAmrojpKWjLONfgWEqrtPW9Bwu
	P/bFZWLOT4nwwNst4RIBLan7VSY9cT/Noum0uLHZEntuUqOQap6/fchbIFatEmIphlJ6j+Lhjnz
	fpDXpZ1kOR+2PcunzgRkMuE4AtivrFiWDNpuzrg==
X-Gm-Gg: ASbGnctsoVd9xDATZgSUWr594dY4stwrKdmzHUtDM9nNOneR0/rILeGxw/feaB6KRDr
	ZYIIrngpwPBww1TlkIKBa9yuScAmXsnbL8/BSQuXYLVUSHZZnDA==
X-Google-Smtp-Source: AGHT+IHxTsLIrAC6zhh+xFT19t7qJCirRx5rwWom9OZGVsdzsgeK6OY9f52T1aAzv8MqmpUlBz61i8RgDthNTw47cCE=
X-Received: by 2002:a17:907:9485:b0:ab3:3b92:8ca5 with SMTP id
 a640c23a62f3a-ab36e2422camr2445750366b.12.1737553881312; Wed, 22 Jan 2025
 05:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122122459.1148668-1-maharmstone@fb.com> <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
In-Reply-To: <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 22 Jan 2025 14:51:10 +0100
X-Gm-Features: AbW1kvawd6mc-BG3APXYrH-8MCIUet4-Jqf0EhrDvehPf6DGoamrryhNZRTsfuk
Message-ID: <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2025 at 13:40, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Wed, Jan 22, 2025 at 12:25=E2=80=AFPM Mark Harmstone <maharmstone@fb.c=
om> wrote:
> >
> > Currently btrfs_get_free_objectid() uses a mutex to protect
> > free_objectid; I'm guessing this was because of the inode cache that we
> > used to have. The inode cache is no more, so simplify things by
> > replacing it with an atomic.
> >
> > There's no issues with ordering: free_objectid gets set to an initial
> > value, then calls to btrfs_get_free_objectid() return a monotonically
> > increasing value.
> >
> > This change means that btrfs_get_free_objectid() will no longer
> > potentially sleep, which was a blocker for adding a non-blocking mode
> > for inode and subvol creation.
> >
> > Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> > ---
> >  fs/btrfs/ctree.h    |  4 +---
> >  fs/btrfs/disk-io.c  | 43 ++++++++++++++++++-------------------------
> >  fs/btrfs/qgroup.c   | 11 ++++++-----
> >  fs/btrfs/tree-log.c |  3 ---
> >  4 files changed, 25 insertions(+), 36 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 1096a80a64e7..04175698525b 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -179,8 +179,6 @@ struct btrfs_root {
> >         struct btrfs_fs_info *fs_info;
> >         struct extent_io_tree dirty_log_pages;
> >
> > -       struct mutex objectid_mutex;
> > -
> >         spinlock_t accounting_lock;
> >         struct btrfs_block_rsv *block_rsv;
> >
> > @@ -214,7 +212,7 @@ struct btrfs_root {
> >
> >         u64 last_trans;
> >
> > -       u64 free_objectid;
> > +       atomic64_t free_objectid;
> >
> >         struct btrfs_key defrag_progress;
> >         struct btrfs_key defrag_max;
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index f09db62e61a1..0543d9c3f8c0 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -659,7 +659,7 @@ static void __setup_root(struct btrfs_root *root, s=
truct btrfs_fs_info *fs_info,
> >         RB_CLEAR_NODE(&root->rb_node);
> >
> >         btrfs_set_root_last_trans(root, 0);
> > -       root->free_objectid =3D 0;
> > +       atomic64_set(&root->free_objectid, 0);
> >         root->nr_delalloc_inodes =3D 0;
> >         root->nr_ordered_extents =3D 0;
> >         xa_init(&root->inodes);
> > @@ -678,7 +678,6 @@ static void __setup_root(struct btrfs_root *root, s=
truct btrfs_fs_info *fs_info,
> >         spin_lock_init(&root->ordered_extent_lock);
> >         spin_lock_init(&root->accounting_lock);
> >         spin_lock_init(&root->qgroup_meta_rsv_lock);
> > -       mutex_init(&root->objectid_mutex);
> >         mutex_init(&root->log_mutex);
> >         mutex_init(&root->ordered_extent_mutex);
> >         mutex_init(&root->delalloc_mutex);
> > @@ -1133,16 +1132,12 @@ static int btrfs_init_fs_root(struct btrfs_root=
 *root, dev_t anon_dev)
> >                 }
> >         }
> >
> > -       mutex_lock(&root->objectid_mutex);
> >         ret =3D btrfs_init_root_free_objectid(root);
> > -       if (ret) {
> > -               mutex_unlock(&root->objectid_mutex);
> > +       if (ret)
> >                 goto fail;
> > -       }
> >
> > -       ASSERT(root->free_objectid <=3D BTRFS_LAST_FREE_OBJECTID);
> > -
> > -       mutex_unlock(&root->objectid_mutex);
> > +       ASSERT((u64)atomic64_read(&root->free_objectid) <=3D
> > +               BTRFS_LAST_FREE_OBJECTID);
> >
> >         return 0;
> >  fail:
> > @@ -2730,8 +2725,9 @@ static int __cold init_tree_roots(struct btrfs_fs=
_info *fs_info)
> >                 }
> >
> >                 /*
> > -                * No need to hold btrfs_root::objectid_mutex since the=
 fs
> > -                * hasn't been fully initialised and we are the only us=
er
> > +                * No need to worry about atomic ordering of btrfs_root=
::free_objectid
> > +                * since the fs hasn't been fully initialised and we ar=
e the
> > +                * only user
> >                  */
> >                 ret =3D btrfs_init_root_free_objectid(tree_root);
> >                 if (ret < 0) {
> > @@ -2739,7 +2735,8 @@ static int __cold init_tree_roots(struct btrfs_fs=
_info *fs_info)
> >                         continue;
> >                 }
> >
> > -               ASSERT(tree_root->free_objectid <=3D BTRFS_LAST_FREE_OB=
JECTID);
> > +               ASSERT((u64)atomic64_read(&tree_root->free_objectid) <=
=3D
> > +                       BTRFS_LAST_FREE_OBJECTID);
> >
> >                 ret =3D btrfs_read_roots(fs_info);
> >                 if (ret < 0) {
> > @@ -4931,10 +4928,11 @@ int btrfs_init_root_free_objectid(struct btrfs_=
root *root)
> >                 slot =3D path->slots[0] - 1;
> >                 l =3D path->nodes[0];
> >                 btrfs_item_key_to_cpu(l, &found_key, slot);
> > -               root->free_objectid =3D max_t(u64, found_key.objectid +=
 1,
> > -                                           BTRFS_FIRST_FREE_OBJECTID);
> > +               atomic64_set(&root->free_objectid,
> > +                            max_t(u64, found_key.objectid + 1,
> > +                                  BTRFS_FIRST_FREE_OBJECTID));
> >         } else {
> > -               root->free_objectid =3D BTRFS_FIRST_FREE_OBJECTID;
> > +               atomic64_set(&root->free_objectid, BTRFS_FIRST_FREE_OBJ=
ECTID);
> >         }
> >         ret =3D 0;
> >  error:
> > @@ -4944,20 +4942,15 @@ int btrfs_init_root_free_objectid(struct btrfs_=
root *root)
> >
> >  int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
> >  {
> > -       int ret;
> > -       mutex_lock(&root->objectid_mutex);
> > +       u64 val =3D atomic64_inc_return(&root->free_objectid) - 1;
> >
> > -       if (unlikely(root->free_objectid >=3D BTRFS_LAST_FREE_OBJECTID)=
) {
> > +       if (unlikely(val >=3D BTRFS_LAST_FREE_OBJECTID)) {
> >                 btrfs_warn(root->fs_info,
> >                            "the objectid of root %llu reaches its highe=
st value",
> >                            btrfs_root_id(root));
> > -               ret =3D -ENOSPC;
> > -               goto out;
> > +               return -ENOSPC;
> >         }
> >
> > -       *objectid =3D root->free_objectid++;
> > -       ret =3D 0;
>
> So this gives different semantics now.
>
> Before we increment free_objectid only if it's less than
> BTRFS_LAST_FREE_OBJECTID, so once we reach that value we can't assign
> more object IDs and must return -ENOSPC.
>
> But now we always increment and then do the check, so after some calls
> to btrfs_get_free_objectid() we wrap around the counter due to
> overflow and eventually allow reusing already assigned object IDs.
>
> I'm afraid the lock is still needed because of that. To make it more
> lightweight maybe switch the mutex to a spinlock.

How about this?

```
retry:  val =3D atomic64_read(&root->free_objectid);
        ....;
        if (atomic64_cmpxchg(&root->free_objectid, val, val+1) !=3D val)
                goto retry;
        *objectid =3D val;
        return 0;
```

> Thanks.
>
> > -out:
> > -       mutex_unlock(&root->objectid_mutex);
> > -       return ret;
> > +       *objectid =3D val;
> > +       return 0;
> >  }
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index aaf16019d829..b41e06d5d2fb 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -472,18 +472,19 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info=
 *fs_info)
> >                          *
> >                          * Ensure that we skip any such subvol ids.
> >                          *
> > -                        * We don't need to lock because this is only c=
alled
> > -                        * during mount before we start doing things li=
ke creating
> > -                        * subvolumes.
> > +                        * We don't need to worry about atomic ordering=
 because
> > +                        * this is only called during mount before we s=
tart
> > +                        * doing things like creating subvolumes.
> >                          */
> >                         if (is_fstree(qgroup->qgroupid) &&
> > -                           qgroup->qgroupid > tree_root->free_objectid=
)
> > +                           qgroup->qgroupid > (u64)atomic64_read(&tree=
_root->free_objectid))
> >                                 /*
> >                                  * Don't need to check against BTRFS_LA=
ST_FREE_OBJECTID,
> >                                  * as it will get checked on the next c=
all to
> >                                  * btrfs_get_free_objectid.
> >                                  */
> > -                               tree_root->free_objectid =3D qgroup->qg=
roupid + 1;
> > +                               atomic64_set(&tree_root->free_objectid,
> > +                                            qgroup->qgroupid + 1);
> >                 }
> >                 ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
> >                 if (ret < 0)
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 955d1677e865..9d19528fee17 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -7325,9 +7325,6 @@ int btrfs_recover_log_trees(struct btrfs_root *lo=
g_root_tree)
> >                          * We have just replayed everything, and the hi=
ghest
> >                          * objectid of fs roots probably has changed in=
 case
> >                          * some inode_item's got replayed.
> > -                        *
> > -                        * root->objectid_mutex is not acquired as log =
replay
> > -                        * could only happen during mount.
> >                          */
> >                         ret =3D btrfs_init_root_free_objectid(root);
> >                         if (ret)
> > --
> > 2.45.2
> >
> >
>

