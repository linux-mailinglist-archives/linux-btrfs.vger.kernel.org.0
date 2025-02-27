Return-Path: <linux-btrfs+bounces-11919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C3A48951
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 20:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA2A1886BE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 19:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7326F466;
	Thu, 27 Feb 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="YCikq+9r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571A1E3DD7
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686244; cv=none; b=B+AH8wb2YAZ0ZEWHx1CJWh3mbhcPV0O2uz6nTUoEcPt8VoFbID5257hIhJHes3t3d0mU6V2+Veq6WSs0EmMNjLiobwb1QOIB8l2kVFr3I+8kAsCWa+JHsZwX4IJC6Iw8/pzL2jUyNNFuoMOgeUECDiRndsVwhrOw565DcOm+Q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686244; c=relaxed/simple;
	bh=9MB+4V7eMBWv8ixlEPuL3H9cxFTqVp3c5mWbUfx5Biw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjHceB20hK+XLDMCCWEenSb3njPR+iL2jBjR9o32MqxiGxtJ62jVR2uxqKWyn5B/MVhptWQZV4gG8hno090HlzY/J99yqI4G9iKPBdsMzKXOoo55lI1SWXBYkFOHpYUNa7SPCecO2ht3GWZz4YyRKxTSbGr2VJYP79rLYpM+W1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=YCikq+9r reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cV05z5hbrvBc0u8UdPXAJlDoHvr6I8zR8Deto6or5vA=; b=YCikq+9rW8Od4P7MUvORNVqrs2
	jDrwANCiT7x3sxYpvnZHynQM7fpqnkdgIokZAShkdnCB5BdX3jtoESAtI8l8lVG5Yk0T0NX9HhpwU
	j2oAfnD3wqqlGTkx3FPyPadMLEmZHLWOZX9ueMTejs6n6Zd+3jXZ2+zblGuqQm8SJ3RwBJ48m+Qep
	gikRSu2r2JJbtqk5nrZdBiVrCpXSRGwYeoygApa5AwC1QuqCpVZv2fp47ddYTaDmPM6NLeYvMkR7I
	a7k8B8TSFiTxL52oN5ycOlsa8nUCI7qERYRNPefLxD3M+SsE+gOulyc26rG6Ku8KryaowMwA1x+Za
	5+peo2Qg==;
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
	id 1tnk0Q-0002qY-88 by authid <merlin>; Thu, 27 Feb 2025 11:57:14 -0800
Date: Thu, 27 Feb 2025 11:57:14 -0800
From: Marc MERLIN <marc@merlins.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Boris Burkov <boris@bur.io>, Josef Bacik <josef@toxicpanda.com>,
	QuWenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Chris Murphy <lists@colorremedies.com>,
	Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
	Roman Mamedov <rm@romanrm.net>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <20250227195714.GF11500@merlins.org>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
 <20250227170220.GA2202481@zen.localdomain>
 <20250227172113.GA2210558@zen.localdomain>
 <20250227173323.GD11500@merlins.org>
 <CAL3q7H4n0Akdk22ecLvdj87mP6iET1F9uUFB1Uzm+t+hCE_DHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4n0Akdk22ecLvdj87mP6iET1F9uUFB1Uzm+t+hCE_DHw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org

On Thu, Feb 27, 2025 at 05:41:29PM +0000, Filipe Manana wrote:
> > I will merge the patch and report back since I seem to be able to
> > reproduce easily.
> 
> The patch was backported to 6.11.3, you're on 6.11.2... can't you
> update the kernel to 6.11.11 (the last 6.11 stable kernel)?

I totally can, I didn't know what the bug was, or which kernels it was
fixed in, and don't have time to upgrade to every point release unless
there is a need, which there is in this case.
Will upgrade now, thanks much for the guidance, much appreciated.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

