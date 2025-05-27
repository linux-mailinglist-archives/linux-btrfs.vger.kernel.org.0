Return-Path: <linux-btrfs+bounces-14259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43119AC5ADD
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 21:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0450B1BA4837
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95828A3E4;
	Tue, 27 May 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUjxAihS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643825D1EF
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374659; cv=none; b=mhtx7K95CnEm6+R+x6RZ6pFGJK8gX7SG5QkFs7ImjawnsEkWXAAS+7cGsrlrvCuD0RKfURHU6lh6vCgfPzXb4Zz30SfbvC0Jik1MJkiuuAEbWyKa/yFEwQzCa+l2AotDyCCdVTyntJAEkNNVVw3e9EbUVERfgObc4oOYjkMOPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374659; c=relaxed/simple;
	bh=RvMWXZjVkL0vF23YzRz7NEUZeZIBJPmh6bw5IOzgZoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhFj2Fcnq41UTBLl5uwCTyUSCOCib0AtDobt/5Wmv3Pf4Kp9jwZA47qzPc9pFHZS0IArtU7vKr+BQ4SbrHie5LBCuKW66ZW8eKmj3f1cFAzLblUwoStCibmn/ysj9PyuuHChXOOSCrli57ImZJxEJwMdUr100YJVia9UXGiuoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUjxAihS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0549C4CEEA
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 19:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748374659;
	bh=RvMWXZjVkL0vF23YzRz7NEUZeZIBJPmh6bw5IOzgZoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WUjxAihS9IydysrWIzN6h4Bxw2Tud2fcgZmPVjd8G+w3iVMv8L1FOnr5K2MbXU6EC
	 uDViPEzbZPFRDNzu7XpTZ3ttP++ChWutpHXW/D3gL9VXy2KCe5QwoqxhsC1U6D2i5r
	 me4VhEo0wgKYniMtoXfzE+Q5Tfr6HYNJJmQ/uitpJ3FgwHFRp+gDYNd2xuG8UENLmE
	 mmqqd8qhKxGPeQ1AAlyakyVMtA5auoC5KsYu3y6BLso5t/pEK09ROfC2F2CaS61Iip
	 ++T/i5fzbqUC1A02PpgBO83Bd/9XXb9qxOshBq/lS6SFlK3+xL1pDm1NuQ7LEjWSG+
	 bWUecx8yih9DQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so5118936a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 12:37:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YxWygu9Bo8RiV3A+koo+Y//CvkHUa2wnup5MqtPoOSzk5arB05V
	HgONK+qhD6+YphaE9eAEdsxNBc4NMxUJO14FBI1lwkVssIMIc9+1BHmayj5dBcSZXr83LXoIcO4
	0b0HWr+WXST0ZviVqto1CSdOavzyJbQU=
X-Google-Smtp-Source: AGHT+IEaVE30lJhnfI5CM5ghKkB2z1g/A0ZplQM1ExKhlqedCMTv+3poHg1fc02w1JugupSp/98stXvEbxMqtl3zkOY=
X-Received: by 2002:a17:907:728d:b0:ad4:f6da:fe7e with SMTP id
 a640c23a62f3a-ad85b1d670cmr1459864566b.53.1748374657545; Tue, 27 May 2025
 12:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748373059.git.loemra.dev@gmail.com> <1696139274b2bd4327c008ed6df6f58cb5a8569e.1748373059.git.loemra.dev@gmail.com>
In-Reply-To: <1696139274b2bd4327c008ed6df6f58cb5a8569e.1748373059.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 27 May 2025 20:37:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H47FOG618vY7Ks9ObVrk9fW+qvGw5bJxotmtCyTXDUrQQ@mail.gmail.com>
X-Gm-Features: AX0GCFt9ENkSX33mCOnqZmd6Yb72Oe2wKZVNBrcQjKlGcEigp3ePFa4zQYhwrko
Message-ID: <CAL3q7H47FOG618vY7Ks9ObVrk9fW+qvGw5bJxotmtCyTXDUrQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix refcount leak in debug assertion
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 8:29=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> If the delayed_root is not empty we are increasing the number of
> references to a delayed_node without decreasing it, causing a leak.
> Fix by decrementing the delayed_node reference count.
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/delayed-inode.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index c7cc24a5dd5e..f4e47bfc603b 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1377,7 +1377,12 @@ static int btrfs_wq_run_delayed_node(struct btrfs_=
delayed_root *delayed_root,
>
>  void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
>  {
> -       WARN_ON(btrfs_first_delayed_node(fs_info->delayed_root));
> +       struct btrfs_delayed_node *node =3D btrfs_first_delayed_node(fs_i=
nfo->delayed_root);
> +
> +       WARN_ON(node);
> +
> +       if (node)

This can shortened to:

if (WARN_ON(node))

Besides making the code shorter, it also allows the compiler to
generate better code since the WARN_ON() includes the unlikely tag and
this is an unexpected branch, so we benefit from doing it like that.

With that change:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +               refcount_dec(&node->refs);
>  }
>
>  static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int =
seq)
> --
> 2.47.1
>
>

