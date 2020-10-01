Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15E28097C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 23:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgJAViu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 17:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAViu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 17:38:50 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9AC0613D0
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 14:38:50 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ef16so146105qvb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Oct 2020 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vt7d0zdFS4wZ28y+i4PGnON2eviCG47Hq3eyXnwFFws=;
        b=QeY71ZkbLN+He8+9pzp0zFgQuRY3TKfZFqbhOIWWHe4k5RznERE/NTPn0gcn4jakWB
         mUPSCeXkc4tRSwH1d21tWJOMSdgSVj5uwuvOwAiObjnsAgpGa7L6U7MOL6frvE12eVJc
         2SNvqrIYljfFoy2DaRSINf+9Y9ezYXRlpwMIj++vLaHtRz5VVCoWdCnVrmSeDmbfRv+Z
         LJajnGFqe/pbDWAwwmZxEKo+7/Tqhi+XoTZdyODKtXtvHM0LzlYduX6FBptpxrX2DrCf
         p8rcdh1wXyLfS6M31Tha67WxOJ2tQts93gxRk8R2EtSbKQx931PiDhabGL/4YNx6Ct1b
         TPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vt7d0zdFS4wZ28y+i4PGnON2eviCG47Hq3eyXnwFFws=;
        b=Wa5GC1LGHtutuZKotEMOHIoBnckphHSBQFWUGFJflUasPeeHvvyazv/hLAfc0yJE1M
         IOVM1z1zaHuM4JPUw5LS2zGI8OXQ9kX/NTHKNawnA1ucrixJWzbqFWy/51YsEifbGlse
         ThLZCR/gjxXG2xT59WZqoONq42moAsIUaexmy8WAdXOq666lUpHbTV48KNEm2EzTNJhV
         KKmEG7ShZPm39KW/X96bAJ/tyIunwatDYuBcywXs95HqKDdrQ7g+FT127Uu6g6JWQLYo
         n2JMCZun5xFX9ySo7FY+T4rJrTJRtoKq4oQ5YB81elHUfkSeBf4bw2m6cksaYR3LOH9B
         cP6A==
X-Gm-Message-State: AOAM531FmIvFvRq0RlIl+S8tCaiH17Hq1YJV8iBAwcItHRr2Pu95qyhy
        MFIpSzvCoxGAnGd30PuR/hnLxA==
X-Google-Smtp-Source: ABdhPJxSNhxjbf+KLYEj2mRsS4K+Wc9KgWAP+sEWzvxR61SgSq/b6pKhIYui09OfGLASncW52drQVw==
X-Received: by 2002:a0c:f54e:: with SMTP id p14mr9880419qvm.28.1601588329411;
        Thu, 01 Oct 2020 14:38:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z9sm8173706qta.95.2020.10.01.14.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:38:48 -0700 (PDT)
Subject: Re: [PATCH 5/9] btrfs: rework btrfs_calc_reclaim_metadata_size
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <bc6b0eeceacb2b444acf1ff74673471e2dfd2bb9.1601495426.git.josef@toxicpanda.com>
 <812450cb-e21f-83ac-27b3-803000d7b5d5@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bef58ac4-a591-440f-89d7-143449c73ffd@toxicpanda.com>
Date:   Thu, 1 Oct 2020 17:38:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <812450cb-e21f-83ac-27b3-803000d7b5d5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/1/20 9:59 AM, Nikolay Borisov wrote:
> 
> 
> On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
> <snip>
>>   
>> @@ -800,6 +777,7 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>>   					  u64 used)
>>   {
>>   	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
>> +	u64 to_reclaim, expected;
>>   
>>   	/* If we're just plain full then async reclaim just slows us down. */
>>   	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
>> @@ -812,7 +790,25 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>>   	if (space_info->reclaim_size)
>>   		return 0;
>>   
>> -	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
>> +	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
>> +	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
>> +				 BTRFS_RESERVE_FLUSH_ALL))
>> +		return 0;
>> +
>> +	used = btrfs_space_info_used(space_info, true);
>> +	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
>> +				 BTRFS_RESERVE_FLUSH_ALL))
>> +		expected = div_factor_fine(space_info->total_bytes, 95);
>> +	else
>> +		expected = div_factor_fine(space_info->total_bytes, 90);
> 
> I think this should be just:
> 
> expected = div_factor_fine(space_info->total_bytes, 90);
> 
> Because before this check we tried to overcommit between 1 and 16m
> (depending on the online CPU's) and we failed. So there is no reason to
> think that :
> 
> btrfs_can_overcommit(fs_info, space_info, SZ_1M, BTRFS_RESERVE_FLUSH_ALL)
> 
> would succeed. So you can simplify the logic by eliminating the 2nd
> check for btrfs_can_overcommit

I remove all this code in a later patch, I'm just moving it here to simplify 
btrfs_calc_reclaim_metadata_size, and then changing this logic later so the 
changes are discrete.

> 
>> +
>> +	if (used > expected)
>> +		to_reclaim = used - expected;
>> +	else
>> +		to_reclaim = 0;
>> +	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
>> +				     space_info->bytes_reserved);
>> +	if (!to_reclaim)
>>   		return 0;
>>   
>>   	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
>>
> 
> nit: Not directly related to your patch but since you are moving the
> code does it make sense to keep the fs_closing and STATE_REMOUNTING
> checks around?
> 

It does because we use this as the breaking condition for the preemptive flusher 
thread.  Thanks,

Josef
