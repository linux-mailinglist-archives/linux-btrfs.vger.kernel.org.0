Return-Path: <linux-btrfs+bounces-3554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF0788A604
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510D61C39D6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FBB136E1D;
	Mon, 25 Mar 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY8JRIbY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE35136E01
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369974; cv=none; b=S3mMLwQWfBOLrRgy3AvqqulCF9bFzVdSEmVtBXK/bImqVv5fkokkecOCy1W+ERYEWVWNDQrDcA0/GwRgn0oII2A/PRGM/c86+NEt3jeXi0+os1Nryc3GeM6v304CIeNTGWfCZWkOEIhVrotxJJIJE/feGWvyMtBZJULBghz5xOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369974; c=relaxed/simple;
	bh=DN/ckXJTBxOqj6WOAB5LJMV3rV0A2Ex+lYCiEm1wPQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7Mq0BoPOlndh53iAV/zC8+N9EFXJQE21eq72yrMfEXT+OL3IvROBswpKgfnom6EXyfOvzRfd9AfnzMphyQWX1A2hAcyqbu6QYEt6PYhvdEkcjRFa4qLQNw5UOfNEn3EEadFhve6VcpUf6H6EIBZZFU+o6vNkRjKgWLPdz0g1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY8JRIbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E92AC433A6
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 12:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711369974;
	bh=DN/ckXJTBxOqj6WOAB5LJMV3rV0A2Ex+lYCiEm1wPQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DY8JRIbYOw9iCy/wiq/clYvawGO6a6Qff84dmW9FtdjNSWIDpDDCMIywpS/LPBtrq
	 thiNG0HnxZL8m0mK7oN6rayc0EocWe7gCmr6wEaIE71tnUpe3doPi221fm6fShuXN5
	 7VWAmKEkrtUhU+oAnxq36fU6XhGbn75JdyvCQetf2as7y4s3OliQay68D3wUXeJFUH
	 PL/0Bk7MnwnrWCoJTt4hRk2KA+wJzoEe3Nia4p/hxWgD0TeIyr+9R9gAW2KZLXziSW
	 0dcmRF7Wm+z3sR0677zflxJYVLQZV0oIsgKPHewM2BDlzlM8xr+fXXFjDqGbmmLXAb
	 tzuJ5f3i4tyqA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so737907766b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 05:32:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YxXOkDTJKRayxWkh9dMPbVwnOcj6vQVQhKG8Xr2MG3/dE+IspfU
	/csgx+xKM2WAMicjhRfvvRHiDkQuHjOtGIRabv66UMS4UposODijhM3ITvBSqiZbEIqjHfyHgAo
	02DCtB6spqYSYhFkuEGJze7Dl4tw=
X-Google-Smtp-Source: AGHT+IEteBgP5rj9+s/8CEgWslBPmi6FpKAxko21hU8BM/Q4ZFeVFMazzBvBj0Pj/+wGXNmbv5RCem0qKrIk+bmpMU0=
X-Received: by 2002:a17:906:6b83:b0:a46:9be4:6037 with SMTP id
 l3-20020a1709066b8300b00a469be46037mr4910601ejr.30.1711369972877; Mon, 25 Mar
 2024 05:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9ec01e023cc34e5729dd4a86affd5158f87c7a83.1711311627.git.wqu@suse.com>
In-Reply-To: <9ec01e023cc34e5729dd4a86affd5158f87c7a83.1711311627.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 25 Mar 2024 12:32:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4F1LX++0GVOuRB-EC7EpORPnh6DRDbN6MfOiL0Zq73Rw@mail.gmail.com>
Message-ID: <CAL3q7H4F1LX++0GVOuRB-EC7EpORPnh6DRDbN6MfOiL0Zq73Rw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fallback to single page allocation to avoid bulk
 allocation latency
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Julian Taylor <julian.taylor@1und1.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 8:21=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a recent report that when memory pressure is high (including
> cached pages), btrfs can spend most of its time on memory allocation in
> btrfs_alloc_page_array().
>
> [CAUSE]
> For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
> even if the bulk allocation failed we still retry but with extra
> memalloc_retry_wait().
>
> If the bulk alloc only returned one page a time, we would spend a lot of
> time on the retry wait.
>
> [FIX]
> Instead of always trying the same bulk allocation, fallback to single
> page allocation if the initial bulk allocation attempt doesn't fill the
> whole request.
>
> Even if this means a higher chance of memory allocation failure.

Well, this is a bit confusing, this last sentence.
I mean the chances are the same we had before commit 91d6ac1d62c3
("btrfs: allocate page arrays using bulk page allocator").

>
> Reported-by: Julian Taylor <julian.taylor@1und1.de>
> Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1u=
nd1.de/

As Julian seems to have tested this and confirmed it solves the
regression for him, a Tested-by tag should be here.

Also given that this seems like a huge performance drop, a Fixes tag
would be appropriate here.

Just one comment about the code below.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7441245b1ceb..d49e7f0384ed 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -681,33 +681,22 @@ static void end_bbio_data_read(struct btrfs_bio *bb=
io)
>  int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_arr=
ay,
>                            gfp_t extra_gfp)
>  {
> +       const gfp_t gfp =3D GFP_NOFS | extra_gfp;
>         unsigned int allocated;
>
> -       for (allocated =3D 0; allocated < nr_pages;) {
> -               unsigned int last =3D allocated;
> -
> -               allocated =3D alloc_pages_bulk_array(GFP_NOFS | extra_gfp=
,
> -                                                  nr_pages, page_array);
> -
> -               if (allocated =3D=3D nr_pages)
> -                       return 0;
> -
> -               /*
> -                * During this iteration, no page could be allocated, eve=
n
> -                * though alloc_pages_bulk_array() falls back to alloc_pa=
ge()
> -                * if  it could not bulk-allocate. So we must be out of m=
emory.
> -                */
> -               if (allocated =3D=3D last) {
> -                       for (int i =3D 0; i < allocated; i++) {
> -                               __free_page(page_array[i]);
> -                               page_array[i] =3D NULL;
> -                       }
> -                       return -ENOMEM;
> -               }
> -
> -               memalloc_retry_wait(GFP_NOFS);
> +       allocated =3D alloc_pages_bulk_array(GFP_NOFS | gfp, nr_pages, pa=
ge_array);

No need to add GFP_NOFS, the gpg variable already has it.

Otherwise it looks good, so with that adjusted:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       for (; allocated < nr_pages; allocated++) {
> +               page_array[allocated] =3D alloc_page(gfp);
> +               if (unlikely(!page_array[allocated]))
> +                       goto enomem;
>         }
>         return 0;
> +enomem:
> +       for (int i =3D 0; i < allocated; i++) {
> +               __free_page(page_array[i]);
> +               page_array[i] =3D NULL;
> +       }
> +       return -ENOMEM;
>  }
>
>  /*
> --
> 2.44.0
>
>

