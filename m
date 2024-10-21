Return-Path: <linux-btrfs+bounces-9026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D99A6C22
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF70D1F22F8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1031F941B;
	Mon, 21 Oct 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b="akAizoE7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7991410A1E
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521149; cv=none; b=OjB+zyZwjg1t2NrX7/T7CmvBmBTYgPMlXsJwF5FcF1r6e8wXqv8GZ47vqSUTWxURsyzybBBn8Sr7InN7ajGxX26xMxRZA5p4WkWvVzzJiX74y9LzM+qi59AmM7fbMBN0ESDfmqfqi/n6JghyZcYnl2UgIELllZPK6IF5ilvlLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521149; c=relaxed/simple;
	bh=MDnPeg1V4tvH3QD4EXMehMrQ09R/JIXzgZZ/Tj4nUJU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UYlp9Vhzma8bcA4M6ky01Q5gjrUtNR0cCC5f+pZ8K6DRzCrllkq8fJoUQYktsifU/XMw3SV3ssqHavH1lyZ627jI59ia67cf0oefY4YH5ayjsNMn3mWVXcaGQ2axz4a2iMnZGjGOAIa7O09BCunpqZuQM+wwqjJjiyeAzViltiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net; spf=pass smtp.mailfrom=dirtcellar.net; dkim=pass (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b=akAizoE7; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dirtcellar.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dirtcellar.net; s=ds202312; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
	Reply-To:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9I4h41tHV8RQp4F3W52EaIc+eRdvkgvjy5rb0bG7rnw=; b=akAizoE7gaMnbwR6BHCjrLRzBw
	+NI3zGvWsYqFW+DbF69HbONabCXcUGD3gYqo+cGCgxorDXsVErStQUOaJODhg4aVtpyDZoEd/1O92
	hnmAMOSU7uMfTyAIgK6cz+nEiIwwq5srKm2IDgylMglF/GAPgM+TLYWqx3kehk6dDyZcUzL7sJNk9
	55nHYc+P4a7DTIGWPdrsg0xHjlGRI1CyQyzOwkrFR8eYq2tDRQOq3X+RaYe6Mxy3u4i+FtSiVM621
	/gz95Hm9b29iSZLP2qhYbLUAZ2MA+ydAPKynYlMR+m+caspwNq059LmRGAAkJeccBm/AqswWGw0zT
	ItPAp8uA==;
Received: from 173.92-220-141.customer.lyse.net ([92.220.141.173]:57465 helo=[10.0.0.100])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <waxhead@dirtcellar.net>)
	id 1t2tSG-00GaM8-3S;
	Mon, 21 Oct 2024 16:32:20 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe
References: <cover.1728608421.git.anand.jain@oracle.com>
From: waxhead <waxhead@dirtcellar.net>
Message-ID: <09a3eabc-5e03-3ec9-d867-f86d4b40e2da@dirtcellar.net>
Date: Mon, 21 Oct 2024 16:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.19
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1728608421.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Anand Jain wrote:
> v2:
> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG.
> 2. Correct the typo from %est_wait to %best_wait.
> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
> 4. Implement rotation with a minimum contiguous read threshold before
>     switching to the next stripe. Configure this, using:
> 
>          echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy
> 
>     The default value is the sector size, and the min_contiguous_read
>     value must be a multiple of the sector size.
> 
> 5. Tested FIO random read/write and defrag compression workloads with
>     min_contiguous_read set to sector size, 192k, and 256k.
> 
>     RAID1 balancing method rotation is better for multi-process workloads
>     such as fio and also single-process workload such as defragmentation.

With this functionality added, would it not also make sense to add a 
RAID0/10 profile that limits the stripe width, so a stripe does not 
spawn more than n disk (for example n=4).

On systems with for example 24 disks in RAID10, a read may activate 12 
disks at the same time which could easily saturate the bus.

Therefore if a storage profile that limits the number of devices a 
stripe occupy existed, it seems like there might be posibillities for 
RAID0/10 as well.

Note that as of writing this I believe that RAID0/10/5/6 make the stripe 
as wide as the number of storage devices available for the filesystem. 
If I am wrong about this please ignore my jabbering and move on.






