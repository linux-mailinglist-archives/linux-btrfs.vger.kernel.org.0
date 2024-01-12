Return-Path: <linux-btrfs+bounces-1412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4392082BF3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 12:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573B71C23CC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215F67E86;
	Fri, 12 Jan 2024 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE3KEbmx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A167E6D
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 11:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1413C43390
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705059049;
	bh=3ivSCP2RSRhJO8AoFhSzJu8zd43D+mHxR2PrY1Xh8W0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lE3KEbmxBU4wjIEBK4tl10N/qm9GG+ltDtgmjAT87JmpPrsB0/TXyMKAveUjth7OY
	 l3ItA4ZUJZikQZuGLx++STLByiEIU+BPKS1zNa7MW67O18FNrqeLsP2EUKoTISsgl4
	 Ut9yYN2OoL2U42oVPLidz+zwaM8fm3VdnLm+tPa0qPS8t0Rsjj0nEj+ShjqdSH5BmR
	 D+LbwltXb4Geum615ECeXnkdD3yDAcr98TUooGpZVOvU92ZhRvTUagXO1qxDuGho88
	 wMsp8QPVh82lfrfEsn2Hd3qqYzhdezkh/b0lxjMsddxujPrnwYkXC1WT4TT9FBpP0t
	 kKBVKdQDIt3iA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28d61ba65eso740173166b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 03:30:49 -0800 (PST)
X-Gm-Message-State: AOJu0YxEhGexD7WOrr9eiFnHnlhojL0oMm19GHPlBZNlUbyqAfeAUUKo
	lhuGX4FYcWH3ngnIKlkOX+/rj69UjqHjNQqIucA=
X-Google-Smtp-Source: AGHT+IF3+8BPCfbnRDgIxDgctulrSczgTBoOGXG2kXeK1S83y+Bg78hcS7Xjf+Pcsuuy0emAvK8MyeSSTZkOcsfTB60=
X-Received: by 2002:a17:906:a457:b0:a19:a19b:4262 with SMTP id
 cb23-20020a170906a45700b00a19a19b4262mr398100ejb.205.1705059048383; Fri, 12
 Jan 2024 03:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a2c72015288d70b870ded1d6f8aaba1c2cf63f97.1705045187.git.cccheng@synology.com>
In-Reply-To: <a2c72015288d70b870ded1d6f8aaba1c2cf63f97.1705045187.git.cccheng@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Jan 2024 11:30:11 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6JXLFaMxWX-9ba25=2Kcb6X5ig5yJZWcL39CVGq+Foxg@mail.gmail.com>
Message-ID: <CAL3q7H6JXLFaMxWX-9ba25=2Kcb6X5ig5yJZWcL39CVGq+Foxg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: fix iref size in error messages
To: Chung-Chiang Cheng <cccheng@synology.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, shepjeng@gmail.com, 
	kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 7:49=E2=80=AFAM Chung-Chiang Cheng <cccheng@synolog=
y.com> wrote:
>
> The error message should accurately reflect the size rather than the
> size.

The second "size" should be "type".

>
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

Other than that, it looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/tree-checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 50fdc69fdddf..6eccf8496486 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1436,7 +1436,7 @@ static int check_extent_item(struct extent_buffer *=
leaf,
>                 if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_ty=
pe) > end)) {
>                         extent_err(leaf, slot,
>  "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
> -                                  ptr, inline_type, end);
> +                                  ptr, btrfs_extent_inline_ref_size(inli=
ne_type), end);
>                         return -EUCLEAN;
>                 }
>
> --
> 2.34.1
>
>

