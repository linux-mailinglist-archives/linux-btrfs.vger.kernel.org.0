Return-Path: <linux-btrfs+bounces-9380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB6E9BFE83
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 07:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5B61F23B27
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 06:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FA9194ACF;
	Thu,  7 Nov 2024 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j47O1zFa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBC2B9DD;
	Thu,  7 Nov 2024 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961247; cv=none; b=P+sMzB5gtYsA3sT2UXSbVU3uit35m5Xda3I7R8c+vwLXU9rtk3I/WPD483LygLmxrt4TnJGh6prPNJ+wU18v008WezfDJL834OQBeHKV/QhKm7wYPpWTpdGk8kQ3GYmkxAZc8w4PziP11YhAN+jdr1tKovQJ6Cdrn7LLiQgQMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961247; c=relaxed/simple;
	bh=9aeMmwmnUEyjV483wWngqqK394BMN3bdiS3/vaO0WvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOCPDb6F1P4SVYnPZBGQdaCTG79GpZCrb9SZMbPJpHjrkVikVIsGYl66udom5EB5NEmevgpUtjK0CpluoEV1KFrr6bp778veyz+zSXPVCgb1/CTIg6zwfwyHdfSSZluqkV0yvGdWAuyP8cIKvoenYJ3R1zYZuZWCztLrAXQLfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j47O1zFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791BBC4CECC;
	Thu,  7 Nov 2024 06:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730961247;
	bh=9aeMmwmnUEyjV483wWngqqK394BMN3bdiS3/vaO0WvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j47O1zFatkbjdobXFWlnTGifosynnwTAkVp69Y8OFit3ipqY6/dm5pa2yC83la0Lt
	 YxjuwfwkOQdE/hEjGqTXJ7HAuVL733fBGwHi4PAtx4InNi3Uy8XPSUhmI+HY61l3W6
	 hltuPnrI+h0GzCSRI8lvxOhVXTM28ZWFnzgTNQ5U=
Date: Thu, 7 Nov 2024 07:33:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.cz>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hagar@microsoft.com, broonie@kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Linux btrfs <linux-btrfs@vger.kernel.org>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH 6.11 000/245] 6.11.7-rc1 review
Message-ID: <2024110735-exhume-overhang-ca61@gregkh>
References: <20241106120319.234238499@linuxfoundation.org>
 <CA+G9fYtjpUJFFV=FdqvW+5K+JL5ZYN4sPfVDjQovqzd7cib39w@mail.gmail.com>
 <20241106160708.GE31418@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106160708.GE31418@suse.cz>

On Wed, Nov 06, 2024 at 05:07:08PM +0100, David Sterba wrote:
> On Wed, Nov 06, 2024 at 03:12:46PM +0000, Naresh Kamboju wrote:
> > On Wed, 6 Nov 2024 at 12:26, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.11.7 release.
> > > There are 245 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.7-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > The mips gcc-12 allmodconfig build failed on the Linux stable-rc
> > linux-6.11.y branch.
> > 
> > 
> > First seen on Linux stable-rc v6.11.4-642-g0e21c72fc970
> > 
> >   Good: v6.11.4-397-g4ccf0b49d5b6
> >   Bad:   v6.11.4-642-g0e21c72fc970
> > 
> > mips:
> >   build:
> >     * gcc-12-allmodconfig
> > 
> > Build errors:
> > -------------
> > ERROR: modpost: "__cmpxchg_small" [fs/btrfs/btrfs.ko] undefined!
> 
> The patch "btrfs: fix error propagation of split bios" needs
> 90a88784cdb7 ("MIPS: export __cmpxchg_small()")

Thanks, I"ll queue that up now and push out a -rc2 soon.

greg k-h

