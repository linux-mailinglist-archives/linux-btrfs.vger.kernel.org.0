Return-Path: <linux-btrfs+bounces-10056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8D89E32C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 05:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F1281823
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 04:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0D17B425;
	Wed,  4 Dec 2024 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="QzfY0kI9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.scoopta.email (mx.scoopta.email [66.228.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C1502BE
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287834; cv=none; b=Zc8d4JsEIdOESlJclTD66dMPDgoxt8NT3oUWTXawz43/bTRvp31pyv20S0i/LadRf1xzME4r8jjASnPEAaf8lq3q+V2IIal1sP95cFwUPrkqhNdmJAizEeHVPfc2vYkcGQmV0tz0lQvZXB8+yMX2sGsyHnQ6kS5BV44WaaM5x2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287834; c=relaxed/simple;
	bh=doL6asNGWSTUoyd18PfGnSTYxLiOeoJmgCGOhAJKWHM=;
	h=MIME-Version:Message-ID:Date:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SXLTaq10YiyYUWaPJl2YmYC5J4ShcUnwfLv1p8Mz4WwJozjvbR9Ojf416yLpmQI08rq+7YyCyQFGlX10q91oOcd4rCsnHYzHJdZuZAdm/NA3r8d6pjkdo7QwGern0dv3DHugoXtHBJfA3dnxadD0/VXnwW4jaepPmm4eA5v7kTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email; spf=pass smtp.mailfrom=scoopta.email; dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b=QzfY0kI9; arc=none smtp.client-ip=66.228.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scoopta.email
DKIM-Signature: a=rsa-sha256; b=QzfY0kI9qilcAE2svyXPeBl/nQl/yQqZQZOcnHN8gACiAZpkMe6K5RomzSsW32Y25f261hGslK2npYc2ocf6Hxpb79AYkz+i/FFisfEmdCGQ7jMSxWe9vOeYoH8BekNEI3rf+Ett72+9Z7s3R+hYiNlFqINpWxF6xMea7nq4iUoFqktDjekL+npUv4OeqSJG9eVwl9ajejZQo7a7auTtruzfLYDadzp14lj6js6uhgzOQkvu2g6fLO4m1oYX/INUS8NKYLC5Pklh5slCHplQeuUrJ+TDKW5HHuHnq2R307BGKr3IgFahUXph1uPHeWXvSng4o/0x0TPCeTSIa2GVgnIFD0ovtmFjGtUSj5MpGszHscUNf1M8mhQUNIzPqLOObzCtmvZsAhgtLz44eICa7GkpXvvJG87vbISFXLEiQW9ZwXV38hBFlAoZmtVxdoZbfPr6oi7uHcIGLIkr3ZMsBBn5QJzqxgyGC0kpnxSDcfPHm9ov8moE5JNvwYyEN7qJJNAWK85C9RlLjCv0OeFGwEsrlD0WQVdFRnEWnL/N7ImvKGDxALn2zqiOQrsflH06B6yu7FXqu5CYcmYjdW7xmY8WRo4b4E+zyJGMBL6Vm7057JWSiKVPFAQ7/ii1MsRsM9sI9CmdAR/VTHjqe0J7KuRE8oNmDrIlciyM3xTEMMhBzWSYJ4/xiPmp2YsU1uLwO1CuHHObAN/fLFZO5KVOq0xK6Vl7IDH6BJ7EmiIIJVVBBDh/XrwUh8mk455g5SkvxXCm2AHvYTSFHoJ1Q7GbP9Y2P+jMWVn0sbhahSv43oeOxI7vrb3W3hRYvAfMSKArhxteuDhld2dge1D4rrcARPkQ5EsbVmBHPX5OC+UdYe8+w5Kffeu7AZuAjg0MdR9otEK1q2jeZ9mwa2/kCM+mC+x5Rks/p1epNQlxd7tslMbdBOGQ7sDf1y77PzUHlzWi6VdsU/
 HuQC/DRic68qWwYjw4389gsFjfbTBLfnBVOf0ycamsHZHebuQjtu+y09Ut/xwILKacOTvx2aQVzGSJTXQbQZvnukNMJQpRF2r6pKb9HG5bzEvow90dL/MulvKo+po93SjoikERp44HQzcvDxSrbogjhEtL5g+huw44+4vpOCIvx7bREgX779mlJ66vTSdHr2otqP/jqiR+y0g4ADdLiOG8sBVSlSXWYyRmC9yKfCRWT4CLbEXZ3LF/s9wKmgJV4pc36emEXtZlhOlCuVNgieGewuR6ljvVRQw4ihfheOkrKpmzq7UCUNiFrSwYooakqDHhFkvdcsTmPXyjNPA5Uu250wKiLTZl5GNdS6n9ZZpm3whdgypl83ff7ky0GI9TXXpwp7P3e8cESAkKeA==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=Kr4qCnrBpNva6OAhA5bTkWcvKwli+6KsFUSYNvAja6g=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UserIsAuth: true
Received: from me.scoopta.ninja (EHLO [IPV6:2602:2e1:80:111::f0c5:cafe]) ([2602:2e1:80:111:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID -948943269;
          Tue, 03 Dec 2024 20:50:31 -0800 (PST)
Message-ID: <e5f9df11-bd28-4605-ac28-d68ade32c4ce@scoopta.email>
Date: Tue, 3 Dec 2024 20:50:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
Content-Language: en-US
From: Scoopta <mlist@scoopta.email>
In-Reply-To: <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Oh wow, glad I asked, sounds like things have improved quite a bit. I'll 
make sure to use a debian backport kernel so I'm newer than 6.5. Thanks 
for the information.

On 12/3/24 8:40 PM, Qu Wenruo wrote:
>
>
> 在 2024/12/4 14:04, Scoopta 写道:
>> I'm looking to deploy btfs raid5/6 and have read some of the previous 
>> posts here about doing so "successfully." I want to make sure I 
>> understand the limitations correctly. I'm looking to replace an 
>> md+ext4 setup. The data on these drives is replaceable but obviously 
>> ideally I don't want to have to replace it.
>
> 0) Use kernel newer than 6.5 at least.
>
> That version introduced a more comprehensive check for any RAID56 RMW, 
> so that it will always verify the checksum and rebuild when necessary.
>
> This should mostly solve the write hole problem, and we even have some 
> test cases in the fstests already verifying the behavior.
>
>>
>> 1) use space_cache=v2
>>
>> 2) don't use raid5/6 for metadata
>>
>> 3) run scrubs 1 drive at a time
>
> That's should also no longer be the case.
>
> Although it will waste some IO, but should not be that bad.
>
>>
>> 4) don't expect to use the system in degraded mode
>
> You can still, thanks to the extra verification in 0).
>
> But after the missing device come back, always do a scrub on that 
> device, to be extra safe.
>
>>
>> 5) there are times where raid5 will make corruption permanent instead 
>> of fixing it - does this matter? As I understand it md+ext4 can't 
>> detect or fix corruption either so it's not a loss
>
> With non-RAID56 metadata, and data checksum, it should not cause problem.
>
> But for no-data checksum/ no COW cases, it will cause permanent 
> corruption.
>
>>
>> 6) the write hole exists - As I understand it md has that same 
>> problem anyway
>
> The same as 5).
>
> Thanks,
> Qu
>
>>
>> Are there any other ways I could lose my data? Again the data IS 
>> replaceable, I'm just trying to understand if there are any major 
>> advantages to using md+btrfs or md+ext4 over btrfs raid5 if I don't 
>> care about downtime during degraded mode. Additionally the posts I'm 
>> looking at are from 2020, has any of the above changed since then?
>>
>> Thanks!
>>
>>
>

