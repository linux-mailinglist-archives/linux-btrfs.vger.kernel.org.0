Return-Path: <linux-btrfs+bounces-20225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 154FBD01238
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 06:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1B83300500B
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 05:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57810316902;
	Thu,  8 Jan 2026 05:38:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B872FDC3D
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850713; cv=none; b=XynBazK00bqfZcaINmtUeGt9llSxb9pTzHVurDNeL56vr9RzUl9AyibVMrgqYxR8d2lk6PcZEYLcKCS31P/kTVE+jcBbsXWrERj1dq4ls+psIUpY4j5v4czhvfCJH09d9/+nx08evESasVYcgIJ8dkYyTT1b/TmtDCvZjOfUgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850713; c=relaxed/simple;
	bh=RXiWLSMw6xkj7sl8FYxC2Zr/goEa1OEgltd5TU9pVpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oH8wMPniQkTzqNHQoERB7//LmISF1Bgamnc1CDWu4H6uyhRCFwmYZ8LfCUP0E8tcA6wNQapoqYZSI6Y1v26Sc4CfJxf5o5VnUjG62bbWu8vU8lPKIA3CTf9wuvJ2u96R7etbMODNKs6OiEHQ/PJRnrPjw1L726ar9p4kjTvCzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.0.romanrm.net [IPv6:fd39:ade8:5a17:b555:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 2C22240617;
	Thu,  8 Jan 2026 05:38:24 +0000 (UTC)
Date: Thu, 8 Jan 2026 10:38:23 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: use device_discard_blocks() to
 replace prepare_discard_device()
Message-ID: <20260108103823.49f7c778@nvm>
In-Reply-To: <5ff5f6b0-148a-4b48-a5f9-19215ffa3d36@suse.com>
References: <284c38aeccd4abefa2349d2bab1cefb09e89b5bd.1767847334.git.wqu@suse.com>
	<20260108095120.0d85f706@nvm>
	<35a26759-cd26-4d1f-9d84-03d13e909f07@suse.com>
	<5ff5f6b0-148a-4b48-a5f9-19215ffa3d36@suse.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 15:40:07 +1030
Qu Wenruo <wqu@suse.com> wrote:

> Well, this is a special handling for full device trim, where we don't do 
> any special probing on if the device support TRIM.
> But based on the first discard try to determine and output needed message.
> 
> Either we need a reliable way to do the probe (which is not that simple, 
> previously we had some try to use 0 length discard, but it's not 
> reliable), thus we changed to use the current way.
> 
> So it's not that easy to change without changing the timing of the 
> message or the behavior.

One idea would be to first call device_discard_blocks with "0, 1M" arguments
(or less than 1M, maybe even 4K), and if that succeeds then print the message
and call it again with the full device size.

But I am not certain if this will turn out simpler or more straightforward
than the current code.

-- 
With respect,
Roman

