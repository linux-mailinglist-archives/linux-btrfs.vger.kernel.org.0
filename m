Return-Path: <linux-btrfs+bounces-10481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158729F4E13
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 15:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE46167F58
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B71F63C0;
	Tue, 17 Dec 2024 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgYd0g+e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA313B792
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446486; cv=none; b=dlXu1Leg5bx5WbPm+/2QmvEf94nq/TNn/3IjVNYN8WY/cUZn+9qdvEoSsI40IG8YkCtgmSqHGSlxfKzD+CPpgUM7lB9TRZSfVJyhtL4SVZ7zYbiZ9ypyZaB6yebUVIuK5TdhWDUJXsj32pJRFRxsIKMny+2TUqjzK82hkktuwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446486; c=relaxed/simple;
	bh=r8yLUkp5a/HWS6oYaxBmdU5lxMbiINVUE/TsTziNjlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHNzbwwQkMp460zo04H6zTYWFxTYMjXIWqM0wn7ysYF8M5MLubJOj6Q5mLtmDpmPAEQzEFOa3SMgAwidlMVtpw/ocM3m7MyN6gJsuyp68OYWjdVHP3rX6xKEmOCX3Ss3PtwCljJVZBOfB8nwgQeJ/Gw6pxAYtuqT+CDkA0BVLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgYd0g+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C50C4CEDE
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734446485;
	bh=r8yLUkp5a/HWS6oYaxBmdU5lxMbiINVUE/TsTziNjlM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FgYd0g+ezTRcQXMVG0unk82GI29w3sYTRW6MDoiAUMLIeP2I1dgC3IsfVDukQNWhm
	 C8KqXE6r8XC6cxvs3QgaJ9EB+R0co5DTuCPEtXVoYy4K+9m5h/Nk3kIHzFKThfsQ8K
	 WqXe3MQ/W/kYXOuuJzXcQ+WOJmzE1g3zDkhKcoIG4dLlYlEDlsZI4GtoFi1/2AVsvf
	 D7Avk7IjpmGBzWUS+gFyre7yoTfLTA1kekavE/iul9JiBcgxvDZdUGoc14PAk2iobG
	 EuGLqe13Jqh9m8uPbA6KMSMDuPmfd9TfQk1/CMPROnU6nbfMapAHNB6Snv346S/67D
	 kHkjWgSryTfbw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so7448346a12.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 06:41:25 -0800 (PST)
X-Gm-Message-State: AOJu0YzaaZO6X66WHGWjZp23cMxKZLg3TvDw0qp0HgvnnMsdXUAQGXlm
	EV9JQiTVWiWHVFRGpdXLfhO5GmlDr56AjaBPi22oagwXP6ie0jJ0bzr3n+MfXwuOLjZS0rGUfdU
	tIw6+p7oWj8Zaq+jcHLV3ono0ej0=
X-Google-Smtp-Source: AGHT+IGsA71/Z2L/CzzBzQbUfgREQrVZ6OrHx+UWsM3prY798p6wNb/wgI+QK1aXTf4b/LuL9IIkiJsUucm5qBF19/k=
X-Received: by 2002:a17:906:478a:b0:aa6:a21b:2a9 with SMTP id
 a640c23a62f3a-aab77ed4d3dmr1605904366b.57.1734446483729; Tue, 17 Dec 2024
 06:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <fc5d9d03586f57ffa99ac9e2f10389e2d61a29a7.1733989299.git.jth@kernel.org>
In-Reply-To: <fc5d9d03586f57ffa99ac9e2f10389e2d61a29a7.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 14:40:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5K4bQ6AD9CdUYwuZJccDfKLvdXDYHqLh6oYRCZ-q-4Ng@mail.gmail.com>
Message-ID: <CAL3q7H5K4bQ6AD9CdUYwuZJccDfKLvdXDYHqLh6oYRCZ-q-4Ng@mail.gmail.com>
Subject: Re: [PATCH 01/14] btrfs: don't try to delete RAID stripe-extents if
 we don't need to
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:57=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Don't try to delete RAID stripe-extents if we don't need to.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c             | 13 ++++++++++++-
>  fs/btrfs/tests/raid-stripe-tree-tests.c |  3 ++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 9ffc79f250fb..2c4ee5a9449a 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -59,9 +59,20 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle=
 *trans, u64 start, u64 le
>         int slot;
>         int ret;
>
> -       if (!stripe_root)
> +       if (!btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE) || !stripe_root=
)
>                 return 0;
>
> +       if (!btrfs_is_testing(fs_info)) {
> +               struct btrfs_chunk_map *map;
> +               bool use_rst;
> +
> +               map =3D btrfs_find_chunk_map(fs_info, start, length);

We should handle the case where we can't find an extent map (NULL).

Otherwise it looks good, thanks.

> +               use_rst =3D btrfs_need_stripe_tree_update(fs_info, map->t=
ype);
> +               btrfs_free_chunk_map(map);
> +               if (!use_rst)
> +                       return 0;
> +       }
> +
>         path =3D btrfs_alloc_path();
>         if (!path)
>                 return -ENOMEM;
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index 30f17eb7b6a8..f060c04c7f76 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -478,8 +478,9 @@ static int run_test(test_func_t test, u32 sectorsize,=
 u32 nodesize)
>                 ret =3D PTR_ERR(root);
>                 goto out;
>         }
> -       btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
> +       btrfs_set_super_incompat_flags(root->fs_info->super_copy,
>                                         BTRFS_FEATURE_INCOMPAT_RAID_STRIP=
E_TREE);
> +       btrfs_set_fs_incompat(root->fs_info, RAID_STRIPE_TREE);
>         root->root_key.objectid =3D BTRFS_RAID_STRIPE_TREE_OBJECTID;
>         root->root_key.type =3D BTRFS_ROOT_ITEM_KEY;
>         root->root_key.offset =3D 0;
> --
> 2.43.0
>
>

