Return-Path: <linux-btrfs+bounces-14459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE6ACE1EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 18:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9BF165431
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBDB1A2391;
	Wed,  4 Jun 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc6BhYuM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332C4C7C
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053260; cv=none; b=T3jyxPed2gLphAS+bSk7mmJa1ssEkeL6dniiucYWx6uPgMhTBG7axSvPkJKCF8bjnRwn5kMpvDyTYBkK9BGYHyleMSa6OQxBb1WcuaY4/NzwIBdLF2Cgb6H5bs2NksIXwEBZQUNVR15eY54waKx2JMyBUgA0oFw58HT6w3QbnnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053260; c=relaxed/simple;
	bh=Av57MtcrrOBvQhujs4Ci+waB84EKyVEHg1gRjbqsqHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pI7DpmheV6IqRYNlTncH6u7em5yTNRbkJ9FCGvmh0TJdytZNYTSBj8S4DpY0jgKAiS4WmBy176raA3A8pIY7gmHHNUqc4RMKZanzD/jaxLWriS6SZwEu3MZzD4R6RPO7rZpruxUCcwtaaXCD3oUk79U8uOKmS/XOdM5NzV+pFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc6BhYuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2338BC4CEF0
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749053260;
	bh=Av57MtcrrOBvQhujs4Ci+waB84EKyVEHg1gRjbqsqHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wc6BhYuMLqimZ/PWQ97oIGXpYaODXAJzoiTcok/Hq4hYwac0yscYX3xsC6XGRaYiG
	 tLmdkV1xeHGee2VQ+1pNcqApFlYztpM46rUNEzC/XvwDDz2i/6doKaw2s1wYUiyGta
	 sWGi6DbUYc9lyNIRoU3kR2r7JpKdBjPWLBqNUeHAqGSb9m4d3QJItox78EXU7WcyEd
	 kieDu/nM3Sz8qLxH4rVUCdzaATRIu3UMlBRw16TZ4m16SpO4XfHnEfqH8IYVyB/uie
	 ruPFp9uraKxpxrP9fQRDAtLwCAVxnBjZPw8E0NsCg4l/jrpBomAJrR0+yobWy7swVJ
	 Tdxkl22NnBGJQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606bbe60c01so3708444a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 09:07:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy7IifzEGKqkwaB0kKsh/GQAfuQlT9bzpVIiA2oRmSlkAju99kh
	3Zgb7CHwEdjfmBycOXsmUvHWU+C8v6C4egA4IXSJS7EBy+vaUmtWaO9SYHK8eh1eIWjNTRXUL+o
	HMHmpVqn4L1E1z6/1rQ+sGAME0ZitRGo=
X-Google-Smtp-Source: AGHT+IGf/9m24Mt3Fv6ekidv1rw2iEXk4CuNzhktJKz9Fqa44+b9AeJNTfE9XJrQTcE6JXSVcGaWgdt8keASntifmP0=
X-Received: by 2002:a17:907:7289:b0:ad2:450b:f8df with SMTP id
 a640c23a62f3a-addf8c91ef1mr262649066b.8.1749053258601; Wed, 04 Jun 2025
 09:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604134710.10895-1-sunk67188@gmail.com>
In-Reply-To: <20250604134710.10895-1-sunk67188@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 4 Jun 2025 17:07:01 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7tHk1YOOozZOJU7R53mm6eTxj_iPRWQ5jGXqTspLJmfg@mail.gmail.com>
X-Gm-Features: AX0GCFsnQTSJFLz3qSL_MGh5td6xhOFSQqdqEsDU4prymcsC5d7OCabj9Ye2zf8
Message-ID: <CAL3q7H7tHk1YOOozZOJU7R53mm6eTxj_iPRWQ5jGXqTspLJmfg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: update comment for fields in btrfs_root
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 2:48=E2=80=AFPM Sun YangKai <sunk67188@gmail.com> wr=
ote:
>
> The inode_lock field of struct btrfs_root was removed in
> commit e2844cce75c9e61("btrfs: remove inode_lock from struct btrfs_root a=
nd use xarray locks")
> but the related comment is not updated.
>
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ctree.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 71fa42ca04fe..9dfe2dcd4a37 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -224,16 +224,10 @@ struct btrfs_root {
>
>         struct list_head root_list;
>
> -       /*
> -        * Xarray that keeps track of in-memory inodes, protected by the =
lock
> -        * @inode_lock.
> -        */
> +       /* Xarray that keeps track of in-memory inodes. */
>         struct xarray inodes;
>
> -       /*
> -        * Xarray that keeps track of delayed nodes of every inode, prote=
cted
> -        * by @inode_lock.
> -        */
> +       /* Xarray that keeps track of delayed nodes of every inode. */
>         struct xarray delayed_nodes;
>         /*
>          * right now this just gets used so that a root has its own devid
> --
> 2.49.0
>
>

