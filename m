Return-Path: <linux-btrfs+bounces-18322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A2C0843B
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 00:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 699A64E55FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 22:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2100C30C627;
	Fri, 24 Oct 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+qaa8Jp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D430BF64
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761346310; cv=none; b=e9mbvylGsn3wc/jz5n8Q7FT3t7q2RFTDrCqHSWTCO2Puaai2cWXwjDBKxGE8l9U+CQ0HjxenJDFOIuKr47IPCTsf1eWxMOSJmUd55Cqvgl74DQ2EoSCFTAS0DMKsUUeHGog7P/19HRyn27V/dtC2kIGmmRreMfUUPEBXQqlUhQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761346310; c=relaxed/simple;
	bh=Pk4Mhe0Q3BOELMXw7KOhD1anZjUucupC/wfkF8LReXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp7peU5r1cI3kqlhUmRSdcgailgEfrr/Ti5yofUQzf/doG1s0e1MYLR7m6L+oysz/CwNd25BwidVLDi0GFvD9+o72CabgnTXyvWl6jQwxArR4Ds2lwt0tu1OSVmk6jrMR7Sc3JbrjjNOSThSqEVVsZsY7K+cr8WbSpGRIbOjT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+qaa8Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB92C4CEF1;
	Fri, 24 Oct 2025 22:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761346309;
	bh=Pk4Mhe0Q3BOELMXw7KOhD1anZjUucupC/wfkF8LReXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+qaa8JpJGbdWvD9fxgLvDdYPCrRGMfe8umfVNb3S3AhEvv1EtyIAW0IKhGoQFobG
	 tPaGX4SCeGLl1xDveNB3IGwQghqt4LK33NQgrl5mIrZP9hRGrm1VXgvoH8gCpdW3ud
	 rSstJketS/dKxUC5nw3ViAetOM+wbRVkG8HtCDR9u0Bjz8GjqXK97mnNKOTpQCm0dt
	 Eye2AB2oi1Fl8X6MMCq2DKuctdiqvpscZgjp6Fn/kxcyTPVAErrH72vlIKJbb79THj
	 tRrwFwdHlAXVa83FE9kjErWMWNbgDIohSiYd+t6OQ6fv6h1/MJRnUR3foiVCLyMcO1
	 DDZqjxUGmV0ew==
Date: Fri, 24 Oct 2025 22:51:47 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
Message-ID: <20251024225147.GA4182237@google.com>
References: <cover.1761302592.git.wqu@suse.com>
 <44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com>
 <aPtbzMCLwhuLuo4d@infradead.org>
 <6e338563-97d9-46f5-bfe6-19a1effa8aca@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e338563-97d9-46f5-bfe6-19a1effa8aca@gmx.com>

On Sat, Oct 25, 2025 at 08:45:09AM +1030, Qu Wenruo wrote:
> Even if the new API can cause black magic to make CRC32C to be faster than
> DRAM bandwidth, it will not remove the latency.

For what it's worth, crc32c checksumming is often faster than DRAM
already.  Though, being faster than DRAM is still useful when the data
is already in cache.

For example, on AMD Ryzen 9 9950X (Zen 5), I get 89 GB/s crc32c with the
kernel's current crc32c code for data that's already in L1 cache.

However, Zen 5 tripled the number of ALUs that can execute the crc32
instruction, resulting in new code being optimal.  I've tested that
130 GB/s crc32c is theoretically possible with Zen 5 optimized code.

The indirect calls and other overhead in the traditional crypto API
makes a notable difference in checksumming throughput when the actual
calculation is this fast...

But absolutely, the real bottleneck for I/O is almost always going to be
elsewhere in the stack.

- Eric

