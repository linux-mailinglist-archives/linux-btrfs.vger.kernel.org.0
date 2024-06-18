Return-Path: <linux-btrfs+bounces-5786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C38490C64B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70CE1F2125F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F8F13C69E;
	Tue, 18 Jun 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoMPp6NN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFD2AE6C
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696764; cv=none; b=exx0twXrDsAtrS5idFNbe6Xpz6lzYYFq8I7quQVbKCYnu4U/Lf4GS5hNuTk2boJeCdxGpAH6EIb1Is4G/FXIh0188VQRPfNoGzpgo1Pp8gHqcTh7D5XpFf/lZzVM8uGDirxu3f4hWj9AUySgEqRkESh9h9Ux1lM93bPQ/Nj0xpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696764; c=relaxed/simple;
	bh=DV/ppMnM6w8D0EGHl0Ut2LmtyIDeugCMfIX0OdMygug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pggthJdLVauS5HDaoMXvrzDLuuk4XqPR7q5dtzPL/jVEA6bnzEIYiI2on9t9KycXAgZbV8umDoQYVzMwrgxOQHrLBRBlA5kGHJg+83wKFNYWQQqp+pEq8v5oxDJA62FuLqMKhKUPnrRrzscSiHxhpT15O/b5s/CISCg/EFtlyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoMPp6NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD666C4AF1C;
	Tue, 18 Jun 2024 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718696763;
	bh=DV/ppMnM6w8D0EGHl0Ut2LmtyIDeugCMfIX0OdMygug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LoMPp6NNZ9RuM4LmdjUwzEY0Z6psA6rX12DXI7L/Pk3RFmLoIa1MFG5VlH3XU41M2
	 Nx0l1fZaCQgejq15bBrb33Bb5/cSgLuxO1HT3f9ewuwklX9bRhp0cFWTwxYmJWDwNt
	 BCtOrimcfMf6tjVBjnExUwCIUPD/cpyS3BNbepMFfa8h8bW6pvFhFZ54G5RX6g0INn
	 pinqg/DWIiJioIYw+vrCTqJOnQL2VW4SxZoBXCfWPraBk8FOT+ZS89IpPUFxKsQ5lN
	 p4t7IAMexaNN12mFnZpHgztRB+6a5TVshXVbpYdD55qvPgoNTUi+CwOBpeTX7SAC6t
	 MxFAEVtko+mMg==
Date: Tue, 18 Jun 2024 09:45:53 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>, Qu
 Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix out of bounds write
Message-ID: <20240618094553.68a79daf@dellmb>
In-Reply-To: <20240617194947.1928008-1-alexthreed@gmail.com>
References: <20240617194947.1928008-1-alexthreed@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 22:49:47 +0300
Alex Shumsky <alexthreed@gmail.com> wrote:

> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usually
> read files into huge static memory areas.
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> ---
> 
>  fs/btrfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4691612eda..b51f578b49 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -640,7 +640,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
>  	extent_type = btrfs_file_extent_type(leaf, fi);
>  	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
>  		ret = btrfs_read_extent_inline(path, fi, buf);
> -		memcpy(dest, buf + page_off, min(page_len, ret));
> +		memcpy(dest, buf + page_off, min(min(page_len, ret), len));

Use min3() instead of min(min())

