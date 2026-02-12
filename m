Return-Path: <linux-btrfs+bounces-21648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB4EBR8Ajmm0+AAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21648-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 17:30:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A11312F6F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 17:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93ECB306A191
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7701235B624;
	Thu, 12 Feb 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KneLogqA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677D2F6199
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913701; cv=none; b=nMfXvpaV9xvvjCgT59TeW/lnq7Io0KtTUZQyYdWmVPhM/0X2byqwGnd9fykgTHPAk7FkP+f1f9T3Akz92pUiEzs/C5qPuTPA2H3/yUuiANkEnOtNnKIM5mmpPggBvgiA6nmMrdMgXMPdpeNp9r7Bh5LQPCNED1Q4+7oucBZqNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913701; c=relaxed/simple;
	bh=aFR/WsKOE/u4POp1wV78FrhNGANE4UomNO9Xt23PcQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFOiCQTVE5HTh+tMTxpTbcjw7wsWPF/ffAzCJr3xK+zqxUTZo9ytKqPXBLKMbL4kpfoaOlkF6uGPdONFXlIfZT+Qe7fNKz1jspNuD4RoCPM1mfrNAO6oyxGHuU3O5U+3efAKiUJeq6w/pmNPYDlFVKNmmSShZ0t1O2R8IVF43Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KneLogqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5963EC16AAE
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770913701;
	bh=aFR/WsKOE/u4POp1wV78FrhNGANE4UomNO9Xt23PcQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KneLogqAv2n/qmTsNQG3oaDBZ0Qp2EcRAcoCJTSRrelGnY7SjXPyyx07VWmgJcN1Y
	 OYvxukdpOBPAff8Ahi9wQF/cgXtRBM0aBdhUsX1GrY1kYEhKbbzU/bUjSBv0w3X8Fe
	 PP6Udyqas4yWv/LWL+w4Y7kJh3o4x68KFysZFYNK9YJ4sfK9hFg+pI8Dqel6LqiZwa
	 7CdLpsq8w+8BzeO7DK8vpF3VHax1NtltzKAylWp2slbwMppvpXBwho9zggBELgfea5
	 /4RwmhhFUFkUfVY/RDUPk+0vElmlR0Kg7Y5ZwJUNZzDRt8dqHiEXxZmicvao35GKwt
	 mwJVzD2PaG0aA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so11306700a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 08:28:21 -0800 (PST)
X-Gm-Message-State: AOJu0YxXFrw8FtfuMtfYmNBFQNeGkYRBhQZehyknec+jj4ncLDnDog5J
	iy//NaCI9OWlnb3ejcYOVt9Uh+PwnPPglHgZntblh1Kda9ftlSH86WpxmV+nJezsCMqaHEmvv1D
	BzfdB39SK3azDeHDUbskAOVOhFgu1Uyo=
X-Received: by 2002:a17:907:3f88:b0:b88:4efd:6cbf with SMTP id
 a640c23a62f3a-b8f8f3d8813mr228906566b.12.1770913699807; Thu, 12 Feb 2026
 08:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd0abcd6792c8a155af818bbe88d37d9957f4465.1770887628.git.wqu@suse.com>
In-Reply-To: <cd0abcd6792c8a155af818bbe88d37d9957f4465.1770887628.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 12 Feb 2026 16:27:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4y3reiYwXZPTXYyPqKOjxOP_SVHGPQKH7q3V=LmmBUmg@mail.gmail.com>
X-Gm-Features: AZwV_Qiy_Wj8mAmCWo3Isb9akI5iRUek7XqXBi_yRi_L4dtitpT30aY6EFz6XdM
Message-ID: <CAL3q7H4y3reiYwXZPTXYyPqKOjxOP_SVHGPQKH7q3V=LmmBUmg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove folio parameter from ordered io related functions
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21648-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8A11312F6F8
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 9:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Both functions btrfs_finish_ordered_extent() and
> btrfs_mark_ordered_io_finished() are accepting an optional folio
> parameter.
>
> That @folio is passed into can_finish_ordered_extent(), which later will
> test and clear the ordered flag for the involved range.
>
> However I do not think there is any other call site that can clear
> ordered flags of an page cache folio and can affect
> can_finish_ordered_extent().
>
> There are limited *_clear_ordered() callers out of
> can_finish_ordered_extent() function:
>
> - btrfs_migrate_folio()
>   This is completely unrelated, it's just migrating the ordered flag to
>   the new folio.
>
> - btrfs_cleanup_ordered_extents()
>   We manually clean the ordered flags of all involved folios, then call
>   btrfs_mark_ordered_io_finished() without a @folio parameter.
>   So it doesn't need and didn't pass a @folio parameter in the first
>   place.
>
> - btrfs_writepage_fixup_worker()
>   This function is going to be removed soon, and we should not hit that
>   function anymore.

I still hit that sporadically with fstests, (generic/475 and
generic/648 at least).

>
> - btrfs_invalidate_folio()
>   This is the real call site we need to bother.

bother -> bother with

Otherwise it looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
>   If we already have a bio running, btrfs_finish_ordered_extent() in
>   end_bbio_data_write() will be executed first, as
>   btrfs_invalidate_folio() will wait for the writeback to finish.
>
>   Thus if there is a running bio, it will not see the range has
>   ordered flags, and just skip to the next range.
>
>   If there is no bio running, meaning the ordered extent is created but
>   the folio is not yet submitted.
>
>   In that case btrfs_invalidate_folio() will manually clear the folio
>   ordered range, but then manually finish the ordered extent with
>   btrfs_dec_test_ordered_pending() without bothering the folio ordered
>   flags.
>
>   Meaning if the OE range with folio ordered flags will be finished
>   manually without the need to call can_finish_ordered_extent().
>
> This means all can_finish_ordered_extent() call sites should get a range
> that has folio ordered flag set, thus the old "return false" branch
> should never be triggered.
>
> Now we can:
>
> - Remove the @folio parameter from involved functions
>   * btrfs_mark_ordered_io_finished()
>   * btrfs_finish_ordered_extent()
>
>   For call sites passing a @folio into those functions, let them
>   manually clear the ordered flag of involved folios.
>
> - Move btrfs_finish_ordered_extent() out of the loop in
>   end_bbio_data_write()
>
>   We only need to call btrfs_finish_ordered_extent() once per bbio,
>   not per folio.
>
> - Add an ASSERT() to make sure all folio ranges have ordered flags
>   It's only for end_bbio_data_write().
>
>   And we already have enough safe nets to catch over-accounting of ordere=
d
>   extents.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> But I still appreciate any extra eyes on the call site analyze.
> ---
>  fs/btrfs/compression.c  |  2 +-
>  fs/btrfs/direct-io.c    |  9 ++++-----
>  fs/btrfs/extent_io.c    | 23 ++++++++++++++---------
>  fs/btrfs/inode.c        |  6 ++++--
>  fs/btrfs/ordered-data.c | 29 +++++------------------------
>  fs/btrfs/ordered-data.h |  6 ++----
>  6 files changed, 30 insertions(+), 45 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 1e7174ad32e2..1938d33ab57a 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -292,7 +292,7 @@ static void end_bbio_compressed_write(struct btrfs_bi=
o *bbio)
>         struct compressed_bio *cb =3D to_compressed_bio(bbio);
>         struct folio_iter fi;
>
> -       btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, cb=
->len,
> +       btrfs_finish_ordered_extent(cb->bbio.ordered, cb->start, cb->len,
>                                     cb->bbio.bio.bi_status =3D=3D BLK_STS=
_OK);
>
>         if (cb->writeback)
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 9a63200d7a53..837306254f73 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -625,7 +625,7 @@ static int btrfs_dio_iomap_end(struct inode *inode, l=
off_t pos, loff_t length,
>                 pos +=3D submitted;
>                 length -=3D submitted;
>                 if (write)
> -                       btrfs_finish_ordered_extent(dio_data->ordered, NU=
LL,
> +                       btrfs_finish_ordered_extent(dio_data->ordered,
>                                                     pos, length, false);
>                 else
>                         btrfs_unlock_dio_extent(&BTRFS_I(inode)->io_tree,=
 pos,
> @@ -657,9 +657,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
>         }
>
>         if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> -               btrfs_finish_ordered_extent(bbio->ordered, NULL,
> -                                           dip->file_offset, dip->bytes,
> -                                           !bio->bi_status);
> +               btrfs_finish_ordered_extent(bbio->ordered, dip->file_offs=
et,
> +                                           dip->bytes, !bio->bi_status);
>         } else {
>                 btrfs_unlock_dio_extent(&inode->io_tree, dip->file_offset=
,
>                                         dip->file_offset + dip->bytes - 1=
, NULL);
> @@ -735,7 +734,7 @@ static void btrfs_dio_submit_io(const struct iomap_it=
er *iter, struct bio *bio,
>
>                 ret =3D btrfs_extract_ordered_extent(bbio, dio_data->orde=
red);
>                 if (ret) {
> -                       btrfs_finish_ordered_extent(dio_data->ordered, NU=
LL,
> +                       btrfs_finish_ordered_extent(dio_data->ordered,
>                                                     file_offset, dip->byt=
es,
>                                                     !ret);
>                         bio->bi_status =3D errno_to_blk_status(ret);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 11faecb66109..8914eda1c28f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -521,6 +521,7 @@ static void end_bbio_data_write(struct btrfs_bio *bbi=
o)
>         int error =3D blk_status_to_errno(bio->bi_status);
>         struct folio_iter fi;
>         const u32 sectorsize =3D fs_info->sectorsize;
> +       u32 bio_size =3D 0;
>
>         ASSERT(!bio_flagged(bio, BIO_CLONED));
>         bio_for_each_folio_all(fi, bio) {
> @@ -528,6 +529,7 @@ static void end_bbio_data_write(struct btrfs_bio *bbi=
o)
>                 u64 start =3D folio_pos(folio) + fi.offset;
>                 u32 len =3D fi.length;
>
> +               bio_size +=3D len;
>                 /* Our read/write should always be sector aligned. */
>                 if (!IS_ALIGNED(fi.offset, sectorsize))
>                         btrfs_err(fs_info,
> @@ -538,13 +540,15 @@ static void end_bbio_data_write(struct btrfs_bio *b=
bio)
>                 "incomplete page write with offset %zu and length %zu",
>                                    fi.offset, fi.length);
>
> -               btrfs_finish_ordered_extent(bbio->ordered, folio, start, =
len,
> -                                           !error);
>                 if (error)
>                         mapping_set_error(folio->mapping, error);
> +
> +               ASSERT(btrfs_folio_test_ordered(fs_info, folio, start, le=
n));
> +               btrfs_folio_clear_ordered(fs_info, folio, start, len);
>                 btrfs_folio_clear_writeback(fs_info, folio, start, len);
>         }
>
> +       btrfs_finish_ordered_extent(bbio->ordered, bbio->file_offset, bio=
_size, !error);
>         bio_put(bio);
>  }
>
> @@ -1577,7 +1581,8 @@ static noinline_for_stack int writepage_delalloc(st=
ruct btrfs_inode *inode,
>                         u64 start =3D page_start + (start_bit << fs_info-=
>sectorsize_bits);
>                         u32 len =3D (end_bit - start_bit) << fs_info->sec=
torsize_bits;
>
> -                       btrfs_mark_ordered_io_finished(inode, folio, star=
t, len, false);
> +                       btrfs_folio_clear_ordered(fs_info, folio, start, =
len);
> +                       btrfs_mark_ordered_io_finished(inode, start, len,=
 false);
>                 }
>                 return ret;
>         }
> @@ -1653,6 +1658,7 @@ static int submit_one_sector(struct btrfs_inode *in=
ode,
>                  * ordered extent.
>                  */
>                 btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsi=
ze);
> +               btrfs_folio_clear_ordered(fs_info, folio, filepos, sector=
size);
>                 btrfs_folio_set_writeback(fs_info, folio, filepos, sector=
size);
>                 btrfs_folio_clear_writeback(fs_info, folio, filepos, sect=
orsize);
>
> @@ -1660,8 +1666,8 @@ static int submit_one_sector(struct btrfs_inode *in=
ode,
>                  * Since there is no bio submitted to finish the ordered
>                  * extent, we have to manually finish this sector.
>                  */
> -               btrfs_mark_ordered_io_finished(inode, folio, filepos,
> -                                              fs_info->sectorsize, false=
);
> +               btrfs_mark_ordered_io_finished(inode, filepos, fs_info->s=
ectorsize,
> +                                              false);
>                 return PTR_ERR(em);
>         }
>
> @@ -1773,8 +1779,8 @@ static noinline_for_stack int extent_writepage_io(s=
truct btrfs_inode *inode,
>                         spin_unlock(&inode->ordered_tree_lock);
>                         btrfs_put_ordered_extent(ordered);
>
> -                       btrfs_mark_ordered_io_finished(inode, folio, cur,
> -                                                      fs_info->sectorsiz=
e, true);
> +                       btrfs_folio_clear_ordered(fs_info, folio, cur, fs=
_info->sectorsize);
> +                       btrfs_mark_ordered_io_finished(inode, cur, fs_inf=
o->sectorsize, true);
>                         /*
>                          * This range is beyond i_size, thus we don't nee=
d to
>                          * bother writing back.
> @@ -2649,8 +2655,7 @@ void extent_write_locked_range(struct inode *inode,=
 const struct folio *locked_f
>                 if (IS_ERR(folio)) {
>                         cur_end =3D min(round_down(cur, PAGE_SIZE) + PAGE=
_SIZE - 1, end);
>                         cur_len =3D cur_end + 1 - cur;
> -                       btrfs_mark_ordered_io_finished(BTRFS_I(inode), NU=
LL,
> -                                                      cur, cur_len, fals=
e);
> +                       btrfs_mark_ordered_io_finished(BTRFS_I(inode), cu=
r, cur_len, false);
>                         mapping_set_error(mapping, PTR_ERR(folio));
>                         cur =3D cur_end;
>                         continue;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3af087c81724..b6b386e06529 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -424,7 +424,7 @@ static inline void btrfs_cleanup_ordered_extents(stru=
ct btrfs_inode *inode,
>                 folio_put(folio);
>         }
>
> -       return btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes,=
 false);
> +       return btrfs_mark_ordered_io_finished(inode, offset, bytes, false=
);
>  }
>
>  static int btrfs_dirty_inode(struct btrfs_inode *inode);
> @@ -2945,7 +2945,9 @@ static void btrfs_writepage_fixup_worker(struct btr=
fs_work *work)
>                  * to reflect the errors and clean the page.
>                  */
>                 mapping_set_error(folio->mapping, ret);
> -               btrfs_mark_ordered_io_finished(inode, folio, page_start,
> +               btrfs_folio_clear_ordered(fs_info, folio, page_start,
> +                                         folio_size(folio));
> +               btrfs_mark_ordered_io_finished(inode, page_start,
>                                                folio_size(folio), !ret);
>                 folio_clear_dirty_for_io(folio);
>         }
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index e47c3a3a619a..8405d07b49cd 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -348,30 +348,13 @@ static void finish_ordered_fn(struct btrfs_work *wo=
rk)
>  }
>
>  static bool can_finish_ordered_extent(struct btrfs_ordered_extent *order=
ed,
> -                                     struct folio *folio, u64 file_offse=
t,
> -                                     u64 len, bool uptodate)
> +                                     u64 file_offset, u64 len, bool upto=
date)
>  {
>         struct btrfs_inode *inode =3D ordered->inode;
>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>
>         lockdep_assert_held(&inode->ordered_tree_lock);
>
> -       if (folio) {
> -               ASSERT(folio->mapping);
> -               ASSERT(folio_pos(folio) <=3D file_offset);
> -               ASSERT(file_offset + len <=3D folio_next_pos(folio));
> -
> -               /*
> -                * Ordered flag indicates whether we still have
> -                * pending io unfinished for the ordered extent.
> -                *
> -                * If it's not set, we need to skip to next range.
> -                */
> -               if (!btrfs_folio_test_ordered(fs_info, folio, file_offset=
, len))
> -                       return false;
> -               btrfs_folio_clear_ordered(fs_info, folio, file_offset, le=
n);
> -       }
> -
>         /* Now we're fine to update the accounting. */
>         if (WARN_ON_ONCE(len > ordered->bytes_left)) {
>                 btrfs_crit(fs_info,
> @@ -413,8 +396,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_order=
ed_extent *ordered)
>  }
>
>  void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
> -                                struct folio *folio, u64 file_offset, u6=
4 len,
> -                                bool uptodate)
> +                                u64 file_offset, u64 len, bool uptodate)
>  {
>         struct btrfs_inode *inode =3D ordered->inode;
>         bool ret;
> @@ -422,7 +404,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered=
_extent *ordered,
>         trace_btrfs_finish_ordered_extent(inode, file_offset, len, uptoda=
te);
>
>         spin_lock(&inode->ordered_tree_lock);
> -       ret =3D can_finish_ordered_extent(ordered, folio, file_offset, le=
n,
> +       ret =3D can_finish_ordered_extent(ordered, file_offset, len,
>                                         uptodate);
>         spin_unlock(&inode->ordered_tree_lock);
>
> @@ -475,8 +457,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered=
_extent *ordered,
>   * extent(s) covering it.
>   */
>  void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
> -                                   struct folio *folio, u64 file_offset,
> -                                   u64 num_bytes, bool uptodate)
> +                                   u64 file_offset, u64 num_bytes, bool =
uptodate)
>  {
>         struct rb_node *node;
>         struct btrfs_ordered_extent *entry =3D NULL;
> @@ -536,7 +517,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inod=
e *inode,
>                 len =3D this_end - cur;
>                 ASSERT(len < U32_MAX);
>
> -               if (can_finish_ordered_extent(entry, folio, cur, len, upt=
odate)) {
> +               if (can_finish_ordered_extent(entry, cur, len, uptodate))=
 {
>                         spin_unlock(&inode->ordered_tree_lock);
>                         btrfs_queue_ordered_fn(entry);
>                         spin_lock(&inode->ordered_tree_lock);
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 86e69de9e9ff..cd74c5ecfd67 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -163,11 +163,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_ext=
ent *ordered_extent);
>  void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
>  void btrfs_remove_ordered_extent(struct btrfs_ordered_extent *entry);
>  void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
> -                                struct folio *folio, u64 file_offset, u6=
4 len,
> -                                bool uptodate);
> +                                u64 file_offset, u64 len, bool uptodate)=
;
>  void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
> -                                   struct folio *folio, u64 file_offset,
> -                                   u64 num_bytes, bool uptodate);
> +                                   u64 file_offset, u64 num_bytes, bool =
uptodate);
>  bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>                                     struct btrfs_ordered_extent **cached,
>                                     u64 file_offset, u64 io_size);
> --
> 2.52.0
>
>

