Return-Path: <linux-btrfs+bounces-9597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773F99C7521
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E36C1F23356
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707DE13635E;
	Wed, 13 Nov 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEBIBvVT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C141C92
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510114; cv=none; b=klEXoHJAs4tn3oKtO2g2Mf098rMU5j8MgWwsTDzsmpeE5A5aVHXj+cCnV8jWBOwLtmocZw+p91tlf8La0KMrvqxWNsXFCVotPjn7ePvKlzHnyFEzQEtHcYwj1ku6b7is9sOqs+2/51RyP1A2UbzRAPr2JuwfuV/cc3riRMrP2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510114; c=relaxed/simple;
	bh=Ri1g+rx6ZyBqjKTu+qGGgDWfqQqSHO9fEYzRwrj0/aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRTcGXsY5zv7ABm3I6XEOvT1wfKQw0/QP13Eo2lTmlkHSmL395QTiCaOTsikypJwyU4A6TRwloibTNHrQAnYV3fF5vDruvQYoh7/1z1A5BsuC9b/ucZkMtFXHmre7ugt6X8q4ledQRCRpuDJBSswoXRR8TB3PqdxmqZzLinMyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEBIBvVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4ACC4CEC3
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731510114;
	bh=Ri1g+rx6ZyBqjKTu+qGGgDWfqQqSHO9fEYzRwrj0/aE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FEBIBvVTDZn4urTkN8fRd7Pca3aMcDR8PBt2Brl/iSczZBX/JNgGCN49gFZqj9FVG
	 xfuLk0Ua1u6Xz5JIGhvQHsosv8tkIYKsEcP5wfKmCkAJMTW7d9OPveBthjQTgsAwwZ
	 BhrRBmbwWxA137j9NWkjSsDID52bqLd1gptkrI8ZME8ADz5VSIBJjS3eV5u0Q+2UOR
	 uqmS8o+2U7z/mGraBddL4xCExkdjRTvb4merVGFHu2hrblv+dqaCnOWyHhhypcpN+9
	 lSTXw9AK8w3JXfll3HgIyo+HLQQKYV0sSwqRIfqsPa7t5g76F2HjC8SAJor0CxmAd8
	 3q+WC9wBUiwRg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so1177026766b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 07:01:53 -0800 (PST)
X-Gm-Message-State: AOJu0Ywy2nTMoNRJySY7HJzPCFuqiC7RkVaOkMAcof/J36xhOB4cuk2S
	Lx3zUstBvVA3Re2aZQd7igxDUm1nmCzVyl5sIb4nRu2YGCEEYDxuHF9Qfy1v6GmQgvhysGATqiA
	2QQhwLyj2813oa1Q1igd+LnRXr5Y=
X-Google-Smtp-Source: AGHT+IG7Krr5z971w0JZdQGxTosV/h3TwUyAaMCVC1SBml3XfF6kKa4l7eQBnaAfgaQ9eCgKbjI7eW0mdFAWYlMeMEg=
X-Received: by 2002:a17:907:1c9e:b0:a99:eedd:6466 with SMTP id
 a640c23a62f3a-a9eefee4dbbmr2091604966b.19.1731510112592; Wed, 13 Nov 2024
 07:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
 <794af660cbd6c6fc417a683bfc914bbf9fb34ab0.1727434488.git.fdmanana@suse.com> <42062cf0-e5fd-430f-9aff-51a4bb9ca3ae@opsone.ch>
In-Reply-To: <42062cf0-e5fd-430f-9aff-51a4bb9ca3ae@opsone.ch>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 13 Nov 2024 15:01:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4ufOCatWrsMoDLCfMmZNddFirO6P+WwDBJjV3Y+=cSAg@mail.gmail.com>
Message-ID: <CAL3q7H4ufOCatWrsMoDLCfMmZNddFirO6P+WwDBJjV3Y+=cSAg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: send: fix invalid clone operation for file that
 got its size decreased
To: Markus <markus@opsone.ch>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:07=E2=80=AFPM Markus <markus@opsone.ch> wrote:
>
> Am 27.09.24 um 13:03 schrieb fdmanana@kernel.org:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > During an incremental send we may end up sending an invalid clone
> > operation, for the last extent of a file which ends at an unaligned off=
set
> > that matches the final i_size of the file in the send snapshot, in case
> > the file had its initial size (the size in the parent snapshot) decreas=
ed
> > in the send snapshot. In this case the destination will fail to apply t=
he
> > clone operation because its end offset is not sector size aligned and i=
t
> > ends before the current size of the file.
> >
> > Sending the truncate operation always happens when we finish processing=
 an
> > inode, after we process all its extents (and xattrs, names, etc). So fi=
x
> > this by ensuring the file has a valid size before we send a clone
> > operation for an unaligned extent that ends at the final i_size of the
> > file. The size we truncate to matches the start offset of the clone ran=
ge
> > but it could be any value between that start offset and the final size =
of
> > the file since the clone operation will expand the i_size if the curren=
t
> > size is smaller than the end offset. The start offset of the range was
> > chosen because it's always sector size aligned and avoids a truncation
> > into the middle of a page, which results in dirtying the page due to
> > filling part of it with zeroes and then making the clone operation at t=
he
> > receiver trigger IO.
>
> I came across this patch/message after I had the "failed to clone
> extents" problem 3-4x on Debian 12, 6.1.0-27-amd64. For us, it only
> occurs since we periodically run a Btrfs balance via Cronjob.

I don't know what Debian's 6.1.0-27 matches, but upstream the fix went
into 6.1.113, and the bug first appeared in 6.1.107.
So for 6.1 kernels, it only affected releases between 6.1.107 and 6.1.112.

So check if that kernel corresponds to 6.1.113+, and if the issue
still happens, run 'btrfs receive' with -vv and provide the output to
help figure out if it's the same issue or something else.

>
> That's why I'm wondering: Is it possible that Btrfs Balance increases
> the likelihood of the problem occurring?

Balance doesn't make aligned extents become aligned and vice-versa (if
so it would change file sizes and cause corruption), doesn't make
extents that were not shared become shared and vice-versa, and doesn't
do any changes to the extent layout of a file. So, no, balance is
totally unrelated.

>
> Best,
> Markus

