Return-Path: <linux-btrfs+bounces-15457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A09CB01680
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D235C27CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0B21883C;
	Fri, 11 Jul 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmAJmw1h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D01F582E
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222935; cv=none; b=eAych6HyHs7KzQPVNpzIp+2g6QROgncNOG/DxxQ634aleJbYM1wNYzfzkvrgZqkzb8BUKjjrabjfk0FIyNbjMeg7kGa+UMiEBn4GyT3dHhBXZvaePwF4aSE+IoAUo6TKPNCL8SsstnQgkTi1h/d5GMDT5PyWnjI9anNVCezyu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222935; c=relaxed/simple;
	bh=DszSCLMgklOFKVchWKrwjJ6JF5KBFh4w27J9ESf8upQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPoLgyvkbBIAJkBoNLnOV3r8eR+rvB8rkRff7Ql6AiGv3Y15Guvewr6UEoC6U+ySNjCnO/b58Y/Fr0hORspHEt4Yh1q6KAIPne/vV4LQmZWM7TEirz71aasv8MBJltYqzERIf54vW2rc0Zw04IT918kbjTxkouMPTzbbWRUtxqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmAJmw1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB43C4CEEF
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222935;
	bh=DszSCLMgklOFKVchWKrwjJ6JF5KBFh4w27J9ESf8upQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NmAJmw1hH1StCAV6KuGAeOEpVvuuNIQhKommwd1RXu7rOC/2M8ZlG/coKX7lwCdfz
	 sqQA9fWXoVk3aiiM5AHp0gc+wzBQtFNabcbaCLwtJ7GEkm+qvPVzNMIzh94ijjGa1i
	 1SgEzvRoDSi6qsvDePUxD+yOdzwNWeIzmLTbUYNFu491sqy2N+nnD71nbQsSj+qqSr
	 31FRKhDdaPY8r52RqsHQf6jVGyMVRV/ahfyn2xBC7IEMuA3JrlW0pTLFir38bixr1a
	 C6uQyCwjl+Yzn3jSqgOUdP1+y/deRzzMi+E3w2gtHq4Ael3hFtdypx47V7E2HX4L6+
	 I/DlgHa2lLIrQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so3522564a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 01:35:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YzkJw8D/c0rCDfDxaCZsn913AqQX+EtS86mF7EHbR2XvzrxlJoz
	vkLrex7x8ORiRNA6WohXFswE0BaFAEwaBtu//Lv70KjWELP8ceDkV/FJ6sDv0AcvJVOSfg3KB6v
	CmVqJfNZ4sxejMEmljReerJBlfeMpwe4=
X-Google-Smtp-Source: AGHT+IGO65PWhIjS1VmvJOHsgwWF+3pjBpvakJbZ/YGjuHu/zL6Yd/NZs93AJpOGKwtCauvKOJvGG9hph8HEH13zwGc=
X-Received: by 2002:a17:906:d7cf:b0:ae3:53ac:2999 with SMTP id
 a640c23a62f3a-ae6fc21e1dbmr232150866b.53.1752222934279; Fri, 11 Jul 2025
 01:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
 <1f074a1d-c423-4edf-a7ee-4642d3565759@gmx.com> <5a5e64ef-97cb-4540-915b-db6bece862b0@gmx.com>
In-Reply-To: <5a5e64ef-97cb-4540-915b-db6bece862b0@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 11 Jul 2025 09:34:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7a0PKYRssxfSGRGvqHp6BZGpPY_vDQpmWhmYxADFih8g@mail.gmail.com>
X-Gm-Features: Ac12FXxkPIgMw167s1m7D3ABgrjz8n0M9yU5rFs3nKmQWLcgbJsau7KDiHlJjvc
Message-ID: <CAL3q7H7a0PKYRssxfSGRGvqHp6BZGpPY_vDQpmWhmYxADFih8g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: set EXTENT_NORESERVE before range unlock in btrfs_truncate_block()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 9:02=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/7/11 17:16, Qu Wenruo =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2025/7/9 17:56, fdmanana@kernel.org =E5=86=99=E9=81=93:
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> Set the EXTENT_NORESERVE bit in the io tree before unlocking the range=
 so
> >> that we can use the cached state and speedup the operation, since the
> >> unlock operation releases the cached state.
> >>
> >> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> >
> >
> >> ---
> >>   fs/btrfs/inode.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index d7a2ea7d121f..d060a64f8808 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -4999,11 +4999,12 @@ int btrfs_truncate_block(struct btrfs_inode
> >> *inode, u64 offset, u64 start, u64 e
> >>                     block_end + 1 - block_start);
> >>       btrfs_folio_set_dirty(fs_info, folio, block_start,
> >>                     block_end + 1 - block_start);
> >> -    btrfs_unlock_extent(io_tree, block_start, block_end, &cached_stat=
e);
> >>       if (only_release_metadata)
> >>           btrfs_set_extent_bit(&inode->io_tree, block_start, block_end=
,
> >> -                     EXTENT_NORESERVE, NULL);
> >> +                     EXTENT_NORESERVE, &cached_state);
> >> +
> >> +    btrfs_unlock_extent(io_tree, block_start, block_end, &cached_stat=
e);
> >
> > Feel free to use the same cached_state for fallback_to_cow(), which is
> > calling btrfs_clear_extent_bits(), which doesn't benefit from the cache=
d
> > state.
> >
> > That's the only other location where I can find an extent bit operation
> > after extent unlock.
>
> Sorry, I mean extent io tree usage without using the cached state.
>
> There is one other location like btrfs_inode_set_file_extent_range()
> which is just btrfs_set_extent_bit() wrapper, but without the usage of
> cached_state.

That one implies add a cached state parameter to
btrfs_inode_set_file_extent_range() and not all callers have a state
to pass, from a quick glance, only btrfs_cont_expand().
And for btrfs_cont_expand() it would be useful only for the first
iteration of the loop. So not sure if it's worth it adding a new
parameter and passing NULL almost everywhere else.

Thanks.

>
> >
> > Thanks,
> > Qu
> >
> >>   out_unlock:
> >>       if (ret) {
> >
> >
>

