Return-Path: <linux-btrfs+bounces-5168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD98CB120
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206D12833AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E42143C6A;
	Tue, 21 May 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxODwVDx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5D1FDD;
	Tue, 21 May 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305007; cv=none; b=Px0AMULpLDxa1TKhqc2175zWj5Y0jeFy3MkNVFtXAZSDyosxPLS5cJrtO3S0h/AQsYqqLb2/c790Z743oW5EWEGWUMCKX/570KT32LVUtptRePcoDyD4aFtHwADOSZzSq67X3hcYChHiYYw+/ba5A8oHM55qCXf70hXlJt8oqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305007; c=relaxed/simple;
	bh=36SWW3eOyBmXAHOaKAlujyS+t28dGTrAjamcUYFZRZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLzp7U5NhsmbuagJF7ffmyocMncs3ph9RlcuqFREhFMSAO/dpYysip1V0XUJCvQgNME5R8+o+x1nrqcDfy/S1k5IXCbYCuvh1t+scHuGiffkmAhAbH7B9Mo5EOUUp1EQQrFElmefii+JRig3r5M4Dm5OSH1KfSPla+zbf/TDR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxODwVDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E559C32786;
	Tue, 21 May 2024 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716305007;
	bh=36SWW3eOyBmXAHOaKAlujyS+t28dGTrAjamcUYFZRZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TxODwVDx3Jh0d3avxt6mBWuDgJcaKx37BSc705/Id5bYnVychjvWhDcci8UijqALK
	 m0BS7qDQDplZXSHDduC5DKnaWg7SWnuPkS5Lnbix6t4XiVXmyi5wyxOH/8yRGnZaC3
	 vXMM5b2L+JwvJ5kLsigY+aezJ0JWsiTvWxzPCI3PnfogfA+FcFVBIzYCCro7Sfz38q
	 DMy66cV1zYVu7+ymNMO0QAPZI0/CQV4gltaHAaCq62CwFdlJaZUpTvuHILzLy8+CJG
	 CXwj6z5TOf8yoxp5AFX1KtbRod2whxSgukpy6UEb7wyA0GpBYPLck6lhF96Gio25ii
	 5T+NVnoLgO0Jw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59b58fe083so625981066b.0;
        Tue, 21 May 2024 08:23:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzNJl7idl9fWFmoXUSWKjjfGgAWXTVTO108xtT6eIZeP3CnMuTczBBcr/pR1xxyLre7MlmHuaeB81tUmqX0D9ZdbjHnVMfFbKcQd/Zmdsw19vgaV/1rv9acjDCy343q5wmFHnflOcjjU4=
X-Gm-Message-State: AOJu0YwRXH8O+J/YktHBz39LH9nI7wBfe0berjb8BwPsKEdN6GauoW+A
	QUcP6fSJqk5utW/mnRm8yLl8QqVJAMt9vEmPdNLyWnwI3iTBPmFgHrWKk81YqUDYejUnAdB/sCi
	Seqq48y+ErAeBoPfkKfnWYhesNQ0=
X-Google-Smtp-Source: AGHT+IGFv2zmHhgkq4bVJqngk9pyNDLyzNH1uiZ07MvBdLHYHWPPX3Zr3usmnx9fWhu32CIymMwwtVTHaaYpCU21yu0=
X-Received: by 2002:a17:906:590f:b0:a59:9b52:cfc3 with SMTP id
 a640c23a62f3a-a5a2d57a35dmr1949146766b.29.1716305005726; Tue, 21 May 2024
 08:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-zoned-gc-v3-0-7db9742454c7@kernel.org> <20240521-zoned-gc-v3-1-7db9742454c7@kernel.org>
In-Reply-To: <20240521-zoned-gc-v3-1-7db9742454c7@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 21 May 2024 16:22:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5ONbcPnj=_+b2VeUvo9Y1BzPJ9Xh=WnaqmEnNUA0U4Kg@mail.gmail.com>
Message-ID: <CAL3q7H5ONbcPnj=_+b2VeUvo9Y1BzPJ9Xh=WnaqmEnNUA0U4Kg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: zoned: reserve relocation block-group on mount
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 3:58=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
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
>  fs/btrfs/zoned.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/btrfs/zoned.h   |  3 +++
>  3 files changed, 70 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a91a8056758a..19e7b4a59a9e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3558,6 +3558,8 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>         }
>         btrfs_discard_resume(fs_info);
>
> +       btrfs_reserve_relocation_bg(fs_info);
> +
>         if (fs_info->uuid_root &&
>             (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
>              fs_info->generation !=3D btrfs_super_uuid_tree_generation(di=
sk_super))) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 4cba80b34387..9404cb32256f 100644
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
> @@ -2634,3 +2635,67 @@ void btrfs_check_active_zone_reservation(struct bt=
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

I believe I commented about this in some previous patchset version,
but here goes again.

This happens at mount time, where we have already loaded all block groups.
When we load them, if we find unused ones, we add them to the list of
empty block groups, so that the next time the cleaner kthread runs it
deletes them.

I don't see any code here removing the selected block group from that
list, or anything at btrfs_delete_unused_bgs() that prevents deleting
a block group if it was selected as the data reloc bg.

Maybe I'm missing something?
How do ensure the selected block group isn't deleted by the cleaner kthread=
?

Thanks.


> +
> +       return 0;
> +}
> +
> +void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_info)
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
> +       if (fs_info->data_reloc_bg)
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
> +
> +out:
> +       spin_lock(&fs_info->relocation_bg_lock);
> +       fs_info->data_reloc_bg =3D bytenr;
> +       spin_unlock(&fs_info->relocation_bg_lock);
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 77c4321e331f..b9935222bf7a 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_i=
nfo);
>  int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
>                                 struct btrfs_space_info *space_info, bool=
 do_finish);
>  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
> +void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_info);
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
>
> --
> 2.43.0
>
>

