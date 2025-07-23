Return-Path: <linux-btrfs+bounces-15647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18401B0F655
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2230168FED
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5262F85C7;
	Wed, 23 Jul 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfkmP10r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7F2F49FC;
	Wed, 23 Jul 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282160; cv=none; b=pnJ9Z36MCOu+ZbbEu3xqXACGyrWJbB3LEmuha6KIWHm57VDb83wvH2JtFrMtoVwLZVRuGuZXQa9gTwhOo1QNLb8sdYM2hwgbMih/lK/NFDt3uMe6bA0ZfLTgBK9MCZOqIKek64qqntJ6EB73SFeIBFga3c7xUNbFG8CwrCUswyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282160; c=relaxed/simple;
	bh=uJNb0J1C5TY2VvN8jY4X8ugBBiIqaVX1ecgp4EbJ9r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUowdDB4BfexeatRRm5Pnv/7t4Lx/FPTtl0GhB2lNQzRH4kfTIz2E6kfmANwxAIHy2ZO2arIhxSIXeJCPFYxW3d1uB0HxgyXaOxrCiY1FRfqZdqYNjPk37a/zxdsM4kVUbxp+XUjCpWvQjn9kSE5uP5D+4YzuxkbSVuV37EB1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfkmP10r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673F6C2BD04;
	Wed, 23 Jul 2025 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282158;
	bh=uJNb0J1C5TY2VvN8jY4X8ugBBiIqaVX1ecgp4EbJ9r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfkmP10rDSe+Z9fIhKInnrDo/oHC/3N/n0JgDyzGs8QZcz85TbmbQn978sAS0Yzzl
	 ebFEYezr4JwBxAJJbkh3NeEiGAMd8nOG7/7Xt6EsC/95yhPDrc3Li077mcWmEYOaj5
	 Pn8NfCAGZ/CvgP42/8xsOoCysAnv2suYvyT4ASs3QwC+ClFff242KfjbYhdwtReMjT
	 9n/BhzWO3fpHjpFJfyhS0vwDa3z/njwH3EcU0aZN9fG9dbTcIA4QgIGp9aovurrjmD
	 Yrw8uRKSrQVTV7aCJqFzsIinnRf7OYtB1PMii48n4IyT4IBzQmLW4Ahe1DvN2vFr8S
	 F3Fi/b4ZN3/yg==
Date: Wed, 23 Jul 2025 07:49:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/211: verify if the filesystem being tested
 supports in place writes
Message-ID: <20250723144917.GL2672039@frogsfrogsfrogs>
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

This is a smarter sollution than the fugly hack that I came up with:

# Don't run on mounted filesystems that only support out of place writes
if [ "$FSTYP" = "xfs" ]; then
	_require_no_xfs_always_cow
	_require_xfs_scratch_non_zoned
fi

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
> +
> +	$XFS_IO_PROG -f -c "pwrite 0 128K" -c "fsync" "$test_file" &> /dev/null
> +	if [ $? -ne 0 ]; then
> +		rm -f "$test_file"
> +		_fail "_require_inplace_writes failed to write to test file"
> +	fi
> +
> +	# Grab fiemap output before overwriting.
> +	fiemap_before=$($XFS_IO_PROG -c "fiemap" "$test_file")
> +	if [ $? -ne 0 ]; then
> +		rm -f "$test_file"
> +		_fail "_require_inplace_writes first fiemap call failed"
> +	fi
> +
> +	$XFS_IO_PROG -c "pwrite 0 128K" -c "fsync" "$test_file" &> /dev/null
> +	if [ $? -ne 0 ]; then
> +		rm -f "$test_file"
> +		_fail "_require_inplace_writes failed to overwrite test file"
> +	fi
> +
> +	fiemap_after=$($XFS_IO_PROG -c "fiemap" "$test_file")
> +	if [ $? -ne 0 ]; then
> +		rm -f "$test_file"
> +		_fail "_require_inplace_writes second fiemap call failed"
> +	fi
> +
> +	rm -f "$test_file"
> +
> +	# If the filesystem supports inplace writes, then the extent mapping is
> +	# the same before and after overwriting.
> +	if [ "${fiemap_after}" != "${fiemap_before}" ]; then
> +		_notrun "inplace writes not supported"
> +	fi
> +}
> +
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/generic/211 b/tests/generic/211
> index e87d1e01..ed426db2 100755
> --- a/tests/generic/211
> +++ b/tests/generic/211
> @@ -27,6 +27,7 @@ fs_size=$(_small_fs_size_mb 512)
>  _try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
>  	_fail "mkfs failed"
>  _scratch_mount
> +_require_inplace_writes "${SCRATCH_MNT}"
>  
>  touch $SCRATCH_MNT/foobar
>  
> -- 
> 2.47.2
> 
> 

