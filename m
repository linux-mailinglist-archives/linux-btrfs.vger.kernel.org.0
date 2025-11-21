Return-Path: <linux-btrfs+bounces-19243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A51C78EA3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 12:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C754E242BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0D199EAD;
	Fri, 21 Nov 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1xBqrpq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49D346FA7
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726197; cv=none; b=WtsueDWzHBto+wwrrxSyWvJ3kRsDR5IhmWr+4do3w76HCpuzdhMLVb8MngLbq+rZEqiy2cFK83qM9c1eDyIcVw5GXwEEyD3h+RkfcyzCtV3SqQDOGiDnNlzA8vT/BxiS2kf07RM3LA+By4JCWANB1Ot3rwGf1zqKeJK/Ity+mRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726197; c=relaxed/simple;
	bh=9veETjfS61uUJHWc+P+xYcoh2Ua7uhI7o/Ily78K/hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRXHFU0weg6XQXkMZwV8NXR/MGgbQ8ey4acf+7sK3NmbSXNdCOTmuhW36gkiMwDTQBMk9+bZHv84JqAdw1idbbSzNmnuLaAzTkfkYCRgPu+EZoC4hNAcVuhJZ7hUhlAkU6TUlQT/CiU0pSPYo10dC+XqUz/2YFzoB+AOObU5HNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1xBqrpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0377C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763726196;
	bh=9veETjfS61uUJHWc+P+xYcoh2Ua7uhI7o/Ily78K/hA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O1xBqrpqJHzObvZ7mZkqUg63TlpUhDaiUGB87U/Z964QKzTayYre1Pp1GFLmgCcRa
	 3UI08vhY4UMLDJEuv/Q6+8mX4+xZlJZrjlL8vrC0HVwa1YnnlHBBcqqu6kWX1QGVrv
	 nsclHaTwt/opJ7cIWLH5FmdpKDmWcTMuTFujTqg8lWqK1ArH5/CsH3SUR9H/nSQJ6Z
	 RJOdECLj5i7ZKsjSavf3kxFzlNS34SLHo09lMVaGCiFr6nO9NQD83RVJFVHIX25hKF
	 Hz723g00gXhghug/PQ43KfLwrZSnoUCmM+FoegEe7rSWPKppsjXEyslEc7jNzlAZt/
	 t5Z/rj9TrjKeA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b737502f77bso284227566b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 03:56:36 -0800 (PST)
X-Gm-Message-State: AOJu0YxJAWSP3/EyIE9gEaf1PP/nrXHbyQgGTO/EXxKwTsFFW1jubMtU
	w3Gbi9XBq+30Sghn8TuSA2/o9efqzvrfXQfQvtrYrdhuomRYtuDwSQquCY9v2IaoDnhEj09ch+g
	LO4DAVLby6t0W+t5EW29jek6Ch/1s2RY=
X-Google-Smtp-Source: AGHT+IGbRGs3kHz5/XBWbyhvpXJgWOqg0e0c1vQcZYo+C6yrveqHg2RXwQCzAwO01WPx1yruRMPndw5nayhonTe49J0=
X-Received: by 2002:a17:907:9604:b0:b5c:66ce:bfe6 with SMTP id
 a640c23a62f3a-b7671a1585amr226787966b.55.1763726195074; Fri, 21 Nov 2025
 03:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763629982.git.wqu@suse.com> <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
In-Reply-To: <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Nov 2025 11:55:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
X-Gm-Features: AWmQ_bkizKU1GhmGJ8sE_-RBTDKmxdhuxHEnOyTiIyPN8YyuZUQUrEvRw6L_Ya4
Message-ID: <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF is
 properly truncated
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 9:22=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [POSSIBLE BUG]
> If there are multiple ordered extents beyond EOF, at folio writeback
> time we may only truncate the first ordered extent, but leaving the
> remaining ones finished but not marked as truncated.
>
> Since those OEs are not marked as truncated, it will still insert an
> file extent item, and may lead to false missing csum errors during
> "btrfs check".
>
> [CAUSE]
> Since we have bs < ps support for a while and experimental large data
> folios are also going to graduate from experimental features soon, we
> can have the following folio to be written back:
>
>   fs block size 4K
>   page size 4K, folio size 64K.
>
>            0        16K      32K                  64K
>            |<---------------- Dirty -------------->|
>            |<-OE A->|<-OE B->|<----- OE C -------->|
>                |
>                i_size 4K.
>
> In above case we need to submit the writeback for the range [0, 4K).
> For range [4K, 64K) there is no need to submit any IO but mark the
> involved OEs (OE A, B, C) all as truncated.
>
> However during the EOF handling, we only call
> btrfs_lookup_first_ordered_range() once, thus only got OE A and mark it
> as truncated.
> But OE B and C are not marked as truncated, they will finish as usual,
> which will leave a regular file extent item to be inserted beyond EOF,
> and without any data checksum.
>
> [FIX]
> Introduce a new helper, btrfs_mark_ordered_io_truncated(), to handle all
> OEs of a range, and mark them all as truncated.
>
> With that helper, all OEs (A B and C) will be marked as truncated.
> OE B and C will have 0 truncated_len, preventing any file extent item to
> be inserted from them.
>
> Fixes: f0a0f5bfe04e ("btrfs: truncate ordered extent when skipping writeb=
ack past i_size")

The commit ID is not stable yet, as that change is not in Linus' tree yet.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c    | 19 +------------------
>  fs/btrfs/ordered-data.c | 38 ++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/ordered-data.h |  2 ++
>  3 files changed, 41 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 2d32dfc34ae3..2044b889c887 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1725,24 +1725,7 @@ static noinline_for_stack int extent_writepage_io(=
struct btrfs_inode *inode,
>                 cur =3D folio_pos(folio) + (bit << fs_info->sectorsize_bi=
ts);
>
>                 if (cur >=3D i_size) {
> -                       struct btrfs_ordered_extent *ordered;
> -
> -                       ordered =3D btrfs_lookup_first_ordered_range(inod=
e, cur,
> -                                                                  folio_=
end - cur);
> -                       /*
> -                        * We have just run delalloc before getting here,=
 so
> -                        * there must be an ordered extent.
> -                        */
> -                       ASSERT(ordered !=3D NULL);
> -                       spin_lock(&inode->ordered_tree_lock);
> -                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags)=
;
> -                       ordered->truncated_len =3D min(ordered->truncated=
_len,
> -                                                    cur - ordered->file_=
offset);
> -                       spin_unlock(&inode->ordered_tree_lock);
> -                       btrfs_put_ordered_extent(ordered);
> -
> -                       btrfs_mark_ordered_io_finished(inode, folio, cur,
> -                                                      end - cur, true);
> +                       btrfs_mark_ordered_io_truncated(inode, folio, cur=
, end - cur);
>                         /*
>                          * This range is beyond i_size, thus we don't nee=
d to
>                          * bother writing back.
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index a421f7db9eec..9a0638d13225 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -546,6 +546,44 @@ void btrfs_mark_ordered_io_finished(struct btrfs_ino=
de *inode,
>         spin_unlock(&inode->ordered_tree_lock);
>  }
>
> +/*
> + * Mark all ordered extents io inside the specified range as truncated.
> + *
> + * This is utilized by writeback path, thus there must be an ordered ext=
ent

by -> by the

> + * for the range.
> + */
> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct f=
olio *folio,
> +                                    u64 file_offset, u32 len)
> +{
> +       u64 cur =3D file_offset;
> +
> +       ASSERT(file_offset >=3D folio_pos(folio));
> +       ASSERT(file_offset + len <=3D folio_end(folio));
> +
> +       while  (cur < file_offset + len) {

Two spaces between while and the opening parenthesis.

> +               u32 cur_len =3D file_offset + len - cur;

Please avoid repeating "file_offset + len" so many times. Use a const
variable at the top like:

const u64 end =3D file_offset + len;

Then use 'end' instead.

> +               struct btrfs_ordered_extent *ordered;
> +
> +               ordered =3D btrfs_lookup_first_ordered_range(inode, cur, =
cur_len);
> +
> +               /*
> +                * We have just run delalloc before getting here, so ther=
e must
> +                * be an ordered extent.
> +                */
> +               ASSERT(ordered !=3D NULL);
> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags)=
;
> +                       ordered->truncated_len =3D min(ordered->truncated=
_len,
> +                                                    cur - ordered->file_=
offset);
> +               }

I thought we had not made a decision yet to not use this new fancy locking =
yet.
In this case where it's a very short critical section, it doesn't
bring any advantage over using explicit spin_lock/unlock, and adds one
extra level of indentation.

Also in the subject:

btrfs: make sure all ordered extents beyond EOF is properly truncated

should be "are" instead of "is".

Thanks.

> +               cur_len =3D min(cur_len, ordered->file_offset + ordered->=
num_bytes - cur);
> +               btrfs_put_ordered_extent(ordered);
> +
> +               cur +=3D cur_len;
> +       }
> +       btrfs_mark_ordered_io_finished(inode, folio, file_offset, len, tr=
ue);
> +}
> +
>  /*
>   * Finish IO for one ordered extent across a given range.  The range can=
 only
>   * contain one ordered extent.
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 1e6b0b182b29..dd4cdc1a8b78 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -169,6 +169,8 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered=
_extent *ordered,
>  void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>                                     struct folio *folio, u64 file_offset,
>                                     u64 num_bytes, bool uptodate);
> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct f=
olio *folio,
> +                                    u64 file_offset, u32 len);
>  bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>                                     struct btrfs_ordered_extent **cached,
>                                     u64 file_offset, u64 io_size);
> --
> 2.52.0
>
>

