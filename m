Return-Path: <linux-btrfs+bounces-12268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A60DCA5F9A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 16:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF1B7A6B52
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF1268C57;
	Thu, 13 Mar 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol3uw45m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4F260366
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879288; cv=none; b=lvmNk4O+Sm4R6zBQJZuXxJq/sez1mdO3pR7ekklw3JtPBgeeGnzJTkxJEDjl99HnrSqSRMonmNn1Am3vOK1OmFz53QkTiMhDUPM1j1GTYRqJhq7uD0B3dhbSEdhhcw16IstTNIG6V2as40pmaTwfnaH3V8MleINr+gEfrXw4KR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879288; c=relaxed/simple;
	bh=FaCoLSkRrmZGi/+QcxDjFXhzLFWwjq+8guAOQLswCeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMbJaIioq5MKHt+1BrzhwZK6IhNY3bDnGRMV69CeoVi8G33Eqj9F+bjnzg1Pcf+nHRG3Hd/IXUDYZz78kKOzOZEWMhIxLOelciLQJiQibeAdZP+poVDx5+ZLixWDG+IqHiLDf8AKNLd7ZfzRy8zTFG+OtSByp4rlllWMgUiLd7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol3uw45m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B89C4CEDD;
	Thu, 13 Mar 2025 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741879288;
	bh=FaCoLSkRrmZGi/+QcxDjFXhzLFWwjq+8guAOQLswCeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ol3uw45m2FPj4HYXQYtqC+yyvily58jVTAK6mx8/gQTmogoj5JT8kOJEM6vydlcgX
	 3/0JiQYw9n8KqLym/zzPgMmYw5+WlLAMpeSCLt6Rf0TEVkcr0oNExIqbXw6/oIuIh0
	 aLyVp/TvEm4wsArAOEwkoRXlP7g9n5IGZFl676Rmeza+gojHTVD7KuOooA2QbQZjJe
	 Ho3hP+R4Jwr66ZsQQkpNmT81hRVD3tfZGMG0Mv/UtXCSq4E47mJ2YkQ7ffcGgxPfqc
	 liY5jvt5dwRMvw4SXVrES425xU3dvm/3x7DUjaoSg+Zw3uuDyQmv880EsaX9dIERVE
	 q3LXrrMndzICw==
Date: Thu, 13 Mar 2025 16:21:24 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs: prepare for larger folios support
Message-ID: <20250313152124.GA2420634@ax162>
References: <cover.1741591823.git.wqu@suse.com>
 <20250312134455.GN32661@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312134455.GN32661@twin.jikos.cz>

On Wed, Mar 12, 2025 at 02:44:55PM +0100, David Sterba wrote:
> On Mon, Mar 10, 2025 at 06:05:56PM +1030, Qu Wenruo wrote:
> > [CHANGELOG]
> > v2:
> > - Split the subpage.[ch] modification into 3 patches
> > - Rebased the latest for-next branch
> >   Now all dependency are in for-next.
> 
> Please add the series to for-next, I haven't found anything that would
> need fixups or another resend so we cant get it to 6.15 queue. Thanks.

This series is still broken for 32-bit targets as reported two weeks ago:

https://lore.kernel.org/202502211908.aCcQQyEY-lkp@intel.com/
https://lore.kernel.org/20250225184136.GA1679809@ax162/

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig fs/btrfs/extent_io.o
In file included from <command-line>:
fs/btrfs/extent_io.c: In function 'extent_write_locked_range':
include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_802' declared with attribute error: min(folio_pos(folio) + folio_size(folio) - 1, end) signedness error
  557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
  538 |                         prefix ## suffix();                             \
      |                         ^~~~~~
include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
  557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
      |         ^~~~~~~~~~~~~~~~
include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
   98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
      |         ^~~~~~~~~~~~~~~~~~
include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
  105 | #define min(x, y)       __careful_cmp(min, x, y)
      |                         ^~~~~~~~~~~~~
fs/btrfs/extent_io.c:2472:27: note: in expansion of macro 'min'
 2472 |                 cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
      |                           ^~~

Cheers,
Nathan

