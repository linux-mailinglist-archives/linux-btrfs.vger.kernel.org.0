Return-Path: <linux-btrfs+bounces-1443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D100C82D3A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 05:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE2C28166E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 04:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E4D2572;
	Mon, 15 Jan 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c0JshEHv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BDC23A2;
	Mon, 15 Jan 2024 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=0oUh0+cGcT+wp2cEd4U7ieZkM+ak91v7266sG9V6sGc=; b=c0JshEHvimLExKfkwXfveDR2hG
	EPtESkxXMGWYq1gLgZWSYX5DWxDdqfKYWnSi4O+2NVSDPYPvgyEvhXEuinUFfZ+xllaPXQPj93z6A
	6uHAZfo2jXCQkaZXyt8rx/o/kvcc4CZBXpP1ZFpOfPunr4U6RwPbqqj/L2Vi1HxHZXJN7gJ1MY5To
	N/1Bs9MAViwbDPI3ZHuQk6WnF/Ew6kZ0UXXzK6EdcDgW6MZtzHzt92pPS5lMAvTFUj7OZmRm0+RW9
	tSPTQUW0IjjEI2/pNfgNFklDRS7/Bu5J303jYNGgPvmtSc4O8ZfXfoma52MKXC3ROeggRQvUkyHii
	Ce4FpgeQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPEZE-007kTd-2j;
	Mon, 15 Jan 2024 04:27:20 +0000
Message-ID: <64def21a-2727-455b-9e35-e2a56d2f1625@infradead.org>
Date: Sun, 14 Jan 2024 20:27:18 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] kstrtox: introduce a safer version of memparse()
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 christophe.jaillet@wanadoo.fr, andriy.shevchenko@linux.intel.com,
 David.Laight@ACULAB.COM, ddiss@suse.de, geert@linux-m68k.org
References: <cover.1704422015.git.wqu@suse.com>
 <f972b96cad42e49235d90b863038a080acc0059e.1704422015.git.wqu@suse.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f972b96cad42e49235d90b863038a080acc0059e.1704422015.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/4/24 18:35, Qu Wenruo wrote:
> [BUGS]
> Function memparse() lacks error handling:
> 
> - If no valid number string at all
>   In that case @retptr would just be updated and return value would be
>   zero.
> 
> - No overflown detection

       overflow

>   This applies to both the number string part, and the suffixes part.
>   And since we have no way to indicate errors, we can get weird results
>   like:
> 
>   	"25E" -> 10376293541461622784 (9E)
> 
>   This is due to the fact that for "E" suffix, there is only 4 bits
>   left, and 25 with 60 bits left shift would lead to overflow.
> 
> [CAUSE]
> The root cause is already mentioned in the comments of the function, the
> usage of simple_strtoull() is the source of evil.
> Furthermore the function prototype is no good either, just returning an
> unsigned long long gives us no way to indicate an error.
> 
> [FIX]
> Due to the prototype limits, we can not have a drop-in replacement for
> memparse().
> 
> This patch can only help by introduce a new helper, memparse_safe(), and
> mark the old memparse() deprecated.
> 
> The new memparse_safe() has the following improvement:
> 
> - Invalid string detection
>   If no number string can be detected at all, -EINVAL would be returned.

                                                        is returned.

> 
> - Better overflow detection
>   Both the string part and the extra left shift would have overflow

                                                  have overflow

>   detection.
>   Any overflow would result -ERANGE.

    Any overflow results in -ERANGE.

> 
> - Safer default suffix selection
>   The helper allows the caller to choose the suffixes that they want to
>   use.
>   But only "KMGTP" are recommended by default since the "E" leaves only
>   4 bits before overflow.
>   For those callers really know what they are doing, they can still
>   manually to include all suffixes.
> 
> Due to the prototype change, callers should migrate to the new one and
> change their code and add extra error handling.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Disseldorp <ddiss@suse.de>
> ---
>  include/linux/kernel.h  |  8 +++-
>  include/linux/kstrtox.h | 15 +++++++
>  lib/cmdline.c           |  4 +-
>  lib/kstrtox.c           | 99 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 124 insertions(+), 2 deletions(-)
> 

> diff --git a/lib/cmdline.c b/lib/cmdline.c
> index 90ed997d9570..35dbb03b5592 100644
> --- a/lib/cmdline.c
> +++ b/lib/cmdline.c
> @@ -139,10 +139,12 @@ char *get_options(const char *str, int nints, int *ints)
>  EXPORT_SYMBOL(get_options);
>  
>  /**
> - *	memparse - parse a string with mem suffixes into a number
> + *	memparse - DEPRECATED, parse a string with mem suffixes into a number
>   *	@ptr: Where parse begins
>   *	@retptr: (output) Optional pointer to next char after parse completes
>   *
> + *	There is no way to handle errors, and no overflown detection and string
> + *	sanity checks.
>   *	Parses a string into a number.  The number stored at @ptr is
>   *	potentially suffixed with K, M, G, T, P, E.
>   */
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 41c9a499bbf3..375c7f0842e3 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -113,6 +113,105 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  	return 0;
>  }
>  
> +/**
> + * memparse_safe - convert a string to an unsigned long long, safer version of
> + * memparse()
> + *
> + * @s:		The start of the string. Must be null-terminated.

Unless I misunderstand, this is the biggest problem that I see with
memparse_safe(): "Must be null-terminated".
memparse() does not have that requirement.

And how is @retptr updated if the string is null-terminated?

If the "Must be null-terminated." is correct, it requires that every user/caller
first determine the end of the number (how? space and/or any special character
or any alphabetic character that is not in KMGTPE? Then save that ending char,
change it to NUL, call memparse_safe(), then restore the saved char?

I'm hoping that the documentation is not correct...

> + *		The base is determined automatically, if it starts with "0x"
> + *		the base is 16, if it starts with "0" the base is 8, otherwise
> + *		the base is 10.
> + *		After a valid number string, there can be at most one
> + *		case-insensitive suffix character, specified by the @suffixes
> + *		parameter.
> + *
> + * @suffixes:	The suffixes which should be handled. Use logical ORed
> + *		memparse_suffix enum to indicate the supported suffixes.
> + *		The suffixes are case-insensitive, all 2 ^ 10 based.
> + *		Supported ones are "KMGPTE".
> + *		If one suffix (one of "KMGPTE") is hit but that suffix is
> + *		not specified in the @suffxies parameter, it ends the parse
> + *		normally, with @retptr pointed to the (unsupported) suffix.
> + *		E.g. "68k" with suffxies "M" returns 68 decimal, @retptr
> + *		updated to 'k'.
> + *
> + * @res:	Where to write the result.
> + *
> + * @retptr:	(output) Optional pointer to the next char after parse completes.
> + *
> + * Returns:
> + * * %0 if any valid numeric string can be parsed, and @retptr is updated.
> + * * %-EINVAL if no valid number string can be found.
> + * * %-ERANGE if the number overflows.
> + * * For negative return values, @retptr is not updated.
> + */
> +noinline int memparse_safe(const char *s, enum memparse_suffix suffixes,
> +			   unsigned long long *res, char **retptr)
> +{

Thanks.
-- 
#Randy

