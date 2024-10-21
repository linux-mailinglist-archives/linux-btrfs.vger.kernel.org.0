Return-Path: <linux-btrfs+bounces-9015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDDF9A595A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 05:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7FD1C20F9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 03:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB87155321;
	Mon, 21 Oct 2024 03:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="oaXoG8zM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1B2F4A
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 03:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729482954; cv=none; b=mjivwxZ/rqAJqoEmHINlIsY+mYyIA0ejSbG31MxlQJPUJe8PZ9GwscnFuqOvilAHpkBzO/CknCT1e1i3sCOZHyGb8FOQw/3M6gjLgLkNnTi+t/3GXf2hf2PrJzqScATgj/nl7uzblOJGTRO454jvMYoY8FcD97SDfuDt4hACUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729482954; c=relaxed/simple;
	bh=v/mImVwkCbkB7p1Qu09QEolQjBYSggBit6fzsGWBCBE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3A1ZQPYq6WGjcFNjYPbvYxHMEc/yr1GOrdnGos5T0AZfCUgv2kiZ86FJWMPRbNcpnNm2EjxPh4gUT+ce/GSXYucXPQotTdqqVifp209zuByG4OjM/6bP/Ps9DX+gqdZgdyAwGyEffh/p7gKtGzcQJ1ViASGxzpbj6an1+RTtbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=oaXoG8zM; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1729482951;
	bh=3/gd7ayIBH7TMlYkwtnDomlLMgEILCiNPvidcDibmEo=; l=1745;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oaXoG8zMagytOayryo6uL69k96wqpw7D+LhDh9Tv950U75UxSIJ5qfBTv5i2uKl+s
	 7cEe0PyVqsplVitExWg/bbJNpmqT8FV24/2huB6ZX0tcTlS2ZA4F1L2OpZsXJ/4QrQ
	 wtq7AgAdI+W/xn25rUK+kaWbTo0/5cPsB6pFJGD0=
Received: from liv.coker.com.au (247.234.70.115.static.exetel.com.au [115.70.234.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 45CF0FEC3;
	Mon, 21 Oct 2024 14:55:49 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: strangely uncorrectable errors with RAID-5
Date: Mon, 21 Oct 2024 14:55:46 +1100
Message-ID: <8439012.T7Z3S40VBb@cupcakke>
In-Reply-To: <67b3649b-2372-4846-bb86-79fafec1bab0@gmx.com>
References:
 <23840777.EfDdHjke4D@xev> <67b3649b-2372-4846-bb86-79fafec1bab0@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 21 October 2024 08:01:52 AEDT Qu Wenruo wrote:
> The metadata is gone, and there is only one mirror for it.
> 
> What profile are you using for metadata?

# btrfs fi df /mnt
Data, RAID5: total=4.92GiB, used=1.21GiB
System, RAID5: total=48.00MiB, used=16.00KiB
Metadata, RAID5: total=864.00MiB, used=172.77MiB
GlobalReserve, single: total=6.95MiB, used=0.00B

It's all RAID5.  Why would it be all gone?  Also why can't it be recreated 
when diff doesn't report any file loss?  Can I convert a BTRFS filesystem from 
this state to an all good state?

As an aside I've had something quite similar happen on a production server 
running Ubuntu 20.04 and RAID-1 and now I'm just running it knowing that a 
scrub will give errors but that it apparently works.

> Just in case, RAID5 is not recommended for metadata due to the complex

From what I know it's still not recommended for anything though.  But 
definitely if I didn't want to have data loss and I wanted RAID-5 then I'd use 
RAID-1 for metadata.  But in this case I was more interested in seeing how it 
might break than in keeping the data intact.

> recovery combinations:
>  >> The power failure safety for metadata with RAID56 is not 100%.
> 
> I'm pretty sure if you're using RAID5 for metadata, that's exactly the
> case where corrupted metadata can not be properly fixed at a per-sector
> basis.
> 
> Thus it's recommended to go RAID1* for metadata if you want to use RAID5
> for data.

OK.  I'll run some new tests on RAID1 metadata and RAID5 data and see how that 
goes.

Is there any way of recovering the filesystem with those errors or is mkfs 
required?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




