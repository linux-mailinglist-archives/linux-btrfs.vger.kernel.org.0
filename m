Return-Path: <linux-btrfs+bounces-4541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D438B13DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 21:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A00283BD2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3113BC20;
	Wed, 24 Apr 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="CBteshOG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AB1848
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988697; cv=none; b=dzwEd8AiJcj4o1t2UBze/yC955hIuTATqXCUAXr+JirKECvA5AHuU+dAXzwCoGhv4EaRKoeUv0p1pK1AqIvDurGV6lXc4aUHV7osL8hmRYQyLWTE/iU2GZLDzFs0L64tEMmSDIiv7XoQIWXWZGWiaW04mcT0i72kPEdm+JyVONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988697; c=relaxed/simple;
	bh=tgmUpTAYd/4XQRVUZt4BDgziY8PV/qDZn7Zf49EYzqY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MCb+J6Lt/GO151Us9t5skkcHr/WR4+Z9MTF7H0Fb2l/8tCBhe7oBDHlWlJfO74Eko4r05eDrjB25SYlWbN0tjpJPe4+PAdUsEwjiLbiEgKVLUk3S7tbsnqKDDdxtuPYtqckPrpjfHICQFa6npKxKlaxhc+a51FJ9uytKCfuZjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=CBteshOG; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id zikurgVYzzTQvzikvrmJtM; Wed, 24 Apr 2024 21:58:13 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1713988693; bh=IIvE99SVHf/U1TJQ56ToO4qTDtBsbb3exXARHiYIAS4=;
	h=From;
	b=CBteshOGn4aaz6cev1Yp05VE6VJA0FRrMyZWTNaxF5qQyf/T7YBLGJs3JcDm0QmLF
	 uIWTbLO7XZvtq5KQsNJQ4P0naaZOibkK1peScZ70QNZkqBYgKR0Bz2WKmUA1VCheYT
	 //hjZyjDwcpLJzcVkw6R+EDh2+9ZLSOTlacMEYNn9AV/Fhp+s2flduuhfBgWPGX5lE
	 0vpo/5s14e3UKbqgPOW0TSpzTAFzzujNpuWqtORG5Dw64v1UBrKiuBJd1nsbsN0Zw2
	 7SRuaGz14eFwhTsN6gcgU6aqrVciH1b4AqPhjv7tK+szWPekYwCfiWxAW3L9aovZHX
	 1XRYMSu6YZgaw==
X-CNFS-Analysis: v=2.4 cv=PJXE+uqC c=1 sm=1 tr=0 ts=66296455 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8 a=7kUzt1AaCKh-bZeUMJsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
Message-ID: <2864ff12-1d6a-4559-9f42-0cbcf7eed74d@libero.it>
Date: Wed, 24 Apr 2024 21:58:12 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: fsfeatures: hide RST behind experimental
 builds
From: Goffredo Baroncelli <kreijack@libero.it>
To: Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>
Cc: HAN Yuwei <hrx@bupt.moe>, linux-btrfs@vger.kernel.org
References: <a45bd8eb8d16b648368b2e83f12a72ea44dab71c.1713937746.git.wqu@suse.com>
 <d0b14c11-c224-4fb4-b9d6-ad7bfa0ecbba@libero.it>
Content-Language: en-US
In-Reply-To: <d0b14c11-c224-4fb4-b9d6-ad7bfa0ecbba@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBj6CxYP5DHWGY9n5LusMMpu28emsUDXkw2OzwDzj+nYxBmHuFDwxpFDScZ0noY/RpWGoXZGaZM39xed3PTG4dzi4Zp/LDmKE6BLKNe7tv12hXMdkUSd
 rW9YAo6tyaxfB9P9bm34HHTDV5nSjJuuuCdAxorAzdEzMwV9uLNpG1PnBppMUMzaW51IUVgWYsuj7LP0NIS+J3WpDY57hZZLDQdlvBIKnz45uMyMl1x+tqIF
 B6NVtZl6WWz0Dr+ODUhWopYQl35PBpWP8Sgy1W39m/M=

On 24/04/2024 21.30, Goffredo Baroncelli wrote:
> On 24/04/2024 07.49, Qu Wenruo wrote:
>> [BUG]
>> There is a report that with v6.7.1 btrfs-progs, `mkfs.btrfs -O rst`, but
>> kernel 6.7/6.8 are unable to mount it at all.
>>
>> [CAUSE]
>> Although the feature string states the raid-stripe-tree feature is
>> supported since v6.7 kernel, it's not correct.
>> Only debug kernel with CONFIG_BTRFS_DEBUG would support the RST feature.
>>
>> Thus RST is still considered experimental.
>>
>> [FIX]
>> Move the RST mkfs features back to experimental.
>>
>> This patch would only hide the RST features from 'mkfs -O' options, the
>> existing supporting code for RST would still be there, thus
>> non-experimental build of `btrfs check` can still verify a btrfs with
>> RST.
>>
>> Reported-by: HAN Yuwei <hrx@bupt.moe>
>> Fixes: b421fdff9574 ("btrfs-progs: move raid-stripe-tree and squota build out of experimental")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/fsfeatures.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index c5e81629ccea..7aaddab6a192 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -222,6 +222,7 @@ static const struct btrfs_feature mkfs_features[] = {
>>           VERSION_NULL(default),
>>           .desc        = "block group tree, more efficient block group tracking to reduce mount time"
>>       },
>> +#if EXPERIMENTAL
>>       {
>>           .name        = "rst",
>>           .incompat_flag    = BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE,
>> @@ -238,6 +239,7 @@ static const struct btrfs_feature mkfs_features[] = {
>>           VERSION_NULL(default),
>>           .desc        = "raid stripe tree, enhanced file extent tracking"
>>       },
>> +#endif
>>       {
>>           .name        = "squota",
>>           .incompat_flag    = BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA,
> 
> I am bit confused.

Ignore this email.

> 
> The Han report say that the problem is due to the fact that the option is enabled by *default*.
> 
> So way we should remove (from the binary) this option at all ? Shouldn't be enough to remove it from the options enabled by default  ?
> 
> Something like:
> 
> -        VERSION_TO_STRING2(compat, 6,7),
> -        VERSION_NULL(safe),
> 
> +       VERSION_NULL(compat),
> 
> +        VERSION_TO_STRING2(safe, 6,7),
> 
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


