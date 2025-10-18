Return-Path: <linux-btrfs+bounces-17993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF7FBEC90B
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 414A94E2E48
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A769285C98;
	Sat, 18 Oct 2025 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cwWbZroz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4371E492A
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760771692; cv=none; b=s5wh1Dn7jOwx6G9jCHPd3zHuH5DueZid1u6Nxqle+2zrsOKRHH8oB9l8cPodC1OI6k29Tj7u7Rmal+o4OLdhBk6XIGqTg/53vn1hbEia08k9HzsOxvj8WAqYKzcnBwOhmdoPzIOs+TiC9z/ijAQVyoFfG+cpTIEKx0Z72Uolqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760771692; c=relaxed/simple;
	bh=Uv43NfxsjELEUOhC5ZP/Vzwa/AELWJXqB6vt/n2Ib6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gk1g0c0BEUxvDBrc0OjlCrdN0DUZKTbimUMqhgaY+Bf3toL7US+DxOpmFg4dZBi3ZPhdY+WxkOsNwgb7RpCLvu8fYRHKFBmt3uq3p+hDbQ5OCU7/bt8xBEIkAovRJ/Nlyl2NNxV4NHaYq/IVQkmMQU6g7nasctPUiDpxfElu3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cwWbZroz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-427091cd4fdso744642f8f.1
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 00:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760771688; x=1761376488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ+Q+7QzZkIznVW7J9G8VUcwxw7cwtloUtcrlyPtiAs=;
        b=cwWbZroz1e3z7q8EkcdtYNRds4MMnjLNbDHsGyZOr3BbQtWyITIh/9RAMU/xWnqaY5
         RnVAsoEX1+r7Xma/+A5iB8yhhe8U3Dab6ekRWrFlAlzBZpKSiBil/rnxF6CaATKab1dr
         JGy3AAOqO+7nHIBaXPLMVWvIoFU0KZN0DsVEepaFaBZ5SeP8mF8IKBvv/E0MA4JeSUBY
         hulm+Sb85QsO++thXCMf+RljfizmJZg5cTpg77Wzu8o5alCYm7rmmqLQr1DRqES/jhWY
         /0/aJCSxJKkJkhJ63pFH0DeV2Yl9fWr0uDu0qrtWL0InqBcDuPebNg8sqGfrzn5s9KZz
         GjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760771688; x=1761376488;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ+Q+7QzZkIznVW7J9G8VUcwxw7cwtloUtcrlyPtiAs=;
        b=tMqgOdLRo4BUluvFr/2XWdNMitXytAnnoQ8IMBmYklwX5pPXMjgXsR7dsMEB9gNOLe
         KwFt9h32Hvn/xlPloKLC1IbNvb2NlClUZWzTDseDKcQDjvL03WaLbXSLX4d6GYmW+sjo
         53m1GG88xr3kuhIHNY8pxEg3Rwh/DZLOZKrccGCON+byweAZe0/I/xlaVAmczquivjk9
         nQrhANFix/Ron9hbHilR76Ncl+BV0a+jR/1tPLX634NAWFRrim16x4ZhVlgKmxSMN7hr
         85xKUJGYdA9okdaRu2ud3ZjQ2YPrtF3i6dKBhSKB2VC5htpYJhZwfO5TvLZN5RJNFQpV
         6hwA==
X-Gm-Message-State: AOJu0YzP4mifLl9QwFq+RYEKmrn/1fqpFAVaBIrjvg66MQSFFpe+AwWX
	xUiL01hHT50KqASnCjG3eJ8Id+ZKbUeCmRfbP4tvemMRlIktx4RuBVfj1HzLVeh8uuar50Y0NZa
	VJg1k
X-Gm-Gg: ASbGncttv7i67llNUyttPiAvVWoaTlcaJfbKh87EIh5+upZHcdisw210XBmKS9egDVo
	ukNMpHX2aV2TNjl2IrdM/9NXy5EBy7w9xDrjK0zpmqHuncCu0SITJcCdFc29HJVd0r7UnmZca+W
	ziFloujeE0IGTIk87HECFOlzVivnLxWy0d9Va6vFJLy0vHruszpCQcw24l/IRD9FbHHro9dA/mi
	JjKJLlxnFiGTeGqEauTBkthJLQ7Ig8d5nBsMyFAZ7RSwDpnmhIjms0hlLBNPvx5NDDmf/nubyhc
	uPe29qdI8ca6jNzcIWkvIpPzAC3hFuBPTF1KCEgEZ5V7ERE4jTlPTtlu3UU4mWXeqYTp9RY/ODW
	poXz13oL9a5HXXtIFFLA1vdktT3tNDvUQVDaa0WOLCBK6yLTBDM3188fC7maOcQ/Q2uBNnSVSrb
	2/V8Hv4SGE5JiuOvUmsINnOA76wfZvhezSMP51C9A=
X-Google-Smtp-Source: AGHT+IFeZT0xTC/LlVPb+X/G5LUiAEsrK6EQURhHhqoHu8c7lFB0fHgYNuQzPo6HQ5YdGJn6n9cYrw==
X-Received: by 2002:a5d:5d08:0:b0:427:a34:648c with SMTP id ffacd0b85a97d-4270a34652cmr2227305f8f.58.1760771688206;
        Sat, 18 Oct 2025 00:14:48 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230109a03sm1809440b3a.51.2025.10.18.00.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 00:14:47 -0700 (PDT)
Message-ID: <6e45f5e9-f056-4bc4-984a-2886c3bdc5e7@suse.com>
Date: Sat, 18 Oct 2025 17:44:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] btrfs: scrub: enhance freezing and signal handling
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1760607566.git.wqu@suse.com>
 <20251018041654.1144286-1-safinaskar@gmail.com>
 <edfa6dd0-5cd5-4763-8be5-ffbd855a0ee3@suse.com>
 <CAPnZJGC3UVQJ=3qMhSY8-K+gwSx9bXsjgCgfbFNjenPUM6Dnyg@mail.gmail.com>
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
In-Reply-To: <CAPnZJGC3UVQJ=3qMhSY8-K+gwSx9bXsjgCgfbFNjenPUM6Dnyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/18 17:13, Askar Safin 写道:
> On Sat, Oct 18, 2025 at 7:26 AM Qu Wenruo <wqu@suse.com> wrote:
>> Unfortunately it's not a fix, but a behavior change.
>> Previously we put priority beyond pm, but not anymore.
>>
>> So no backport to stable.
> 
> I absolutely disagree. This is actual fix for actual bug.
> Many distros use btrfs for root filesystem by default, so
> this bug impacts a lot of users.
> 
> I will wait till this fix will reach mainline. Then I will directly
> ask Greg KH to port
> the fix to stable.

Sure go ahead and check who Greg trust more.

Let me be clear, it will affect existing users, especially for 
dev-replace cases.

If a user expects the dev-replace to finish no matter pm is involved or 
not, and now pm disrupted canceled it, it's a behavior change or even 
regression.

This will need quite some changes, not only to the docs, but even some 
new btrfs-progs options (e.g. --inhibit to inhibit the pm operations).

I appreciate your help so far on testing, but I'm afraid you're not the 
one making the final call, not even me.

Thanks,
Qu
> 
> Note this comment
> https://github.com/systemd/systemd/issues/33626#issuecomment-2323415732
> :
>> Failing suspend may not just end up in data loss but also in permanent hardware damage.
>> If you close the lid of a laptop and store it in a bag expecting the laptop to suspend and
>> the laptop does not, in a short time it will reach crazy temperatures in that bag,
>> that can permanently damage the screen
> 
> (That comment was not about this btrfs bug, but it still applies.)
> 


