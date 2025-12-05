Return-Path: <linux-btrfs+bounces-19537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC38CA65A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 08:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 485B330344E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D51EDA0F;
	Fri,  5 Dec 2025 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aaIfPJLV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7D2F616D
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918488; cv=none; b=TPg3qd1D08KNyAt22OLusagFnxWk1gKvPRRQ+oGJu6Yon0MpH9kkKx0g5fvHp7H4elomCotWVFg63Lak1kxm+QZUzunFOT7k84I1VUChp3fxVHyBbWDdQCyzMhSUogK5GvhbmooNQqa5Xl/V8LykVcLY6CNusz5KukOpcHKYRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918488; c=relaxed/simple;
	bh=2aPcnfrmG1GAhPFpQKMGQr+tDYB0B0wrTvcsUF4vWYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzVnP4R0CjEKh8hfN6v0Bc5j52Kc1luAsxz36YAawyW1mE6x9FRKuLOY6Aq3or0v9KwrwR/mLso65p4cIZCvAmvC08vFFMVuneRgdGNpCOlg6KiUjL9lIhr5AzinTb3yD5Y5zTNdqLJd05RwRMlvyEUnHb9I8yUuVzs17KC5rgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aaIfPJLV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso22598065e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Dec 2025 23:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764918475; x=1765523275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KKP1mlcjiMeGrtgPfbrYFNK6zcrbrtNLpBYH8C2BXZU=;
        b=aaIfPJLVYeCj72HP+frffE+RGNW+Q5Y3mBGkJ+3YY/la2a+0vZHOIDN0x121UMfFQ7
         aGNx+f61lMzOH7SOzXesz0/jCGK+o2w8JsBh/QMd13iIc7iJFY2wh+gH28UVIoya+g0B
         nYTcLqCNWrmB+USMNZVIVMWJuhOAmQceZEBw1+XQIc8GgKReMEKmJ3b4gP2uwxx8JKbL
         HkmHTlXf5RQEPA4wdE6dNyL8OX+7vZ7hDLakUJ+Nn9d/Mc8FpTcrnepAug6CZSnVM1Ke
         /NUrM5H0brF2i6V9jMILJDZ5k29mOvgbWJ6Z5LrmACaQJCF6n/eweeCBX9svBlmCxpAQ
         B8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764918475; x=1765523275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKP1mlcjiMeGrtgPfbrYFNK6zcrbrtNLpBYH8C2BXZU=;
        b=xOh7S8rclbVHnVcb7YI5k6KIvQh0vpOMdz0IEPeWXRV0YVKezjGe0UIE0T2LCxUMki
         NCkxJcowLlqFuDHaxJVX7B5RtyvhFy1P7oT1x1mTrGQhM0SfdE30h6fovZs5f+Mt4VJr
         zGqGKBCe7awR72Cvo8WSXBjXH8ZI9ChiFN8ScwCqfZFGKwgUMCmkwUk3z7JwR1DovtVs
         egLC10Nd1BcUCYSPIHstQoYXys2mk3OozYY9j/cEMEgJQa0v7KAYnMhUeKMGXQEPmSUZ
         ovTfQKtmdI3+UmaBD/wQ4dciTXr4v0E/GQ0qQWan1ke461tfc9c8ZfgIVu4te/avfCPw
         WlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJNXrw6A8MNrwmUb/v7d6GHk6W1TcXOvkksq+lm7GLrcclkH1pYO2ZhER0cL/cdbn8k+F+omkvaP73sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJ1FNWbbvSo9dbzwtIAjlOLlZ1NxohvVA8K6Ylsh1uYoxWihX
	NaJ8t/KL2mYMIMqooXOMlLtQU+4eKyJK3TOAtsXPa9w4U3+5lVTnNMKxeKxRDJ7Qs9w=
X-Gm-Gg: ASbGncuua8Tmv+Rv2f11nGliYbH35Yw3lYUZpcnrEiDg8N++68c3B3ejq3hoQiuLmge
	4ROwtrhHBVM/h2kPJsauVaT+gw8mKZuowdMShP8X4ZhW/1qXMW5tLM50aWpQrRsJVbpVqKOPdt7
	Maz/tgJAzYMkFcJhQlLEaDilvXpXsT+3XOeTQOriisBgmutykk6i8FpEGlz3+S87uLKIw9tUDO6
	1WuUismk2bW1qkD/p6x3OtjLANGLoaG6Ee1oPqrG5c5xfUZcWVLfQW+V2ptDIoGhGK/zbITHXyt
	3BxMOj/RolJTz9ouwf8pHROvas6603eXZUfyxQxfY9WlD8VTS669xZORD1J4TYN6uZ2OFAGTOZ4
	w/J6rGvEJmtP373EYhBnDMpzrSOwiF1KBAPHk6AOCqSBVhuUVsusv1L7XHgMK3h/Y3uTfaOoor3
	LQxOx1YoZB2fxOicQDEKfhH9ICITCOsIIln8aENF0=
X-Google-Smtp-Source: AGHT+IE8Sb9yZgDujBHmQimeJvcUdNGbGwE6Yd1913s61qF0Q6eSXsPpIN2g3zMrGQVp4caXQHKa7w==
X-Received: by 2002:a05:600c:45c4:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-4792af485afmr98961955e9.31.1764918475310;
        Thu, 04 Dec 2025 23:07:55 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f179sm39093065ad.64.2025.12.04.23.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 23:07:54 -0800 (PST)
Message-ID: <30c4fdb9-2611-4029-b93f-923cfd86155d@suse.com>
Date: Fri, 5 Dec 2025 17:37:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root
 into flags
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
 <20251204124227.431678-3-johannes.thumshirn@wdc.com>
 <35a62029-142b-4882-a238-81baf00f5f1f@suse.com>
 <02f6380c-39d1-4634-b21c-78b81aaacc52@wdc.com>
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
In-Reply-To: <02f6380c-39d1-4634-b21c-78b81aaacc52@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/5 17:09, Johannes Thumshirn 写道:
> On 12/4/25 11:12 PM, Qu Wenruo wrote:
>> Unsigned int is a little overkilled in this case.
>> We have at most 4 bits so far, but unsigned int is u32.
>>
>> I think using bool bitfields is more space efficient, and the bitfields
>> members are all set without race, it should be safe.
>>
>> Furthermore I also tried to reduce the width of mirror_num, with all
>> those work and properly re-order the members, I can reduce 8 bytes from
>> btrfs_bio:
>>
>>            } __attribute__((__aligned__(8)));               /*    16   120 */
>>            /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
>>            btrfs_bio_end_io_t         end_io;               /*   136     8 */
>>            void *                     private;              /*   144     8 */
>>            atomic_t                   pending_ios;          /*   152     4 */
>>            u8                         mirror_num;           /*   156     1 */
>>            blk_status_t               status;               /*   157     1 */
>>            bool                       csum_search_commit_root:1; /*   158:
>> 0  1 */
>>            bool                       is_scrub:1;           /*   158: 1  1 */
>>            bool                       async_csum:1;         /*   158: 2  1 */
>>
>>            /* XXX 5 bits hole, try to pack */
>>            /* XXX 1 byte hole, try to pack */
>>
>>            struct work_struct         end_io_work;          /*   160    32 */
>>            /* --- cacheline 3 boundary (192 bytes) --- */
>>            struct bio                 bio __attribute__((__aligned__(8)));
>> /*   192   112 */
>>
>>            /* XXX last struct has 1 hole */
>>
>>            /* size: 304, cachelines: 5, members: 13 */
>>
>> The old size is 312, so a 8 bytes improvement on the size of btrfs_bio.
> 
> That's definitely more the kind of improvement expected, can you send a
> patch for it? Meanwhile I've pushed 1/5 to for-next.
> 

Sure, after you.

Thanks,
Qu

