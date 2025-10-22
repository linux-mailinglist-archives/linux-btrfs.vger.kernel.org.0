Return-Path: <linux-btrfs+bounces-18169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB108BFD45E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 18:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E07B1A6319F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A84434FF4E;
	Wed, 22 Oct 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3iec2f5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EF3126A4;
	Wed, 22 Oct 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149857; cv=none; b=Xfi4bVwgys/q7u2d9WbcfCNxhH4sVfh1V7fMiRi/WGRZo01O+ju36ZL5sZOgGj22HXVjcUydwD5f2+UPaal7BJV2ggPgsUqDEfpk+Gf3mHtuB9JIqmTvUQeJXM2wadrv/T2AqA7iV6ck59/XE8RWFLN2dadZblcEs80xAtMY5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149857; c=relaxed/simple;
	bh=rLW1ynNa3SaBtjvt3d2mAGFdVn86KwNdTO6hkxUHKB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrPzU22IGYGbmSXzcQk7w1Vz5jKKzXJ9tgzsOIeMxQUC9vaPNKSrNteCDqnAYhOuCcntre3MLvhCDaJ5I9XBVZmvszu2rWvSofUcy2fuboeMkVk9VHT6QqG86TjiFrI+7duhjKaOdvDlBeALmrteId0PXQZ9jvKZSWhTF7bY8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3iec2f5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B09DC4CEE7;
	Wed, 22 Oct 2025 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149857;
	bh=rLW1ynNa3SaBtjvt3d2mAGFdVn86KwNdTO6hkxUHKB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3iec2f5g8lpbutlDBsURcS33Zn1sUPwmcBR0875lcA9/p1SSKaqWU44qWkCNevV5
	 Gg2bmH0zW05wQV+5oJhDETl+Drq57PTYDk0kFuyIP4NxuRct1gOxD33spMBsDXUdD2
	 Dc9/TrKh7iVsj3C8I3UXCzYqCaIcFybqxuqO12iT+cDWOVr0uJ06SSP3z8rLtNqgV0
	 3k1MG4ZWqWbsVxRVIxa2eqBJ+vwjAucTCZratw4tZ0wi4w+fPcP8IlfL4K1tQPbfH3
	 5P5L2yRP7g2ei+mdTtM8tkoXymvnBV0kGtPBGjY/YYEsP+Les8u8h0Yn2k4j9QwNpU
	 lJBShtoHCXrnQ==
Date: Wed, 22 Oct 2025 18:17:32 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH 0/2] Kbuild: enable -fms-extensions, make btrfs the first
 user
Message-ID: <20251022161732.GB1226098@ax162>
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
 <20251022053042.GQ13776@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022053042.GQ13776@suse.cz>

+ Nicolas for kbuild

On Wed, Oct 22, 2025 at 07:30:42AM +0200, David Sterba wrote:
> On Mon, Oct 20, 2025 at 04:22:26PM +0200, Rasmus Villemoes wrote:
> > Since -fms-extensions once again came up as potentially useful, Linus
> > suggested that we bite the bullet and enable it.
> > 
> > https://lore.kernel.org/lkml/CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com/
> > 
> > So that's what patch 1 does, and patch 2 puts it to use in the btrfs
> > case.
> > 
> > Compile-tested only, with gcc (15.2.1) and clang (20.1.8).
> > 
> > Rasmus Villemoes (2):
> >   Kbuild: enable -fms-extensions
> >   btrfs: send: make use of -fms-extensions for defining struct fs_path
> 
> For the btrfs part
> 
> Acked-by: David Sterba <dsterba@suse.com>
> 
> I think it makes more sense to take the patches via the kbuild tree so
> it's in linux-next for build coverage and eventual tweaks to the Kbuild
> files. Or I can take the patches into btrfs for-next.

Yeah, we should be able to take these into Kbuild. I had just one small
nit on patch 1 that we could probably fix up at application time unless
folks disagree with it. I hope there will be no follow up fixes needed
but it would make more sense in our tree than yours.

Cheers,
Nathan

