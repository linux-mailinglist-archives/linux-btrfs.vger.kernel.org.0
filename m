Return-Path: <linux-btrfs+bounces-17204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA6BA2653
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 06:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF543A7F92
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 04:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC514233704;
	Fri, 26 Sep 2025 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KojDMZ9S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31569265CC9
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758861534; cv=none; b=f7HoydKtb5/AqFfb5NOdIjye4kwAqxVzJqf6sOJdAOZxWuMlewqNX+rBhvsyc43QulUoUKoqGXO+dCMG+VC7JLjTXmFCZG2uDHLC3p5TVaLJ13J/jUI+m/IFEuwCNAund3rRk4wFrhWTGeeV2ZF/+NpzM0mk89IDkUFBS+JICgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758861534; c=relaxed/simple;
	bh=PuyVknkXODCaw+d95cvSFd5kvdtynFsDyCbef2WMUZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ML67NqrsG76uIxHb5wQOaH6sj8K8dP3egIu2m517mObBvPTz/eur+Oo5vza9/Iv5wrc3KQtQy9iX0yRGrAiih82PGNhPB+Wb9U49E6HoRB7PUwK6Urk6q4JKEWqlMo9rRymmRIjxVQRFJg/BBeQUJ7E5NTwlcf3JuFTZENEJIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KojDMZ9S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e29d65728so11099775e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 21:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758861529; x=1759466329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xoMd+/sJEhvgRlM0By7/MiChlWNC97BNhED9LkmeIJw=;
        b=KojDMZ9Szl77xfjwSzy8zu4GDUVNYav6Yh5H/o0rOh4LD5weOusJ5tZrHDcVmtaWM8
         RSHlSWEacXuKj3FtjHEWK1PAzzKvIhkGYlnQy0JZDt8QughwL86BLqUJGIQhSbvW/Z4v
         3suSi/j0JzuptGCEQUWWO6VQeiFk8yA6zw/ZKnRW8KNq3q29xCAjhx09HfWyCF6nHyeV
         X7EXHgVX3WDaSjiM9bkA2V4vTZ22PfSJF4c23HWne8n3wK7iU2fWiaSl9xHM/BeT4/66
         Zcx/oDf+xgW76JIzHh91UchAGpHLok5RhnjBWnpntf1JQrU9EyvkWXhYsfXj247emRdz
         yOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758861529; x=1759466329;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoMd+/sJEhvgRlM0By7/MiChlWNC97BNhED9LkmeIJw=;
        b=J3iNxyt7sK/cSe7LGWLh+lyep/RGOSWwt6P2n/Kr8Gtu7gHKZglLsmL/6ZxGKYMbWS
         gPb1ADO2KDOyPECGQBvLcjixyLOO2tw62cloIeMyC8lDwaJOA7FI/dV6J19ehDYnylq0
         CWc7dk+wgPeSopIkALNh53pFa+J8vOh2iB8sxx54ae1zWCxRCrMGRWNO9y/CRGtstNwt
         uzoHnsIY5j0RuBKihVYNedwDKnx8TS7oSYCyprwnhUeTpglU6K7GyOpF9Nw0cudVlXW5
         OZUeDU3I0irMaRWKbRLc36S3e6si/mEcYNDXqOF8sOLhuC+J13B9NmSTPOPlVER9uO4M
         Bk7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmxDa0NMktLHnoClWc/B6Oh4WtgvoJeQY9gF0gkEl6Dvq9Hlxy5fGyopKEsHm/lmb74YyPRu6LRWgNFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlszp8mCCi6n0quEXQn05zHBar50MQLDnPWyaW16sxaakIbv6V
	Ax+FGTgAZTFpEvX4aC9iOEKoptoVHaLtgyo3jHsBoN4TLGVBjKDjbTglqLMlYYj7R6m6JJ1/rWu
	Afq49
X-Gm-Gg: ASbGncsnkdIDnA5UQv9k6s+YITC6BQg8y/tuBXAvdWWCz/gcCkkgnxyFL7EkHTrslNz
	debHA6l+YzHTHkDRW15pM9fz7O0kimievbRzuHbxoN7vTCCUtskYuGEfWSsg87ZDpYi5MNHN+JO
	YJXL6TLFKeMWwhE3svAkloEogc9YqqHnF7J3ylgkVeRnLCwkSfqrHNOtcT/WBkc+bWrAGWK4/Td
	aFrQsVXGVegDK1whGlv0b8dW5lZV8s2PeD5DAgymJzin1hw2WT6/rLcwxMNcgH+G35geZd4YCRF
	g6EK6YWeJANMbolIgALOetcYJ4X9TbEh1fjZjS+4HOUqfiMA15sALUxBcimmorIPfjd/rpUUKSy
	Z1KL6Q8/zeQaC0U1EVZcsiqwlKMRBvNk6vAsT/cqfWZv20X7zlcY=
X-Google-Smtp-Source: AGHT+IG08c0OsV6cjmUNezTef1spRV6uX3YxOHjrW5VZtWGgcqmObI6Ch+PSXYggcddS5gLPPsj3Qg==
X-Received: by 2002:a05:6000:2585:b0:3ee:15b4:174c with SMTP id ffacd0b85a97d-40e4486c164mr4793485f8f.3.1758861529348;
        Thu, 25 Sep 2025 21:38:49 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023e5f41sm3308690b3a.42.2025.09.25.21.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 21:38:48 -0700 (PDT)
Message-ID: <2914730e-e608-4a38-9ccf-9c908b4b277c@suse.com>
Date: Fri, 26 Sep 2025 14:08:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wrong SSD type detection on zoned device
To: HAN Yuwei <hrx@bupt.moe>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <C8FF75669DFFC3C5+5f93bf8a-80a0-48a6-81bf-4ec890abc99a@bupt.moe>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <C8FF75669DFFC3C5+5f93bf8a-80a0-48a6-81bf-4ec890abc99a@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/26 12:42, HAN Yuwei 写道:
> Hi,
> 
> I just found that when mounting zoned device, it will have "ssd" mount 
> option.
> 
> # cat /etc/fstab:
> [...]
> LABEL=DATA2     /data2  btrfs 
> rw,relatime,space_cache=v2,subvolid=5,subvol=/,nofail,nosuid,nodev      0 0
> 
> # mount
> [...]
> /dev/sdd on /data2 type btrfs 
> (rw,nosuid,nodev,relatime,ssd,space_cache=v2,subvolid=5,subvol=/)
> 
> # cat /sys/block/sdd/queue/rotational
> 1
> 
> Is this needed to be fixed?
> 
> 

Indeed it's a regression due to the changes in v6.17 that we delayed the 
device opening, so that set_devices_specific_options() is called without 
any device opened.

Thus it always set SSD because fs_devices->rotating is not set as we 
haven't yet opened any device.

Will sent out a fix for it.

Thanks,
Qu

