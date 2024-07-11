Return-Path: <linux-btrfs+bounces-6364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6392E0AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 09:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEC528108C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790413D8BA;
	Thu, 11 Jul 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olYkCL1o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838913A406;
	Thu, 11 Jul 2024 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682291; cv=none; b=h4WYAeI2b5TULiM6TZdhEoCbbTRrfF1f3vnkLVAYNxxlqTpk+ybMoZ29JU5j5SGXFpDWoeyVhqlTJuAhv1CXieZ7Rf7ROI5XTgaTbI9GlpY9K9jpftTDvalbdKHpfvSeyF8CpRd9daoEH6/fpbuo7VnvxdA1xg+0tw++r2eZrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682291; c=relaxed/simple;
	bh=Kubu7iLQr57nLBjUBPT4riwgm3m1g6y0MJo1CpU5kCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoqiXslUke/3UvDhEmLzTQ+tSM0kuagcpEelPQ+lUzXFomXPtxlPAgddaALH7A036nfHSNo53VpzH7r3nCb6E/S4HZhkWXgzQXpSiBqxRfZorVdNsfdDdTy0lVkInUId3alJkJup927a2vztEEsggP8RmOM/NyELJ8iq+G2NuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olYkCL1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D01C116B1;
	Thu, 11 Jul 2024 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720682290;
	bh=Kubu7iLQr57nLBjUBPT4riwgm3m1g6y0MJo1CpU5kCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=olYkCL1oQV4t20a45Q3N3WeWUK9SPgjLrsv/EgY4GZkW3medrNJtjI/2mza104nNj
	 SjJeIJ30HZqdQGEIuKjSJQUBjIB8bpJWc9PmvXxGiwDD9MYjBIWQC51BS/d7iGkVpA
	 nP9UOWyhy5Eu19AEtqJnP8DX/05NuYnH8pdnHAskRC/rTNnFaeOzGaLm3827wPR44D
	 Wt0408QjrdBjLRmOxVc8WObeTCLLvc3D4v3oDMbHKOT1NInIkk2yh2KheWmEx2/gXx
	 zg/FbBoH/bgC458jS+C8tWLnacapeTzM9egkEIlSJLC7iIsnDacsFbq+ZjZDL55UuY
	 1QK8pBJCOgteA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso71003066b.1;
        Thu, 11 Jul 2024 00:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1gTGWxWg6cUzTGseoZPHCpv+y+/y1j8boi8U99YVjc/oElp/KiHj+guSyhBEzl3JHCLXzAzjSb/GYANIKNb1xMpgKefjDCg==
X-Gm-Message-State: AOJu0YxRVzR4muLSeT/A7LRDepZa93osgoKZYWySZGnn2hYU/I60dqrR
	jkDdKZxAgtDJ+xlxWxTL9Pq3H6QIr3I5SjV5MZTKssNcpg4+J/E/zQw0ECqsLMeCyGaebfLCO95
	YcEpu6ZG9kYMlzO2HLTDM1x4X+os=
X-Google-Smtp-Source: AGHT+IHEU6nwwQQY2cO2tFLwgipi0QR2Oy4//qYYLlw/DdKKpibSU8gHv+SGMWxZO33hWkWoAn+6uy1Igb/VbUvR1W8=
X-Received: by 2002:a17:906:7951:b0:a77:c080:11fa with SMTP id
 a640c23a62f3a-a780b88350emr663554166b.48.1720682289364; Thu, 11 Jul 2024
 00:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e7ee8ec1731b5d3d44f511b075fa2edb0b38661.1720654947.git.wqu@suse.com>
In-Reply-To: <6e7ee8ec1731b5d3d44f511b075fa2edb0b38661.1720654947.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Jul 2024 08:17:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7NoUN8bPGis-A6VO7t4+YRVEykcGfBM+DoAkHU=bYPAA@mail.gmail.com>
Message-ID: <CAL3q7H7NoUN8bPGis-A6VO7t4+YRVEykcGfBM+DoAkHU=bYPAA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/029: add fixes for the kernel behavior change
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 12:48=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Since fstests commit 866948e00073 ("btrfs/029: change the cross vfsmount
> reflink test"), the test case will fail for older kernels (e.g. 5.14
> kernels from SLE).
>
> The failure is a false alert, but it would still take some time to
> figure it out.
> So add the fixes tag to make it more clear that it's a kernel behavior
> change.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/029 | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tests/btrfs/029 b/tests/btrfs/029
> index 9b56cc73f818..16d9dc2fcc19 100755
> --- a/tests/btrfs/029
> +++ b/tests/btrfs/029
> @@ -23,6 +23,11 @@ _begin_fstest auto quick clone
>
>  _supported_fs btrfs
>
> +_fixed_by_kernel_commit ae460f058e9f \
> +       "btrfs: remove the cross file system checks from remap"
> +_fixed_by_kernel_commit 9f5710bbfd30 \
> +       "fs: allow cross-vfsmount reflink/dedupe"
> +
>  _require_test
>  _require_scratch
>  _require_cp_reflink
> --
> 2.45.2
>
>

