Return-Path: <linux-btrfs+bounces-21328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHb7E3U5gmmVQgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21328-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 19:07:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CDEDD523
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 19:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37862309C8BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA65364EB2;
	Tue,  3 Feb 2026 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcNawCex"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF641FE47C
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141848; cv=none; b=jwg4UZI79gbLAt5Y40fkIETQPt9um/84gWPH1TN45CM1bxb0oj8A3WpnItXDbzesPe1PuQDlXesyahhZ9MXAwuVdiGdNnMB1bvvXpQMomF9rjBnqgM+Vl0qMe1Y1FDceVX6/mKmmoA6gddQk2oLEZPF4tjX4nIMmDzigAvc+36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141848; c=relaxed/simple;
	bh=5xnEwOo18XHKy00M9x8eTHFpZ/We3Z1Yh5JVz30mrrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UK0Oj91jlG7n4JeVF3uBlml4X8GA1uA+/PghCd9LUITecnzrfEZx4EG9l5TH4CDcfH6l+/9+9sQ6Q/oJAyqNhj6WfK2FsBOyIgQrwY3NMBUGNZBvsPckb41mBQt/zzF+M7dkWLPTKlubZ9rQxJxCB+UxZa2MpsH9IAlVEhib070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcNawCex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59805C116D0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141848;
	bh=5xnEwOo18XHKy00M9x8eTHFpZ/We3Z1Yh5JVz30mrrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GcNawCexTWglM5NewBwLqAvOyS2qgaKyzdzYcek67xx/SrTR0mUXdShtOBZQvDr2o
	 E5SClzSidy4WoLhRs9Jz0yAe0lfs9ihImHXnXECbdYf0zwFp3hwZEgOWD0XdReFfeI
	 uVkHqtD6njtCnitWsfpqUnX+LBWLdU3LI+TJW3cdUo9F1hudQNuuY1V19J7bLh5czr
	 VIO0U3GSyDWJERiD5F6R1DmXJI4vNrEdbPfcHNiyLe5TZGjVS5gk7KbaEfSE/c5Uws
	 XG15UxJtRCjvAuZNsZtOP7XhOhtDYvOtQ0J4wx6EmNCu8HCURQbX3VQpm/6/trt5Ps
	 tRMPoE+080lTg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-653780e9eb3so8141904a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 10:04:08 -0800 (PST)
X-Gm-Message-State: AOJu0YzIV8olpTur7HrtzXHJ8zY1eRBNHMkRMwRKhsQgGIqcV9hfCgMj
	oCbeLqCqWoSoHnneA1wYXR251z9JKv9O07TrVngdBW7Nl8455S782jy8DwbCD2GKRbi2O2ZeMir
	54NJkBnms2g1Fl+t/H73kq9tA6WIG5AI=
X-Received: by 2002:a17:907:3ea0:b0:b87:daee:a6c4 with SMTP id
 a640c23a62f3a-b8e9f1ab192mr26568166b.36.1770141846655; Tue, 03 Feb 2026
 10:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1694192469.git.fdmanana@suse.com> <2e3540a727d0d75682f4f70e5de76c503e33049f.1694192469.git.fdmanana@suse.com>
 <CAOcd+r0FHG5LWzTSu=LknwSoqxfw+C00gFAW7fuX71+Z5AfEew@mail.gmail.com>
In-Reply-To: <CAOcd+r0FHG5LWzTSu=LknwSoqxfw+C00gFAW7fuX71+Z5AfEew@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Feb 2026 18:03:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5gP70AWzHVu2TF2J25C8cDOVGsqZQKKGPK89PavfN94w@mail.gmail.com>
X-Gm-Features: AZwV_QiFOhZKADreC_TX2RdWn-AyhksEqfNGoGskoLf3LIssTTGiXu8x2cJGyPQ
Message-ID: <CAL3q7H5gP70AWzHVu2TF2J25C8cDOVGsqZQKKGPK89PavfN94w@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] btrfs: always reserve space for delayed refs
 when starting transaction
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21328-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zadara.com:email,mail.gmail.com:mid,toxicpanda.com:email]
X-Rspamd-Queue-Id: D6CDEDD523
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 5:43=E2=80=AFPM Alex Lyakas <alex.lyakas@zadara.com>=
 wrote:
>
> Hi Filipe,
>
>
> On Fri, Sep 8, 2023 at 8:21=E2=80=AFPM <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When starting a transaction (or joining an existing one with
> > btrfs_start_transaction()), we reserve space for the number of items we
> > want to insert in a btree, but we don't do it for the delayed refs we
> > will generate while using the transaction to modify (COW) extent buffer=
s
> > in a btree or allocate new extent buffers. Basically how it works:
> >
> > 1) When we start a transaction we reserve space for the number of items
> >    the caller wants to be inserted/modified/deleted in a btree. This sp=
ace
> >    goes to the transaction block reserve;
> >
> > 2) If the delayed refs block reserve is not full, its size is greater
> >    than the amount of its reserved space, and the flush method is
> >    BTRFS_RESERVE_FLUSH_ALL, then we attempt to reserve more space for
> >    it corresponding to the number of items the caller wants to
> >    insert/modify/delete in a btree;
> >
> > 3) The size of the delayed refs block reserve is increased when a task
> >    creates delayed refs after COWing an extent buffer, allocating a new
> >    one or deleting (freeing) an extent buffer. This happens after the
> >    the task started or joined a transaction, whenever it calls
> >    btrfs_update_delayed_refs_rsv();
> >
> > 4) The delayed refs block reserve is then refilled by anyone calling
> >    btrfs_delayed_refs_rsv_refill(), either during unlink/truncate
> >    operations or when someone else calls btrfs_start_transaction() with
> >    a 0 number of items and flush method BTRFS_RESERVE_FLUSH_ALL;
> >
> > 5) As a task COWs or allocates extent buffers, it consumes space from t=
he
> >    transaction block reserve. When the task releases its transaction
> >    handle (btrfs_end_transaction()) or it attempts to commit the
> >    transaction, it releases any remaining space in the transaction bloc=
k
> >    reserve that it did not use, as not all space may have been used (du=
e
> >    to pessimistic space calculation) by calling btrfs_block_rsv_release=
()
> >    which will try to add that unused space to the delayed refs block
> >    reserve (if its current size is greater than its reserved space).
> >    That transferred space may not be enough to completely fulfill the
> >    delayed refs block reserve.
> >
> >    Plus we have some tasks that will attempt do modify as many leaves
> >    as they can before getting -ENOSPC (and then reserving more space an=
d
> >    retrying), such as hole punching and extent cloning which call
> >    btrfs_replace_file_extents(). Such tasks can generate therefore a
> >    high number of delayed refs, for both metadata and data (we can't
> >    know in advance how many file extent items we will find in a range
> >    and therefore how many delayed refs for dropping references on data
> >    extents we will generate);
> >
> > 6) If a transaction starts its commit before the delayeds refs block
> >    reserve is refilled, for example by the transaction kthread or by
> >    someone who called btrfs_join_transaction() before starting the
> >    commit, then when running delayed references if we don't have enough
> >    reserved space in the delayed refs block reserve, we will consume
> >    space from the global block reserve.
> >
> > Now this doesn't make a lot of sense because:
> >
> > 1) We should reserve space for delayed references when starting the
> >    transaction, since we have no guarantees the delayed refs block
> >    reserve will be refilled;
> >
> > 2) If no refill happens then we will consume from the global block rese=
rve
> >    when running delayed refs during the transaction commit;
> >
> > 3) If we have a bunch of tasks calling btrfs_start_transaction() with a
> >    number of items greater than zero and at the time the delayed refs
> >    reserve is full, then we don't reserve any space at
> >    btrfs_start_transaction() for the delayed refs that will be generate=
d
> >    by a task, and we can therefore end up using a lot of space from the
> >    global reserve when running the delayed refs during a transaction
> >    commit;
> >
> > 4) There are also other operations that result in bumping the size of t=
he
> >    delayed refs reserve, such as creating and deleting block groups, as
> >    well as the need to update a block group item because we allocated o=
r
> >    freed an extent from the respective block group;
> >
> > 5) If we have a significant gap betweent the delayed refs reserve's siz=
e
> >    and its reserved space, two very bad things may happen:
> >
> >    1) The reserved space of the global reserve may not be enough and we
> >       fail the transaction commit with -ENOSPC when running delayed ref=
s;
> >
> >    2) If the available space in the global reserve is enough it may res=
ult
> >       in nearly exhausting it. If the fs has no more unallocated device
> >       space for allocating a new block group and all the available spac=
e
> >       in existing metadata block groups is not far from the global
> >       reserve's size before we started the transaction commit, we may e=
nd
> >       up in a situation where after the transaction commit we have too
> >       little available metadata space, and any future transaction commi=
t
> >       will fail with -ENOSPC, because although we were able to reserve
> >       space to start the transaction, we were not able to commit it, as
> >       running delayed refs generates some more delayed refs (to update =
the
> >       extent tree for example) - this includes not even being able to
> >       commit a transaction that was started with the goal of unlinking =
a
> >       file, removing an empty data block group or doing reclaim/balance=
,
> >       so there's no way to release metadata space.
> >
> >       In the worst case the next time we mount the filesystem we may
> >       also fail with -ENOSPC due to failure to commit a transaction to
> >       cleanup orphan inodes. This later case was reported and hit by
> >       someone running a SLE (SUSE Linux Enterprise) distribution for
> >       example - where the fs had no more unallocated space that could b=
e
> >       used to allocate a new metadata block group, and the available
> >       metadata space was about 1.5M, not enough to commit a transaction
> >       to cleanup an orphan inode (or do relocation of data block groups
> >       that were far from being full).
> >
> > So improve on this situation by always reserving space for delayed refs
> > when calling start_transaction(), and if the flush method is
> > BTRFS_RESERVE_FLUSH_ALL, also try to refill the delayeds refs block
> > reserve if it's not full. The space reserved for the delayed refs is ad=
ded
> > to a local block reserve that is part of the transaction handle, and wh=
en
> > a task updates the delayed refs block reserve size, after creating a
> > delayed ref, the space is transferred from that local reserve to the
> > global delayed refs reserve (fs_info->delayed_refs_rsv). In case the
> > local reserve does not have enough space, which may happen for tasks
> > that generate a variable and potentially large number of delayed refs
> > (such as the hole punching and extent cloning cases mentioned before),
> > we transfer any available space and then rely on the current behaviour
> > of hoping some other task refills the delayed refs reserve or fallback
> > to the global block reserve.
> >
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/block-rsv.c   |   6 +-
> >  fs/btrfs/delayed-ref.c |  21 ++++++-
> >  fs/btrfs/transaction.c | 135 ++++++++++++++++++++++++++++++++---------
> >  fs/btrfs/transaction.h |   2 +
> >  4 files changed, 132 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> > index 6ccd91bbff3e..6a8f9629bbbd 100644
> > --- a/fs/btrfs/block-rsv.c
> > +++ b/fs/btrfs/block-rsv.c
> > @@ -281,10 +281,10 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info =
*fs_info,
> >         struct btrfs_block_rsv *target =3D NULL;
> >
> >         /*
> > -        * If we are the delayed_rsv then push to the global rsv, other=
wise dump
> > -        * into the delayed rsv if it is not full.
> > +        * If we are a delayed block reserve then push to the global rs=
v,
> > +        * otherwise dump into the global delayed reserve if it is not =
full.
> >          */
> > -       if (block_rsv =3D=3D delayed_rsv)
> > +       if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELOPS)
> >                 target =3D global_rsv;
> >         else if (block_rsv !=3D global_rsv && !btrfs_block_rsv_full(del=
ayed_rsv))
> >                 target =3D delayed_rsv;
> > diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> > index a6680e8756a1..383d5be22941 100644
> > --- a/fs/btrfs/delayed-ref.c
> > +++ b/fs/btrfs/delayed-ref.c
> > @@ -89,7 +89,9 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans=
_handle *trans)
> >  {
> >         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> >         struct btrfs_block_rsv *delayed_rsv =3D &fs_info->delayed_refs_=
rsv;
> > +       struct btrfs_block_rsv *local_rsv =3D &trans->delayed_rsv;
> >         u64 num_bytes;
> > +       u64 reserved_bytes;
> >
> >         num_bytes =3D btrfs_calc_delayed_ref_bytes(fs_info, trans->dela=
yed_ref_updates);
> >         num_bytes +=3D btrfs_calc_delayed_ref_csum_bytes(fs_info,
> > @@ -98,9 +100,26 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_tra=
ns_handle *trans)
> >         if (num_bytes =3D=3D 0)
> >                 return;
> >
> > +       /*
> > +        * Try to take num_bytes from the transaction's local delayed r=
eserve.
> > +        * If not possible, try to take as much as it's available. If t=
he local
> > +        * reserve doesn't have enough reserved space, the delayed refs=
 reserve
> > +        * will be refilled next time btrfs_delayed_refs_rsv_refill() i=
s called
> > +        * by someone or if a transaction commit is triggered before th=
at, the
> > +        * global block reserve will be used. We want to minimize using=
 the
> > +        * global block reserve for cases we can account for in advance=
, to
> > +        * avoid exhausting it and reach -ENOSPC during a transaction c=
ommit.
> > +        */
> > +       spin_lock(&local_rsv->lock);
> > +       reserved_bytes =3D min(num_bytes, local_rsv->reserved);
> > +       local_rsv->reserved -=3D reserved_bytes;
> > +       local_rsv->full =3D (local_rsv->reserved >=3D local_rsv->size);
> > +       spin_unlock(&local_rsv->lock);
> > +
> >         spin_lock(&delayed_rsv->lock);
> >         delayed_rsv->size +=3D num_bytes;
> > -       delayed_rsv->full =3D false;
> > +       delayed_rsv->reserved +=3D reserved_bytes;
> > +       delayed_rsv->full =3D (delayed_rsv->reserved >=3D delayed_rsv->=
size);
> >         spin_unlock(&delayed_rsv->lock);
> >         trans->delayed_ref_updates =3D 0;
> >         trans->delayed_ref_csum_deletions =3D 0;
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 4453d8113b37..ac347de1ffb8 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -555,6 +555,69 @@ static inline bool need_reserve_reloc_root(struct =
btrfs_root *root)
> >         return true;
> >  }
> >
> > +static int btrfs_reserve_trans_metadata(struct btrfs_fs_info *fs_info,
> > +                                       enum btrfs_reserve_flush_enum f=
lush,
> > +                                       u64 num_bytes,
> > +                                       u64 *delayed_refs_bytes)
> > +{
> > +       struct btrfs_block_rsv *delayed_refs_rsv =3D &fs_info->delayed_=
refs_rsv;
> > +       struct btrfs_space_info *si =3D fs_info->trans_block_rsv.space_=
info;
> > +       u64 extra_delayed_refs_bytes =3D 0;
> > +       u64 bytes;
> > +       int ret;
> > +
> > +       /*
> > +        * If there's a gap between the size of the delayed refs reserv=
e and
> > +        * its reserved space, than some tasks have added delayed refs =
or bumped
> > +        * its size otherwise (due to block group creation or removal, =
or block
> > +        * group item update). Also try to allocate that gap in order t=
o prevent
> > +        * using (and possibly abusing) the global reserve when committ=
ing the
> > +        * transaction.
> > +        */
> > +       if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL &&
> > +           !btrfs_block_rsv_full(delayed_refs_rsv)) {
> > +               spin_lock(&delayed_refs_rsv->lock);
> > +               if (delayed_refs_rsv->size > delayed_refs_rsv->reserved=
)
> > +                       extra_delayed_refs_bytes =3D delayed_refs_rsv->=
size -
> > +                               delayed_refs_rsv->reserved;
> > +               spin_unlock(&delayed_refs_rsv->lock);
> > +       }
> > +
> > +       bytes =3D num_bytes + *delayed_refs_bytes + extra_delayed_refs_=
bytes;
> > +
> > +       /*
> > +        * We want to reserve all the bytes we may need all at once, so=
 we only
> > +        * do 1 enospc flushing cycle per transaction start.
> > +        */
> > +       ret =3D btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush)=
;
> > +       if (ret =3D=3D 0) {
> > +               if (extra_delayed_refs_bytes > 0)
> > +                       btrfs_migrate_to_delayed_refs_rsv(fs_info,
> > +                                                         extra_delayed=
_refs_bytes);
> > +               return 0;
> > +       }
> > +
> > +       if (extra_delayed_refs_bytes > 0) {
> > +               bytes -=3D extra_delayed_refs_bytes;
> > +               ret =3D btrfs_reserve_metadata_bytes(fs_info, si, bytes=
, flush);
> > +               if (ret =3D=3D 0)
> > +                       return 0;
> > +       }
> > +
> > +       /*
> > +        * If we are an emergency flush, which can steal from the globa=
l block
> > +        * reserve, then attempt to not reserve space for the delayed r=
efs, as
> > +        * we will consume space for them from the global block reserve=
.
> > +        */
> > +       if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL_STEAL) {
> > +               bytes -=3D *delayed_refs_bytes;
> > +               *delayed_refs_bytes =3D 0;
> > +               ret =3D btrfs_reserve_metadata_bytes(fs_info, si, bytes=
, flush);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  static struct btrfs_trans_handle *
> >  start_transaction(struct btrfs_root *root, unsigned int num_items,
> >                   unsigned int type, enum btrfs_reserve_flush_enum flus=
h,
> > @@ -562,10 +625,12 @@ start_transaction(struct btrfs_root *root, unsign=
ed int num_items,
> >  {
> >         struct btrfs_fs_info *fs_info =3D root->fs_info;
> >         struct btrfs_block_rsv *delayed_refs_rsv =3D &fs_info->delayed_=
refs_rsv;
> > +       struct btrfs_block_rsv *trans_rsv =3D &fs_info->trans_block_rsv=
;
> >         struct btrfs_trans_handle *h;
> >         struct btrfs_transaction *cur_trans;
> >         u64 num_bytes =3D 0;
> >         u64 qgroup_reserved =3D 0;
> > +       u64 delayed_refs_bytes =3D 0;
> >         bool reloc_reserved =3D false;
> >         bool do_chunk_alloc =3D false;
> >         int ret;
> > @@ -588,9 +653,6 @@ start_transaction(struct btrfs_root *root, unsigned=
 int num_items,
> >          * the appropriate flushing if need be.
> >          */
> >         if (num_items && root !=3D fs_info->chunk_root) {
> > -               struct btrfs_block_rsv *rsv =3D &fs_info->trans_block_r=
sv;
> > -               u64 delayed_refs_bytes =3D 0;
> > -
> >                 qgroup_reserved =3D num_items * fs_info->nodesize;
> >                 /*
> >                  * Use prealloc for now, as there might be a currently =
running
> > @@ -602,20 +664,16 @@ start_transaction(struct btrfs_root *root, unsign=
ed int num_items,
> >                 if (ret)
> >                         return ERR_PTR(ret);
> >
> > +               num_bytes =3D btrfs_calc_insert_metadata_size(fs_info, =
num_items);
> >                 /*
> > -                * We want to reserve all the bytes we may need all at =
once, so
> > -                * we only do 1 enospc flushing cycle per transaction s=
tart.  We
> > -                * accomplish this by simply assuming we'll do num_item=
s worth
> > -                * of delayed refs updates in this trans handle, and re=
fill that
> > -                * amount for whatever is missing in the reserve.
> > +                * If we plan to insert/update/delete "num_items" from =
a btree,
> > +                * we will also generate delayed refs for extent buffer=
s in the
> > +                * respective btree paths, so reserve space for the del=
ayed refs
> > +                * that will be generated by the caller as it modifies =
btrees.
> > +                * Try to reserve them to avoid excessive use of the gl=
obal
> > +                * block reserve.
> >                  */
> > -               num_bytes =3D btrfs_calc_insert_metadata_size(fs_info, =
num_items);
> > -               if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL &&
> > -                   !btrfs_block_rsv_full(delayed_refs_rsv)) {
> > -                       delayed_refs_bytes =3D btrfs_calc_delayed_ref_b=
ytes(fs_info,
> > -                                                                      =
   num_items);
> > -                       num_bytes +=3D delayed_refs_bytes;
> > -               }
> > +               delayed_refs_bytes =3D btrfs_calc_delayed_ref_bytes(fs_=
info, num_items);
> >
> >                 /*
> >                  * Do the reservation for the relocation root creation
> > @@ -625,18 +683,14 @@ start_transaction(struct btrfs_root *root, unsign=
ed int num_items,
> >                         reloc_reserved =3D true;
> >                 }
> >
> > -               ret =3D btrfs_reserve_metadata_bytes(fs_info, rsv->spac=
e_info,
> > -                                                  num_bytes, flush);
> > +               ret =3D btrfs_reserve_trans_metadata(fs_info, flush, nu=
m_bytes,
> > +                                                  &delayed_refs_bytes)=
;
> >                 if (ret)
> >                         goto reserve_fail;
> > -               if (delayed_refs_bytes) {
> > -                       btrfs_migrate_to_delayed_refs_rsv(fs_info,
> > -                                                         delayed_refs_=
bytes);
> > -                       num_bytes -=3D delayed_refs_bytes;
> > -               }
> > -               btrfs_block_rsv_add_bytes(rsv, num_bytes, true);
> >
> > -               if (rsv->space_info->force_alloc)
> > +               btrfs_block_rsv_add_bytes(trans_rsv, num_bytes, true);
> > +
> > +               if (trans_rsv->space_info->force_alloc)
> >                         do_chunk_alloc =3D true;
> >         } else if (num_items =3D=3D 0 && flush =3D=3D BTRFS_RESERVE_FLU=
SH_ALL &&
> >                    !btrfs_block_rsv_full(delayed_refs_rsv)) {
> > @@ -696,6 +750,7 @@ start_transaction(struct btrfs_root *root, unsigned=
 int num_items,
> >
> >         h->type =3D type;
> >         INIT_LIST_HEAD(&h->new_bgs);
> > +       btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_B=
LOCK_RSV_DELOPS);
> Maybe my understanding is bad, but shouldn't it be BTRFS_BLOCK_RSV_DELREF=
S?
> Because BTRFS_BLOCK_RSV_DELOPS is used in
>
>     btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
>                  BTRFS_BLOCK_RSV_DELOPS);
>
> And delayed_block_rsv is used for "delayed items", not for "delayed refs"=
.

Yes, correct, it should have been DELREFS instead.
There's no big harm in general however, since if we run out of space
in the delayed refs reserve we fallback to the global reserve.

I'll fix it, thanks.

>
> If so, the the code in btrfs_block_rsv_release():
>
>     /*
>      * If we are a delayed block reserve then push to the global rsv,
>      * otherwise dump into the global delayed reserve if it is not full.
>      */
>     if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELOPS)
>         target =3D global_rsv;
>
> should also be modified.
> Or is there some connection between "delayed items" reservation and
> "delayed refs" reservations?
>
> Thanks,
> Alex.
>
>
> >
> >         smp_mb();
> >         if (cur_trans->state >=3D TRANS_STATE_COMMIT_START &&
> > @@ -708,8 +763,17 @@ start_transaction(struct btrfs_root *root, unsigne=
d int num_items,
> >         if (num_bytes) {
> >                 trace_btrfs_space_reservation(fs_info, "transaction",
> >                                               h->transid, num_bytes, 1)=
;
> > -               h->block_rsv =3D &fs_info->trans_block_rsv;
> > +               h->block_rsv =3D trans_rsv;
> >                 h->bytes_reserved =3D num_bytes;
> > +               if (delayed_refs_bytes > 0) {
> > +                       trace_btrfs_space_reservation(fs_info,
> > +                                                     "local_delayed_re=
fs_rsv",
> > +                                                     h->transid,
> > +                                                     delayed_refs_byte=
s, 1);
> > +                       h->delayed_refs_bytes_reserved =3D delayed_refs=
_bytes;
> > +                       btrfs_block_rsv_add_bytes(&h->delayed_rsv, dela=
yed_refs_bytes, true);
> > +                       delayed_refs_bytes =3D 0;
> > +               }
> >                 h->reloc_reserved =3D reloc_reserved;
> >         }
> >
> > @@ -765,8 +829,10 @@ start_transaction(struct btrfs_root *root, unsigne=
d int num_items,
> >         kmem_cache_free(btrfs_trans_handle_cachep, h);
> >  alloc_fail:
> >         if (num_bytes)
> > -               btrfs_block_rsv_release(fs_info, &fs_info->trans_block_=
rsv,
> > -                                       num_bytes, NULL);
> > +               btrfs_block_rsv_release(fs_info, trans_rsv, num_bytes, =
NULL);
> > +       if (delayed_refs_bytes)
> > +               btrfs_space_info_free_bytes_may_use(fs_info, trans_rsv-=
>space_info,
> > +                                                   delayed_refs_bytes)=
;
> >  reserve_fail:
> >         btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
> >         return ERR_PTR(ret);
> > @@ -987,11 +1053,14 @@ static void btrfs_trans_release_metadata(struct =
btrfs_trans_handle *trans)
> >
> >         if (!trans->block_rsv) {
> >                 ASSERT(!trans->bytes_reserved);
> > +               ASSERT(!trans->delayed_refs_bytes_reserved);
> >                 return;
> >         }
> >
> > -       if (!trans->bytes_reserved)
> > +       if (!trans->bytes_reserved) {
> > +               ASSERT(!trans->delayed_refs_bytes_reserved);
> >                 return;
> > +       }
> >
> >         ASSERT(trans->block_rsv =3D=3D &fs_info->trans_block_rsv);
> >         trace_btrfs_space_reservation(fs_info, "transaction",
> > @@ -999,6 +1068,16 @@ static void btrfs_trans_release_metadata(struct b=
trfs_trans_handle *trans)
> >         btrfs_block_rsv_release(fs_info, trans->block_rsv,
> >                                 trans->bytes_reserved, NULL);
> >         trans->bytes_reserved =3D 0;
> > +
> > +       if (!trans->delayed_refs_bytes_reserved)
> > +               return;
> > +
> > +       trace_btrfs_space_reservation(fs_info, "local_delayed_refs_rsv"=
,
> > +                                     trans->transid,
> > +                                     trans->delayed_refs_bytes_reserve=
d, 0);
> > +       btrfs_block_rsv_release(fs_info, &trans->delayed_rsv,
> > +                               trans->delayed_refs_bytes_reserved, NUL=
L);
> > +       trans->delayed_refs_bytes_reserved =3D 0;
> >  }
> >
> >  static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
> > diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> > index 474ce34ed02e..4dc68d7ec955 100644
> > --- a/fs/btrfs/transaction.h
> > +++ b/fs/btrfs/transaction.h
> > @@ -117,6 +117,7 @@ enum {
> >  struct btrfs_trans_handle {
> >         u64 transid;
> >         u64 bytes_reserved;
> > +       u64 delayed_refs_bytes_reserved;
> >         u64 chunk_bytes_reserved;
> >         unsigned long delayed_ref_updates;
> >         unsigned long delayed_ref_csum_deletions;
> > @@ -139,6 +140,7 @@ struct btrfs_trans_handle {
> >         bool in_fsync;
> >         struct btrfs_fs_info *fs_info;
> >         struct list_head new_bgs;
> > +       struct btrfs_block_rsv delayed_rsv;
> >  };
> >
> >  /*
> > --
> > 2.40.1
> >

