Return-Path: <linux-btrfs+bounces-8512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5798F4E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1B8280ED9
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079FD1A76C0;
	Thu,  3 Oct 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="bP9o/tWH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52877433C1
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975452; cv=none; b=UZPgROSS0Z4Z3ZkkuKnGuauo9fqV/w1zboJrF0ORf9mbsoY7Ho3eSdV4X9qdHxnCMEsZZhf3v8tHZvzQD+GsCiwOBY/0FUKFVPQ1ns3JgjgiRcj7VlV288yUu77yqubBWiqqODm0r3arQ5NstGQhmd1kpZ3RboupQfbtx+M6EKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975452; c=relaxed/simple;
	bh=JKjbR7S44ol4H+DoabHAsZoMtDnQDDZzzG5mbZhfFjo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=fpuEeeioIHdWlJaUyCPdAbOHjsGxgYh1O0Tcb7uM1Y1n65UAdzO12aLrnykEtbwU45k2JCeI+dKpIEFjeiAjLBiW54rYPWtV4UKW7Ezqe7qTxRz15qbfTUT2gFzWCfZeEH/v4e+hM3t1NFu++05LG5nAl0wJ5cas14kvl1zQZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=bP9o/tWH; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id wPLdsKDs02bxewPLdsrlZc; Thu, 03 Oct 2024 19:10:41 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1727975441; bh=5srzR7oJo3X4CcIpj1l2Hyaje1DevdDhVMzfhL15It0=;
	h=From;
	b=bP9o/tWHFwX3EBWW0Aa1q9+KmdItnhZQ5+SDLJzEZf80MVUQVuJCQ5jtQuQM2icmZ
	 tU2CmgDhjhXtXEq7YJbz/2EUnCjm4ZyLn4FjxZbkl09+eHUobqUfXt6Fnxpaqefxee
	 UBnSn2MiRNfSTLoEOSl/6CFg4Qym+KYgcWh5aeM2IdUlDk3Fg40JVlecsdJNy4UQ+g
	 AdeI8UIIQnSxhFsqk4LB3kxsFxGgCkLpRR/zMy1c3+rZI0KWQuVoo+9L1E8HSadt8J
	 Ft2hOwI29pQRzrZTBoZL5xiQCSVBMdSOXvvUTLOSTpUiuA4xiJFuJw6Xzn/Rf7sgDn
	 fUQRkQpUHSRaw==
X-CNFS-Analysis: v=2.4 cv=bN/dI++Z c=1 sm=1 tr=0 ts=66fed011 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=jlxGcPDykXFWp798Uf0A:9 a=QEXdDO2ut3YA:10
Message-ID: <401088cf-85c0-4ea2-bc4c-b34138eae5e9@libero.it>
Date: Thu, 3 Oct 2024 19:10:26 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: BTRFS list of grievances
From: Goffredo Baroncelli <kreijack@libero.it>
To: waxhead@dirtcellar.net
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
 <4f672a82-28d8-490e-bdce-e794748d41fd@libero.it>
Content-Language: en-US
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <4f672a82-28d8-490e-bdce-e794748d41fd@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP+Z2pRLytgbkWw/LpXW8gejf2m04kCx0aZ/JFADR72TJ3cOFvUlHPjMIT0ecmrDx8DdCnFj6ESRMP7Mx6rzfkOzMSl63mNARxMNxYAIfTW1CP/rM9Oc
 h5vkeMUmBe9Vch0tmua66ay2+Q7wZrOchos9pGGrU0yEBokpg1PusHYAsXyiggrsDA5Yk2yzAx0nXMNbIkCZBsEEi8ZydsDguoS054/SPNWJwlvygOTrsJoM

On 30/09/2024 23.43, Goffredo Baroncelli wrote:
> On 27/09/2024 13.20, waxhead wrote:
[...]
>>
>> 6. DEVICE STATS:
>> ================
>> Again device ID's are not used, but also why is this info not listed in a table? Showing this in a table would make 5x lines become 1x line which would be far more readable. 


This was an already solved problem


$ sudo ./btrfs dev stat -T /mnt/btrfs-raid1/
Id Path      Write errors Read errors Flush errors Corruption errors Generation errors
-- --------- ------------ ----------- ------------ ----------------- -----------------
  1 /dev/sda2            0           0            0               763                 0
  2 /dev/sdb2            0           0            0              3504                 0
  3 /dev/sdd2           13           0            0              6218                 0

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

