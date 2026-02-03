Return-Path: <linux-btrfs+bounces-21308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FZmOA2ogWm3IQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21308-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 08:47:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921FD5D23
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 08:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C66903013D92
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 07:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D12C392C23;
	Tue,  3 Feb 2026 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KHTQ8W4+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7071F3B87
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770104843; cv=none; b=KFr5EI9OyUXqtBylQLd3W9ITxxEyXYZB/JMr/in1W1YFJPDViEufEX0h+6tE1fD71aOSJwSiig6SqnsFGkIAgsfpwgiuOxsCq9CpZ9IzuMRaC0O6Id+R0tfAgosyfvz01+DqTKN49keDksXpIl3sL61Wy/HEm4YwdXd+y560/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770104843; c=relaxed/simple;
	bh=F/G3N1nsEgSIGr659ZVHS9ZlFK802Lxba0/ikETcJgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qc8CPvqY3CHSXteFbDFD4tyK0vT0QZeFE23omk8MWl/vJ8G2AvyAyaFalW46uwYh1+EZQyixE0F3/9MTpAz+RaagSypF0sI4Ub2jxf2KVjhtXw1DdLDwheeEZPnvyN1/EtjuL+vF7F+ZcjTmScOC20yqYQPdsOQutGd7I6reP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KHTQ8W4+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so42413535e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Feb 2026 23:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770104840; x=1770709640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NLncjY2pbWT8KkYzmGvDYy1CNdwOdL//o8/0rdamU9U=;
        b=KHTQ8W4+EuiZqmTqL4eAfKHDXKRlSXbgTkwjY6itLdWVij/TQCZRW3xPqmazAW+kLd
         T4a5IdWAbLaacZMk9yWzq930lzE74IbzlLljbGkrjdyID17BjUsSukUlWq6sKMm2ARQ5
         CyhfxDtE2sGkeU9yeQidTfjHxnkWIU5koNS2J3e2faWZQBPuy6FbwwkVoO5l54JPcOHh
         g/hCZ5igb3Rcs6brz2acDoMYU8xbGzr+82GtZwNVhTKK0nxZbWY8RUHvcvfvCtkSWc0l
         VZJIGU8UL4UJ6L+RzCwT+Gpq83LmkYM39zIN9jDTjxpPzEjj3lfays1yLQ/iMbU0egkf
         Tx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770104840; x=1770709640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLncjY2pbWT8KkYzmGvDYy1CNdwOdL//o8/0rdamU9U=;
        b=cmK7XrZ8oi5BrUHWQrmTgNBTiRFeYJ6d3QxP+by9CGKn6REq7+AY8+NRNSh4GcIGpa
         6hRxX1RFWY9tdd/zJNIStwo/cTkhVGGxt6VKIKnijDL9e7rLQSJ5kyf7+nvpFjmYVC4k
         d3Z2ry3adSKoMjJKW7cGhSIPyCN82cfolyv9r2a+FE+1nT9WSm2xjav/hpzrDjpjImeF
         EERUl6yXwxVIVAcg2XyUpUefxCyegBOca8n4zoQh5Xcak0/8xmFtHCQk/wWBPJdLLG+y
         ANOK7k2jvk3a64pgT/ZLei+dytlrgd2Og0hxV9UJ+sZeTQS29njqRLC9js3PUOVdf9Es
         R1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4wECKnDdk0l+kbjMShzP8iKr1Tk0awPgutYCOJmcYDA2z377PQbyEdSUiPsm19F//lIbK/4n2PDnIyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XBSRYvs1Wf45nHoNpJ+czAypbIdVWQtXqNi+wb+KDOGa/0IN
	ZnPxFGmOvh7PfofjHmKzP87K/w6hpOkqBWuISiFiJahiugi1Z81zBqCQ7fEQ4cNDTuM=
X-Gm-Gg: AZuq6aKYDAOQVIatAclnuD09cp5Pofnj0nWWr37Z2KkyE3d6a7+WJNQnN2rAXXQ2d9r
	P5eMum8+V4iXUHAr/158QHtHJ5k1UzcQvkOK8tR7tN69hjzRDmhQIjYTpwHrjKnbG+kqXVzA1zi
	wDBq4LjN8fXBuAvkUwJt3TAkC5TPk4yslLmoHUP7pL5eRu1XQPG/gDFWHulmLErOdzmj9fNGD57
	EZhondNzprQyCmvOklE0Ha7MAMN4nxqgEA3RdMAyxTNkgx0/hrPtlPxNRw3tpX3BXVBA4mZPjoJ
	DEz/FEaW7CJOVpR3UPbQkmYkKhZ7HM99/5cARHFtZyHVRRASJSAuDgqhYMzWgT6RINbJpikBbC5
	fc9TH+oBvKtht9078y+EY3/2YZVedt/JFMFCLFAPuitCKxJ7YGySx453HItrO1PmTAQir+wUML9
	7LaOQGlLW8/QxVzgimfp5z1/wO+btbSFYWkbZAI40=
X-Received: by 2002:a05:600c:4507:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-482db45ea8emr170468925e9.9.1770104839803;
        Mon, 02 Feb 2026 23:47:19 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8ec56da8esm92037795ad.13.2026.02.02.23.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 23:47:19 -0800 (PST)
Message-ID: <fa4a4321-7b45-45e1-b372-9ada2ffbc8ef@suse.com>
Date: Tue, 3 Feb 2026 18:17:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: We have a space info key for a block group that doesn't exist
To: Dominique Martinet <asmadeus@codewreck.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
 <aYGeghb0lkhZhDcV@codewreck.org>
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
In-Reply-To: <aYGeghb0lkhZhDcV@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21308-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[codewreck.org,gmx.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7921FD5D23
X-Rspamd-Action: no action



在 2026/2/3 17:36, Dominique Martinet 写道:
> Hi Qu,
> 
> Qu Wenruo wrote on Wed, Nov 19, 2025 at 09:59:55AM +1030:
>>>> We have a space info key for a block group that doesn't exist
>>>
>>> So even without clearing the cache as you've proposed below, it
>>> couldn't have caused any post or future corruption, right?!
>>
>> Yep. Allocation is always happening based on a block group, such
>> orphan space info/bitmap keys won't cause the allocator to use it
>> anyway.
>>
>> So no corruption or whatever.
> 
> We're running rountine btrfsck before copying the filesystem for cloning
> in one of our tools, and I'm starting to get user reports of errors due
> to this error (we run an ancient 5.10 kernel but there hadn't been any
> such report, and now we just got two in a couple of weeks so something
> must have been backported to the stable tree...)
> 
> Anyway, I agree with your answer that it's safe to ignore, but it's not
> obvious for users to decide that, so I'd like to address this somehow.
> 
> If it's really harmless, could it be printed as info message but not
> change the btrfsck return code? (e.g. if that's the only error, return
> success)

I think it's possible to change it to a warning, not an error, but we 
are going to have proper automatic kernel in v6.20 kernel.

With that said, at least for us developers a proper error will help us 
more, and prevent further similar problems.

Trading between end users complains and future proof, I still prefer to 
keep it as an error for now.

> 
> If you think it's worth keeping as an error, would you (or someone else)
> happen to have any idea where I should start looking?

In v6.20 kernel, the first RW mount of the fs will automatically fix the 
problem.

The patch is here:

https://lore.kernel.org/linux-btrfs/f58857f1ac741bd1fb4fa2e7ec56ed87815bb1f5.1766198159.git.wqu@suse.com/

And it's already in our for-next branch, heading towards v6.20 kernel.

I will backport that fix to older LTS kernels (6.6 and 6.12 planned) so 
that even older kernel users will get their fs fixed properly.

Thanks,
Qu

> 
> 
> (Alternatively since we're not copying at the block level I guess there's
> no real need for this check in the first place, as any real corruption
> would cause IO error, and I could just forget about this... The check
> was just ported e2fsck from back when the fs was ext4...)
> 
> Thanks,


