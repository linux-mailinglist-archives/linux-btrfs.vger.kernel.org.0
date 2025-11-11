Return-Path: <linux-btrfs+bounces-18877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE9C4FB82
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 21:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFD43B7DF8
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849672BE7AC;
	Tue, 11 Nov 2025 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NEETMhYX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FB33D6C7
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893519; cv=none; b=KZ7Q6ACcsaCzXvUSANTHTI0Qsbv56inTLr3eNgHE3HveVFKpQbECILd1EHKpqT8yRZkg8zK5JYGy61C89u527aBGDLlvJmJdciE84kJeS129fY9qTy0ZJE06kCgJ3RkVzA1r1Bgx4OiCwx1aCBqe9LJA3rGDXRz4p+4pY0ip4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893519; c=relaxed/simple;
	bh=oRbZl3b2HBKqNSxa6bAJh8dfZpbF9UulQSvuOah+xCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ib9/1JF1OZo0zJ+Av+mtcbd6Yb7cZQSooHfeLrpNGiJAfmOYIcOBSyTEfiUvMnSxzXT30PVqyjiJgh4qr0qwZ+bQR0beGbPoodCxtE6j9b8a+esT8tZIkP8tm3ecSUnwdRgq6buyMJA1hYK5txINxQlKDqCokUZ5IrR6YEeS6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NEETMhYX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b32900c8bso42147f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 12:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762893516; x=1763498316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jncJnNbR5V/dQX3wE6DsLWbJxpoyKxtT+WPfuWZqQSA=;
        b=NEETMhYXrBqTTuQvmEJvDMJOU6e8tKPmUA5NFckHjN5T7nPLQVenwG+X1wkEDPicZR
         8grTOLLVei8tkspsCa8N6FYSj0t0DZZ9BVqEhX9oh7sIWdguUUSIXAhaEyliwlpMGPP5
         SjqFWChCVvcdMZfoPWeHpDjosf/3W2z9XOhfszSjkl+LR3gHy8bGXvP8sqzSt6bmVrPN
         qBpTfxCHTrJOO3yEv3v9IzKZV2Z9p1gP5wjQZC3+qUYMgtPUIYElKH8UQmLxsg7rMYka
         054T8vyexQ/KZCDvoApLqh9KT8XxYNbT6yVvOq/ZDpLsLGGiK1AX6icb/nwbyRwhkggP
         7kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893516; x=1763498316;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jncJnNbR5V/dQX3wE6DsLWbJxpoyKxtT+WPfuWZqQSA=;
        b=anHS4k0zUQNgXUgCLYaz2neEq9ttOy+TNuhkIoivMCrCw26H98Zztr6QNseK8MwCDQ
         OZO4nZbZxRxdj87iHwaITpW7h/acgSfze26uyQkngNraZxYjWskW3CLp3nOJLa/JamPU
         rwHT42ygydUfdJLvD5DrirLXiFLpq4ZDZSL/PNL06siDl1OEhMYcTmspJ67HGyj23KxH
         Ej1+d3MQwMaUyEy70WwdbqhMbHi0kO1L9tqGMmsYFZuLNkO8J6ovFv2i18HT2YVdp+gF
         IrBojiHuAKdda9YhlxnrnrBZd7qnut3m35KtvUI9oLNQbx+7dioRZs0FhNgSVW39BF10
         kbpw==
X-Gm-Message-State: AOJu0Yzcihh4QFGQdbEXzrSLIf7eruAHXOq9qzWvoSytrmaXeacCcu9H
	Mr4NBsnJycZbJRxhiktRjyFZ/g7iYmLFHtbvZv6nb3xzwGTRGzL2vNvxYnZPahMem/uMyf27NCZ
	jsE6W
X-Gm-Gg: ASbGncu+usFuc6Bzfc2UTpPUEK8FGKdODyIdYItLGVAaDyzLRC3p4mfWs/Uu+u6FCEZ
	emjCQd5RiK38QK5DqqhufkUxe374L2Y498MeRGz1eXDwUdeFO3CWd/d9Wpuv/n7vuSKvSrvZYNs
	Jvp/nnTl4VAX1ZAZf5xOjJoHegB/TBuC5Lh9b8lO+3NZWj6CTKgvp5Ag69GYVKqmDEekGHpDFoU
	nO0F5ai9famvE3AKEng4bUjbw8E2Qz8JDu+el40ph3hv8KRCxwZvOt/aMpRsQbwa4el8QMVoIQo
	Kk8+xnAIt7ex1AHP73DwPWeKFlYwyRyjtYhCN9xtxyjgcS4Jl52I2GErAu80cd3ebQQ/vmXajYQ
	FDlHmOfYNNxFdkNxZ9V5YRqdifeoqvefV7GL1f63aC5IfED+Wz/eJ4aZMYJsQujJmCnZ3X6Nu0F
	XA49nCHfcu0o0V+yrnZ5lGEPqVJSA6IYiW+UNC4C4=
X-Google-Smtp-Source: AGHT+IF66F/Hq92HAf5nIzXBhq5zLm87an4RstM3qnJEEOkbkFuGpihtvM2oAu0KVxxSKGzo3beHgA==
X-Received: by 2002:a05:6000:186c:b0:42b:2f90:bd05 with SMTP id ffacd0b85a97d-42b4bdb5205mr380755f8f.45.1762893515892;
        Tue, 11 Nov 2025 12:38:35 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbd89a7sm6247635ad.19.2025.11.11.12.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:38:35 -0800 (PST)
Message-ID: <efd483bc-ff94-4cf4-845b-a6c101226324@suse.com>
Date: Wed, 12 Nov 2025 07:08:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
To: Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1761715649.git.wqu@suse.com>
 <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
 <CAPjX3FcPa3mHYajjKJsOSk57o7O3Uas_qP1bvf7QJK3VQzJS7w@mail.gmail.com>
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
In-Reply-To: <CAPjX3FcPa3mHYajjKJsOSk57o7O3Uas_qP1bvf7QJK3VQzJS7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/11 23:11, Daniel Vacek 写道:
> On Wed, 29 Oct 2025 at 06:43, Qu Wenruo <wqu@suse.com> wrote:
[...]
>> -/*
>> - * Calculate checksums of the data contained inside a bio.
>> - */
>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio)
>> +static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
>>   {
>> -       struct btrfs_ordered_extent *ordered = bbio->ordered;
>>          struct btrfs_inode *inode = bbio->inode;
>>          struct btrfs_fs_info *fs_info = inode->root->fs_info;
> 
> If you use bbio->fs_info, the inode can be also removed.

Please check the patch 3/7.

There is no more btrfs_bio::fs_info.

