Return-Path: <linux-btrfs+bounces-11776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038EA44405
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DC5164C63
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AA326AA93;
	Tue, 25 Feb 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqX4RTTI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F67221F20
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496326; cv=none; b=X2p89C9wIgYHEA9qFCBCHmnktHmx6tEtDUYES/+s7wTfyQ/gnPhVqX7kc7MUkVyzloluqnq+g2p/6l/64b7fy4TZPOETMBy9JwSsFrcNQXnv3GG9NpA/uAL3Q3/+XYv00Ze1VcWMe3K9VDSchAwLzWzVY16SBRhFOPDPC/E1r/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496326; c=relaxed/simple;
	bh=HG4UokqaOOPJ5IeCbL2Oz6XUbDGjpwrA1bpIz67KBLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2Uis5sSZ8Lv7w5iLQ527bES6Zh+J+1I2x5SZmqg/xdeVNPP5AOH2N7nBL7gNzTcL38bPGGIPuTgPfRBRP4XwS+5yWhaWeE4Zg2ARZznoobdTRUVQDUFC5d4mlZrdBRbaIYR8Moqbh9OEd3YBrQW53F4/nQTMqhX4PpehjyezTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqX4RTTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD9AC4CEE6
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740496325;
	bh=HG4UokqaOOPJ5IeCbL2Oz6XUbDGjpwrA1bpIz67KBLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TqX4RTTIVZkq3xREIcq/X5siJUQWcLY462mCLJG+MxJYQVSPVcr5UnbLH1I/l/lag
	 tQ0lbbU9LbLCTN124CoRd/+BZLF/Wg9vMAurbWszd/Z2VazP73OEXVEYrqCAKZm8eu
	 TwY0PABmIUaH53sJSLCW1GnH8sAgGijtdw95SxGeVYJu+TMxEI1vVFybMfxBtQ4JfR
	 wmp3AF3XI1SjDJ5K/7StQC2VzKuFtSvVbWtggI+Rk8uPNsvfs/G3kA1jfH/6LAnxgk
	 mTxeG9pXoEoSugk4Hl9vqgo1ss5e4R3tsIdg/jYggm6o8VV0T2nmcreoHHDjYigKit
	 57l36+aUVkoGQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abbac134a19so876675666b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 07:12:05 -0800 (PST)
X-Gm-Message-State: AOJu0YziKkld9yB77BKIZNrRccUaZV9Td2FfirNGE1zXnFLuEccIGssd
	gswXY571W5mNJP6d6ptYrMP6i8fSPcWXnISp250leaqpygh/ChtGTfY+N8D+J1zGqfdx7C30Ybh
	cgivMZmSLJwxOFm73ccxvxOSA0Lk=
X-Google-Smtp-Source: AGHT+IHSPQIHTTrbfhYwRXq7oieBVum+W592VIeKFIWABHcIeMEUoUse+ujkfac8DhB/PvK7z3nK2EgZ8UiMayQjW7w=
X-Received: by 2002:a17:907:98b:b0:abb:b209:aba6 with SMTP id
 a640c23a62f3a-abed0c5c015mr446561266b.3.1740496324479; Tue, 25 Feb 2025
 07:12:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <ee3f2825c85a104f23fb3703052383340fb676ce.1740354271.git.wqu@suse.com>
In-Reply-To: <ee3f2825c85a104f23fb3703052383340fb676ce.1740354271.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Feb 2025 15:11:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4SUc4NRUjonXV4rMr6T3_xGP+agj_QDVQhvZgnPjjY_A@mail.gmail.com>
X-Gm-Features: AWEUYZn6SPdwn5uK_i7EPqXKqjJnF0LSZ3VmLQWv9Xpub9uvQNdByuQQRVQHFFc
Message-ID: <CAL3q7H4SUc4NRUjonXV4rMr6T3_xGP+agj_QDVQhvZgnPjjY_A@mail.gmail.com>
Subject: Re: [PATCH 2/7] btrfs: fix the qgroup data free range for inline data extents
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:47=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Inside function __cow_file_range_inline() since the inlined data no
> longer takes any data space, we need to free up the reserved space.
>
> However the code is still using the old page size =3D=3D sector size
> assumption, and will not handle subpage case well.
>
> Thankfully it is not going to cause any problems because we have two extr=
a
> safe nets:
>
> - Inline data extents creation is disable for sector size < page size
>   cases for now
>   But it won't stay that for long.
>
> - btrfs_qgroup_free_data() will only clear ranges which are already
>   reserved
>   So even if we pass a range larger than what we need, it should still
>   be fine, especially there is only reserved space for a single block at
>   file offset 0 for an inline data extent.
>
> But just for the sake of consistentcy, fix the call site to use
> sectorsize instead of page size.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fe2c6038064a..0efe9f005149 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -672,7 +672,7 @@ static noinline int __cow_file_range_inline(struct bt=
rfs_inode *inode,
>          * And at reserve time, it's always aligned to page size, so
>          * just free one page here.
>          */
> -       btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
> +       btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL)=
;
>         btrfs_free_path(path);
>         btrfs_end_transaction(trans);
>         return ret;
> --
> 2.48.1
>
>

