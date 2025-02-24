Return-Path: <linux-btrfs+bounces-11746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F317A4283A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB2D174972
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C079262D06;
	Mon, 24 Feb 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUbuXkfa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76521514CC
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415666; cv=none; b=pN0VXkJ1L4+LDnaFVUiDfN/uOuBl28/tgNOI10HQ1KaOuhjUxB8PcfULkOUGXnDRkjwAYa+DNnbwsPFtlwekxIJfFOBwcFDTmNDbz/V67h76QAt1BAJ/exszuIl6fCaJb5HLyb21lOCWBLPD1qUR1uwoTvH5UVuvRY0BdcpkSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415666; c=relaxed/simple;
	bh=oCN0jhS1B1uXeWaHcdcXkLtBr1NBCXqK9uVGv2FHIkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nq7SSAuoNywJEOpg0mjcNFtT8PKDM8wbnv00brXDxMtDjCFYp4msUvJ56a0W/LMapQo9GIDItAm6POOD6/RzWDMz7CTcop7PaWeR9gA/6ofByxVcMww23W+5r034sxnaTLIBiQglKoQJLeQUvHUgWlPfc2IVPXifPBkXO3FCuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUbuXkfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F8FC4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740415666;
	bh=oCN0jhS1B1uXeWaHcdcXkLtBr1NBCXqK9uVGv2FHIkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eUbuXkfaCPOs9rIyRCmHahgz/NGoJDzUR3aFcSPURwY6O87QzDaFBnJKxmXbM2ejc
	 cIaFE05bdJA72PXdCcslLZulAHxprsw6ThFz0vbufU+QfkOv64QFcPp5FVrpuYYbSR
	 lcNDjR9+D78VR9iyOjVHgkVPPp8rzz/RMgUYMnu9UuTUip8VzR9PnZ6z8/mkR8CCzm
	 eIjbktjK4Cv85cgw9N/x64AXuj2d/V98XhF8/Xl9J/kJqx6hMEfltngDrxQGhmqz+r
	 pjzJIA7FP+xUoPEmxWAk5iket8U95fv34k1vr/iByikDXwyE9tYEodfdcxETvnk1rB
	 2awTH8n6WJG7A==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbda4349e9so668107366b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 08:47:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5EFOmkyThs2d3uwdK4aYA74IlLJTdlr8kbFlx2N9DX6DV5HUsvbyqGIHvdk9MN7hJZcmSqvSkG1m4eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/DtrVCUfLNoeq4AHA8ngVZrNGyh+duHGiQkqsmueQM1Img8k
	wVaViPEo7kTgN0MuY4Hcr6WzhHZAve9lQKXYYORdltTuAQTUQo2RA///QdixTIw2Bk0lVUFlBAX
	M2tYOo9qm4NQqOG10UMMXWvD+Nok=
X-Google-Smtp-Source: AGHT+IFDM6sdWdoWwPSzvxgFPWBnhoH4DJhmLmeXnzrlTohLd+CBEiWJIJPiGvr5tdKHeksj0ezuIZQq09pPg0I4JCo=
X-Received: by 2002:a17:907:d8f:b0:abb:e961:ca32 with SMTP id
 a640c23a62f3a-abc0d9dae22mr1368295966b.21.1740415664478; Mon, 24 Feb 2025
 08:47:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739608189.git.wqu@suse.com> <4e0368b2d4ab74e1a2cef76000ea75cb3198696a.1739608189.git.wqu@suse.com>
 <CAL3q7H5yrvxK5QFeCmfU+_sMmxpFyfcL_W8CALcCPLjkbbJHLQ@mail.gmail.com> <64782982-20d5-41e7-81d0-6960f3b5c0ee@gmx.com>
In-Reply-To: <64782982-20d5-41e7-81d0-6960f3b5c0ee@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 24 Feb 2025 16:47:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6-NWr78xiPT51FwQDrT9vw-O0r3q94BA11pGvR7SzPjQ@mail.gmail.com>
X-Gm-Features: AWEUYZk9sIvegxvMrMk4c7qSeJis97WrJhGj-xaQOtylPAAi5homROtar8VYzuk
Message-ID: <CAL3q7H6-NWr78xiPT51FwQDrT9vw-O0r3q94BA11pGvR7SzPjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] btrfs: fix inline data extent reads which zero out
 the remaining part
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:39=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2025/2/21 23:02, Filipe Manana =E5=86=99=E9=81=93:
> > On Sat, Feb 15, 2025 at 8:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG in DEVEL BRANCH]
> >> This bug itself can only be reproduced with the following out-of-tree
> >> patches:
> >>
> >>    btrfs: allow inline data extents creation if sector size < page siz=
e
> >
> > At least this patch could be part of this patchset no? It seems related=
.
> > It makes it harder to review with unmerged dependencies.
>
> Sure, I can merge all those patches into a much larger series.
>
> >
> >>    btrfs: allow buffered write to skip full page if it's sector aligne=
d
> >>
> >> With those out-of-tree patches, we can hit a data corruption:
> >>
> >>    # mkfs.btrfs -f -s 4k $dev
> >>    # mount $dev $mnt -o compress=3Dzstd
> >>    # xfs_io -f -c "pwrite 0 4k" $mnt/foobar
> >>    # sync
> >>    # echo 3 > /proc/sys/vm/drop_caches
> >>    # xfs_io -f -c" pwrite 8k 4k" $mnt/foobar
> >>    # md5sum $mnt/foobar
> >>    65df683add4707de8200bad14745b9ec
> >>
> >> Meanwhile such workload should result a md5sum of
> >>    277f3840b275c74d01e979ea9d75ac19
> >
> > So this is hard for us human beings to understand - we don't compute
> > checksums in our heads.
> > So something easier:
> >
> > # mkfs.btrfs -f -s 4k $dev
> > # mount $dev $mnt -o compress=3Dzstd
> > # xfs_io -f -c "pwrite -S 0xab 0 4k" $mnt/foobar
> > # sync
> > # echo 3 > /proc/sys/vm/drop_caches
> > # xfs_io -f -c "pwrite -S 0xcd 8k 4k" $mnt/foobar
> > # od -A d -t x1 $mnt/foobar
> >
> > Now display the result of od which is easy to understand and
> > summarises repeated patterns.
> > It should be obvious here that the expected pattern isn't observed,
> > bytes range 0 to 4095 full of 0xab and 8192 to 12K full of 0xcd.
> >
> > See, a lot easier for anyone to understand rather than comparing checks=
ums.
>
> Thanks a lot, will go that reproducer in the commit message.
> >
> >
> >>
> >> [CAUSE]
> >> The first buffered write into range [0, 4k) will result a compressed
> >> inline extent (relies on the patch "btrfs: allow inline data extents
> >> creation if sector size < page size" to create such inline extent):
> >>
> >>          item 6 key (257 EXTENT_DATA 0) itemoff 15823 itemsize 40
> >>                  generation 9 type 0 (inline)
> >>                  inline extent data size 19 ram_bytes 4096 compression=
 3 (zstd)
> >>
> >> Then all page cache is dropped, and we do the new write into range
> >> [8K, 12K)
> >>
> >> With the out-of-tree patch "btrfs: allow buffered write to skip full p=
age if
> >> it's sector aligned", such aligned write won't trigger the full folio
> >> read, so we just dirtied range [8K, 12K), and range [0, 4K) is not
> >> uptodate.
> >
> > And without that out-of-tree patch, do we have any problem?
>
> Fortunately no.
>
> > If that patch creates a problem then perhaps fix it before being
> > merged or at least include it early in this patchset?
>
> I'll put this one before that patch in the merged series.
>
> >
> > See, at least for me it's confusing to have patches saying they fix a
> > problem that happens when some other unmerged patch is applied.
> > It raises the doubt if that other patch should be fixed instead and
> > therefore making this one not needed, or at least if they should be in
> > the same patchset.
>
> But I'm wondering what's the proper way to handle such cases?
>
> Is putting this one before that patch enough?
>
> I really want to express some strong dependency, as if some one
> backported that partial uptodate folio support, it will easily screw up
> a lot of things.

You mean if someone decided to apply that out-of-tree patch into their own
custom built kernel and use it?

If so I don't think they should be doing it, we normally only support code =
that
was merged into Linus' tree.

>
> On the other hand, it's also very hard to explain why this patch itself
> is needed, without mentioning the future behavior change.
>
> Any good suggestions? Especially I'm pretty sure such pattern will
> happen again and again as we're approaching larger data folios support.

I think the pattern only happens because patches for sub-pages block
size keep accumulating without being merged, as you are the only one
doing development in that area.
I don't have a perfect solution for that.

I see you've sent another patchset reordering things and making the
dependency more clear. I'll look into it.

Thanks.


>
> Thanks,
> Qu
>
> >
> > It's not clear here if this patch serves other purposes other than
> > fixing that other out-of-tree patch.
> >
> > The patch itself looks fine, but all these references to other
> > unmerged patches and that they cause problems, make it hard and
> > confusing to review.
> > Sorry, it's just hard to follow these patchsets that depend on other
> > not yet merged patchsets :(
> >
> > Thanks.
> >
> >>
> >> Then md5sum triggered the full folio read, causing us to read the
> >> inlined data extent.
> >>
> >> Then inside function read_inline_extent() and uncomress_inline(), we z=
ero
> >> out all the remaining part of the folio, including the new dirtied ran=
ge
> >> [8K, 12K), leading to the corruption.
> >>
> >> [FIX]
> >> Thankfully the bug is not yet reaching any end users.
> >> For upstream kernel, the [8K, 12K) write itself will trigger the full
> >> folio read before doing any write, thus everything is still fine.
> >>
> >> Furthermore, for the existing btrfs users with sector size < page size
> >> (the most common one is Asahi Linux) with inline data extents created
> >> from x86_64, they are still fine, because two factors are saving us:
> >>
> >> - Inline extents are always at offset 0
> >>
> >> - Folio read always follows the file offset order
> >>
> >> So we always read out the inline extent, zeroing the remaining folio
> >> (which has no contents yet), then read the next sector, copying the
> >> correct content to the zeroed out part.
> >> No end users are affected thankfully.
> >>
> >> The fix is to make both read_inline_extent() and uncomress_inline() to
> >> only zero out the sector, not the whole page.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/inode.c | 15 +++++++++------
> >>   1 file changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index 2620c554917f..ea60123a28a2 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -6780,6 +6780,7 @@ static noinline int uncompress_inline(struct btr=
fs_path *path,
> >>   {
> >>          int ret;
> >>          struct extent_buffer *leaf =3D path->nodes[0];
> >> +       const u32 sectorsize =3D leaf->fs_info->sectorsize;
> >>          char *tmp;
> >>          size_t max_size;
> >>          unsigned long inline_size;
> >> @@ -6808,17 +6809,19 @@ static noinline int uncompress_inline(struct b=
trfs_path *path,
> >>           * cover that region here.
> >>           */
> >>
> >> -       if (max_size < PAGE_SIZE)
> >> -               folio_zero_range(folio, max_size, PAGE_SIZE - max_size=
);
> >> +       if (max_size < sectorsize)
> >> +               folio_zero_range(folio, max_size, sectorsize - max_siz=
e);
> >>          kfree(tmp);
> >>          return ret;
> >>   }
> >>
> >> -static int read_inline_extent(struct btrfs_path *path, struct folio *=
folio)
> >> +static int read_inline_extent(struct btrfs_fs_info *fs_info,
> >> +                             struct btrfs_path *path, struct folio *f=
olio)
> >>   {
> >>          struct btrfs_file_extent_item *fi;
> >>          void *kaddr;
> >>          size_t copy_size;
> >> +       const u32 sectorsize =3D fs_info->sectorsize;
> >>
> >>          if (!folio || folio_test_uptodate(folio))
> >>                  return 0;
> >> @@ -6836,8 +6839,8 @@ static int read_inline_extent(struct btrfs_path =
*path, struct folio *folio)
> >>          read_extent_buffer(path->nodes[0], kaddr,
> >>                             btrfs_file_extent_inline_start(fi), copy_s=
ize);
> >>          kunmap_local(kaddr);
> >> -       if (copy_size < PAGE_SIZE)
> >> -               folio_zero_range(folio, copy_size, PAGE_SIZE - copy_si=
ze);
> >> +       if (copy_size < sectorsize)
> >> +               folio_zero_range(folio, copy_size, sectorsize - copy_s=
ize);
> >>          return 0;
> >>   }
> >>
> >> @@ -7012,7 +7015,7 @@ struct extent_map *btrfs_get_extent(struct btrfs=
_inode *inode,
> >>                  ASSERT(em->disk_bytenr =3D=3D EXTENT_MAP_INLINE);
> >>                  ASSERT(em->len =3D=3D fs_info->sectorsize);
> >>
> >> -               ret =3D read_inline_extent(path, folio);
> >> +               ret =3D read_inline_extent(fs_info, path, folio);
> >>                  if (ret < 0)
> >>                          goto out;
> >>                  goto insert;
> >> --
> >> 2.48.1
> >>
> >>
> >
>

