Return-Path: <linux-btrfs+bounces-15091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D831AED96A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 12:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07070189881F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51FC253922;
	Mon, 30 Jun 2025 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="rMX1j5R2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CB23F27B
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278164; cv=none; b=fmpHWrP18sGKC4Nk5VhiFsrHE9DKlJGrUX6LAjUWcRoJnnT0Ls469E9WPqfPTjwHpWL7yQbxtmjJ4stJ1yuOCexPC4mu4dhObaAcKyJy6A6b9i3M79rn/EOYGiwzpWl7Z2fyXBMc3hVfnlihbUHAv35eyH8QcIX1/6doIVXnfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278164; c=relaxed/simple;
	bh=8bAv0bYUhy9TCGU8j0W9HbLS88I8oQawA6A+2LJTYes=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tvDxD3p2y/vHIiZymcJz9eRSvhgsVyrCx5WavMPcRA3e6RX46OBKM3p34pnGxE4xOkvMT2ucuJ0afToln0amRjvS2NJiAlsauwmq/dEC/ngCn0EOu4HWy4lE0Xm2ISaswGcyXzbr/rEXCSg8+jee1p0bVW6C4R2LLV4oTPaBkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=rMX1j5R2; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 4C1452931A6;
	Mon, 30 Jun 2025 11:09:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1751278154;
	bh=sU+98e1z47nHBSBif2vo5xoE2TPflnge2GQkvzXsAOk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=rMX1j5R2skOhFhJMCWvSAWq6MnGp7pcuEa934BzP723l53dy1vWOhY8hIlU/pPT8c
	 BoU6zYfGdZ6N8imJDQzH/guf0RAhkBoG616GuJJThGYWCgqSlr4wJXUaZx8IVRwtaf
	 vC30vbFK64KmcJIvYSRgEQ2PRzGY+ZJXPgv7XirM=
Message-ID: <b7d55f63-5827-4bbf-b0ff-dea46b00f7dd@harmstone.com>
Date: Mon, 30 Jun 2025 11:09:14 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: using snapshot for backup: best practise?
To: linux-btrfs@vger.kernel.org, framstag@rus.uni-stuttgart.de
References: <20250626114345.GA615977@tik.uni-stuttgart.de>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250626114345.GA615977@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2025 12.43 pm, Ulli Horlacher wrote:
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

Omar Sandoval had patches to add recursive snapshotting to btrfs-progs, but
they never made it in, for reasons I can't remember.

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


