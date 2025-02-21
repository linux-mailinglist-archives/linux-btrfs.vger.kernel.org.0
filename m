Return-Path: <linux-btrfs+bounces-11696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61DA3F467
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 13:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C645B189F978
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2702320AF8E;
	Fri, 21 Feb 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUwiOpda"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C42046A1
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141159; cv=none; b=IwVb0fG1I4tbJoTe41ioSxwsy4/V0t3ySV1XCc54heW3wKS35zk5bo/M16U/ThahfBB+OqTAbesqVG2IChxzsuYIfQxhBB8VH4v6n/HGe74R6Y/ZBRDipbs74+QwbrPRbRYV3RidKrUv9IllAUghe+5EaBb5fVRMsFCnkapYTVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141159; c=relaxed/simple;
	bh=JhHa34UOytFUEDD5WzJCMPg3qczyqxixlmpdjk4cr7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyA79awYC/3CUchdJnmKIcE0aGx0RGZVjYc87r1S+1/QytBR8lPP5WMHCXeQgZaHkQ0YW9vMgfqQkDm8rYI+qsVd/IAgaY7dYdy50zJFBXwE9vfgQl4fEFWjxB1KgeJFkhN5JR7Aad9BjB5uCx4UCIj0GJXMySOKNUL01+wRw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUwiOpda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996E1C4CEE8
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 12:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740141158;
	bh=JhHa34UOytFUEDD5WzJCMPg3qczyqxixlmpdjk4cr7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rUwiOpdauLkluGfSltOkQrLEpfPH5bCjRfG7DrJ5xZiDP9ebsiJJpmid5Co25JvnE
	 iIfxzudmsEYl/janZFgb9ng4OwusEs3cqmGecCQxjwhN+KSSGWcIzytpjiY4WR+SDP
	 l24Ay+Adrs/LCdAsUUkuw9A0phNsZdAoY7gThk979IBxpoRLrC17/PUka+zfasRG0v
	 jgsmyjj4NSzlyAYlZezFHYCU1xT3JCruxjrXPasAvdk2RbxIC67JQOHPvHc5pMzh7o
	 JhKuh34A+ahAuah9g0lxS2thr4VUCo3NUdPPxcE+6X2Y0gUTyzAE5K2V9j0E7vUGBw
	 HCUn/ki6hHiaA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso317817866b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 04:32:38 -0800 (PST)
X-Gm-Message-State: AOJu0YxiwamupNPToNBkCi79VVRK7RUoz1RIgSqtOz4oICLxnHgOx6E+
	4+zH5n7nlmDKUopnxozS63Q6CwqlmI684+g4vzgkPl8HFzsyppZ3Z370mG6SugucbqCJrRMKJK3
	g/movAZvKoV1JXcGhOA284WCTCuc=
X-Google-Smtp-Source: AGHT+IGSX1lSotOTNHeZONh/pjxLcbjoJRY0ZAtUDnva59SyskvM5RByCwzaB2A2iGsqnXSuT75VijiEGidvdlk9/Fc=
X-Received: by 2002:a17:907:8a91:b0:abb:9a1e:47cb with SMTP id
 a640c23a62f3a-abc09e49525mr279234966b.55.1740141156869; Fri, 21 Feb 2025
 04:32:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739608189.git.wqu@suse.com> <4e0368b2d4ab74e1a2cef76000ea75cb3198696a.1739608189.git.wqu@suse.com>
In-Reply-To: <4e0368b2d4ab74e1a2cef76000ea75cb3198696a.1739608189.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Feb 2025 12:32:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5yrvxK5QFeCmfU+_sMmxpFyfcL_W8CALcCPLjkbbJHLQ@mail.gmail.com>
X-Gm-Features: AWEUYZnIaFpBzdPBIoZKpk9sBfsMRsW0G2iQKOFE7GfkW8DG4dOHyef7mqUwmt4
Message-ID: <CAL3q7H5yrvxK5QFeCmfU+_sMmxpFyfcL_W8CALcCPLjkbbJHLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] btrfs: fix inline data extent reads which zero out
 the remaining part
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 8:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG in DEVEL BRANCH]
> This bug itself can only be reproduced with the following out-of-tree
> patches:
>
>   btrfs: allow inline data extents creation if sector size < page size

At least this patch could be part of this patchset no? It seems related.
It makes it harder to review with unmerged dependencies.

>   btrfs: allow buffered write to skip full page if it's sector aligned
>
> With those out-of-tree patches, we can hit a data corruption:
>
>   # mkfs.btrfs -f -s 4k $dev
>   # mount $dev $mnt -o compress=3Dzstd
>   # xfs_io -f -c "pwrite 0 4k" $mnt/foobar
>   # sync
>   # echo 3 > /proc/sys/vm/drop_caches
>   # xfs_io -f -c" pwrite 8k 4k" $mnt/foobar
>   # md5sum $mnt/foobar
>   65df683add4707de8200bad14745b9ec
>
> Meanwhile such workload should result a md5sum of
>   277f3840b275c74d01e979ea9d75ac19

So this is hard for us human beings to understand - we don't compute
checksums in our heads.
So something easier:

# mkfs.btrfs -f -s 4k $dev
# mount $dev $mnt -o compress=3Dzstd
# xfs_io -f -c "pwrite -S 0xab 0 4k" $mnt/foobar
# sync
# echo 3 > /proc/sys/vm/drop_caches
# xfs_io -f -c "pwrite -S 0xcd 8k 4k" $mnt/foobar
# od -A d -t x1 $mnt/foobar

Now display the result of od which is easy to understand and
summarises repeated patterns.
It should be obvious here that the expected pattern isn't observed,
bytes range 0 to 4095 full of 0xab and 8192 to 12K full of 0xcd.

See, a lot easier for anyone to understand rather than comparing checksums.


>
> [CAUSE]
> The first buffered write into range [0, 4k) will result a compressed
> inline extent (relies on the patch "btrfs: allow inline data extents
> creation if sector size < page size" to create such inline extent):
>
>         item 6 key (257 EXTENT_DATA 0) itemoff 15823 itemsize 40
>                 generation 9 type 0 (inline)
>                 inline extent data size 19 ram_bytes 4096 compression 3 (=
zstd)
>
> Then all page cache is dropped, and we do the new write into range
> [8K, 12K)
>
> With the out-of-tree patch "btrfs: allow buffered write to skip full page=
 if
> it's sector aligned", such aligned write won't trigger the full folio
> read, so we just dirtied range [8K, 12K), and range [0, 4K) is not
> uptodate.

And without that out-of-tree patch, do we have any problem?
If that patch creates a problem then perhaps fix it before being
merged or at least include it early in this patchset?

See, at least for me it's confusing to have patches saying they fix a
problem that happens when some other unmerged patch is applied.
It raises the doubt if that other patch should be fixed instead and
therefore making this one not needed, or at least if they should be in
the same patchset.

It's not clear here if this patch serves other purposes other than
fixing that other out-of-tree patch.

The patch itself looks fine, but all these references to other
unmerged patches and that they cause problems, make it hard and
confusing to review.
Sorry, it's just hard to follow these patchsets that depend on other
not yet merged patchsets :(

Thanks.

>
> Then md5sum triggered the full folio read, causing us to read the
> inlined data extent.
>
> Then inside function read_inline_extent() and uncomress_inline(), we zero
> out all the remaining part of the folio, including the new dirtied range
> [8K, 12K), leading to the corruption.
>
> [FIX]
> Thankfully the bug is not yet reaching any end users.
> For upstream kernel, the [8K, 12K) write itself will trigger the full
> folio read before doing any write, thus everything is still fine.
>
> Furthermore, for the existing btrfs users with sector size < page size
> (the most common one is Asahi Linux) with inline data extents created
> from x86_64, they are still fine, because two factors are saving us:
>
> - Inline extents are always at offset 0
>
> - Folio read always follows the file offset order
>
> So we always read out the inline extent, zeroing the remaining folio
> (which has no contents yet), then read the next sector, copying the
> correct content to the zeroed out part.
> No end users are affected thankfully.
>
> The fix is to make both read_inline_extent() and uncomress_inline() to
> only zero out the sector, not the whole page.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2620c554917f..ea60123a28a2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6780,6 +6780,7 @@ static noinline int uncompress_inline(struct btrfs_=
path *path,
>  {
>         int ret;
>         struct extent_buffer *leaf =3D path->nodes[0];
> +       const u32 sectorsize =3D leaf->fs_info->sectorsize;
>         char *tmp;
>         size_t max_size;
>         unsigned long inline_size;
> @@ -6808,17 +6809,19 @@ static noinline int uncompress_inline(struct btrf=
s_path *path,
>          * cover that region here.
>          */
>
> -       if (max_size < PAGE_SIZE)
> -               folio_zero_range(folio, max_size, PAGE_SIZE - max_size);
> +       if (max_size < sectorsize)
> +               folio_zero_range(folio, max_size, sectorsize - max_size);
>         kfree(tmp);
>         return ret;
>  }
>
> -static int read_inline_extent(struct btrfs_path *path, struct folio *fol=
io)
> +static int read_inline_extent(struct btrfs_fs_info *fs_info,
> +                             struct btrfs_path *path, struct folio *foli=
o)
>  {
>         struct btrfs_file_extent_item *fi;
>         void *kaddr;
>         size_t copy_size;
> +       const u32 sectorsize =3D fs_info->sectorsize;
>
>         if (!folio || folio_test_uptodate(folio))
>                 return 0;
> @@ -6836,8 +6839,8 @@ static int read_inline_extent(struct btrfs_path *pa=
th, struct folio *folio)
>         read_extent_buffer(path->nodes[0], kaddr,
>                            btrfs_file_extent_inline_start(fi), copy_size)=
;
>         kunmap_local(kaddr);
> -       if (copy_size < PAGE_SIZE)
> -               folio_zero_range(folio, copy_size, PAGE_SIZE - copy_size)=
;
> +       if (copy_size < sectorsize)
> +               folio_zero_range(folio, copy_size, sectorsize - copy_size=
);
>         return 0;
>  }
>
> @@ -7012,7 +7015,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>                 ASSERT(em->disk_bytenr =3D=3D EXTENT_MAP_INLINE);
>                 ASSERT(em->len =3D=3D fs_info->sectorsize);
>
> -               ret =3D read_inline_extent(path, folio);
> +               ret =3D read_inline_extent(fs_info, path, folio);
>                 if (ret < 0)
>                         goto out;
>                 goto insert;
> --
> 2.48.1
>
>

