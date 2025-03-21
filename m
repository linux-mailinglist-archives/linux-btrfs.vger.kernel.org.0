Return-Path: <linux-btrfs+bounces-12485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0CCA6BA63
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 13:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B643AC93A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D95225A20;
	Fri, 21 Mar 2025 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF/zKf5F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A792248BE
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559076; cv=none; b=uQ/mTK0domi8juAXFrpFf8CuhA3mAKziAvA+cIXjadaqUi/luRBXl1ZKPZAiNNRCIsNMkPt4om9TjDXxlLJRvIQrMaYmBmEYhe2jzJ/l8kJzgFo8lbs5lXgx5B80+ih7fYBnM+ju/ar5RFyS7Ah2UmvxVkMq7igHjMQ44gRE6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559076; c=relaxed/simple;
	bh=qdmNjUWhriFJpZTBgda8T7HPWf/Tib3lkwwnJnMjUwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r48vlqcJrz1t48mTxYuKMcz0k0JAeLoeuMUgU0SUyUryBbjPG62XmEneB5vqkabSGCf+CxOQHUtF8Yv5lxcWWsoZXWdNnGQ1D7f1HAjD2vb0upBm0xPod8LuDiOqh2ZiUYWG0ZNtm9fmdxb9vw+8Yqer8+MCt2Bg/CVdXsMEI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF/zKf5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E569C4CEE3
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742559075;
	bh=qdmNjUWhriFJpZTBgda8T7HPWf/Tib3lkwwnJnMjUwA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DF/zKf5FThhicYmNpKqc1iS5yG4phkveVUUEVlVG0Mk40sk2oXyLcEuAqax7Db1F7
	 bVU0k68rjQz0Qx4Zeie4KVpIOByPCkLjMbM7iwApW74FBA0QM9foSbFhfNooPtEBU9
	 m5l1Ok/nBs5pj88ndzM1OgRLRpHu4wrm62cwszVMMy3dfM5mmPzvT9gf8j64nKEVFG
	 QhOk95v2ZcqtTlFRBxyj/iodvYyfr3kQWeVzsXbpP8WLm53cc7dBhImFpM0dSnlfx0
	 vriYxhiXGOopYkaSG16jb9ixbvPgjZuhQWt+oQ4M/ChjkTksX/xrbWugpYnp83gQ36
	 3oPiCwQQDG2vw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab771575040so590281366b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 05:11:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx9DBQ0g21MTqG7UZDfgcDbkQkp5UKecVOxZLbZ8E5A4ZdXPHa/
	hxWo56nO3IkcoNm0ljTKzVJnKSDVNFnCQw44XA873qKbOC9FutpO7tyU9LZ86st3gi0TjfG8KMZ
	O/xZOOynKR8x/vgcL4VKvF4d8Y5c=
X-Google-Smtp-Source: AGHT+IGjD/T/0NLv7H7xeGnPEwQdMOOhVccJF40C/vLuZ7CzqEqxrI3PfWouoKLxrpaSv/uJdwstC1/7x08r/Efu6xc=
X-Received: by 2002:a17:907:9f13:b0:ac3:bd68:24ef with SMTP id
 a640c23a62f3a-ac3cd251258mr749946166b.0.1742559073929; Fri, 21 Mar 2025
 05:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742443383.git.wqu@suse.com> <b0bd320dba85d72a34a4f7e5ba6b6c42caedbe41.1742443383.git.wqu@suse.com>
In-Reply-To: <b0bd320dba85d72a34a4f7e5ba6b6c42caedbe41.1742443383.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Mar 2025 12:10:36 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4jFan6PrC=DuuOA49es_Fs+=8iStatN5JxjBC1YNfWMg@mail.gmail.com>
X-Gm-Features: AQ5f1Jp41HoacYL-WhV9xCP6nZAJIMFKI57ahh8xbE8zJ-HdDrecI7BJDNPdFVQ
Message-ID: <CAL3q7H4jFan6PrC=DuuOA49es_Fs+=8iStatN5JxjBC1YNfWMg@mail.gmail.com>
Subject: Re: [PATCH 2/4] btrfs: cleanup the reserved space inside the loop of btrfs_buffered_write()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:36=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Inside the main loop of btrfs_buffered_write(), if something wrong
> happened, there is a out-of-loop cleanup path to release the reserved
> space.
>
> This behavior saves some code lines, but makes it much harder to read,
> as we need to check release_bytes to make sure when we need to do the
> cleanup.
>
> Extract the cleanup part into a helper, release_reserved_space(), to do
> the cleanup inside the main loop, so that we can move @release_bytes
> inside the loop.
>
> This will make later refactor of the main loop much easier.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 47 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index b7eb1f0164bb..f68846c14ed5 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1074,6 +1074,27 @@ int btrfs_write_check(struct kiocb *iocb, size_t c=
ount)
>         return 0;
>  }
>
> +static void release_space(struct btrfs_inode *inode,
> +                         struct extent_changeset *data_reserved,
> +                         u64 start, u64 len,
> +                         bool only_release_metadata)
> +{
> +       const struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +
> +       if (!len)
> +               return;
> +
> +       if (only_release_metadata) {
> +               btrfs_check_nocow_unlock(inode);
> +               btrfs_delalloc_release_metadata(inode, len, true);
> +       } else {
> +               btrfs_delalloc_release_space(inode,
> +                               data_reserved,
> +                               round_down(start, fs_info->sectorsize),
> +                               len, true);
> +       }
> +}
> +
>  ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
>  {
>         struct file *file =3D iocb->ki_filp;
> @@ -1081,7 +1102,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>         struct inode *inode =3D file_inode(file);
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>         struct extent_changeset *data_reserved =3D NULL;
> -       u64 release_bytes =3D 0;
>         u64 lockstart;
>         u64 lockend;
>         size_t num_written =3D 0;
> @@ -1090,7 +1110,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>         unsigned int ilock_flags =3D 0;
>         const bool nowait =3D (iocb->ki_flags & IOCB_NOWAIT);
>         unsigned int bdp_flags =3D (nowait ? BDP_ASYNC : 0);
> -       bool only_release_metadata =3D false;
>
>         if (nowait)
>                 ilock_flags |=3D BTRFS_ILOCK_TRY;
> @@ -1125,7 +1144,9 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>                 size_t dirty_sectors;
>                 size_t num_sectors;
>                 struct folio *folio =3D NULL;
> +               u64 release_bytes =3D 0;

We don't actually need to initialize this anymore.

>                 int extents_locked;
> +               bool only_release_metadata =3D false;
>
>                 /*
>                  * Fault pages before locking them in prepare_one_folio()
> @@ -1136,7 +1157,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>                         break;
>                 }
>
> -               only_release_metadata =3D false;
>                 sector_offset =3D pos & (fs_info->sectorsize - 1);
>
>                 extent_changeset_release(data_reserved);
> @@ -1191,6 +1211,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>                 ret =3D balance_dirty_pages_ratelimited_flags(inode->i_ma=
pping, bdp_flags);
>                 if (ret) {
>                         btrfs_delalloc_release_extents(BTRFS_I(inode), re=
serve_bytes);
> +                       release_space(BTRFS_I(inode), data_reserved,
> +                                     pos, release_bytes, only_release_me=
tadata);
>                         break;
>                 }
>
> @@ -1198,6 +1220,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>                 if (ret) {
>                         btrfs_delalloc_release_extents(BTRFS_I(inode),
>                                                        reserve_bytes);
> +                       release_space(BTRFS_I(inode), data_reserved,
> +                                     pos, release_bytes, only_release_me=
tadata);
>                         break;
>                 }
>
> @@ -1210,6 +1234,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>
>                         btrfs_delalloc_release_extents(BTRFS_I(inode),
>                                                        reserve_bytes);
> +                       release_space(BTRFS_I(inode), data_reserved,
> +                                     pos, release_bytes, only_release_me=
tadata);
>                         ret =3D extents_locked;
>                         break;
>                 }
> @@ -1277,6 +1303,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>                 btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_by=
tes);
>                 if (ret) {
>                         btrfs_drop_folio(fs_info, folio, pos, copied);
> +                       release_space(BTRFS_I(inode), data_reserved,
> +                                     pos, release_bytes, only_release_me=
tadata);
>                         break;
>                 }

After this, we also don't need to set 'release_bytes' to 0 anymore either.

Anyway, these are small things, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> @@ -1292,19 +1320,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, s=
truct iov_iter *i)
>                 num_written +=3D copied;
>         }
>
> -       if (release_bytes) {
> -               if (only_release_metadata) {
> -                       btrfs_check_nocow_unlock(BTRFS_I(inode));
> -                       btrfs_delalloc_release_metadata(BTRFS_I(inode),
> -                                       release_bytes, true);
> -               } else {
> -                       btrfs_delalloc_release_space(BTRFS_I(inode),
> -                                       data_reserved,
> -                                       round_down(pos, fs_info->sectorsi=
ze),
> -                                       release_bytes, true);
> -               }
> -       }
> -
>         extent_changeset_free(data_reserved);
>         if (num_written > 0) {
>                 pagecache_isize_extended(inode, old_isize, iocb->ki_pos);
> --
> 2.49.0
>
>

