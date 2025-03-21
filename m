Return-Path: <linux-btrfs+bounces-12484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DECA6BA39
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 13:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F52E3B56FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05B22256E;
	Fri, 21 Mar 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRAx5MTo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64186250
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558457; cv=none; b=cS0L69vSydzN41lM96f9dd2mRmMl3Cchqqwb1iDDsL0MZ49nwaahKLGJmEimgHzeMIe4HbbAh+cqdM/PRB6gNVnFFPmfrypCm5am7B1HoSV9Uz14adsk4YXJCzrSB+6EJqz+I0qzOAJ3IsWxLF86+ua9ZFi/FDzBWXTzg9hf/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558457; c=relaxed/simple;
	bh=kZRq5jaeZacSsiWdH0hr2BfQXJA7kgwbX6lMhWXFToo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jh8Yg3Adq+KOOv+rWhiQ95xvdJSpeApDoVf2Z1B9XN32sqNGFzQ7f/VkC2jPDUVl2/ONEzwK9/kxWYDb9RFXLTuuPef69s7htFEA4CJuJ/tA5MgjYmFSUYIfdVoVv+s6OGEdCp5KygBJeG4zZxqDRDn4Bykii1yISYUog5lE5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRAx5MTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5090EC4CEE3
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 12:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742558457;
	bh=kZRq5jaeZacSsiWdH0hr2BfQXJA7kgwbX6lMhWXFToo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kRAx5MTo/wp1KcF59sztPCpja8axQDPiWvoaTMp6VmYeEZ89Bpu7h1ftBCsT/NXRm
	 0/xZ8D1DRZ7n01Ha0g+Gh+zKPb8F86ypXoNzbhQNMTf0Q8bPmOtbXty454l4RmaKsN
	 hMET6NJX35GR6jp0B5MY/W2OIRLxhgcmfb3uH7qjm716zIu/SRx11wCjls5OyeC27s
	 daJs5EECBpfH8W/+qTEubQ+/xObiu6pSFkFQ61rh21ETuiHCeMU2kQiM6OgrCgas5V
	 8f+UOUQl5lnz3vcV8RzLf6tpugopVBbUBb2Xxz+ZAsH/txhFtnZCfanI5t+LNg6nNu
	 mstmEwM4bFHkQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso3341574a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 05:00:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YyN9Z/R9LRLtkscolt6jgiwlWXXEsoe+MlvOgP4WR1loQC8vk4F
	KBTBrsDM6ytvXcNmACQ5zD2JiSyHZ7ue3MM2ej89UOFeALwUkIzyHjeoxFIkrMtgKbv9WurXyxs
	517IzsE5WwrF6/H7BMcSuduP+sJ8=
X-Google-Smtp-Source: AGHT+IHlSVuTy1XyqfaoqUQD6sFVWkfLeDS41qgIXp2wY0VHyqtp2h/ybFKyYOcNYVDn1+NWvV9l/DceFMiAjEULtog=
X-Received: by 2002:a17:907:1c11:b0:ac3:ed52:2c4c with SMTP id
 a640c23a62f3a-ac3f24d5cd3mr336576166b.37.1742558455740; Fri, 21 Mar 2025
 05:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742443383.git.wqu@suse.com> <66698e7eb0589e818eec555abc3b04969dcb48f1.1742443383.git.wqu@suse.com>
In-Reply-To: <66698e7eb0589e818eec555abc3b04969dcb48f1.1742443383.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Mar 2025 12:00:18 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7TN7tEuGqS-vsCawUvmLSaDsXWfQZzPjecXmD8mnk-kA@mail.gmail.com>
X-Gm-Features: AQ5f1JoTCPUfc-68D6rumEGI2L_6fmCZcKLSqZ52L2C-edugflfOcOzVus7rO_8
Message-ID: <CAL3q7H7TN7tEuGqS-vsCawUvmLSaDsXWfQZzPjecXmD8mnk-kA@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: remove force_page_uptodate variable from btrfs_buffered_write()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:36=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Commit c87c299776e4 ("btrfs: make buffered write to copy one page a
> time") changed how the variable @force_page_uptodate is updated.
>
> Before that commit the variable is only initialized to false at the
> beginning of the function, and after hitting a short copy, the next
> retry on the same folio will force the foilio to be read from the disk.

foilio -> folio

>
> But after the commit, the variable is always updated to false for each

I think saying "is always initialized to false at the beginning of the
loop's scope" is more clear.
When you say updated it gives the idea it was declared in an outer
scope, but that's not the case anymore.

> iteration, causing prepare_one_folio() never to get a true value passed
> in.
>
> The change in behavior is not a huge deal, it only makes a difference
> on how we handle short copies:
>
> Old: Allow the buffer to be split
>
>      The first short copy will be rejected, that's the same for both
>      cases.
>
>      But for the next retry, we require the folio to be read from disk.
>
>      Then even if we hit a short copy again, since the folio is already
>      uptodate, we do not need to handle partial uptodate range, and can
>      continue, marking the short copied range as dirty and continue.
>
>      This will split the buffer write into the folio as two buffered
>      writes.
>
> New: Do not allow the buffer to be split
>
>      The first short copy will be rejected, that's the same for both
>      cases.
>
>      For the next retry, we do nothing special, thus if the short copy
>      happened again, we reject it again, until either the short copy is
>      gone, or we failed to fault in the buffer.
>
>      This will mean the buffer write into the folio will either fail or
>      success, no split will happen.
>
> To me, either solution is fine, but the newer one makes it simpler and
> requires no special handling, so I prefer that solution.

Ok so this explanation of different behaviour is something that should
have been in the change log of commit c87c299776e4 ("btrfs: make
buffered write to copy one page a time").

With the new behaviour, when folios larger than 1 page are supported,
I wonder if we don't risk looping over the same subrange many times,
in case we keep needing to faultin due to memory pressure.

>
> And since @force_page_uptodate is always false when passed into
> prepare_one_folio(), we can just remove the variable.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Anyway, this change looks good, and at least with the typo fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/file.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index c2648858772a..b7eb1f0164bb 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -800,7 +800,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_hand=
le *trans,
>   * On success return a locked folio and 0
>   */
>  static int prepare_uptodate_folio(struct inode *inode, struct folio *fol=
io, u64 pos,
> -                                 u64 len, bool force_uptodate)
> +                                 u64 len)
>  {
>         u64 clamp_start =3D max_t(u64, pos, folio_pos(folio));
>         u64 clamp_end =3D min_t(u64, pos + len, folio_pos(folio) + folio_=
size(folio));
> @@ -810,8 +810,7 @@ static int prepare_uptodate_folio(struct inode *inode=
, struct folio *folio, u64
>         if (folio_test_uptodate(folio))
>                 return 0;
>
> -       if (!force_uptodate &&
> -           IS_ALIGNED(clamp_start, blocksize) &&
> +       if (IS_ALIGNED(clamp_start, blocksize) &&
>             IS_ALIGNED(clamp_end, blocksize))
>                 return 0;
>
> @@ -858,7 +857,7 @@ static gfp_t get_prepare_gfp_flags(struct inode *inod=
e, bool nowait)
>   */
>  static noinline int prepare_one_folio(struct inode *inode, struct folio =
**folio_ret,
>                                       loff_t pos, size_t write_bytes,
> -                                     bool force_uptodate, bool nowait)
> +                                     bool nowait)
>  {
>         unsigned long index =3D pos >> PAGE_SHIFT;
>         gfp_t mask =3D get_prepare_gfp_flags(inode, nowait);
> @@ -881,7 +880,7 @@ static noinline int prepare_one_folio(struct inode *i=
node, struct folio **folio_
>                 folio_put(folio);
>                 return ret;
>         }
> -       ret =3D prepare_uptodate_folio(inode, folio, pos, write_bytes, fo=
rce_uptodate);
> +       ret =3D prepare_uptodate_folio(inode, folio, pos, write_bytes);
>         if (ret) {
>                 /* The folio is already unlocked. */
>                 folio_put(folio);
> @@ -1127,7 +1126,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>                 size_t num_sectors;
>                 struct folio *folio =3D NULL;
>                 int extents_locked;
> -               bool force_page_uptodate =3D false;
>
>                 /*
>                  * Fault pages before locking them in prepare_one_folio()
> @@ -1196,8 +1194,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>                         break;
>                 }
>
> -               ret =3D prepare_one_folio(inode, &folio, pos, write_bytes=
,
> -                                       force_page_uptodate, false);
> +               ret =3D prepare_one_folio(inode, &folio, pos, write_bytes=
, false);
>                 if (ret) {
>                         btrfs_delalloc_release_extents(BTRFS_I(inode),
>                                                        reserve_bytes);
> @@ -1240,12 +1237,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, s=
truct iov_iter *i)
>                                         fs_info->sectorsize);
>                 dirty_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, dirty_sect=
ors);
>
> -               if (copied =3D=3D 0) {
> -                       force_page_uptodate =3D true;
> +               if (copied =3D=3D 0)
>                         dirty_sectors =3D 0;
> -               } else {
> -                       force_page_uptodate =3D false;
> -               }
>
>                 if (num_sectors > dirty_sectors) {
>                         /* release everything except the sectors we dirti=
ed */
> --
> 2.49.0
>
>

