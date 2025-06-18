Return-Path: <linux-btrfs+bounces-14761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E5ADE30E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 07:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C22E3BDC10
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 05:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE01FBE80;
	Wed, 18 Jun 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="csYI3t33"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F93A1DB
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750224585; cv=none; b=S/C7I+sB4usGd8VXv5r7IIaO9aCgUGntUu5crTyy6IwyeUd0ZKK+DNO2dOBYcHhw8ufUKGuZR6kFoLeN+DAZbHTAm01po7b2icbM/xGC25v3vRPsR/Ny/TeQyX7W0fTKqLynD8ylBdXa1TL+affXagXYl+D3MxmL3FXAHO0ESdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750224585; c=relaxed/simple;
	bh=0TUTR6hCqBL3PiJfKUWeb+mPO+qEj1nRUOwQ+Qsm2KA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ddXPBdZny/9oaR/9fJgat/gA8DhO4mSF4EKJz7UIyfCj1HZOU8ZSk8UJe9wli+mW9066WwwnbkqLmtCWk9A31GobyPwHB1mBBSWP1W5oiGUlaYUbpmoOX/MWyse0tX+JyA1+sO2C4evMqC31kXz6YTPvY8wxgVaAklBW9TOfwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=csYI3t33; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a54700a463so196813f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750224582; x=1750829382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3h9ooIFTbxNTKIyDusACjTGBSpWX2Geof5SV00Z+wPg=;
        b=csYI3t33vNL00rlw0f58ajfACZypmE2hBrhMECRCER5mo7YmGN8A31pqinkreTPTXd
         nLvS2QmqUj7cDP27sQsK5EI96BCi77uUkghw+M/qD4vdcCCfAE3gDD6xpcqAUJMVMrFl
         LX2gLpw0Mqh2+3jiOT60EZLz+FB89ZDWxCOhhyueQR8S9D0iEehclhKJ+vhimiqZtYIk
         iQ2b0LPWU1Qgs6chgqbzdL01AGu4sY1PD3NwzICPevmA8TPppHUyUEhT2Qnbik8ceSkv
         oHIvzZlVUIm5SxK5CCY6nM3CVGmUvdlwpb7fZZYy/TW/FntBQSXNoy/kwBlxwTyPMh5j
         cVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750224582; x=1750829382;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3h9ooIFTbxNTKIyDusACjTGBSpWX2Geof5SV00Z+wPg=;
        b=L9ae03pT00BkoQrHD580R05Teb1K+Kf5y1YFSByjop0KbAxSFVV1OAvS4f/rnOTULa
         CqvflcXxqxqb3yCZy+JIFqxc2T7WepROTPyZ83bRpkfIkbcIxOTN8Xsumgbyk20sL/e6
         9EUY607qA86fbHnLDOxPB/jNcDwzQ6fXa0YEPgrAFQr0847SIEuDn77Lt3vxNKsHdblf
         S7iQzSOoxEgljLVGzugVhs0AH2vCCVgV/QnNLiOJVsI84iWpDhqtfuUjeko+KTGRb+I8
         fCFbQ3cj62jQuFNNHgQdmu3ix2o4qcJk9fGTCzmDrO1nVyIeSKa2zn7AHBdT8U6YA88t
         HmIw==
X-Forwarded-Encrypted: i=1; AJvYcCV6IOPEEVeOAwy1io+LpvwAfpnKPGN8XGv3G0ZT03H7KewBp7ECZS80lkH+5byefCtqfJm72hRY4F9KjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCCu5Yj8Jzuk4OTBffiEThZPesrjqipuqr8l8sVYikgmSk5lxi
	81BGhV2nl5e+8DYW/EUO0A3mu8DCRK0VvI7QMwE31TZpIeuQPzG3S8odsIhtwVL9iQZ7QQ/sQ42
	e8z/V
X-Gm-Gg: ASbGncuw2Gusy2tPKhNU64ytto1zXu/0KJ8rIcbHrc4VtcedUT5khIdl/VQQC5ZpdV8
	V+mfi9T6GwY92JQ/IqOnE64Rx7syTqawQ48CeNdkkcnV8Jz0zJ0KwCnRMvdL+d1fCBz2tGRu2ou
	+SfEyioFXw7d02ZcNmjL4aQnyhL3VUihg8gm5EPjkDIx9XYmq1LQUipQf4RDqAi+mZsoQDIcSQM
	k6PTeAF0zbQf2syxaly8TUNhea5sAH4MrEbWdxtn5Cdhpr2CYS+7Y3BoElfFA7Q5TKMf3JsQAh7
	It3aJLlsbJjWBoaSDzNBdS8Aze7j1qpi2N2idCGatY2LzP8DfyGmNfbk+qgfL6sJcoHq+/K3qKK
	PeivvgYErV6p5ig==
X-Google-Smtp-Source: AGHT+IEdsd+7fNkHEtlNxAL7k8rsWjnVDoF8HRUCH+NsV0ZStsurQekzuU1PNn3AIL5ytvcfUdnS5g==
X-Received: by 2002:a5d:5f4c:0:b0:3a3:598f:5a97 with SMTP id ffacd0b85a97d-3a58e1458bfmr703921f8f.9.1750224581668;
        Tue, 17 Jun 2025 22:29:41 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb887csm90830985ad.192.2025.06.17.22.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 22:29:41 -0700 (PDT)
Message-ID: <f3d998db-6aba-443d-9f42-25e195052a61@suse.com>
Date: Wed, 18 Jun 2025 14:59:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck in CHANGING_BG_TREE state after interrupted btrfstune
 --convert-to-block-group-tree
From: Qu Wenruo <wqu@suse.com>
To: Tine Mezgec <tine.mezgec@gmail.com>, linux-btrfs@vger.kernel.org
References: <a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com>
 <d57e673e-f894-48cc-8b34-c3754fa23b70@suse.com>
 <e264b3d7-1242-4470-8a5c-805e29911390@gmail.com>
 <99814fd5-3f80-4d08-af7e-468f7c8885df@suse.com>
 <38c007e1-fd3f-4f5c-9f54-ad380d7071ad@gmail.com>
 <b673bc6a-296b-418c-b20f-9cab6345131e@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <b673bc6a-296b-418c-b20f-9cab6345131e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/13 19:31, Qu Wenruo 写道:
> 
> 
> 在 2025/6/13 19:01, Tine Mezgec 写道:
>> Hi Qu,
>>
>> Your patch did the trick, the conversion completed cleanly, the 
>> CHANGING_BG_TREE flag is gone, and the incompat BG_TREE bit is now 
>> set. Mounting the 11‑device volume takes ~5 seconds instead of several 
>> minutes, so everything is back to normal or even better than before.
>>
>> Thanks a lot for the quick diagnosis and the fix.
>>
>> One thought: the optimisation that skips the full extent‑tree scan 
>> clearly helps in the common case, but when it backfires the only 
>> recovery path is recompiling progs with a patch. Would it make sense 
>> to expose a --full-scan (or --no-fast-scan) switch in btrfstune so an 
>> interrupted conversion can be resumed with stock binaries?
> 
> No need for a new option, because it's definitely a bug, and a bug 
> should and will be hunt down.
> 
> The only problem is, I still didn't get a full chain on why the last 
> block group in the old tree is skipped.

The final update, the proper fix is sent here:
https://lore.kernel.org/linux-btrfs/cover.1750223785.git.wqu@suse.com/

The final fix is just a single one line fix, for a stupid uninitialized 
structure.

But I also added an optimization so that for resume case, the fs opening 
would benefit a lot from the block group tree.

Thank you for the report and all the help pinning down the problematic 
function.

Thanks,
Qu

> 
> The old code seems correct, but it isn't. I'll keep digging and send out 
> a proper fix later.
> 
> Thanks,
> Qu
> 
>>
>> Either way, I really appreciate the help.
>>
>> Best regards,
>> -Tine
> 
> 


