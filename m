Return-Path: <linux-btrfs+bounces-4352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8790F8A8458
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 15:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E42B253BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C5D13FD9D;
	Wed, 17 Apr 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/yRUj7T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748C13E414
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360192; cv=none; b=qCghcYb06/mXBrpa+BH2fv1xfnRMfeWkplP7GvGZAzS8zWK9eWCSYvYUUTL5lZohqgGSCAvmsIfrWq4uttY1TWNNibdmuuNOcIOpVqug5kY6llGobBEClLsI3REzTxuK2ltX2DrK+tx2zjlArSDw6G3uhZfNjd7eHSeKSjfRwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360192; c=relaxed/simple;
	bh=MegZYV5VnMj6iR/NqNENjrC0LjnfYtpYVCS0wW0jdZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA861e+G1DcHvkLnWCIQPy0cYPUFjrCBIaF6yPfa+j+kzIYssk5DgULzzeuN5i1GOIFu8pgMc0IhpLF+qSnalaqMbzHM+W2s8L88Ke6MkutJGARNp8A+f4LMjf7qOg79s0A6t5rJRaygv0AgeLEvkatnyhxg12KMSoo2JvNozDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/yRUj7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC27C4AF07
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713360191;
	bh=MegZYV5VnMj6iR/NqNENjrC0LjnfYtpYVCS0wW0jdZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q/yRUj7Ta21ejfCNHcPKa6WzGOZJyEWln99ty6VfT4A6Y+ndOGY0AH234Mss1sljD
	 Q3MDiAeQv5EzOib7XzSFUgAxKZKopWb/ADKKbLFseL8U84VNNFAOTpADCjtBE3J0tE
	 7xmvGyjn2rochL0Pgf9cCBDKm6cLsmDUjR5PuLrUbUqaD26U/M3EbnrmC2sAuY7SvY
	 HinApjjWycPcpMjQ6I8DKdVMf0/SzEkdZBZQvlI2aoP/PT0XF4PuIL5r3g5U62F2zq
	 QgOHgZqbDOakaMR5ejFJyeuxzjayN76d+xRCZFDvFPWgDHd6fMBxhWlV/JlyeQJkBi
	 KK8bV3jwkLSwg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a55323f2ef9so358407966b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 06:23:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YxJVLEbu4fzeBRcLzcthgZkoSeyAT5oUrGdVS5woR87WLBCEWGg
	MC/OceoqW6L32F1wPSbE1wBZShE7nuXBQ4ElujaW0Snq9fncNqOPBBV5jOpG++49wguh28J0rTC
	0fzgdGx8pENSB8uI21rkP79JMBiw=
X-Google-Smtp-Source: AGHT+IEp/N8WmhguNen8mYr7GXkBYxgnbo7omYru4f9SKc6mFdFzEHb9VgpHvVo3TMzuPJ9PYiAYMOwZesCxmCplqus=
X-Received: by 2002:a17:907:7208:b0:a51:a329:cd76 with SMTP id
 dr8-20020a170907720800b00a51a329cd76mr13209457ejc.13.1713360190335; Wed, 17
 Apr 2024 06:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1480374e3f65371d4b857fb45a3fd9f6a5fa4a25.1713357984.git.jth@kernel.org>
In-Reply-To: <1480374e3f65371d4b857fb45a3fd9f6a5fa4a25.1713357984.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Apr 2024 14:22:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H708=OB+XSLjx5ZL8g_Z8j1TC8RHmx1fHE63h6PT8SB0g@mail.gmail.com>
Message-ID: <CAL3q7H708=OB+XSLjx5ZL8g_Z8j1TC8RHmx1fHE63h6PT8SB0g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: reserve relocation zone on mount
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Boris Burkov <boris@bur.io>, 
	Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:47=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Reserve one zone as a data relocation target on each mount. If we already
> find one empty block group, there's no need to force a chunk allocation,
> but we can use this empty data block group as our relocation target.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/disk-io.c |  2 ++
>  fs/btrfs/zoned.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h   |  3 +++
>  3 files changed, 65 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c2dc88f909b0..680ea8924333 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3559,6 +3559,8 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>         }
>         btrfs_discard_resume(fs_info);
>
> +       btrfs_reserve_relocation_zone(fs_info);
> +
>         if (fs_info->uuid_root &&
>             (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
>              fs_info->generation !=3D btrfs_super_uuid_tree_generation(di=
sk_super))) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d51faf7f4162..1d44c268da96 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -17,6 +17,7 @@
>  #include "fs.h"
>  #include "accessors.h"
>  #include "bio.h"
> +#include "transaction.h"
>
>  /* Maximum number of zones to report per blkdev_report_zones() call */
>  #define BTRFS_REPORT_NR_ZONES   4096
> @@ -2634,3 +2635,62 @@ void btrfs_check_active_zone_reservation(struct bt=
rfs_fs_info *fs_info)
>         }
>         spin_unlock(&fs_info->zone_active_bgs_lock);
>  }
> +
> +static u64 find_empty_block_group(struct btrfs_space_info *sinfo, u64 fl=
ags)
> +{
> +       struct btrfs_block_group *bg;
> +
> +       for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {
> +               list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> +                       if (bg->flags !=3D flags)
> +                               continue;
> +                       if (bg->used =3D=3D 0)
> +                               return bg->start;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info)
> +{
> +       struct btrfs_root *tree_root =3D fs_info->tree_root;
> +       struct btrfs_space_info *sinfo =3D fs_info->data_sinfo;
> +       struct btrfs_trans_handle *trans;
> +       u64 flags =3D btrfs_get_alloc_profile(fs_info, sinfo->flags);
> +       u64 bytenr =3D 0;
> +
> +       lockdep_assert_not_held(&fs_info->relocation_bg_lock);
> +
> +       if (!btrfs_is_zoned(fs_info))
> +               return;
> +
> +       bytenr =3D find_empty_block_group(sinfo, flags);
> +       if (!bytenr) {
> +               int ret;
> +
> +               trans =3D btrfs_join_transaction(tree_root);
> +               if (IS_ERR(trans))
> +                       return;
> +
> +               ret =3D btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE=
);
> +               btrfs_end_transaction(trans);
> +
> +               if (!ret) {
> +                       struct btrfs_block_group *bg;
> +
> +                       bytenr =3D find_empty_block_group(sinfo, flags);
> +                       if (!bytenr)
> +                               goto out;
> +                       bg =3D btrfs_lookup_block_group(fs_info, bytenr);
> +                       ASSERT(bg);
> +
> +                       if (!btrfs_zone_activate(bg))
> +                               bytenr =3D 0;
> +                       btrfs_put_block_group(bg);
> +               }
> +       }

At mount time before reaching this code, we read all block groups and
any unused block groups are added to the list of unused block groups,
so that the cleaner kthread will delete them the next time it runs (if
they are still unused).

Don't you need to remove the block group from the list?

Thanks.

> +
> +out:
> +       fs_info->data_reloc_bg =3D bytenr;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 77c4321e331f..048ffada4549 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_i=
nfo);
>  int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
>                                 struct btrfs_space_info *space_info, bool=
 do_finish);
>  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
> +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 po=
s,
>                                      struct blk_zone *zone)
> @@ -271,6 +272,8 @@ static inline int btrfs_zoned_activate_one_bg(struct =
btrfs_fs_info *fs_info,
>
>  static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_i=
nfo *fs_info) { }
>
> +static inline void btrfs_reserve_relocation_zone(struct btrfs_fs_info *f=
s_info) { }
> +
>  #endif
>
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, =
u64 pos)
> --
> 2.35.3
>
>

