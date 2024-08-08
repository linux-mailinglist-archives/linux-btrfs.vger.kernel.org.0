Return-Path: <linux-btrfs+bounces-7048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E031894BC59
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB381C21BE4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5FD18B486;
	Thu,  8 Aug 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOMfPqNC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1518A95F
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117052; cv=none; b=ng8Q1LVbqCe5gll7YEHDqXBlkRJcMb6TSgxYNVdb1fuo0ZgWvAIuzpvvaavLK98Ch3TfqTSGqmMMOqtmwUYDo9AKQle9wSM+QMiqQOq36w/dpUrmrhWd0CvXzfjeH9D8eB7+ciDxWPuqHSZwkDiWRVGUXwOKrMKb0qKSTTKPKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117052; c=relaxed/simple;
	bh=/YbcLAL+Guxt9D0iSW7/sZrN8h6Vh0KZobyB8FNXQ3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxx48uKpRhLtoVOtYQVTWVJKOpLdJZIDnt+1smIAOSdbedCreQpbrUiQtefUfyP2JBUCxyMdyMDywELbzhMIqq8b2Eg1pY53iHDTU8rQLJ/xxhDEhagtZC0Z7839bApwtZD+9cyr876TmPe+o1C4JSgncLr6VVMo2ml8UTORwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOMfPqNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C22EC32782
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723117052;
	bh=/YbcLAL+Guxt9D0iSW7/sZrN8h6Vh0KZobyB8FNXQ3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tOMfPqNCKHGVqYenFSVeVlVb4T/krqwiCTNeKEjfqVAor0AnuI5pz8hgvMzfJCNay
	 yx62IomEtAmDjQryVMPb/uWXXi58DazDNghf+JMWKzxdrt6O2vy8Eoo7tnszXzd8wy
	 DPK2S8Z9fJ1xhQGRxw1hMZMe6uPUdkRsuyBtA6BmdR0EvBVLBO/Zgg5VVjJyHmNNlb
	 uicDsPLmlmFLJ+3ofNKrF1a0wD+R+Cb5b6YMFF249PTX1f7743V2RESNOHr9bBUVYZ
	 vYdjPlg7Yhs0tHtgZC+ASqOIQjcxAsSL1RDXYlR0Q5il5Rf48P4okFesTIf9bNgJWC
	 080/VHE4PvitA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so13192081fa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 04:37:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YwakxfQVKGifUKibWPFf3Hjf99zYACNhzPwTtd0D97Czo8LaBgh
	LWPUJScJd23C5UDZxP+UPAbyo5bZpha/AwjQ4ykvB4uwLSb+qQhd4T4Am1lEWdWWWye9/XLUteM
	EQhS/TXbPRkdIYOoiRPJHDeK4LFo=
X-Google-Smtp-Source: AGHT+IEN7mMrHC8nPSqXa4JqYp3P5KnnJHbVkOYg5Yy4ROy1bQZC3SBh/lOuEmBmQJFej1KZrCR/zqN4lKcNcje6VVQ=
X-Received: by 2002:a05:6512:e98:b0:529:b718:8d00 with SMTP id
 2adb3069b0e04-530e58124bbmr1414159e87.8.1723117050417; Thu, 08 Aug 2024
 04:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723096922.git.wqu@suse.com> <3843c1c37c19f547236a8ec2690d9b258a1c4489.1723096922.git.wqu@suse.com>
In-Reply-To: <3843c1c37c19f547236a8ec2690d9b258a1c4489.1723096922.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 8 Aug 2024 12:36:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7kXGi7WBnm3eGDTAsvxS7+xr194Yi1bRhJ44FrivEHXw@mail.gmail.com>
Message-ID: <CAL3q7H7kXGi7WBnm3eGDTAsvxS7+xr194Yi1bRhJ44FrivEHXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: introduce extent_map::em_cached member
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:06=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> For data read, we always pass an extent_map pointer as @em_cached for
> btrfs_readpage().
> And that @em_cached pointer has the same lifespan as the @bio_ctrl we
> passed in, so it's a perfect match to move @em_cached into @bio_ctrl.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 822e2bf8bc99..d4ad98488c03 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -101,6 +101,8 @@ struct btrfs_bio_ctrl {
>         blk_opf_t opf;
>         btrfs_bio_end_io_t end_io_func;
>         struct writeback_control *wbc;
> +       /* For read/write extent map cache. */
> +       struct extent_map *em_cached;

As mentioned before, this can be named just "em", it's clear enough
given the comment and the fact the structure is contextual.
The naming "em_cached" is odd, and would be more logical as
"cached_em" if it were outside the structure.

>  };
>
>  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> @@ -1003,8 +1005,8 @@ static struct extent_map *__get_extent_map(struct i=
node *inode,
>   * XXX JDM: This needs looking at to ensure proper page locking
>   * return 0 on success, otherwise return error
>   */
> -static int btrfs_do_readpage(struct folio *folio, struct extent_map **em=
_cached,
> -                     struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start=
)
> +static int btrfs_do_readpage(struct folio *folio, struct btrfs_bio_ctrl =
*bio_ctrl,
> +                            u64 *prev_em_start)
>  {
>         struct inode *inode =3D folio->mapping->host;
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> @@ -1052,7 +1054,7 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>                         break;
>                 }
>                 em =3D __get_extent_map(inode, folio, cur, end - cur + 1,
> -                                     em_cached);
> +                                     &bio_ctrl->em_cached);
>                 if (IS_ERR(em)) {
>                         unlock_extent(tree, cur, end, NULL);
>                         end_folio_read(folio, false, cur, end + 1 - cur);
> @@ -1160,13 +1162,12 @@ int btrfs_read_folio(struct file *file, struct fo=
lio *folio)
>         u64 start =3D folio_pos(folio);
>         u64 end =3D start + folio_size(folio) - 1;
>         struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ };
> -       struct extent_map *em_cached =3D NULL;
>         int ret;
>
>         btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>
> -       ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
> -       free_extent_map(em_cached);
> +       ret =3D btrfs_do_readpage(folio, &bio_ctrl, NULL);
> +       free_extent_map(bio_ctrl.em_cached);
>
>         /*
>          * If btrfs_do_readpage() failed we will want to submit the assem=
bled
> @@ -2349,16 +2350,14 @@ void btrfs_readahead(struct readahead_control *ra=
c)
>         struct folio *folio;
>         u64 start =3D readahead_pos(rac);
>         u64 end =3D start + readahead_length(rac) - 1;
> -       struct extent_map *em_cached =3D NULL;
>         u64 prev_em_start =3D (u64)-1;
>
>         btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>
>         while ((folio =3D readahead_folio(rac)) !=3D NULL)
> -               btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_=
start);
> +               btrfs_do_readpage(folio, &bio_ctrl, &prev_em_start);
>
> -       if (em_cached)
> -               free_extent_map(em_cached);
> +       free_extent_map(bio_ctrl.em_cached);

So instead of calling free_extent_map() before each submit_one_bio()
call, it would be better to do the call inside submit_one_bio() and
then set bio_ctrl->em_cached to NULL there,
to avoid any use-after-free surprises and leaks in case someone later
forgets to call free_extent_map(). Also removes duplicated code.

Also, as mentioned before, the subject of the patch is incorrect, it
should mention btrfs_bio_ctrl:: instead of extent_map::

Thanks.

>         submit_one_bio(&bio_ctrl);
>  }

>
> --
> 2.45.2
>
>

