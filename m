Return-Path: <linux-btrfs+bounces-10606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020D9F7D09
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 15:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42080160162
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A383225411;
	Thu, 19 Dec 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eezgb7U0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0169D2B
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618199; cv=none; b=eSlidJ15a1EvzCGFNMuluQfaZNIK3k5D5fQUJRXcqMsnimn52fbmt5v8IyBidn8e7zw3U+KKqEw7spxOBpYNFesiT8tXMg7l9KnAu4YJhXcEoZtbWhDpgB5GauVXZgq68an079ArS5YZ7/boXzxM/WBlAxpW1E6S4ut9sIH4juE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618199; c=relaxed/simple;
	bh=5ASMstOO9em0OQZB/6zEI49LhjinHCRP/yrDaPY65cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiQqzzEpZDr8eI2tBEgQ4fW/hDs1+/LDFp+gPWHXaWFj1oWfnobQ6cZFEm9q+SFR58B9+JM2g5HCUvInDQt8JSAsPytjMXOYILMQHmYO+/tALEza3cWgd5c+XAnpbNsfw8Uz9WEXox+A8Jp9i4Lxpl0509pqKW9TKAOgDHswGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eezgb7U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1237AC4CED4
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734618199;
	bh=5ASMstOO9em0OQZB/6zEI49LhjinHCRP/yrDaPY65cY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eezgb7U0KjDs/ioiCUiBPbii81nMHckAuagHGq49ARG+XSy+showpmj/g3TMGjJ0e
	 EdJSs+KNekADwT0gj8ASCk72rhSZYldb1CWrXh8S7Br03B2s+7WNSk9/DQNpENwmas
	 Or2dmHeZVA3UPBt83KuNJOGdhIQ/w5lXb+GGfkNEOXfAcE1tJjwIHxMVuB1NQ1JBzE
	 ArpEdurfvxMQCuwnu8vkX6bN0c6U8E8JjMRvCAeXqTIFY+UImj4IGCO6TmcMPNx9DK
	 sgPQ4kkckL7nz882UKa8jwNC9a3NcjWph+1A/6T+BTixMU04Xgnx2ykjPcSeVwoXgv
	 ftTyNttOTLRww==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso133668866b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 06:23:18 -0800 (PST)
X-Gm-Message-State: AOJu0YwRmzThT48eaDU+c4okgkUNVETeq4taS2MdZKLRxOI8KKfT2d7D
	MvoQCUVDqYTfuZXMRTYLBH3feDV9ALLJQcbeNKOwpyiWEDABIYFj1v3GkpCQcsfpHlIkfwIDNmG
	M2Y59nlaRA8filvGu6l02riJdQRA=
X-Google-Smtp-Source: AGHT+IFNIbQvSNwBg/5WzLUHMS1g0lzCl2TyIH1KrBPV0NT+QlMQc1Oyec4qeHnBHUNYJea60LWvTb1tqrltgYZhUQg=
X-Received: by 2002:a17:907:2d8e:b0:aab:d8de:64ed with SMTP id
 a640c23a62f3a-aabf47abbafmr742167266b.25.1734618197594; Thu, 19 Dec 2024
 06:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <648c181a4b3d2076ee838945232e3b87b5d575e7.1734582790.git.wqu@suse.com>
In-Reply-To: <648c181a4b3d2076ee838945232e3b87b5d575e7.1734582790.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Dec 2024 14:22:40 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4H=ERLpP9i01G=cfz5iOq3hbZgA+31DD5pH_eO4sYAhA@mail.gmail.com>
Message-ID: <CAL3q7H4H=ERLpP9i01G=cfz5iOq3hbZgA+31DD5pH_eO4sYAhA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: handle free space tree rebuild in multiple transactions
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:35=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> During free space tree rebuild, we're holding a transaction handler for

handler -> handle

> the whole rebuild process.
>
> This can lead to blocked task warning, e.g. btrfs-transaction kthread
> (which is already created before btrfs_start_pre_rw_mount()) can be
> waked up to join and commit the current transaction.
>
> But the free space tree rebuild process may need to go through thousands
> block groups, this will block btrfs-transaction kthread for a long time.
>
> Fix the problem by calling btrfs_should_end_transaction() after each
> block group, so that we won't hold the transaction handler too long.

handler -> handle

We could also start the transaction kthread only after building the
free space tree,
it would avoid some transaction commits, saving IO and rotation of
backup roots in
the super block.

But with the free space tree being a default for quite a while now,
and this being
more likely only on very large filesystems, it's fine.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> And since the free-space-tree rebuild can be split into
> multiple transactions, we need to consider the safety when the rebuild
> process is interrupted.
>
> Thankfully since we only set the FREE_SPACE_TREE compat_ro flag without
> FREE_SPACE_TREE_VALID flag, even if the rebuild is interrupted, on the
> next RW mount, we will still go rebuild the free space tree, by deleting
> any items we have and re-starting the rebuild from scratch.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Use btrfs_should_end_transaction() instead of batching
>   Which should be more reliable than batching.
> ---
>  fs/btrfs/free-space-tree.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 7ba50e133921..2400fa5a5be4 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1350,6 +1350,12 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_=
info *fs_info)
>                         btrfs_end_transaction(trans);
>                         return ret;
>                 }
> +               if (btrfs_should_end_transaction(trans)) {
> +                       btrfs_end_transaction(trans);
> +                       trans =3D btrfs_start_transaction(free_space_root=
, 1);
> +                       if (IS_ERR(trans))
> +                               return PTR_ERR(trans);
> +               }
>                 node =3D rb_next(node);
>         }
>
> --
> 2.47.1
>
>

