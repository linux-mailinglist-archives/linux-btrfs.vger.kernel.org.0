Return-Path: <linux-btrfs+bounces-18122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A83BF7A13
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA0164EEBDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFD9347FE2;
	Tue, 21 Oct 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aarghimedes.fi header.i=@aarghimedes.fi header.b="AnP8Jq7z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from aarghimedes.fi (aarghimedes.fi [92.223.105.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AE355057
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.223.105.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063649; cv=none; b=fEZNeOmSbB4YEEmaJIxjkODKMQ8Yr5S6ESgwERFVYlLtTB7pUYGkCdG+mjDYlAA2zbcCycXanzr2K9D2+n+1z5vgC588+UsHTe/BoSZ79ef5sze4U+yMUeguYHplBedOeM+o41WkFz63B2AxoEjXcyPFtNlbeDf7Tp0e9HYRUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063649; c=relaxed/simple;
	bh=o2R0lfSXoBn1hVRfX2n09oC8qepli8bBv0F4hB3py9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JUoaAyrvhysURszwxq1VTe9vaT19VMlfrgD2DTHojMPOLb6hVhmbDr1Og9oramNLhUepnOMrrItH9mi7/gPAh95GXTXzoTgdrHcxHIRoa5Iga5XUTvxZ78RhpWc8FFA6wWC7qxT4ZEmGURDeLrAii81V9ktD1DEsEa6dE6SJvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aarghimedes.fi; spf=pass smtp.mailfrom=aarghimedes.fi; dkim=pass (2048-bit key) header.d=aarghimedes.fi header.i=@aarghimedes.fi header.b=AnP8Jq7z; arc=none smtp.client-ip=92.223.105.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aarghimedes.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aarghimedes.fi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aarghimedes.fi;
	s=default; t=1761063336;
	bh=o2R0lfSXoBn1hVRfX2n09oC8qepli8bBv0F4hB3py9I=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AnP8Jq7zI6PIY7x3dSQbKrflYvhl0qHokp/sJalZbNNd81QvJpOSyJt2aH4v0G2MF
	 1KM54R10jbeKsQPY6Kl6871kt8HZYGlsjeOKOE/5PSoI87j9L8QhksnEMxF2wkO3Q2
	 57hfDntDqim5EhOVZ8MIOX3vKsAUi1RsGJ7vUgIAqydUpZA9qxAhdMbZDI7DL1vhC9
	 dqP/YJ8QBwRW+93Z2IUCwUb4GtMCe0iZRdVo3siaoMAvpxwy+rMIOTi+aHDJgjwBp0
	 q4DdllJxyG6XELEm8gIHMsfZsIynKh0QyJcAp5F5f4NCRQk/3U7+xvoeybRLgzlYC/
	 3rpEQHPsX5c/Q==
Received: from [192.168.122.121] (79-134-115-245.cust.suomicom.net [79.134.115.245])
	by aarghimedes.fi (Postfix) with ESMTPSA id 3B46F204B4
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 19:15:36 +0300 (EEST)
Message-ID: <a4848938-6578-4d62-857a-890f7345d043@aarghimedes.fi>
Date: Tue, 21 Oct 2025 19:15:35 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <3a3df034-4461-4c35-b170-a5084586d2b3@gmail.com>
 <d7e67eee-ac1a-4677-8bed-25c358c66c81@harmstone.com>
 <a8a16938b9112d7aa68b6df3de30d35c116fb17a.camel@scientia.org>
From: Jukka Larja <roskakori@aarghimedes.fi>
In-Reply-To: <a8a16938b9112d7aa68b6df3de30d35c116fb17a.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Anton Mitterer kirjoitti 21.10.2025 klo 18.53:
> On Tue, 2025-10-21 at 16:46 +0100, Mark Harmstone wrote:
>> The brutal truth is probably that RAID5/6 is an idea whose time has
>> passed.
>> Storage is cheap enough that it doesn't warrant the added latency,
>> CPU time,
>> and complexity.
> 
> That doesn't seem to be generally the case. We have e.g. large storage
> servers with 24x 22 TB HDDs.
> 
> RAID6 is plenty enough redundancy for these, loosing 2 HDDs.
> RAID1 would loose half.

Also significant, RAID1 only protects from single drive failure, RAID6 from two.

-JLarja

