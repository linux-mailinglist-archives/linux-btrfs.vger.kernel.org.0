Return-Path: <linux-btrfs+bounces-11745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687ECA4231A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 15:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E973AFAC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1681624D3;
	Mon, 24 Feb 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjBXn8nO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1F13A244;
	Mon, 24 Feb 2025 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407118; cv=none; b=Wtigi7Tj16qbz5bseygH/Oe4UbyYFcvyE+vgoFrcQA6jWhjnfNS9jomopLWzxvB1ywnbZiUKWrWt0dPitQKOZqXItnbE4OGfnOeFC1rw8LePJ7LTYpO9e/xxawt4yM3WLyIirJaAPjDvdl0WE19+bm3t210I1YJtcp2ttxuBp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407118; c=relaxed/simple;
	bh=Fu3IjRZJNaESo9kXk4aiCl8GEmhNGVIn0NHb/78P/Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0v1EUQREPKlzj2HywIN8K0/2Y7UTXyPEod2FUpve1GK8OOhfTrZ67a04dJkOXE67j2xDF2UnkwSR122bHnY4GhFQLdGJ+UD0mmpMgi9hSXjtZpmJmLVi0bD+bL+/61uKnE01kFAt3yXxZVbQc5naZvQYgQqDkTbGxJnD6c8mMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjBXn8nO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6A6C4CEE8;
	Mon, 24 Feb 2025 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740407117;
	bh=Fu3IjRZJNaESo9kXk4aiCl8GEmhNGVIn0NHb/78P/Cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CjBXn8nOg9VmBgOPvGWV9WjXP3Qo4R6MXxAMcTFlRgCLEKR0c+fq+I8oSGsgj52FI
	 lhHvqMd5E9B1lSgp++7fBsJMRiqJJoINfotbdGo49N6xSScHKBHZxIeNFwAXbjrSWk
	 g99tRHI4Y2vTt/LGzYSPec5A8tG0q+JmBAT2dlWH1rTYjBhruGlwE3qnhgobc5Ko/y
	 bJWZRlQMvxmRp1Ln7fuYLWriwlEST/Nlj3GjsMSDh0GUiIqB1Xdr5B+rwy1jkdIWm2
	 zlRLZiSKWzKqmwv7qOfDkokIxIpJCQHLdRlCIc1OMt94jjXi/S+FQE7zIXbl8nHdxG
	 +S4CgBfc9L2DA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb86beea8cso800255666b.1;
        Mon, 24 Feb 2025 06:25:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDwjLwwIz/ynUaJQ8NIt9Dyfm852R2AzVBbj1ZaVFqXH9+tak14HZ6mqMm+fK7qAcnlqjJmjUiMShd0qR6@vger.kernel.org, AJvYcCVPSjWhmULu/+j8Q96oLx2QXpl+EduqBWH3gprGeLTasF5sRy1gvnlNDxdXqldnqx8xk6fnoqMi@vger.kernel.org, AJvYcCWec0zbILkvKZta7DdAvWUmg1nppuSNTgESt1ycGTFr4WHkGWJRer+1DGxWj6pXWhzoXdXrhapuy+c3dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YylwYhI+Cv44UofutKXFGo35HjpmUY9sQMU5mYz9EpsUsT4enTl
	0lowXhUwXOwPmlTJIyq0C4zHGIFRq12QM5vPBtLStpa4zYdna4LT8pnPCdwUeNWnQb6DHz2R/P5
	DzEj919LcMNoPkVweF5H4df2bwvU=
X-Google-Smtp-Source: AGHT+IG2MO2F44XNQKsXwhRvAAJ8CAvQkLvOkdUllcG08U3Kx54+D03Fsj3xR9fAIBrlUMxDJ+CCrRsBsdHJ4BNYWEM=
X-Received: by 2002:a17:906:30d4:b0:ab7:eff8:f92e with SMTP id
 a640c23a62f3a-abc09aa9d7amr1054883166b.21.1740407115708; Mon, 24 Feb 2025
 06:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224075142.2959155-1-make24@iscas.ac.cn>
In-Reply-To: <20250224075142.2959155-1-make24@iscas.ac.cn>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 24 Feb 2025 14:24:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5nq9jv59YdhPjUuMYVLgyVTG1fuurGdhiqtqCz2K6khQ@mail.gmail.com>
X-Gm-Features: AWEUYZlAcNEwByHsVOvcRHftrsVYQLVGrvui_XCTwsz22yR_jiFpTocxAQnWipI
Message-ID: <CAL3q7H5nq9jv59YdhPjUuMYVLgyVTG1fuurGdhiqtqCz2K6khQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add a sanity check for btrfs root in btrfs_search_old_slot()
To: Ma Ke <make24@iscas.ac.cn>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, jeffm@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:52=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> When searching the extent tree to gather the needed extent info,
> btrfs_search_old_slot() doesn't check if the target root is NULL or
> not, resulting the null-ptr-deref. Add sanity check for btrfs root
> before using it in btrfs_search_old_slot().
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 0b246afa62b0 ("btrfs: root->fs_info cleanup, add fs_info convenien=
ce variables")

Besides what was already pointed out by Qu, that you should explain
how can the root be NULL, etc, this is also a completely wrong commit
in the Fixes tag.

You can only get a NULL extent root if the fs was mounted with
ignorebadroots and there is a corruption in the extent tree (or maybe
we got some transient error while attempting to read it like -ENOMEM).

So ignorebadroots was introduced in commit 42437a6386ff ("btrfs:
introduce mount option rescue=3Dignorebadroots") which is dated from
2020, but that commit you added in the Fixes tag is from 2016, back
when we could never have successfully mounted the fs with a NULL
extent root.

> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  fs/btrfs/ctree.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 3dc5a35dd19b..4e2e1c38d33a 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2232,7 +2232,7 @@ ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
>  int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_ke=
y *key,
>                           struct btrfs_path *p, u64 time_seq)
>  {
> -       struct btrfs_fs_info *fs_info =3D root->fs_info;
> +       struct btrfs_fs_info *fs_info;
>         struct extent_buffer *b;
>         int slot;
>         int ret;
> @@ -2241,6 +2241,10 @@ int btrfs_search_old_slot(struct btrfs_root *root,=
 const struct btrfs_key *key,
>         int lowest_unlock =3D 1;
>         u8 lowest_level =3D 0;
>
> +       if (!root)
> +               return -EINVAL;
> +
> +       fs_info =3D root->fs_info;
>         lowest_level =3D p->lowest_level;
>         WARN_ON(p->nodes[0] !=3D NULL);
>         ASSERT(!p->nowait);
> --
> 2.25.1
>
>

