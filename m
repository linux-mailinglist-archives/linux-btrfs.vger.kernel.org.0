Return-Path: <linux-btrfs+bounces-168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830E7EF79D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 19:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CB61F2279E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E586433D4;
	Fri, 17 Nov 2023 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="IrJ+7tLm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B658FE6
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 10:56:10 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 440erw4l5EwsU440er8Oa8; Fri, 17 Nov 2023 19:56:09 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1700247369; bh=ZeUZjX5WLzxmO8vMGeGxP6V3yGGUw1xoocDb1qNqsYI=;
	h=From;
	b=IrJ+7tLmyhBDMM7FjU3XP3z6uJ0I5u2OY/1lD7Y4mtaQ3cHHKq/gPybHeQCAHcvwR
	 dvnDUrceigPsHJlClBY4DtfmQAFFqtjh26zhgnJykQinbT0NiEd7FXKBLiX7IaKJOz
	 mWIB/O3gOfd+t0UjhdL6lq0jtfVcwPyapE461mvALAbkUMLpDWeo5/zxROfaFTaUGb
	 JYW0TnIg4CRRDrFX+bulbR43tGCxzePNyRh64YZJPa/TWYKIXlv3/cpKLbsGuE9mFv
	 Kr53arSqAdMx8AFXuEdrqCS80BZhwrHZ4VCGa7eRTKvTkF9HJSb4ieN8LAoTBzU9+/
	 rFbDmjrHpf+Jw==
X-CNFS-Analysis: v=2.4 cv=N6vvVUxB c=1 sm=1 tr=0 ts=6557b749 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=JBwH_H3BnaK8NAcj7AwA:9 a=QEXdDO2ut3YA:10
Message-ID: <4bf1d0d4-6fc3-434f-8166-7a628d48d52f@libero.it>
Date: Fri, 17 Nov 2023 19:56:08 +0100
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
To: Remi Gauvin <remi@georgianit.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
 <59b6ad3e-c16e-4a29-abd4-4d6f57047155@libero.it>
 <65b3acc5-0aff-a7e8-142b-4ad40c60f3dd@georgianit.com>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <65b3acc5-0aff-a7e8-142b-4ad40c60f3dd@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGxp1bcXMUPlbqihPkiN80jBW7bQqcSGNm+WGBcIBo03qIHRx/jf3bpNeP0UUGZ497qyUFOr+QoludejVR1ozkjwFI2C+QKobJcr0lHoE2xh7ST5/h0J
 FOO3nRhK60TtYlfIR79u313YGsNR5tr1V6467iaI7YsuLH/op0QCZiYuaHJky6CBb56nMFXvTgFy6a9VNeysGcGt2U1CQZcF5ckPmxWqRvxMGWtN1lLmCrmW

On 16/11/2023 22.42, Remi Gauvin wrote:
> On 2023-11-16 4:12 p.m., Goffredo Baroncelli wrote:
>>
>>
>> If we remove the COW (and thus the CSUM), there is no guarantee that
>> the data
>> is sync between the two copies in case of unclean shutdown.
>> In case of dis-agreement between the copies, there is no CSUM to help
>> to understand
>> which is the good copy.
>>
>> The metadata are still COW and CSUM protected.
> 
> 
> The Complaint I have is the reckless disregard with which BTRFS allows
> (and as in this case, is often suggested) to use BTRFS Raid 1 *without*
> Cow.  in the case of an unclean shutdown, if there was data being
> written to a NoCow file, it is very likely that the files writes will be
> interrupted at a different point, resulting in the two Raid copies being
> *different*.
> 
> By itself, BTRFS does not detect this condition.  Even if you were to
> manually scrub, it *still* won't compare the two Mirrors to ensure that
> the file contents are the same on both copies.  The exact data that is
> read back will depend on which drive is being read from.
> 
> If this is still the case, I would suggest that a workload that requires
> disabling COW on BTRFS, it would also be necessary to replace BTRFS Raid
> with MD.
> 

If you want that the two copies are synced, you need cow. If you want the
checksum you need cow. However cow is slow and causes an high fragmentation when
there are short writes + sync.

Even if I understand your disappointment, what are the alternatives ?
- MD (as suggested by you) have the same problem, the two copies
   may be out of sync (unless you journal the data, but this is also slow).
- ZFS ? I don't know how it perform bad/good in these scenarios. I suspect
   that it is a bit better due to its tiering structure.
- Reading the two copies and syncing these when different, choosing randomically
   a good copy ? This would avoid that reading two times the same data
   gives a different data due to which copy is picked. Which is not very good either.


> 
> 
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


