Return-Path: <linux-btrfs+bounces-4298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CDE8A69D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234341F214B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE34129A77;
	Tue, 16 Apr 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU6OVrcW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7651292CE
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267732; cv=none; b=pG2/m02J/oY6/Eny+6SHwRFqDCV6FxW52URrG5WZ0P/yXhGWJeIcStyFmScO1wHz1jPb6wKcf10O6ltLa4nzdEfNuMOoo1j0DDIvKFoCDkjKX/ORhYs+/cIje/iGzjTfYnTa0kp2ymB8NNpPcs+4mSCSQqkDVcZapSia2caxBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267732; c=relaxed/simple;
	bh=5L+qAARozmmk8lP3tX9FS/hNSlqNy7x1cDR7tMb1Sgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nbw1jJsc2V3gSQzqE/kkFDYxXxlnMsJbq6pMvP16CRSVi5qeHIJgefyr/D9gtl0a3ve/LSSQKTEmHgoB7eYMEbqdTHViwUPscNF0u4hvCZrIDDjvl8hTUS8MVNNPS4ilA+U/+6Ww6UHcLhCXwiWCGFcefVj3OFkL9s3U5fdrf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU6OVrcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4251C3277B
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713267731;
	bh=5L+qAARozmmk8lP3tX9FS/hNSlqNy7x1cDR7tMb1Sgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VU6OVrcWBayuZeiq1Enin4Tf8y1s1tnsS0v5Ki4uPdCAPOigLzrL+qf84/VFlarCx
	 brOJJnclBMv8PPxUscyrl/cPjggxVEXJBp3RCvi0Te4+Q6beL5Ayz4QaEMVuzWoYCk
	 sMiqSwLlGuf5/PEf44pqzh5e68vnVHAQojnRhLbHZj+o7BuZt6uWt5zDpgznIFKFmE
	 jfqmfKGa10z1ukanVVE4R945BLg/UtsaZkYDgDlc0uD3EU/ppUku9Xw/m6hK0qMeHp
	 fjJjAGHEwCFZd+CsnRYxyeHsvWf8yCMUFuPIrRf/ds3/b2hRfg2urzYJTo9607LoIQ
	 LG6OoU35WN2OA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51beae2f13so489509066b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 04:42:11 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz37JvJIc6ujStHUHqJLD6jsobaA9YctXl3dOU/1oV2wdSnsCq6
	zmnIXcTjOpv+RGi8xbbLOUm6aMQYbGBzhO5EIQ7dwpEVRd8wI+YVf7JPeMEmoVo/ep6zggqTXSr
	EGVYaZEHXQKVfxp2ROqY2bNMJKAI=
X-Google-Smtp-Source: AGHT+IEGoudS4XvvWFAM44VhDQuRmrmqyPH7BApV1ei0+QC+uhqVr9cWULDxNobjGGSYJbHKdBu3/pyvsUxaYZNGeCI=
X-Received: by 2002:a17:907:5c5:b0:a52:1fb:180d with SMTP id
 wg5-20020a17090705c500b00a5201fb180dmr9680938ejb.46.1713267730271; Tue, 16
 Apr 2024 04:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713223082.git.wqu@suse.com> <52ebe8f2afb1460ef9b5abc814c432b4f4bd0dd4.1713223082.git.wqu@suse.com>
In-Reply-To: <52ebe8f2afb1460ef9b5abc814c432b4f4bd0dd4.1713223082.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Apr 2024 12:41:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5qQU_hSVgzP9qJ0y4J0igx+gk23nNHBPkxzkQY61_cQA@mail.gmail.com>
Message-ID: <CAL3q7H5qQU_hSVgzP9qJ0y4J0igx+gk23nNHBPkxzkQY61_cQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: tree-checker: add one extra file extent item
 ram_bytes check
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 12:24=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> During my development on extent map cleanups, I hit a case where we can
> create a file extent item that has ram_bytes double the size of
> num_bytes but it's not compressed.
>
> Later it turns out to be a bug in btrfs_split_ordered_extent(), and
> thankfully it doesn't cause any real corruption, just a drift from
> on-disk format.
>
> Here we add an extra check on ram_bytes for btrfs_file_extent_item to
> catch such problem.
>
> However considering the incorrect ram_bytes are already in the wild, and
> no real data corruption, we do not want end users to be bothered as their
> data is still consistent.
>
> So this patch would only hide the check behind DEBUG builds for us
> developers to catch future problem.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index c8fbcae4e88e..8dfbec3e6ba2 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -212,6 +212,7 @@ static int check_extent_data_item(struct extent_buffe=
r *leaf,
>         u32 sectorsize =3D fs_info->sectorsize;
>         u32 item_size =3D btrfs_item_size(leaf, slot);
>         u64 extent_end;
> +       u8 compression;
>
>         if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
>                 file_extent_err(leaf, slot,
> @@ -251,16 +252,15 @@ static int check_extent_data_item(struct extent_buf=
fer *leaf,
>                 return -EUCLEAN;
>         }
>
> +       compression =3D btrfs_file_extent_compression(leaf, fi);
>         /*
>          * Support for new compression/encryption must introduce incompat=
 flag,
>          * and must be caught in open_ctree().
>          */
> -       if (unlikely(btrfs_file_extent_compression(leaf, fi) >=3D
> -                    BTRFS_NR_COMPRESS_TYPES)) {
> +       if (unlikely(compression >=3D BTRFS_NR_COMPRESS_TYPES)) {
>                 file_extent_err(leaf, slot,
>         "invalid compression for file extent, have %u expect range [0, %u=
]",
> -                       btrfs_file_extent_compression(leaf, fi),
> -                       BTRFS_NR_COMPRESS_TYPES - 1);
> +                       compression, BTRFS_NR_COMPRESS_TYPES - 1);
>                 return -EUCLEAN;
>         }
>         if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
> @@ -279,8 +279,7 @@ static int check_extent_data_item(struct extent_buffe=
r *leaf,
>                 }
>
>                 /* Compressed inline extent has no on-disk size, skip it =
*/
> -               if (btrfs_file_extent_compression(leaf, fi) !=3D
> -                   BTRFS_COMPRESS_NONE)
> +               if (compression !=3D BTRFS_COMPRESS_NONE)
>                         return 0;
>
>                 /* Uncompressed inline extent size must match item size *=
/
> @@ -319,6 +318,30 @@ static int check_extent_data_item(struct extent_buff=
er *leaf,
>                 return -EUCLEAN;
>         }
>
> +       /*
> +        * If it's a uncompressed regular extents, its ram size should ma=
tch
> +        * disk_num_bytes. But for now we have several call sites that do=
esn't
> +        * properly update @ram_bytes, so at least make sure
> +        * @ram_bytes <=3D @disk_num_bytes.
> +        *
> +        * However we have a recent bug related to @ram_bytes update, cau=
sing

Reading this in one year or more will be confusing.
Why not just say:

"However we had a bug related to ..."

> +        * all zoned btrfs and regular btrfs DIO to be affected.
> +        * Thankfully the ram_bytes is not critical for non-compressed fi=
le extents.
> +        * So here we hide the check behind DEBUG builds for developers o=
nly.
> +        */
> +#ifdef CONFIG_BTRFS_DEBUG
> +       if (unlikely(compression =3D=3D BTRFS_COMPRESS_NONE &&
> +                    btrfs_file_extent_disk_bytenr(leaf, fi) &&
> +                    btrfs_file_extent_ram_bytes(leaf, fi) >
> +                    btrfs_file_extent_disk_num_bytes(leaf, fi))) {
> +               file_extent_err(leaf, slot,
> +                               "invalid ram_bytes, have %llu expect <=3D=
%llu",

Please leave a space between <=3D and %llu, that makes it more readable,
consistent with code and consistent with an error message at
check_block_group_item().

With that change:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +                               btrfs_file_extent_ram_bytes(leaf, fi),
> +                               btrfs_file_extent_disk_num_bytes(leaf, fi=
));
> +               return -EUCLEAN;
> +       }
> +#endif
> +
>         /*
>          * Check that no two consecutive file extent items, in the same l=
eaf,
>          * present ranges that overlap each other.
> --
> 2.44.0
>
>

