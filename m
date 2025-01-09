Return-Path: <linux-btrfs+bounces-10865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE9A07BDC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C0218843FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDB21D010;
	Thu,  9 Jan 2025 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgT6gs2S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FD20469B;
	Thu,  9 Jan 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436289; cv=none; b=M5SBdYLIewV0FYyN8s/tqrmfAU4yUCE0mnlV7owno/Ah/E+1QfbkGtljZlnYjHpWwrdy/4BMsvBiSFGZV5NqefVgMhjvVo0m4LapxTQvCeKOFejTPVtHCQjbSi8kN3Lq3QEOLZAO+VzO5qG1aU+9ChRQVooWj1FaQoY4uQ0NEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436289; c=relaxed/simple;
	bh=G3Bh3o+63Hmzs7uWXSC3jJMqqF+s2qWGt23sjfWSzh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suvRwPKFR1dh1TV36vItH7HNa/tf2hXa9Wsq8UMZ4b/vmX0e8QmR0hfiEHYGDso2YGjOPT7A8POJZzN06/FWCvaNQFxN1C6Emdr9kp3XvqtADLBzefLXX62qEsGyU5Y0NWOSTYKSQjEL/5uVTeCWcMO/aB7IV3xJ8X8UxApWWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgT6gs2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E6BC4CED6;
	Thu,  9 Jan 2025 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736436288;
	bh=G3Bh3o+63Hmzs7uWXSC3jJMqqF+s2qWGt23sjfWSzh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GgT6gs2S60MCIJvkVoJoSnxvd1v/5pGOwcck2I8Px39rI6aAEtJ2U7WXVYRuXdRDQ
	 YuB64yK33QGTxUvAVChkyXRQ3zNIYlSW1Bsgz+oOY7KVlxKHtcWScWGoh2rlDJHdxc
	 Pf/HWqLY5+S1G5KvardXheprkilvIeUY9FiBwwJywlrwhH9ZoWbSuLUCYZVCr6fxj4
	 hhrueJGpRJh7HhrFCOsseIrj+vqrVgPwcsbYGVWYBl+2ARzLnARnf6D+vvnxNnZK7g
	 EaPt2rEzGeieG2h1spGJNMpVUOyx+mK9Fxqk6y41KOfwfENPjkCpBJEHDCaHC0QCnd
	 Bu4DcWweZNHdA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso1337785a12.0;
        Thu, 09 Jan 2025 07:24:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUZgXXFNubLI6ZK+0MhCWACYROpMudOCFhhI/Zj/sTjLkn17ShlyZBXNpU+a/BVNaknBlVyFV/P0KQhK8l@vger.kernel.org, AJvYcCWx1591oFP4NCh42Vx4Hgm+p+ZedpBT2skN3fYXINj6co2g8jv17eeQkkefUs09BCMFCRVr7xZsTTnNqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk89QHW3RziHU1Yuyq9faglbRrsk89FLqQnScaBw9awSpfYMGv
	rolf9FgmsIdtcdQS+fnDxNILAF1uk6RvvkCzhkzYFMaCx2Te141vlC/POA2Ztqd1oZSlNtd/r5K
	z0sdjFshUwpTbICSsVg3HkbHvj38=
X-Google-Smtp-Source: AGHT+IGe5KxkJIPhh52EIyzo8DZCZovUBdusZAb52bLblWSMMBqnogLHc8cGx9AdlfMBcJBaNy2tVh4W9mFm8leruEg=
X-Received: by 2002:a05:6402:40c1:b0:5d1:1064:326a with SMTP id
 4fb4d7f45d1cf-5d972e1c39fmr16325428a12.15.1736436287149; Thu, 09 Jan 2025
 07:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org> <20250107-rst-delete-fixes-v2-6-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-6-0c7b14c0aac2@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Jan 2025 15:24:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6=EVN9PokKxsf6MiOo2DRt3N=t2ikm9H7U1FxB+4udCg@mail.gmail.com>
X-Gm-Features: AbW1kvZUSOBU_A29vDPV2_cj57PLiMxIS3by5hKEvJAU06qAgzrXVkUVGg5wcC0
Message-ID: <CAL3q7H6=EVN9PokKxsf6MiOo2DRt3N=t2ikm9H7U1FxB+4udCg@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] btrfs: fix deletion of a range spanning parts
 two RAID stripe extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:50=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> When a user requests the deletion of a range that spans multiple stripe
> extents and btrfs_search_slot() returns us the second RAID stripe extent,
> we need to pick the previous item and truncate it, if there's still a
> range to delete left, move on to the next item.
>
> The following diagram illustrates the operation:
>
>  |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
>         |--- keep  ---|--- drop ---|
>
> While at it, comment the trivial case of a whole item delete as well.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 79f8f692aaa8f6df2c9482fbd7777c2812528f65..893d963951315abfc734e1ca2=
32b3087b7889431 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -103,6 +103,31 @@ int btrfs_delete_raid_extent(struct btrfs_trans_hand=
le *trans, u64 start, u64 le
>                 found_end =3D found_start + key.offset;
>                 ret =3D 0;
>
> +               /*
> +                * The stripe extent starts before the range we want to d=
elete,
> +                * but the range spans more than one stripe extent:
> +                *
> +                * |--- RAID Stripe Extent ---||--- RAID Stripe Extent --=
-|
> +                *        |--- keep  ---|--- drop ---|
> +                *
> +                * This means we have to get the previous item, truncate =
its
> +                * length and then restart the search.
> +                */
> +               if (found_start > start) {
> +
> +                       ret =3D btrfs_previous_item(stripe_root, path, st=
art,
> +                                                 BTRFS_RAID_STRIPE_KEY);
> +                       if (ret < 0)
> +                               break;
> +                       ret =3D 0;
> +
> +                       leaf =3D path->nodes[0];
> +                       slot =3D path->slots[0];
> +                       btrfs_item_key_to_cpu(leaf, &key, slot);
> +                       found_start =3D key.objectid;
> +                       found_end =3D found_start + key.offset;

Hum, this isn't safe, ignoring the case where btrfs_previous_item()
returns 1, meaning there's no previous item.

In that case previous_item() returns pointing to the same leaf and
slot, and then below we delete the item instead of trimming it
(increasing its range start and decreasing its length).

Thanks.

> +               }
> +
>                 if (key.type !=3D BTRFS_RAID_STRIPE_KEY)
>                         break;
>
> @@ -156,6 +181,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
e *trans, u64 start, u64 le
>                         break;
>                 }
>
> +               /*
> +                * Finally we can delete the whole item, no more special =
cases.
> +                */
>                 ret =3D btrfs_del_item(trans, stripe_root, path);
>                 if (ret)
>                         break;
>
> --
> 2.43.0
>
>

