Return-Path: <linux-btrfs+bounces-170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC8C7EF7B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 20:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7562C1C2030B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D6C433DD;
	Fri, 17 Nov 2023 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="F9IqGU4e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670FACE
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 11:10:35 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id 44EYrNz3zGKAA44EZrU1AZ; Fri, 17 Nov 2023 20:10:31 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1700248231; bh=OnTq4zaIkK+gOih5kWf6JjLxMP2xlrNMTHMg4tVwu+o=;
	h=From;
	b=F9IqGU4eZCmCVYUfcPWJIFT1FbALEadTDXL7BpRzOEfa/8Fcd38OaBMdvkudG4Yuv
	 iOFvTOzRiYcsUzzpAtSW372RlFudQ+lZDAnmXMvLQoGoFYyYLga5JqrYNQWYQJzMrH
	 IZIYOjiotEW4bLCR3QHjXeaaA4BYcLwGnZyQ1F5KyoUkmo3QsmFYy7DWayXz1FquhV
	 Bp0m5KsHzMIMloAukjMcfjH50Q0KYX7EDoFHanP6A/JeinrTWb3m2AEaOGVGlQardf
	 lxvc2srnVZZN2at2o1Egb/xinCSotGuihH11n8R0VTLv9gJ6WjKSNk5uSQi/KCLPHS
	 4yiopKXBwn7Zw==
X-CNFS-Analysis: v=2.4 cv=OoOJiQzt c=1 sm=1 tr=0 ts=6557baa7 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=LPPgUBR8ukhsxVunpBsA:9 a=QEXdDO2ut3YA:10
Message-ID: <31ab3d6b-5a15-4cec-8ad8-b928c6502b9c@inwind.it>
Date: Fri, 17 Nov 2023 20:10:30 +0100
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
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
 <15a0b5f85425163e39edb7f2c5d9878a847754e7.camel@scientia.org>
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <15a0b5f85425163e39edb7f2c5d9878a847754e7.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIcNWxosOxWDhvqA60Sbvtn4nhYgv2NQIQuEEi4pZ8LmQ9RHSqMMSKpNUDOrqztjT9N0596Psj0hY4SRPCCc6enRHENvx2htdXp/zLbEzXO7FgcoyJTL
 phxczMIynDkSMBIxpt91snr5NrTdMEMLqJllbZoTOsylwcVHiP8aVdU/NUEchIUzec9eaDD4AvHcrLW999BdPjm1nYcW1ovbac3ehq88cVr//cgjSXL8VQOd

On 16/11/2023 22.25, Christoph Anton Mitterer wrote:
> On Thu, 2023-11-16 at 20:50 +0100, Goffredo Baroncelli wrote:
>> nocow means nocsum, then the system cannot tell which is the good
>> copy.
> 
> What I never understood:
> 
> When doing nowdatacow, then one cannot have data csums, because it
> couldn't update both csum and data atomically, right?
> 
> But doesn't that only matter in case of a crash (and then one wouldn't
> know whether it's the data or the csum that's good)?
> 
> And shouldn't it be possible to be made work properly in all cases
> where no crash is involved?
> So for all cases where corruptions might occur, except for the single
> case of a crash, one could still have the benefits of checksumming.

I am not sure to fully understand what you wrote. However:

- COW has bad performance when there are small writes + sync
- CSUM need COW
- COW alone is enough to guarantee the consistency in case of unclean
   shutdown
- CSUM protects from corruption due to external causes (e.g. cosmic rays).

In VM scenario, it is suggested to disable COW to avoid fragmentation and to
increase the speed.
This (the disabling of COW) causes a possible out of sync of data of the two copies
of a RAID1 filesystem.
Worse, because NOCOW means NOCSUM, it is impossible to say which copy is good.

Let me to do a counter example: the case COW and NOCSUM, doesn't suffer of
the problems related to the unclean shutdown.

In case of raid1/dup/raid10, COW is enough to guarantee consistency in case
of unsafe shutdown.

> 
> 
> If so, I don't quite get why it's not made possible for nodatacow. The
> worst thing that - in my naive understanding - is, that on a crash I
> wouldn't know whether the data or the csum is correct.
> But that's that's anyway the case with nodatacow and a crash.
> 
> So one would only need a way, that, after a crash, allows people to
> choose whether they want to ignore the csum and take the data as is, or
> rather get an EIO if the csum doesn't match.
> 
> 
> And again, naively thought: since we do have the generations...
> couldn't such a tool, just work on all data that has a recent
> generation, or if that doesn't work, on all data that is nodatasum?
> 
> 
> At least the last time I've checked, most typical users of notdatasums
> (VM images, DBs) either don't support their own checksumming at all,
> don't have it enabled per default, or have only some level of
> checksumming.
> 
> 
> 
> Cheers,
> Chris.
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


