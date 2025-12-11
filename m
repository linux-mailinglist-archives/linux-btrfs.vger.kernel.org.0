Return-Path: <linux-btrfs+bounces-19648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B2CB5010
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C1B300B2A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8640C299AAB;
	Thu, 11 Dec 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYgGq/oa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FC22068F
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765438964; cv=none; b=XFmwIylFARpSKNAVbv5ItAj0Br5TDmFe+Fxc8eTlQclsxohMFzSuWiHc8UQNRzaJhxApHL7ftp2xAktWwvc2p1WAXZ1U57whV6tw0YB2Exmsqd3K9v82tM1hlBUXRVpCxxyeMCTEud2XFEZd5We7FrfXcoEwvPdrjK/IdOSLbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765438964; c=relaxed/simple;
	bh=rSTQ1hoheBeEV6oQTH83IFmTlqS2xryOjrpPYmEneqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ly0vAlPrL5rfiObGiE1ta+48AXSzOVFE9xdcBD3cOgrvASQRhpMCEH74xzOXG3W5W1KvvPwr/qW8AGtWW0s9Fg+CLwARRi8C1OhqAq0V08WTUPSMEEDfoHTzU+mmSgnm/RxdbVgLeVo+J869/vGr/NVIF+IRLJ9vTXUOdXDdM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYgGq/oa; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-349e7fd4536so50029a91.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 23:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765438963; x=1766043763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/TdrVpDQgzsbZe/RUyZrRJ2jXI1bB1U1u4iqQ1xzSE=;
        b=BYgGq/oamXKY/4Sktw2m4dPcQH63y2QKKRtBos0YXcNOGtkzyLlnfAgOpICQ93DKun
         YhX8LVfd6hsFVv99v0UoR5Gy+4+Bq7Xjc6uqM9ngDO4ebSoVAWX/BrpT/RjBD9KNOk83
         /bmVKyFpXGv6AqHrYAvmL62LCiNHt6cPiXXB1K0Lj/dhPvg41GrxloOacWSxnrAgTysA
         6hzg87b9SH7wJ5+zSZDIax02As48M/2+TW83aQ5yrZjeiEUJEGbCfStbbjvSxe71ocX7
         7hkBchn2n3WyHaNolmcWLaeeH8PgKUH7YlriHWEanC/Ne0pO8t/BJKe7IDRf//fKgz8C
         muBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765438963; x=1766043763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/TdrVpDQgzsbZe/RUyZrRJ2jXI1bB1U1u4iqQ1xzSE=;
        b=DEe7Aot7K3W/3xo4SxGHYUEW4EN+uTJ0OBYkH/dZHmGLljxieNVu0TnRxsWTV44ENQ
         lPKCrE5QLKSln5xACGOdWVj3Tvn3740Nv0L6JdRtsc+nCErEuyesrVoMGWNur+sP8Rs9
         ckqeXDTVsl3VPB0WghAhc3M3WoDIjeaZXFWIc4V4S+yv9fxbMV+t1Rp4kM+lbR9uY4/+
         ZJMxRoETYzkBSjufFymx7+abuTIdTU+bBoBoYNlpJoqIKBTNmMvEM/qABr2tEUrcNXJ0
         HaSzZjOwluVp7E0GvuE/sOtLwUgv8a02Ld5xJU98QNmGVhADLDmbMYIKfkXkdkZqe6fE
         EauQ==
X-Forwarded-Encrypted: i=1; AJvYcCU92l73ldcQ9upCQfI+ZhxP0Uz7BA1nNB/2Rm76hyeR/O4t+QDXzxYM9pS0JZDOUeCf1sYUrAcrMzYOTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfuYv1WyQPrTOYmQ6gV7d5QXXy01vfqeq7ZqYnO+o3WiCXpN7
	zdvDpUis3kmKFC2DZ0Czq6powvGa32hrHrmdlPy9XBVED4pC/Qa+9t7M
X-Gm-Gg: AY/fxX5B6kJqYus3Oghhrfb2mF+XvPDqKlG0EqvAxZZy6IOODvCg2hZok4Fyb7KkGt+
	69FYynDNR2kAbIt73iW+7RpYGG3yFMmImDFOEt4lcU04/s0XxzcsmlEVU7KO6SyJozl8x4JJL0N
	07E9rRXpdIGlQW3Zln5S4oD5Ccl4A/t3UeGY5z+zmuUhv6AqzimCJ0coKDEoFAcyqfoB2/81BTA
	wKm/hHBkxq1JgYVqawMH6gFbXx9pB299MDXsOFiicQDdWE2NGTPgJzqDLywct5HQkaguyUI0uth
	oGqJSMZezpgcZO6AJ1cfp6B6dMVpk1BFPJs+OIggNikIORgmSBLmLLZP2aCE5eZ59beTUZrV5Bj
	RfmrJDSbyAMQE2djGETDMxuKB17jSfYyojGvTm965Vv1uFULYDQdZnQF4IzYXNad02F88qQRgvp
	+BXZSEr7jdPiYjyw0AboEdUMe9ZPYYJSvpIdazthFob/3yLET1kFIC+2MFPVT5IA==
X-Google-Smtp-Source: AGHT+IHtCO0fNmCTJ6Pa2bC9LB/C/CW7OE/dtrXGanjyJMTISS3fCi8PQt+Ku2K2uGXlyGCw7UdGQQ==
X-Received: by 2002:a17:90b:4ac6:b0:340:aa74:c2a6 with SMTP id 98e67ed59e1d1-34a906f3d4bmr1274455a91.6.1765438962772;
        Wed, 10 Dec 2025 23:42:42 -0800 (PST)
Received: from [192.168.1.13] (59.106.191.164.v6.sakura.ne.jp. [2001:e42:102:1201:59:106:191:164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a9257aa56sm447958a91.0.2025.12.10.23.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 23:42:42 -0800 (PST)
Message-ID: <f774489e-7fc7-4d81-be5c-7c97971e7562@gmail.com>
Date: Thu, 11 Dec 2025 15:42:38 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: search for larger extent maps inside
 btrfs_do_readpage()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <7b5888df903f412b05831ea5302e586cf38c231f.1765434313.git.wqu@suse.com>
 <d8037cc1-ba03-4bab-8165-0b0d2fdff58f@gmail.com>
 <d18e6504-95e5-4a61-8000-f3a8526d25ec@gmx.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <d18e6504-95e5-4a61-8000-f3a8526d25ec@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/12/11 15:37, Qu Wenruo 写道:
> 
> 
> 在 2025/12/11 17:47, Sun Yangkai 写道:
>>
>>
> [...]
>>> So we're calling btrfs_get_extent() again and again, just for a
>>> different part of the same hole range [4K, 32K).
>>>
>>> [ENHANCEMENT]
>>> Make btrfs_do_readpage() to search for a larger extent map if readahead
>>> is involved.
>>>
>>> For btrfs_readahead() we have bio_ctrl::ractl set, and lock extents for
>>> the whole readahead range.
>>>
>>> If we find bio_ctrl::ractl is set, we can use that end range as extent
>>> map search end, this allows btrfs_get_extent() to return a much larger
>>> hole, thus reduce the need to call btrfs_get_extent() again and again.
>>
>> I like the idea to reduce unnecessary tree searches. After reading more context
>> about this, I wonder why we don't set the length of the hole as it is when
>> searching the extent? So no matter how long the hole is, we could just return
>> its range in one search.
> 
> https://lore.kernel.org/linux-btrfs/CAL3q7H5x+t_P=CoxcvmNLr8YKM-
> pUF3mAUiZBUkdRN3oN+273A@mail.gmail.com/

I've missed that. Thanks a lot.


