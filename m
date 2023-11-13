Return-Path: <linux-btrfs+bounces-114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582C7EA566
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 22:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4951C209F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 21:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FEF2D619;
	Mon, 13 Nov 2023 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="JjV8QrGX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E025115
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 21:20:07 +0000 (UTC)
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 13:20:02 PST
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B036D5E
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 13:20:02 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id 2eKirU4NvGKAA2eKirmJjM; Mon, 13 Nov 2023 22:19:01 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1699910341; bh=HQ8vsIpyLvzVEZQIaFWhTJBfcUNsCwNl3QW29NHlv4Y=;
	h=From;
	b=JjV8QrGXBqE+O7AAozelx36YcSv0CiGvacY22ur+Qcz/bRlm7MdJ/f/DwpfFXHxmu
	 2W2pHfeu8ZmDk4hLzdGoIbuf0quNfy1uvmp5VIoVGW3MTuRdG5gT7wIwL8LWecuKfu
	 bmpNAOBP+CUSsxGIQFbyU+aRHJevvZb1KxBtLljd7nrRXMzH4PjmbJ4rR+PgSGSeMI
	 tdx2JLJc5t51jXevowhVh8H57Zsuqd4JSMHPX2ObM7QsDNLeY25R8MFWyl+yXX9CNb
	 iRhu80Lde5pJMQ3+hBJKeU5CwE6djKanKPwQtk5v6rgSdKQKDsKpxZacSI6thmQUMX
	 yfCNAbjff2HqA==
X-CNFS-Analysis: v=2.4 cv=OoOJiQzt c=1 sm=1 tr=0 ts=655292c5 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=qxm2pN5k5gR1q23X170A:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
Message-ID: <a2019903-d439-4875-a612-0d73468df173@inwind.it>
Date: Mon, 13 Nov 2023 22:19:00 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: checksum errors but files are readable and no disk errors
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Johannes Hirte <johannes.hirte@datenkhaos.de>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <c47b7010-2993-43cb-91b4-13bc0d447260@libero.it>
 <f5729921-8f98-4510-b8fc-538b9bcfbad6@gmx.com>
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <f5729921-8f98-4510-b8fc-538b9bcfbad6@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMgPPI9U6WAkiMv4YxPjrGqpTCc1xcczBtaJQOTBVC+i69ILVaS5uArYgYAcT2I6BQuKJAQ+ZZ+tRb0igbYUQI82qSONcGKZLo/JpuQr1GTucUh1yen3
 WhEFVvKrmQWJdCpJE7D2DuellIlz/0babi4jDPHH97YP93NKDIo61DsQBsBQj/wdlMuKM9DduCvbstTGMfGYd68LNs8Wk58AG86Bi6uKmJKIMy5qJTBv5T4T
 4N8kD/7cJd13Vv1HJfxp/hO3NylC2g8sYPojZBVFjrA=

Hi Qu,

On 13/11/2023 22.00, Qu Wenruo wrote:
> 
> 
> On 2023/11/14 07:20, Goffredo Baroncelli wrote:
>> Hi Qu,
>>
>> On 12/11/2023 08.51, Qu Wenruo wrote:
>>> For the cause of the error, the most common one is page modification
>>> during writeback, which is super common doing DirectIO while modify the
>>> page half way.
>>> (Which I guess is common for some VM workload? As I have seen several
>>> reports like this)
>>
>> because this is an already known "bug" of btrfs [1], what about taking some
>> (non invasive) countermeasure like:
>> - put a warning in a dmesg in case of directio and a file w/csu
> 
> This can be overkilled, as most direct IO won't modify their contents
> during writeback.> 
> But IMHO we can do a double csum (csum at the beginning of direct IO,
> then the regular csum), and compare them, then outputting a warning
> message for it.

I am not sure that this would be a solution. Putting a warning when
DIRECTIO && CSUM means that sooner or later the user is warned of the fact
that the checksum might be not corrected. It is overkilling? Yes, but any
warning about a *potential* problem is "overkilling". A warning like this
put the user in the position to take a choice :don't care, disable the csum
(switching to another fs ?) or disable the directio (if possible).

If we warn the user only after the problem is happened, the user cannot take any
action before to *prevent* the problem.

We should pay attention that the goal of the warning is not to allow
the user to protect its data (which is impossible in BTRFS and ZFS [*]),
but to avoid the csum mismatch when the data is read again.

> 
> However this would affect all direct IO, slowing them down due to the
> extra csum.

But if the csum are not reliable, why the user should use it ? Event if
there is a bitflip, the user cannot be sure that the error is in the
data or in the csum.
> 
> Thanks,
> Qu
>> - do a csum ^ directio
>>      - disable directio in case of a file w/csum
>>      - return an error in case of directio and a file w/csum
>>
>> If we cannot guarantee the checksum when a directio writing is executed, we
>> should not leave the user under the illusion that the file is checksum
>> protected.
>>
>> BR
>> GB
>>
>> [1]
>> https://patchwork.kernel.org/project/linux-btrfs/patch/5d52220b-177d-72d4-7825-dbe6cbf8722f@inwind.it/
>> https://lore.kernel.org/linux-btrfs/1ad3962943592e9a60f88aecdb493f368c70bbe1.camel@infradead.org/#r
>>

[*] May be the latest release of ZFS allows csum+o_direct

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


