Return-Path: <linux-btrfs+bounces-19143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638AC6E6C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 13:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F17D42C4F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 12:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9935581F;
	Wed, 19 Nov 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIsnaIGc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168E33E34C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554951; cv=none; b=dWMi5RiXKXt/BefzynrXndr3Ao4u4YnipYVvR9kIyxPHTgqRoMdYQ2X68iXvYE03V7RleC3dQT+q16jZUOQVYSWEbKWOFo1Uf2g5qEifD8NhpsdHRUjmYlkLVN0Qt/CUVwaTNulVA1RdTnZzLZ7MDM99iofbUWKBqnn6kOjeiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554951; c=relaxed/simple;
	bh=yNkh+FGS8yxloGOK54t9LE/IQxfEVuZ+9Fza/N5k79M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwAFos9Xde9sn8l6MwDB8KcxfLnr6ycGlYohR6pob1IiyFp7n+/rT0+NxVXFRA2+Mya/LJQoeJWOOIx6VsPAlI6LvsxVX5Wq+nJuK3owTcm+n+A5D7lquVOti6iV1jXTCr6zhUMtdSBwzjECzRmj8c7aR1hNM2d6u/f4Lf+m0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIsnaIGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FB8C2BCB4
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 12:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763554951;
	bh=yNkh+FGS8yxloGOK54t9LE/IQxfEVuZ+9Fza/N5k79M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sIsnaIGcqXOTHjU5Mc0OUFrYLZE3bFWV7bZBuO9FFpx71MD1pCfBCW9mAfjVO7rJj
	 rkECaxF/QmJDPgBGiFTK75wbbc76TVLIUVmG/Co3vVPzbm5nXSMT89q+J3xtzzaVeM
	 wrooJQxSOKab/apm6zjew9BbGRgFMrb0qqoAmIBODV541tgyHFJ5CpuYq6smGwldfs
	 or4PnJXerV5ubVcA+J2ZNdR5up7jg5mt0VuVOOyJQZ0aZp16yNRgQLgLLAOnh5Lbxu
	 okhjuwVexGJ2NBtgFG0+KXJnkodq5pbIc9HqH64eboQtu8FewZ5itdOaDvg4T0Ujpk
	 E9mpH1kCDKW9g==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b737c6c13e1so758432266b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 04:22:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdGHs/6ildiPRFl7+Ag7LOD4p8QIzrKnA0pN3aVcL0i7n1ljpl2Hsy5IZPxNbJBZDlj0tdFyawSNgqgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJqOrdQLj6ov7hFCftlF+F7RrRPo10N1iTqoiPaOdDrBvMzvE
	uTxc9XsLY2tC3VaKD12TS9BXTL7lPKKikHx6DV9XX85DARxoDRR7CYQ7xi6EnhSTI3yGTmscVrT
	GCO6ETishxoiSlGk0Ehj9IvLZilDtjb8=
X-Google-Smtp-Source: AGHT+IGPom92GimBYmeWMqayo6X+8ZokA/qiAlRcgcVuw804bv8iYT664Qm8Q9nK5ibXOLGMlpM1oemDIBSdswBpXr0=
X-Received: by 2002:a17:906:d1d9:b0:b73:6998:7bce with SMTP id
 a640c23a62f3a-b7369987d75mr1707560566b.33.1763554949092; Wed, 19 Nov 2025
 04:22:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118160845.3006733-1-neelx@suse.com> <20251118160845.3006733-6-neelx@suse.com>
In-Reply-To: <20251118160845.3006733-6-neelx@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 19 Nov 2025 12:21:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5AVVyeNxdXPJyGM9ys7WLncTWnwAciuEtThbWpzZGe2Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkdS2k-ra-zLwBH59RTYVXAiDits3StdQPQgZCkdORiNKljtxwa0iz-_2M
Message-ID: <CAL3q7H5AVVyeNxdXPJyGM9ys7WLncTWnwAciuEtThbWpzZGe2Q@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] btrfs: move inode_to_path higher in backref.c
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 4:16=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrote=
:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> We have a prototype and then the definition lower below, we don't need
> to do this, simply move the function to where the prototype is.

According to our development notes here:

https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html

Under the "Function declarations" section we have:

"avoid prototypes for static functions, order them in new code in a
way that does not need it

but don=E2=80=99t move static functions just to get rid of the prototype"

So what's the motivation for moving the function?



>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/backref.c | 68 ++++++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 36 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 78da47a3d00e..bd913e3c356f 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2574,8 +2574,39 @@ int iterate_inodes_from_logical(u64 logical, struc=
t btrfs_fs_info *fs_info,
>         return iterate_extent_inodes(&walk_ctx, false, build_ino_list, ct=
x);
>  }
>
> +/*
> + * returns 0 if the path could be dumped (probably truncated)
> + * returns <0 in case of an error
> + */
>  static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
> -                        struct extent_buffer *eb, struct inode_fs_paths =
*ipath);
> +                        struct extent_buffer *eb, struct inode_fs_paths =
*ipath)
> +{
> +       char *fspath;
> +       char *fspath_min;
> +       int i =3D ipath->fspath->elem_cnt;
> +       const int s_ptr =3D sizeof(char *);
> +       u32 bytes_left;
> +
> +       bytes_left =3D ipath->fspath->bytes_left > s_ptr ? ipath->fspath-=
>bytes_left - s_ptr : 0;
> +
> +       fspath_min =3D (char *)ipath->fspath->val + (i + 1) * s_ptr;
> +       fspath =3D btrfs_ref_to_path(ipath->fs_root, ipath->btrfs_path, n=
ame_len,
> +                                  name_off, eb, inum, fspath_min, bytes_=
left);
> +       if (IS_ERR(fspath))
> +               return PTR_ERR(fspath);
> +
> +       if (fspath > fspath_min) {
> +               ipath->fspath->val[i] =3D (u64)(unsigned long)fspath;
> +               ++ipath->fspath->elem_cnt;
> +               ipath->fspath->bytes_left =3D fspath - fspath_min;
> +       } else {
> +               ++ipath->fspath->elem_missed;
> +               ipath->fspath->bytes_missing +=3D fspath_min - fspath;
> +               ipath->fspath->bytes_left =3D 0;
> +       }
> +
> +       return 0;
> +}
>
>  static int iterate_inode_refs(u64 inum, struct inode_fs_paths *ipath)
>  {
> @@ -2700,41 +2731,6 @@ static int iterate_inode_extrefs(u64 inum, struct =
inode_fs_paths *ipath)
>         return ret;
>  }
>
> -/*
> - * returns 0 if the path could be dumped (probably truncated)
> - * returns <0 in case of an error
> - */
> -static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
> -                        struct extent_buffer *eb, struct inode_fs_paths =
*ipath)
> -{
> -       char *fspath;
> -       char *fspath_min;
> -       int i =3D ipath->fspath->elem_cnt;
> -       const int s_ptr =3D sizeof(char *);
> -       u32 bytes_left;
> -
> -       bytes_left =3D ipath->fspath->bytes_left > s_ptr ?
> -                                       ipath->fspath->bytes_left - s_ptr=
 : 0;
> -
> -       fspath_min =3D (char *)ipath->fspath->val + (i + 1) * s_ptr;
> -       fspath =3D btrfs_ref_to_path(ipath->fs_root, ipath->btrfs_path, n=
ame_len,
> -                                  name_off, eb, inum, fspath_min, bytes_=
left);
> -       if (IS_ERR(fspath))
> -               return PTR_ERR(fspath);
> -
> -       if (fspath > fspath_min) {
> -               ipath->fspath->val[i] =3D (u64)(unsigned long)fspath;
> -               ++ipath->fspath->elem_cnt;
> -               ipath->fspath->bytes_left =3D fspath - fspath_min;
> -       } else {
> -               ++ipath->fspath->elem_missed;
> -               ipath->fspath->bytes_missing +=3D fspath_min - fspath;
> -               ipath->fspath->bytes_left =3D 0;
> -       }
> -
> -       return 0;
> -}
> -
>  /*
>   * this dumps all file system paths to the inode into the ipath struct, =
provided
>   * is has been created large enough. each path is zero-terminated and ac=
cessed
> --
> 2.51.0
>
>

