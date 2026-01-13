Return-Path: <linux-btrfs+bounces-20456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F49BD1A897
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 18:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93760301E589
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4052A2F2607;
	Tue, 13 Jan 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2Vzuzi0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27D50097B;
	Tue, 13 Jan 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324340; cv=none; b=c3oBtSZ8K7CJd+2UNVvHjMuK8c5wvOts/ONG+5NvTUs0ywCcGIuUqtSy2Sf4kFPUhYed+TaMZTrwSc45CXph9tb0xeg1/6pt4cnl8oQUN9jWao/a9OjrdjSI8mcyE6iMV9B8cgHwJP82EgC2NkCrXHSnHndQWVoq9UbU8weuOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324340; c=relaxed/simple;
	bh=C/2SQPl6UjUQTRIIYmdGNIwQsNZmauOxZmV+h883hUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSe+QFwo5Zugq6ZJG7YCzxw+1c959j2BiNwBgHdjmNsKMsP61NOvmOeZGyfcFLJJNnpYt9ivwSZu7FVkyvXzefwVG7vdOuBbmB4Uk3mVz4hw9xDSj/Lrzd2q+jpAMTA+8ApjImZulimCvpsJISP0pqsLgiJfvpNttQl9w7TRAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2Vzuzi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B97DC116C6;
	Tue, 13 Jan 2026 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768324340;
	bh=C/2SQPl6UjUQTRIIYmdGNIwQsNZmauOxZmV+h883hUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2Vzuzi0oXWcGxcZtY14Q1cDhag4Gx03lMTmIzUKHD3FvPdiu4przlwd8iJhupv93
	 Wj1a8nRxvG0gJU+ELYQE3qoRH46uZEgtf5xXjx7vX2Gp6JGBvZo1jyCLBqcKDoKfLm
	 UQ90saFKu4OvAKu79zH2UDPTLJ/Tz+6dTksaCeK1HdGRqbkktsJYZGCsPjfefJRHXi
	 ffQTKbUazXlS7Qf5l4Vs1kbNp04gR4RlNFDl0GGCBmGL0N2oqDiEXC2FbFJVfak99+
	 Q1Z6k9pVz3Ah3mZ/5notHjQpr5C2UkDCKEQNJ3LXx/Q7lR6VdNiUQrl0Kn7l/xvEMr
	 eeytoaCxUXYnQ==
Date: Tue, 13 Jan 2026 09:12:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fsx: add missing -T option to getopt_long()
Message-ID: <20260113171219.GC15541@frogsfrogsfrogs>
References: <dcbecbe996375e0f04962aa2e1a97ade927ecf74.1768225429.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbecbe996375e0f04962aa2e1a97ade927ecf74.1768225429.git.fdmanana@suse.com>

On Mon, Jan 12, 2026 at 01:44:09PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently fsx fails with an invalid argument error when we pass the -T
> option (do not use dontcache IO) to it because it's not listed in the
> gepopt_long() call.
> 
> Fix this and add T to the getopt_long() call.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Oops, I totally didn't notice this omission: :(

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  ltp/fsx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 626976dd..8626662b 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -3160,7 +3160,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:TOP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'a':
> -- 
> 2.47.2
> 
> 

