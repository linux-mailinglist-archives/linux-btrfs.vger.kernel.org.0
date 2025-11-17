Return-Path: <linux-btrfs+bounces-19067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA49C63620
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 11:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 072F1348DA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 09:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E65324B30;
	Mon, 17 Nov 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OP5d9/4e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381BF30C621
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373139; cv=none; b=F/8bo0gRK+YwtMqWXNpShqI5VOWCZZZIpy+UrU+ZNPRW47XEWQskFuAIz91xNElipVOS0NAPIOzJzQcTO+a3JD0NPTqQtKWciqAKVaIoCsHheDCYcQ6Ac4jfkFOMjG+UDxI8q2/6m8AIqz6/i5N76pqSpI1SffsTUc+Y9kFOJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373139; c=relaxed/simple;
	bh=jiC4FQelt/2q+sCYzCioaj9LrI1QY/bIZra3z5sdcGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEhD7LrRTDa1YZeNkhB3t7m2ZJoBrKkvCQvjx9H/Ok9Cer2Z0bolMokBX9m3tj+jILJcy4P8RfUJAUjOcch3aqNDh1wyt89hwItKMLaRciAM81kU2QADoIYTOLyVjRktS5fK3madfsvKgJhW95Tns4W1A+ox4xaxQuTmd7qeVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OP5d9/4e; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4774f41628bso26465935e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 01:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763373135; x=1763977935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sEaAB2fetXc8FGhmXLE0eVCHF/qxE8AoHbrt1zMJG90=;
        b=OP5d9/4e9G4Kgn6aWlFQHhNTBVJRLs7PON2PPs44oUQysiYAhpauPDY8j05tmQBX8V
         fLcH7+ETQzgrGXEWycRNehxyYBTYJjsJHZB5AXaph5+Rb8fvr+TdprRXwlNvFFI1wDmz
         HUqBSWpbFCLr1ssi8bTg2stC5L+nT8DBx4avSIabsmF/4l3LU1ZedVrEhmodWh3O7hyc
         d1JTSwhyg0wmchL9bRCq9BTUnviCNgSEXqpPAncr2HHO1F/jXl+sxZG/EedByQAecQ37
         meLLLmFIgyhS0qdJ549E9SAdAm4BJoaC50h85Ub0Manr8XHyLRcj/i6zZHSy74cRwYAL
         VdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373135; x=1763977935;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEaAB2fetXc8FGhmXLE0eVCHF/qxE8AoHbrt1zMJG90=;
        b=p9BLbqjIcnSzbyQQePOIe+vU0WkLeaD2URjZ9x6NkKzT86q9ZiABAS0h5GiWOEV+1S
         f+J72k2E06kDAKkkSFGvK6w4ujivzuS+JyAsNHB28C08kI+9r6WUV7bU9iQejGU0XN6Q
         qMQo3hhpn8TefrxEyOifCijQPS0JLExeSRsVYBdRclRmES2sijWu2Lj13JnD2r2pa5H3
         WTabMxvet7aUGw6aPrD7Nv/b4zWRlxq+VhClmUWtz1PUm3LhaJHN9sBcWgIZ67FNSNUd
         L1Fnbq/VUdFclQDzRoDm+BI1t3leZ7GtYLDUI8Bq9fKBbU+TP+v2uhtrMWNOqjDxOttS
         oODg==
X-Forwarded-Encrypted: i=1; AJvYcCVWeCFWZJqo1zaYqbIoBmR/SDfGnj4E3ZW+H9J25DWfBJSlghdW6ZrL1iYPEXzXwaRqjtc4H3lFGNp8zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjkphQhn/ZT3s0MrdnMKYeAkX04YqBm5A4h9j3WEpTQrBEVPe
	Q6pXGiizC6xxaDw1nMXVXj4R5UypkvNhjH/0DW8kLnA2FRrFY1c0njByMqFCo+ETDkM+bpYTnQI
	5rH7W
X-Gm-Gg: ASbGncs4ZEDD+j5QeKQzE+FX9MRI1knIsXIrCfenRk0jgIvOYYJvjBKhUOewp82JfvS
	YFiqIxP2CnxFfRWN2SlYwPWOOyLDmJbnKza0eRM5sOEznRt3geBPEzYLYZOx8eO9xNLn03HyLSh
	oOZRSsanQSlz9Ked5SIoQv6GFsUr5nY1Z127sJNOUvREOklUuq0zCThCWfYLT/YkI4LpLxbX217
	OY+R30SOWpRPdPqDdF7Tst1o4GtzsqfHbtJ6WDtEzmNaOyfA/XDjs58r3MNwYvQcLREgy03753G
	jFDJsBCkg6OX44E8+TSutI8A9NOjJLDYPQ3pG9KdE4miSOiSUmtNJOzIrIUSojAZm6F+VRz9Rx3
	4MCFLIU5wF4hM3MRnQ+wcwH7rd6TwOrGoFlrvf9bYceL/m8jg9foJ4Cblw6a1f279JIgcfDekRV
	AC1ddWK2IDjYUHkZrGDpmrE5W749ZMjVOjePIpvKU=
X-Google-Smtp-Source: AGHT+IEo92Md++KeUEbmlDKzZdYcSKXBjzAJ+vanZF6SnAXEWw8BMYwkq+8CXTedPCKcwu3Mm1NO7A==
X-Received: by 2002:a05:600c:1819:b0:475:de06:dbaf with SMTP id 5b1f17b1804b1-4778bd1474amr97273875e9.17.1763373134950;
        Mon, 17 Nov 2025 01:52:14 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986e5ef31esm97975655ad.35.2025.11.17.01.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 01:52:14 -0800 (PST)
Message-ID: <7a15f000-4a11-4ea5-ba74-a311077439cc@suse.com>
Date: Mon, 17 Nov 2025 20:22:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix racy bitfield write in
 btrfs_clear_space_info_full()
To: Sam James <sam@gentoo.org>
Cc: boris@bur.io, kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <87zf8lxa44.fsf@gentoo.org>
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
In-Reply-To: <87zf8lxa44.fsf@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/17 20:18, Sam James 写道:
> Has this one been taken into a tree yet? We've been "backporting" it for
> a while now.

It's already in our for-next tree, which will be pushed upstream in 
v6.19 release.

Thanks,
Qu

