Return-Path: <linux-btrfs+bounces-21164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOeiIPXZeWlI0AEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21164-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 10:42:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D336D9EF27
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 10:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 501F2302F71E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032F634A76E;
	Wed, 28 Jan 2026 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DRg1Wbdi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7D33DEF7
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593110; cv=none; b=KGowEd7WrCVc0Tn0q8jyt3c0Gj9PxxYI3hcEYU/jyhvNFjFJlQFh45YOBfRv9XDyJ9MTMRi0WpMhvig8osfIdImmWh0jxmV+vejemSeBeu38Wsf6xw1i6V0E8Wpi0DzRz6im7H+ZxcLpoK5x/XqJe2xK/H8irWQUPh6hnikJU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593110; c=relaxed/simple;
	bh=pA6nIf/94Wqspi4PI0wcmfNLmd1MbjPd/RjO6I3SKaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONXf62A5iRbiTxLzYnHBKR+4AMG7A8XzDEoDcZfQUqe014D+wgBYUA/6Az1nK/NawcvYVAbtcRSujC/fn2q/LqYW3j5sEKGe4hrf66Iax8K4piHjANRZctCMY4vy7wBnQayTsABsPZ5PKIGIwOoBpZBLCoNSXiRdyGLtbeME7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DRg1Wbdi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so49790225e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 01:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769593105; x=1770197905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=epzAuMZpqj+EBt5suFXWHzHJ6BhtPZKV4VKXcZqdj7g=;
        b=DRg1Wbdi5llEKl9TCj8U3DBqB9tnydenTgtlMvGujUDmqQuwe906q3mn6nJayy5uzV
         SIvczS8IX5oW3hxEdflY2w6w9WaMq7HROjlyJtnm8sOvYhvUerzWJCaGadsvzK4v+Ct1
         9pvJ/7+8Ks54qEjC40hXq37WpyKY7XwDnBUk+r7iD+ccCcvlaMZ6aUZc7ryG93FYJc21
         umkBkpcyfAAq716/+ksn9SSV2dIjEIyeX+T7/9nf/z/oIPwCDVYhQwR497H4FtpMZflX
         6smUc2ONOdzMsQDtrZM83Yn5vU2+e+LRqEZs6dv0qvsiSVU0Iy5+bofa9fqFvQWxfpGJ
         szcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769593105; x=1770197905;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epzAuMZpqj+EBt5suFXWHzHJ6BhtPZKV4VKXcZqdj7g=;
        b=TvucICQlEOfSLgciElZTuKwrtym4sS0wHJSV7yvyMJXiMCbV2+eh2KiTnLSf5h1cG0
         +9laVdCAUML5WiAU8Ol6DBUTSaZDnz+AQ01lxDDDqxE72pPbwBQ/+exKwmTP6SsJN4ru
         FnRwS0q3enkZNEgwGY7ES6h0S63O+iJ4tQ23BsATGxK00nKiEifLgzkJPQtSZeghNKBJ
         kVpTDcwg16YCAABOVWy8vHLcIEMQiJoHB3fBB63/sp0lxh1iBSJJTctHQyymNHthajb5
         DUM4bK4BkY8D4tbgeMkzuH4rxESAxrs6rl6lhnCIgHiQtD4UFa1Dq25OEFwa4tzHPBQx
         uWRw==
X-Forwarded-Encrypted: i=1; AJvYcCUlRVuueb64Yn5+2liaU1zZba3w+i9at1sLKkq4rbIZ/6zBsBufiHGk/wOfIlYLObp7Cb9OD1C9DCapJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrlMC0ed7sLTcdUMvtZi1nZHTGfg/YVGOjmAAOeVlrTellB+f
	nf5MsYImYcqxy+Mk+JTVjCF4MUL2Ujb8FhYKDBpwWWfqWFuUVFx8HWCZmt+R8g4wPdk=
X-Gm-Gg: AZuq6aJbwd+u0ADZ8DVUXoisaEGNw+taXM46YANM2uMffI5iX1CxB7EEF1dOfONgy1c
	MHRtrN6K+BJ7DWOtPonB4J1BW8CSH1A9On4rHZ9F1kuInweX1UF47f46inXb/yH0frlxjLac2Ea
	Klpk1HrZV6y5xZvVYMip4p/p+A/zWg1XMAvtWraIitFYMd3SR7TrwhUsV3plXJMtupyW5iIaAEG
	B5yOs5FxZx73Qp+i3cSly95K1IIeapvD15WqcvX3Bf2Eguj1PXQT+pvqpSMH+ih/hxawCRU94A8
	JmkbMAxWqG2tJfSnTTe8O448jO/pNMMkmVHx7cS6Wrk75TGfhZtrDqfpuivnRLcxrmil1i14QXn
	oOHko03IN7iiCEI289fNOlCFz5iJtbHg5z2wP6gfAA8ATsF96FACMDm8jGCYW8ZcZmiLJ3GKHJq
	qwJYpqBNYsiMtSyvvKAbs99Q0wmy4yA6c6Z7QPMCI=
X-Received: by 2002:a05:600c:4f95:b0:477:af8d:203a with SMTP id 5b1f17b1804b1-48069c66b3bmr54303525e9.27.1769593105155;
        Wed, 28 Jan 2026 01:38:25 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c24083sm2012029b3a.55.2026.01.28.01.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 01:38:24 -0800 (PST)
Message-ID: <5596aa91-aec1-4ea4-b500-b26060c91b57@suse.com>
Date: Wed, 28 Jan 2026 20:07:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] btrfs: handle user interrupt properly in
 btrfs_trim_fs
To: jinbaohong <jinbaohong@synology.com>
Cc: dsterba@suse.com, fdmanana@kernel.org, linux-btrfs@vger.kernel.org,
 robbieko@synology.com
References: <eec6b47d-2b0a-4196-807a-b05f4a983e47@suse.com>
 <20260128092132.848164-1-jinbaohong@synology.com>
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
In-Reply-To: <20260128092132.848164-1-jinbaohong@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21164-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D336D9EF27
X-Rspamd-Action: no action



在 2026/1/28 19:51, jinbaohong 写道:
> Hi Qu,
> 
> Thanks for the review.
> 
>> If your idea is to exit without counting it as an error, it's better to
>> put the early return before the error message, or it will still acts
>> like an error.
> 
> If some block groups or devices failed before the user interrupted, I
> think we should still report those failures to the user. The warning
> message tells the user what actually went wrong before they interrupted,
> which could be useful information.
> 
> So the current placement is intentional: report any real errors that
> occurred, then return the interrupt code.
> 
> What do you think?

OK, then it looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Thanks,
> Jinbao
> 
> 
> Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.


