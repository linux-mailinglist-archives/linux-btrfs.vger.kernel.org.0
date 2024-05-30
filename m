Return-Path: <linux-btrfs+bounces-5371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B18D5179
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 19:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EAA1C223C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F34D135;
	Thu, 30 May 2024 17:47:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.pmacedo.com (mail.pmacedo.com [178.79.159.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98847A73
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.159.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091272; cv=none; b=l/BA35VyZVJVKFC3p0tRot2NqJ0a3uk8UDXT1svKfI60zZzd2seoOntxNEvTZrzFjaQKKn7TLEgFgMQzPnc9qEVIUU4qjM1p4FYUPNBgC3JBCPg1vSyIthqLf+eyaVxGgyhZbDsmk6Xx2K784vi0fctsTLNePg86vDM3BapTPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091272; c=relaxed/simple;
	bh=qis0yxBrJa9V4wKEopwR5reaJi+mzc256L5ClhznUy4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=pb2jO9ei0OBx915LU2n9AyDSHHcVzCJ7yyMRQxJ7kLJ7Plw2UXfaDrXlAHAM3UMQx/4DOOGOOVxnT1k4diMPmvbr5gm31q+SbFaQrbyDn4alz+3sPE8OHY6F0oTRqzOSaQh8OP1n2+D1gp+W0ia9ZyCI2Z8e1TIY5JF93JC6Ryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pmacedo.com; spf=pass smtp.mailfrom=pmacedo.com; arc=none smtp.client-ip=178.79.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pmacedo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmacedo.com
Received: from localhost (localhost [127.0.0.1])
	by mail.pmacedo.com (Postfix) with ESMTP id A187A227A24
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 17:47:46 +0000 (UTC)
X-Virus-Scanned: Debian amavis at mail.pmacedo.com
Received: from mail.pmacedo.com ([127.0.0.1])
 by localhost (mail.pmacedo.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6lIyWZzebChY for <linux-btrfs@vger.kernel.org>;
 Thu, 30 May 2024 17:47:45 +0000 (UTC)
Received: from [IPV6:2a02:168:5209:0:cde8:7916:6dc:fdad] (unknown [IPv6:2a02:168:5209:0:cde8:7916:6dc:fdad])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(Client did not present a certificate)
	by mail.pmacedo.com (Postfix) with ESMTPSA id 8F1502277DE
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 17:47:45 +0000 (UTC)
Message-ID: <0d06a11a-a218-4e2d-a035-3711b03caa3c@pmacedo.com>
Date: Thu, 30 May 2024 19:47:43 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Profile conversion - unexpected large allocation on target
 profile during conversion
From: Pedro Macedo <pmacedo@pmacedo.com>
To: linux-btrfs@vger.kernel.org
References: <4122a35a-a7ba-4deb-8db9-6e67647f53cd@pmacedo.com>
Content-Language: en-US
In-Reply-To: <4122a35a-a7ba-4deb-8db9-6e67647f53cd@pmacedo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-05-30 2:36 PM, Pedro Macedo wrote:
> Is this over-allocation during conversion expected or known? This is 
> on kernel 6.8.9; I only really noticed this because one of the 
> filesystems failed the conversion with ENOSPC even though there should 
> be plenty of space. For now I'm working around the ENOSPC issue on the 
> smaller array by using a loop with dconvert=raid6,limit=100 followed 
> by a 30s sleep.

And to add to the oddness found on this conversion: the workaround now 
hit ENOSPC, even though technically it should be possible as I have >4 
disks with free space (but only 3 disks with equal amounts of free 
space, which I'm guessing is why ENOSPC is being triggered):

Unallocated:
    /dev/mapper/evg--1                   0.00GiB
    /dev/mapper/evg--2                   0.00GiB
    /dev/mapper/evg--3                   0.00GiB
    /dev/mapper/evg--4                   0.00GiB
    /dev/mapper/evg--5                   0.43GiB
    /dev/mapper/evg--6                 51.95GiB
    /dev/mapper/evg--7               127.95GiB
    /dev/mapper/evg--8               127.95GiB
    /dev/mapper/evg--9               127.95GiB
    /dev/mapper/evg--10               95.92GiB
    /dev/mapper/evg--11             100.95GiB
    /dev/mapper/evg--12             105.95GiB
    /dev/mapper/evg--13               33.92GiB
    /dev/mapper/evg--14                 0.00GiB
    /dev/mapper/evg--15                 0.00GiB


However, if I now run a balance with -dprofiles=single, I can clearly 
see data being converted between to raid6 with no errors, which is extra 
confusing - different code path being used perhaps?


Thanks,

Pedro Macedo








