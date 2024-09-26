Return-Path: <linux-btrfs+bounces-8238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3E3986F6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 10:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FD51C225E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C271AB6EE;
	Thu, 26 Sep 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM6AilHz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849A1A7252;
	Thu, 26 Sep 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340973; cv=none; b=nFW0pPs2AgIx9OQx/PhUCoQjz6/86sak6VGlPBJZGldEh0lWcCjoVRGizc6EAmQu49nf8gsUiMdcxADWDwR/Z/EVDV70z1b9pNW428WoZtv9JvT/Zsse9jcz+cCLHg+eSeTl/OqUiM4sGLVGCktiG03dDHTzUNcOOzOO0E3M8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340973; c=relaxed/simple;
	bh=vpkXEpKybJDncqHsEf/0PLLjsfAU3N4qHOv8jxozlLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7ZCcBUgiNd2AHrirYjM1gFS93nuMC5UZJYwlD1hSrsjWN+FNNrZJj2kSStF1UGl9D9TOLEat+OfpmUo7uhiJqddTnDfU0NcHRxKJpadOjahy96wlXJgyOO2MDaXa+IikQe1lCuwlB+j/5Ztzymshzu4qT74Fdob7GNK7PxCmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM6AilHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8FBC4CECF;
	Thu, 26 Sep 2024 08:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727340972;
	bh=vpkXEpKybJDncqHsEf/0PLLjsfAU3N4qHOv8jxozlLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KM6AilHzA+NTD5jm/gvAgFZuByWPwMiI3yvn2vkUc4eB4jHrWwwIwHSOPGRbY50Pa
	 jqCywrf8WbEikc2f7yv5e+cs7FvifHu/UvBo2f282B3o/81Dai0et/PswZKdE2mqkk
	 ryoACtIN3ixnz8B02xed10K/Q/X1/XWFlBuweek+9BsUHmRDHNxhO166LFYN0n6PFy
	 pwqJE06njaBds+jdkBkfD0XKtGIykOTRiVCCfbVBBWWXHeyGPDdlatu/ZQZvcbNfIq
	 YQu8XdMKfTuWLzxeQSMMRQWVgshyg/3k/ah4u+OomYi+i+VoCrefBab0j4Ef5nfKKz
	 4VpvMYzWmLtow==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d64b27c45so105758566b.3;
        Thu, 26 Sep 2024 01:56:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVX/Q2OWXDIY+B4QCXwQ97Pi9j+Qbt+rrIsmrU80j2LGhOrNSlIlIJpY0lsN0Wajo7zThCpAY7Pv7n0/Wgx@vger.kernel.org, AJvYcCWfQlOpJEMu0wRKkmG7ZvXTAZ+Ks25bZwznakcmrx6WpnHFlAiNWeCehzeWRTWuPIHPi+IumUp8Q6i8kA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43/dSrIiULLrCVO3QOBCXFTTYBL1iLXqN1Fu8ggQBGUFVRmzp
	kD33x/foCM/D8uNmbr+Nls7kPf0F/z4+Hw7D68S73Nk2Pc13EASVLf0ShYZgD+G9aZromkHVN0i
	ASYh+XPs8Gan/kWfsxxMssnRlm38=
X-Google-Smtp-Source: AGHT+IGwv5COqIIkFVRj/th/Gliz1VNcfblucTvd75jdXUBdE/ZzldXRuUWkKawJ5ytm0JBF7ajrBugQU6DIQSlgRyo=
X-Received: by 2002:a17:907:f199:b0:a90:348f:fad7 with SMTP id
 a640c23a62f3a-a93a03b45d1mr501420366b.38.1727340970990; Thu, 26 Sep 2024
 01:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926074947.39415-1-riyandhiman14@gmail.com>
In-Reply-To: <20240926074947.39415-1-riyandhiman14@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 09:55:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5vV1MLODuCHr1p4Dx6tMGOMeqxDnTGMsDz290kw8Vsew@mail.gmail.com>
Message-ID: <CAL3q7H5vV1MLODuCHr1p4Dx6tMGOMeqxDnTGMsDz290kw8Vsew@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add missing NULL check in btrfs_free_tree_block()
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 8:50=E2=80=AFAM Riyan Dhiman <riyandhiman14@gmail.c=
om> wrote:
>
> In commit 3ba2d3648f9dc (btrfs: reflow btrfs_free_tree_block), the block
> group lookup using btrfs_lookup_block_group() was added in btrfs_free_tre=
e_block().
> However, the return value of this function is not checked for a NULL resu=
lt,
> which can lead to null pointer dereferences if the block group is not fou=
nd.
>
> This patch adds a check to ensure that if btrfs_lookup_block_group() retu=
rns
> NULL, the function will gracefully exit, preventing further operations th=
at
> rely on a valid block group pointer.
>
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
> Compile tested only
>
>  fs/btrfs/extent-tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a5966324607d..7782d4436ca0 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3454,6 +3454,8 @@ int btrfs_free_tree_block(struct btrfs_trans_handle=
 *trans,
>         }
>
>         bg =3D btrfs_lookup_block_group(fs_info, buf->start);
> +       if (!bg)
> +               goto out;

We are supposed to be able to always find the block group to which the
extent buffer belongs to.
If we don't, it means we have a serious corruption or bug.

If that happens we want it to be noisy so that it gets reported and we
look at it.
Letting a NULL pointer dereference happen is one way of getting our attenti=
on.

O more gentle and explicit way would be to have a:    ASSERT(bg !=3D NULL);

But certainly not ignoring the problem.

Thanks.

>
>         if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
>                 pin_down_extent(trans, bg, buf->start, buf->len, 1);
> --
> 2.46.1
>
>

