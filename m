Return-Path: <linux-btrfs+bounces-15046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D1CAEB769
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F63A8455
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930352C08CD;
	Fri, 27 Jun 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK9P8tby"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31772AE6F
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026522; cv=none; b=TXH8woWsOAs6qoPgm2aL39pfXhpSmxr7bs/pb+CH0Zs03sd72Q0P1iTLkWNsrPDLMca0wGUFgMa0mISbuL/IYzhuBnB6bxPPEw1mcG27Yg3NCywdtgV9tyLKNSSFtGljWxFpS1PAF0Yd+MnOzVbLiq6j9ps6xig17cJdUQv5a88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026522; c=relaxed/simple;
	bh=dGqgzbvK0NeclFyxQYX1JS3AtdNoM1Kg3BKSAhEG/GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoQcxcz5uu8AH53+qpWu5A27sKAsOWvWYGJq+cAvSCOS/cP58KW+hsNf09k06zJeDUjPCSOswYfvnLaeoTzTPoz2Zgstz5QRMBq0rO951qZGEWfvkGzi6rf4ivZnUefLIbT3oMiDzg07e8udr42lsY/2xSlcuy7li+PqN4Obp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK9P8tby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67964C4CEF2
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751026522;
	bh=dGqgzbvK0NeclFyxQYX1JS3AtdNoM1Kg3BKSAhEG/GA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sK9P8tbyLAGFeCmw6VOs0qvvLpDJpjZLiiG118bruhisJ9wulL03/mLDAVQq6OsZt
	 8m4rPSL2C/Iy9468vy569hKnRRF00yksWjvI+T7Cw9253yI21m1ztyck9BKRF5Rn5j
	 BLu9iRe4jCCcq3a0aNqzQCFeo8TnS/hH+SQILhpcrvALj6rKeXw1SX8CQn7umHD27s
	 Dzx2ajohCU8cVO6F4ApvAtoqo8WnjnmfQK4iT+d/mLbrA+RcDodM5owBZ/mCeRicgy
	 j7ItKgN0DEK23gJo0MLcG2XG0+COJ56ZhmdE7lYZu06G0Sh0gGZQb6xrLfxVCspS0L
	 w4aZMUJswD4aA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adb4e36904bso425423166b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 05:15:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YxPAWYd4MBl44dQXpNShr39trRn7H+pvBCZI5Dp1JChVijcjZ+j
	ZTplvTCxqhA2wWklavAChkiu0K+kr0UUSVsajoHgEVfVbgb6CaI2LHPiRwiHWFhRzXLvu2vGTrQ
	z1+W+9+dccQI8abTph7qfFMMir202ru8=
X-Google-Smtp-Source: AGHT+IGlo957CxtmNc26KLl9kBmmCInHtJhsHfbQXp4w+FdgyD66vVEOc6B2lCyIZvYTOSVnCGurOoHjsfEust166Os=
X-Received: by 2002:a17:907:f1cc:b0:ad8:9a86:cf52 with SMTP id
 a640c23a62f3a-ae34fd336camr250936566b.11.1751026521009; Fri, 27 Jun 2025
 05:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627091914.100715-1-jth@kernel.org> <20250627091914.100715-10-jth@kernel.org>
In-Reply-To: <20250627091914.100715-10-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Jun 2025 13:14:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7KZs1j10t7q9HhLNZ9FowyMKoS2W9PCpris+ukz8x+DA@mail.gmail.com>
X-Gm-Features: Ac12FXw4VXfKJj2yODZD6ruYAd_aTux_IJcQqHK7FXca1Tb25vY4_8mteD7aIEA
Message-ID: <CAL3q7H7KZs1j10t7q9HhLNZ9FowyMKoS2W9PCpris+ukz8x+DA@mail.gmail.com>
Subject: Re: [PATCH RFC 9/9] btrfs: remove unused bgs on allocation failure
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, David Sterba <dsterba@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 10:36=E2=80=AFAM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> In case find_free_extent() return ENOSPC, check if there are block-groups
> in the filsystem which have been marked as 'unused' and if so, reclaim th=
e
> space occupied by these block-groups.
>
> Restart the search for free space to place the extent afterwards.
>
> In case the allocation is targeted for the data relocation root, skip thi=
s
> step, as it can cause deadlocks between block group deletion and relocati=
on.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.h | 11 +++++++++++
>  fs/btrfs/extent-tree.c |  5 +++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index a8bb8429c966..d5c91db88456 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -396,4 +396,15 @@ int btrfs_use_block_group_size_class(struct btrfs_bl=
ock_group *bg,
>                                      bool force_wrong_size_class);
>  bool btrfs_block_group_should_use_size_class(const struct btrfs_block_gr=
oup *bg);
>
> +static inline bool btrfs_has_unused_block_groups(struct btrfs_fs_info *f=
s_info)
> +{
> +       bool unused_bgs;
> +
> +       spin_lock(&fs_info->unused_bgs_lock);
> +       unused_bgs =3D !list_empty(&fs_info->unused_bgs);
> +       spin_unlock(&fs_info->unused_bgs_lock);
> +
> +       return unused_bgs;
> +}
> +
>  #endif /* BTRFS_BLOCK_GROUP_H */
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index da731f6d4dad..34d21713c6ab 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4683,6 +4683,11 @@ int btrfs_reserve_extent(struct btrfs_root *root, =
u64 ram_bytes,
>         if (!ret && !is_data) {
>                 btrfs_dec_block_group_reservations(fs_info, ins->objectid=
);
>         } else if (ret =3D=3D -ENOSPC) {
> +               if (!btrfs_is_data_reloc_root(root) &&
> +                   btrfs_has_unused_block_groups(fs_info)) {
> +                       btrfs_delete_unused_bgs(fs_info);
> +                       goto again;
> +               }

Unfortunately this won't solve the -ENOSPC.

A deleted block group can't be reused in the same transaction, we have
to commit the transaction used to delete it.
This is to respect COW semantics and crash proof consistency.
And we can't commit here the transaction since that would deadlock for
any path that holds a transaction handle open, such as when modifying
any tree for example.

So unless some other task happens to commit the transaction used by
btrfs_delete_unused_bgs() after we call btrfs_delete_unused_bgs() and
before we retry the extent reservation when jumping to 'again',
-ENOSPC will happen again.


>                 if (!final_tried && ins->offset) {
>                         num_bytes =3D min(num_bytes >> 1, ins->offset);
>                         num_bytes =3D round_down(num_bytes,
> --
> 2.49.0
>
>

