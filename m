Return-Path: <linux-btrfs+bounces-20108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C55EACF4E67
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC6431B0219
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99B33A01E;
	Mon,  5 Jan 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAFTU5gc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24F23EA83;
	Mon,  5 Jan 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631710; cv=none; b=iOW4pccZpR4UwqgnW+n0GCCApa5ULvcw9AssnnOI0AXEYDAKEc4WtjAWGlZujSyNLSAM6Pq90uiAlNUODd0ehkoT2wAl1cowT7tGsSTFVo+Ndh1uxRlcZTyjYrk+z42zW27LKHxt3oXWQ7CDRzi/qhiJDpb2fO/1Sg2xHhNyuqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631710; c=relaxed/simple;
	bh=lgBmFWS+eHzup5griXBJ5iLWt12w0pIwjjUwlCOm7g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5f2FQeLtiNZQcAp1NfJ13wvsHDmGH+mOoXYKSRlZBydItuSMIebOJDYEnsLot2pF9g7hlI39q7X7x2RAz9744lW+t4EebK2GkzU0XnPjTQry3QuXi6IMeuSXBh51JBLgOI0YrC6zM4JS0AQlgar/kcLNg2/WHYil48dW9739FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAFTU5gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61723C116D0;
	Mon,  5 Jan 2026 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767631709;
	bh=lgBmFWS+eHzup5griXBJ5iLWt12w0pIwjjUwlCOm7g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAFTU5gcAiQg7vMGozUVUYCTRsEYNiZ3wG5wWEcjG4Wyc8CAUmCW26cdyPm06fmRl
	 wUcnCBNzAyWUCHnOE+bhRTFKktre3jQ3Rx45plVujMGnUkjEKPQycongC7a6cOpPMY
	 sNSWOVHPCqETgqkZKd8HB6mVr+NZr2th3IgIN2lUrx/NWFO8+kJbl0RVTmfRvp7gcB
	 b9DyTQmR7vFDsboDOEU5g4X7Zz7R5LKWqu+23P4VIZHZa5MJgora8v42WNPs2MTT0y
	 8LJDwXu5f85x70Wtfo5hlGB+xdiNPArBz6kPOeVGTguZTk2Wr0REa218Jiz7yYxdoB
	 kinjeKInNoE/Q==
Date: Mon, 5 Jan 2026 13:24:29 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
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
Subject: Re: [PATCH v4 0/2] kbuild: remove gcc's -Wtype-limits
Message-ID: <aVutfSk4PWbGac_Q@levanger>
Mail-Followup-To: Nathan Chancellor <nathan@kernel.org>,
	Vincent Mailhol <mailhol@kernel.org>,
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
References: <20260101-remove_wtype-limits-v4-0-225b75c29086@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101-remove_wtype-limits-v4-0-225b75c29086@kernel.org>

On Thu, Jan 01, 2026 at 04:21:38PM +0100, Vincent Mailhol wrote:
> I often read on the mailing list people saying "who cares about W=2
> builds anyway?". At least I do. Not that I want to fix all of them,
> but on some occasions, such as new driver submissions, I have often
> found a couple valid diagnostics in the W=2 output.
> 
> That said, the annoying thing is that W=2 is heavily polluted by one
> warning: -Wtype-limits. Try a gcc W=2 build on any file and see the
> results for yourself. I suspect this to be the reason why so few
> people are using W=2.
> 
> This series removes gcc's -Wtype-limits in an attempt to make W=2 more
> useful. Those who do not use W=2 can continue to not use it if they
> want. Those who, like me, use it for time to time will get an improved
> experience from the reduced spam.
> 
> Patch #1 deactivates -Wtype-limits. Extra details on statistics, past
> attempts and alternatives are given in the description.
> 
> Patch #2 clean-ups the local Kbuild -Wno-type-limits exceptions.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Changes in v4:
> 
>   - Remove patch #3.
>   - Aside from minor changes in the patch descriptions, this is
>     basially a revert to v1.
> 
> Link to v3: https://lore.kernel.org/r/20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org

just to prevent confusions:  As Dan silenced the Smatch warning caused
by patch #3 [1] (thanks!), the additional comment patch [2] is obsolete
and v3 of the series is a more complete version than v4.

Kind regards,
Nicolas


[1]: https://github.com/error27/smatch/commit/a7b509b8171b4982b5a2a355f64d083dd76e03f9
[2]: https://lore.kernel.org/linux-kbuild/b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org/

