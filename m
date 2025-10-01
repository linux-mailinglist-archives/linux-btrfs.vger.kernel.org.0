Return-Path: <linux-btrfs+bounces-17313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BBBB09B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D07B0E4F
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DBA3019B7;
	Wed,  1 Oct 2025 14:03:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC782FBE07;
	Wed,  1 Oct 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327381; cv=none; b=pY3/rUQcV+yPvb+DAu2Qk9sgk9DOlGvLISjCLHmBakR3sQ8yzMcgPr2xX5mo99wolLalqOfafy+NwbkI1VQ55bU4O5TcZBTj48IYxPv5AzKBMJSeLPZOxu6LJ4TeNjJ04fw3duv2z+dVFGlCyBmJErVptvxSoV0TtGPtsSgqZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327381; c=relaxed/simple;
	bh=1NNK+1vKpQS/XBwoBGwNOBbFofbQOyIzzUMiqq18nlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1KUR9KtoSnYuEDyY5ne7h/zRBU8hgsIj56Pk12bnhuhUkkCnA72Gtct9q7flA7A3gBc7lsaVxEmCspKxY6Z7qT2a2PtdFZZo/AFhz6bFeM9t6u0JK8zxmd2nIABaG9ODPhThXv8LiBjEIjw7S8AGRIVvv+95QRMtBFWIlVAgGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EBDC4CEF1;
	Wed,  1 Oct 2025 14:02:58 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: dsterba@suse.cz
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	nathan@kernel.org,
	patches@lists.linux.dev,
	wqu@suse.com,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] btrfs: Fix PAGE_SIZE format specifier in open_ctree()
Date: Wed,  1 Oct 2025 16:02:54 +0200
Message-ID: <20251001140254.2784891-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926065401.GR5333@suse.cz>
References: <20250926065401.GR5333@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi David,

On Fri, 26 Sep 2025 at 08:54:01 +0200, David Sterba wrote:
> On Thu, Sep 25, 2025 at 07:03:04PM -0400, Nathan Chancellor wrote:
> > There is an instance of -Wformat when targeting 32-bit architectures due
> > to using a 'size_t' specifier (which is 'unsigned int' for 32-bit
> > platforms) to print PAGE_SIZE:
> > 
> >   In file included from fs/btrfs/compression.h:17,
> >                    from fs/btrfs/extent_io.h:15,
> >                    from fs/btrfs/locking.h:13,
> >                    from fs/btrfs/ctree.h:19,
> >                    from fs/btrfs/disk-io.c:22:
> >   fs/btrfs/disk-io.c: In function 'open_ctree':
> >   include/linux/kern_levels.h:5:25: error: format '%zu' expects argument of type 'size_t', but argument 4 has type 'long unsigned int' [-Werror=format=]
> >   ...
> >   fs/btrfs/disk-io.c:3398:17: note: in expansion of macro 'btrfs_warn'
> >    3398 |                 btrfs_warn(fs_info,
> >         |                 ^~~~~~~~~~
> > 
> > PAGE_SIZE is consistently defined as an 'unsigned long' in
> > include/vsdo/page.h so use '%lu' to clear up the warning.
> > 
> > Fixes: 98077f7f2180 ("btrfs: enable experimental bs > ps support")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>
> Thanks, I'm planning to send it as fixup once the main pull request is
> merged, until then it'll be in linux-next.

The build failure is now upstream, and I can confirm this patch
fixes it, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

