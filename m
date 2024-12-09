Return-Path: <linux-btrfs+bounces-10153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A33F9E8B37
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09027281517
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2443210197;
	Mon,  9 Dec 2024 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k04TNpYR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2221019B
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723595; cv=none; b=CL0ZxlUHjhcvHFy8QtZuoP6IfYdsjbhptsrF/hC6tHw7SnuGGpcXgJonQt4tyh4Q9EwBf1JafUYzYpRtwaLP6ncgp1ULt/Dq2Hqnung3K2tRkrY1tc90vWj3aavR/vYO1fU7Mab0KmYc0KqYH1WjalgC/Zcok7P81+uv+7kPbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723595; c=relaxed/simple;
	bh=JUx61LlOuh9JRe8p7MKPL6/7r0KR3CL3nxGdz3IBBmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0ynVEw405/IzMSFc8DLl78ZFBUbaAvnHaodhkm3J5yFb0HYziAB2y9cTuBpnV4oOXDBwK618JS7X9+vo6Ja1QwGVnZbkOpilWo66TacbrGUqcsGf8+jIL0dpD0XDKM+QMStfZms/ppFgaXpaOv3vdLS6hS34W+pHDRWo7n4YD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k04TNpYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8ABC4CED1;
	Mon,  9 Dec 2024 05:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733723593;
	bh=JUx61LlOuh9JRe8p7MKPL6/7r0KR3CL3nxGdz3IBBmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k04TNpYR4YFTvXA50Vbb6N8hYwPg6BnLdrpbwckF0iU7MgsMc8GePEP/TDFcwhtKZ
	 5cM8EFfnmmoIrbbmhjsOHiTZFt9ld7LMn6Ea1QZ7Trn/wCBlxWtudGpMkTKv/nrsnW
	 Zv+mWjZT6BAW0ATn+6HH8X2cDQGXPzzcyHT81E1Fl91JbCp+bkgK12k4WbHaz5OD8R
	 I5A6KuGutcV81IkqyY5OfvSztkHwR8g7ZQp7Dbz4YtWbc5LNwnf/jr5wFGQoAJdZad
	 Q8DhGGXrlgYZLwRI3IVkMkb3mP1E930XI2G9DFcdEk5g9XdqdPjLI+/QxhWwHLE/vK
	 3VtMrneLOCKXg==
Date: Mon, 9 Dec 2024 13:53:09 +0800
From: Zorro Lang <zlang@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>, linux-btrfs@vger.kernel.org,
	ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Message-ID: <20241209055309.54x5ngu3nikr3tce@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan>
 <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202144208.GB321427@pevik>

On Mon, Dec 02, 2024 at 03:42:08PM +0100, Petr Vorel wrote:
> > Hi!
> > > The code to skip filesystems in the case of all filesystems is in the
> > > run_tcase_per_fs() function:
> 
> > > static int run_tcases_per_fs(void)
> > > {
> > >         int ret = 0;
> > >         unsigned int i;
> > >         const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);
> 
> > > The skip_filesystems array is passed to the tst_get_supporte_fs_types()
> > > function which filters out them.
> 
> > Perhaps you mean that the skiplist does not work with .all_filesystems
> > _and_ the LTP_SINGLE_FS_TYPE environment variable?
> 
> > I guess that we need:
> 
> > diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> > index bbbb8df19..49b1d7205 100644
> > --- a/lib/tst_supported_fs_types.c
> > +++ b/lib/tst_supported_fs_types.c
> > @@ -159,6 +159,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
> 
> >         if (only_fs) {
> >                 tst_res(TINFO, "WARNING: testing only %s", only_fs);
> > +
> > +               if (tst_fs_in_skiplist(only_fs, skiplist))
> > +                       tst_brk(TCONF, "Requested filesystems is in test skiplist");
> > +
> 
> It's a nice feature to be able to force testing on filesystem even it's set to
> be skipped without need to manually enable the filesystem and recompile.
> (It helps testing with LTP compiled as a package without need to compile LTP.)
> Therefore I would avoid this.
> 
> @Zorro Lang or are you testing whole syscalls on particular filesystem via
> LTP_SINGLE_FS_TYPE=xfs ?

Oh, yes, I always use LTP with different LTP_SINGLE_FS_TYPE. So that's might be
the problem?

Thanks,
Zorro

> 
> Kind regards,
> Petr
> 
> >                 if (tst_fs_is_supported(only_fs))
> >                         fs_types[0] = only_fs;
> >                 return fs_types;
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

