Return-Path: <linux-btrfs+bounces-13446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEA3A9DD2F
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 23:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D7B466C63
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF34B1F3BAC;
	Sat, 26 Apr 2025 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5Pyct0Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71541C71
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745701321; cv=none; b=cUFWE4IjkscVEj9ysdzCoeee6sHgTO7rJt1H7qacUxRfr2zHK6pC+ZcLrgsc5Gv2/Wt0J+nMbThrqXkkXxF8QsJctNWOhNE+6Ij+tMG/QuN564iDZXzcDMNcUtpTyL2bSM/37naw3WLKXbHlQ4JGEinrNtY3bppGfYXp+nVsbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745701321; c=relaxed/simple;
	bh=CN3+kDXnvm6OVn8Gqh83NFae9GAS4F6ljPiFL7THxJ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=s2EI2pu+lIPdR3oBuNmwoLuxnfRRSDPytP4mBcFMYwN0beUoXUfWU+Wj9SEP6kTtSvPDkQJ1n3sjo7zW/i/CN7B6qa/EKA2PX1jHQrldLjtMIfmWOXnwXTmNVTMX/WfW0MwMSggdve4bTSBkeh6SpMligo99JzJIK25JqLM+ZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5Pyct0Y; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac25520a289so538257766b.3
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745701318; x=1746306118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiahmivXlgWjfRyY4Jn744umLEv24swB02MUYntFkNM=;
        b=f5Pyct0YdFFqMF3ORAjPzr/Nyac8Kxu0RD+zYvbIf5xgYp5yPnpgdEt/eRMoYMaqWn
         1lannVKyws0yzW+ONiFP//cmmiAS+hqY0bkD7q5o6Tfd96zcIOE6SIWbXAjx+u10SHrq
         F9BCZNL1/F52V714fOpGZbpXFrcmUTPxBQ51wrfDTE3I61/UhaU6ePVEnzz7tKDB8ZBc
         1LRnskSKMFiCB/jJllc/tJnmhsRfEUNXKW38lt8t6vWAodkHUCWlOKUzjiO+O07M9uun
         SUzLKVv/FK6swyBYvHro+RHORDbyOBsHFS5zGkqkaafO4ms+OLuYtd0qigYryDo6NcyX
         ua/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745701318; x=1746306118;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiahmivXlgWjfRyY4Jn744umLEv24swB02MUYntFkNM=;
        b=XhoPHOqQp6a+mNKVrL4c0krBi5FyzVQVEflJ647S9zSgRBLfnQaPh7BVWoWqvb31TB
         4a8tpniCp0stN7oq2+E2KDJmpQdyNg3vXBdqGKGyk5AOWSZvwCb4sDuwFbMFSU8mNX++
         vsOieKIJ515ZwHt/XV5tiR8ma4RD3j9zSWtKJHKzm1wsDYvDBe5j1QYfC5cd0FhYvofq
         CxzmS88ulckh7JGM9f4mhrVPfMFniUxm16AoH6SDYQj++ACmxKO5eE4URooMqgzJLOxY
         BqceFIFFwT8N08WVkHv7F6lDFFlp341nvrz8jDbYMIu9NKolICuxLCJla3PUoTOjZRiy
         Bfew==
X-Forwarded-Encrypted: i=1; AJvYcCU4PAQL7aJxlYBsMQCNcBe7Hu1uJfVr4JwDz/Y9G8YG6FgO07ncPoIDzFlTe2o/1f17vhgLv8x9HduRQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+gW3vGZ6YIirv34BmWhfYE14u3xWHtYN0augtYSbVU0H3G+K
	tv8TqV8xHyS4eEmGl618wxKOkM9xZ6x/sLHydK4idZfbogTHzF6x
X-Gm-Gg: ASbGncsp3ipPidkYAiVfSrMn+1mV5nhMlHg5y9OvV71gEZl1f/IHqP+cI2+A/EU48nV
	Miw6HjVLZBceoQEMgaMzaf7voL3RmMQ0EfLHj1y5j2357hWCitLbwRVdhDW+Seu6ul+zCfaWjID
	27ZGpe9a89e02Fd4JKUYWJ8C3BVgGVV5Or+HXJgK6uWuORwk4aOM4vzuOid+k3/n+bkdrr5x9Fv
	u925Xn3oZdxa0QQOHq0r1y0TR53HQxix5S4jdnhpDNqixhLfHkog/Hx6s2Ql5zlOocycmW9IOed
	nbToyk0F/H4nuDk/AC9cDqicP5Np2KsH5yZ2caXcTSejGnQXy1YkST0Peq6uxD6McqGaeiD1iom
	8WJrJpV97L3fS7uE/qRpTOF9KpTVdAJfcl1dEJEI8iiOCIOy+G8mNS0syxQ==
X-Google-Smtp-Source: AGHT+IGvW4QpXvXZZLSZsfYQwoJCFMqfe5tbeadH9NiXhidjGKtAQ46AWMRwfDGkpsmC2LQ6Ch5OWw==
X-Received: by 2002:a17:906:5952:b0:ace:7be1:1434 with SMTP id a640c23a62f3a-ace7be11c82mr370539566b.30.1745701317624;
        Sat, 26 Apr 2025 14:01:57 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:b4b9:d84:88d0:f6eb? (2a02-a466-68ed-1-b4b9-d84-88d0-f6eb.fixed6.kpn.net. [2a02:a466:68ed:1:b4b9:d84:88d0:f6eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e6f2csm339815666b.45.2025.04.26.14.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 14:01:57 -0700 (PDT)
Message-ID: <90a4c852-cfb1-4f24-b30e-0562afbd8937@gmail.com>
Date: Sat, 26 Apr 2025 23:01:56 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors on newly created file system
From: Ferry Toth <fntoth@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>
References: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <2366963.X513TT2pbd@ferry-quad>
 <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
 <3309589.KRxA6XjA2N@ferry-quad>
 <d98ffb69-195b-4c07-ac56-8ae1f811af32@gmail.com>
 <f32bd559-71c7-4d45-9af4-47a913eca63d@gmx.com>
 <a0c57ce5-84f0-4534-9d34-d2bd0d305882@gmail.com>
Content-Language: en-US
In-Reply-To: <a0c57ce5-84f0-4534-9d34-d2bd0d305882@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Op 24-04-2025 om 23:16 schreef Ferry Toth:
> Op 24-04-2025 om 22:49 schreef Qu Wenruo:
>>
>>
>> 在 2025/4/25 05:41, Ferry Toth 写道:
>>> Hi
>>>
>> [...]
>>>>
>>>>
>>>> Except with newer mkfs.btrfs (I tested using 6.13) the files are 
>>>> owned by the unprivileged user.
>>>>
>>>>
>>>> The result is, the image will not boot correctly.
>>>>
>>>>
>>> I found more about this issue here
>>>
>>> https://lore.kernel.org/yocto/ 
>>> tRtu.1740682678597454399.5171@lists.yoctoproject.org/T/ 
>>> #m5de0afa17d2c0f640e86ffe67e0d74aea467fd5b
>>>
>> Thanks for the report.
>>
>> Just want to be sure, with pseudo emulating root environment, how does 
>> it handle the file uid/gid?
>>
>> Mkfs.btrfs uses the uid/gid reported from stat() system calls, thus if 
>> pseudo doesn't change uid/gid reported from stat(), mkfs.btrfs will 
>> just follow the result.
> 
> The change in mkfs.btrfs is reportedly:
> "The important change is that previously mkfs.btrfs was
> using lstat syscall to get file stats, but then it switched to nftw libc
> function to do the same. Pseudo[3] however doesn't support this call -
> it "knows" that it exists (at least nftw64), but there seems to be no
> implementation."
> 
> So, as I understand, pseudo would hook into stats call, lookup in 
> database and change uid/gid accordingly. But now there is only a stub.
> 
> Right now I am trying a patch for pseudo that implements nftw64. It 
> triggers a rebuild for half my image, so that will takes another hour or 
> so. I'll let you know how that goes.
> 
> This particular problem does seem to be more pseudo related.

Yes, the patch for pseudo is working. So, this is not a mkfs.btrfs bug.

Thanks for your support!

>> I guess it's possible for us to implement an idmap-like solution, but 
>> I'd like to know how pseudo works first.
>>
>> Thanks,
>> Qu
> 


