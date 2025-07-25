Return-Path: <linux-btrfs+bounces-15669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05941B11CC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 12:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157A356856F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120BB2E49AB;
	Fri, 25 Jul 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA44u8tL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E32DAFB0
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440396; cv=none; b=hfJZEC/UnVaN22YNt72q22nT8E8x4UUQRCsD/0doFGmbt3poHNiJEYm2IFPF4eEKnagsQS36g3v2qXRwOgOfqsXLUU33xTU2Obmgw7yTG9HU1lKZrQnk7UvfLE8y93yeG/f7ThiWkXQlUbIszesXM3I9fFei4hkl/NDV1YxsA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440396; c=relaxed/simple;
	bh=BgTrtv1uiN7i1sP62hP1oH9p44MRUlmV+IPqJf7GB6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YT5HoLaeFJ7qhAvRBADT9uOU3O3T0eOnP1q4q6G3ORS3luxxV/HCxO7kxWVRiqx3q3n5GNUO0GnjRv63FNwRF/2A1zvaA3LDRnc1zxQ9eG7qXzFoon2ofIAgWM6Wp9Ns6na4TOqvQ2uAbSXNtcB28EeH3Exuy+PjqfbUlKcAyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA44u8tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F225BC4CEEF
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753440396;
	bh=BgTrtv1uiN7i1sP62hP1oH9p44MRUlmV+IPqJf7GB6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OA44u8tLAurtBVzw617YXtdNTXumJfQxSBCr6s5b2UcxMDF0m4RvCK2aW94uCAGj5
	 tBpY4rLC8EPL1CuI0yT0jw3G3Sku/iGpJXo2bA5TCK0WbfgCg6UACDyk/PjAx1Rjum
	 3vUFBCsVb8tkMsyFi0jfIcyvEp7AjCkLpbGN/r26f+dryn8Cinyf38ctYxWaZ2rI8T
	 YeIPjECC6CA2RGnM3Fd6PufZpU+o7FQsAG8XrWscG5ge2M+KJRvPr+BDyGaSqWKIvm
	 O1Rn9Odtj5ecoeCfLPk9Adr6ZW8HFeis3mJLOmrih00dRI0PHu7wdyNSjO3tXWd6Pe
	 GtSLKnwsTdbXw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so356505866b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:46:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YwtLGlgI8Bs57/jPIm971dlCC8fD+tdl8FdbB4j8dvS3yV9yCO1
	D9/RGjha2qUhxeC1tq6hPWQBlqeReXu/U5LoM2KTMw1VQxNm8Z+cvCaN/ApPrGGjJ1lRtjZSDev
	lE5LtcitQqSmpFXr/kqjrCOA6qMrqRH4=
X-Google-Smtp-Source: AGHT+IEE4BiA6OwpUQkgON1qu357EY7VUeNthyC7huV9Feai6MBPFcXoj8AOFfISGLuQCxn4OWDNKCQo40LBdaxFQDU=
X-Received: by 2002:a17:907:7f2a:b0:ae3:6708:941c with SMTP id
 a640c23a62f3a-af617202040mr159668066b.6.1753440394480; Fri, 25 Jul 2025
 03:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a7bb9f34f314ca33eff7ed726ab074aaf681521.1753432924.git.wqu@suse.com>
In-Reply-To: <8a7bb9f34f314ca33eff7ed726ab074aaf681521.1753432924.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 25 Jul 2025 11:45:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5_GUZ5tbnYUSD=_wh+PdgeVjdUNLG=VWabFvNYY2B4xA@mail.gmail.com>
X-Gm-Features: Ac12FXwZW4ftIqkCJ6tITXHcxOOLLWSgvQOSvSA_p4CJrVwCQK3r6R118X58_vQ
Message-ID: <CAL3q7H5_GUZ5tbnYUSD=_wh+PdgeVjdUNLG=VWabFvNYY2B4xA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not call btrfs_copy_root() on half-dropped subvolume
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 9:43=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is an internal report that balance triggered transaction abort,
> with the following call trace:
>
>   item 85 key (594509824 169 0) itemoff 12599 itemsize 33
>           extent refs 1 gen 197740 flags 2
>           ref#0: tree block backref root 7
>   item 86 key (594558976 169 0) itemoff 12566 itemsize 33
>           extent refs 1 gen 197522 flags 2
>           ref#0: tree block backref root 7
>  ...
>  BTRFS error (device loop0): extent item not found for insert, bytenr 594=
526208 num_bytes 16384 parent 449921024 root_objectid 934 owner 1 offset 0
>  BTRFS error (device loop0): failed to run delayed ref for logical 594526=
208 num_bytes 16384 type 182 action 1 ref_mod 1: -117
>  ------------[ cut here ]------------
>  BTRFS: Transaction aborted (error -117)
>  WARNING: CPU: 1 PID: 6963 at ../fs/btrfs/extent-tree.c:2168 btrfs_run_de=
layed_refs+0xfa/0x110 [btrfs]
>
> And btrfs check doesn't report anything wrong related to the extent
> tree.
>
> [CAUSE]
> The cause is a little complex, firstly the extent tree indeed doesn't
> have the backref for 594526208.
>
> The extent tree only have the following two backrefs around that bytenr
> on-disk:
>
>         item 65 key (594509824 METADATA_ITEM 0) itemoff 13880 itemsize 33
>                 refs 1 gen 197740 flags TREE_BLOCK
>                 tree block skinny level 0
>                 (176 0x7) tree block backref root CSUM_TREE
>         item 66 key (594558976 METADATA_ITEM 0) itemoff 13847 itemsize 33
>                 refs 1 gen 197522 flags TREE_BLOCK
>                 tree block skinny level 0
>                 (176 0x7) tree block backref root CSUM_TREE
>
> But the such missing backref item is not an corruption on disk, as the
> offending delayed ref belongs to subvolume 934, and that subvolume is
> being dropped:
>
>         item 0 key (934 ROOT_ITEM 198229) itemoff 15844 itemsize 439
>                 generation 198229 root_dirid 256 bytenr 10741039104 byte_=
limit 0 bytes_used 345571328
>                 last_snapshot 198229 flags 0x1000000000001(RDONLY) refs 0
>                 drop_progress key (206324 EXTENT_DATA 2711650304) drop_le=
vel 2
>                 level 2 generation_v2 198229
>
> And that offending tree block 594526208 is inside the dropped range of
> that subvolume.
> That explains why there is no backref item for that bytenr and why btrfs
> check is not reporting anything wrong.
>
> But this also shows another problem, as btrfs will do all the orphan
> subvolume cleanup at a read-write mount.
>
> So half-dropped subvolume should not exist after an RW mount, and
> balance itself is also exclusive to subvolume cleanup, meaning we
> shouldn't hit a subvolume half-dropped during relocation.
>
> The root cause is, there is no orphan item for this subvolume.
> In fact there are 5 subvolumes around 2021 that have the same problem.
>
> It looks like the original report has some older kernels running, and
> caused those zombie subvolumes.
>
> Thankfully upstream commit 8d488a8c7ba2 ("btrfs: fix subvolume/snapshot
> deletion not triggered on mount") has long fixed the bug.
>
> [ENHANCEMENT]
> For repairing such old fs, btrfs-progs will be enhanced.
>
> Considering how delayed the problem will show up (at run delayed ref
> time) and at that time we have to abort transaction already, it is too
> late.
>
> Instead here we reject any half-dropped subvolume for reloc tree, so
> at least the fs can keep read-write operations until btrfs-progs is
> utilized to add back the missing orphan items.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/relocation.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 60dd3971c3ae..a43d635d861b 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -602,6 +602,23 @@ static struct btrfs_root *create_reloc_root(struct b=
trfs_trans_handle *trans,
>         if (btrfs_root_id(root) =3D=3D objectid) {
>                 u64 commit_root_gen;
>
> +               /*
> +                * Relocation will wait for cleaner thread, and any half-=
dropped
> +                * subvolume will be fully cleaned up at mount time.
> +                * So here we shouldn't hit a subvolume with non-zero dro=
p_progress.
> +                *
> +                * If this happened, it means the subvolume has experienc=
ed some bug
> +                * which didn't insert the correct orphan item for it.

Or it was inserted but deleted when it shouldn't. Or the cleaner
didn't finish dropping the subvolume before returning (releasing the
cleaner_mutex), etc.
Just don't mention one possible cause as if it were the only possible scena=
rio.

Just say something like:  "If this isn't the case, error out since it
can make us attempt to drop references for extents that were already
dropped before."

> +                * Error out early, as btrfs_copy_root() can increase ref=
s on already
> +                * dropped nodes/leaves and cause problems later at delay=
ed ref runtime.

Not just nodes/leaves (metadata), but can also happen for data extents.

> +                */
> +               if (unlikely(btrfs_disk_key_objectid(&root->root_item.dro=
p_progress))) {
> +                       btrfs_err(fs_info,
> +               "subvolume %llu is not properly cleaned up before relocat=
ion",

"can not relocate partially dropped subvolume %llu, drop progress key
(%llu %u %llu)" sounds less weird to me.

> +                                 objectid);
> +                       return ERR_PTR(-EUCLEAN);

This leaks the root_item, must do a "goto fail".

I also find the subject  "btrfs: do not call btrfs_copy_root() on
half-dropped subvolume" confusing.
Should be more along the lines of:  "btrfs: do not allow relocation of
partially dropped subvolumes".

Thanks.

> +               }
> +
>                 /* called by btrfs_init_reloc_root */
>                 ret =3D btrfs_copy_root(trans, root, root->commit_root, &=
eb,
>                                       BTRFS_TREE_RELOC_OBJECTID);
> --
> 2.50.0
>
>

