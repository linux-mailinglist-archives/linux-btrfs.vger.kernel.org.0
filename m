Return-Path: <linux-btrfs+bounces-18168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22343BFD57B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55509567ED2
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C1272813;
	Wed, 22 Oct 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8qihREK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29D296BB3;
	Wed, 22 Oct 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149709; cv=none; b=PUWHktZTsUatKA+VkVcGWmQGusMLeTeoIXhEeMPVqn3Mg05mFnsHwAWtTHREyKSZORUeNDCXUwSwtp6pHJzArxC+iRhoerTvC2xwvyHuORCfCnMLOJd8Hn/0geDafcua57lpwEAMpg23gdNNXWLcjKbRtmazKtqKls28U21Oe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149709; c=relaxed/simple;
	bh=pCpXNAQqYHcVWpzxhcLIg6joAplMw10+lCiIBwDTKyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwLxnkrwZJbMd1POC+iS30I+UoU9/AE+d2GQW38N5pgaEq1NP+KhhGDQ8hs7ayEtSo3mBifGaOhEHlujwFIGBvd5xAvQUb2ycEDqThRAaUX6EZ2vSI8bsU/dSS7o31ERfwkaymxUvoDO9QmK3znp9y66ViAqyc1lCeDbzWgJGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8qihREK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097D1C4CEE7;
	Wed, 22 Oct 2025 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149709;
	bh=pCpXNAQqYHcVWpzxhcLIg6joAplMw10+lCiIBwDTKyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8qihREK7DoHk9Cy/EajhwciFwHFgxgVIoUnpRte7nKocPi5tnCFUOEQibwJ3hqas
	 KrSagASJ7Dp+UwsakLlPaZ7DCeqISZGDOsI9gE98ud0BGtvdecagP9HgFK/ue0Dfzp
	 GYszrVkxdhMCrmvaWO1ZgotBGwO48YUR7p/Pbxq9ZA+wIXulwlSUAEw5XWX7oPXO+q
	 T5RAYF2kUAI7GhevwfUsg1j+HP+cQgHHdqcVewWeZZnJGUN7DUBaIzhoYVxzW+2qJW
	 K8NT7JvennyS6w+QK8ebfLkK65AuRkG8OArHcpXkU8+Q5ax4d3jGcxzv9qDvUF8Vp6
	 brm0TKSeOZBDA==
Date: Wed, 22 Oct 2025 18:15:05 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/2] Kbuild: enable -fms-extensions
Message-ID: <20251022161505.GA1226098@ax162>
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
 <20251020142228.1819871-2-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020142228.1819871-2-linux@rasmusvillemoes.dk>

On Mon, Oct 20, 2025 at 04:22:27PM +0200, Rasmus Villemoes wrote:
> Once in a while, it turns out that enabling -fms-extensions could
> allow some slightly prettier code. But every time it has come up, the
> code that had to be used instead has been deemed "not too awful" and
> not worth introducing another compiler flag for.
> 
> That's probably true for each individual case, but then it's somewhat
> of a chicken/egg situation.
> 
> If we just "bite the bullet" as Linus says and enable it once and for
> all, it is available whenever a use case turns up, and no individual
> case has to justify it.
> 
> A lore.kernel.org search provides these examples:
> 
> - https://lore.kernel.org/lkml/200706301813.58435.agruen@suse.de/
> - https://lore.kernel.org/lkml/20180419152817.GD25406@bombadil.infradead.org/
> - https://lore.kernel.org/lkml/170622208395.21664.2510213291504081000@noble.neil.brown.name/
> - https://lore.kernel.org/lkml/87h6475w9q.fsf@prevas.dk/
> - https://lore.kernel.org/lkml/CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com/
> 
> Undoubtedly, there are more places in the code where this could also
> be used but where -fms-extensions just didn't come up in any
> discussion.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  Makefile | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index d14824792227..ef6f23ee8e7f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1061,6 +1061,15 @@ NOSTDINC_FLAGS += -nostdinc
>  # perform bounds checking.
>  KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
>  
> +# Allow including a tagged struct or union anonymously in another struct/union.
> +KBUILD_CFLAGS += -fms-extensions
> +
> +# For clang, the -fms-extensions flag is apparently not enough to
> +# express one's intention to make use of those extensions.
> +ifdef CONFIG_CC_IS_CLANG
> +KBUILD_CFLAGS += -Wno-microsoft-anon-tag
> +endif

I think this should go in the first 'ifdef CONFIG_CC_IS_CLANG' block in
scripts/Makefile.extrawarn below '-Wno-gnu' with a comment that is
similar in nature, which could even be combined like

  # The kernel builds with '-std-gnu11' and '-fms-extensions' so the use
  # of GNU and Microsoft extensions is acceptable.

Other than that, this seems fine to me.

>  # disable invalid "can't wrap" optimizations for signed / pointers
>  KBUILD_CFLAGS	+= -fno-strict-overflow
>  
> -- 
> 2.51.0
> 

