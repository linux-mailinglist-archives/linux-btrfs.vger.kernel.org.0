Return-Path: <linux-btrfs+bounces-18483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70966C26EA8
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F2426E86
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947F328B6D;
	Fri, 31 Oct 2025 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTVNVGmd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566E30497A;
	Fri, 31 Oct 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761943072; cv=none; b=GXvZlyzTc5WIC32DobphOsl6UIac6SPC8I+n4oUClSJPC63CeoSPvR/JOHUOuCk8wJlRfAb5tizdZIA1KSPjKA8VpPrn7lbBFe+RT6MsUQ5c9bOSTM/+VTUtsMA1w9lPZKDSJkVLOfisQXLLR7aUJQ8LDi+1QSuYzS3XwyPGl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761943072; c=relaxed/simple;
	bh=06p3NygxEpzTyI9vzctkNxGfa/fJn/Y5U5F4DP7lLu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN3VZnH2f/N+3hrDsl38FyjgKBR4eNyDZ6/8ZKArIDncJ+RKZmiPwEBZxeLa94aP8VT48Mm78Rqh7/Se/RoA0QgQAwoT54n1an5JMLK5kJhWC6IYepmCJDyPj41Fp+IQQh4U5a1M0+Wk72rkZRpFA1ez2G7VcIbyTX5HK4masDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTVNVGmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ABCC4CEE7;
	Fri, 31 Oct 2025 20:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761943071;
	bh=06p3NygxEpzTyI9vzctkNxGfa/fJn/Y5U5F4DP7lLu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTVNVGmd+tbuj/k9c5IhGeEZh6E2dxZN+wP3B0vnwUaDnQbmwUoDQ/KdCZjRYTwRm
	 7ohmIPyqtROUs9kfyD9L20WXyWq+KfXGtHmi/tih9LiZccsxWnwxNNaMyKi2ZNvDTk
	 fVAxuzVSPflmTsSsEow0r6JBSrEGeklMRx2punr+Chk59Ka7Fpkm3OeTltcuXyb8Wu
	 VBlnh0dIixICrv7topusConPHLKSBt5r9+Hy8KzaFwUYs4zzYxSX7wZNIqIWqZhonH
	 3Nw2RH2/W9M11+y5+0XHDpiK+LjG4zLCpnzp48v9liZ0qsqW2GNoTdsKM/4cFYiUDv
	 O7fO36/2kLttA==
Date: Fri, 31 Oct 2025 16:37:46 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Gladyshev Ilya <foxido@foxido.dev>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Chris Mason <chris.mason@fusionio.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: make ASSERT no-op in release builds
Message-ID: <20251031203746.GE2486902@ax162>
References: <20251030182322.4085697-1-foxido@foxido.dev>
 <202510311956.w2iYoQcn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510311956.w2iYoQcn-lkp@intel.com>

On Fri, Oct 31, 2025 at 08:18:50PM +0800, kernel test robot wrote:
> Hi Gladyshev,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Gladyshev-Ilya/btrfs-make-ASSERT-no-op-in-release-builds/20251031-024059
> base:   e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> patch link:    https://lore.kernel.org/r/20251030182322.4085697-1-foxido%40foxido.dev
> patch subject: [PATCH] btrfs: make ASSERT no-op in release builds
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251031/202510311956.w2iYoQcn-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510311956.w2iYoQcn-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510311956.w2iYoQcn-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/btrfs/raid56.c:302:13: warning: function 'full_page_sectors_uptodate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
>      302 | static bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.

Just in case it is not obvious: full_page_sectors_uptodate() is only
called within an ASSERT() macro, so after this change, it is only
referenced within sizeof(), so it won't be emitted in .text (which may
be a bug). Presumably that is expected in this case, so I would
recommend marking this as __maybe_unused to avoid the warning.

Cheers,
Nathan

