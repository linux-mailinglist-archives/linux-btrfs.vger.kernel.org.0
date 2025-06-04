Return-Path: <linux-btrfs+bounces-14465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F192ACE633
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 23:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0063A77DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3B5202961;
	Wed,  4 Jun 2025 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETr5U080"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC11FAC4D
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749073008; cv=none; b=lU8ExCMkYJuJEkSsxCkXwEG0xRz459x6UfPJzI5Eac/7jLIlrkFHW/11hLtMEmfuqXUiHiGp67Jn7mlgsRMwXZJtfvE2vNpeEOn+A5xiK38qhkqngjX23G9DAUo0OVMRC1osNgbKnWtOMpQsHkz5RpIOl4f3pUR8QlcdDRJQIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749073008; c=relaxed/simple;
	bh=w+EsebHWDwX9qXnb53CMVp5OmDT/lw1v2xdsrOI4kGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SpaTq7Yw9KljP5DrNED+QN1yaYooZpijJZUd/x6ukj/fFCJAVtREqalHU+MlpbK/BKI8V6DlzmmaYnIsCkn7TbYLAWFXgK8eVasLEHgittQsOt3+zUieI1vvn/25G/z1ryeFoJibJHYsQmELFmfkd1Osdi7/Mqvs0afHBoA2Yvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETr5U080; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so446899a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749072998; x=1749677798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T0ai4Vk+Pr2CFkChJO5T5nwc2vzR0EdQ/25VF+MLXxA=;
        b=ETr5U080TLaxB1h+lxHyHW8vwbNJO4qozzuN9oYMXlqc/fIphSP+ApUNiZ4fXFeJ4A
         IaoaWIOV7HJlueAznWRHi44OxXozP2gtNukCmDLjBoNzd6drSZivnqEGgSQfL0ynO4tk
         oktZGCqCrlFnSH+ezw76KaDkfLdnrNDTiven8Y4DLLMt9r9H+GTduORbkTRKdL9JPBOM
         evT8BGmm1YplknBw7QP2fgPJJ0c8x51zokemCdjJZ9iRHuhVp/UOe9mWD3QbkcrWhU+r
         ua/kcobXjJ4abbicL1FbHH2tXe7eBc8BaoE6SC2ECmujR9HIlrm/L6Ss78JFFctcM2BI
         1oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749072998; x=1749677798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0ai4Vk+Pr2CFkChJO5T5nwc2vzR0EdQ/25VF+MLXxA=;
        b=AWetmRGjk4wa/7nsdz9e5VsXW6wwNgGUVYDaEdrEkW7e71Brgqse1tDNX9IPe9C1K1
         8gPjKsKIWr2QamRYhLZKKzlYxuaqGyba/lar601tyRkXtlU5+RnbEZPTP6PW6rN2bX6a
         Nlu7su2vZxyl3DlQ7tnuwZlHg26b12MKEP5yUcUHgXPka+ZZ2Ru0sq7ufiuxYHb7oGal
         1X50TfmgBBB6d18zRHQUUqgNy+GtPBPNL4UToxbBGge22sitxAny8+gm0sHas4x+rkcZ
         /Eck49Fnh0Bnv4XNM9cdEBTdb+B0LooeYVZLUXmIWQWXaaalM/pyAgQuxGeRrOR/+qMU
         34xA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ujw8e/GXmqfx9icy2kLsKwOtX9xokAA6dsm4XXth5JQ3CRUJfWZgiBOww8Fvw11M2NsLlGRtrkAtTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8S0LncGKYqLXexoJyHT+O/jEJBnGOUpvVfUm4s+IyfZFJ/nV9
	fxLH1bsk+dTNy88MmRyTK8ntmYKKydBlAGHWRsKlLOnIQk8+55qNGeb8Vwv4hwyW
X-Gm-Gg: ASbGncu+re4GVUtJ7sKv+mzxSyEpOYj5d0z7wlIpPIjy9y/GW6d2ge0JjEXyXVAI4eO
	879hFSC+ZpcWA93JOOb5Gk0iylzPJzCv6RDlMw6XbPziRJe5EUcl9szk0cJAiXz4Wt3uU7GGSi1
	3BKweLCLzUbDGOwRSy7mjsOOwWDsmQHs/SasnTewbImrfoSaQSfKSFKWKcSl5/1V2hJmHykOuW6
	VjkRsAMCKGrX5Wg2FDwyOt0T6ZWQe/skC6UJ8k2jpxdkcOGUoffv1cUw4CIwpRTT5aw0WdHOixB
	0yVWEQdKXLlrpTSG68k5sV06v9mxjH2jWgMDRsk1RUd9uGgHjyaHWw8vGTJAXHzQtf38MiDqHK5
	bmF3N0JOBqGLw7cNNQYqvQTHCq5uat0jjIoyHOFNMNqesfko3UKiBtOx3LlnF7IEStx1NaXh8
X-Google-Smtp-Source: AGHT+IELz/fBg6EzCtXAW3E5i/zR64oubbrysQJ2oDwy4ZDycXo0dW+Cf4PfgLMALKJx2Df0T59ruA==
X-Received: by 2002:a17:907:6ea1:b0:ad8:8efe:3206 with SMTP id a640c23a62f3a-addf8f5879bmr388138266b.42.1749072998500;
        Wed, 04 Jun 2025 14:36:38 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:9386:40ea:f665:2d25? (2a02-a466-68ed-1-9386-40ea-f665-2d25.fixed6.kpn.net. [2a02:a466:68ed:1:9386:40ea:f665:2d25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5e2bf011sm1158127766b.105.2025.06.04.14.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 14:36:38 -0700 (PDT)
Message-ID: <3fea5116-8532-4076-a824-620dc4c5a627@gmail.com>
Date: Wed, 4 Jun 2025 23:36:37 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why does defragmenting break reflinks?
To: Qu Wenruo <wqu@suse.com>, =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa?=
 =?UTF-8?B?8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>,
 linux-btrfs@vger.kernel.org
References: <9d74d71f-b65d-4f06-adb3-18f7698edb8a@velocifyer.com>
 <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 30-05-2025 om 02:27 schreef Qu Wenruo:
> 
> 
> 在 2025/5/30 09:22, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 写道:
>> BTRFS-FILESYSTEM(8) says "defragmenting  with  Linux kernel versions < 
>> 3.9 or ≥ 3.14-rc2 as well as with Linux stable kernel versions ≥ 
>> 3.10.31, ≥ 3.12.12 or ≥ 3.13.4 will break up the reflinks of COW data 
>> (for example files copied with cp --reflink, snapshots or de- 
>> duplicated data)." Why does defragmenting not preserve reflinks and 
>> why was it removed?
>>
> 
> Defrag means to re-dirty the data, and write them back again, which will 
> cause COW.

That sounds like an implementation choice.

> And by nature this breaks reflinked data extents.

With a different implementation this would not by nature be the case.

Actually this makes defrag a very dangerous operation on disks with many 
snapshots (> 20). When you would defrag each snapshot suddenly your 5% 
full disk would be 100%.

