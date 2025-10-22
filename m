Return-Path: <linux-btrfs+bounces-18172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E061DBFE42B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 23:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9B93A8323
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 21:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4893530215A;
	Wed, 22 Oct 2025 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJmitPwV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81F301489;
	Wed, 22 Oct 2025 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167498; cv=none; b=T2SqpqRIBlmFHoHykuOMmo2pVna48Sb07BsDPWBQcyJHzqjHvl5P03xapcKmow+I4R7SC8yLPHhuI9rOOD13SWHWEIIKi8jDxLf8jqlx4PUADTvRHtzy6VRi1MeKI/QAoVWcBCJ3vJR/9g2MY55GmC+q8zj55waAJcYS1+619gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167498; c=relaxed/simple;
	bh=fuasEY/k35VNWMkadGPOeA6z1Miu6p/9NnKbua0vPQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Skfq3QmcKdcm1Zv9UXQiqqVbLA4+p89bX+ewBmZJcQ0tVvhCXoG6jw765HN1T/gVMs/sPokHthBUcqsPkCCqPtApiRhAtXwleI0SHTv0eSXSIZUVORkP4MKuBLvTUQxM29DmDQs9rnztmywZiyD4OhAZcYFys2UTimVMe+S/CMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJmitPwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA73C4CEFF;
	Wed, 22 Oct 2025 21:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761167498;
	bh=fuasEY/k35VNWMkadGPOeA6z1Miu6p/9NnKbua0vPQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJmitPwVwcHfnUendGCJUzxCHm3rEnlhpzqo+Iu9vjWHMYcuJqrSpuHjlxTNCRCOr
	 4rr4UO3iWDsN6N8zJJIwdRo2ALUomWFxZEVFoxMIQ+MrhasmPP5rHrh7o52FrZQdEo
	 NR94v/s7MbInPDjKHCcezIy/Hh3ecd6rdbSviKE4RkCFwCd5BKt8Rd209UqWEr5hr6
	 wpT420V6tFcsshF6x2iHf6L5862LF2t5tgYm7VmVkxaB9ku9S8s3p7oCRGBlgu3D08
	 bcehbjOX1zZmVJVqwVdq3lbja/QZFgiIOFB4V+wKJXUIqZocpikk2gmvTv2YpxhxOC
	 4d7F58qFcvTyA==
Date: Wed, 22 Oct 2025 23:11:33 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/2] Kbuild: enable -fms-extensions
Message-ID: <20251022211133.GA2063489@ax162>
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
 <20251020142228.1819871-2-linux@rasmusvillemoes.dk>
 <20251022161505.GA1226098@ax162>
 <CAKwiHFiMAm-DX3aERH_F1UooiM1YUiMaax51exhRg2=1ND2VCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwiHFiMAm-DX3aERH_F1UooiM1YUiMaax51exhRg2=1ND2VCw@mail.gmail.com>

On Wed, Oct 22, 2025 at 10:35:33PM +0200, Rasmus Villemoes wrote:
> On Wed, 22 Oct 2025 at 18:15, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Mon, Oct 20, 2025 at 04:22:27PM +0200, Rasmus Villemoes wrote:
> 
> > > +# Allow including a tagged struct or union anonymously in another struct/union.
> > > +KBUILD_CFLAGS += -fms-extensions
> > > +
> > > +# For clang, the -fms-extensions flag is apparently not enough to
> > > +# express one's intention to make use of those extensions.
> > > +ifdef CONFIG_CC_IS_CLANG
> > > +KBUILD_CFLAGS += -Wno-microsoft-anon-tag
> > > +endif
> >
> > I think this should go in the first 'ifdef CONFIG_CC_IS_CLANG' block in
> > scripts/Makefile.extrawarn below '-Wno-gnu' with a comment that is
> > similar in nature, which could even be combined like
> >
> >   # The kernel builds with '-std-gnu11' and '-fms-extensions' so the use
> >   # of GNU and Microsoft extensions is acceptable.
> >
> > Other than that, this seems fine to me.
> 
> I honestly had no idea where it was best to put these, and your
> suggestion sounds quite reasonable. I didn't think to look in that
> Makefile.extrawarn as the name suggested that was only about what
> happens with W=1 and higher.

Yeah, we may want to rename that to just Makefile.warn since it
encompasses all warnings since commit e88ca24319e4 ("kbuild: consolidate
warning flags in scripts/Makefile.extrawarn"), which is actually
feedback I gave on the original change:

https://lore.kernel.org/20230811141943.GB3948268@dev-arch.thelio-3990X/

I'll send a patch for that soon.

> Feel free to tweak when applying.

I have tentatively applied this to kbuild-next so that it can spend most
of the cycle in -next to try and catch all potential problems.

Cheers,
Nathan

