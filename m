Return-Path: <linux-btrfs+bounces-9019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893B59A62B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 12:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0811C212E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C61E630C;
	Mon, 21 Oct 2024 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSEV/V0R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65F1E3776
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506289; cv=none; b=TJ6rNB0w3CBySYrB3vJzj+MGi24cMUTl193yWizeJ8uDJU1gGjgV5tJMRFXhmeCKfRwlCBXD8swf1tLFduX1mVaBTD/s7OKYjyQsnnw8FUh9r2kTmBTHnYbd1s1AmE4O5Rxb24YWucVm3puyfGZ6n7N0lc+EJCMSC2V4PmEJ/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506289; c=relaxed/simple;
	bh=j7JwufYmXU9yvVU6RVHxW62zsSo1B6eC7rPz49qBe9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqZVtynFfhrv0tGjb5AMNtB2xCclboIUc87JlLp2tLhpoyalZEfTLyjut5+vWgLNohCJ+f+DLvgKV85zLT4aHr0Lxj4ZVC6qmPRaGV3Ia4xT3qAmV9Sba8h1y/aRe8UJUIKnMzRxnUATS1k2kyB1eB5No7T3Ug/zE4jRi3JDcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSEV/V0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD131C4CEC3
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729506288;
	bh=j7JwufYmXU9yvVU6RVHxW62zsSo1B6eC7rPz49qBe9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TSEV/V0RFW+CMTvq4nPrFIHxfd8f6hWT+FPQ+sFQlQMt+lfuLYHpzOz+D+jPMvoGS
	 3/e4lg8wIrKV8++24u3EROr4qYdcYVcp1ofFaxS0oHt57HDkrTBx2Ouu1lW82uvEL8
	 iDx/Jvg+Mi2j8V0N+ppBG25fKNU5eznZ6apwVvaU8dB3sUyj7kouMjYTPPbfimuw8R
	 /SNah0ecCVN77+P6r3UVAgGQk75Sespf2R+7mRVcRUvp9KQQEw2Q7JCtI9XpdumwlV
	 KHctIOJnAfdhjHDIDbYmZI33ITAZMXm6ITUTq+ZxOCi71QTxXhm5Ru2EnSw6Oa/ldJ
	 +v6SPqWDKaZjA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so511462166b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 03:24:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YzJ8gSBM0OtV6FA0oJQHYSjtcR1u6/d8bSgx4uZs2MOVPfHDU9j
	Z/w9Peqw7yT6i8q2ncb0Vb68goJah5uKhQ6w6pYZyPN9+vfgpVMXXeB2hDSpL8vfr6hvf6+OvzT
	dro6NZG/1Uq2oPufAXwdwN+CSK68=
X-Google-Smtp-Source: AGHT+IEsMlAs6aITs3N6fd9EgIK76kIF1cUtuPGf2NjOFEF5etf3jiC5WJZGopoBZj6DLPiZk8zyxJUK/qIBzH8nufo=
X-Received: by 2002:a17:907:d15:b0:a99:c0be:a8ac with SMTP id
 a640c23a62f3a-a9a69bad1b8mr1163762966b.37.1729506287078; Mon, 21 Oct 2024
 03:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <'01b1cb0e-4642-452d-894d-bc14607c94c5@gmx.com'> <f443abf2897eea14639ec11f077ae510a9448a2e.1729295368.git.boris@bur.io>
In-Reply-To: <f443abf2897eea14639ec11f077ae510a9448a2e.1729295368.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 21 Oct 2024 11:24:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7jnBKBRsYPR3_vj5qd9zrA8rjBM1sYk_hzgstf8zyE4g@mail.gmail.com>
Message-ID: <CAL3q7H7jnBKBRsYPR3_vj5qd9zrA8rjBM1sYk_hzgstf8zyE4g@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: make dropped merge extent_map immutable
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 12:52=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> In debugging some corrupt squashfs files, we observed symptoms of
> corrupt page cache pages but correct on-disk contents. Further
> investigation revealed that the exact symptom was a correct page
> followed by an incorrect, duplicate, page. This got us thinking about
> extent maps.
>
> commit ac05ca913e9f ("Btrfs: fix race between using extent maps and mergi=
ng them")
> enforces a reference count on the primary `em` extent_map being merged,
> as that one gets modified.
>
> However, since,
> commit 3d2ac9922465 ("btrfs: introduce new members for extent_map")
> both 'em' and 'merge' get modified, which started modifying 'merge'
> and thus introduced the same race.
>
> We were able to reproduce this by looping the affected squashfs workload
> in parallel on a bunch of separate btrfs-es while also dropping caches.
> We are still working on a simple enough reproducer to make into an fstest=
.
>
> The simplest fix is to stop modifying 'merge', which is not essential,
> as it is dropped immediately after the merge. This behavior is simply
> a consequence of the order of the two extent maps being important in
> computing the new values. Modify merge_ondisk_extents to take prev and
> next by const* and also take a third merged parameter that it puts the
> results in. Note that this introduces the rather odd behavior of passing
> 'em' to merge_ondisk_extents as a const * and as a regular ptr.
>
> Fixes: 3d2ac9922465 ("btrfs: introduce new members for extent_map")
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Boris Burkov <boris@bur.io>

Looking at the subject, I find it a bit confusing.
Saying something like "don't change adjacent extent maps when merging
extent map" seems more clear to me.
Or better, saying what problem we are fixing rather than how we are
fixing it - i.e. "fix read corruption due to race with extent map
merging".

Anyway the fix looks good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
> Changelog:
> v3:
> - use correct const pointer
> - update comment
> v2:
> - make 'merge' immutable instead of refcounting it
> ---
>  fs/btrfs/extent_map.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index d58d6fc40da1..f8e6f2e42381 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -244,15 +244,21 @@ static bool mergeable_maps(const struct extent_map =
*prev, const struct extent_ma
>  }
>
>  /*
> - * Handle the on-disk data extents merge for @prev and @next.
> + * Handle the on-disk data extents merge for @prev and @next
> + *
> + * @prev: left extent to merge
> + * @next: right extent to merge
> + * @merged: the extent we will not discard after the merge; updated with=
 new values
> + *
> + * After this, one of the two extents is the new merged extent and the o=
ther is
> + * removed from the tree and likely freed. Note that @merged is one of @=
prev/@next
> + * so there is const/non-const aliasing occurring here.
>   *
>   * Only touches disk_bytenr/disk_num_bytes/offset/ram_bytes.
>   * For now only uncompressed regular extent can be merged.
> - *
> - * @prev and @next will be both updated to point to the new merged range=
.
> - * Thus one of them should be removed by the caller.
>   */
> -static void merge_ondisk_extents(struct extent_map *prev, struct extent_=
map *next)
> +static void merge_ondisk_extents(const struct extent_map *prev, const st=
ruct extent_map *next,
> +                                struct extent_map *merged)
>  {
>         u64 new_disk_bytenr;
>         u64 new_disk_num_bytes;
> @@ -287,15 +293,10 @@ static void merge_ondisk_extents(struct extent_map =
*prev, struct extent_map *nex
>                              new_disk_bytenr;
>         new_offset =3D prev->disk_bytenr + prev->offset - new_disk_bytenr=
;
>
> -       prev->disk_bytenr =3D new_disk_bytenr;
> -       prev->disk_num_bytes =3D new_disk_num_bytes;
> -       prev->ram_bytes =3D new_disk_num_bytes;
> -       prev->offset =3D new_offset;
> -
> -       next->disk_bytenr =3D new_disk_bytenr;
> -       next->disk_num_bytes =3D new_disk_num_bytes;
> -       next->ram_bytes =3D new_disk_num_bytes;
> -       next->offset =3D new_offset;
> +       merged->disk_bytenr =3D new_disk_bytenr;
> +       merged->disk_num_bytes =3D new_disk_num_bytes;
> +       merged->ram_bytes =3D new_disk_num_bytes;
> +       merged->offset =3D new_offset;
>  }
>
>  static void dump_extent_map(struct btrfs_fs_info *fs_info, const char *p=
refix,
> @@ -363,7 +364,7 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                         em->generation =3D max(em->generation, merge->gen=
eration);
>
>                         if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> -                               merge_ondisk_extents(merge, em);
> +                               merge_ondisk_extents(merge, em, em);
>                         em->flags |=3D EXTENT_FLAG_MERGED;
>
>                         validate_extent_map(fs_info, em);
> @@ -378,7 +379,7 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>         if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge=
)) {
>                 em->len +=3D merge->len;
>                 if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> -                       merge_ondisk_extents(em, merge);
> +                       merge_ondisk_extents(em, merge, em);
>                 validate_extent_map(fs_info, em);
>                 em->generation =3D max(em->generation, merge->generation)=
;
>                 em->flags |=3D EXTENT_FLAG_MERGED;
> --
> 2.47.0
>
>

