Return-Path: <linux-btrfs+bounces-15655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA0B10184
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 09:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC4E7B9695
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 07:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE11223DCF;
	Thu, 24 Jul 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uLj9TrND"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FE1F3FF8;
	Thu, 24 Jul 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341462; cv=none; b=GtaymQufqsrrntsWOPrtEHL0XFi58weTfnBV13EqJeQguWIZ0zXxQL/IweikV4NE5dYLy4Pk8BDbIeixlBZY2HaeLIa4bCR2YAkcgd6h9Il8fUB805AxZv020J7tkaM4hp0mJUx5aleWzJla2w2YxX6jkWJJkNpV3lPZ3JtZQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341462; c=relaxed/simple;
	bh=DUDL7NEgwkzzl5dMtsHYd9jnSBtXxB9d9jWolYBO4co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L27xbH9+3LY30kMdjPT8KJMmkJ+yq8KR/xHLhLZizzFDbX3sfISvVyhJ/3apkjlpDPc2SKaCXzFBVXfx3eD8dQUxo+/UJYubso7cHjQNNHL20XhLLgfoV8vvIcCGS96zlH4NiZtAgluAjboG2SevBVdsq8a27wUmsjv6sxsSbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uLj9TrND; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/JC9UrKxywzmx4oRz+Vl7bZIXmhiSvJvj2A9nXL991M=; b=uLj9TrNDWROymCmPOxbtxRcE2r
	ul+evR9F1odZOuVhK5ziNk+ZEQEvmjbmap1qF9HtrMUzJAFMfZFjZA+i5+NFzV9QhKDm0IQjXnbcN
	Ulbg2Tt3wBCfZ/hjH4BlThvUX1zOb6QvB6s8L3fW9t1d5nrkDxxnBH3A5B91Em7LCy9GVY07U6+Tw
	DDSKDj6A+rDbsWi5Z0JltNQudCbyXoonT1KYi+JsO1th0EUzKks4zuDX/5qvj741keXoszXWAY10o
	1dNJQh6vlI8EMXrXNfbvxmDPBEkX2OX9QrUuxXVGN8gXn4neCdRrQrDAcCDD8pGkoeUZBF7u/4mcA
	JxtI9kwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueqCx-00000006gG4-3SQE;
	Thu, 24 Jul 2025 07:17:39 +0000
Date: Thu, 24 Jul 2025 00:17:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/211: verify if the filesystem being tested
 supports in place writes
Message-ID: <aIHeE0a5SdFoCqaP@infradead.org>
References: <7ba7d315e60388593ccef0353cff58c4b5795615.1753272216.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba7d315e60388593ccef0353cff58c4b5795615.1753272216.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 23, 2025 at 01:04:06PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test currently assumes the filesystem can do in place writes (no
> Copy-On-Write, no allocation of new extents) when overwriting a file.
> While that is the case for most filesystems in most configurations, there
> are exceptions such as zoned xfs where overwriting results in allocating
> new extents for the new data.
> 
> So make the test check that in place writes are supported and skip the
> test if they are not supported.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  common/rc         | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/211 |  1 +
>  2 files changed, 60 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 96578d15..52aade10 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5873,6 +5873,65 @@ _require_program() {
>  	_have_program "$1" || _notrun "$tag required"
>  }
>  
> +# Test that a filesystem can do writes to a file in place (without allocating
> +# new extents, without Copy-On-Write semantics).
> +_require_inplace_writes()
> +{
> +	_require_xfs_io_command "fiemap"
> +
> +	local target=$1
> +	local test_file="${target}/test_inplace_writes"
> +	local fiemap_before
> +	local fiemap_after
> +
> +	if [ -z "$target" ]; then
> +		_fail "Usage: _require_inplace_writes <filesystem path>"
> +	fi
> +
> +	rm -f "$test_file"
> +	touch "$test_file"
> +
> +	# Set the file to NOCOW mode on btrfs, which must be done while the file
> +	# is empty, otherwise it fails.
> +	if [ "$FSTYP" == "btrfs" ]; then
> +		_require_chattr C
> +		$CHATTR_PROG +C "$test_file"
> +	fi

Can you factor this into a _force_inplace helper instead of spreading
file systems specific in random helpers (I know we have a few of those,
but we need to get rid of that to make things maintainable..)

> +	# If the filesystem supports inplace writes, then the extent mapping is
> +	# the same before and after overwriting.
> +	if [ "${fiemap_after}" != "${fiemap_before}" ]; then
> +		_notrun "inplace writes not supported"

I think in-place would be the more usual spelling instead of inplace.

Otherwise this looks great, thanks!

