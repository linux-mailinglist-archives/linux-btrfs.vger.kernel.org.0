Return-Path: <linux-btrfs+bounces-3732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2389073E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759901C22758
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6DA8004F;
	Thu, 28 Mar 2024 17:34:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15712B76
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647283; cv=none; b=M6J4TIVPCh7DOukHE/Vdcg+IKMH7dDdi/NlvB4WFmS5jZpzkliK1KiAq1BQmQZl7EPd2YFq78jinpG6dGMjhMlERlpMNPZLiXgQqLSCNTmlOMFidP41LiwdgBekuSAeGSYXHZKfibfZWtXdP9NTL150TKcU18EjKlJmrLBIN7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647283; c=relaxed/simple;
	bh=XYs8i69hvmiTJTMulg7P8yrBy/6iy2nBHOkIaxdW69I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lekfD9S/nPjwkIvz7WRsYcYxER/WMo+JjQJIstA/6fxm4bYc5/g45qn/TBNdO+b5o3w9hw4hVUumVYRQiclXlIrey4g2a0m9iEW/Uq3lW+RF1skR4Wr2UHQgmwygFZlzX4+yHlmopUlXzqIlGuJ2sjxhfoWGPGms2n0h+MqPz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (unknown [IPv6:fd39::4a:3cff:fe57:d6b5])
	by shin.romanrm.net (Postfix) with SMTP id 71FF53F3C3;
	Thu, 28 Mar 2024 17:24:31 +0000 (UTC)
Date: Thu, 28 Mar 2024 22:24:26 +0500
From: Roman Mamedov <rm@romanrm.net>
To: "Massimo B." <massimo.b@gmx.net>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs 
 <linux-btrfs@vger.kernel.org>
Subject: Re: I/O blocked after booting
Message-ID: <20240328222426.6cd2c31d@nvm>
In-Reply-To: <94addf02f0eac5e5f402f48f41d16cb80d17470b.camel@gmx.net>
References: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
	<22650868-6777-41ae-a068-37821929be7c@gmx.com>
	<47440995279bdba442678e807499fff05ee49302.camel@gmx.net>
	<94addf02f0eac5e5f402f48f41d16cb80d17470b.camel@gmx.net>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 15:55:15 +0100
"Massimo B." <massimo.b@gmx.net> wrote:

> What can I do about that failed to trim?
> I have tried this on different disks like
> 
> Samsung SSD 970 EVO Plus 1TB NVMe
> and
> Samsung SSD 860 EVO 1TB SATA
> 
> Trying again after the failed to trim, I got it finished again with
> 156,8 GiB (168413265920 bytes) trimmed
> 
> Should fstrim be fast if it was just finished some minutes before? Why there are
> again more than 100GiB to be trimmed shortly after the last run?
> 
> Is there anything broken with the trim on these devices?

860 EVO do have a bad history with TRIM and NCQ on some controllers:
https://bugzilla.kernel.org/show_bug.cgi?id=203475
But IIRC the affected combinations should have a fix in the kernel by now.

970 is not known to be affected.

Most importantly, do you see any ata errors in dmesg? Such as "SEND FPDMA
QUEUED", or any other.

-- 
With respect,
Roman

