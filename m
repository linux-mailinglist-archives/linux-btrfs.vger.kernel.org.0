Return-Path: <linux-btrfs+bounces-17611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 562FEBCBE17
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 09:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC44E2BB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 07:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23126F2AF;
	Fri, 10 Oct 2025 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GW1oV1iL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2131991D2
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080360; cv=none; b=GNig2SufAnqqqEW4R04hd8Wsfc5rYO7J8yHTHj4HiIGuCoDkbAqx1DvtCGQaeFb8XEtefUj7dlz1CiKszzNy2Bpc6PzIS+2pTdEQbW+NH+ht+Iafovzb+BGreN2fuyu2SIcbmjhOvAUTuzpnFs+695wh//bdvVPXECzf3YVYoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080360; c=relaxed/simple;
	bh=/EML1NxmiqLJaABn0oI8+dpzuPL5H5rM0RK5pEDtEPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NtFtO3PNGAZZwgzVNsCQl3Ib2RKhL3UBGc9epkNvBOWevcotA+Vy0qjiwuIHDXXQ5sb5godUFs67sVP6xTWvY6oV1iWxsjCSuT4qa6Rn1EqlzUyDiY7QrA64cOGwztMltzxhKr7BEBuMUApdDKx4KirWY3sCbCCCOCql90ApmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GW1oV1iL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1474401f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 00:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760080357; x=1760685157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=09t/Z0SiG5F3gkEFxOcXcH1ahsMmQXGAhOFbLNlJSBk=;
        b=GW1oV1iLfqh3spkiMPWNrOYnx1LRfyn8+UV7IbHL0ErnY0y7EbUSI1T/YwIuBsSpYD
         vMtfEULH67fw1Ajq2g2RO3EBwMPkjxjqbaWgT5jfR29fSHG/JxXEOCz0YCDJLm8+GP/0
         xpYdbxcEI24YaxN/m8It1VK59CUKimw/Ey8V+tbwGu9pEnRNskntiGau4XAmhd8IXpHX
         KZE7qq9kabusShTwbjEPmvRTZptVOHH0PVdtzziOlgGqjnQr1itQm5PrSKSovFH1hs7c
         ZtayUil4GuspSHXwwAtpGQwWOv80pbj1EFoiRQIey1SCWX2KERkQvkplyrmiLthElFVn
         OX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080357; x=1760685157;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09t/Z0SiG5F3gkEFxOcXcH1ahsMmQXGAhOFbLNlJSBk=;
        b=EKlCqVCdI+UUwl6C3yPwi+Nw0ke7TX45rwgJkSJJF0sojMle5i1juCwq1Npq16X/Zz
         1SX0p71ILSBsRwhj1jmMr9jeP7hbOIjB9navwwIipX3v+X8n6/3rBBfv2dav9NRhw68W
         qy+BtVrGbfftO74guNNlqmG+nOHjkjQPYR+PyOU4qzsTqZJg3G3AphdAy6zTOg31nU27
         O3hvhmp5mTOhXiUCI8r7gTG7eyh029q6EmiR+3ud+CvkQcP6aCs7kcbGMCV74Tx1urWo
         L4jSWWbCeYL0cjQVwKfqGd5cA2g1txAMd91vY7I48e5z/XEPlwyvoSxQ2IjQwpVQ5nBW
         5RbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw9Mkbknrhlt0kjFhXrU1dCKibTr6LD4L9VjIZlo/j364+E0mFlKg++SEsapDnRfspanEN0Q+g6iRJnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HqO0WDcoRd2Dp37fwN77r0TdTwiWNmC+BSs8TlyfgbhMAV5n
	IdREJ71BwuG8qRwWXMtOOaW4UJ+FVo6PviWrIhOVmO3hMHav5eIZUDWTIdxU9e+30D6A5bDlTva
	U27n2
X-Gm-Gg: ASbGncsA+HOmaVwvqMih7CK9l6nO31S9QRudnIrMbcI6dMHp21yZrVR5LbbkHki9X2I
	UftR33kxT92gUpI56oP+6yK7jzSBuKObvpaWREaspqCjclIgUS71l7bC73Mrip4Q/8ZMlkwcJem
	z8DTZC2zSi6lcY9ttsXyR2Ns9evQQoCyZA9KpNLTeaSwhHnU8NRfQue6ZN3GjTA4WdcWQ9aauna
	SWXglTjHX8Wz5+aE7TXfOkeFVD8QSvaMCzaHQsKz6zI8AVvhdSuAXiuevRMycL4GbM90x0xikBT
	7RlE9fFMgDzsqgpQh0DIvphH+OI9MCdAyzA9Q70N7XHDjlIeIxkm/OUIq2Hk7QBgHxrrIsK1dtw
	7hv2rIbnFXmH2oaSsodo4NaxWpgkHxg8+/+0e8Qfpjk11CXWuzplFf1XB26wltadTjOZ8J00GsC
	QpOKWX
X-Google-Smtp-Source: AGHT+IEuojgz9zS5OJNzqweJXryZ9hlfCHfqKp6YJ19PzCDRkpriJvAJMicchrUgcaXpRGCTus3CUQ==
X-Received: by 2002:a05:6000:40da:b0:3f8:8aa7:465d with SMTP id ffacd0b85a97d-4266e7d4580mr6122489f8f.30.1760080356904;
        Fri, 10 Oct 2025 00:12:36 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08eb7sm47697055ad.82.2025.10.10.00.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 00:12:36 -0700 (PDT)
Message-ID: <44915bc8-9ea6-4776-9b2e-037e35b79f32@suse.com>
Date: Fri, 10 Oct 2025 17:42:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] btrfs: reject delalloc ranges if in shutdown state
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1760069261.git.wqu@suse.com>
 <4c244c7f13e63941f3c366867264c50d4392a8ed.1760069261.git.wqu@suse.com>
 <56575026-9cc0-4ca9-866b-06ec115197cb@wdc.com>
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
In-Reply-To: <56575026-9cc0-4ca9-866b-06ec115197cb@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/10 17:24, Johannes Thumshirn 写道:
> On 10/10/25 7:01 AM, Qu Wenruo wrote:
>> @@ -1286,6 +1289,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>>    	unsigned long page_ops;
>>    	int ret = 0;
>>    
>> +	if (unlikely(btrfs_is_shutdown(fs_info))) {
>> +		ret = -EIO;
>> +		goto out_unlock;
>> +	}
>> +
> 
> See below.
> 
> 
>>    	if (btrfs_is_free_space_inode(inode)) {
>>    		ret = -EINVAL;
>>    		goto out_unlock;
>> @@ -2004,7 +2012,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>>    {
>>    	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>>    	struct btrfs_root *root = inode->root;
>> -	struct btrfs_path *path;
>> +	struct btrfs_path *path = NULL;
>>    	u64 cow_start = (u64)-1;
>>    	/*
>>    	 * If not 0, represents the inclusive end of the last fallback_to_cow()
>> @@ -2034,6 +2042,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>>    	 */
>>    	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
>>    
>> +	if (unlikely(btrfs_is_shutdown(fs_info))) {
>> +		ret = -EIO;
>> +		goto error;
>> +	}
>>    	path = btrfs_alloc_path();
>>    	if (!path) {
>>    		ret = -ENOMEM;
> 
> Stupid question, going to error here will give us a error print
> (run_delalloc_nowcow failed, root= ... ). Is this intentional or would
> bailing out before allocating a path and erroring make more sense?

That error message is mostly to help debugging various leakage related 
to ordered extents.

In this shutdown case, such error message will still help, because it's 
no different than an injected error.
If later we hit some ordered extent related bugs (including the folio's 
ordered flag), such error message will show the possible involved paths.

Thanks,
Qu

> 
> That on the other hand would skip the cleanup, but if needed we can
> still extract them into a cleanup function and call them before return.
> 


