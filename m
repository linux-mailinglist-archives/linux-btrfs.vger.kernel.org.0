Return-Path: <linux-btrfs+bounces-18029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E22BEFA55
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 455224EEA65
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE12BEC31;
	Mon, 20 Oct 2025 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T7IURxth"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2961FE47B
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944591; cv=none; b=uYkQUtl5qV7WlBQRw47vK3TzeGGWx41m/E0f2whBnewGohRpZUB73lHbnITzPgDgY1sExLRfCIsXgnX0CnzFVmjroK8wGb+wwOSqVQniMOe7bWT8lQPKvO03DZhQGq6OVxLxvjY6AjdrWJLmQ4PSZ1qQ9J5TPvBzOTdTNzVukUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944591; c=relaxed/simple;
	bh=20LCBZR/gV7+MkQ1glXCNGYGDgZDymrAP/dmdXnQ63E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t5VXvHwsoA5Iz+G0SWDJZe8rK4dHY+ASubHr0n++gA0E1TJnyMQdmyzIYRa2YB412+Zy85aypiSkNQPiR2uvpTby/PG6IHwCPvL4Pwy3KVtKnLkwWRUInq6ZGoTDtPdBqYbki8Ts57E2ILFUmpcVKN6hX6aRVWv36JBUIjKug70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T7IURxth; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so27435285e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 00:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760944588; x=1761549388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Dib+8Doe/XEjEEfda2bJyGchaNGxgUKf1XVwulhtC8=;
        b=T7IURxthOgBUrf+1+vMdGYS+R6y7qUiTjjMozVXOUaJvAeArttIhDVw6M8Jzb8T9z4
         TM0v8VoHN6EQ+2J3Xf2co6ieN7DE5kqgSP52kdHsdhNDdPSSxwJmBoYaVpmUDYTe9H9Q
         CGRmOndKEKQMnQZD7YC9W4dxRK5J6vNXui/4oNQZDKL2KwIl75gVnhQ02kA3nLbncBLx
         f2SNYFK6AxErxqPr4h6AkvCJQQMPefQrve2WR0Raa7iLv2UBuDHrjDjg2Ep4En/VO3qN
         zow+mJy66mNIAj779/7A1ThWdH5MAPiTjcBQgsHBDMkCKkdG72HCHREjs7wLtZP6VQ6e
         JfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944588; x=1761549388;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Dib+8Doe/XEjEEfda2bJyGchaNGxgUKf1XVwulhtC8=;
        b=ZHh+hTctZWOp2Gz8wS01Ljl3UXWCCm9CqUAAT0zvwiGWtqHp8BgZpr8rB9pdmApGLM
         8VO1+AC8m4PNYPX2ZJDPx2PIkZRBSaMaNQ0P15V6Ae7knrln5d0GmBPSGk/lsqFQkzdl
         AMNDh1z36VviGLrRFl00ECKQvoSeDzuS30eA9wW/0GMM9q7OABZ7sr8DJ2Yw7KuIl62b
         Hg13eR1S1dpRaHgTP/h0BeHoQct0vJvWpEdGonsqL2TwY/R1E+CXP3JxYCri3T2rRnrt
         Bb1jku4KMW9DPt6vhWK2g0DNKcU11zQJ4nejkZ144gLWfKxZf7ItPefy5+1vi5fq7p5H
         C2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVh5TxeCoeWDixKisyKYAkjljdktXA9IIg34dYR3Yd31cTk5vpmcbGXtyAH1VfTWWgarVWX8NJQqJK4Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyesRniaZ394H5npayTc9N2dzDgcp23WJeZWVf1douHEu2vMYqj
	iWiDU6JkbKpm5rMXKUFv8qvZhJECzz5UzJjKsS85Zk856q8Xl5edv/y6i4a9yWC+0Jo=
X-Gm-Gg: ASbGncs/xlgrfrsk8NRT8yDTPJz8TYj0bfOsH18pPz3ELhR4p3GXYxCGgZN3kP5sFZS
	56k0R85Ky7wnHuPAb/Gww1g6zh3tNgq6i8FnbrNu0n8S8Zu7+ZJREDFrNLYzPjdkP010SwrIZOA
	zCR1cjwXI6bQry9KP0k767sMqtbyzD9sSuy3Z5dZLT1KFQZW13+LZiENaZVoE9YsSVBmPaytmNt
	HkZc5oJc8y3HyLkODRxvgpq4PLRksaT0YUUfeDuRqRVuKFcDgdbSdlNzC409/0/WVYB++sFQwUw
	2xPyuYOuMmWAaxi18VkgDmPxYAS8JVYwzxL22cLfBd/mMD3Jcw0+QWh7pS4dT4LkpGsGETj0L4O
	m3d3lXoW+qPzYKziq2SfyC8S1kL4UApDyVn0LRKDy6q2DSoF/cJPw4YpO66WU50GowippU42xvA
	XssoXHSij32BWQfE6curVm5sxWBu/G
X-Google-Smtp-Source: AGHT+IHQQmNeBbKtK/IM1/ac3ubm7E/+xZyn6+r/QJIYB+98SaFLzFP7vULUJoQ5jXzFn9OxsGSZxA==
X-Received: by 2002:a05:6000:2089:b0:427:521:134c with SMTP id ffacd0b85a97d-42705211378mr8737336f8f.6.1760944587813;
        Mon, 20 Oct 2025 00:16:27 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fde15sm72078875ad.84.2025.10.20.00.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 00:16:27 -0700 (PDT)
Message-ID: <2912ce5f-fb54-4681-b001-112fa26b062d@suse.com>
Date: Mon, 20 Oct 2025 17:46:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: get rid of btrfs_dio_private
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <c5f3f2c9e1d5a3754ff61b3569191b31d13b9bda.1760939793.git.wqu@suse.com>
 <d5b9e358-cb02-4f8f-b669-770a2014319b@wdc.com>
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
In-Reply-To: <d5b9e358-cb02-4f8f-b669-770a2014319b@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/20 17:41, Johannes Thumshirn 写道:
>       /* size: 336, cachelines: 6, members: 13 */
>       /* sum members: 334, holes: 1, sum holes: 2 */
>       /* member types with holes: 1, total: 1 */
>       /* forced alignments: 2, forced holes: 1, sum forced holes: 2 */
>       /* last cacheline: 16 bytes */
> 
> 
> We might want to shuffle some things around though.
> 
> Anyways, not relevant to this patch

Unfortunately fstests is not passing, test cases like btrfs/06[01] can 
fail with pretty high chance.

It looks like the bbio->file_offset is not safe, as btrfs_split_bio() 
can modify the original file offset, causing some bio ranges not 
properly released during dio reads.

Please ignore the patchset for now, we really want some stable 
file_offset/size that will not change due to split.

Thanks,
Qu

> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> 
> 


