Return-Path: <linux-btrfs+bounces-14751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE53AADDD22
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 22:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65B7189FC73
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9789728D8FF;
	Tue, 17 Jun 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt/plGbZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1C2EFD89;
	Tue, 17 Jun 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191680; cv=none; b=Vk7oJzab9AzZn2juyB7ZF2xCfyAOcaA6yQmY8E8VViC0grHJtUT0KZJdJh+287nNa+BjF9dbos0AsbVSnh/oTa9w/1gJZguP7iis43p9QpNYdVOicKs/mSADnEyjkrYA0a1aFdA7SbPj+IMYRw9sbe6VALzw89akBsdjBsUN31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191680; c=relaxed/simple;
	bh=RrtllbK3ZIMpv++bqo+M6j4DPtmstNepiDX3C1BJqdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j308jOBRc55l5hU9JhAgTRtQpu0IS5h1K8sfY5GOeA/M84JEqydTH0NosHkEF8EAZbkuKOnRVRrpPB8PD3AunqmS46r1n43nXQgfU1C235ClUHAl2Vrwbc2xq7mC4M8n7LaoCzTFxdJnGe6br4q+H+sBukcPyQ/0MynHRwdixCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt/plGbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125E8C4CEE3;
	Tue, 17 Jun 2025 20:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750191680;
	bh=RrtllbK3ZIMpv++bqo+M6j4DPtmstNepiDX3C1BJqdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bt/plGbZ+zWReJSuhppf0OBOsFXIRKpNTdMOk4Fvkm5aqCQiL1DKcm8Axmi9Tmp/w
	 aSHXBNksJg4onS/aTeed/ZqCYIT/mCAZuyh8R5mPCrHIy84YyE9+bTMmxYsCnuNX9l
	 W5gnNhZxp33GSHtQUSncqvHSQcVjqFdETtTkCaLYdAb20NalPSrT5/6p8Vks+/CmRs
	 SO/Fo4rvXnGSQzcc0Ovq0Lzd74smhJgY5Tu5ICPVT0Xk7uGxBwPOWOjx15Mor5+TJp
	 4wtR6EPAIpyixfbiglA7JbOcAKDTcVfM7MAFWuxTdbjMvj0y0f+xHcn9qb0ax3Ao0g
	 8VK3HQIscFtpQ==
Date: Tue, 17 Jun 2025 13:20:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-btrfs@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/2] crypto/crc32[c]: register only "-lib" drivers
Message-ID: <20250617202050.GB1288@sol>
References: <20250613183753.31864-1-ebiggers@kernel.org>
 <20250613183753.31864-3-ebiggers@kernel.org>
 <20250617201748.GE4037@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617201748.GE4037@suse.cz>

On Tue, Jun 17, 2025 at 10:17:48PM +0200, David Sterba wrote:
> On Fri, Jun 13, 2025 at 11:37:53AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > For the "crc32" and "crc32c" shash algorithms, instead of registering
> > "*-generic" drivers as well as conditionally registering "*-$(ARCH)"
> > drivers, instead just register "*-lib" drivers.  These just use the
> > regular library functions crc32_le() and crc32c(), so they just do the
> > right thing and are fully accelerated when supported by the CPU.
> > 
> > This eliminates the need for the CRC library to export crc32_le_base()
> > and crc32c_base().  Separate patches make those static functions.
> > 
> > Since this patch removes the "crc32-generic" and "crc32c-generic" driver
> > names which crypto/testmgr.c expects to exist, update crypto/testmgr.c
> > accordingly.  This does mean that crypto/testmgr.c will no longer
> > fuzz-test the "generic" implementation against the "arch" implementation
> > for crc32 and crc32c, but this was redundant with crc_kunit anyway.
> > 
> > Besides the above, and btrfs_init_csum_hash() which the previous patch
> > fixed, no code appears to have been relying on the "crc32-generic" or
> > "crc32c-generic" driver names specifically.
> > 
> > btrfs does export the checksum driver name in
> > /sys/fs/btrfs/$uuid/checksum.  This patch makes that file contain
> > "crc32c-lib" instead of "crc32c-generic" or "crc32c-$(ARCH)".  This
> > should be fine, since in practice the purpose of this file seems to have
> > been just to allow users to manually check whether they needed to enable
> > the optimized CRC32C code.  This was needed only because of the bug in
> > old kernels where the optimized CRC32C code defaulted to off and even
> > needed to be explicitly added to the ramdisk to be used.  Now that it
> > just works in Linux 6.14 and later, there's no need for users to take
> > any action and this file is basically obsolete.
> 
> Well, not the whole file, because it says which checksumming algo is
> used for the filesystem, but the implementation part is.

Oh, right.  It's one of those sysfs files that don't follow the normal sysfs
convention and contain multiple values.  I'll update the paragraph above to
clarify that it's referring to the driver name part of the file.

- Eric

