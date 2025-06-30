Return-Path: <linux-btrfs+bounces-15093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC6DAED984
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A807A5425
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7122571DC;
	Mon, 30 Jun 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="pVlxrw/b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E8239090
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278462; cv=none; b=O9TyFqeXMXaWjDequsV0IfqKfzT9yYfgIjvyozW0nARZqI9ipIaDM6hokVgX1tVzwcLb0yuehvFCnLS2XXvJxyTwGNzgnaZGLzHJlNqTI9r917MpAetpTL8jG+BxJ/S0wueKw0C+8Mog1LPSAk7NMOUqi8SNwhGRZbEAYfPfDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278462; c=relaxed/simple;
	bh=0oft7MVSyXcGuNXRm1gIpzAQUHQr50gpnB0+lnuwH/E=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BD/6SSmkDx0KSSwEc7RoOTyFNAONP7N9iOdo9yzA2LEYkuCh9ZGeobNtS0GWg4eR9FZW19wiIC34FfB9fUGnLJaZ+ufl7j9u6ZeQVc1KIBOS9bUKETawRJ3d12JshoReFfUQbBOA+l3dyIoNdtIUxnwbyMKExnJfziX2XSrGEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=pVlxrw/b; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 5153F2931A3;
	Mon, 30 Jun 2025 11:07:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1751278026;
	bh=l6kNuRaGfZIYcHzQTduMH2XcJHjuEfx5fuvsdiQxxQE=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=pVlxrw/bF9Q0Ez+Mey7NbdUoEtV/ZKXODVsBqEsfeh8pfamPPl9WKAVRHA+g8cou0
	 tDgr4QwSRO2FntkGMCfXBCdNlmHooSysf8b2pTMUDsFZLnQcltkyjS15KLi/suH47m
	 NCBRkoyK4XLeV9AOCP4ik6uqfRbZVl18aC84IXss=
Message-ID: <82b6ddab-0eef-47b8-8010-9b09fcb70444@harmstone.com>
Date: Mon, 30 Jun 2025 11:07:06 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: restic backup with btrfs /
To: linux-btrfs@vger.kernel.org, framstag@rus.uni-stuttgart.de
References: <20250628173308.GB847325@tik.uni-stuttgart.de>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250628173308.GB847325@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/06/2025 6.33 pm, Ulli Horlacher wrote:
> restic (https://restic.net/) is a great backup tool but has some
> limitations or design flaws: one is, it believes that any subvolume is on a
> different filesystem. This means: "restic backup --one-file-system /" will
> only backup the root subvolume, but no other subvolumes like /home
> /var/spool etc...
> 
> One has to add every subvolume to the argument list. Bad if you
> create new subvolumes and forget to update the backup cronjob.
> When you later need to restore a file, there will be none...

This is a bug in Restic that needs to be fixed, though they may not see it that
way. The issue is that btrfs uses a different device number for each subvolume -
I believe this is because subvols can share inode numbers, and VFS gets confused
otherwise.

The same behaviour can be seen with rsync, which restic might well use
internally.

> My idea is now: I do not backup the original /, but do:
> 
> mount --bind / /backup/restic
> restic backup /backup/restic
> umount /backup/restic
> 
> Next evolution step:
> I could recursivly mount-bind other filesystems into /backup/restic/
> For example:
> 
> mount --bind /local /backup/restic/local
> mount --bind /data /backup/restic/ldata

This is unlikely to work, as bind mounts will also be seen as different
filesystems.

> That I would have a "all in one backup".
> 
> What do you think of this idea?
> 


