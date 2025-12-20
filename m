Return-Path: <linux-btrfs+bounces-19922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA0CD2F4E
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 13:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC983021E6A
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846752E9EDA;
	Sat, 20 Dec 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNVOhvyc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A6D2D7DC6;
	Sat, 20 Dec 2025 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235319; cv=none; b=inzHHUmpyegQ6YL5N5jQstrdORMeE1EnBM3XmrMMPMN8pdjMktKazrMsjeHJoVBCzls7Z94zsewVKu8STIjnfsw51Letr/7cV44JFcDKMkTzXMsdumse2nXhpasZXEwikMEBOH9YX3gQYRDz9pBP1JEv9oOHPHBbxw+nyUx8Avg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235319; c=relaxed/simple;
	bh=MRnaPvNUsM3C1QVwEqlYbFLPv+0NuwF7Xn+8YTf2DRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVDLaaPLrSP9guOyvqct/k1fLxFjQ5vFMZB3ejivnttSHW2bum7KsnNCTnZGcNZWvo3+ffG3Y+uSJIzwIjse++KZqV98jB+fJ4Ly31t1kKP37XIylEwPLIZYQN0hNlV6idVT0pc0fFParxaL9+F7mIdz2BUl7SBDVWxVmrPmFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNVOhvyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD91FC116D0;
	Sat, 20 Dec 2025 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766235319;
	bh=MRnaPvNUsM3C1QVwEqlYbFLPv+0NuwF7Xn+8YTf2DRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNVOhvyc2nQ2EAOdPfMbSrgPWjIoMShcik8XDz252J1qWh2Zf7pLnjoqxVsVCuJKs
	 PV1tuC7ZYu6wUCOn6oBMYOkB8g6YQ/LB3kfEY0ODx6XanTKiRjLJqHfc2ItGXFk9CX
	 4dvrfiOUIzRkodk/ym/CrPwizDcc8HfpziStD7e7T6YHhnn5uj1K4qNV0cfgDKrLuR
	 RRW6AOsWhACJ+gBNy/AHABBe26wWK2gnAvbmnv5OJ3fENav88l7Byy8h0AZB1BRWqE
	 C7oUfrG03fxOsbhxiKmchWXYZWHOQto3vhJ3Tu6BHPxBxSv8059cNJWm5zdCycUDCZ
	 h8NWda6wXNJSw==
Date: Sat, 20 Dec 2025 13:52:49 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 3/3] overflow: Remove is_non_negative() and
 is_negative()
Message-ID: <aUacIe84RuAxGV6W@levanger>
Mail-Followup-To: Vincent Mailhol <mailhol@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
	linux-hardening@vger.kernel.org
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>

On Sat, Dec 20, 2025 at 12:02:21PM +0100, Vincent Mailhol wrote:
> The is_non_negative() and is_negative() function-like macros just
> exist as a workaround to silence the -Wtype-limits warning. Now that
> this warning is disabled, those two macros have lost their raison
> d'être. Remove them.
> 
> This reverts commit dc7fe518b049 ("overflow: Fix -Wtype-limits
> compilation warnings").
> 
> Suggested-by: Nicolas Schier <nsc@kernel.org>
> Link: https://lore.kernel.org/all/aUT_yWin_xslnOFh@derry.ads.avm.de
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Changelog:
> 
>   v1 -> v2: new patch
> ---
>  include/linux/overflow.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 

Thanks!

Reviewed-by: Nicolas Schier <nsc@kernel.org>

