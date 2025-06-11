Return-Path: <linux-btrfs+bounces-14605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153FCAD533B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1823A73AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF27B273D80;
	Wed, 11 Jun 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMohoi+/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625C273D7B
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639760; cv=none; b=cod5n5EwPZsiUxKcTBcjeQTAWtkFtKy9k/zQ2GnRzTpz077HVbBvQSNRmkiZHd/+YaOvH+PPNO/poBZznXrIeFEnryafkkViw81ms2q5wrWRACS2KfbiOS8poKpLojuoaf3hulCGNM3EhmDRk+2L+4OTgMkcXc40nz9FbVmgOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639760; c=relaxed/simple;
	bh=Ak9FcLcGlY/vK54qJpIC+YBqoCR+yCJzrziXEPajlNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qB2g1nm+PFfDNMcDsXlGiCxHJ077zGJykud3JcssMo6CDgArz72XlevELusRAnNoO1Zq2Kmj+TUN8lVX2WrgNqLcAME+eH0V4WEyqnwS6cSDFlG8RXfMQfar+uJ0nls3qDfKuAScV1u1UPyBOTgzf+e+BMIndRKVMVLsrJTcP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMohoi+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828F4C4CEF2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 11:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639759;
	bh=Ak9FcLcGlY/vK54qJpIC+YBqoCR+yCJzrziXEPajlNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UMohoi+/i5kBtk+bJJ4WbZaXPHm0JAoZCmuVCB88zryyVdby5KR1za1zqbfMzdoE1
	 B06ycbZIr4+cL1veFBlsHvlBnx2u6s++WklUvKgDEWyJ7zWwmRyuxeuySyvBuHgTKs
	 MVCjhXlbYTchX0VxADR1I5+d99MGEvbM8WeCEGu1Ib/4vEBgY5tTFHfBzv1bopYxKH
	 NsEw6VVeskc29eXxSBl0sTriXFJLDwCPtRlGKBuEOiQNbdapstnTe9lZgwa3fsZ4h8
	 V99AO+inov3ho45Nz6YysG/RPLoh3k5HLVZGS3diBow22CipKEv14nqi4qnRkkNFad
	 WMMGioLkLj44w==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso8505805a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 04:02:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwOI+vW54V23ub1jWDiN/rtA49qioaITV0AJE5uWyUsBhRxpmBD
	2OZb7le6Y69q2AUF0ai0B6dGDPdOoMr+OAhZler01aLtatFk7FpH6ssk0tKzmdwY3WvIlTvWZQF
	M0lMXWHYfWFdue8EzlleLxCCf0Ew2JOw=
X-Google-Smtp-Source: AGHT+IGJe22CtlYTnHx3p0MHwLTZKY77mm9BOn9SVOMiwaaaV2zEjw6uPiXfjtQ5MBqL9yq6IcKZpjoen3dX11V1gBk=
X-Received: by 2002:a17:906:6a0c:b0:ade:3b84:8f04 with SMTP id
 a640c23a62f3a-ade8c7696c8mr191941766b.21.1749639757855; Wed, 11 Jun 2025
 04:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <511dad96b50657c84f9926a3a2d370419be93722.1749604913.git.wqu@suse.com>
In-Reply-To: <511dad96b50657c84f9926a3a2d370419be93722.1749604913.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 11 Jun 2025 12:02:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7XNLSw3vSZY_RGR=2G1P3KH-5JMDHNpe=DqJuwUyyZQw@mail.gmail.com>
X-Gm-Features: AX0GCFtYeqBJG5QdxtTk5_1q83-0foMUR_9w8V278X2iV2HAyvYN5I0kOstLibQ
Message-ID: <CAL3q7H7XNLSw3vSZY_RGR=2G1P3KH-5JMDHNpe=DqJuwUyyZQw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add extra warning when qgroup is marked inconsistent
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:23=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Unlike qgroup rescan, which always shows whether it cleared the
> inconsistent flag, we do not have a proper way to show if qgroup is
> marked inconsistent.
>
> This was not a big deal before as there aren't that many locations that
> can mark qgroup inconsistent.
>
> But with the introduction of drop_subtree_threshold, qgroup can be
> marked inconsistent very frequently, especially for dropping large
> subvolume.
>
> Although most user space tools relying on qgroup should do their own
> checks and queue a rescan if needed, we have no idea when qgroup is
> marked inconsistent, and will be much harder to debug.
>
> So this patch will add an extra warning (btrfs_warn_rl()) when the
> qgroup flag is flipped into inconsistent for the first time.
> And add extra reason why qgroup flips inconsistent.
>
> This means we can move the error message immediately before
> qgroup_inconsistent_warning() into that function.
>
> For call sites without an obvious reason, or is a shared error handling,
> output the function that failed and the error code instead.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add a reason format string for qgroup_inconsistent_warning()
>   This can replace the existing error messages, and provide a much
>   better help for debugging.
> ---
>  fs/btrfs/qgroup.c | 87 ++++++++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 39 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index a1afc549c404..6d8d06f6b8f3 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -346,13 +346,27 @@ int btrfs_verify_qgroup_counts(const struct btrfs_f=
s_info *fs_info, u64 qgroupid
>  }
>  #endif
>
> -static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
> +__printf(2, 3)
> +static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info, cons=
t char *fmt, ...)
>  {
> +       bool old_inconsistent =3D fs_info->qgroup_flags & BTRFS_QGROUP_ST=
ATUS_FLAG_INCONSISTENT;

To avoid such long line:

const u64 old_flags =3D fs_info->qgroup_flags;

> +
>         if (btrfs_qgroup_mode(fs_info) =3D=3D BTRFS_QGROUP_MODE_SIMPLE)
>                 return;
>         fs_info->qgroup_flags |=3D (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT=
 |
>                                   BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN=
 |
>                                   BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING=
);
> +       if (!old_inconsistent) {

Then here:

if (!(old_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT))

Though it's a stylistic thing, feel free to ignore.

> +               struct va_format vaf;
> +               va_list args;
> +
> +               va_start(args, fmt);
> +               vaf.fmt =3D fmt;
> +               vaf.va =3D &args;
> +
> +               btrfs_warn_rl(fs_info, "qgroup marked inconsistent, %pV",=
 &vaf);
> +               va_end(args);
> +       }
>  }
>
>  static void qgroup_read_enable_gen(struct btrfs_fs_info *fs_info,
> @@ -431,13 +445,10 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *=
fs_info)
>                                 goto out;
>                         }
>                         fs_info->qgroup_flags =3D btrfs_qgroup_status_fla=
gs(l, ptr);
> -                       if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_F=
LAG_SIMPLE_MODE) {
> +                       if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_F=
LAG_SIMPLE_MODE)
>                                 qgroup_read_enable_gen(fs_info, l, slot, =
ptr);
> -                       } else if (btrfs_qgroup_status_generation(l, ptr)=
 !=3D fs_info->generation) {
> -                               qgroup_mark_inconsistent(fs_info);
> -                               btrfs_err(fs_info,
> -                                       "qgroup generation mismatch, mark=
ed as inconsistent");
> -                       }
> +                       else if (btrfs_qgroup_status_generation(l, ptr) !=
=3D fs_info->generation)
> +                               qgroup_mark_inconsistent(fs_info, "qgroup=
 generation mismatch");
>                         rescan_progress =3D btrfs_qgroup_status_rescan(l,=
 ptr);
>                         goto next1;
>                 }
> @@ -448,10 +459,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *f=
s_info)
>
>                 qgroup =3D find_qgroup_rb(fs_info, found_key.offset);
>                 if ((qgroup && found_key.type =3D=3D BTRFS_QGROUP_INFO_KE=
Y) ||
> -                   (!qgroup && found_key.type =3D=3D BTRFS_QGROUP_LIMIT_=
KEY)) {
> -                       btrfs_err(fs_info, "inconsistent qgroup config");
> -                       qgroup_mark_inconsistent(fs_info);
> -               }
> +                   (!qgroup && found_key.type =3D=3D BTRFS_QGROUP_LIMIT_=
KEY))
> +                       qgroup_mark_inconsistent(fs_info,
> +                                                "inconsistent qgroup con=
fig");

There doesn't seem to be a reason to do a line split here.

>                 if (!qgroup) {
>                         struct btrfs_qgroup *prealloc;
>                         struct btrfs_root *tree_root =3D fs_info->tree_ro=
ot;
> @@ -1841,13 +1851,12 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
>                 if (qgroup->rfer || qgroup->excl ||
>                     qgroup->rfer_cmpr || qgroup->excl_cmpr) {
>                         DEBUG_WARN();
> -                       btrfs_warn_rl(fs_info,
> -"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr =
%llu excl %llu excl_cmpr %llu",
> -                                     btrfs_qgroup_level(qgroup->qgroupid=
),
> -                                     btrfs_qgroup_subvolid(qgroup->qgrou=
pid),
> -                                     qgroup->rfer, qgroup->rfer_cmpr,
> -                                     qgroup->excl, qgroup->excl_cmpr);
> -                       qgroup_mark_inconsistent(fs_info);
> +                       qgroup_mark_inconsistent(fs_info,
> +                               "to be deleted qgroup %u/%llu has non-zer=
o numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
> +                               btrfs_qgroup_level(qgroup->qgroupid),
> +                               btrfs_qgroup_subvolid(qgroup->qgroupid),
> +                               qgroup->rfer, qgroup->rfer_cmpr,
> +                               qgroup->excl, qgroup->excl_cmpr);
>                 }
>         }
>         del_qgroup_rb(fs_info, qgroupid);
> @@ -1965,11 +1974,9 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *=
trans, u64 qgroupid,
>         spin_unlock(&fs_info->qgroup_lock);
>
>         ret =3D update_qgroup_limit_item(trans, qgroup);
> -       if (ret) {
> -               qgroup_mark_inconsistent(fs_info);
> -               btrfs_info(fs_info, "unable to update quota limit for %ll=
u",
> -                      qgroupid);
> -       }
> +       if (ret)
> +               qgroup_mark_inconsistent(fs_info, "qgroup item update err=
or %d",
> +                                        ret);

Same here, no need for line split.

>
>  out:
>         mutex_unlock(&fs_info->qgroup_ioctl_lock);
> @@ -2024,7 +2031,8 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_f=
s_info *fs_info,
>         ret =3D __xa_store(&delayed_refs->dirty_extents, index, record, G=
FP_ATOMIC);
>         xa_unlock(&delayed_refs->dirty_extents);
>         if (xa_is_err(ret)) {
> -               qgroup_mark_inconsistent(fs_info);
> +               qgroup_mark_inconsistent(fs_info,
> +                                        "xarray insert error: %d", xa_er=
r(ret));

Same here.

>                 return xa_err(ret);
>         }
>
> @@ -2091,10 +2099,8 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_tr=
ans_handle *trans,
>
>         ret =3D btrfs_find_all_roots(&ctx, true);
>         if (ret < 0) {
> -               qgroup_mark_inconsistent(fs_info);
> -               btrfs_warn(fs_info,
> -"error accounting new delayed refs extent (err code: %d), quota inconsis=
tent",
> -                       ret);
> +               qgroup_mark_inconsistent(fs_info,
> +                               "error accounting new delayed refs extent=
: %d", ret);
>                 return 0;
>         }
>
> @@ -2586,7 +2592,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_t=
rans_handle *trans,
>  out:
>         btrfs_free_path(dst_path);
>         if (ret < 0)
> -               qgroup_mark_inconsistent(fs_info);
> +               qgroup_mark_inconsistent(fs_info, "%s error: %d", __func_=
_, ret);
>         return ret;
>  }
>
> @@ -2630,7 +2636,8 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_h=
andle *trans,
>          * mark qgroup inconsistent.
>          */
>         if (root_level >=3D drop_subptree_thres) {
> -               qgroup_mark_inconsistent(fs_info);
> +               qgroup_mark_inconsistent(fs_info,
> +                                        "subtree level reached threshold=
");

Same here.

>                 return 0;
>         }
>
> @@ -3130,10 +3137,12 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *=
trans)
>                 spin_unlock(&fs_info->qgroup_lock);
>                 ret =3D update_qgroup_info_item(trans, qgroup);
>                 if (ret)
> -                       qgroup_mark_inconsistent(fs_info);
> +                       qgroup_mark_inconsistent(fs_info,
> +                                                "qgroup item update erro=
r %d", ret);

We have 3 identical messages here in this function. We can easily make
them distinct, for this one:

"qgroup info item update error %d"

>                 ret =3D update_qgroup_limit_item(trans, qgroup);
>                 if (ret)
> -                       qgroup_mark_inconsistent(fs_info);
> +                       qgroup_mark_inconsistent(fs_info,
> +                                                "qgroup item update erro=
r %d", ret);

For this one:   "qgroup limit item update error %d"

>                 spin_lock(&fs_info->qgroup_lock);
>         }
>         if (btrfs_qgroup_enabled(fs_info))
> @@ -3144,7 +3153,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *tr=
ans)
>
>         ret =3D update_qgroup_status_item(trans);
>         if (ret)
> -               qgroup_mark_inconsistent(fs_info);
> +               qgroup_mark_inconsistent(fs_info,
> +                                        "qgroup item update error %d", r=
et);

And here:  "qgroup status item update error %d"

Anyway these are minor updates, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


>
>         return ret;
>  }
> @@ -3551,7 +3561,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle =
*trans, u64 srcid,
>         if (!committing)
>                 mutex_unlock(&fs_info->qgroup_ioctl_lock);
>         if (need_rescan)
> -               qgroup_mark_inconsistent(fs_info);
> +               qgroup_mark_inconsistent(fs_info, "qgroup inherit needs a=
 rescan");
>         if (qlist_prealloc) {
>                 for (int i =3D 0; i < inherit->num_qgroups; i++)
>                         kfree(qlist_prealloc[i]);
> @@ -4785,7 +4795,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_ro=
ot *subvol_root,
>         spin_unlock(&blocks->lock);
>  out:
>         if (ret < 0)
> -               qgroup_mark_inconsistent(fs_info);
> +               qgroup_mark_inconsistent(fs_info, "%s error: %d", __func_=
_, ret);
>         return ret;
>  }
>
> @@ -4863,10 +4873,9 @@ int btrfs_qgroup_trace_subtree_after_cow(struct bt=
rfs_trans_handle *trans,
>         free_extent_buffer(reloc_eb);
>  out:
>         if (ret < 0) {
> -               btrfs_err_rl(fs_info,
> -                            "failed to account subtree at bytenr %llu: %=
d",
> -                            subvol_eb->start, ret);
> -               qgroup_mark_inconsistent(fs_info);
> +               qgroup_mark_inconsistent(fs_info,
> +                               "failed to account subtree at bytenr %llu=
: %d",
> +                               subvol_eb->start, ret);
>         }
>         return ret;
>  }
> --
> 2.49.0
>
>

