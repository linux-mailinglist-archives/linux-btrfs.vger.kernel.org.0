Return-Path: <linux-btrfs+bounces-15327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFB8AFCDB6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0DB18858A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE222127E;
	Tue,  8 Jul 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTX18UKt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8881749
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985179; cv=none; b=etMC70AWqlpevhPoPdcVfy+Bnj2Jvaybt7JiAw7B6otvTNu+GOBUw4jMOJi5iWB4M7EGJ2eT/DHSAuWRq+YJOnAaGhejasWhrO+BDSD9NRw9op9vlxOEevWjslLl4j0hQyabInxWZic3DrjqhHSoBZXsvNPhjTS0gPLkz02KRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985179; c=relaxed/simple;
	bh=KVticx/+MpCBM9+qNbwvNvE47tzy1ee8fynEm9PhwEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYYtlKR4IvA/wIEu6i8SEesMLQs4Zvt8atnSz8BsxsRW07u1G8utvKKyTPLz8j03pCHH18j6aUlQMhKMsDGIcDpYqlIvdGt6QDloyHA2Xpd7pcubt1j4zwZj2j3PiU7WqfwQqRLDL0CKPu2y3rOOUMUuvh5QhpRAlIlRLig0ulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTX18UKt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so26698775e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751985176; x=1752589976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATSURZVGIaKJpvj5EwOr02mJYdYAvyv9qvyCS4VnjH0=;
        b=LTX18UKtAqXB5GJ5nhP2XB817/yN1739SBO/mhDUE/yUNBjTCrjxTW3WVygWLJOqCI
         gDhlXgW1VryjWeWFOKHDkgGcTJ3OaA6fC+1VHJpTgPytgCWhYdcMoWMTdDF0mTXhiUUw
         GNFPMF1Yu/KIbjV+JSEeYnmB7MGtVnznHx2HI8vbNJTJrX3UBl7WYva5GHI1uGbtMj3q
         R1wG6v992M8131JVoRJvn9nM6GqcGVlXN0D+J915gzyiKRd3EgUYLgVPMK7wBE5SDfXT
         0JR8AbdRTzozNyIOQvG2Wp8PZlZRHGBIu0KYf+YCk2P7kHD2iTg64TBo0aCD1t67SqZv
         8S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985176; x=1752589976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATSURZVGIaKJpvj5EwOr02mJYdYAvyv9qvyCS4VnjH0=;
        b=e9JnV6LQEJudgvC/KyaHvbVrTkeTti/TKU8jjtbV75K8zYdYy2ZgHpi8gdUScvqr56
         Nbc59Frcb5Q/LWLbjPLwzpK26wy4FiGrtWCU3p5JnO1NH6Mr2vFxo+fXtCfdnj/4XsmG
         f8VrSqqILIH49sgHsId95SsthqslZDnyVEyJGneoF8ano/q+9FcQHrmtOHn31SWSsV0O
         5TgufKs5irTMMny3T/gRR4WT1FrQJ5y0UMuWDs0jn2Fkb5h+b/IFi0tiubvpxt4QhTeD
         zkm53vVEL17F0Xv5XgDVov4DYYyAwBE1rIY7zop1Qd6dHRGNNvaeNM5jXCc3t+2zh09F
         v3kw==
X-Gm-Message-State: AOJu0YzeH4KJE5rrbrIE71mOJX7ptFXx5nxnpzW3yPXHWgxAgJgKnp5+
	Ix+lbN27ynxZxRLTD7wYCAN6IA0ZDn50m88sFDpF7zpZxW7i1NZKX8kaJ8XNyEhEwMQ=
X-Gm-Gg: ASbGncsFoBm6x7SIT+B9RHHRJXptf1SHyL3FeR1o50ufnuIQnRMoo7aYFEqJ8XQlnWN
	PVMLYk+67eh02cLphztoYa3HI/o1KKAj+GAqsJn/InsAbLv7ZAZrrPkNAkJ5fxtRWVGebOcUQL2
	/EUa4PBLtg75xg1lWH36tpom84Cs6amiagdR0YSF1gYR1BduRwo+Sxkg8/Mpw4C8p58InSpfizH
	tQbZMVsiabN/d69Z0UzNp2vPaMIR68J1RM9YXeZHhBm3ots7THxM9TeUCernAmTJlsAC9anomrj
	HMiXwD2EMfQZklr4JaNF77ZKKGTuF08kiILwgFyaOyN+JOILf1DQzM0JTh3Ot9Pc1ljulrrkoCF
	EipQns0aOoVm1tYE0NNbVg8EkcrB8BufzozVLwyK2i9ADsTI=
X-Google-Smtp-Source: AGHT+IFGzl3lG1fpNkM0UCSome96qNyNLTi1NJFw2XDx9R4YoKmM3bggjDKJ1SVLU9Rn00CmUnbL2Q==
X-Received: by 2002:a05:6000:18a5:b0:3a5:2182:bce2 with SMTP id ffacd0b85a97d-3b4964c0a9fmr15969556f8f.17.1751985176225;
        Tue, 08 Jul 2025 07:32:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:a08:6480:3e01:6cde? ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd45957fsm23055335e9.17.2025.07.08.07.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:32:55 -0700 (PDT)
Message-ID: <43d86312-c109-4f22-9ea2-92725030f053@linaro.org>
Date: Tue, 8 Jul 2025 15:32:55 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: btrfs: Do not free multi when guaranteed to be NULL
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, WenRuo Qu <wqu@suse.com>,
 Tom Rini <trini@konsulko.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
 <8780edf7-e89e-424c-8770-2d45ab8849d4@wdc.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <8780edf7-e89e-424c-8770-2d45ab8849d4@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2025 15:16, Johannes Thumshirn wrote:
> On 08.07.25 13:35, Andrew Goodbody wrote:
>> multi is guaranteed to be NULL in the first two error exit paths so the
>> attempt to free it is not needed. Remove those calls.
>>
>> This issue found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>    fs/btrfs/volumes.c | 2 --
>>    1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 5726981b19c..71b0b55b9c6 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -972,12 +972,10 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
>>    again:
>>    	ce = search_cache_extent(&map_tree->cache_tree, logical);
>>    	if (!ce) {
>> -		kfree(multi);
>>    		*length = (u64)-1;
>>    		return -ENOENT;
>>    	}
>>    	if (ce->start > logical) {
>> -		kfree(multi);
>>    		*length = ce->start - logical;
>>    		return -ENOENT;
> 
> What tree are you working against? __btrfs_map_block() is "gone" since
> cd4efd210edf ("btrfs: rename __btrfs_map_block to btrfs_map_block")
> which is more than two years old.

master

https://source.denx.de/u-boot/u-boot/-/blob/master/fs/btrfs/volumes.c?ref_type=heads#L975

I am not seeing the commit you mention in master or -next.

Andrew

