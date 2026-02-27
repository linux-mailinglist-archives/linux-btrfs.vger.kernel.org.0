Return-Path: <linux-btrfs+bounces-22052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICnLNjVAoWnsrQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22052-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:56:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 570491B38FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 161E63019C8A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9138A718;
	Fri, 27 Feb 2026 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MieYH4fG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A664301701
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772175393; cv=none; b=ZjwhE188s+Koa/SMiHvQSK5tUqca9igZlYqgk6LZz05PXPz2R01OImy7RzkrmrBZGPOl5lRSlam6fyhS5sXTnNu6c1J9xpG2Jjjk/vPlFSoQs38Co2GANmSWFPlcWAXN6KdyrxyyN400tcWrCJYZNF1Xie+wuIKVAdYfXKIkEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772175393; c=relaxed/simple;
	bh=0chTZxrbhlrsLruSMIgriWboZgguPI4iTTzMyr0NX4g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fKSTyLtF4igkxF3QrO4pP9G27RfJFE2oh3HdaczJg3YzFqtvI4LVS7W4WKKBI0RpExgx2Hebc39kapFtjzbBQWjBNgx8DpOIThviY60fZ8epBrw+ZxB0uUPe7quPI8XvBDz6GjNtx2/OXEp/WYXlyxAeSz+TD0kxXezjPOokQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MieYH4fG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48371bb515eso22589825e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 22:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772175390; x=1772780190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kIc+yKkDm0c2XFpHu5zeS+KC8UxEPaAe7ihRE4oNVRA=;
        b=MieYH4fGOYHN6NJsEypqvE4G28J0+ymo09anD/osTx5ptUoL5welOKqfJDbFk/bC8T
         XE3+Bm2DCf4ifjsZeUvf8HB9AVEmheaxSpVweZaDlWbBsg4q7saxciEE+T3dfgDkBGku
         vRV3u4AglR/+1DoryKldQ3xlMJ+XEXzbwc6EeCtShZgfUvUApszLeJCJjJw4ABPFM9Wc
         FWEE9pX1Azi/Wjc8jaHZRn4llBa2czoh7ArQh1AuslmfRQZ00TzhYNxAWvCaM6vM9CtU
         gQdSs4pFonMlPVV/qr7LZnIvJq/bethGwYpCB6U2b/UDP0tNj4XDSDQJYoJ4F9y6Tt5K
         6GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772175390; x=1772780190;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIc+yKkDm0c2XFpHu5zeS+KC8UxEPaAe7ihRE4oNVRA=;
        b=TOM1GjnGEMc8+ddKr5wqlP9nuURRKmZL7RvpdH9iT+f9D7B0xaUHrhvlaCMdgn54oe
         JC8lDtMUFYVnX9TN00I8JZleYMEknfPcI4/TVXyOGr6JA4GigNwiVhfd8oXcP4Pc1VCE
         Kyt3y5jpLpXfesZFq2cYI2lA2HvR11nfI4PGyBPSLYu+SoPdJ2qf6jMonjZJOKqRvE6n
         xEUxtYE/4JIMzI5Oc/jxsh+eval2134C7L3QZJq6EmyJvOlI+Ei3Oa+o/HvnSIw9tG24
         Tqit61zyUNbDAsC+RDn+Cv+MKVnVQtP8zgd46XM/3Z8Fp9QMk7zenptQicy/w2KLJ5AZ
         RD+w==
X-Forwarded-Encrypted: i=1; AJvYcCUyISG+lrpkzFoVND9U+8J6BiYJ1PhSngqexpSMk+IOU0TG38g5ryYHnIUZCBsAMpRkQQYya0OeDSiwxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzysepAXYP+TmGdij3NvhEDCbKrWjlzEUASuRvlv3g/zs8s3srX
	OReC20ZxqngsauqTiImub41Q/3bnH0ZyPx9CBxPStZWWe/XU+FX8dHaqu0sE4K2lRwY=
X-Gm-Gg: ATEYQzyLn4uXxq3cfmo5kvedUg4oYuMv+6GuRlUstBUDtFjBeshiiVjgcJPi36mlWKq
	cr4L5tNnuVBHxo9glZMHbP25+ykSNRYK5j1/301ZVXAZy+aaukqHheGd/z6kASo36aex9ZC/NEp
	gxKaFRMvmcKJiKIvc8o0kwQojIc++sh0vcsTOJuoKoElI6odINkomw+CdRVz1uEVmlkVjryhcPR
	9RP0vhIjMDeuVT7CtO1ukXzOQf8IHFXwrzXBJCeC74hXIiTXuk5nnn94s6h/KWVoMv0bTrM5P2R
	Fp/Sm3GJcFkKGJFN3rSpp6wnEjjM/WbdUaYJSBOrx4OmMnXxOOdGCHZv5Yf5P8bnSLJE8T62Tof
	JUte6xJZDCRkPYdu5MdKqWVDXi8AVFGCQVzkztGfpdLEbws7qLTEHPryRa9V6FSCrX9Xnk/MWTB
	1+55Ue3wW3ac0Pf/SYYI8dWqIwjgO7DE6Xq6SBmMw4ltJlga/h1gc=
X-Received: by 2002:a05:600c:628c:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-483c9c28da8mr24171145e9.31.1772175390425;
        Thu, 26 Feb 2026 22:56:30 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff350asm3872849b3a.35.2026.02.26.22.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 22:56:29 -0800 (PST)
Message-ID: <4586325b-ef9a-4299-8a5b-9a67aa4edbe0@suse.com>
Date: Fri, 27 Feb 2026 17:26:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] btrfs: free path if inline extents in
 range_is_hole_in_parent()
From: Qu Wenruo <wqu@suse.com>
To: Hongbo Li <lihongbo22@huawei.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
Cc: sashal@kernel.org, fdmanana@suse.com, linux-btrfs@vger.kernel.org
References: <20260227064414.2314529-1-lihongbo22@huawei.com>
 <2a3587d3-f131-4e19-b7fd-3c14e8d097f6@suse.com>
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
In-Reply-To: <2a3587d3-f131-4e19-b7fd-3c14e8d097f6@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22052-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 570491B38FB
X-Rspamd-Action: no action



在 2026/2/27 17:18, Qu Wenruo 写道:
> 
> 
> 在 2026/2/27 17:14, Hongbo Li 写道:
>> Commit f2dc6ab3a14c ("btrfs: send: check for inline extents in
>> range_is_hole_in_parent()") is a patch backported directly from
>> mainline to 6.6, it does not free the path in the inline extents case.
>>
>> Commit 4ca6f24a52c4 ("btrfs: more trivial BTRFS_PATH_AUTO_FREE
>> conversions") in 6.18-rc1 fixes this by accident
> 
> It's not "by accident", it's the designed behavior, remember the fix is 
> after that commit introducing scope-based auto-cleanup.

To be clear, all I mention here is based on upstream, not the stable 
commits.

Commit 4ca6f24a52c4 ("btrfs: more trivial BTRFS_PATH_AUTO_FREE 
conversions") is in v6.18, meanwhile commit 08b096c1372c ("btrfs: send: 
check for inline extents in range_is_hole_in_parent()") is in v6.19-rc6.

> 
> It's missing the dependency, which can not be directly backported, and 
> considering the scope-based auto-cleanup makes is much harder to detect 
> just by the patch context, it's indeed a problem.
> 
>> by converting to
>> BTRFS_PATH_AUTO_FREE, but we cannot backport this to 6.6 due to many
>> dependencies. Instead, we choose to use a goto statement to avoid the
>> memory leak in inline extents case.
>>
>> Fixes: f2dc6ab3a14c ("btrfs: send: check for inline extents in 
>> range_is_hole_in_parent()")
> 
> With the commit message fixed it looks good to me.
> 
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/btrfs/send.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>> index 6768e2231d61..b107a33dfd4d 100644
>> --- a/fs/btrfs/send.c
>> +++ b/fs/btrfs/send.c
>> @@ -6545,8 +6545,10 @@ static int range_is_hole_in_parent(struct 
>> send_ctx *sctx,
>>           extent_end = btrfs_file_extent_end(path);
>>           if (extent_end <= start)
>>               goto next;
>> -        if (btrfs_file_extent_type(leaf, fi) == 
>> BTRFS_FILE_EXTENT_INLINE)
>> -            return 0;
>> +        if (btrfs_file_extent_type(leaf, fi) == 
>> BTRFS_FILE_EXTENT_INLINE) {
>> +            ret = 0;
>> +            goto out;
>> +        }
>>           if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
>>               search_start = extent_end;
>>               goto next;
> 
> 


