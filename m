Return-Path: <linux-btrfs+bounces-18216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459D4C027C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998991A686F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4230ACFF;
	Thu, 23 Oct 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIR+elVd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51A2045AD;
	Thu, 23 Oct 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237957; cv=none; b=jGEUAR4CXn73WsyuGklxnqu2QuIDXnoesSjlKfDax37kU2cwR8HV1eUQrIHaB5xIRLpxXM2ujUpV1iPw+UeUbObEPSS/HYlrWs3zbB77q1D9WpDLFHhVsqT9p9PcG8r64fHv87LHyWScBMgRicbbyJbzX/SkFV7tdAt0G1oXwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237957; c=relaxed/simple;
	bh=qtOPVqukC5iqdVsYYN6G/HJCFCE384nTNnjCr8WVy7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWy4NL/8g+WpD8mwwxSAW1SGEO+4eQbglYUIHcTIck0aNGiS3yqN5UGSg8s8uAQi+AikPuOWxuEFu3hlyzupVf5MUcn6k4ZD2zXlUowngThIGyp+IMd8xYg7DxA+7hoT/D4F7EXxxJj4OjOEBKfTUbC1dOuZYUTdc4Fb+ORX+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIR+elVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6B3C4CEE7;
	Thu, 23 Oct 2025 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761237956;
	bh=qtOPVqukC5iqdVsYYN6G/HJCFCE384nTNnjCr8WVy7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIR+elVdaifJs5yC1CcHU/S6NEAiVjgh5oa4rNfrtDp+hRAqPXetY4Ht5fPM4CW/n
	 sN7BNhT8F8NTQ5JQI+6HOu9O326DfPsn5lFGmE+DTZjWWlhD2hUhHAesmmiSTk1YZu
	 6ZREA5iMwY/Z6ruQ+gIvQBhpQslzodiZDPy82lxEyODe376vbBgMafU+Kz/BofYCsX
	 ajFGedOfYfVFYR9PQ4WwAKuFprlQSGy84bXs7pR/vmt3GOxe4QbcrhJUrWfRVO2P4T
	 nhmOZaXIXZNMtxjuWEGCSTLafm/yzbb6I2+VgGZizm36vu5ntZ3KO95xrpDeHOSCXc
	 O4OEkHwX6YdZQ==
Date: Thu, 23 Oct 2025 18:45:52 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org, jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 1/2] Kbuild: enable -fms-extensions
Message-ID: <20251023164552.GC2090923@ax162>
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
 <20251020142228.1819871-2-linux@rasmusvillemoes.dk>
 <20251022161505.GA1226098@ax162>
 <CAKwiHFiMAm-DX3aERH_F1UooiM1YUiMaax51exhRg2=1ND2VCw@mail.gmail.com>
 <20251022211133.GA2063489@ax162>
 <20251023124041.GA739226@ax162>
 <0b2bc5fb-2345-47dd-b980-120805d3c69f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b2bc5fb-2345-47dd-b980-120805d3c69f@oracle.com>

On Thu, Oct 23, 2025 at 09:17:47AM -0500, Dave Kleikamp wrote:
> On 10/23/25 7:40AM, Nathan Chancellor wrote:
> > Something like this is all it takes to resolve the issue, so I will send
> > a patch for formal review/acking but I wanted to bring it up ahead of
> > time in case this is unpalpable and we should throw these changes out of
> > -next instead of forward fixing.
> 
> I'm on vacation now, so I may be slow to respond to a future patch, so I'll
> go ahead and give you my ack to this.
> 
> Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Great, thanks for the tag and taking a look quickly!

> > diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
> > index 10934f9a11be..5aaafedb8fbc 100644
> > --- a/fs/jfs/jfs_incore.h
> > +++ b/fs/jfs/jfs_incore.h
> > @@ -76,14 +76,14 @@ struct jfs_inode_info {
> >   		struct {
> >   			unchar _unused[16];	/* 16: */
> >   			dxd_t _dxd;		/* 16: */
> > -			/* _inline may overflow into _inline_ea when needed */
> > +			/* _inline_sym may overflow into _inline_ea when needed */
> >   			/* _inline_ea may overlay the last part of
> >   			 * file._xtroot if maxentry = XTROOTINITSLOT
> >   			 */
> >   			union {
> >   				struct {
> >   					/* 128: inline symlink */
> > -					unchar _inline[128];
> > +					unchar _inline_sym[128];
> >   					/* 128: inline extended attr */
> >   					unchar _inline_ea[128];
> >   				};
> > @@ -101,7 +101,7 @@ struct jfs_inode_info {
> >   #define i_imap u.file._imap
> >   #define i_dirtable u.dir._table
> >   #define i_dtroot u.dir._dtroot
> > -#define i_inline u.link._inline
> > +#define i_inline u.link._inline_sym
> >   #define i_inline_ea u.link._inline_ea
> >   #define i_inline_all u.link._inline_all
> 

