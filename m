Return-Path: <linux-btrfs+bounces-172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 457B77EFB20
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 23:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F46EB20BEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61A3446B1;
	Fri, 17 Nov 2023 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="DwLf5aBb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1DD4B
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 14:00:57 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id 46tTrOrLYGKAA46tTrUUlE; Fri, 17 Nov 2023 23:00:56 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1700258456; bh=/VH+D+NeGEopdM8AwdUuA68h+g5sDw4ETvQD6dj5bvM=;
	h=From;
	b=DwLf5aBbe02013PjqTSs02CSlUyA6r4uPIf0T2G9EYah3N2L7tZxWHCFmegqnxD7q
	 mpnRKUWf/YHPlJlgDu9ksN3Xy5vcEFNM9jdz0c7Kt7HG5z7nmPaESPgxKtMeWsQ/es
	 wcdrS4u8pZ+nN9aHUGbwZD8k/7CaLuLkXRVzYZJGZIBmoX3OWRdQiPLF0J23bNrGqT
	 SgrRXfHAeNjdtXUdmyn5NWN6IU4+XIJdmtfPgb/oH74FVX3kZHUxudtlNYAcnLhZwi
	 6hKS7QEzrWiBifYVo679XruA9UWgpqA1p55MQWKigMJQ/LMWYRS0Zle3Giy1Apak1F
	 z0Q3/IQmzpTLA==
X-CNFS-Analysis: v=2.4 cv=OoOJiQzt c=1 sm=1 tr=0 ts=6557e298 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=jrBqA5t7BCvrIOjTMHUA:9 a=QEXdDO2ut3YA:10
Message-ID: <cecd43db-da2c-4558-b343-4faabacdf0d8@inwind.it>
Date: Fri, 17 Nov 2023 23:00:55 +0100
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
 <4bf1d0d4-6fc3-434f-8166-7a628d48d52f@libero.it>
 <9f955c4a-82be-98cc-6f61-ee5469c32ba2@georgianit.com>
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <9f955c4a-82be-98cc-6f61-ee5469c32ba2@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK4o15Sp5NgBVUTQT8lirATsqaCl+qe+mYpthTvtU26m8y/gWVfwwvvrp4BOtPCikHqtjkPzoVhDmwSpKK9ha1FhRzHWbib7JJlFC8LdWuDAHmCn/NzI
 0RP2DMqTOFUiBdkxq5AcnzlyOlIqxazaZoUyNOZp0Sdy/7Wx+wmqMzmXztM2pGIkaWcCLBDmRDWgjgGPYbVYNUcoyLhRFvnnUpo75wOS3iuPJ6Y3QONVmwRJ

On 17/11/2023 22.25, Remi Gauvin wrote:
> On 2023-11-17 1:56 p.m., Goffredo Baroncelli wrote:
>>
>> Even if I understand your disappointment, what are the alternatives ?
>> - MD (as suggested by you) have the same problem, the two copies
>>    may be out of sync (unless you journal the data, but this is also slow).
> 
> No,, MD, (and any other Raid Implementation I have ever heard of,), will
> have a mechanism of detecting unclean shutdown, and will immediately
> re-synchronize the mirrors.  (This can be fast if using something like
> write intent bitmap, or it might have to scan and re-sync the entire
> drive, but mirrored drives are never left out of sync deliberately.)
> While the drive is out of sync, 1 drive will be considered canonically
> correct.  (ie, will only read from one drive unless there's a read failure.)
> 

I think that we should put everything in the right order:

- COW:
	preserve data and metadata even after an unclean shutdown

- BTRFS with NOCOW:
	preserve metadata even after an unclean shutdown
	data may be wrong
	depending by which disk is read, the data may be different

- EXT4 + MD (with a bitmap)
	preserve metadata even after an unclean shutdown
	data may be wrong


So yes EXT4+MD (with a bitmap) is slightly better than a BTRFS without COW.
>>
>> - Reading the two copies and syncing these when different, choosing
>> randomically
>>    a good copy ? This would avoid that reading two times the same data
>>    gives a different data due to which copy is picked. Which is not
>> very good either.
>>
> 
> That is what Raid does (classically.)..  Yes, data corruption will
> happen to a file is a write is interrupted.. (that can't be helped
> without cow, or data journalling of some kind.)  But you don't end up
> with different random corruptions.
> 




> 
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


