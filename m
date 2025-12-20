Return-Path: <linux-btrfs+bounces-19923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D50CD2F54
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 13:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B5F53019BA6
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 12:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5012E03F5;
	Sat, 20 Dec 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hma2xX0Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FE2F7AB8;
	Sat, 20 Dec 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235322; cv=none; b=jwPL15///xrMQKz+p9jLImpDfaxEVlZUY3LaCho4eiqolD3LVKGh2/wp1eYMc431NfkUp6saAYlA5QACmn5kx5OC0C7/dIzNv5d9R7TyZJGnUnr+xiS2GhRIC2U2ws7L9+QAUdAKdvVc3bCdvj6kn90glqpb6dbdwP2xXoMnkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235322; c=relaxed/simple;
	bh=XgGP7ww8ai2wwjZ85vTd42D15tCSeweaMJxvXdmFUuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seusClFeJHvLoIUXfG0RBSPelRYDAiambukd1RyBFcwaVKVz/DsbJIIThAukLq099URbY6dXougmXkYErCCblbDN1XmbYAn7plJwsxRozmpdOegNbLQjpzSSL9sTssT25wj7odkFs/f/THn+pDiKXebECUvHvxh0474PyEqpHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hma2xX0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EB9C116B1;
	Sat, 20 Dec 2025 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766235321;
	bh=XgGP7ww8ai2wwjZ85vTd42D15tCSeweaMJxvXdmFUuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hma2xX0YNM6Q+vUqmt1ike9JxjvQ+gIiLs4WHYeJ17hy9QevTlfFq2JhqNDM4VoEZ
	 xTFLfW4JOk7HCazAu/pIQ74tSQ1b4MIgtGN0cjupKI2lCLZqlNkoPv3aGWTh4/Qf4Y
	 qDLH+X68OevlBW4voE73WwL2APh5C+RATf63iN/bwAeUKNW19hRo53Fmu1j5BrTw/Z
	 S86mNPBBl7ZlI0YAZ9sI0iiR4xg8ni+gE/Kn1a36lERGttFkOamghinApw0RiRSffG
	 6ZYj/hnyPZblwft0zFv8xxVqm5h4j28KqXFJ7LeHr/MDNOfnwesRMv6JFPbkQqtgL1
	 pZ/k6Erlesl2A==
Date: Sat, 20 Dec 2025 13:53:23 +0100
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
Subject: Re: [PATCH v3 2/3] kbuild: cleanup local -Wno-type-limits exceptions
Message-ID: <aUacQyHLoRKXXbrb@levanger>
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
 <20251220-remove_wtype-limits-v3-2-24b170af700e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220-remove_wtype-limits-v3-2-24b170af700e@kernel.org>

On Sat, Dec 20, 2025 at 12:02:20PM +0100, Vincent Mailhol wrote:
> Now that -Wtype-limits is globally deactivated, there is no need for
> local exceptions anymore.
> 
> Acked-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Changelog:
> 
>   v1 -> v2: small change in patch description
> ---
>  drivers/gpu/drm/Makefile | 1 -
>  fs/btrfs/Makefile        | 1 -
>  2 files changed, 2 deletions(-)
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>

