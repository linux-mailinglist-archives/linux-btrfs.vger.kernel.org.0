Return-Path: <linux-btrfs+bounces-10905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2757DA09786
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E877A46E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96566213220;
	Fri, 10 Jan 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJS+21AV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF1213E7E
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526582; cv=none; b=RnpfCPC/X8pbP/Bz+8sJXXWe8Kny7cvhr1ZHNnNgDEA8Zoktf0r61WnHjM+FURTMWTJT4Q+GpjwdJOTNA4h/3rt7/Pz3C/L+LuTHUeEu6PED0/XqXlNcRsa4+xcV1N0RBnw8pl+g0GIopdC1o85Vr112y6i+4/gFWoETevHSqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526582; c=relaxed/simple;
	bh=KlKLvS+iWOebV9dOvq8DwiR0D1hGd6zLZ0S/qIEQcFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoZ9Zn2lPwz4xvV4tHH6Ht7GPQ7MWim9uHy9Ssxz3ed4F2Q9FwK9nXMITYPGNEbfGJTV3F5xk/CNRcA18Jof8FmlCGTSZdhOH/+xYpkC9qz/sC3gEVAjYKjiB+TQ7N+Mr1MRcKWKAPREZOAzNH3EwVP6qcATg/kRD39xfr1IJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJS+21AV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363A3C4CEE0
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526582;
	bh=KlKLvS+iWOebV9dOvq8DwiR0D1hGd6zLZ0S/qIEQcFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KJS+21AVcmFP5Q6VZ08eVIqsU/vIRdWi0b2WVgiTYQOCnxalEhYrk+Fi2Eu8WMwLz
	 fwB/f7C4+GRhDqTbQVDLI7CoIceddY4UANZkZbPs5Vm3nJDM2GVhblxXrWs/zvDPWH
	 9m6r/P7C9YfhD3Yx7sfIITT9FILO4MaMNIwCY1vPTQVlwaxAl+FvKYPl4zvycpI1/C
	 AlfL44R3WmAUCSejPMBASQtKlimE964gMaaX6SK/+5UMU3b9YbhpjYjNvK+cmMwXQs
	 HOJDG51Zqki9ZZ8NvETV1L1RFy9LBh1GmpWgUPXb86hdPLF8kteWigLvQdYGI0v1bp
	 8zsWTIAJmRyCA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso436767766b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 08:29:42 -0800 (PST)
X-Gm-Message-State: AOJu0YwuNSA9ylxKV9XdKAznB4Sz2jVH8uGay0IB7AELtbNC+6rj5UBK
	jbnuF90AMHHLwAjbsIliFgmL9YbfjljnSwZCzlkEV+UIYhcUg3D++jmFggDXWGyi14NuyNs7Hi6
	wGl6xymTzrnVKE32SakvSw52/AH8=
X-Google-Smtp-Source: AGHT+IGVouxLH1r+vxMkY/bFfqrnUjBwCWCdxVQstl2pYswZdUhkHcA/kIMfGHLN2qzT6ftqzRsO66tnwrzlERZm/4k=
X-Received: by 2002:a17:907:7f24:b0:aaf:123a:f303 with SMTP id
 a640c23a62f3a-ab2abdc5a93mr960454166b.55.1736526580721; Fri, 10 Jan 2025
 08:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736479224.git.wqu@suse.com> <ac9345c0d31fc1b669ccfe436e49883ed998ab07.1736479224.git.wqu@suse.com>
In-Reply-To: <ac9345c0d31fc1b669ccfe436e49883ed998ab07.1736479224.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 10 Jan 2025 16:29:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5DT2FtBCnPTC_SPNyeGyAyNy7O_Q_gqLJOOWoDRcrM9g@mail.gmail.com>
X-Gm-Features: AbW1kvaqpneMoKv5MCqwSnRx8aSM5GD_TSYK6otIb70VAsnMJe2d7Jc3Nv23ZJg
Message-ID: <CAL3q7H5DT2FtBCnPTC_SPNyeGyAyNy7O_Q_gqLJOOWoDRcrM9g@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] btrfs: add extra error messages for delalloc
 range related errors
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 3:32=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> All the error handling bugs I hit so far are all -ENOSPC from either:
>
> - cow_file_range()
> - run_delalloc_nocow()
> - submit_uncompressed_range()
>
> Previously when those functions failed, there is no error message at
> all, making the debugging much harder.
>
> So here we introduce extra error messages for:
>
> - cow_file_range()
> - run_delalloc_nocow()
> - submit_uncompressed_range()
> - writepage_delalloc() when btrfs_run_delalloc_range() failed
> - extent_writepage() when extent_writepage_io() failed
>
> One example of the new debug error messages is the following one:
>
>  run fstests generic/750 at 2024-12-08 12:41:41
>  BTRFS: device fsid 461b25f5-e240-4543-8deb-e7c2bd01a6d3 devid 1 transid =
8 /dev/mapper/test-scratch1 (253:4) scanned by mount (2436600)
>  BTRFS info (device dm-4): first mount of filesystem 461b25f5-e240-4543-8=
deb-e7c2bd01a6d3
>  BTRFS info (device dm-4): using crc32c (crc32c-arm64) checksum algorithm
>  BTRFS info (device dm-4): forcing free space tree for sector size 4096 w=
ith page size 65536
>  BTRFS info (device dm-4): using free-space-tree
>  BTRFS warning (device dm-4): read-write for sector size 4096 with page s=
ize 65536 is experimental
>  BTRFS info (device dm-4): checking UUID tree
>  BTRFS error (device dm-4): cow_file_range failed, root=3D363 inode=3D412=
 start=3D503808 len=3D98304: -28
>  BTRFS error (device dm-4): run_delalloc_nocow failed, root=3D363 inode=
=3D412 start=3D503808 len=3D98304: -28
>  BTRFS error (device dm-4): failed to run delalloc range, root=3D363 ino=
=3D412 folio=3D458752 submit_bitmap=3D11-15 start=3D503808 len=3D98304: -28
>
> Which shows an error from cow_file_range() which is called inside a
> nocow write attempt, along with the extra bitmap from
> writepage_delalloc().
>
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 16 ++++++++++++++++
>  fs/btrfs/inode.c     | 14 +++++++++++++-
>  fs/btrfs/subpage.c   |  3 ++-
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 54081b1783fc..615f03fb5d97 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1263,6 +1263,15 @@ static noinline_for_stack int writepage_delalloc(s=
truct btrfs_inode *inode,
>                                                        wbc);
>                         if (ret >=3D 0)
>                                 last_finished_delalloc_end =3D found_star=
t + found_len;
> +                       if (unlikely(ret < 0))
> +                               btrfs_err_rl(fs_info,
> +"failed to run delalloc range, root=3D%lld ino=3D%llu folio=3D%llu submi=
t_bitmap=3D%*pbl start=3D%llu len=3D%u: %d",
> +                                            inode->root->root_key.object=
id,

You can use btrfs_root_id(), it's shorter and it's what we use everywhere e=
lse.

> +                                            btrfs_ino(inode),
> +                                            folio_pos(folio),
> +                                            fs_info->sectors_per_page,
> +                                            &bio_ctrl->submit_bitmap,
> +                                            found_start, found_len, ret)=
;
>                 } else {
>                         /*
>                          * We've hit an error during previous delalloc ra=
nge,
> @@ -1561,6 +1570,13 @@ static int extent_writepage(struct folio *folio, s=
truct btrfs_bio_ctrl *bio_ctrl
>                                   PAGE_SIZE, bio_ctrl, i_size);
>         if (ret =3D=3D 1)
>                 return 0;
> +       if (ret < 0)
> +               btrfs_err_rl(fs_info,
> +"failed to submit blocks, root=3D%lld inode=3D%llu folio=3D%llu submit_b=
itmap=3D%*pbl: %d",
> +                            BTRFS_I(inode)->root->root_key.objectid,

Same here.

> +                            btrfs_ino(BTRFS_I(inode)),
> +                            folio_pos(folio), fs_info->sectors_per_page,
> +                            &bio_ctrl->submit_bitmap, ret);
>
>         bio_ctrl->wbc->nr_to_write--;
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a450fc080ca3..c8145a588f45 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1134,6 +1134,10 @@ static void submit_uncompressed_range(struct btrfs=
_inode *inode,
>                 if (locked_folio)
>                         btrfs_folio_end_lock(inode->root->fs_info, locked=
_folio,
>                                              start, async_extent->ram_siz=
e);
> +               btrfs_err_rl(inode->root->fs_info,
> +               "%s failed, root=3D%llu inode=3D%llu start=3D%llu len=3D%=
llu: %d",
> +                            __func__, btrfs_root_id(inode->root),

And here, and below, it's using btrfs_root_id(). So we should be
consistent and use it everywhere.
Thanks.

> +                            btrfs_ino(inode), start, async_extent->ram_s=
ize, ret);
>         }
>  }
>
> @@ -1246,7 +1250,7 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>         free_async_extent_pages(async_extent);
>         if (async_chunk->blkcg_css)
>                 kthread_associate_blkcg(NULL);
> -       btrfs_debug(fs_info,
> +       btrfs_debug_rl(fs_info,
>  "async extent submission failed root=3D%lld inode=3D%llu start=3D%llu le=
n=3D%llu ret=3D%d",
>                     btrfs_root_id(root), btrfs_ino(inode), start,
>                     async_extent->ram_size, ret);
> @@ -1580,6 +1584,10 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>                 btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_siz=
e,
>                                        end - start - cur_alloc_size + 1, =
NULL);
>         }
> +       btrfs_err_rl(fs_info,
> +                    "%s failed, root=3D%llu inode=3D%llu start=3D%llu le=
n=3D%llu: %d",
> +                    __func__, btrfs_root_id(inode->root),
> +                    btrfs_ino(inode), orig_start, end + 1 - orig_start, =
ret);
>         return ret;
>  }
>
> @@ -2327,6 +2335,10 @@ static noinline int run_delalloc_nocow(struct btrf=
s_inode *inode,
>                 btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur=
_offset + 1, NULL);
>         }
>         btrfs_free_path(path);
> +       btrfs_err_rl(fs_info,
> +                    "%s failed, root=3D%llu inode=3D%llu start=3D%llu le=
n=3D%llu: %d",
> +                    __func__, btrfs_root_id(inode->root),
> +                    btrfs_ino(inode), start, end + 1 - start, ret);
>         return ret;
>  }
>
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index d692bc34a3af..7f47bc61389c 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -652,7 +652,7 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, =
folio_clear_checked,
>                                                                         \
>         GET_SUBPAGE_BITMAP(subpage, fs_info, name, &bitmap);            \
>         btrfs_warn(fs_info,                                             \
> -       "dumpping bitmap start=3D%llu len=3D%u folio=3D%llu" #name "_bitm=
ap=3D%*pbl", \
> +       "dumpping bitmap start=3D%llu len=3D%u folio=3D%llu " #name "_bit=
map=3D%*pbl", \
>                    start, len, folio_pos(folio),                        \
>                    fs_info->sectors_per_page, &bitmap);                 \
>  }
> @@ -717,6 +717,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info =
*fs_info,
>         /* Target range should not yet be locked. */
>         if (unlikely(!bitmap_test_range_all_zero(subpage->bitmaps, start_=
bit, nbits))) {
>                 subpage_dump_bitmap(fs_info, folio, locked, start, len);
> +               btrfs_warn(fs_info, "nr_locked=3D%u\n", atomic_read(&subp=
age->nr_locked));
>                 ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start=
_bit, nbits));
>         }
>         bitmap_set(subpage->bitmaps, start_bit, nbits);
> --
> 2.47.1
>
>

