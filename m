Return-Path: <linux-btrfs+bounces-21518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NDiKBhNZiWlk7QQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21518-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 04:48:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6055010B760
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 04:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 436EE3006B0C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 03:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A82765C5;
	Mon,  9 Feb 2026 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CW1tENx6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4F176FB1
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608905; cv=none; b=Nh7mQExE/P95lB9sav0mZCPoVYRUUvpMQG6af1+TikdkDS9t+9TanFcjXsvieJpBbKVxlBqziW9RlnyU04GgZlUMi4ww7rOgY2hZGaKFu6diI+cD92Q+H5WegXOFSsOSc8sYe7FuKwk/XNcz0z4K3i0x6L0LRB2WabAS53QBfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608905; c=relaxed/simple;
	bh=rCjVztGWd0QytKRX5GY2FnCA66ZdsSPTCyXqhxa5x70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DicgoLivtDzXxqEspO/n+6JMZgwQ/HSXxYYhpiEYBlE6T56qqTiWT1LQL/9PQlTSRT0yBTRF8EIpRDrhPkt/Ijb+8+VOS/zyakZNd2E/V9NoQ6L07cVTzCUmQPsAV7yi8apVhM3D3quobIyHMXUfy7kJIhInODPJyAZHKesbtao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CW1tENx6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359108fd24so2513293f8f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 19:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770608904; x=1771213704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=70FZ4uVVmtyGDkcbeubLIg+ONnDXD4WhlqD3IkSs2uM=;
        b=CW1tENx6AUqdHzf4m40zqnshqItO2rhHwbPS14Dapt03egTV2pirO0Ox6WfDXdUWhV
         OrVE9X87PJjAyb9uPiv9K+qpmdzKLti5F3pAOTEUaC9GAjzY04kuxnepR8R0zeDi9HFN
         W8Ya/dTo0yXjb4o6WXqYNkgQRyp/ArBW090Vqh2bHlMQb9u9dwWMLth4ZP/JIFrdq4x1
         lE0tAa/8LmpxWwbLUvf5iGep3zigpTzwDbhoyez/Z8mXe6FKUUWrALuJiv3RO1aXFNg3
         K4mFjBHtysZVGXDmSsXrBHHaVyuupLh1ir8D4kyih8x8YtHu1RbQaNwwY2rZxRZfN1yQ
         fhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608904; x=1771213704;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70FZ4uVVmtyGDkcbeubLIg+ONnDXD4WhlqD3IkSs2uM=;
        b=O9YIx4OrGbvovVfATtp9OeIOE07v+A4o7aTUbSidxIdTzu6Jg0aivLr19xrCF4hFJC
         COyYjuZHg6hnMvVdsuTneVYu/7kET3/9YLokRUYU5zMAv9v3GojQbckFoGXXq9ZqjhAK
         1ehSdDJXbdPx7/k4sEK/ANimjBr9COnahioAiDOGqBhi7a+0QMjbzxQD0kGvEuQGj5bL
         nRAGsihfRuHB/ddSdW/qMnYF+0WZcNl+xZFTj3sMLVly9aWM8sMj2yGteSzfrUZ1vGPE
         e30H/54r3IJg9loyCeMmWUIiD0cSl9RAT158pY/u1VuPFYOxcMMPkip6UXCDYiSZiSzE
         MWsg==
X-Gm-Message-State: AOJu0Yzi7x6fv2oAwmSUMkZq3wmX/HnQa9Wr5oqshfRRv553As6sbbOj
	qppxi8y/i1UpVX1AqnxJRLS5K13XmNhL6kYUptEG5MbasFP/+2wjDb44dH9EwWxix4yO9OZRzm+
	87Ij5VSw=
X-Gm-Gg: AZuq6aJyX6xudAq6IDz2Qea8iw/vl25nOcF35J/AcCeYgW2IHmd9QI+S112637ODm1V
	DbPB+nKUa2gTYpLWIe6PVHgbxgk0e1IlqZjHrlNpjMEvxNJADakBsqUIGhK77hGQ+4vwV61AdGX
	cLW5vu3E8gsASXvl2Cx9wBxUxHq8idS3PD3kQDyz3Vg0w3RjQk9nK2Gkw73/fNVeuZOoKv1eviv
	R8KGRtQxDkb39sm6In+B9vi7AAd95UMgzz0QlfN5FKgX2hVaMcWmE1KpAr8akurw8Izf8arsaks
	WemXUO1dHdGfggX3ZUIv0aoS4yO7oLE7h5joq3D1GmIY0DevbCR/beYDoY9eXjIvbc3dvVPjSag
	fh72IqzxM26nV9ke9iui4SbB31b+KTwB1K166e7axz7rtuKhSbRjzi/XNNPJA6qP37bjRq5F6gu
	O/HQ5WDfCUE1oK8Xemowi4w6iqgQkeRSjksYwbPF0=
X-Received: by 2002:a05:600c:4eca:b0:47e:e4ff:e2ac with SMTP id 5b1f17b1804b1-483209c557amr137477305e9.33.1770608903620;
        Sun, 08 Feb 2026 19:48:23 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166f7cesm9172214b3a.5.2026.02.08.19.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 19:48:23 -0800 (PST)
Message-ID: <54b7e6a4-7a08-434c-b7e0-849d3f961de3@suse.com>
Date: Mon, 9 Feb 2026 14:18:16 +1030
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
 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
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
In-Reply-To: <3137a2417287037a2ed52ded55fab35181254009.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21518-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 6055010B760
X-Rspamd-Action: no action



在 2026/2/9 14:02, Christoph Anton Mitterer 写道:
> On Mon, 2026-02-09 at 13:51 +1030, Qu Wenruo wrote:
>> I think you're safe to clear the v2 cache, and let the kernel create
>> at
>> mount time.
> 
> Would it help you if I keep the fs for further debugging (or later
> checking a possible fix)?

I don't think the key point is the context.

I believe the key point here is the size of the fs, which should be very 
large, so that rebuild itself will take over 30s.

With that said, feel free to clear v2 cache and let the kernel to re-create.

When we want to test later, you can just go the same 
clear_cache,space_cache=v2 mount option, as long as you didn't 
significantly reduce the (used) size of the fs.

Thanks,
Qu

> 
> If so, any rough estimate on how long that would take (cause in
> principle I would sooner or later want to use that device again for
> backups ;-) ).
> 
> 
> Thanks,
> Chris


