Return-Path: <linux-btrfs+bounces-1555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D7A831EC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 18:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7CAB23565
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2677D2D610;
	Thu, 18 Jan 2024 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wgJncUnU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090392C68C;
	Thu, 18 Jan 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600359; cv=none; b=TeP3dQn9Gg/LNfgCrGrzbr2hM6WjWIzw7ZUcLQwcfSfDLwk9OiCOlZ1M4YcTcsSGwUPNToOjfB2agXhNWy2vh7a6jtEgKeh7/fLxJZOhycyfwJ79siZD3fj+Tj1CfORTU6amuDIr/j2AUw7Qg3vWkxmbyBZQtYd/lKMlyOS6GjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600359; c=relaxed/simple;
	bh=KKJJ6HPqG21gZ+Co1uAQr5O3IGs7SkQEmxmkOZnVKfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YdvnfZFeivYgw7PqKkP8r1OJSvv1e9rPt4vsW3kMvjz+K/49Up3F0mxVJXOlE5tp4Yvjp6PNz9uJCOEICo6D75j9CBKHKXdTZJM24glfF/ZzHxkPcw5qSpsbV3aiUqZvxvnqfFB/ib029BXQ4R7/Z/bCWrYEKpPd2CsItzK2V6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wgJncUnU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=hGDDDdy4DJSwqpdxi3VKxYASFTzt0obR4RNDFTT72ow=; b=wgJncUnUfmNMXiR5xRJWIIeNXg
	wBOu88qbaJDezs/zSYlfZcTUWlXhv3nv3I1fvX7tVAlpiBHzZrhSE/CbZNqoVSak1UAIFgZLvKs9k
	d5oHh5hCeaIDuYlmrI5QaNjFvgiXnwViG4baMr+s/FmA98LNXq+C8YZ0KEpmhhU976FVX+oXBjuLW
	yBqqIkLVvDNrdwWfqX1vr+UBI+oypanwcmpmfdz4cqSJDn88M2GjXrAyEFiDj0kciwzzFafjG+2jk
	RDFFFCf6Sx0vfG5Jfu0Bl2m7EfkuxdYWhJQmTKxQs4YdFLn23iKb4DdnM3YTj7hp7lgUEd0/1PTHH
	1/KpAwUg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQWZ8-003R80-0C;
	Thu, 18 Jan 2024 17:52:34 +0000
Message-ID: <d91d9c20-3b17-40e4-96d0-49daecf6558e@infradead.org>
Date: Thu, 18 Jan 2024 09:52:33 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] kstrtox: introduce a safer version of memparse()
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM, ddiss@suse.de,
 geert@linux-m68k.org
References: <cover.1704422015.git.wqu@suse.com>
 <f972b96cad42e49235d90b863038a080acc0059e.1704422015.git.wqu@suse.com>
 <64def21a-2727-455b-9e35-e2a56d2f1625@infradead.org>
 <848c719c-daa2-403a-b7eb-f172b4236dc1@gmx.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <848c719c-daa2-403a-b7eb-f172b4236dc1@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/14/24 21:27, Qu Wenruo wrote:
> 
> 
> On 2024/1/15 14:57, Randy Dunlap wrote:
> [...]
>>> @@ -113,6 +113,105 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>>>       return 0;
>>>   }
>>>
>>> +/**
>>> + * memparse_safe - convert a string to an unsigned long long, safer version of
>>> + * memparse()
>>> + *
>>> + * @s:        The start of the string. Must be null-terminated.
>>
>> Unless I misunderstand, this is the biggest problem that I see with
>> memparse_safe(): "Must be null-terminated".
>> memparse() does not have that requirement.
> 
> This is just an extra safety requirement.
> 
> In reality, memparse_safe() would end at the either the first
> unsupported suffix after the valid numeric string (including '\0'),
> or won't be updated if any error is hit (either no valid string at all,
> or some overflow happened).
> 
> For most if not all call sites, the string passed in is already
> null-terminated.
> 
>>
>> And how is @retptr updated if the string is null-terminated?
> 
> E.g "123456G\0", in this case if suffix "G" is allowed, then @retptr
> would be updated to '\0'.
> 
> Or another example "123456\0", @retptr would still be updated to '\0'.
> 
>>
>> If the "Must be null-terminated." is correct, it requires that every user/caller
>> first determine the end of the number (how? space and/or any special character
>> or any alphabetic character that is not in KMGTPE? Then save that ending char,
>> change it to NUL, call memparse_safe(), then restore the saved char?
> 
> There are already test cases like "86k \0" (note all strings in the test
> case is all null terminated), which would lead to a success parse, with
> @retptr updated to ' ' (if suffix K is specified) or 'k' (if suffix K is
> not specified).
> 
> So the behavior is still the same.
> It may be my expression too confusing.
> 
> Any recommendation for the comments?

Well, "Must be null-terminated." is incorrect, so explain better where
the numeric conversion ends.

Thanks.

> 
> Thanks,
> Qu
> 
>>
>> I'm hoping that the documentation is not correct...
>>
>>> + *        The base is determined automatically, if it starts with "0x"
>>> + *        the base is 16, if it starts with "0" the base is 8, otherwise
>>> + *        the base is 10.
>>> + *        After a valid number string, there can be at most one
>>> + *        case-insensitive suffix character, specified by the @suffixes
>>> + *        parameter.
>>> + *
>>> + * @suffixes:    The suffixes which should be handled. Use logical ORed
>>> + *        memparse_suffix enum to indicate the supported suffixes.
>>> + *        The suffixes are case-insensitive, all 2 ^ 10 based.
>>> + *        Supported ones are "KMGPTE".
>>> + *        If one suffix (one of "KMGPTE") is hit but that suffix is
>>> + *        not specified in the @suffxies parameter, it ends the parse
>>> + *        normally, with @retptr pointed to the (unsupported) suffix.
>>> + *        E.g. "68k" with suffxies "M" returns 68 decimal, @retptr
>>> + *        updated to 'k'.
>>> + *
>>> + * @res:    Where to write the result.
>>> + *
>>> + * @retptr:    (output) Optional pointer to the next char after parse completes.
>>> + *
>>> + * Returns:
>>> + * * %0 if any valid numeric string can be parsed, and @retptr is updated.
>>> + * * %-EINVAL if no valid number string can be found.
>>> + * * %-ERANGE if the number overflows.
>>> + * * For negative return values, @retptr is not updated.
>>> + */
>>> +noinline int memparse_safe(const char *s, enum memparse_suffix suffixes,
>>> +               unsigned long long *res, char **retptr)
>>> +{
>>
>> Thanks.
> 

-- 
#Randy

