Return-Path: <linux-btrfs+bounces-21634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPk/C0TCjGkmswAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21634-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 18:54:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097F126BBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 18:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B8E2300CC9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FBA34A783;
	Wed, 11 Feb 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKaHjHTs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B521ADA7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832448; cv=none; b=iPvKjGAwC6B0xCIqEIpDkY2DA/ULXTqGlYm4FMcrp40PbRL6nqbZaBQQV/eFHItkcPU3OdKHUtNr3NRuvIZ6A5LUB7fw/GZ+sQSgS590DPQOUb4Ce641/JjZ430vcTim6fHTyPrpFzh8OvKEgiGdpxmfJjOd3PqV44kH2r+81lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832448; c=relaxed/simple;
	bh=nkQQQgY+Dxg3C1kPQDdJZ4t355Ya93GbviDUXl18aaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0UWPOALa0FQkIXEV58Nt+pKQ0TlXHpCVMinSd/+UKqPdzs7ahVih8T5CQl3rvhi6+06qKLdny9R880XA5Hc9cM3oYgBkbh5I8MPqxWLjqcYGM0sKHGXmeKeX7Fzk/dhUa4Tbliy/2wqFK2pVSxnXC9aq8zVz6xwR1LzpdFUlDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKaHjHTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB758C4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770832448;
	bh=nkQQQgY+Dxg3C1kPQDdJZ4t355Ya93GbviDUXl18aaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KKaHjHTs7XOcHL0tbvwYc8ZfXVCbchsmin0jQkSMOVjdkda2tXp/5RaIKzDv47i6q
	 rMpcoZGuMMtqN56HLM/QYZM0My0nR0W7JeoumsMTCSNOd9m7W0U4+wXydJojZwUSw/
	 GedsBtCptu9NyOmhNN/zHHiWsdzZgvsCZBvWdWY79UqzOwq1Rq6o3Gv5xSEo3hpj5g
	 PAmNrde0+Y0VA8ird4AdSqZ0A8hKQJ+0Fsgd/tm0J3LXPUK4RKMr4fNQkxRgfIx9uE
	 OVOAhCSKKExbbxvZo2MAlpYi8rIHgcU8368oV2rSZruNmx62ZUNUnf3c0sOj6rqoG3
	 uaERzBSn0YPxA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f7a30515aso103156866b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 09:54:07 -0800 (PST)
X-Gm-Message-State: AOJu0YyypL+PAAxs6tcVu/DNie2eogbWaB0mUsz45jn7nS5ggpLjgTI/
	stkRnTHsD0uri2zs80aGnwKv7+iAfCikc+nqyHt3xe5Od6NLRph4KkP11TaJFLHXRZQcbwqnVvQ
	rtfslhT8P1uyOiDQVRuDGDPRjeAuhWOY=
X-Received: by 2002:a17:907:3c8f:b0:b88:505d:2ac with SMTP id
 a640c23a62f3a-b8f6a92ad7fmr170503166b.1.1770832446365; Wed, 11 Feb 2026
 09:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770724034.git.fdmanana@suse.com> <54f2a569d1dda9eeb17b4839f6055631e13fab22.1770724034.git.fdmanana@suse.com>
 <20260211173919.GB1458991@zen.localdomain>
In-Reply-To: <20260211173919.GB1458991@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 11 Feb 2026 17:53:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7hmnQjsdW4ccCgwCsHoge0kuC+FsmDkib9OPu-x+Jxwg@mail.gmail.com>
X-Gm-Features: AZwV_QgBV_BWPA2lHaimURqS5_jKF9GURODKU3pUUiOyb0pX0H6l0bULhiBPZr4
Message-ID: <CAL3q7H7hmnQjsdW4ccCgwCsHoge0kuC+FsmDkib9OPu-x+Jxwg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] btrfs: check for NULL root after calls to btrfs_csum_root()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21634-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,meta.com:email,bur.io:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9097F126BBB
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 5:40=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Tue, Feb 10, 2026 at 11:57:50AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > btrfs_csum_root() can return a NULL pointer in case the root we are
> > looking for is not in the rb tree that tracks roots. So add checks to
> > every caller that is missing such check to log a message and return
> > an error.
>
> Similar question on if you think this one needs a Fixes.
>
> >
> > Reported-by: Chris Mason <clm@meta.com>
> > Link: https://lore.kernel.org/linux-btrfs/20260208161657.3972997-1-clm@=
meta.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/disk-io.c     |  4 ++++
> >  fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
> >  fs/btrfs/file-item.c   |  7 +++++++
> >  fs/btrfs/inode.c       | 18 ++++++++++++++++--
> >  fs/btrfs/raid56.c      | 12 ++++++++++--
> >  fs/btrfs/relocation.c  |  8 ++++++++
> >  fs/btrfs/tree-log.c    | 21 +++++++++++++++++++++
> >  7 files changed, 84 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 4b1e67f176a3..99ce7c1ca53a 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -1626,6 +1626,10 @@ static int backup_super_roots(struct btrfs_fs_in=
fo *info)
> >                       btrfs_err(info, "missing extent root for extent a=
t bytenr 0");
> >                       return -EUCLEAN;
> >               }
> > +             if (unlikely(!csum_root)) {
> > +                     btrfs_err(info, "missing csum root for extent at =
bytenr 0");
> > +                     return -EUCLEAN;
> > +             }
> >
> >               btrfs_set_backup_extent_root(root_backup,
> >                                            extent_root->node->start);
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 331263c206af..d1bfbad5adc6 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -1974,8 +1974,15 @@ static int cleanup_ref_head(struct btrfs_trans_h=
andle *trans,
> >                       struct btrfs_root *csum_root;
> >
> >                       csum_root =3D btrfs_csum_root(fs_info, head->byte=
nr);
> > -                     ret =3D btrfs_del_csums(trans, csum_root, head->b=
ytenr,
> > -                                           head->num_bytes);
> > +                     if (unlikely(!csum_root)) {
> > +                             btrfs_err(fs_info,
> > +                                       "missing csum root for extent a=
t bytenr %llu",
> > +                                       head->bytenr);
> > +                             ret =3D -EUCLEAN;
> > +                     } else {
> > +                             ret =3D btrfs_del_csums(trans, csum_root,=
 head->bytenr,
> > +                                                   head->num_bytes);
> > +                     }
>
> nit: I sort of prefer early-exit/goto-cleanup as a general pattern rather
> than nesting the work behind conditions, but I assume you did it on purpo=
se
> since it's the only early exit that cleans up?

Yes, it was on purpose, because pinning the extent must come before
the failure and everything after should be executed on error too (just
like when btrfs_del_csums() fails).

Thanks.

>
> I think it's nice that it makes all the code look predictable and the
> same when checking the root.
>
> >               }
> >       }
> >
> > @@ -3147,6 +3154,15 @@ static int do_free_extent_accounting(struct btrf=
s_trans_handle *trans,
> >               struct btrfs_root *csum_root;
> >
> >               csum_root =3D btrfs_csum_root(trans->fs_info, bytenr);
> > +             if (unlikely(!csum_root)) {
> > +                     ret =3D -EUCLEAN;
> > +                     btrfs_abort_transaction(trans, ret);
> > +                     btrfs_err(trans->fs_info,
> > +                               "missing csum root for extent at bytenr=
 %llu",
> > +                               bytenr);
> > +                     return ret;
> > +             }
> > +
> >               ret =3D btrfs_del_csums(trans, csum_root, bytenr, num_byt=
es);
> >               if (unlikely(ret)) {
> >                       btrfs_abort_transaction(trans, ret);
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 7bd715442f3e..f585ddfa8440 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -308,6 +308,13 @@ static int search_csum_tree(struct btrfs_fs_info *=
fs_info,
> >       /* Current item doesn't contain the desired range, search again *=
/
> >       btrfs_release_path(path);
> >       csum_root =3D btrfs_csum_root(fs_info, disk_bytenr);
> > +     if (unlikely(!csum_root)) {
> > +             btrfs_err(fs_info,
> > +                       "missing csum root for extent at bytenr %llu",
> > +                       disk_bytenr);
> > +             return -EUCLEAN;
> > +     }
> > +
> >       item =3D btrfs_lookup_csum(NULL, csum_root, path, disk_bytenr, 0)=
;
> >       if (IS_ERR(item)) {
> >               ret =3D PTR_ERR(item);
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 826809977df5..1cbaaf7a7230 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -2013,6 +2013,13 @@ static int can_nocow_file_extent(struct btrfs_pa=
th *path,
> >        */
> >
> >       csum_root =3D btrfs_csum_root(root->fs_info, io_start);
> > +     if (unlikely(!csum_root)) {
> > +             btrfs_err(root->fs_info,
> > +                       "missing csum root for extent at bytenr %llu", =
io_start);
> > +             ret =3D -EUCLEAN;
> > +             goto out;
> > +     }
> > +
> >       ret =3D btrfs_lookup_csums_list(csum_root, io_start,
> >                                     io_start + args->file_extent.num_by=
tes - 1,
> >                                     NULL, nowait);
> > @@ -2750,10 +2757,17 @@ static int add_pending_csums(struct btrfs_trans=
_handle *trans,
> >       int ret;
> >
> >       list_for_each_entry(sum, list, list) {
> > -             trans->adding_csums =3D true;
> > -             if (!csum_root)
> > +             if (!csum_root) {
> >                       csum_root =3D btrfs_csum_root(trans->fs_info,
> >                                                   sum->logical);
> > +                     if (unlikely(!csum_root)) {
> > +                             btrfs_err(trans->fs_info,
> > +                               "missing csum root for extent at bytenr=
 %llu",
> > +                                       sum->logical);
> > +                             return -EUCLEAN;
> > +                     }
> > +             }
> > +             trans->adding_csums =3D true;
> >               ret =3D btrfs_csum_file_blocks(trans, csum_root, sum);
> >               trans->adding_csums =3D false;
> >               if (ret)
> > diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> > index baadaaa189c0..230dd93dad6e 100644
> > --- a/fs/btrfs/raid56.c
> > +++ b/fs/btrfs/raid56.c
> > @@ -2295,8 +2295,7 @@ void raid56_parity_recover(struct bio *bio, struc=
t btrfs_io_context *bioc,
> >  static void fill_data_csums(struct btrfs_raid_bio *rbio)
> >  {
> >       struct btrfs_fs_info *fs_info =3D rbio->bioc->fs_info;
> > -     struct btrfs_root *csum_root =3D btrfs_csum_root(fs_info,
> > -                                                    rbio->bioc->full_s=
tripe_logical);
> > +     struct btrfs_root *csum_root;
> >       const u64 start =3D rbio->bioc->full_stripe_logical;
> >       const u32 len =3D (rbio->nr_data * rbio->stripe_nsectors) <<
> >                       fs_info->sectorsize_bits;
> > @@ -2329,6 +2328,15 @@ static void fill_data_csums(struct btrfs_raid_bi=
o *rbio)
> >               goto error;
> >       }
> >
> > +     csum_root =3D btrfs_csum_root(fs_info, rbio->bioc->full_stripe_lo=
gical);
> > +     if (unlikely(!csum_root)) {
> > +             btrfs_err(fs_info,
> > +                       "missing csum root for extent at bytenr %llu",
> > +                       rbio->bioc->full_stripe_logical);
> > +             ret =3D -EUCLEAN;
> > +             goto error;
> > +     }
> > +
> >       ret =3D btrfs_lookup_csums_bitmap(csum_root, NULL, start, start +=
 len - 1,
> >                                       rbio->csum_buf, rbio->csum_bitmap=
);
> >       if (ret < 0)
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 3906e457d2ef..8a8a66112d42 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -5641,6 +5641,14 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered=
_extent *ordered)
> >       LIST_HEAD(list);
> >       int ret;
> >
> > +     if (unlikely(!csum_root)) {
> > +             btrfs_mark_ordered_extent_error(ordered);
> > +             btrfs_err(fs_info,
> > +                       "missing csum root for extent at bytenr %llu",
> > +                       disk_bytenr);
> > +             return -EUCLEAN;
> > +     }
> > +
> >       ret =3D btrfs_lookup_csums_list(csum_root, disk_bytenr,
> >                                     disk_bytenr + ordered->num_bytes - =
1,
> >                                     &list, false);
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index e2806ca410f6..e9655095ba4c 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -984,6 +984,13 @@ static noinline int replay_one_extent(struct walk_=
control *wc)
> >
> >               sums =3D list_first_entry(&ordered_sums, struct btrfs_ord=
ered_sum, list);
> >               csum_root =3D btrfs_csum_root(fs_info, sums->logical);
> > +             if (unlikely(!csum_root)) {
> > +                     btrfs_err(fs_info,
> > +                               "missing csum root for extent at bytenr=
 %llu",
> > +                               sums->logical);
> > +                     ret =3D -EUCLEAN;
> > +             }
> > +
> >               if (!ret) {
> >                       ret =3D btrfs_del_csums(trans, csum_root, sums->l=
ogical,
> >                                             sums->len);
> > @@ -4890,6 +4897,13 @@ static noinline int copy_items(struct btrfs_tran=
s_handle *trans,
> >               }
> >
> >               csum_root =3D btrfs_csum_root(trans->fs_info, disk_bytenr=
);
> > +             if (unlikely(!csum_root)) {
> > +                     btrfs_err(trans->fs_info,
> > +                               "missing csum root for extent at bytenr=
 %llu",
> > +                               disk_bytenr);
> > +                     return -EUCLEAN;
> > +             }
> > +
> >               disk_bytenr +=3D extent_offset;
> >               ret =3D btrfs_lookup_csums_list(csum_root, disk_bytenr,
> >                                             disk_bytenr + extent_num_by=
tes - 1,
> > @@ -5086,6 +5100,13 @@ static int log_extent_csums(struct btrfs_trans_h=
andle *trans,
> >       /* block start is already adjusted for the file extent offset. */
> >       block_start =3D btrfs_extent_map_block_start(em);
> >       csum_root =3D btrfs_csum_root(trans->fs_info, block_start);
> > +     if (unlikely(!csum_root)) {
> > +             btrfs_err(trans->fs_info,
> > +                       "missing csum root for extent at bytenr %llu",
> > +                       block_start);
> > +             return -EUCLEAN;
> > +     }
> > +
> >       ret =3D btrfs_lookup_csums_list(csum_root, block_start + csum_off=
set,
> >                                     block_start + csum_offset + csum_le=
n - 1,
> >                                     &ordered_sums, false);
> > --
> > 2.47.2
> >

