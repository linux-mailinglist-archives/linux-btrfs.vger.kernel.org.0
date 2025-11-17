Return-Path: <linux-btrfs+bounces-19076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A543C659BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 18:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84F9D4E4DB2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1822C3090D6;
	Mon, 17 Nov 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dznz+Mw/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4611C84A0;
	Mon, 17 Nov 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401846; cv=none; b=Rg9AwzUiUqKZJC4xSYscIbwFUbYKZvkt+eRWqOnI+GpjjYricHOwOzApv7UEFAEUMIcRriX7rygRVApNOu6GTwYTjsk0eu32vHPaRYanDO5MHJh3UdmlFvqD0Tp24wavfH1VJy5ifDf7aUEWTMspu5jLHe0khPp4o93A8lYcLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401846; c=relaxed/simple;
	bh=QQhtxpEWysuYaVFicx733YbjkwZ4jDJuKIM4qO7V8jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tewBCozyj/jo1ptclfSPj1jLmZnwJTjCX8OadXyGu+/C3HK5ZftCbKIbQYtEpAbxW7HPl2mYh7JnxNxURbIadJwSa0LwNP4jAuSiYEgoe3ZQQFduyrV0/3f7c30LW+9tWNcz+Xciy5LQucSl0qss8sgqheAliQ6e58WTc7JIAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dznz+Mw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3397C2BC9E;
	Mon, 17 Nov 2025 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763401845;
	bh=QQhtxpEWysuYaVFicx733YbjkwZ4jDJuKIM4qO7V8jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dznz+Mw/9tnubWGsL0hZ9LRL1zq/hn1CoNOmHzFWokfGEB0ic06/2485Jh0rj06TH
	 6ifQzb5AspJOKOOyuT1n/P0FF2MUVTLvntokGx4HVMpaHiMYlBYWaaEfa7a6iWZ4E8
	 sPj/OtOvdGtlz7gw0RmtcfKD9kllmK9VDRdRde8ADpdFDA3guIbLc2c33viA+pzmye
	 SX5vG/kKpJvEGUQaR1kOx3JDRwAULgfJkitMQfSlF2qCpuj7jl5Q0U/jR+61dyDfxT
	 zHTlg4d25KF8C9CHJx+gBn1nyTTmBOdwvA7PIGySwxA61s9wyYtVeV07khso82vhsl
	 GKdtz82TgzAIQ==
Date: Mon, 17 Nov 2025 10:50:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Objtool segfault inside an VM, based on commit 24172e0d7990
Message-ID: <20251117175041.GA703155@ax162>
References: <0b7d3e02-0609-410e-a221-8e68a0bd89b0@gmx.com>
 <cfc6e0f7-8924-4276-b29c-a6a72ebf2300@gmx.com>
 <9cd36c00-b2e0-4d57-94b1-840b084d0a3b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cd36c00-b2e0-4d57-94b1-840b084d0a3b@gmx.com>

On Mon, Nov 17, 2025 at 03:40:35PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/11/17 13:33, Qu Wenruo 写道:
> > 
> > 
> > 在 2025/11/17 13:10, Qu Wenruo 写道:
> > > Hi,
> > > 
> > > Recently I'm hitting pretty frequent objtool crashes, sometimes
> > > during module linking (btrfs in my case) sometimes during the
> > > vmlinux linking.
> > > 
> > > Unfortunately I don't have a coredump for it.
> > > 
> > > The only info so far is from dmesg (and obvious the compile failure):
> > > 
> > > [  625.066787] traps: objtool[46220] general protection fault
> > > ip:563ab54c6eb0 sp:7ffd9c2ba7c8 error:0 in
> > > objtool[19eb0,563ab54b2000+1f000]
> > > 
> > > The involved VM has the following spec:
> > > 
> > > - Kernel branch
> > >    Btrfs' development branch.
> > > 
> > >    The base commit is 24172e0d79900908cf5ebf366600616d29c9b417, around
> > >    v6.18-rc6.
> 
> Furthermore, if just compiling on old kernels (in my case, 6.17.8), I
> haven't yet hit a linking time segfault.
> 
> So it's something in the v6.18 release cycle.
> 
> Not sure if it's the recent Zen5 related hassles.

I had similar objtool crashes and David's fix [1] from another bug
report thread [2] appears to resolve this for me.

[1]: https://github.com/davidhildenbrand/linux/commit/58e62699f77738188730d489accd01ad8e3cdeeb
[2]: https://lore.kernel.org/20251117082023.90176-1-00107082@163.com/

Cheers,
Nathan

