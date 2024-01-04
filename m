Return-Path: <linux-btrfs+bounces-1225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D466823C63
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 07:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D381F2437D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D71DFE9;
	Thu,  4 Jan 2024 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkM+vHPC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1371D68D;
	Thu,  4 Jan 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=AvGkACQcr2iyTESCDfvJI1c7IEOTfjYcidY62BG+hQg=; b=qkM+vHPC1kerwfZCfHWPncWot+
	e///vE6FWI0lSMPj4VRdGerdJfi7HKBUFOJwOPff5cN+qRe+Fn/YuEG93UZ4JQ+A4YVZS57Ni6T54
	9ZJA1/XdgGUd7wrdfUctO6XCNeLlKQbclDVZrcVAFAQ2oi/bkqv3gHt4lASRwM777msflH0KwE+o+
	7KfPSp1G+HHxzk3v3amcGwtRA9BHULgaSJMHQkZLJXH+ZyHWo7JS5tYGkw/7FBYYHpcMtAFoke20g
	ATaPARG2jQyKXNymq07iJ6l0GrKQqDzm4UmNIH/4saT5UGRDLprcKaKOTDCu7gqFRRajF9AIqs1Vm
	3wJnNQaQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLHZA-00D1HE-12;
	Thu, 04 Jan 2024 06:50:56 +0000
Message-ID: <bd4f25a9-9584-42bc-bde8-b9ca82cbc1c5@infradead.org>
Date: Wed, 3 Jan 2024 22:50:55 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] kstrtox: introduce a safer version of memparse()
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM, ddiss@suse.de,
 geert@linux-m68k.org
References: <cover.1704324320.git.wqu@suse.com>
 <4960b36916d55e22be08fe1689b81e0eefb47578.1704324320.git.wqu@suse.com>
 <248554b4-a549-4e94-835c-3430403b746c@infradead.org>
 <d321160b-b895-4049-8ac6-4ff6ce5df7d4@gmx.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <d321160b-b895-4049-8ac6-4ff6ce5df7d4@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/3/24 22:42, Qu Wenruo wrote:
> 
> 
> On 2024/1/4 17:00, Randy Dunlap wrote:
>> Hi,
>>
> [...]
>>> + *        parameter.
>>> + *
>>> + * @suffixes:    The suffixes which should be parsed. Use logical ORed
>>> + *        memparse_suffix enum to indicate the supported suffixes.
>>> + *        The suffixes are case-insensive, all 2 ^ 10 based.
>>
>>                          case-insensitive
>>
>>> + *        Supported ones are "KMGPTE".
>>> + *        NOTE: If one suffix out of the supported one is hit, it would
>>
>>                                                  ones
>>
>>> + *        end the parse normally, with @retptr pointed to the unsupported
>>> + *        suffix.
>>
>> Could you explain (or give an example) of "to the unsupported suffix"?
>> This isn't clear IMO.
> 
> Oh, my bad, that sentence itself is not correct.
> 
> What I really want to say is:
> 
>  If one suffix (one of "KMGPTE") is hit but that suffix is not
>  specified in the @suffxies parameter, it would end the parse normally,
>  with @retptr pointed to the (unsupported) suffix.

(corrected ^^^)

> The example would be the "68k " case in the ok cases in the next patch.
> We have two different cases for the same "68k" string, with different
> @suffixes and different results:
> 
>     "68k ", KMGPTE -> 68 * 1024, @retptr at " ".
>     "68k ", M -> 68, @retptr at 'k'.
> 
> I don't have a better expression here unfortunately, maybe the special
> case is not even worthy explaining?
> 

No, the corrected paragraph above is good. (s/would end/ends/)

Except for one thing: the examples here terminate on a space character,
but the function kernel-doc says "null-terminated":

+/**
+ * memparse_safe - convert a string to an unsigned long long, safer version of
+ * memparse()
+ *
+ * @s:		The start of the string. Must be null-terminated.




>>
>>> + *
>>> + * @res:    Where to write the result.
>>> + *
>>> + * @retptr:    (output) Optional pointer to the next char after parse completes.
>>> + *
>>> + * Return 0 if any valid numberic string can be parsed, and @retptr updated.
>>> + * Return -INVALID if no valid number string can be found.
>>> + * Return -ERANGE if the number overflows.
>>> + * For minus return values, @retptr would not be updated.
>>
>>   * Returns:
>>   * * %0 if any valid numeric string can be parsed, and @retptr is updated.
>>   * * %-EINVAL if no valid number string can be found.
>>   * * %-ERANGE if the number overflows.
>>   * * For negative return values, @retptr is not updated.
>>
>>
>> For *ALL* of the comments, I request/suggest that you change the "would be" or
>> "would not be" to "is" or "is not" or whatever present tense words make the
>> most sense.
> 
> No problem.


-- 
#Randy

