Return-Path: <linux-btrfs+bounces-10512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6F89F5915
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 22:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9431716D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E201F9F79;
	Tue, 17 Dec 2024 21:44:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF131F37C6
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471856; cv=none; b=EBp2RGS7QC1YGyOxIUjTYNP5PhY4aQZdrJ4j7MgsQr5jfD8VGWU3OR9NeUWaTVF2dvZT5X2hLPob/PHBlac3zk8UHUJy7PwPeuB40h5BiBkDFf3wmX3sT8PmcijdtOghpHEGFureSJr5rG+QNK1t0udH/eRASWgJ8R1ddEy4Vlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471856; c=relaxed/simple;
	bh=tCGV74sH3vdsNWv/ZcZqSRdrxGNyr57GMpARriFeLyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NjFf9sJlbXHJ2P4cH7b/YgCZvz52anL43UByQRJLATp+tFArfYRUxEsLPK02xehicFMO7HUJOz3SsmNMicYeiLKxtVs+5vZDABQBERZimUJ8vqRI3h/NirFL4+p6MJ+HyJLHjHcK02nzsmxNP87A0fSIWaXQNPjiqrIjIxJT3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 7FDA2C03A39
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 22:44:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uoMGAnT9EWKB for <linux-btrfs@vger.kernel.org>;
	Tue, 17 Dec 2024 22:44:02 +0100 (CET)
Received: from [192.168.55.34] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id CD249C03949
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 22:44:02 +0100 (CET)
Message-ID: <c4a2c262-4701-4507-be4a-db90b893bd7b@dubiel.pl>
Date: Tue, 17 Dec 2024 22:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 97% full system, dusage didn't help, musage strange
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
 <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
 <4144f14a-8742-4092-b558-d1a9de4d03e5@dubiel.pl>
 <8eb9e55e-7a61-4c1a-b5ab-acf35ba4396e@gmx.com>
 <ea8eb95c-e64a-4589-b302-23eb1fc6bd5c@dubiel.pl>
 <a6a641f6-b0a1-4915-912a-638cc07eba88@suse.com>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <a6a641f6-b0a1-4915-912a-638cc07eba88@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>
> You need something procedure like this:
>
> start:
>     if (unallocated space >= 8GiB)
>         return;
> check_usage_percentage:
>     if (no block group has usage percentage < 30%) {
>         delete_files;
>         goto check_usage_percentage;
>     }
>     balance dusage=30
>     goto start;
>
> Although there are some concerns, firstly the tool, sorry I didn't 
> remember the name but there is an out-of-btrfs-progs tool can do 
> exactly that.


Thank you for hints. I'll search for that program and try it.





