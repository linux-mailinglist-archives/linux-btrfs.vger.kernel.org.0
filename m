Return-Path: <linux-btrfs+bounces-4011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF089B277
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 16:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B711F216E5
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0538DD3;
	Sun,  7 Apr 2024 14:29:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30419374D2
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Apr 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712500176; cv=none; b=SngUlzUyywaickkYokLceJEWM2NB4VArjfBo2aBpm9zrhr+G/gyHAr//OyzFZJYFnowyp04pRW6TvqALgcbjQZcqIdAav8Y6kuCylMcUIrDunha3jRGbDUsU7Dxrf7mYXxxlrBgSn5iZ8B0wch6c0KNJ2NloFXTgDZDc0C1LUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712500176; c=relaxed/simple;
	bh=8JxEbMaBGKjvd18G13wagdugpYIoe5ASVQLJ5cIrgAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpgRWNFGcJ0uLqTLvwFy2Ke09b1BblyiX2+qn440OL0vHHp2h8MajTrItxAIjcLigbBBqk0CcA9VSFgw3tzRPrLZnLI7669V3VsrQFa4etK0mn6FYg5bjIYUrfi8ovYLj/uDFeabghCUE2Z1rIcY2QpKz+MEaBybmrKGW+mArAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
	by shin.romanrm.net (Postfix) with SMTP id BA68E3F6D6;
	Sun,  7 Apr 2024 14:29:20 +0000 (UTC)
Date: Sun, 7 Apr 2024 19:29:13 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>
Subject: Re: exactly shrinking btrfs on a device?
Message-ID: <20240407192913.0682fa4d@nvm>
In-Reply-To: <d7c9378abccd7a7c243fc10938c6ba1ba48db232.camel@scientia.org>
References: <896a5d36071a30605c38779dd03103b6429ebcae.camel@scientia.org>
	<20240406033700.2c2404c1@nvm>
	<0c9f96442083fe6e5ad387adbc496ff2f3370270.camel@scientia.org>
	<bba42153-f4d9-4fb6-8252-a5cd1929b901@gmail.com>
	<d7c9378abccd7a7c243fc10938c6ba1ba48db232.camel@scientia.org>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 07 Apr 2024 04:52:06 +0200
Christoph Anton Mitterer <calestyo@scientia.org> wrote:

> On Sat, 2024-04-06 at 08:03 +0300, Andrei Borzenkov wrote:
> > Why not? You set the container to the exact size and let btrfs grow
> > up 
> > to it. Or may be you need to clarify your question.
> 
> Well... maybe, I guess, I just wanna know where it exactly ends. ^^

Try "btrfs fi show /mnt/point/ --raw". It will show the device size in
bytes, as used by Btrfs. 

...
	devid    1 size 503251058688 used 400023945216 path /dev/sda3
...

# blockdev --getsize64 /dev/sda3
503251060736

This seems to be the number you're looking for.

In my case we can see that since the total device size is not a multiple of
4096, Btrfs has left 2048 bytes unused at the end.

-- 
With respect,
Roman

