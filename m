Return-Path: <linux-btrfs+bounces-12744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA37DA7866E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 04:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2440C3AF783
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 02:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06F22612;
	Wed,  2 Apr 2025 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="zWfcNaH8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55411CBA
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743561174; cv=none; b=MukMK4Pf6s+9+EEnGH97kGUjH6MWYCTCsokNIwQaEcbdbxlFvbdg+6ShZULGqKpdXM/KczA3jgHcAffrodJ4tzxaGcr2np5dkXm7DQD7crffs7cPu1DNmnPBeErnn4zO8W3jsDQJgQCZ9nrq8LqrzxgppIw+GWF7n1T9gz2cG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743561174; c=relaxed/simple;
	bh=diqcLmOObrec4e75yjJO1K2Efxs94Rddsf6oBOPV5Q8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQh1KS36Tfhik8eJx3/64emVereVYeiJnrz8UKF+HhbQK3flL8FnGdPrCT9D6o3UtgwpEcwDkPeDd8fS5rn5Zha9EFYzdfBTnxEUZyNMSXbZSUaX6kkVf8jaMcVsnXKMC5Ej/oUpZCuBWC70n3HAjKoVnLYfIUQpsfTdkNRRmkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=zWfcNaH8; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1743561168;
	bh=AmkCrFVibzqMXxsKU3AnU1Yhx7/kku4LgaC+sG431z4=; l=1765;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=zWfcNaH8CbbzFKHXi0mutjnFBeKtQ5K5MkzcSq/1MBztaPYhn3OPWnKmVUFWEglh4
	 Mhx34/bwcCgYEi0lxW8lNp3KcCalksn6YNHTNN85nkIddsrg6bmjUP+onwaUDs5aa5
	 2Ydsr3OVfsEfpAd+d6faTbWhtovNiWvV7/8XIag4=
Received: from liv.coker.com.au (n175-33-160-16.sun22.vic.optusnet.com.au [175.33.160.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 8FCB617421;
	Wed,  2 Apr 2025 13:32:47 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 Chris Murphy <lists@colorremedies.com>
Subject: Re: BTRFS error count 754 after reboot on Debian kernel 6.12.17
Date: Wed, 02 Apr 2025 13:32:44 +1100
Message-ID: <873501505.0ifERbkFSE@cupcakke>
In-Reply-To: <7b155ed6-da59-4560-9e2f-1ffa0143d84b@app.fastmail.com>
References:
 <3349404.aeNJFYEL58@xev> <3682098.taCxCBeP46@cupcakke>
 <7b155ed6-da59-4560-9e2f-1ffa0143d84b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 2 April 2025 03:00:33 AEDT Chris Murphy wrote:
> On Tue, Apr 1, 2025, at 1:18 AM, Russell Coker wrote:
> > On Tuesday, 1 April 2025 15:04:20 AEDT Chris Murphy wrote:
> >> These are likely old errors. You'd need to check old logs to see when the
> >> write errors occurred. These statistics are just a counter. You can reset
> >> them with `btrfs dev stats -z` and they'll go back to zero.
> >> 
> >> It's simple counter. It could be 754 errors seen one time. Or it could be
> >> `1 error seen 754 times. Or any combination of multiple errors multiple
> >> times adding up to 754 errors.
> > 
> > Is "btrfs dev stats -z" covered by removing the device from the set and
> > adding it again?  If so I did that but it kept recurring.  The fact that
> > the error count was there in the first place wasn't the unexpected thing,
> > it was the fact that it kept coming back and had no log entries about it.
> 
> Removing it with a `btrfs` command? Or physically disconnecting and
> reconnecting?

btrfs commands.

> The statistics are per device, persistently stored in the device b-tree
> which is metadata block group. So this metadata could be on any device in a
> multiple device Btrfs, not necessarily on the device that produced the
> errors.

It should be on the device itself and once the device is subject to a btrfs 
dev rem command it should be gone for good.

> I'd like to think upon `btrfs device remove` or `btrfs replace` the device's
> stats are also removed from dev tree. But I haven' tested it, and I'm not
> sure what the code says should happen.

After doing the btrfs dev add it reports 0 errors until after reboot.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




