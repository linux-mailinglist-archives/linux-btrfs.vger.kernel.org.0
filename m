Return-Path: <linux-btrfs+bounces-19333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659DC848C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 11:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 960FD4E9B98
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0B4314A73;
	Tue, 25 Nov 2025 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD9Pdpj5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA63148C4
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067549; cv=none; b=kgXeFoyclyDjHcKfkSRZi5WqESIQA8eiMgJMj0iqreOjVo2Gj/tGCbFXV5JhHWhCKPChTqYFHa/fFQow+t97piGtgbnPXNSxyVymvfZ2lzVnhxU2p19DdT/B57PfsE7g+jh6R5i8piy3qkpthw4c7m6UO+uCkKh6xOtU1ejw3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067549; c=relaxed/simple;
	bh=7xGpvM+IWWM5p/pR9wQjeug0VJgt6BxSj/ClaSW84So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjmj9nyyDK/gt6GOI7MiqjQ5aJOo+VR0j1HsyeXRiycq1pfog/mgx7SNytnQIzEmY5a+zahQCnJqiloaaW9cuVHbLjx+9QkwI4mJy2tZgMZeGaDEZxTbaLt/9AqQHw6M7K04Cpo+DtN3zlscvQ/bUalfFsQXyByI1DSXptBBjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD9Pdpj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843EEC116D0
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764067547;
	bh=7xGpvM+IWWM5p/pR9wQjeug0VJgt6BxSj/ClaSW84So=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UD9Pdpj5PYggsiuPe9/NR2VfIWbm7Hmbo+beIE8TKhtZX54+KgwJQRe1tt5jYvnU7
	 fsOhgXgQqJykSBveNd75r3Ht2xozcSo5KU96D7xi5CKyO82f+Eb8IuiU9RCQR0vgJQ
	 wL9EdZ1MBOx5MYyGdM3IYOZqzHIokmYWEwTKkuRtkcW3mtQUmCpJC5enJYwGMrchXb
	 +A9z5ymZ/Ju1sASUPobFsehb56U4OCh5+ulw25CdY00pmFOSkjAtrxy1emej/uJSao
	 OAQQxBsGEnmVTTLSTGXpmFoxEEk5w+61Ddk8JMf3mpRvK6aY0UNpBrtgBuO1IfIEjH
	 8Lgyn5B/aNplg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso9465450a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 02:45:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yxy7qgizOwwoSxBp8dJq0KJOgVMthNGv+UCbpR4mjWpRMOHRwNv
	/0KHYkdUud82wV+k7AXxSKTEtiobnJDU+nGZijxVvnqj1bh/Z0ANLH+bBvVUDekAzGRHE5fDhYz
	Zrq6ZAbaHHCkKQxR8Mm/A+TSvc0efTDQ=
X-Google-Smtp-Source: AGHT+IGoLBHIszOwyT4+St/mSUG1V06O1dm5O7GrHGTqIR2wv7akITLNdNsW7JTOwYi34Z/SczhZmsAiI0FDlKHI3Ps=
X-Received: by 2002:a17:907:7212:b0:b73:8bd4:8fa with SMTP id
 a640c23a62f3a-b7671688896mr1510909466b.3.1764067546012; Tue, 25 Nov 2025
 02:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <349a50a207bb672f4d8e48ddfb70da10707902e5.1764057885.git.wqu@suse.com>
In-Reply-To: <349a50a207bb672f4d8e48ddfb70da10707902e5.1764057885.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Nov 2025 10:45:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5Ue-fSHHUF8daFkp-yZ9QWbKVpdZgbWKrT_gT-4XckgQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmJnDy_ff99GgSpU4zu9xk8FmPU7WzwWDb6P7BlJN3dJUeROJcM_Q8VZU4
Message-ID: <CAL3q7H5Ue-fSHHUF8daFkp-yZ9QWbKVpdZgbWKrT_gT-4XckgQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: make sure all ordered extents beyond EOF are
 properly truncated
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 8:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> However during the EOF handling, patch "btrfs: truncate ordered extent
> when skipping writeback past i_size" only calls
> btrfs_lookup_first_ordered_range() once, thus only got OE A and mark it
> as truncated.

And there's a reason why the patch only looks for one ordered extent.

Because there shouldn't be more than one: btrfs_truncate() calls
btrfs_wait_ordered_range() when we truncate the size of a file to a
smaller value.
The range goes from the new i_size, rounded down by sector size, to
(u64)-1. And btrfs_wait_ordered_range() flushed any delalloc besides
waiting for ordered extents.

So how can we find more than one ordered extent after this?

I think this changelog should explain that, it makes no mention of
this detail about btrfs_truncate().

Thanks.


>
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
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the ASSERT() inside btrfs_mark_ordered_io_truncated()
>   Since the range passed in is to the end of the folio during writeback
>   path, there is no guarantee that there is always one or more ordered
>   extents covering the full range.
>
>   This get triggered during fsstress runs, especially common on bs < ps
>   cases.
>
>   Remove the ASSERT() and exit the oe search instead.
>
> Resend:
> - Move the patch out of the series 'btrfs: reduce btrfs_get_extent()
>   calls for buffered write path'
>   As this is a bug fix, which needs a little higher priority than
>   the remaining optimizations.
>
> - Fix various grammar errors
>
> - Use @end to replace duplicated calculations
>
> - Remove the Fixes: tag
>   The involved patch is not yet merged upstream.
>   Just mention the patch subject inside the commit message.
> ---
>  fs/btrfs/extent_io.c    | 19 +------------------
>  fs/btrfs/ordered-data.c | 33 +++++++++++++++++++++++++++++++++
>  fs/btrfs/ordered-data.h |  2 ++
>  3 files changed, 36 insertions(+), 18 deletions(-)
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
> index a421f7db9eec..3c0b89164139 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -546,6 +546,39 @@ void btrfs_mark_ordered_io_finished(struct btrfs_ino=
de *inode,
>         spin_unlock(&inode->ordered_tree_lock);
>  }
>
> +/*
> + * Mark any ordered extents io inside the specified range as truncated.
> + */
> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct f=
olio *folio,
> +                                    u64 file_offset, u32 len)
> +{
> +       const u64 end =3D file_offset + len;
> +       u64 cur =3D file_offset;
> +
> +       ASSERT(file_offset >=3D folio_pos(folio));
> +       ASSERT(end <=3D folio_pos(folio) + folio_size(folio));
> +
> +       while (cur < end) {
> +               u32 cur_len =3D end - cur;
> +               struct btrfs_ordered_extent *ordered;
> +
> +               ordered =3D btrfs_lookup_first_ordered_range(inode, cur, =
cur_len);
> +
> +               if (!ordered)
> +                       break;
> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags)=
;
> +                       ordered->truncated_len =3D min(ordered->truncated=
_len,
> +                                                    cur - ordered->file_=
offset);
> +               }
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

