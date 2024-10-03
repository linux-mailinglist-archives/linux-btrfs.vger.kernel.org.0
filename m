Return-Path: <linux-btrfs+bounces-8515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F314998F601
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 20:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8128CB21F09
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695FE1AAE2E;
	Thu,  3 Oct 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="ZAbwSQ91"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA5847F5F
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980041; cv=none; b=pkUWsJCEHPFtWvaXg19P9JaNEQ3cf2hB0vDnIl+dVfwAmqk+KxzGWhVM/SCTc7wb7oW+wRk7onRxstzG/c60OWpNWzqCse0cq/+XrwQZ+KApgU/KToX3drof/Xlec+0Kg/TlmqX/YabU9uTjAhxsdQ+ebvOqNzy8vbsmEOzw09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980041; c=relaxed/simple;
	bh=kszYJN321nr4EXuPRYW9e0OqivcPpvR0VrghzCHOYRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5NHPBZP/KmMiPJ+jjEl7ecVja5XtuPRvxERHzy4gNnScpEoPc2NDfQyWLmFRUeOj04//hKFQcgUdp7Bxv3XtqydJrw6Mfv6oFr3rWnzXNMSm1mpAK6iSyFQk5yaC7jwp2KoFiBW/TEGx3cqg4TtwpOSyF9Fy0IQPp1AHXEJpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=ZAbwSQ91; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPSA
	id wQVBsKRJRn1YKwQVCsTMr8; Thu, 03 Oct 2024 20:24:38 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1727979878; bh=9yZS2n/odx/V3WPQjp4F4lSztSvZa5zR59lrCoHeWdI=;
	h=From;
	b=ZAbwSQ91TdYyyQ+0LyizfVJWSloyFOzFSRVT8o4R1M4u2DQ75lQlB8FVLoc72fTUS
	 pQxCwUUi1SD6ftKdSdyZqQHml+nGHobAQ/suIHke33H/CtmGzkzXLEVZ/vFfLyN172
	 Yh7g3GHexlE30GS3SuUilyIb1IxpKBPdLv3Go6Oq7b4R+hsxiOZuRaM3S7Wkx9wR/q
	 +Appavu3SNCHAjEWbs2waidEr/cxPGCqt1P1NVVa2H7S0BCERR4rPDPVj+NWHJo1sv
	 TcHJPFEAvBd09aCJthoG0ENy6ul83cgOODfdvodbv75hYglEFlRTVU7UzvWZpgTQcd
	 oBHcae3ASIxkQ==
X-CNFS-Analysis: v=2.4 cv=F62cdbhN c=1 sm=1 tr=0 ts=66fee166 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=ok5rCHcrOnwyp_ZeS8oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <2733d961-cef0-4fac-8a46-3d74f1c4bf7a@inwind.it>
Date: Thu, 3 Oct 2024 20:24:23 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: BTRFS list of grievances
To: Remi Gauvin <remi@georgianit.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
 <4f672a82-28d8-490e-bdce-e794748d41fd@libero.it>
 <401088cf-85c0-4ea2-bc4c-b34138eae5e9@libero.it>
 <8236a191-88d5-b2bb-2048-87b49539a8a3@georgianit.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <8236a191-88d5-b2bb-2048-87b49539a8a3@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAsYXVnmqGfAyQl3xA3/tZYtaazPYiwshk9qx8kKo725CwiHDbC7sQLZj2Rijbr8ePMxDpr4AeGSjidqgjf4byo0u2aIb5AWy2Czdc/9mm5ikxqsrL4H
 vpWrs2TWSDMqceE9TG9b5whvbS1qMK0OlUhIiTVjyNm0XmtayQKeOm2EIfYxpw33Eya9OlT3fTjcQz3A/EztokmGugngaxE4WzW2/x1YZ4pGZlkbFjJ1HtLR

On 03/10/2024 19.26, Remi Gauvin wrote:
> On 2024-10-03 1:10 p.m., Goffredo Baroncelli wrote:
>>
>> $ sudo ./btrfs dev stat -T /mnt/btrfs-raid1/
>> Id Path      Write errors Read errors Flush errors Corruption errors
>> Generation errors
>> -- --------- ------------ ----------- ------------ -----------------
>> -----------------
>>   1 /dev/sda2            0           0            0
>> 763                 0
>>   2 /dev/sdb2            0           0            0
>> 3504                 0
>>   3 /dev/sdd2           13           0            0
>> 6218                 0
>>
> 
> I hope that's a made up sample and not actual output of your
> filesystem.  Otherwise, you have a problem...
> 

It is a real output, and I didn't notice these errors.

This was an old disks set. And these are old errors, due to a bad power supply.
Replaced the power supply all the problem disappeared.

Of course I didn't have any data issue, due to btrfs+raid1.

However I never cared to clear those errors. Anyway I run a "btrfs scrub"
which didn't find any error.

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

