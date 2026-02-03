Return-Path: <linux-btrfs+bounces-21334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NS2LsVigmnfTQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21334-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 22:04:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E384DEB75
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 22:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E568302A517
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 21:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398C52E7F1C;
	Tue,  3 Feb 2026 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CzIfV+yJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF0AD24
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770152636; cv=none; b=g7+0QQsxbfmCSr8K1nkEEfRKdpltYVKqxZW391CqgjT0Oq26uC+i0sD76rD6IGJsnhfH09dDviX1SpNo2lh3rUcM8s3UmG9NMHfVPiZ0x3axw/GzR0qhHqDaNUBxFIyMyzu4gyRnGtHRauG5/pBE/PaZ6oGZOzOtb4jjn1Jqj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770152636; c=relaxed/simple;
	bh=Mox2FT/7df68/qKfHo/cNxYGxxVrdUgYwVFj9S1bsT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fZZ+0dZyVkA2kdCAhl1XBrOKws2+JPxfbO23eLxUS/9mODhic7ycy4H3rsU//QkJ+gKqbwj1z7qE3yEMn1vTwbPrJbQ/sxeJYkRzNXM0f7lD8KwiVG9XEAbOqPHQYRAgnwfmlI5iqimVCCC0BXqtO+5DK7MgriuuchVNoHnmAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CzIfV+yJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so64370775e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 13:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770152633; x=1770757433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ev0CNwjUyB59wvku8XKUnGS3jEGzvdmkDddGfJCvjVk=;
        b=CzIfV+yJ8PFquWSHCdsLMcUFW/VEARa9tmdxM+VNG8PMHtZyhGVuJ4uzaTxxzeq4Y4
         38BD3RS9Xc1c71es+tyIKjrWN0PNq/o+sy0Q27eJSbMOiOdC47X9ba6DVZ+VLAQJec9w
         kTZMq06YEkEUr5ySQCuLEJ/2amh1krK/9UwEOBBp84PXA4vasXDc+GhTfuCB5u1zs3UQ
         o6eRNuPDN0/kjdB4TwXYCs13VcZtmiNs32ZqBgILG8pjH0mLtoIO93veq9upbic6iMw1
         P/f7FqJ3ZDUJTQIAbYD37MYGBGgJxtXXv3uMDfehP+GOtTD7ckoYk1Az0bEQdAvficPn
         bQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770152633; x=1770757433;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev0CNwjUyB59wvku8XKUnGS3jEGzvdmkDddGfJCvjVk=;
        b=GU5qyica8M//UmK1jJZe5XqsS52PFVzuJ2f4e36IBL4f8tAhthp5ltY1G/FpeVOutv
         /9pCZChvMV4csxEp9FpcGm4YezkGvEsLszNLwqdo9FwKs0ylVk5XRhnRxmqzYrwnWEI3
         0e7mRtEkkRqFqFXWN1uL2IMngzAxYAcWQ7FcQtXS2v/Bh8iMHdNIr6PBuvtP0WtfJuIa
         G8X2fvlMEUyoboda6dia/bvGsKcmiYUbkQ9rCX9zVxOO+/SPsDDqp0+ujDbIhRLnrL+X
         PuX5Ewra/Bdvqr4nZp4BrCae1Cgs8e0Q4C8PtarK03CRSZ2y7MOHxRONzQFVznpxxGsD
         USHw==
X-Forwarded-Encrypted: i=1; AJvYcCWsoljE8XaTH3unxS8mURFE9BWpwZCBOjJdDOz9HQiB8WblsPCOS/YEYuZdACoF+hylmvzb3DTcikVrYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxF0I+srTygrN1GHbYY8OSGe1kT13Z7T5JMiS4sQ5XVkTYWvMc
	2z+TIEBCIGUbZUv+0PDiIOejQkHGKZKIJo4MaWiGzozJxp9yGG0kCHskN1gNSp7IRglmnRCREU8
	mO/qt
X-Gm-Gg: AZuq6aJfdaU1MBBigKOCpjUO5Y6EdNmjtKTH+WPVXQHgPXNPNRV/Lcw0i8+4o/n2XuP
	Ckf6/NZTb8nXYE+7QxwSYh68NKbAIQCmuE/ZQGPGhHoMnnTFjaDjIixmQ4thLGA2S21InYsyWcg
	+KdPBwbwdb0kfVepF1NoRxdrIbuM606EDzybRlNeST9k8QTUVySPJFXU3PbYouAEPIHaHK9M3Tp
	GqcJXl/NeczAjQsgWGJluq/nuk5N+vvkdVmK4jokahJoakSNXtACgA2CbwpqcNR2QwyzhwNVIDV
	/FbAfXbDv9RD1c+fZOzzqUKCZIBE0Gv7OzLMNbvkJUC6kfpNtStVsx4Ckz5g0MV8emduHRUNhqZ
	uo6XHi1mboQMGN7/l5x8rZHT3pa6igkPA6QOCJrjJb7S/yf14IOX/HfFg+4mkgZrRI8wgJURFah
	IdTzQoehC5HmEriewZjv8zfsR92KFY7GgK19b9jh8=
X-Received: by 2002:a05:600c:4e4f:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-4830e9335cfmr13178515e9.11.1770152633411;
        Tue, 03 Feb 2026 13:03:53 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354860be583sm426970a91.1.2026.02.03.13.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 13:03:52 -0800 (PST)
Message-ID: <0214fe74-c8d1-4ad4-9718-38950df30916@suse.com>
Date: Wed, 4 Feb 2026 07:33:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: cleanups to the sys chunk array checks
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1770133086.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1770133086.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21334-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 3E384DEB75
X-Rspamd-Action: no action



在 2026/2/4 02:09, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the changelogs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> 
> Filipe Manana (2):
>    btrfs: remove duplicate system chunk array max size overflow check
>    btrfs: move min sys chunk array size check to validate_sys_chunk_array()
> 
>   fs/btrfs/disk-io.c | 28 +++++++++-------------------
>   1 file changed, 9 insertions(+), 19 deletions(-)
> 


