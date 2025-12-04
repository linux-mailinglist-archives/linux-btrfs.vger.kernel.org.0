Return-Path: <linux-btrfs+bounces-19526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99945CA3D56
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 14:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1DE305D653
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87F342146;
	Thu,  4 Dec 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAGioxPG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AF279DC0
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855056; cv=none; b=t/vvbRQXbGfcKrKyc8gYG/ICP1RdM2UjLKIL/kEiXTBT5bC3ApeDtXYSFwlr0MiggJhwTZtRvHYQH4qPVXZI1OCg/S1s4lviK4l6DRPYmXcyCWI8wbchZzTXFOJFkS2c9gN4F893s8cuQldOaympICNUEFMgaoqhguVVzBmNlX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855056; c=relaxed/simple;
	bh=pQ3N7e/1FUWhdvMfFSRSwpjWnYSgF4Q92V7sniTbbHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acrrUu4fh5p6RNaPtdtvUotaloQfwtSP2pHaLFSwMW05fwTqGropoa3X0zilWbRrLWjrsCjZ/olq5ilo8l8/jcr711uQNA22vbXQC2CJa+IHa6tUtInm7yPijzDdLJkQEIG3LjZSNGA/KcVMQYCzhEJqtW5nKCvGadzXvSzknPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAGioxPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C58C19421
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764855055;
	bh=pQ3N7e/1FUWhdvMfFSRSwpjWnYSgF4Q92V7sniTbbHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QAGioxPGRLezovsU3v4Out+/mGm1A2INkOKNkUFxpO158dXxyFKFNDJLzoyardQJO
	 8d+p0uwlC7iLjzGSlPNXlDKQGFqTSiJ7DnZ3HGkYdLetivw7DvQSMPGc5Xx8CVoxbn
	 MgfXydb5YjTeOgqND4T6kAB4OSGBrzCvbqxhO5z70NMPoenMe6A15IB0s3RobHVMX0
	 AzutxS3VS/IOygfiEY1wOLOFabFW2mry6zPON4y/WRkXlMaswmevddc5HRrptwk3Ua
	 ZQn/qY2z9QR/9ymbvbNpYB5UzFi6fMkGGCTj5M5HKwPn/z1y6mKdrPMO/BBqjTYBn6
	 3sJzjvoIF0nEw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so204118566b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Dec 2025 05:30:55 -0800 (PST)
X-Gm-Message-State: AOJu0YydN1ebHfks2WF7NWQtCAfv3Q1vjMnu3vurXCqWwlSfFfI2jnWj
	cowpNNMnivZs8IfQzTrGEiyIj7oarSRJkE/qo8z74daxKsHFqpZHxsRGLUMV96fYJyf4DQFsmHY
	xODegA546zMuYie1awKtMIcsa0hG6v2U=
X-Google-Smtp-Source: AGHT+IGscJpvXEG9kBWwxtRldUBKpHh2NPAOtKQwrTD8TIYdHMDtABLQiOAWzNeK2g5x2ozNcHDVIN3Xd31cgMDTMuI=
X-Received: by 2002:a17:907:7b85:b0:b73:8792:c3ca with SMTP id
 a640c23a62f3a-b79dc51af8cmr647019766b.32.1764855054476; Thu, 04 Dec 2025
 05:30:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com> <20251204124227.431678-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20251204124227.431678-3-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Dec 2025 13:30:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7rB-WghdPAOjJmoKhV+e6ftj=3DK+aDdGnjBRjUHcPZg@mail.gmail.com>
X-Gm-Features: AWmQ_blH1bpcnvKoBRb3etrRn_U31caop8RphnqyLINHkzimLeiJ0UmmKmo14-w
Message-ID: <CAL3q7H7rB-WghdPAOjJmoKhV+e6ftj=3DK+aDdGnjBRjUHcPZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root
 into flags
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 12:44=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Remove struct btrfs_bio's csum_search_commit_root field and move it as a
> flag into the newly introduced flags member of struct btrfs_bio.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/bio.c         | 5 ++++-
>  fs/btrfs/bio.h         | 6 ++++--
>  fs/btrfs/compression.c | 4 +++-
>  fs/btrfs/extent_io.c   | 7 ++++---
>  fs/btrfs/file-item.c   | 4 ++--
>  5 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 33149f07e62d..2a9ab1275b7d 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -97,7 +97,10 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_=
fs_info *fs_info,
>                 bbio->orig_logical =3D orig_bbio->orig_logical;
>                 orig_bbio->orig_logical +=3D map_length;
>         }
> -       bbio->csum_search_commit_root =3D orig_bbio->csum_search_commit_r=
oot;
> +
> +       if (orig_bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT)
> +               bbio->flags |=3D BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT;
> +
>         atomic_inc(&orig_bbio->pending_ios);
>         return bbio;
>  }
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index d6da9ed08bfa..18d7d441c1ec 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -20,6 +20,9 @@ struct btrfs_inode;
>
>  typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
>
> +/* Use the commit root to look up csums (data read bio only). */
> +#define BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT      (1 << 0)

Please use ENUM_BIT(), it's our preferred way for defining flags and
makes backports less likely to cause problems due to accidental flags
getting the same value (we've been hit by this a few times in the
past).
See examples such as in extent-io-tree.h.

Also, what's the motivation for this and the other similar patches?
Does it reduce the size of the structure? If so, please mention it in
the changelog and what are the old and new sizes.

Thanks.

> +
>  /*
>   * Highlevel btrfs I/O structure.  It is allocated by btrfs_bio_alloc an=
d
>   * passed to btrfs_submit_bbio() for mapping to the physical devices.
> @@ -80,8 +83,7 @@ struct btrfs_bio {
>         /* Save the first error status of split bio. */
>         blk_status_t status;
>
> -       /* Use the commit root to look up csums (data read bio only). */
> -       bool csum_search_commit_root;
> +       unsigned int flags;
>
>         /*
>          * Since scrub will reuse btree inode, we need this flag to disti=
nguish
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 913fddce356a..1823262fabbd 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -603,7 +603,9 @@ void btrfs_submit_compressed_read(struct btrfs_bio *b=
bio)
>         cb->compressed_len =3D compressed_len;
>         cb->compress_type =3D btrfs_extent_map_compression(em);
>         cb->orig_bbio =3D bbio;
> -       cb->bbio.csum_search_commit_root =3D bbio->csum_search_commit_roo=
t;
> +
> +       if (bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT)
> +               cb->bbio.flags |=3D BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT;
>
>         btrfs_free_extent_map(em);
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 2d32dfc34ae3..d321f6897388 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -166,9 +166,10 @@ static void bio_set_csum_search_commit_root(struct b=
trfs_bio_ctrl *bio_ctrl)
>         if (!(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_READ && is_data_inode=
(bbio->inode)))
>                 return;
>
> -       bio_ctrl->bbio->csum_search_commit_root =3D
> -               (bio_ctrl->generation &&
> -                bio_ctrl->generation < btrfs_get_fs_generation(bbio->ino=
de->root->fs_info));
> +
> +       if (bio_ctrl->generation &&
> +           bio_ctrl->generation < btrfs_get_fs_generation(bbio->inode->r=
oot->fs_info))
> +               bbio->flags |=3D BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT;
>  }
>
>  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 14e5257f0f04..823c063bb4b7 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -422,7 +422,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>          * while we are not holding the commit_root_sem, and we get csums
>          * from across transactions.
>          */
> -       if (bbio->csum_search_commit_root) {
> +       if (bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT) {
>                 path->search_commit_root =3D true;
>                 path->skip_locking =3D true;
>                 down_read(&fs_info->commit_root_sem);
> @@ -473,7 +473,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>                 bio_offset +=3D count * sectorsize;
>         }
>
> -       if (bbio->csum_search_commit_root)
> +       if (bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT)
>                 up_read(&fs_info->commit_root_sem);
>         return ret;
>  }
> --
> 2.52.0
>
>

