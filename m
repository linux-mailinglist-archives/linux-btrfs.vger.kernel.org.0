Return-Path: <linux-btrfs+bounces-21325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPQvJko2gmmVQgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21325-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:54:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE35DD297
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCF3D304ED20
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38466268C42;
	Tue,  3 Feb 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="J4RxXIuq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997412877EA
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140585; cv=pass; b=svUhuAoPFHLI9BQUbzRE1bI7yjDl6mgwebo+0AEDWl4ReS0aPWCodCuKmvSf0Uy2ZoNe1ukg41DshSvD2aOwXx504vwWjQKEhmg9WNxZviS7Rv4/WWnk9tmbAibC1gUvjmDLhEta7zHiqNCgF2Hs0EdmDQUW1ANqCyUAAy+kwvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140585; c=relaxed/simple;
	bh=NKQi1LoE981fACB6+YEOiHyds1wEIaI5LYVqT3xGOj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roR8/O2xhAPIijYNz1lckjhWq+6iFuyMwl9IvuMb9s97NlOY/XRj7CdX1a3hl+JVOJDea43jbDt2CvbnDGRxbMP+Gp4a7tTuIb4W0SSsSUIIgG7pVx3B5lTF8ZfVo5qEu3PL6VAvlNmNV2/wHhoEn10wQTwwRLF6Tw/F77jpReg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=J4RxXIuq; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82418b0178cso224298b3a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 09:43:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770140580; cv=none;
        d=google.com; s=arc-20240605;
        b=kxoVK20g/swApKydjTHSTgW7JcPqyZuritTQhZ1jdPqYxB9DOLbl7yACioyYafJwCw
         F1uAKe9sP+56FVuIYVndOBOmQDHkcou/9zy/+yrSH25cW165OlGeRxIl/CxUE/6kbqQ6
         lKM+X8OrcZaDx3XixN32kjsiMt3st//jabwDKzTGsS7Vw3U4F5ALQmvFm/jNrZMXkbyb
         v7rw02e0T93ZC/czXWFieZaVvnnvKWWRS9bsMt0u62wJSvsKVKBBBijI+54LYBmFEAJn
         3BWNuIWaxVRZMhAYV66g1QJTIrdV6O3fumixvDBoFFR+Hf4FNPk5SF0iwpMlw2lOwjlL
         2MRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yli+sOpkW2sD6IJU8vYpCg1PKJ3PuRL6sbR8PDOC5Pc=;
        fh=RhFuKwp73/x8KksFPnzjZEYxDQ9t3rFtnoJ8q5GIsWE=;
        b=OQ1fwRwaWCCinAufsj48YFlyYrIU8SDTxy1V9n4uXr4aW9jKh58SoOv/vkPcJyYb1r
         ReJ0cCdP386YOHaW9xh/LUbGq+MZjJoTu2XoGmEMYlsYOnGodsOCIDBBGA8tMwtHiAyY
         o7NHen0Pw/vE0aBevpvXyx20api4FVTd2sSTZGdks/qGMMnCYQhP9qIBvgVWBsOSUX3q
         k+YiOTJPWmyNATTVNEsLkyqdfT75VEck70d8RfUOHFC39a2L0LrQtefiyqPQXNRxZ33R
         yTof0likAZsxetMNhv3dYD1tVDFcKiRnUHI3l3yzgeqEl5qwBiH1DyGZk8deLTM52wVo
         pLGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1770140580; x=1770745380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yli+sOpkW2sD6IJU8vYpCg1PKJ3PuRL6sbR8PDOC5Pc=;
        b=J4RxXIuquSJjz1frC2G43JMdqG18vmFWMrNwle7wjQuKmXVlcYFpA3lGx68B8a6hah
         udN7PiduwBPhsfCv2p/+MNwUNnkoqPWSZMacfielrV24p0PdoyCbNTFUMxPm5v3tbXDl
         VV0pnW00ZNsCusqIAu6DfU8wZrW4nSmUotDjviQapfIm52VuHjGQ0FqNN4236tQD3KOR
         7vHYCQNu6A6Y/oB8UPW7Bc8SVa0q181bJPxs9af8INIe8OY69ZMHX0ps0NPjccsf0Wc0
         EMICxQZR62WRL0EluPjNdtsbvKN/x+rfmRrpfMM/K4++tZMCmAVu41o5z7JLL/eFpHUx
         QoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140580; x=1770745380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yli+sOpkW2sD6IJU8vYpCg1PKJ3PuRL6sbR8PDOC5Pc=;
        b=ktldwhOF3f5WU33b/5R8MHZZZUBzkTt+Truz2RIGm9oR3mrdCIGFQRYtqkYbx5M2t0
         BNqeXQzH7ypcDssz5yQVyH19Xjnk7craKbajRAH/6zBQcatJH2YZyMPPskHpHPqJqwoS
         vByV0+S87TgeV1bi9LacJDBbcAnPCd/jnw6PsByTLevHH+LYG0d+elQjrCeqKcVqk/pq
         4ia+L//wQpkX5cPNGvZmiGlN1vbS2vd6G4QVDvh1k/UcemAKtIx7KNSoYGetJ/UKAIih
         OKBY9TvQcn6Uwkch9RWXyjFAavBVqvrweoXQv0byenA7TRtzJ1a76/bVECh+okgGybTh
         vhhw==
X-Gm-Message-State: AOJu0YxLlRDf/3KVxlV/4oGE8FaQ+04NlI/Mg3kxS9fnCJE+i4H2E020
	64nXVNzjYtEjmKRiwBifYx2qwmtaLw5k/RtewbLatrbsW9O2HKMggoClBGRPmHrCI2XCTiwfR5+
	gpAN69Sq7n6yFXAD9ktvPJbMBqBfoWXaxvh43FNWOnA==
X-Gm-Gg: AZuq6aJ7wP4Cux7VnttKH4t9MjFPlVM9X1O2zeBjHAABgU3PE85F/A4wznXPQvxVaoW
	3YuTGvSkPDrlv4kZALQKXt69XDRZeA1TVuvwlk6+VI7hN2kCJSAUHVbT6V/5obknzLEmMIjM7jr
	D+MxHQaet0TJgkuNngJzfJLYpS6xe16VuUSGcI/RDyFhixB8H+bWgB8azuWe5vps1jDf2CtOO6q
	0Pkf2tOU5vzzWy1tTchRffIoquSv/XDpz7hGhen2zxqDvay6jxo8ZBu4rnjE3eR8S+ZrVwGL4/J
	AHs2
X-Received: by 2002:a05:6a00:7595:b0:7b8:8bfa:5e1e with SMTP id
 d2e1a72fcca58-8241c1f521amr192013b3a.4.1770140580236; Tue, 03 Feb 2026
 09:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1694192469.git.fdmanana@suse.com> <2e3540a727d0d75682f4f70e5de76c503e33049f.1694192469.git.fdmanana@suse.com>
In-Reply-To: <2e3540a727d0d75682f4f70e5de76c503e33049f.1694192469.git.fdmanana@suse.com>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Tue, 3 Feb 2026 19:42:49 +0200
X-Gm-Features: AZwV_QhHrOw39Xzs0Lmm-Kuyi9nbOhIytkz01-FtKZ1UBrfKXg40gmttx_OQWKI
Message-ID: <CAOcd+r0FHG5LWzTSu=LknwSoqxfw+C00gFAW7fuX71+Z5AfEew@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] btrfs: always reserve space for delayed refs
 when starting transaction
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zadara.com,none];
	R_DKIM_ALLOW(-0.20)[zadara.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21325-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zadara.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.lyakas@zadara.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email,toxicpanda.com:email,zadara.com:dkim]
X-Rspamd-Queue-Id: AFE35DD297
X-Rspamd-Action: no action

Hi Filipe,


On Fri, Sep 8, 2023 at 8:21=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> When starting a transaction (or joining an existing one with
> btrfs_start_transaction()), we reserve space for the number of items we
> want to insert in a btree, but we don't do it for the delayed refs we
> will generate while using the transaction to modify (COW) extent buffers
> in a btree or allocate new extent buffers. Basically how it works:
>
> 1) When we start a transaction we reserve space for the number of items
>    the caller wants to be inserted/modified/deleted in a btree. This spac=
e
>    goes to the transaction block reserve;
>
> 2) If the delayed refs block reserve is not full, its size is greater
>    than the amount of its reserved space, and the flush method is
>    BTRFS_RESERVE_FLUSH_ALL, then we attempt to reserve more space for
>    it corresponding to the number of items the caller wants to
>    insert/modify/delete in a btree;
>
> 3) The size of the delayed refs block reserve is increased when a task
>    creates delayed refs after COWing an extent buffer, allocating a new
>    one or deleting (freeing) an extent buffer. This happens after the
>    the task started or joined a transaction, whenever it calls
>    btrfs_update_delayed_refs_rsv();
>
> 4) The delayed refs block reserve is then refilled by anyone calling
>    btrfs_delayed_refs_rsv_refill(), either during unlink/truncate
>    operations or when someone else calls btrfs_start_transaction() with
>    a 0 number of items and flush method BTRFS_RESERVE_FLUSH_ALL;
>
> 5) As a task COWs or allocates extent buffers, it consumes space from the
>    transaction block reserve. When the task releases its transaction
>    handle (btrfs_end_transaction()) or it attempts to commit the
>    transaction, it releases any remaining space in the transaction block
>    reserve that it did not use, as not all space may have been used (due
>    to pessimistic space calculation) by calling btrfs_block_rsv_release()
>    which will try to add that unused space to the delayed refs block
>    reserve (if its current size is greater than its reserved space).
>    That transferred space may not be enough to completely fulfill the
>    delayed refs block reserve.
>
>    Plus we have some tasks that will attempt do modify as many leaves
>    as they can before getting -ENOSPC (and then reserving more space and
>    retrying), such as hole punching and extent cloning which call
>    btrfs_replace_file_extents(). Such tasks can generate therefore a
>    high number of delayed refs, for both metadata and data (we can't
>    know in advance how many file extent items we will find in a range
>    and therefore how many delayed refs for dropping references on data
>    extents we will generate);
>
> 6) If a transaction starts its commit before the delayeds refs block
>    reserve is refilled, for example by the transaction kthread or by
>    someone who called btrfs_join_transaction() before starting the
>    commit, then when running delayed references if we don't have enough
>    reserved space in the delayed refs block reserve, we will consume
>    space from the global block reserve.
>
> Now this doesn't make a lot of sense because:
>
> 1) We should reserve space for delayed references when starting the
>    transaction, since we have no guarantees the delayed refs block
>    reserve will be refilled;
>
> 2) If no refill happens then we will consume from the global block reserv=
e
>    when running delayed refs during the transaction commit;
>
> 3) If we have a bunch of tasks calling btrfs_start_transaction() with a
>    number of items greater than zero and at the time the delayed refs
>    reserve is full, then we don't reserve any space at
>    btrfs_start_transaction() for the delayed refs that will be generated
>    by a task, and we can therefore end up using a lot of space from the
>    global reserve when running the delayed refs during a transaction
>    commit;
>
> 4) There are also other operations that result in bumping the size of the
>    delayed refs reserve, such as creating and deleting block groups, as
>    well as the need to update a block group item because we allocated or
>    freed an extent from the respective block group;
>
> 5) If we have a significant gap betweent the delayed refs reserve's size
>    and its reserved space, two very bad things may happen:
>
>    1) The reserved space of the global reserve may not be enough and we
>       fail the transaction commit with -ENOSPC when running delayed refs;
>
>    2) If the available space in the global reserve is enough it may resul=
t
>       in nearly exhausting it. If the fs has no more unallocated device
>       space for allocating a new block group and all the available space
>       in existing metadata block groups is not far from the global
>       reserve's size before we started the transaction commit, we may end
>       up in a situation where after the transaction commit we have too
>       little available metadata space, and any future transaction commit
>       will fail with -ENOSPC, because although we were able to reserve
>       space to start the transaction, we were not able to commit it, as
>       running delayed refs generates some more delayed refs (to update th=
e
>       extent tree for example) - this includes not even being able to
>       commit a transaction that was started with the goal of unlinking a
>       file, removing an empty data block group or doing reclaim/balance,
>       so there's no way to release metadata space.
>
>       In the worst case the next time we mount the filesystem we may
>       also fail with -ENOSPC due to failure to commit a transaction to
>       cleanup orphan inodes. This later case was reported and hit by
>       someone running a SLE (SUSE Linux Enterprise) distribution for
>       example - where the fs had no more unallocated space that could be
>       used to allocate a new metadata block group, and the available
>       metadata space was about 1.5M, not enough to commit a transaction
>       to cleanup an orphan inode (or do relocation of data block groups
>       that were far from being full).
>
> So improve on this situation by always reserving space for delayed refs
> when calling start_transaction(), and if the flush method is
> BTRFS_RESERVE_FLUSH_ALL, also try to refill the delayeds refs block
> reserve if it's not full. The space reserved for the delayed refs is adde=
d
> to a local block reserve that is part of the transaction handle, and when
> a task updates the delayed refs block reserve size, after creating a
> delayed ref, the space is transferred from that local reserve to the
> global delayed refs reserve (fs_info->delayed_refs_rsv). In case the
> local reserve does not have enough space, which may happen for tasks
> that generate a variable and potentially large number of delayed refs
> (such as the hole punching and extent cloning cases mentioned before),
> we transfer any available space and then rely on the current behaviour
> of hoping some other task refills the delayed refs reserve or fallback
> to the global block reserve.
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/block-rsv.c   |   6 +-
>  fs/btrfs/delayed-ref.c |  21 ++++++-
>  fs/btrfs/transaction.c | 135 ++++++++++++++++++++++++++++++++---------
>  fs/btrfs/transaction.h |   2 +
>  4 files changed, 132 insertions(+), 32 deletions(-)
>
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 6ccd91bbff3e..6a8f9629bbbd 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -281,10 +281,10 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *f=
s_info,
>         struct btrfs_block_rsv *target =3D NULL;
>
>         /*
> -        * If we are the delayed_rsv then push to the global rsv, otherwi=
se dump
> -        * into the delayed rsv if it is not full.
> +        * If we are a delayed block reserve then push to the global rsv,
> +        * otherwise dump into the global delayed reserve if it is not fu=
ll.
>          */
> -       if (block_rsv =3D=3D delayed_rsv)
> +       if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELOPS)
>                 target =3D global_rsv;
>         else if (block_rsv !=3D global_rsv && !btrfs_block_rsv_full(delay=
ed_rsv))
>                 target =3D delayed_rsv;
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index a6680e8756a1..383d5be22941 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -89,7 +89,9 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_h=
andle *trans)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_block_rsv *delayed_rsv =3D &fs_info->delayed_refs_rs=
v;
> +       struct btrfs_block_rsv *local_rsv =3D &trans->delayed_rsv;
>         u64 num_bytes;
> +       u64 reserved_bytes;
>
>         num_bytes =3D btrfs_calc_delayed_ref_bytes(fs_info, trans->delaye=
d_ref_updates);
>         num_bytes +=3D btrfs_calc_delayed_ref_csum_bytes(fs_info,
> @@ -98,9 +100,26 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans=
_handle *trans)
>         if (num_bytes =3D=3D 0)
>                 return;
>
> +       /*
> +        * Try to take num_bytes from the transaction's local delayed res=
erve.
> +        * If not possible, try to take as much as it's available. If the=
 local
> +        * reserve doesn't have enough reserved space, the delayed refs r=
eserve
> +        * will be refilled next time btrfs_delayed_refs_rsv_refill() is =
called
> +        * by someone or if a transaction commit is triggered before that=
, the
> +        * global block reserve will be used. We want to minimize using t=
he
> +        * global block reserve for cases we can account for in advance, =
to
> +        * avoid exhausting it and reach -ENOSPC during a transaction com=
mit.
> +        */
> +       spin_lock(&local_rsv->lock);
> +       reserved_bytes =3D min(num_bytes, local_rsv->reserved);
> +       local_rsv->reserved -=3D reserved_bytes;
> +       local_rsv->full =3D (local_rsv->reserved >=3D local_rsv->size);
> +       spin_unlock(&local_rsv->lock);
> +
>         spin_lock(&delayed_rsv->lock);
>         delayed_rsv->size +=3D num_bytes;
> -       delayed_rsv->full =3D false;
> +       delayed_rsv->reserved +=3D reserved_bytes;
> +       delayed_rsv->full =3D (delayed_rsv->reserved >=3D delayed_rsv->si=
ze);
>         spin_unlock(&delayed_rsv->lock);
>         trans->delayed_ref_updates =3D 0;
>         trans->delayed_ref_csum_deletions =3D 0;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 4453d8113b37..ac347de1ffb8 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -555,6 +555,69 @@ static inline bool need_reserve_reloc_root(struct bt=
rfs_root *root)
>         return true;
>  }
>
> +static int btrfs_reserve_trans_metadata(struct btrfs_fs_info *fs_info,
> +                                       enum btrfs_reserve_flush_enum flu=
sh,
> +                                       u64 num_bytes,
> +                                       u64 *delayed_refs_bytes)
> +{
> +       struct btrfs_block_rsv *delayed_refs_rsv =3D &fs_info->delayed_re=
fs_rsv;
> +       struct btrfs_space_info *si =3D fs_info->trans_block_rsv.space_in=
fo;
> +       u64 extra_delayed_refs_bytes =3D 0;
> +       u64 bytes;
> +       int ret;
> +
> +       /*
> +        * If there's a gap between the size of the delayed refs reserve =
and
> +        * its reserved space, than some tasks have added delayed refs or=
 bumped
> +        * its size otherwise (due to block group creation or removal, or=
 block
> +        * group item update). Also try to allocate that gap in order to =
prevent
> +        * using (and possibly abusing) the global reserve when committin=
g the
> +        * transaction.
> +        */
> +       if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL &&
> +           !btrfs_block_rsv_full(delayed_refs_rsv)) {
> +               spin_lock(&delayed_refs_rsv->lock);
> +               if (delayed_refs_rsv->size > delayed_refs_rsv->reserved)
> +                       extra_delayed_refs_bytes =3D delayed_refs_rsv->si=
ze -
> +                               delayed_refs_rsv->reserved;
> +               spin_unlock(&delayed_refs_rsv->lock);
> +       }
> +
> +       bytes =3D num_bytes + *delayed_refs_bytes + extra_delayed_refs_by=
tes;
> +
> +       /*
> +        * We want to reserve all the bytes we may need all at once, so w=
e only
> +        * do 1 enospc flushing cycle per transaction start.
> +        */
> +       ret =3D btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush);
> +       if (ret =3D=3D 0) {
> +               if (extra_delayed_refs_bytes > 0)
> +                       btrfs_migrate_to_delayed_refs_rsv(fs_info,
> +                                                         extra_delayed_r=
efs_bytes);
> +               return 0;
> +       }
> +
> +       if (extra_delayed_refs_bytes > 0) {
> +               bytes -=3D extra_delayed_refs_bytes;
> +               ret =3D btrfs_reserve_metadata_bytes(fs_info, si, bytes, =
flush);
> +               if (ret =3D=3D 0)
> +                       return 0;
> +       }
> +
> +       /*
> +        * If we are an emergency flush, which can steal from the global =
block
> +        * reserve, then attempt to not reserve space for the delayed ref=
s, as
> +        * we will consume space for them from the global block reserve.
> +        */
> +       if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL_STEAL) {
> +               bytes -=3D *delayed_refs_bytes;
> +               *delayed_refs_bytes =3D 0;
> +               ret =3D btrfs_reserve_metadata_bytes(fs_info, si, bytes, =
flush);
> +       }
> +
> +       return ret;
> +}
> +
>  static struct btrfs_trans_handle *
>  start_transaction(struct btrfs_root *root, unsigned int num_items,
>                   unsigned int type, enum btrfs_reserve_flush_enum flush,
> @@ -562,10 +625,12 @@ start_transaction(struct btrfs_root *root, unsigned=
 int num_items,
>  {
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct btrfs_block_rsv *delayed_refs_rsv =3D &fs_info->delayed_re=
fs_rsv;
> +       struct btrfs_block_rsv *trans_rsv =3D &fs_info->trans_block_rsv;
>         struct btrfs_trans_handle *h;
>         struct btrfs_transaction *cur_trans;
>         u64 num_bytes =3D 0;
>         u64 qgroup_reserved =3D 0;
> +       u64 delayed_refs_bytes =3D 0;
>         bool reloc_reserved =3D false;
>         bool do_chunk_alloc =3D false;
>         int ret;
> @@ -588,9 +653,6 @@ start_transaction(struct btrfs_root *root, unsigned i=
nt num_items,
>          * the appropriate flushing if need be.
>          */
>         if (num_items && root !=3D fs_info->chunk_root) {
> -               struct btrfs_block_rsv *rsv =3D &fs_info->trans_block_rsv=
;
> -               u64 delayed_refs_bytes =3D 0;
> -
>                 qgroup_reserved =3D num_items * fs_info->nodesize;
>                 /*
>                  * Use prealloc for now, as there might be a currently ru=
nning
> @@ -602,20 +664,16 @@ start_transaction(struct btrfs_root *root, unsigned=
 int num_items,
>                 if (ret)
>                         return ERR_PTR(ret);
>
> +               num_bytes =3D btrfs_calc_insert_metadata_size(fs_info, nu=
m_items);
>                 /*
> -                * We want to reserve all the bytes we may need all at on=
ce, so
> -                * we only do 1 enospc flushing cycle per transaction sta=
rt.  We
> -                * accomplish this by simply assuming we'll do num_items =
worth
> -                * of delayed refs updates in this trans handle, and refi=
ll that
> -                * amount for whatever is missing in the reserve.
> +                * If we plan to insert/update/delete "num_items" from a =
btree,
> +                * we will also generate delayed refs for extent buffers =
in the
> +                * respective btree paths, so reserve space for the delay=
ed refs
> +                * that will be generated by the caller as it modifies bt=
rees.
> +                * Try to reserve them to avoid excessive use of the glob=
al
> +                * block reserve.
>                  */
> -               num_bytes =3D btrfs_calc_insert_metadata_size(fs_info, nu=
m_items);
> -               if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL &&
> -                   !btrfs_block_rsv_full(delayed_refs_rsv)) {
> -                       delayed_refs_bytes =3D btrfs_calc_delayed_ref_byt=
es(fs_info,
> -                                                                        =
 num_items);
> -                       num_bytes +=3D delayed_refs_bytes;
> -               }
> +               delayed_refs_bytes =3D btrfs_calc_delayed_ref_bytes(fs_in=
fo, num_items);
>
>                 /*
>                  * Do the reservation for the relocation root creation
> @@ -625,18 +683,14 @@ start_transaction(struct btrfs_root *root, unsigned=
 int num_items,
>                         reloc_reserved =3D true;
>                 }
>
> -               ret =3D btrfs_reserve_metadata_bytes(fs_info, rsv->space_=
info,
> -                                                  num_bytes, flush);
> +               ret =3D btrfs_reserve_trans_metadata(fs_info, flush, num_=
bytes,
> +                                                  &delayed_refs_bytes);
>                 if (ret)
>                         goto reserve_fail;
> -               if (delayed_refs_bytes) {
> -                       btrfs_migrate_to_delayed_refs_rsv(fs_info,
> -                                                         delayed_refs_by=
tes);
> -                       num_bytes -=3D delayed_refs_bytes;
> -               }
> -               btrfs_block_rsv_add_bytes(rsv, num_bytes, true);
>
> -               if (rsv->space_info->force_alloc)
> +               btrfs_block_rsv_add_bytes(trans_rsv, num_bytes, true);
> +
> +               if (trans_rsv->space_info->force_alloc)
>                         do_chunk_alloc =3D true;
>         } else if (num_items =3D=3D 0 && flush =3D=3D BTRFS_RESERVE_FLUSH=
_ALL &&
>                    !btrfs_block_rsv_full(delayed_refs_rsv)) {
> @@ -696,6 +750,7 @@ start_transaction(struct btrfs_root *root, unsigned i=
nt num_items,
>
>         h->type =3D type;
>         INIT_LIST_HEAD(&h->new_bgs);
> +       btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLO=
CK_RSV_DELOPS);
Maybe my understanding is bad, but shouldn't it be BTRFS_BLOCK_RSV_DELREFS?
Because BTRFS_BLOCK_RSV_DELOPS is used in

    btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
                 BTRFS_BLOCK_RSV_DELOPS);

And delayed_block_rsv is used for "delayed items", not for "delayed refs".

If so, the the code in btrfs_block_rsv_release():

    /*
     * If we are a delayed block reserve then push to the global rsv,
     * otherwise dump into the global delayed reserve if it is not full.
     */
    if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELOPS)
        target =3D global_rsv;

should also be modified.
Or is there some connection between "delayed items" reservation and
"delayed refs" reservations?

Thanks,
Alex.


>
>         smp_mb();
>         if (cur_trans->state >=3D TRANS_STATE_COMMIT_START &&
> @@ -708,8 +763,17 @@ start_transaction(struct btrfs_root *root, unsigned =
int num_items,
>         if (num_bytes) {
>                 trace_btrfs_space_reservation(fs_info, "transaction",
>                                               h->transid, num_bytes, 1);
> -               h->block_rsv =3D &fs_info->trans_block_rsv;
> +               h->block_rsv =3D trans_rsv;
>                 h->bytes_reserved =3D num_bytes;
> +               if (delayed_refs_bytes > 0) {
> +                       trace_btrfs_space_reservation(fs_info,
> +                                                     "local_delayed_refs=
_rsv",
> +                                                     h->transid,
> +                                                     delayed_refs_bytes,=
 1);
> +                       h->delayed_refs_bytes_reserved =3D delayed_refs_b=
ytes;
> +                       btrfs_block_rsv_add_bytes(&h->delayed_rsv, delaye=
d_refs_bytes, true);
> +                       delayed_refs_bytes =3D 0;
> +               }
>                 h->reloc_reserved =3D reloc_reserved;
>         }
>
> @@ -765,8 +829,10 @@ start_transaction(struct btrfs_root *root, unsigned =
int num_items,
>         kmem_cache_free(btrfs_trans_handle_cachep, h);
>  alloc_fail:
>         if (num_bytes)
> -               btrfs_block_rsv_release(fs_info, &fs_info->trans_block_rs=
v,
> -                                       num_bytes, NULL);
> +               btrfs_block_rsv_release(fs_info, trans_rsv, num_bytes, NU=
LL);
> +       if (delayed_refs_bytes)
> +               btrfs_space_info_free_bytes_may_use(fs_info, trans_rsv->s=
pace_info,
> +                                                   delayed_refs_bytes);
>  reserve_fail:
>         btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
>         return ERR_PTR(ret);
> @@ -987,11 +1053,14 @@ static void btrfs_trans_release_metadata(struct bt=
rfs_trans_handle *trans)
>
>         if (!trans->block_rsv) {
>                 ASSERT(!trans->bytes_reserved);
> +               ASSERT(!trans->delayed_refs_bytes_reserved);
>                 return;
>         }
>
> -       if (!trans->bytes_reserved)
> +       if (!trans->bytes_reserved) {
> +               ASSERT(!trans->delayed_refs_bytes_reserved);
>                 return;
> +       }
>
>         ASSERT(trans->block_rsv =3D=3D &fs_info->trans_block_rsv);
>         trace_btrfs_space_reservation(fs_info, "transaction",
> @@ -999,6 +1068,16 @@ static void btrfs_trans_release_metadata(struct btr=
fs_trans_handle *trans)
>         btrfs_block_rsv_release(fs_info, trans->block_rsv,
>                                 trans->bytes_reserved, NULL);
>         trans->bytes_reserved =3D 0;
> +
> +       if (!trans->delayed_refs_bytes_reserved)
> +               return;
> +
> +       trace_btrfs_space_reservation(fs_info, "local_delayed_refs_rsv",
> +                                     trans->transid,
> +                                     trans->delayed_refs_bytes_reserved,=
 0);
> +       btrfs_block_rsv_release(fs_info, &trans->delayed_rsv,
> +                               trans->delayed_refs_bytes_reserved, NULL)=
;
> +       trans->delayed_refs_bytes_reserved =3D 0;
>  }
>
>  static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 474ce34ed02e..4dc68d7ec955 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -117,6 +117,7 @@ enum {
>  struct btrfs_trans_handle {
>         u64 transid;
>         u64 bytes_reserved;
> +       u64 delayed_refs_bytes_reserved;
>         u64 chunk_bytes_reserved;
>         unsigned long delayed_ref_updates;
>         unsigned long delayed_ref_csum_deletions;
> @@ -139,6 +140,7 @@ struct btrfs_trans_handle {
>         bool in_fsync;
>         struct btrfs_fs_info *fs_info;
>         struct list_head new_bgs;
> +       struct btrfs_block_rsv delayed_rsv;
>  };
>
>  /*
> --
> 2.40.1
>

