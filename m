Return-Path: <linux-btrfs+bounces-22251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGxHK0yFqWkd9gAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22251-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 14:29:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214A21299F
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 14:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51FB03049303
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78C3A2559;
	Thu,  5 Mar 2026 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghFyesax"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B5217F24
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717383; cv=none; b=Zkhc1kAMltEH0kCy/vV4XCIFFQLYZql+vTt72+Z9Xo5pqEhGVdZ/Ut+f2g4rzsKHnZgr1Rh3oiQY8SpLTWrd5ynIS1uroXQHRPveyNdKhu99msmZmAYBIG0A4okHA11M9QQ/SGLQjlK7f+tJUeeV2J2BhU5EUs6xxIJU+fWOalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717383; c=relaxed/simple;
	bh=YkO/G2R8ODRQ2rRsUP15eiun7Ah5MnpYmFzHmN7pXOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rM/HLySUjYiyQQTXJWEHdfOkBi/NfvBZUploZuxs/HFnUCboweYgvKSKDk50uadjV3JOd1H1ZgG796pAz5yXDFqpJI0CsgpJPpGVAV8nEwwokSf67dve2GZugPJSITW0JDzKq+Z456v7gRUoDeBTNtRFwnTC2FaN6cpWEHNEgOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghFyesax; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c65c87f73e3so463302a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2026 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772717381; x=1773322181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3MTFpPEzVHMAxitK3qHuRqSeRiKuf1OA/xRrKez398=;
        b=ghFyesaxQ3hYarG0bIHmWbZEUAM12YSnthd+RofIHVb0qduqXwF+JW1GaeHFAIRRlG
         iSXDwTCgz5BsLpu/TYyX4wKB5natGVSjFK0NuBMV9AbU38KlA4lZcJlnJaLCGOWJOXe8
         QCTwXKABST/FoAG3mEVAzZqWQDtQtN5ZIVm9DDyMR2sLfUyzVsQlw75+C6L6wXyU5dbL
         OLPtfcjM9ez3U3KpffljS3FC0MjSREDORY/VLd7UO7NpsOfiXMygMIzuoGNdh2kHsKQl
         sajZTB3c9ACAI2HBMYnI1I1SEwbN7SbV5Wta6kohQf1rIXBW9sh0vZACcj7lczhTgjWf
         WJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772717381; x=1773322181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3MTFpPEzVHMAxitK3qHuRqSeRiKuf1OA/xRrKez398=;
        b=LQpfs7ZcJ8hbgXBL+d9XJoZFZJKiKeWAWWaU/iK3XkpEa3MPkqw6aJXWPdIW4jHckb
         i4Epzl2YQfl0IEgd13YM1xNWADPhDVruM2Bnq2oW0LsRCBOb7GbUsNEgZSK3q1YbeoUf
         9iDZCdnqwOqyKAdc1TJWvGe9g4tU1HYg0iW29r1gjIOhHUWaRZHqsh8lfL0Awaocx5Sx
         SgPOAH6ctI/RNixLkrkNRvaG34wATBfMhfIz8nzWcPNh388l1aQ7ZzV/B5DVHfanenWg
         R3h19WeehKqntsmz0tiLoO116hsBjV1++EgFrzYaQxBfx/z1DvSXKaNskD6S78LjlHJg
         bPMw==
X-Forwarded-Encrypted: i=1; AJvYcCXc2CWPTCDgQ6qSPCtSOKIzucPxRGK+izIIkCS25e93E3nk2Az9RCIYWcsWk4CD8CrihyI4+YLjn+lyPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyawKfBfjH+/3kHS3XlEFuqzwt+QMuNOA30OhxHFVH/Guk4xIC0
	XoyZmhvoxeuwj+tMEKmzaeJAt/WMxtgCGUS8x+OcKmb2XOQuoIIWB2of
X-Gm-Gg: ATEYQzzKkdaZT9W7Y7WNxpZvBXod37BCl1cyZndMtiXBnfdgNmxYQzUNB3c/Vj6YroR
	fLowcOtxgzt26/DjZCUhUMUHjm90t5x42U8fJQJjzG/IDM4i+97Iiq+uBSHR72onV5ATCFru3GO
	gZnc3f1ax4UE7pFyGzjT/Nk1Zuhg2m5KBlHRU1qwDYjEMBCK/hxiTu4hnpc+J9jQoucdAF/IfQz
	Ubr+8ROG/5kO0g/QAuN7BZ8vuCePCyaKkZEPmunpZmagcK/Pt7LIFeZDo4x5U2J5q8LM5aO7Shm
	+2q4/4XzO4N8VtceBqiOPPsVViXVPbzrxyVSTVAiKAqEddNWn0XKCimWKAHo8YnZx1KmEpxIfNz
	YTs1RbqrdO+ZStVxFMSafKJqYnDGBwqkPrvEfqW7z8RCJ8jUPA4m5u35dyQWU2XqUEVkbkFE1Jp
	aVaowxKaFJ7/tpFqS5vJhTbArHiugPK6Z9FKxQgg==
X-Received: by 2002:a05:6a00:12d7:b0:824:91f5:aa2d with SMTP id d2e1a72fcca58-82972ca0678mr3362315b3a.5.1772717381459;
        Thu, 05 Mar 2026 05:29:41 -0800 (PST)
Received: from [192.168.1.13] ([103.173.155.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm20500506b3a.36.2026.03.05.05.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 05:29:41 -0800 (PST)
Message-ID: <9fae675a-50b2-468b-9e01-0a15001f53a9@gmail.com>
Date: Thu, 5 Mar 2026 21:29:33 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs: zoned: limit number of zones reclaimed in
 flush_space
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>,
 Boris Burkov <boris@bur.io>
References: <20260305100644.356177-1-johannes.thumshirn@wdc.com>
 <20260305100644.356177-4-johannes.thumshirn@wdc.com>
 <0bb1f7b9-18d0-4fe6-96a4-88a6082c3342@gmail.com>
 <eaa84469-ca22-4833-b6e5-9dc1af4d2bab@wdc.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <eaa84469-ca22-4833-b6e5-9dc1af4d2bab@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5214A21299F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22251-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2026/3/5 21:02, Johannes Thumshirn wrote:
> On 3/5/26 1:38 PM, Sun YangKai wrote:
>>> -static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
>>> +static int btrfs_reclaim_block_group(struct btrfs_block_group *bg, int *reclaimed)
>>>     {
>>>     	struct btrfs_fs_info *fs_info = bg->fs_info;
>>>     	struct btrfs_space_info *space_info = bg->space_info;
>>> @@ -2036,15 +2036,18 @@ static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
>>>     	if (space_info->total_bytes < old_total)
>>>     		btrfs_set_periodic_reclaim_ready(space_info, true);
>>>     	spin_unlock(&space_info->lock);
>>> +	if (!ret)
>>> +		(*reclaimed)++;
>> We take the address, pass the pointer to this function and just for a
>> conditional increase operation so I wonder if it would make sense to put
>> this into the caller side. I think this will make the code easier to follow.
> 
> Then I'd need to change the return value to a triple, negative error
> code, 0 for skip and 1 for reclaimed. Can do if there is consensus, but> we have some of these interface in btrfs (btrfs_search_slot() comes as
> one of my prime examples) and I really dislike this interface.

Sorry I missed the skip case so got a little confused. Now it makes sense.

BTW, the style of negative for error code, 0 for success and 1 for 
'nothing found/done' seems widely used in btrfs code base, and I'm a 
little curious about your preferred interface :)

> 
>>> @@ -2099,6 +2102,8 @@ static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
>>>     		if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
>>>     			goto end;
>>>     		spin_lock(&fs_info->unused_bgs_lock);
>>> +		if (reclaimed >= limit)
>> Type of reclaimed is int and type of limit is unsigned int. Would it
>> make sense to use both unsigned int here to make sure we're comparing
>> variables with the same type and the behavior is expected?
> 
> I don't think it is a problem in practice. Even if limit is UINT_MAX
> (like when being called from btrfs_reclaim_bgs_work()) we hardly ever
> have a list with 2^32 entries of block groups. I know this sound a bit
> like "You'll never need more than 64K of memory" but we'll run into
> different problems before IMHO.
It is not a problem in this case and not a blocker for this patch. I 
personally prefer to unify the variables' types if possible because 
comparing signed integer with unsigned integer will easily trigger some 
unexpected behaviors (and I've encountered this kind of issues a few 
times :)

Thanks again for your great work!

Best regards,
Sun YangKai

> 
>>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>>> index 0e5274c3b988..57b74d0608ae 100644
>>> --- a/fs/btrfs/space-info.c
>>> +++ b/fs/btrfs/space-info.c
>>> @@ -918,8 +918,7 @@ static void flush_space(struct btrfs_space_info *space_info, u64 num_bytes,
>>>     		if (btrfs_is_zoned(fs_info)) {
>>>     			btrfs_reclaim_sweep(fs_info);
>>>     			btrfs_delete_unused_bgs(fs_info);
>>> -			btrfs_reclaim_bgs(fs_info);
>>> -			flush_work(&fs_info->reclaim_bgs_work);
>>> +			btrfs_reclaim_block_groups(fs_info, 5);
>> Would it make sense to define this as a named constant like
>> BTRFS_ZONED_SYNC_RECLAIM_BATCH instead of a magic number 5 here?
> 
> Yep I can do that if there's another round (or when applying).
> 
> 
> Thanks,
> 
>       Johannes
> 


