Return-Path: <linux-btrfs+bounces-18965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623CC5A428
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 23:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798873BD7E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 21:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D7B324B36;
	Thu, 13 Nov 2025 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T8UKIxxa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3331D725
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070998; cv=none; b=Cpo5iKud31IrVXSDgeWmDXDiotdDGDVJuB/RTLxS4KsmoCv2tIrrJDyHKKixUJ5MifJtITkWZedpbPc2SFSzWlDMTCLtKGfyiBuoR1SddW6T0BdFX/p+1lNTlKCj5VkzyLUv9sglxl96HmsSYH1EC+Pgpnc0Ki5KWh2UgkE9lwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070998; c=relaxed/simple;
	bh=PTyhTTPCaQ0teEwhz3DsKC/7a0r4//cMCE8FArL7S8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aS/HS+L9WqV6hjI1Y1gIIkgy3wDr1RWMNfYaRTx6glvywbHKoX3gZrJEUsC9BRi3SQUnc3pTK8Fcitd35GqQBo2cHMaHIE/Z8oApCvAXxfSxgv9XkY3sF3E9dLkYuwZeBrMLXVNZlgTpdAr4PYLsNgy4JjyHgmbbGijgC61+p8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T8UKIxxa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4710022571cso12910315e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 13:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763070994; x=1763675794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jRvKmmKDBmadpAMzc7ydS2dOo2T0G6HxfPJcXHxvRLA=;
        b=T8UKIxxaJ3UIV8KyvcZbPvgMgBYHxnm/pOpN+J0j9Rb9zcFVaC46XemjWo9ShFyKmC
         NzjTBNHdP/7zGFDxexh/tPRBoE0kHXanq/50cxPOyJZoOrJp1McmlBgoAs94kyHCLSe1
         i2Zp73jE21T+Q9qAyztq4TfqpUnjppL2AUz6HRpbYGcZPU56nCB/oFMBmhvYbXWwFwWL
         NdNnxl+v+KeO3TF69NVK32a4QPrPNLfWMmMyKLpFwK/39U36lRKGe0bLh+ywyk1Da8Bg
         9k4Z18depYh11eU+QPPSjIfE4XXKdlpSvhSjdrb2PdLwFsfM3G5VlApIKCNYfwFjm57Y
         c4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763070994; x=1763675794;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRvKmmKDBmadpAMzc7ydS2dOo2T0G6HxfPJcXHxvRLA=;
        b=XSTuihXKPVXhaEV5OCJTgphKAiAyXW+3bkbwNUJfWN9ashQP9enrqP4U4FtR+KB3OF
         Gx3bZTqcRNKsisvmeiMw64/ifvPVMd1l4mEUjPtauI4yDa/BYElhrFflBBWeLYHiGKoZ
         0f9baRfTdhoMjlTMdPEZ+/JvMsVJJIEftYyAUZJJj80yckLaQKr2xRtl76EXW2U0pfoG
         CkpimSLKCDYqiGH+XXS2hPUmWzVKYQIxiCXwz7qpIF1zs8dNXnKabLZdjLkajtbYP9fv
         GWkh7aPw9A2+SOBTg5JF/i+WwfY74WUz6wpVq0i5wX887DHHKVHdHOSSHtBTYZ5iiRGe
         rF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiLTUa9EaYn4MIRP7CCcr3Jz6dPGW8N0E0XRPCPgWwPkStn7kXDWtsYaKHgVwUcb/0GwJahjr57+undA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhtpRfSZv+e+/ByraNOXyraKGXM44BXGxru/tOmNTgYrvwau7e
	1KI6alnFtnbA29qGhBY8UDORztF3VH+7F1E4/YaGLUK9fR1T0uWseRVSM4GittF4U+k=
X-Gm-Gg: ASbGncvN9E/uUd2tThlnVrVzI/AiXmvOTuCgyKmrczWAfK6CfzYepzzhaERTWDhGKF4
	TzeDhnWDvcsVCoDBcggwsnuJpdzwm+4yrGOHr7P1VynUlpcOMqstPPAk6CRHeEgnoK1BkYlIQhA
	FTDK8DeG72esoprjiN3sFtXDwIJ5NHkS56KjmfjjQ5ok3yCBhOpMsun9Sm5mIvTxMw/s2IfFC8O
	UX04SHRAOfI9f4oZrdaeWk/Vua7E3zeEPwWvcM9z4WypdFPR5ohEySYBO10PFucoc7rwnwmnEKM
	e5+8Z+btAQbkZoUn9Vz5weEH7kT1egCqz3Fj7MvtaIqa302CRJDd2b22HNvsbRX2BCe+GOMiKFj
	tykIGCNGeU4JXbqrV6QV2oXRP3deAfhmDSw1c/0xFGW+hgVeaSfg6AdMFqbg9kAgV432/SE7Y1s
	RKGRSvfapMzLHuUbqKWSq1hdB/Kwri3eWQvfSlPDc=
X-Google-Smtp-Source: AGHT+IEtjFwpcesrUjyIopMNi0ysT/drCu8g2mcZJu7HkZMgEtELOrSpiQmNpwA6WfolP43kiTNVvw==
X-Received: by 2002:a05:600c:4f54:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-4778fea17d7mr8162525e9.33.1763070993705;
        Thu, 13 Nov 2025 13:56:33 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36e8a58c4sm3027479a12.9.2025.11.13.13.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 13:56:33 -0800 (PST)
Message-ID: <92db89af-6fd2-4861-9bfe-3144c5f1be79@suse.com>
Date: Fri, 14 Nov 2025 08:26:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] btrfs: a bug fix and some cleanups in ctree.c
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1763052647.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1763052647.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/14 03:26, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Trivial changes, details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Filipe Manana (8):
>    btrfs: fix leaf leak in an error path in btrfs_del_items()
>    btrfs: remove pointless return value update in btrfs_del_items()
>    btrfs: add unlikely to critical error in btrfs_extend_item()
>    btrfs: always use left leaf variable in __push_leaf_right()
>    btrfs: remove duplicated leaf dirty status clearing in __push_leaf_right()
>    btrfs: always use right leaf variable in __push_leaf_left()
>    btrfs: abort transaction on item count overflow in __push_leaf_left()
>    btrfs: update check_skip variable after unlocking current node
> 
>   fs/btrfs/ctree.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 


