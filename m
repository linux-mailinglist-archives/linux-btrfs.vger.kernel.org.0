Return-Path: <linux-btrfs+bounces-13104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE6A90C73
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2888C1898805
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180ED22538F;
	Wed, 16 Apr 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz4U6K0w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3D1E1C29;
	Wed, 16 Apr 2025 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832364; cv=none; b=UTFzyLZkrcr2G8obKChutRSP6+JmEONo515tDcN6rEqlAy/yEXp0AtNKU8znhz2tfwn9N6xooXgrH22LphYmfIwLkXEusQYZzZiePwP2VRhINJucYpejzoail/3j+DrqxyG0AJXul9Lvfi59aKQARxQ+/a3adkhqCkcJzrkVkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832364; c=relaxed/simple;
	bh=GKcGNyHGasxdRxMei5YuDEFeVxkBmIq6kKeZnapvDhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H13S8uTXfLwNNzlt3lWkRBfyiW/XvAHVIVJ741ai83Lcuxn5cKIU0jJC0b+uDRRio04QUkQFvL+Es+9IVbSvIjuuE6525WXT+2op1r8CxbTKELQRCiIPTY0Aye0fmINx8wR07qm87RH/qtGJ07Q8Fcx1IX1mxtIOlbtsmPqBLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz4U6K0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97767C4CEE4;
	Wed, 16 Apr 2025 19:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744832363;
	bh=GKcGNyHGasxdRxMei5YuDEFeVxkBmIq6kKeZnapvDhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tz4U6K0wGRsmiB18U3TSwopTiXRtFDWGz1PBuPGwvVJEJVeXzbvSl2cDX8G4qDz8h
	 4mA9/nQRG/RWl6IaZZtSkfqUSdowb8g9CIuVLeJba9yEdysA5vL5CgXEojPfjbY9Zz
	 qka5ayg3we0xLWGfR4SXh8ANaEhwQqyp+kKeId0uhKYCjrbefYz5O3c3t3yW7D12qI
	 1526j61q9f12ahp8s6lJAbw441uHudja632A26LIzm/ZX7ylmjyWMjrrCd1gC8SnVT
	 r3esVJajvF7CmuZgNg8pdemq50Q4446bj0RzKpH2kYtanZ0UNW6Mb8JzXr3fShBQiY
	 OcAhcmVl2CTKg==
Date: Wed, 16 Apr 2025 12:39:22 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Boris Burkov <boris@bur.io>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kdevops@lists.linux.dev
Subject: Re: btrfs v6.15-rc2 baseline
Message-ID: <aAAHagHUl1wvAurW@bombadil.infradead.org>
References: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
 <20250416191253.GA3231475@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416191253.GA3231475@zen.localdomain>

On Wed, Apr 16, 2025 at 12:12:53PM -0700, Boris Burkov wrote:
> >  - Do you want results for each rc release posted to the mailing list?
> 
> I am still getting a hang of how to get at the results, so in my
> opinion, sharing an easily digestible update with releases would be
> helpful.

Great. Well so, essentially this is ready to be automated because the
results below were exctracted from a git commit on kdevops-results-archive,
and so we could simply just have it email the list per tag, if we wanted
that.

Then, do we want fs-next tested too?

> I'm surprised to see every profile that mentions holes/noholes has
> hundreds of matching errors, while others that don't explicitly
> configure them are fine. There are only two options, so you would think
> that either "holes" or "noholes" would behave the same as
> simple/fspace/etc..
> 
> It could be a good exercise for me to learn about the tooling to look
> into what's going on...

Great, happy to help answer any questions you might have.

  Luis

