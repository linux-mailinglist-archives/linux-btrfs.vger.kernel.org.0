Return-Path: <linux-btrfs+bounces-21519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mo4tEFFciWlY7gQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21519-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:02:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0DA10B7D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 517C93006B5A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 04:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2775A1EFF9B;
	Mon,  9 Feb 2026 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UzT47qIc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A88469D
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770609734; cv=none; b=mGpGoOdSR2ks1Vu8ZqIAtF1c/FmYomao/CsJnt3WAjw/uRJA+BC8OiEA2g0yh3fRkpuJxoPkewBZZCIjuNeyQweJ4JVZGCmWIqxWjh5Q2SH/iyJKbl8KufVlnH6MsP++ao7ogeN+ZDvdbJtyEmPzWe3ecwkF2ctwV1AbvUeYcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770609734; c=relaxed/simple;
	bh=SZa/9UfQaN0owfBWrJ6MWqktllzbwAs76kia2EiDrzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWJK1srf/KgPxf0UNuYuGNMrP/bDs0WUDWJr5oPX+iPWB5HwciCdWO6hcrpe1NQJpy+Jc5iHlm3zyPmZgB3GrwooBNp9wvQHKvPOf4afB9jB8UL3kmNF8b5oD922cU97n3+L8WjBdSoOKMm7XuegDbtxtVl8yaAJ+aX0hEMeo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UzT47qIc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso42179925e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 20:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770609733; x=1771214533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GeWl/XpNCsumgdye4yW/lIdXLdzF5JiqZP9x4XKxjHI=;
        b=UzT47qIc5oNhvncIZrWPe6w+Sd9tgea82CVfDGzWSz78NYeON4je/on/nLh4fry83n
         6bKmYXCYIRhgsWDYVSdBSf5lQb5pp/pVmzYIWQ0nwBs7GPCRwWOhlShtJ9D9g3I5rQgL
         6tJ6HGkUP1ttN+yylLJF4XqHV/lz2wme+I7t5FF3apPkBnq/cH5WJQJcqO+IWux7Vd4p
         fBN1u6ofuVpbrb7oSB+HIg0DjTAMZaBHJGbrSrSiEJ9/GstYtWBPU8BYZ5fsP3gYEqTT
         TQg+2g5X1RnQQvxomoPr0+2LzQ/V4gUkGA4qOAjepLSLyzdDlDQeVSbT5Iwu2tLgB/6G
         kK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770609733; x=1771214533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeWl/XpNCsumgdye4yW/lIdXLdzF5JiqZP9x4XKxjHI=;
        b=oUMB3H0jPxsSRSXThgLIC5T3WzvOIdZkWjJtgZqa2ztBbfpPsSJZHueSoDwgEAq+Kw
         qIgrknYjDqsTywXdNKmCJCT3DpvK5alnnMacWMokpzL0UDAtr1tkph5JQJ1MNocVG71n
         j6tLYaicD7IqSAgEbd7bJDU/9toIBkA96CPGrF5STxbwfVg9fMQqsgUxliHDC5v6CeMk
         M5CcUkkBmDiRfhJGApgbsJMp1JDhICYcB7lL8lIZ2D21OS+6px6vXiMLiQUfwtlWxPT7
         e25HVOOIl8npni0H8bWT/+/rgW8dfX9Rof04BP/FTekmdwLLwV9lLwXSurzifAw+b6VD
         wNfw==
X-Gm-Message-State: AOJu0Ywp/Bf/Wfw5xk6CnDCSVWpRbO3EvCqaUbyeiHdLaadmGQzSEzSS
	97nglVI8B+zcaeA+bdzSwHA1korEBl6Z4eBci69XK2etrxZu314IECpoaMrr54QVogA=
X-Gm-Gg: AZuq6aKr6dqJW/g4Us8niLVjfm/vAgaJLK+0nhjj+ph+P6yz+kYn+Fbt5DurtrY3CHe
	WRtN2h6oGlaLlHm8lwJjIo1qDsfN4XCB9xL4J2u03krZBJHA+r9HTPhl2D90YVT0vxsbVhh65QR
	NCTtmbuDbtuvCZdXBBwIs8hv8XdCwX2oNHNV0fLuIc7AP8lRx09Lc/t6BS8f3dkY6McwwPnG63E
	79Ll3lpwknIxhRwYjjm6DHpi0b70Gs7P67InUxaCEGlvRwaf9w3QlNsqJmCZW6NSMjqFdV3l+4w
	gqa1n+HfV8v36LPDK3VOkzZ5nbiFFci0NtzN2XsnUT4T8qAy6SqmFU0iDZeMZd5FZQ0iFxn+Mkw
	/wSoS5cHl6B8TqJhyqLoTuazXDXNtht9iNcXo21fBMTmELUhuUWg7MDLOXKR2oX8s7ZujxbbyoW
	QrGpDjYQgO8mTbSv5PrxIH/Nf+hC1kUy6OWXJVo/A=
X-Received: by 2002:a05:600c:548e:b0:480:1e40:3d2 with SMTP id 5b1f17b1804b1-48320983bf7mr125796905e9.29.1770609732602;
        Sun, 08 Feb 2026 20:02:12 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418ccb2asm8394039b3a.58.2026.02.08.20.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 20:02:12 -0800 (PST)
Message-ID: <c8fe54d5-d088-4326-a5ec-4c9687f89902@suse.com>
Date: Mon, 9 Feb 2026 14:32:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: space_info METADATA (sub-group id 0) has 691535872 free, is not
 full // open_ctree failed: -2
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
 <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
 <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
 <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
 <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
 <572f0ac4-90f6-4c56-aa4c-2a64e365d526@suse.com>
 <52c813cf8dffe11325ce291d3f3bd41bcce21936.camel@scientia.org>
 <f094ddbb70cabd2e329615269519b1844f786629.camel@scientia.org>
 <a6d825eb-3e8c-404f-90f6-6b4e5621479d@suse.com>
 <05e63d59951cfb8612c876d5bc7fdb76b272b01c.camel@scientia.org>
 <89188b7b8b5a1f9bb64af37777aec906134ad75c.camel@scientia.org>
 <9b05f9a3-5efe-4e57-9585-a3886bb419fa@suse.com>
 <3137a2417287037a2ed52ded55fab35181254009.camel@scientia.org>
 <54b7e6a4-7a08-434c-b7e0-849d3f961de3@suse.com>
 <4aa883f597c4d12ddfb50912cc03349594d4fdd7.camel@scientia.org>
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
In-Reply-To: <4aa883f597c4d12ddfb50912cc03349594d4fdd7.camel@scientia.org>
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
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21519-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 8F0DA10B7D2
X-Rspamd-Action: no action



在 2026/2/9 14:28, Christoph Anton Mitterer 写道:
> On Mon, 2026-02-09 at 14:18 +1030, Qu Wenruo wrote:
>> I don't think the key point is the context.
>>
>> I believe the key point here is the size of the fs, which should be
>> very
>> large, so that rebuild itself will take over 30s.
> 
> That fs (where it failed) is on an 8 TB HDD (and I think it's at best
> half full)...
> 
> I did the same procedure on a significantly larger fs (20 TB HDD, ~16
> TB used)... and it worked.
> 
> Or what do you mean by size? Size in terms of bytes or in terms of
> number of files?

Mostly in bytes, but also related to how fragmented the free space is.
The more fragmented the more time it will take thus higher chance to hit 
problems.

Thanks,
Qu

> 
> 
> 
>> With that said, feel free to clear v2 cache and let the kernel to re-
>> create.
>>
>> When we want to test later, you can just go the same
>> clear_cache,space_cache=v2 mount option, as long as you didn't
>> significantly reduce the (used) size of the fs.
> 
> Okay.
> 
> 
> Thanks,
> Chris.


