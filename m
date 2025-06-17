Return-Path: <linux-btrfs+bounces-14695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1FEADBFF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 05:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39B61890B04
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4021B908;
	Tue, 17 Jun 2025 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu6RodLl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E451922FB;
	Tue, 17 Jun 2025 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750131592; cv=none; b=bhWvhXkLdpCuOCfmD2TT/jCeZ9BkorSYQ1zq79SSGmG9birr6cFRpQas5fxt9E9qXDefOw9Gp5ATRQKHMduafS6+UhxcSkZSywVEefYP3JaexfQ+D4DnBtYki9meGcZXWeEya9TToq0kg0XhflLjiD7SZOUstT95BpXC8dLiaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750131592; c=relaxed/simple;
	bh=NSPb6+HT/YxNcS+qTQcwoCQsyAZ/Oi8zdfZMXq/TBOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnam07fRH6A31SKXfwVYe5nHm/ibqoKC8d5D9cOW7OJ+yiPvcF6BPcaxbp0C36CfxxORDyt/rPwA4UV13HEJK3b+qUL/SjdchJo2ytVaC3lQW7XvFEGtxIr7BowMg5iYd3Rm3Na1wcAONJ4/xfTIwr69qME8fb8A3QRbUGgZwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu6RodLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BFCC4CEEA;
	Tue, 17 Jun 2025 03:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750131592;
	bh=NSPb6+HT/YxNcS+qTQcwoCQsyAZ/Oi8zdfZMXq/TBOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mu6RodLlst5LFiZSrl79H21SxtX2ANOAzFDa0/NmmaUQBYB6WKYdzC7sScabEwoAe
	 khh/rFiSKld+wMcoZF4UK7xjstZoGyMnKIZws66yxdb8re6DJVNv8TUeJFdyCBM/vs
	 JYZ2rCWrHHaSMqWvxr8Pn9chi3I3jz2Rh6ksMPaomL2qxMSSiP26MZ4cs/URVfC/ao
	 sq8narNQK0DMSsHaF91iuGXe8xbX1iE4uahJZ/aWZXmzGGm0gymWos2e3v+9cfv+Er
	 6ZeUXPfA4TpqW1PQfEI2I/CnBN+d57K3aVOLyb7Hka0Ft0nEslochGa4SqIEmzZ+78
	 ZeMh00KhzEldw==
Date: Mon, 16 Jun 2025 20:39:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-btrfs@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/2] Simplify the shash wrappers for the CRC32 library
Message-ID: <20250617033922.GE8289@sol>
References: <20250613183753.31864-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613183753.31864-1-ebiggers@kernel.org>

On Fri, Jun 13, 2025 at 11:37:51AM -0700, Eric Biggers wrote:
> This series simplifies how the CRC32 library functions are exposed
> through the crypto_shash API.  We'll now have just one shash algorithm
> each for "crc32" and "crc32c", and their driver names will just always
> be "crc32-lib" and "crc32c-lib" respectively.  This seems to be all
> that's actually needed.
> 
> As mentioned in patch 2, this does change the content of
> /sys/fs/btrfs/$uuid/checksum again, but that should be fine.
> 
> This is based on v6.16-rc1, and I'm planning to take these patches
> through the crc-next tree.  These supersede
> https://lore.kernel.org/r/20250601224441.778374-2-ebiggers@kernel.org/
> and
> https://lore.kernel.org/r/20250601224441.778374-3-ebiggers@kernel.org/,
> and they fix the warning in the full crypto self-tests reported at
> https://lore.kernel.org/r/aExLZaoBCg55rZWJ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com/
> 
> Eric Biggers (2):
>   btrfs: stop parsing crc32c driver name
>   crypto/crc32[c]: register only "-lib" drivers

FYI, applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next
as per the plan above.  An ack from the btrfs folks on both patches would be
appreciated, though.

- Eric

