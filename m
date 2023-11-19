Return-Path: <linux-btrfs+bounces-187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C757F059B
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Nov 2023 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747321F21C90
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Nov 2023 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EDBD2ED;
	Sun, 19 Nov 2023 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="pottNLd7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA3AE5
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Nov 2023 03:24:30 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id 4fucrc5zZGKAA4fucraCUe; Sun, 19 Nov 2023 12:24:26 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1700393066; bh=O+ii9JmIbJPOqty+//0wQ/MIOeRSvVCL5/Siz/vXPxw=;
	h=From;
	b=pottNLd7NqfeI0pihSlrjGyMGt8IMM1Q4ZPDJdRuqx8lRGwSAp8lzOGIAdaByYPU3
	 OnFsL/mqcG0dybmF1Dde/4h9OY17cU9sKTb4N2EZP+9qw69CGwFpN7n/q0y7+JA2J7
	 GmwaxH/3lF0+txPIskSgH4l5h0vhk2zF7qHuAIz6X2ZKkwsbZadTAMR6yk2LeRIh+0
	 lS2n6xzhdIwuHjh/3pdKuPud1838Pt7Y3TJXiIYDlvPwWNox6aiW/QsvGDbc4DapGQ
	 PUs+mlAfepd337fZTueEVS8eQQGPx/fIEEWKxeX7gCcYSgYPnMw6FVqeJZ2tXRuLrC
	 YBuG4eODinSlA==
X-CNFS-Analysis: v=2.4 cv=OoOJiQzt c=1 sm=1 tr=0 ts=6559f06a cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=HEnqKuICbuCCPOXILOYA:9 a=QEXdDO2ut3YA:10
Message-ID: <398d34db-e8a6-4116-af6c-ef325944a7d7@inwind.it>
Date: Sun, 19 Nov 2023 12:24:26 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: checksum errors but files are readable and no disk errors
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
 <15a0b5f85425163e39edb7f2c5d9878a847754e7.camel@scientia.org>
 <31ab3d6b-5a15-4cec-8ad8-b928c6502b9c@inwind.it>
 <e713409c7a72e0b2f8ccca5a99b71115df0a694b.camel@scientia.org>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <e713409c7a72e0b2f8ccca5a99b71115df0a694b.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfME2QDzNOEFNeQnisgcISsIEdcqYdhuAVFz2tsY3CynhmR1jnJdPXaXDIpKLYxcLXcU/NXWkVq7iTR2y0atpTEt+dds1cN7NpiyJCptqvG25rKtEZraO
 0wgK0tV9/GB7nWmQhbSpNXfy9HqlGvH7q740XYdlYyKTBLJScxeU1XTTpfEvu4cFdDH5rkUkjvP8/wCjl2Qs9nDZeqF9F0xsatBtkmyif6Uln4mrdB6tK9UZ

On 19/11/2023 00.16, Christoph Anton Mitterer wrote:

> 
>> - CSUM need COW
> 
> Not clear.
> 
> Why can't we e.g. calculate the csum, write it and write the data (or
> vice versa)?
> 
> Yes, it won't be atomic, ... but isn't that only a problem in case of
> crash where one is already written but not the other?
> (Maybe that's the point where I misunderstand things)
> 

How you can understand if:
- the data mismatch due to cosmic ray, or
- the data mismatch due to incomplete write

> And in such crash scenario (with nodatacow and the current no csum) we
> won't be anyway sure whether that particular data block would be
> completely old, completely new, or anything in between.
> 
> So the only case where we'd loose something is, when the data was
> actually written, but the csum was not (and we'd get a false positive).
> Yet, we'd get the csum protection for all other cases (bit rot, cosmic
> rays, etc.).
> 
> If that's the case, I'd rather be able to have a notdatacow+csum mode,
> where I live with the fact that things may be uncertain in the case of
> a crash (with I on my systems experience typically very rarely).
> 
> What would however be needed is a way to manually recover from
> data/csum difference. That could be a scrub (which allows one to choose
> whether to simply re-calculate the data or consider such data damaged),
> could be a mount option, etc..
> 
> 
> 
> So I guess my main point/question is:
> 
> Why can't we have nodatacow + csum, other than for the case of a crash.
> 
> And if that's the only case that would pose problems, is that really
> worth it or shouldn't it be users choice.
> 

This thread born by the fact that in case of directio, it is
impossible to guarantee that csum are correct. Now we are discussing
to add another set of cases to made the csum less reliable.

However I understood your point: allow a set of cases were the user may
allow to lost data (which may be lost anyway); after a crash the
system should be able to do a scrub for the last written data and
recompute the csum were possible.

This was a proposed strategy to mitigate the raid5/6 hole: in case
of crash, recompute the parity on the area that was updated.

I think that there is a generic complexity due to the fact that now
the system is able to write data when it want. With a change like
we are discussing, the system should collect all the write and before
updating the disk, it has to log what is updating.

May be that this is a too invasive change.

Anyway IIRC Qu proposed a patch for the raid5/6 case...

> 
> Cheers,
> Chris.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


