Return-Path: <linux-btrfs+bounces-10099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9C9E77DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8134B284EF6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D7F203D41;
	Fri,  6 Dec 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="Z71zglcv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB612206A5
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508776; cv=none; b=nkFZr9craKLl5sxYluinICj0v9fGT+86g8O/PKnwWOdSoHaMK6AAZt8G7+lVYI+H518SEm5AYuTkRnOa9Yi9jQrcWITGlSganfzSojH86BOGcI/EgrehKX/xE092c5UxzQlGf60UkZt+UnQlwU7vwEe0BJ6DAkTGhmS38PalneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508776; c=relaxed/simple;
	bh=0WsRMOGQzs86KELutDgcZQcMqvB6+nU25GWSkEu0N/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=baw9nFzeY/NVwaR6iOjiZG0cIAQne2iFf1YIhGPcs9A0/R6K8mYRfHnP2pRtTmFCpwQcjt3OAGds3dydfgsHYnN6X9VGYkDSM4+uEI/eFwiDU+hhIEoxbpbUzf0tdk9fJsEPFwGqSbumesYPg3Xkd39xufEfZ7c9NA4ptlABUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=Z71zglcv; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id JcmNtg9FMx4RAJcmNtYPiO; Fri, 06 Dec 2024 19:10:15 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1733508615; bh=RPThpADeVEhPwMtiOXldk8ympzPTGXdcp/zaYSJykzU=;
	h=From;
	b=Z71zglcvAP98ZicqNDpmt0aSakzsRd7jcrtmRNFmOMOYG+DzQxx0q6HSbvddWt29g
	 0ETnkY5cJvUVi5bfKjljxj6TPVGyOThM+7VZOIh/rMK412FQuQ0ASXbSH4Yie9O+1S
	 IsUGv1TAbviv6HrG4uHlul7BStoRUYV/l6+DLihoMl+EeG6nr5+c9rg/Gxg5k+V1fE
	 dIMQHkj8j65azYO8gn1M29z0K8xIzmHvoeu3cb0MvTpd4Kk8vjP1OBCt9MelBxpJ7W
	 68hQN7s9b69S9QXOhy+AOvhqPWoKUA9JCyDiJJhDbuXRTcxx5wKzkoAXFKvaICHwpJ
	 StOK7suenKpGA==
X-CNFS-Analysis: v=2.4 cv=Fcf8x4+6 c=1 sm=1 tr=0 ts=67533e07 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=j9opc7AhIdtwNly09wgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <d3173d91-278f-48bf-ab47-3541eab84245@libero.it>
Date: Fri, 6 Dec 2024 19:10:14 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: Using btrfs raid5/6
To: Qu Wenruo <wqu@suse.com>, Andrei Borzenkov <arvidjaar@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, Scoopta <mlist@scoopta.email>,
 linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
 <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
 <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
 <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIrCqCobXAxM1NsPCASxGWy2txZ9eMP+QiNdkcBkTgNhM/oE5/JfFhAkkvzmW8GSmzt1sDj7TAX/ls8znG0Hh1DQe092mab9ytIRL9FQcqXnf6NjpKJ1
 B9N/DnMl9CpSkJyPJnNACw8TlD2F3RTvBavRW23cJ0KUCjXi1rRsj7ZSQmENI0nXIc8H8fNVqd5Qy9VZiiaNM8qCDqWIxxvRIN9ZXml+buJiRq/DdeQ35Ya/
 Q5Kp8b6KNf/oNpJMujf5djNFKQvYBFQMTAVJ5ZXfxHC8tWGNkSRNjLaeHvGBb+ixhUabYGdyjbwmRNRzSYSezA==

On 06/12/2024 05.16, Qu Wenruo wrote:
> [...]
>  as case 1.0, even missing D1 is fine to recover.
>
>
> So if you believe powerloss + missing device counts as a single device missing, and it doesn't break the tolerance of RAID5, then you can count this as a "write-hole".
>
> But to me, this is not a single error, but two error (write failure + missing device), beyond the tolerance of RAID5.

The "powerloss" and a "device loss" can be considered two different failures only if these are independent.

Only in this case the likelihood of the combination of these two events is the product of the likelihood of each event.

However if these share a common root cause, these cannot be considered independent, and the likelihood of the event "power loss"+"device loos" is the likelihood of the root cause.

The point is that a "device loss" may be a consequence of a power failure. In my experiences (as hobbyist) when a disk is disappeared is very frequent near a reboot. So the likelihood of a write hole is between the likelihood of a powerloss (single failure) and a power loss+disk loss (two failures).

However, this is not the real problem. The real problem is that if a scrub is not performed after a power loss, the data and the parity may mismatch; or better, the likelihood of a data mismatch is low (because the data likely is UN-referenced), but the parity mismatch likelihood is a lot higher, because the parity mismatch is related to the stripe (at whole) that contain the data updated and not necessarily to only the data that it is updated. And this mismatch is not correct until a scrub.

So the "write hole" happens even if the "power loss" and the "disk loss" events happen not at the same time. It is enough that a scrub (or a read) is not performed in the meantime. This to say that considering that the "power loss" and "disk failure" event likelihood as the product of the two likelihoods, is a bit optimistic. If a regular scrub is not performed, the likelihood of this combination is near to the lower likelihood of the two.

This is not specific to BTRFS, however MD solved this issue performing a logging of a stripe update.

A more general solution would be implementing a logging like what MD does. I think that you, Qu, did a prototype  something in the past. BTRFS is advantaged by the fact that it can skip this logging when a full stripe is written (if the full strip is not written is not even referenced). MD can't do that.


>
> Thanks,
> Qu
>
BR

Goffredo

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


