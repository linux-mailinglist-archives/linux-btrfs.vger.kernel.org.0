Return-Path: <linux-btrfs+bounces-12099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB3A56ABE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 15:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257983AB82D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098EF155321;
	Fri,  7 Mar 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM9lbCzc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427228BE5
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358781; cv=none; b=K1DkPnXVCeZi/8Ld06vayUi8ewaVqt5fj0PT3uv0KZeirVB9j3MAATMrs3GO7fIstUmwXYM3WvSi0CLipCdJDgL6LnAFpPaZFR88aNh/pAEz+mO8N/Sbs0vhQ0iFE3xv/rq0M5vbfOEcywndw3BP+KGq7ALRSyQymBoMF5MpQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358781; c=relaxed/simple;
	bh=XQJMD07KUybDIAVTIaEE4n7W3Oe214XAmOgTnINFVYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/L0zFHeS5ZLcU5OfkuKngZbalkJCTI0I8GoPQpYduoN9iTcnMy6r7TUxUMRaVvesJ9Oqu/CycT4b9n1tExOquBBuYnWeNpxXA1HW7p7xFR2cn6c0lUEao0BGSfLE/bq3C1eumaxNIP7teL4gVZcFOy698KF7i32ElnDfCVbHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM9lbCzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3880C4CEE8
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741358779;
	bh=XQJMD07KUybDIAVTIaEE4n7W3Oe214XAmOgTnINFVYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZM9lbCzcMrMMHJ4N74aKoG3k/Oi2udmOsLmiuJpGKGtj7yoP8pD4vRyPYt6F3Ix58
	 FdX8lBdMvIQM4D+WOWrmBBioMiaIb1jBECzNb35Rt+e0uxmiQMTPgdnspusVN16Osc
	 ZAfC2bJZp43mHx/Umtiasp7/xWoFtXwvMyFHL0xnJTQnOW17DaqUyc61hhK+qAF+zA
	 jKrYcs8e8oL4ZXwoKaRi6ntdrX8rs9+6eQGbchp/CxsJBLkIGcYlVRfSyqOQ3NEoQd
	 fsgDMM5Fg11VOvo8yMdXSLkV60tAn9tbAqWUvQ1viFQOj2TAoUKUj1r4H64gMNTWAC
	 on6BWwtj7158Q==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec111762bso359993266b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Mar 2025 06:46:19 -0800 (PST)
X-Gm-Message-State: AOJu0YzR8QZAyjwKynYx7o17bGJ82TVMfrjT2LvEZjQK74ZGkiaGsVI7
	hSX4dd5iXyBb+DgjSAHTGZMa/H+VfQrBac0rlHEtENFygEQXcaHyGxEo01EK1fTqYbMXECpQXCB
	kzZ3mrJvqPwM1/XQYWSBivrW2CH0=
X-Google-Smtp-Source: AGHT+IFUpU3rAhkOTp01pr7DA8KR/rT8wJhGUYKfTeN8xaByDCtEBEk9QCKgQ+m8IyQj8omoQDJN0bUrI7eoDIJ7szE=
X-Received: by 2002:a17:906:9586:b0:abf:d4a9:a096 with SMTP id
 a640c23a62f3a-ac252fb6f47mr359718766b.37.1741358778165; Fri, 07 Mar 2025
 06:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741306938.git.boris@bur.io> <91e9ffb668376e4c67753ca92c8ca8737c07258c.1741306938.git.boris@bur.io>
In-Reply-To: <91e9ffb668376e4c67753ca92c8ca8737c07258c.1741306938.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 7 Mar 2025 14:45:40 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7XB-FFKDkWv7iPRH1wQygrgw9iz25iSam+rBvFBcqwcg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr5s2XC090PqLVOt57Gnj20FnKl0E3Ba0FjR8Ft5p22wx9Xw1DYu0wuvAw
Message-ID: <CAL3q7H7XB-FFKDkWv7iPRH1wQygrgw9iz25iSam+rBvFBcqwcg@mail.gmail.com>
Subject: Re: [PATCH 5/5] btrfs: codify pattern for adding block_group to bg_list
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:31=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> Similar to mark_bg_unused and mark_bg_to_reclaim, we have a few places
> that use bg_list with refcounting, mostly for retrying failures to
> reclaim/delete unused.
>
> These have custom logic for handling locking and refcounting the bg_list
> properly, but they actually all want to do the same thing, so pull that
> logic out into a helper. Unfortunately, mark_bg_unused does still need
> the NEW flag to avoid prematurely marking stuff unused (even if refcount
> is fine, we don't want to mess with bg creation), so it cannot use the
> new helper.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 54 +++++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e4071897c9a8..a570d89ff0c3 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1455,6 +1455,31 @@ static bool clean_pinned_extents(struct btrfs_tran=
s_handle *trans,
>         return ret =3D=3D 0;
>  }
>
> +/*
> + * link the block_group to l via bg_list

Please make the style consistent with the rest, first word capitalized
and ending the sentence with punctuation.

> + *
> + * Use this rather than list_add_tail directly to ensure proper respect
> + * to locking and refcounting.
> + *
> + * @bg: the block_group to link to the list.
> + * @l: the list to link it to.
> + * Returns: true if the bg was linked with a refcount bump and false oth=
erwise.
> + */
> +static bool btrfs_link_bg_list(struct btrfs_block_group *bg, struct list=
_head *l)

Don't use single letter variable names, it's discouraged, except for
loop index variables like 'i' or 'j' for inner loops.
Use something else like 'list' for example.

Otherwise it looks fine.

With that:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +{
> +       struct btrfs_fs_info *fs_info =3D bg->fs_info;
> +       bool added =3D false;
> +
> +       spin_lock(&fs_info->unused_bgs_lock);
> +       if (list_empty(&bg->bg_list)) {
> +               btrfs_get_block_group(bg);
> +               list_add_tail(&bg->bg_list, l);
> +               added =3D true;
> +       }
> +       spin_unlock(&fs_info->unused_bgs_lock);
> +       return added;
> +}
> +
>  /*
>   * Process the unused_bgs list and remove any that don't have any alloca=
ted
>   * space inside of them.
> @@ -1570,8 +1595,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
>                          * drop under the "next" label for the
>                          * fs_info->unused_bgs list.
>                          */
> -                       btrfs_get_block_group(block_group);
> -                       list_add_tail(&block_group->bg_list, &retry_list)=
;
> +                       btrfs_link_bg_list(block_group, &retry_list);
>
>                         trace_btrfs_skip_unused_block_group(block_group);
>                         spin_unlock(&block_group->lock);
> @@ -1968,20 +1992,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)
>                 spin_unlock(&space_info->lock);
>
>  next:
> -               if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
> -                       /* Refcount held by the reclaim_bgs list after sp=
lice. */
> -                       spin_lock(&fs_info->unused_bgs_lock);
> -                       /*
> -                        * This block group might be added to the unused =
list
> -                        * during the above process. Move it back to the
> -                        * reclaim list otherwise.
> -                        */
> -                       if (list_empty(&bg->bg_list)) {
> -                               btrfs_get_block_group(bg);
> -                               list_add_tail(&bg->bg_list, &retry_list);
> -                       }
> -                       spin_unlock(&fs_info->unused_bgs_lock);
> -               }
> +               if (ret && !READ_ONCE(space_info->periodic_reclaim))
> +                       btrfs_link_bg_list(bg, &retry_list);
>                 btrfs_put_block_group(bg);
>
>                 mutex_unlock(&fs_info->reclaim_bgs_lock);
> @@ -2021,13 +2033,8 @@ void btrfs_mark_bg_to_reclaim(struct btrfs_block_g=
roup *bg)
>  {
>         struct btrfs_fs_info *fs_info =3D bg->fs_info;
>
> -       spin_lock(&fs_info->unused_bgs_lock);
> -       if (list_empty(&bg->bg_list)) {
> -               btrfs_get_block_group(bg);
> +       if (btrfs_link_bg_list(bg, &fs_info->reclaim_bgs))
>                 trace_btrfs_add_reclaim_block_group(bg);
> -               list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
> -       }
> -       spin_unlock(&fs_info->unused_bgs_lock);
>  }
>
>  static int read_bg_from_eb(struct btrfs_fs_info *fs_info, const struct b=
trfs_key *key,
> @@ -2940,8 +2947,7 @@ struct btrfs_block_group *btrfs_make_block_group(st=
ruct btrfs_trans_handle *tran
>         }
>  #endif
>
> -       btrfs_get_block_group(cache);
> -       list_add_tail(&cache->bg_list, &trans->new_bgs);
> +       btrfs_link_bg_list(cache, &trans->new_bgs);
>         btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
>
>         set_avail_alloc_bits(fs_info, type);
> --
> 2.48.1
>
>

