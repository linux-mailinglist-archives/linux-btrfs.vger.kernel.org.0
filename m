Return-Path: <linux-btrfs+bounces-16327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F8DB33631
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 08:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9B816FC9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4D2765CE;
	Mon, 25 Aug 2025 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAh2VNib"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDD18DF62;
	Mon, 25 Aug 2025 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102140; cv=none; b=JsMg+H1SlDJ1IL9iE4IMfVk121eEF8Ism0rtPKOYZXw7gRXGq019HZSm4Lgf9i5FlfkvTht5+eW0lLSlj5bDxLDFjACD6wVGEWEWUUSuj8HeBPgAbzzf9i8HIJKxbyOG7mnnzdC65cOMLGOzGhZ8m/q9d4wdTzUKujbj/sDaaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102140; c=relaxed/simple;
	bh=fOg2rikJSBXbdvaWm7pWnLtoNbBye1QoCZaFW8KYW44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkdcHKhQJMONVI2j1QxqsgbMdkpnD7S0ECDg2oHqnL+IAAiZqel7yFpzygRjcELyqw0CSld5YbMUYUx84Y++Jh2HnBkMMLgA+47HzkEVCoSWGO2/zDNpcCxKKSmOW36Fur5XPLfg6vV/thb1UYdaJ2D0jPzvUdCu6E+pT1lLkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAh2VNib; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24687a76debso10081935ad.0;
        Sun, 24 Aug 2025 23:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756102138; x=1756706938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWo0HvnFKQO2x4FLpne5+21ofwRrF2q/uH1iwkAkYZM=;
        b=PAh2VNibaiP90f96Yno1XTkiwh1ayXbqFj940h5+bxsvUzfckBwAV1wxN95zwXE0qQ
         IVlxDv/9xzyT9M9C9xTVZNNCheUlxugwl2dXe06LkmluocGcc7K/pwkT5peyQeT88gkr
         SDXGcKnNsYZ50i4w0iRrRGWQS85iF8/i1WnC0tjjAFFi4bYEsolD8muDm58QPU1ogvFq
         6NQ+WJFRynZBR6M6WlDtUKeYuSAJ73uK3e6TMDtfSqoEITvJAoEFpadqqQ4ddBDA/gda
         JnAXh72sPd9X9goKbj12aM6GqZXTaeLbPoxYo2foPfuvqJA03s0Yl8gB3GthkShhpdXc
         Z0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756102138; x=1756706938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWo0HvnFKQO2x4FLpne5+21ofwRrF2q/uH1iwkAkYZM=;
        b=ns0ZmfESUiRJrocvmxv3HQ7pkGZnLKaJVNUXmMXarNjQiBvBe0o6j2JCQkVgrg+sYR
         dqoQdp+4+XcMzR9PNIrTFoZYDhv4LvM/kPBzEs3ae30mLdBCtC2rkKHvczn8z3T2cwg9
         yHY+YUu9ep9LxjicZuaRkynFAxucps8WQgsADtI6GoPzcvlllnJ9evzmkXmga+g3l6Vg
         h8Gxc9+sH1dXwYk/fvUzPJsjM3+kcLF/cjvF3yUi505xV3SoXGpgPlISDz5zwM9no47v
         N1PdyyJ+OvHi+lIrcm6LOrl+jJBEqpVAKTL076pizbI1G5SedMGOD3EauY+6qQTC0Jpt
         +mMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6/5Xx4AzO6KowI43s6UuTIZjz7MIv8LsK8zWJDbs6lzKUG1X7yDUi4UaGN7o9d+h+9GaRMq5i@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFBEnhEJU9lnv49OG/CbI2VnFNTINmr158CuuUctO6DfvULm8
	e/oA2NBtI1d7LQf6YZZonYFjBO6Ov8/TRY87S8BbmwghJBVH6EmCbUIL
X-Gm-Gg: ASbGncvp95/6OBQtzXvmb0k4YJ8rT/vj/DR+N89Si/sqVejWOirfd9UPBcjf5nNjOjL
	5joOXtVcfq5oFbMJawwR2hZXP3wlDxsPGGFYb3/YwdHxUGdbhFvZteZldn/YoeM+j16kbm1hL9d
	BidqsrupM7yZebH1/tTeoeiTCYip2+dJuUDKzPoBrkSicPIWP7QGJXOsCczEbX6OEDQxdgyPNrv
	lovxVdCka1bzmyfKcuLbNQSx9AcE2NvMKDJLGgL/uakkh42K3cuSwk4mSodxe0bq4Vk2DVGab4n
	oxLxy/ZfeYwQEJ5AfFrRSykSFNyGp1rJOQf1tv5nCZwUB7l7L5h1LrnZ0Omg5VS+l+YCIuM4Adb
	BACg1ZKimsya0zRyVEh0xHmBbROMKjinv
X-Google-Smtp-Source: AGHT+IGqLbbCRlDHxwlxlar/vEQzKA8yrc23ORBwx0Iq8p5h+4QqUtl2WnnLOxBCfgCn0OXRH71I9w==
X-Received: by 2002:a17:902:d542:b0:246:c428:ca4 with SMTP id d9443c01a7336-246c4281372mr35791575ad.25.1756102138303;
        Sun, 24 Aug 2025 23:08:58 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.214.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688801bdsm57973175ad.123.2025.08.24.23.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 23:08:57 -0700 (PDT)
Message-ID: <30a36652-2476-4244-bcdf-c576e12565bf@gmail.com>
Date: Mon, 25 Aug 2025 11:38:53 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] generic/563: Increase the iosize to to cover for
 btrfs
Content-Language: en-US
To: Disha Goel <disgoel@linux.ibm.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
 <7e337d30307b293b30c6ad00c1fc222bbeed640c.1755677274.git.nirjhar.roy.lists@gmail.com>
 <501cb5ba-4890-4f1c-815a-4b15cf7942e8@linux.ibm.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <501cb5ba-4890-4f1c-815a-4b15cf7942e8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/22/25 20:07, Disha Goel wrote:
> On 20/08/25 1:45 pm, Nirjhar Roy (IBM) wrote:
>> When tested with block size/node size 64K on btrfs, then the test fails
>> with the folllowing error:
>>       QA output created by 563
>>       read/write
>>       read is in range
>>      -write is in range
>>      +write has value of 8855552
>>      +write is NOT in range 7969177.6 .. 8808038.4
>>       write -> read/write
>>      ...
>> The slight increase in the amount of bytes that are written is because
>> of the increase in the the nodesize(metadata) and hence it exceeds
>> the tolerance limit slightly. Fix this by increasing the iosize.
>> Increasing the iosize increases the tolerance range and covers the
>> tolerance for btrfs higher node sizes.
>> A very detailed explanation is given by Qu Wenruo in [1]
>>
>> [1] 
>> https://lore.kernel.org/all/fa0dc9e3-2025-49f2-9f20-71190382fce5@gmx.com/
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>
> The patch looks good. However, the subject line seems incorrect, could 
> you please fix it.

Thanks. Added the RBs, fixed some typos and sent the final [v4].


[v4] 
https://lore.kernel.org/all/cover.1756101620.git.nirjhar.roy.lists@gmail.com/

--NR

>
> I tested it on Power, and the generic/563 test passes with both 4k & 
> 64k block sizes.
>
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
>
>> ---
>>   tests/generic/563 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/563 b/tests/generic/563
>> index 89a71aa4..6cb9ddb0 100755
>> --- a/tests/generic/563
>> +++ b/tests/generic/563
>> @@ -43,7 +43,7 @@ _require_block_device $SCRATCH_DEV
>>   _require_non_zoned_device ${SCRATCH_DEV}
>>     cgdir=$CGROUP2_PATH
>> -iosize=$((1024 * 1024 * 8))
>> +iosize=$((1024 * 1024 * 16))
>>     # Check cgroup read/write charges against expected values. Allow 
>> for some
>>   # tolerance as different filesystems seem to account slightly 
>> differently.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


