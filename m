Return-Path: <linux-btrfs+bounces-8267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B808C987673
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 17:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455DD285C66
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAB015667E;
	Thu, 26 Sep 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqkr+WuW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233F84E1C;
	Thu, 26 Sep 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364326; cv=none; b=M+XM7K2E8TmVARWD+/Jg9SmAOGvuSABufmDvhdbULZZRleqvklgnbXjnC9eNbZzhIM43g9zzDG6ddW8KeseSLkKsAO9EBSgzwSoSpOtS6iZ9OKfYJHBjkGPLjL0Y7klEi3Ovlalhx0q8hVQgB6jkr6tMJKseW0t5krL14Fs64zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364326; c=relaxed/simple;
	bh=p3k7qbv2fo+fUfIGF/Zhfvnan8c3NFy/HIGK3Amf6/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjHuWHVKc1MROzMaIcN7c+/umy73Fo6U1vQuRb59SD3lkI2DEiwWI5bGCNC3QHLX8LDoTMTQQKNqSm+/kO0KQzwIbdpSYxkDoAQv0xfEL2JHzVK/ER3Qw5p2jUuM5+WE3Uj8dMKvRVjdg7v6d/1aTNL1x2QCuCkRsBLxL1mDiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqkr+WuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7F1C4CECE;
	Thu, 26 Sep 2024 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727364325;
	bh=p3k7qbv2fo+fUfIGF/Zhfvnan8c3NFy/HIGK3Amf6/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aqkr+WuW+aIAmtSdKAlbnAHJRMPTP9RdqK6xL4Uvnep82aEmsikn/4QMd49langOw
	 4/ON+uH580Q4Q0lvY0Th81QySUmxGYMGibFY8q4YN6F7mP5swUVNCE7nK8qScCW1cS
	 XUYfSoagzN8BdeZsj6BsLGqEh3CdJkt7wKS4Uh91EirmSdcAFgErnV4TWS7Wf+1hbo
	 0THrfoEw7JU8GuPRxAew2/tCdo79YunUvlKz2XYmOidos1SqCS2zv/w84vaOuGuhNU
	 YGCrqBKE6e3THLMh+VJhy9WMVCzj+xGFMVfjuAF4WDWvzlWLqeTBD9/twWrEA+FR7I
	 ZkDSLeLM3MAXA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c5c3a1f474so1170747a12.0;
        Thu, 26 Sep 2024 08:25:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPSwzdseUTKfS5eiblvVl1hsnpkDjR8/AkTl7oM+Xb3HEmVUN5wgXz+IqYHa2GyQ+a/PQmiz3OyL44vyFQ@vger.kernel.org, AJvYcCW/WKJP4hvr1TDOUIloB7LxePrmVgKssBpOvevaGSRi31M0E77RnFhqHO2kAFeoXltz0pyGTFEPPaCFfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt3vnSN1N65A8q7GDAG61JX6BMWUkshKh6NUKBBdToaCD2e+Gh
	QrUFIJh4v1A+cfG417zfosiB0jZrL4Sg0M2ONOboESmYZ4cjiuCfOntA+eyi6XPqy1tNK1dpEo7
	gCdXbDCgNovF2TYChskBbM7og/Lw=
X-Google-Smtp-Source: AGHT+IEEENqGCYv6FQ9us0MuI9s/yTGYxVTzRQ8seA4R5g9hiIJvVggtYITFUlHEhjdfbsmww9wW2ak0ykH7CMbZP98=
X-Received: by 2002:a17:907:2ce5:b0:a8d:2ec3:94f4 with SMTP id
 a640c23a62f3a-a93a066f942mr744184966b.54.1727364324062; Thu, 26 Sep 2024
 08:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926150555.37987-2-riyandhiman14@gmail.com>
In-Reply-To: <20240926150555.37987-2-riyandhiman14@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 16:24:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H447Sf0__CVSmP==kQkyVOQqDwN6Lb48nZ3iDZB8Nokfw@mail.gmail.com>
Message-ID: <CAL3q7H447Sf0__CVSmP==kQkyVOQqDwN6Lb48nZ3iDZB8Nokfw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add missing NULL check in btrfs_free_tree_block()
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:06=E2=80=AFPM Riyan Dhiman <riyandhiman14@gmail.c=
om> wrote:
>
> In commit 3ba2d3648f9dc (btrfs: reflow btrfs_free_tree_block), the block
> group lookup using btrfs_lookup_block_group() was added in btrfs_free_tre=
e_block().

It wasn't, it was just a refactoring and the variable name was renamed
from "cache" to "bg".
The whole logic of looking up for a block group and ignoring NULL,
because it should never happen, comes from:

commit f0486c68e4bd9a06a5904d3eeb3a0d73a83befb8
Author: Yan, Zheng <zheng.yan@oracle.com>
Date:   Sun May 16 10:46:25 2010 -0400

    Btrfs: Introduce contexts for metadata reservation

You have to follow the git history and not blame only the most recent
commit touching a line using git blame.


> However, the return value of this function is not checked for a NULL resu=
lt,
> which can lead to null pointer dereferences if the block group is not fou=
nd.

Just add that this should be impossible to happen, because if we are
freeing an extent buffer it means there's a block group to which it
belongs.

>
> This patch adds a check to ensure that if btrfs_lookup_block_group() retu=
rns
> NULL, the function will gracefully exit, preventing further operations th=
at
> rely on a valid block group pointer.
>
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
> v2: Added WARN_ON if block group is NULL instead of jump to out block.
> v1: if block group is NULL, jump to out block.
>
> Compile tested only
>
>  fs/btrfs/extent-tree.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a5966324607d..be031be3dfe5 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3455,6 +3455,13 @@ int btrfs_free_tree_block(struct btrfs_trans_handl=
e *trans,
>
>         bg =3D btrfs_lookup_block_group(fs_info, buf->start);
>
> +       if (WARN_ON(!bg)) {

Sorry I misled you here.
We don't need the WARN_ON() because btrfs_abort_transaction() already
produces a trace, and I forgot that before.

> +           btrfs_abort_transaction(trans, -ENOENT);
> +           btrfs_err(fs_info, "block group not found for extent buffer %=
llu generation %llu root %llu transaction %llu",

As the line is long, move the string argument to a new line.

Everything else looks fine, thanks.

> +                               buf->start, btrfs_header_generation(buf),=
 root_id,
> +                               trans->transid);
> +           return -ENOENT;
> +       }
>         if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
>                 pin_down_extent(trans, bg, buf->start, buf->len, 1);
>                 btrfs_put_block_group(bg);
> --
> 2.46.1
>
>

