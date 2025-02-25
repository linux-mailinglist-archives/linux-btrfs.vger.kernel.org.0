Return-Path: <linux-btrfs+bounces-11821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB6A45101
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 00:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DF87AB1E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 23:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275D2397B9;
	Tue, 25 Feb 2025 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FX5VsRay"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE8231A41
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740527092; cv=none; b=N2kpc4MYz8TCFd9me53VRR4JeugT8opwPl2YmX2ZPLwHb9TdLPhNSmTNgIya7RMwzy/6nVP1Z2qOvxUwSF7phTNe+h5gzMbiB1AWGkxYHA9pT5jY4HIBgW7zVNSS2mnm9apYPp56yngIeJfCd6KToPT5qtvtDcj44KpObf4XsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740527092; c=relaxed/simple;
	bh=MRSRSfSsRAPyrt8/KaOd83SIsUq/3feNxSEIwJa2mKQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G8yCiwFr+/f5vBhnbRsXWvQFR1J7reUzmxazTjGBqeHj4OkC2RZ2QKqslKmqRLfMNyVUP5L7YI0Hy4pR4hU1XU1Q0yDVe6UuX8d2k2uQnjA59xFuwnqWlTVw4bUWpp9NU0dIvXXPgV60UFuv3YdlQ/4mlMQqRLBeNgjz31vuQGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FX5VsRay; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abba1b74586so903522066b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 15:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740527088; x=1741131888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pejq2J/7ybzi36+Va2cxBkxxKE0J8pmrvrya21/lbEY=;
        b=FX5VsRayuPzP7upVYPYRHuypUlKaj12kSL4QWexOmIgMJr3eU4VZsaC0iQjKIW6tN3
         bmR7IxCBfmfEdiP7ObrdgmEE7H/d4Z8HmCkVNXrLWiA4gNK8nZL2r/Yq5HidmI0McWqQ
         0JpWZ6xMFproXWb399p/ZwJcGa6HDyTmkWhVmFDqtEzElnp43iRw9+nGRmGv3rLlPwrs
         3ZWwEFTnbxN/YGu4r4VCkPsU+X/t2q2tTuOHe1Nk4U234vDZB6CPCcxPSAVtazKruqtE
         X8cSzu3aYx3kQse+6k49nHIsRqdErjk6m6KI2jlPJJ37sKScCqZxLOuH934TUSuFvzS6
         IzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740527088; x=1741131888;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pejq2J/7ybzi36+Va2cxBkxxKE0J8pmrvrya21/lbEY=;
        b=UWaePK3QXgsNN8QuwYB4P49vFiEg47NIZokIdacTPUKnF0Ja8ozUsiqBcKFf43fpWl
         aYGGLOk1DE2uKxsjllmP1srV9tzqwh6853FfF9M9FzONuJDdg6Ym5g2sd4W7KTDA/yLh
         6fovOVNhzLpzwm1Yi8hRkNGovzdtN1xmHBFTjwSb2U5ArhGodKBLi9AaCAAwoQp/Vbc7
         049eR/ZXKDJlCzIfl7YJankdCfwgFTnoDJrbUyPWWOvt54dSDnYlEJrqVx2CW0ZS+mKI
         XCDjguSjEd6Byg0N4d65RErEoya8vbYKR4p+IW40EJig1vpEUxN/FLhLLPyMAwsckqCC
         Q7Fw==
X-Gm-Message-State: AOJu0YzGnn7P0RNuPLn/uM/h+Z2oL78u8JbKcnZAeIb9NzNyCYltIZNJ
	XJ1aVhZyw1SkHpSJNSRjeSneXZ1OJZCYlAm1m13N2DG040FpmYuFskHTFMm5oehiUbwX0RLqkG4
	J
X-Gm-Gg: ASbGnctC6VJSRWK6vTtU9RZKbSvNNy/KLIeLgurOb0uUSGe4Nl2+NrGJfD26Eua7V7X
	odHHETBNjbLO7b6vDnXD1+atgWFHbhAmMFGK/3Cok3Oy6nwqydXmubf5Oj5hrBt9ZtwTCQEMTT/
	nyaVbBFcrUPbR5DPAVQUp4M+FiriQKfqXNMEElFsenFnZ9No9rk5q8ELOtFpeoWQ9OV3Kqlk7C1
	/IqfvtisIvOmgXwx1Cnx5o8cqHm6iPl5UEJk4VdUcgveNEdpv6m8UPQn3xa1/5iar2DUjmi+ZjB
	MyIwXxCf8fhW73h7vvtKYxxMkrVR3DbqvXYPnQO1RthI28m1EmDbRQ==
X-Google-Smtp-Source: AGHT+IE2G9Rc5Zpq7WIrPaXJZ3gK1vuoYOs5rRj3pgkvTNwSqhydBfrwog92/YgirujtmnXT/A9edw==
X-Received: by 2002:a17:906:6a1c:b0:abc:cbf:ff1e with SMTP id a640c23a62f3a-abed101dfe0mr466751166b.40.1740527088191;
        Tue, 25 Feb 2025 15:44:48 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a01fcacsm20096835ad.95.2025.02.25.15.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 15:44:47 -0800 (PST)
Message-ID: <40a0b543-6e43-446b-9720-1218859b1086@suse.com>
Date: Wed, 26 Feb 2025 10:14:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] btrfs: introduce a read path dedicated extent lock
 helper
From: Qu Wenruo <wqu@suse.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1740354271.git.wqu@suse.com>
 <f8b476f39691d46b592cf264914b3837f59dcd77.1740354271.git.wqu@suse.com>
 <CAL3q7H4BCqEtwSOykWqYxjgqqiPZKqQ9K_VjAt08Vs9CAcj7yQ@mail.gmail.com>
 <e8b84e01-a56d-427e-b188-6c2539a0093b@suse.com>
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
In-Reply-To: <e8b84e01-a56d-427e-b188-6c2539a0093b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/26 07:42, Qu Wenruo 写道:
> 
[...]
>>> +        *
>>> +        * Have to wait for the OE to finish, as it may contain the
>>> +        * to-be-inserted data checksum.
>>> +        * Without the data checksum inserted into csum tree, read
>>> +        * will just fail with missing csum.
>>
>> Well we don't need to wait if it's a NOCOW / NODATASUM write.
> 
> That is also a valid optimization, I can enhance the check to skip 
> NODATASUM OEs.

BTW, the enhancement will not be in this series.

As it will introduce extra skip cases, which may further makes things 
more complex.

I'll make it a dedicated patch in the future.
Currently there are quite some patches tested based on the behavior 
without NODATASUM skip.

Thanks,
Qu

> 
> Thanks a lot for reviewing the core mechanism of the patchset.
> 
> Thanks,
> Qu
> 
> 


