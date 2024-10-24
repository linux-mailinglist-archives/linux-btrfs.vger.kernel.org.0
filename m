Return-Path: <linux-btrfs+bounces-9121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275CD9ADB7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 07:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3391F25D0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 05:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85837172BCC;
	Thu, 24 Oct 2024 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y/QsgxET"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC542048
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747502; cv=none; b=OqgQdAYu30JlMs49rbI5OX0gpOncRV+c3b47fZEBW42xTTE2r6HuxRcs05os9hnRZ/TFIZwJJC7RC2agAeyhUT4j6Y0Qvua9GTtTTg9iHoRwGGAO1fKkoQUcBMKaOEt2pGi+0puay9B2R8bMEl3xphqIIwInxxuCx9Fl/GR8cCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747502; c=relaxed/simple;
	bh=fnoxVZFDnJUaXAFsPMzgYCgo5/dObdNvcNgOCMbAqNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsnYrOGSLoBq2iGH7Y18hZUKLzD2WDPGCioQKPeT/2dI1Vd20PWxSlzJqXHAG1DWmZa2YXuqdi3KIOHDXBIV11oGP3UxEAkh04aOPgw1Z71Tj/mSyHJRM/aUmqA3VTctza8BMLJsx1KKwTmhxul0SOtsiPYUMj9sXENk48jwHCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y/QsgxET; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43161c0068bso4969235e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 22:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729747498; x=1730352298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wwY7yJSjFchM8ZUBP9KNth+w5Zoe/7P2k/oN5iFGL4E=;
        b=Y/QsgxET70zmh4+v7JKWqKA8QA3RB/SxRmRjvXjGwSwZey0I588wFcbwcXoNncvybf
         m7NvF/WT9T7ll13BQBcXjI4lj24try4DqxiRMuiwe23S1atiJhKeFeSHqVwt1CgBup8E
         YDP6TRbF4q60fNbNiminb8XgKeyA9C+C+BS/3naqdmVvkMGYQLf7Tjvw8B8lNhbSR2Uq
         iQ4w6qIX8NcNyWwoRAFnKCrLpKZeqED1Ml0pm/VEuCOsoeL//cd5JuRnCXyN4SWS3wIl
         iGm4wNky8/JaXW7x3AoZEwVczYO48XoRsU/uZOGImfFatKje8/ZDgNX+ge2GnMrTmCR6
         Bmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729747498; x=1730352298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwY7yJSjFchM8ZUBP9KNth+w5Zoe/7P2k/oN5iFGL4E=;
        b=hOc1L9FjkXOv6ngt19Y9LODPVkEvCuHcNODf7GWg5LH54jkpg1KaFjWndAR70HqV2Z
         InkEwj6YxfijHp4qdGPcJgZtZOZZKccsJwMvL/g7KHHl+TdXayyKDoB9MzG5huOGBtNU
         4hfVpA5Hapm+lN5lVHrxRes2nfuBtOiB2YMeK16wtDpoeMS7z6qA4fGg+Y8n73PxSVAd
         soyb1JSrsZj/yhhVeG+QaKU0aI/0Wo8a3vL2N3w5JYndbQnrXIWhPiIC85qwaZm7y4bN
         Vuh25keh35gXSWbw6qJrOAA1cFzpa5ItSqmpTr1uOEMthMvpj3+K0Dn2J9VYBpjbWmDe
         NhVg==
X-Gm-Message-State: AOJu0YzBHRwh2ig72YhQCx4jq7UIOb18QPl0fylUJ7ebhlTsRmzDO/k0
	o1LUY9eqyyGT0bwGka4YjKsK4QHxv92+bT9CygOzofqMR+vCc5Z++/Ok7i2/bus=
X-Google-Smtp-Source: AGHT+IGFimNsg/yYSYV9mJB/v2ugfxoeVUssQTLYAZZVYj15v+F1Vlh5lUzWdjMM32Vt1yPDsEeR2w==
X-Received: by 2002:adf:ec4f:0:b0:37c:d569:97b with SMTP id ffacd0b85a97d-37efcf05dcemr3578135f8f.19.1729747498222;
        Wed, 23 Oct 2024 22:24:58 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48bb5csm484878a91.8.2024.10.23.22.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 22:24:57 -0700 (PDT)
Message-ID: <d373ef6a-956e-4319-ad2c-36f67a887a58@suse.com>
Date: Thu, 24 Oct 2024 15:54:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: avoid deadlock when reading a partial uptodate
 folio
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org
References: <62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com>
 <ZxnXtI_6HCwvCvLT@infradead.org>
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
In-Reply-To: <ZxnXtI_6HCwvCvLT@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/24 15:44, Christoph Hellwig 写道:
> On Thu, Oct 24, 2024 at 09:43:47AM +1030, Qu Wenruo wrote:
>> There is also the minimal fio reproducer extracted from that test case
>> to reproduce the deadlock:
> 
> Please add this to xfstests.
> 

This is just a subset of generic/095.

And generic/095 has a much higher chance to trigger it than the minimal one.
The minimal one is only easier to debug and faster to finish one run.

Do I still need to add the minimal one to fstests?

Thanks,
Qu

