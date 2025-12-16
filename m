Return-Path: <linux-btrfs+bounces-19791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE23CC4182
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF2F730EB67D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3A835BDDE;
	Tue, 16 Dec 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy1rP0u9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87835B145
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899390; cv=none; b=rJjvE10v4MUGJWTWepc8RfCg3OLHbdkC79IePcciAmteFUiBN3lhp/DOQyFseH2+xhAO118uC+8dbA6slgIC9iNp3Fc0XhoPwJQtppFKQkqLGAkuFMfkFxz2bi1i4h7f+AmDDtuPwySub90pPecD2rHnhyfTVGVzjXYq8G50bVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899390; c=relaxed/simple;
	bh=s08UAP8wzh3kwOeHxiEGtjDfN9WoLYy7XhQJdPk7c4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0ZR45TTWr4yslaWXwMcwjUU7ArlcwpoFSB7VxigvPDPwetXgMMcJOUj2J/FR0eJdAVhxtFF6IpHDPN/eGv63ZFBmP90OFUE8BwX+tbOsepnZ6w51FLaS66Cp8cu6AtZ0mQ+ENkw2GWnRhgjmnOcKXX8B5iQ0M2d7I3dOItzDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy1rP0u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C112C113D0
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765899390;
	bh=s08UAP8wzh3kwOeHxiEGtjDfN9WoLYy7XhQJdPk7c4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gy1rP0u9VaaLerSmp+oX5ZFGMZb9R8mQlOUIXQuNn3cTW/0BwC89WaOlRhmiMYRbw
	 FTo0qFAlj/rcTeBYYxWMZClxxh/JT8Pk58cDRGiqhqESfThVnPWOgf7AfEHYEJaU56
	 c8erKm555V703zJPZMAv2wGwYfVHOScAzk1OBvzP12Nn1qQVdT7l+kXQQYIVA1qvaU
	 EA7HYOzCwH+JckSFAIQVcfNDbsALbAI5+vZvO5+Kb77kF+MGPQ9mK9sbHdI6IXR/7N
	 5P5Hjy4W50xL0k3zrUYaRtTtvbjq0u6x1u9XydRHdzYcYRRwSYx7I1bzOwYGmSAZJ1
	 81C57HIBKTHYA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79ea617f55so352897766b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 07:36:30 -0800 (PST)
X-Gm-Message-State: AOJu0YzIW0J2wLmIYHNgzmULI5IEdriasFPQ+PiHQWM8mtbG4mStA3EF
	q3npHJylrxmvonTXGi4LtdVieMFhzMksMT3ok+FkxNpW0GbouxoT1lV2DrGFaLxh0oPOZZ2aVqx
	6eOcN/5qUGfOdzS4TQwUIDlXY28t9JI4=
X-Google-Smtp-Source: AGHT+IGcwlVsQwOED7axdXd+76GL0DNNjL/UjC26giICb5xoguVAM4oz3jyvf2+eMxHU8V0nxRBmQSlQoCqbBnVwqKY=
X-Received: by 2002:a17:907:6e90:b0:b7a:1be1:86e8 with SMTP id
 a640c23a62f3a-b7d23b8f5bdmr1284001466b.64.1765899388783; Tue, 16 Dec 2025
 07:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169dd70fb9c36f34aa32cc0894b13c981d9edc83.1765842002.git.wqu@suse.com>
In-Reply-To: <169dd70fb9c36f34aa32cc0894b13c981d9edc83.1765842002.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Dec 2025 15:35:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H54oK0nuo=O=s9Kmn2orwGO-MHJjvKvME2bLxqWZQVskA@mail.gmail.com>
X-Gm-Features: AQt7F2okeX1JnTHGj0Z-EaV5FqgG5zr62jbciSFBMAmoo2vIGiHMKFn6RpFrCbU
Message-ID: <CAL3q7H54oK0nuo=O=s9Kmn2orwGO-MHJjvKvME2bLxqWZQVskA@mail.gmail.com>
Subject: Re: [PATCH v4] btrfs: add an ASSERT() to catch ordered extents
 missing checksums
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 11:43=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Inspired by recent bug fix like 18de34daa7c6 ("btrfs: truncate ordered
> extent when skipping writeback past i_size"), and the patch "btrfs: fix
> beyond-EOF write handling", if we can catch ordered extents missing
> checksums, the above bugs will be caught much easier.
>
> Introduce the following extra checks for an ordered extent at
> btrfs_finish_one_ordered(), before inserting an file extent item:
>
> - Skip data reloc inodes first
>   A data reloc inode represents a block group during relocation, which
>   can have ranges that have checksums but some without.
>   So we need to skip them to avoid false alerts.
>
> - NODATACOW ordered extents, NODATASUM inodes must have no checksum
>   NODATACOW implies NODATASUM, and it's pretty obvious that NODATASUM
>   inodes should not have ordered extents with checksums.
>
> - Compressed file extents must have checksums covering the on-disk range
>   Even if a compressed file extents is truncated, the checksums are
>   calculated using the on-disk compressed extent, thus the checksums must
>   cover the whole on-disk compressed extent.
>
> - Truncated regular file extents must have checksum for the truncated
>   length
>
> - The remaining regular file extents must have checksums for the whole
>   length
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
> Changelog:
> v4:
> - Rewords about the checksum problems
>   Instead of "incorrect" checksums, use "missing" checksums to reduce
>   confusion
>
> - Constify the ordered extent parameters
>
> - Rename involved functions to use "ordered_extent_" prefix
>
> v3:
> - Fix a compiler warning when CONFIG_BTRFS_ASSERT is not selected
>   By hiding the oe_csum_bytes() and the main part of assert_oe_csums()
>   behind that config.
>
> v2:
> - Updated to check all possible combinations
>   Previously version can only detect the OEs in patch "btrfs: fix
>   beyond-EOF write handling" where the OE has no csum at all, but can
>   not detect OEs that has partial csums.
> ---
>  fs/btrfs/inode.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 461725c8ccd7..3df8f174d32c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3090,6 +3090,68 @@ static int insert_ordered_extent_file_extent(struc=
t btrfs_trans_handle *trans,
>                                            update_inode_bytes, oe->qgroup=
_rsv);
>  }
>
> +#ifdef CONFIG_BTRFS_ASSERT
> +static u64 ordered_extent_csum_bytes(const struct btrfs_ordered_extent *=
oe)
> +{
> +       struct btrfs_ordered_sum *sum;
> +       u64 ret =3D 0;
> +
> +       list_for_each_entry(sum, &oe->list, list)
> +               ret +=3D sum->len;
> +       return ret;
> +}
> +#endif
> +
> +#define ASSERT_ORDERED_EXTENT(cond, oe)                        \
> +       ASSERT(cond,                                    \
> +"root=3D%lld ino=3D%llu file_pos=3D%llu num_bytes=3D%llu ram_bytes=3D%ll=
u truncated_len=3D%lld csum_bytes=3D%llu disk_bytenr=3D%llu disk_num_bytes=
=3D%llu flags=3D0x%lx", \
> +              btrfs_root_id((oe)->inode->root),        \
> +              btrfs_ino((oe)->inode),                  \
> +              (oe)->file_offset, (oe)->num_bytes,      \
> +              (oe)->ram_bytes, (oe)->truncated_len,    \
> +              ordered_extent_csum_bytes(oe),           \
> +              (oe)->disk_bytenr, (oe)->disk_num_bytes, \
> +              (oe)->flags);
> +
> +static void assert_ordered_extent_csums(const struct btrfs_ordered_exten=
t *oe)
> +{
> +#ifdef CONFIG_BTRFS_ASSERT
> +       struct btrfs_inode *inode =3D oe->inode;
> +       const u64 csum_bytes =3D ordered_extent_csum_bytes(oe);
> +
> +       /*
> +        * Skip data reloc inodes. They are for relocation and they
> +        * can have ranges with csum and ranges without.
> +        */
> +       if (btrfs_is_data_reloc_root(inode->root))
> +               return;
> +
> +       if (test_bit(BTRFS_ORDERED_NOCOW, &oe->flags) ||
> +           inode->flags & BTRFS_INODE_NODATASUM) {
> +               ASSERT_ORDERED_EXTENT(csum_bytes =3D=3D 0, oe);
> +               return;
> +       }
> +
> +       /* For compressed OE, csums must cover the on-disk range. */
> +       if (test_bit(BTRFS_ORDERED_COMPRESSED, &oe->flags)) {
> +               ASSERT_ORDERED_EXTENT(oe->disk_num_bytes =3D=3D csum_byte=
s, oe);
> +               return;
> +       }
> +
> +       /* For truncated uncompressed OE, the csums must cover the trunca=
ted length. */
> +       if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags)) {
> +               ASSERT_ORDERED_EXTENT(oe->truncated_len =3D=3D csum_bytes=
, oe);
> +               return;
> +       }
> +
> +       /*
> +        * The remaining case is untruncated regular extents.
> +        * The csums must cover the whole range.
> +        */
> +       ASSERT_ORDERED_EXTENT(oe->num_bytes =3D=3D csum_bytes, oe);
> +#endif
> +}
> +
>  /*
>   * As ordered data IO finishes, this gets called so we can finish
>   * an ordered extent if the range of bytes in the file it covers are
> @@ -3170,6 +3232,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_e=
xtent *ordered_extent)
>
>         trans->block_rsv =3D &inode->block_rsv;
>
> +       assert_ordered_extent_csums(ordered_extent);
> +
>         ret =3D btrfs_insert_raid_extent(trans, ordered_extent);
>         if (unlikely(ret)) {
>                 btrfs_abort_transaction(trans, ret);
> --
> 2.52.0
>
>

