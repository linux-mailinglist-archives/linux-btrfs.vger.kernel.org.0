Return-Path: <linux-btrfs+bounces-15222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D747AF6C84
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84227AE681
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65EC2C15AB;
	Thu,  3 Jul 2025 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=render-wahnsinn.de header.i=@render-wahnsinn.de header.b="hmiuizh1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.render-wahnsinn.de (mail.render-wahnsinn.de [135.181.221.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DC2C158E
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.221.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530298; cv=none; b=iaM8A3Z0k3qfrysn1cEq1OEDeaCQ7MSMVqHm2VjD36YMDt57KKF77BTEd3H6cZ9QWGb4V+ghrydUxXSY9L7mrBcKP5RZGvfuS6GS5IkYl8E2Bpg1Q/Jl7w7EijWoc/JXX/7Wu3at9frMVIl0xv594otEhoNiihp3pWNfs+Vm+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530298; c=relaxed/simple;
	bh=onuAznHdSlgC/H9lrZ/ZIkKP1C3FWNQ0JMbeCivyxHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l7MdjGKuJIf7vNjmKwmFETYu29/EJxUnOwjsfHc0HHISi9NNqGIAoA8pGheqDD/iJUhYybHpivNbyhpuhvz0u4KfPZtXdyQ8BuYDbp915wsqBjnXqjmj3/AZ5sue1NUETx/SgSNxTZHHqGWro+R/+IKGYgdE2AlD9AAkz2BGEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=render-wahnsinn.de; spf=pass smtp.mailfrom=render-wahnsinn.de; dkim=pass (2048-bit key) header.d=render-wahnsinn.de header.i=@render-wahnsinn.de header.b=hmiuizh1; arc=none smtp.client-ip=135.181.221.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=render-wahnsinn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=render-wahnsinn.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A94015FC0C
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 10:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
	s=dkim; t=1751529606; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fZQ9Eq/WbdCycDWXCx39GUCX+pEUivI2pEr0BwedPo8=;
	b=hmiuizh1pPrJYFftR/oy7Hk8SYgWlnNETVid29F7ozc4sPFR+aT/MvX4ap6YGRl9WdW/xu
	aQvMAGvhPk0HTAaLwylQhjSJhukFfj4tDQeYNRvvruJZ7r5RqCk4tbMJahgEuXoa7Gfc7m
	YnG2s34Ee0PVBKObsEgEZYC46l8xGpCt12d8qZ++vsnEVwiGajKmwVjnRL4/1olgTHdJEy
	OpcgXlgqXx3+2DVOpXFXFSiIFOCzrySqadQ04uE47aL1wHwQ+QUQ7REnTANbVkQ3Bdgy+H
	Eo9+7b5lW/3dgGxgmNi2hAi87yNP9klKn/tjRdIA6iIXL0Txf2uJV7kFglHxnw==
Message-ID: <d882ddfe-b0a2-4b1f-ac28-145652ace126@render-wahnsinn.de>
Date: Thu, 3 Jul 2025 10:00:02 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: restic backup with btrfs /
To: linux-btrfs@vger.kernel.org
References: <20250628173308.GB847325@tik.uni-stuttgart.de>
Content-Language: en-US, de-DE
From: Robert Krig <robert.krig@render-wahnsinn.de>
In-Reply-To: <20250628173308.GB847325@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Why don't you just create a backup script, where you create a list of 
subvolumes dynamically and then back those up, rather than hardcode 
specific subvolumes?

I would use btrfs tools to get a list of subvolumes and their paths, 
create snapshots and mount them in a similar directory tree and point 
restic at the snapshot and backup up from there.
Either that, or if you insist on use --one-file-system, backup up each 
subvolume snapshot individually.

Am 28.06.25 um 19:33 schrieb Ulli Horlacher:
> restic (https://restic.net/) is a great backup tool but has some
> limitations or design flaws: one is, it believes that any subvolume is on a
> different filesystem. This means: "restic backup --one-file-system /" will
> only backup the root subvolume, but no other subvolumes like /home
> /var/spool etc...
>
> One has to add every subvolume to the argument list. Bad if you
> create new subvolumes and forget to update the backup cronjob.
> When you later need to restore a file, there will be none...
>
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
>
> That I would have a "all in one backup".
>
> What do you think of this idea?
>

