Return-Path: <linux-btrfs+bounces-14994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9D0AE9DD0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49F05A1267
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062BE2E1C64;
	Thu, 26 Jun 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cobb.uk.net header.i=@cobb.uk.net header.b="Arcr34xC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2751EB2F
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942189; cv=none; b=ZblTrSTETSDd4EuHP7uWTRFV18qbawpgKt0C84k2j0rUPCW83VeKOE6EXZvb2dx1v7mqLimR8ny6jP7k2C5YjZtqNNulmRM+CUBVgwU6lJhxeTPljrQyRNz39DFJ40dR4r2v2PK+Haddw5FyAuk2f9iTcCNi9Q2B38JZdRhBDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942189; c=relaxed/simple;
	bh=yoM90IawnngJ19PSOOuElZ2sFrQY+zYnHr2EdBur+CI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=jVC2Wo1BDuabqSvRDOg4PO3Six/ualJ8uhAEbPeL73YmljuqC2bh358rujn13IYT87Lnqtr1RKly3KLZiIo6guIEqJSHpDkM2RLP77/ctnf3Y9/7HXhEJSk3SYafsg7uva+8MH98AbSs0/6nCG9+F6pruZVdVhDHwvD9gkPJhXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cobb.uk.net; spf=pass smtp.mailfrom=cobb.uk.net; dkim=pass (2048-bit key) header.d=cobb.uk.net header.i=@cobb.uk.net header.b=Arcr34xC; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cobb.uk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cobb.uk.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cobb.uk.net
	; s=mythic-beasts-k1; h=To:Subject:From:Date;
	bh=7NXICPgIsyP1I78o4/qSIDrQfw79e/VYIubpAeAJx/k=; b=Arcr34xC/kG+IHuTO1djazmuAN
	rWtQ2Z3EAd+aj1Igh/ZiktnZWxCKv5Hy/KgYOHwld8lunUSfB2OI2UicKmpb2siZVMyXm9PguQScZ
	eU8jV85LtJeniOd5yRz6aTAh/WKtI/XpKAQYDtEbbshTpreABgv/Lu0Ersbx7F0rHZA197NCeZ+gK
	N/rL4tK4hsOQz7mvnIYhi2PYx9xWT7l2GqlzgsIFojWziAfc6GxKs90OimkeZHYOWi4ToFe8SnqLQ
	oY53VM66MifN+upnA9DNFtAZhKIG+zw9+GBomQ3P6qBZVDR9t1Ko8I5XrrhuE2KqiyufIY+Abg2gf
	DKD+PxbA==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpa (Exim 4.94.2)
	(envelope-from <g.btrfs@cobb.uk.net>)
	id 1uUluw-005fzg-2j
	for linux-btrfs@vger.kernel.org; Thu, 26 Jun 2025 13:41:26 +0100
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
	by black.home.cobb.me.uk (Postfix) with ESMTP id 2ADD07DD708
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 13:41:23 +0100 (BST)
Message-ID: <f36e47c9-f135-473c-b1f1-2fedaef8aa10@cobb.uk.net>
Date: Thu, 26 Jun 2025 13:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: using snapshot for backup: best practise?
To: linux-btrfs@vger.kernel.org
References: <20250626114345.GA615977@tik.uni-stuttgart.de>
Content-Language: en-US
In-Reply-To: <20250626114345.GA615977@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 10

I do various sorts of backups but the main one built around snapshots 
uses btrbk. It doesn't solve the problem you mention below but it does 
reduce the problem to listing each subvolume once in the config file 
(which can easily be automated if you want). For example, here is an 
extract from the btrbk.conf on one of my systems:

#
# Data pool
#
volume /mnt/data
  snapshot_dir btrbk_snapshots
  snapshot_create onchange
  preserve_day_of_week monday

# On the disk itself only keep recent snapshots
  snapshot_preserve_min  5d
  snapshot_preserve 10d 4w
  timestamp_format long-iso

# On the backup disk keep historic monthlies
  target_preserve_min no
  target_preserve 30d 8w *m
  target send-receive    /snapshots/black_snapshots

#Do not snapshot the deb-proxy cache
#subvolume home/cache
# Do not snapshot emergency
#subvolume emergency
subvolume home/boinc-client
# For boinc just keep the latest plus one daily
  snapshot_preserve_min latest
  snapshot_preserve 1d
  target_preserve 4d 1w 1m
subvolume home/cobb
subvolume home/default-user
subvolume home/dmarc-staging
subvolume home/imap-archive
subvolume projects
subvolume home/mywiki
.
.
.

And, of course, btrbk handles all the management of the snapshots 
themselves (see the first half of the example file above, which keeps 10 
daily snapshots and 4 weekly snapshots on the disk itself and a 
different selection on another disk).


On 26/06/2025 12:43, Ulli Horlacher wrote:
> 
> I am using fsfreeze when running a backup to ensure a consistent filesystem.
> 
> While the backup is running writes to the filesystem are suspended and the
> whole system is unresponsive, e.g. logins are not possible.
> On certain errors the unfreeze will not happen and the system is locked
> forever.
> 
> Using snapshots seems a better idea for backups :-)
> 
> But snapshots do not include subvolumes.
> 
> For example the / filesystem has the subvolumes:
> /home
> /home/tux/test
> /var/spool
> 
> When I run the command:
> 
> btrfs subvolume snapshot / /.snapshot/_
> 
> the snapshot will contain only the root subvolume.
> 
> I have to manually add:
> 
> rmdir /.snapshot/_/home
> btrfs subvolume snapshot /home /.snapshot/_/home
> rmdir /.snapshot/_/home/tux/test
> btrfs subvolume snapshot /home/tux/test /.snapshot/_/home/tux/test
> rmdir /.snapshot/_/var/spool
> btrfs subvolume snapshot /var/spool /.snapshot/_/var/spool
> 
> Then run the backup on /.snapshot/_ und afterwards:
> 
> btrfs subvolume del /.snapshot/_/var/spool
> btrfs subvolume del /.snapshot/_/home/tux/test
> btrfs subvolume del /.snapshot/_/home
> btrfs subvolume del /.snapshot/_
> 
> But this will work only for this special example!
> And I have hundreds of systems to backup with different filesystem layout!
> 
> Is there a best practise "Using snapshots for making backup"?
> I need automatic detecting, creating and removing of nested snapshots.
> 


