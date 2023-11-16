Return-Path: <linux-btrfs+bounces-161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE97EE8B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 22:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD0CB20C49
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E773BB3E;
	Thu, 16 Nov 2023 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="wF9o6DwP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7958BC
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 13:12:57 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 3jfTrlqyYEwsU3jfTr0mDD; Thu, 16 Nov 2023 22:12:56 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1700169176; bh=7ujvwIoV/UM+2m/sqBs7s28zI3I6MijiHF2GRiwaoP0=;
	h=From;
	b=wF9o6DwPiR7jgNIPuMQqmCZnMlyFuEX0Nr5gQnxLcLiVLF0ZlKd1x8TDtEO8gmZfq
	 /QHjwJo2HeaihaIG6Ui8hlg4vDcG88wx2Y895SRqPvSadxir0tB816TYDoKeVqfEZx
	 vRx7vC9dlq48y9ijJhYIGfjiyHD7AAhu2NpmidJzkRmfj5pEBBRYKFTrNebZRgySDn
	 vHAOgtm7Z+VPaFzskEq7kwWcRnTFfcenJSdMz6RIgp3IqWxkaJsXv2cseHrAz58RbU
	 +ZcarWtXmBIvJYaokc0tnWwdw/R/ZJMhmvaNS+7bPgA+zZe/Wo64Q+TOWGeGZZcUS3
	 2/Y3YNv2fTkBg==
X-CNFS-Analysis: v=2.4 cv=N6vvVUxB c=1 sm=1 tr=0 ts=655685d8 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=8FrBgBojkTsOwnWsMnIA:9 a=QEXdDO2ut3YA:10
Message-ID: <59b6ad3e-c16e-4a29-abd4-4d6f57047155@libero.it>
Date: Thu, 16 Nov 2023 22:12:55 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: checksum errors but files are readable and no disk errors
From: Goffredo Baroncelli <kreijack@libero.it>
To: Remi Gauvin <remi@georgianit.com>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
Content-Language: en-US
In-Reply-To: <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMBMwHFtI6RqTN8eLv9iE83kWJqYi6wSIjArW4nPLdZjSLyuJempDRChpSv/KkMkqyy3SxXkerQvyO03mB1E9Eey8o1vCkEGEgmWvjDUaissjuYEkzE9
 olKHjrJDPW6nC8M6KNkWKwNrHNVQFUPPi9JaqNoE/4E0a2yGgzBuD1ft+a1tWjnQLMqHxAmyR9BcuByB3W+w3BAdybS9N4g9XjPR4N9UJRnD4ElfaP3On9oD

On 16/11/2023 20.50, Goffredo Baroncelli wrote:
> On 16/11/2023 15.30, Remi Gauvin wrote:
>> On 2023-11-14 3:18 p.m., Qu Wenruo wrote:
>>>
>>> Disabling COW is recommended for those VM files, as it implies to
>>> disable csum, and reduce fragmentation.
>>
>>
>> Doesn't disabling COW on BTRFS RAID1 Still result in inconsistent
>> mirrors with unclean shutdowns?
>>
> 
> Unfortunately True,
> nocow means nocsum, then the system cannot tell which is the good copy.

Sorry I was too fast, and my answer was incomplete.

In case of an unclean shutdown, the COW nature of btrfs would guarantee
the consistency of the data+metadata. Moreover in case of disagreement between the
two copies, the CSUM helps to understand which is the "good" copy.

If we remove the CSUM, the first part still applies: the COW nature should
be enough to guarantee the consistency, even in case of unclean shutdown.
In case of dis-agreement between the copies, there is no CSUM to help to understand
which is the good copy.

If we remove the COW (and thus the CSUM), there is no guarantee that the data
is sync between the two copies in case of unclean shutdown.
In case of dis-agreement between the copies, there is no CSUM to help to understand
which is the good copy.

The metadata are still COW and CSUM protected.

> 
> BR
> 
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


