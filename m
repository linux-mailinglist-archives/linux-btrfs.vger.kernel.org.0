Return-Path: <linux-btrfs+bounces-16537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B02B3C94B
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899A3188EE87
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0541FDE31;
	Sat, 30 Aug 2025 08:30:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB453363
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Aug 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756542627; cv=none; b=IsScg2m5xVkx70x4jAhS85A6Y+iq68SUrDEfYchH5sT/Y964WnDyTgtrf0WksQdE1M1xx4FzQabR9PVnmruop62ybeBAiVSBz+fyk4eBtQMoxLUSAnX+Lhf/gD6dEKiOSRvqNqOa5AcJ295O+b0/SyCdqYJkWotkEBoGPU0Hhb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756542627; c=relaxed/simple;
	bh=7X4lFdvXRZoQ389Z+XvMgTrJnS46Unj08rh85pUKWps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lP7QkZ8pWr4i7jzKusvXrGR34GOMuu9yQ4baP5eFbZgh4sAlhzPZj34df35+c0AqxOqot7TE3Wt/KU9SKOXJNFkz1c78Uhux7nd5ODVMTQI06crISJZtroCguoybt0CLY2vvEGBTvNubIA2+LHAbXU2We/JIGzKJnJ78uK8nJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 7FDF013AABA;
	Sat, 30 Aug 2025 08:20:31 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Andy Smith <andy@strugglers.net>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Mysterious disappearing corruption and how to diagnose
Date: Sat, 30 Aug 2025 10:20:28 +0200
Message-ID: <5920388.DvuYhMxLoT@lichtvoll.de>
In-Reply-To: <aLI8XeLxrWhwhcZK@mail.bitfolk.com>
References:
 <aLIRfvDUohR/2mnv@mail.bitfolk.com>
 <635a25a0-c8cb-4a48-bf8b-c81dac1c1260@gmx.com>
 <aLI8XeLxrWhwhcZK@mail.bitfolk.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi.

Andy Smith - 30.08.25, 01:48:45 CEST:
> > I know you have ran scrub and it should have fixed all the missing
> > writes, but mind to use some liveUSB or newer LTS kernel (6.12
> > recommended) and re-run the scrub to see if any error reported?
> 
> I do a bit of travelling the next few days and I will not like to change
> kernels on this non-server-grade system with no out-of-band management
> while I am not close by. So, I will leave things with sdh outside of
> the filesystem for now.
> 
> When I return I will upgrade the kernel, scrub and if clean put sdh back
> into the filesystem then scrub again. The Debian bookworm-backports
> repository has a linux-image-amd64 package at version
> 6.12.38-1~bpo12+1.

Backports also has btrfs-progs 6.14-1~bpo12+1 which might be helpful to 
have over default btrfs-progs for Debian 12 which is 6.2-1+deb12u1.

Of course there is the option to upgrade to Debian 13 as well which got 
released recently.

Best,
-- 
Martin



