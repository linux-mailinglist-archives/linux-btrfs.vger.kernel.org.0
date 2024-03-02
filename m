Return-Path: <linux-btrfs+bounces-2985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B37B86F125
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 17:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEF72833C4
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4E1B5BA;
	Sat,  2 Mar 2024 16:19:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6DE1A5A2
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Mar 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396376; cv=none; b=lXwYqMeu/5yEWAt2s5fzXshmH8VkGSFtLId+VeWYezk0h1Ci0tuCGLazKGSY+KOHydPJ83eRDnl7jg0Q9EbI0sTc6S2Aik7aJaNHXwLZoTjGtSFC2YLatVtLQ6QC9p5a+L88kvm67SUh39Z8UF5TA/hhXMO38YHIHNG9sFuI4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396376; c=relaxed/simple;
	bh=6p0KWGR1uWNpLBoG4wDjbLwe5LT1AB4tTGpJv0AFQcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWvZNc2rabIphG8bpOSFSshGXZIB4WgNWPv57nYyOKHTgZqrTQwip2guR/KYix9ekgzKrQWqn3u3MhphK4DcJEEWBYUEDsU1jLse2gBgQynVTLozrVCkur7DlaO/KNWcVeNCpe90uFF16vCCiOCaxO8N5ZIgI0KR0jPX1aWmWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
	by shin.romanrm.net (Postfix) with SMTP id 1FC4C3F8ED;
	Sat,  2 Mar 2024 16:19:26 +0000 (UTC)
Date: Sat, 2 Mar 2024 21:19:23 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Nigel Kukard <nkukard@LBSD.net>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs ontop of LVM ontop of MD RAID1 supported?
Message-ID: <20240302211923.6e4cfad4@nvm>
In-Reply-To: <20240302204726.6d2dcd87@nvm>
References: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
	<20240302204726.6d2dcd87@nvm>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Mar 2024 20:47:26 +0500
Roman Mamedov <rm@romanrm.net> wrote:

> I made a Btrfs on top of LVM on top of RAID1 myself now, but on consumer SSDs.
> Copying some files to it now, to check. Would be also helpful if you can find
> a precise sequence of commands which can trigger the bug, less vague than
> copy some files to it and see.

After some file copying, snapshotting and reading back, I did not manage to
reproduce any corruption so far, on 6.6.18.

-- 
With respect,
Roman

