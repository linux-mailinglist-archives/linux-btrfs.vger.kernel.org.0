Return-Path: <linux-btrfs+bounces-1223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5F3823C46
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 07:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB371C21256
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6DF1DA28;
	Thu,  4 Jan 2024 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3w/lOk/B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D611CAAA;
	Thu,  4 Jan 2024 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=nm5gZuhwG89+aYkWXe70aqBaQmXxsheZZc0vTTDP7VU=; b=3w/lOk/BCWj902Chpacv/FdQqw
	1vY7lL4Q8eS22dxlxKHMnZ2z889bYifxJLGDC7xFe3WferO5QwfAmHotYQYU9Ug1nGEyp8HO0oQW7
	xYJRXgd5VzoxSd3DbY+/D1naFFBk+Pvamvy7f3NA22p4YvTsQDVOhNDKyZl/hr8L9afwIOxuvEsp8
	nAJK+2aEF6VAhVz97uSkAlkVJxWa6lR737XAdfLaUtyMaWp0m4edkGjmNUhx3S/xdApXWej21MQok
	OkGIY1RcEXmw+3/bJQzRTASvUCyTarRS+Grtz3PZ+/3CQEepzyGUeCmXIEVoexLhko7ktw/Qbk2Ww
	g6a0GjLg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLHFW-00CzYy-1e;
	Thu, 04 Jan 2024 06:30:38 +0000
Message-ID: <248554b4-a549-4e94-835c-3430403b746c@infradead.org>
Date: Wed, 3 Jan 2024 22:30:37 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] kstrtox: introduce a safer version of memparse()
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 christophe.jaillet@wanadoo.fr, andriy.shevchenko@linux.intel.com,
 David.Laight@ACULAB.COM, ddiss@suse.de, geert@linux-m68k.org
References: <cover.1704324320.git.wqu@suse.com>
 <4960b36916d55e22be08fe1689b81e0eefb47578.1704324320.git.wqu@suse.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4960b36916d55e22be08fe1689b81e0eefb47578.1704324320.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/3/24 15:27, Qu Wenruo wrote:
> [BUGS]
> Function memparse() lacks error handling:
> 
> - If no valid number string at all
>   In that case @retptr would just be updated and return value would be
>   zero.
> 
> - No overflown detection
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
> 
> - Better overflow detection
>   Both the string part and the extra left shift would have overflow
>   detection.
>   Any overflow would result -ERANGE.
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
>  lib/cmdline.c           |  5 ++-
>  lib/kstrtox.c           | 96 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d9ad21058eed..b1b6da60ea43 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -201,7 +201,13 @@ void do_exit(long error_code) __noreturn;
>  
>  extern int get_option(char **str, int *pint);
>  extern char *get_options(const char *str, int nints, int *ints);
> -extern unsigned long long memparse(const char *ptr, char **retptr);
> +
> +/*
> + * DEPRECATED, lack of any kind of error handling.
> + *
> + * Use memparse_safe() from lib/kstrtox.c instead.
> + */
> +extern __deprecated unsigned long long memparse(const char *ptr, char **retptr);
>  extern bool parse_option_str(const char *str, const char *option);
>  extern char *next_arg(char *args, char **param, char **val);
>  
> diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
> index 7fcf29a4e0de..53a1e059dd31 100644
> --- a/include/linux/kstrtox.h
> +++ b/include/linux/kstrtox.h
> @@ -9,6 +9,21 @@
>  int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
>  int __must_check _kstrtol(const char *s, unsigned int base, long *res);
>  
> +enum memparse_suffix {
> +	MEMPARSE_SUFFIX_K = 1 << 0,
> +	MEMPARSE_SUFFIX_M = 1 << 1,
> +	MEMPARSE_SUFFIX_G = 1 << 2,
> +	MEMPARSE_SUFFIX_T = 1 << 3,
> +	MEMPARSE_SUFFIX_P = 1 << 4,
> +	MEMPARSE_SUFFIX_E = 1 << 5,
> +};
> +
> +#define MEMPARSE_SUFFIXES_DEFAULT (MEMPARSE_SUFFIX_K | MEMPARSE_SUFFIX_M |\
> +				   MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T |\
> +				   MEMPARSE_SUFFIX_P)
> +
> +int __must_check memparse_safe(const char *s, enum memparse_suffix suffixes,
> +			       unsigned long long *res, char **retptr);
>  int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
>  int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
>  
> diff --git a/lib/cmdline.c b/lib/cmdline.c
> index 90ed997d9570..d379157de349 100644
> --- a/lib/cmdline.c
> +++ b/lib/cmdline.c
> @@ -139,12 +139,15 @@ char *get_options(const char *str, int nints, int *ints)
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
> + *

Extra line is not needed.

>   */
>  
>  unsigned long long memparse(const char *ptr, char **retptr)
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 41c9a499bbf3..a1e4279f52b3 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -113,6 +113,102 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  	return 0;
>  }
>  
> +/**
> + * memparse_safe - convert a string to an unsigned long long, safer version of
> + * memparse()
> + *
> + * @s:		The start of the string. Must be null-terminated.
> + *		The base would be determined automatically, if it starts with
> + *		"0x" the base would be 16, if it starts with "0" the base
> + *		would be 8, otherwise the base would be 10.
> + *		After a valid number string, there can be at most one
> + *		case-insensive suffix character, specified by the @suffixes

		case-insensitive

> + *		parameter.
> + *
> + * @suffixes:	The suffixes which should be parsed. Use logical ORed
> + *		memparse_suffix enum to indicate the supported suffixes.
> + *		The suffixes are case-insensive, all 2 ^ 10 based.

		                 case-insensitive

> + *		Supported ones are "KMGPTE".
> + *		NOTE: If one suffix out of the supported one is hit, it would

		                                         ones

> + *		end the parse normally, with @retptr pointed to the unsupported
> + *		suffix.

Could you explain (or give an example) of "to the unsupported suffix"?
This isn't clear IMO.

> + *
> + * @res:	Where to write the result.
> + *
> + * @retptr:	(output) Optional pointer to the next char after parse completes.
> + *
> + * Return 0 if any valid numberic string can be parsed, and @retptr updated.
> + * Return -INVALID if no valid number string can be found.
> + * Return -ERANGE if the number overflows.
> + * For minus return values, @retptr would not be updated.

 * Returns:
 * * %0 if any valid numeric string can be parsed, and @retptr is updated.
 * * %-EINVAL if no valid number string can be found.
 * * %-ERANGE if the number overflows.
 * * For negative return values, @retptr is not updated.


For *ALL* of the comments, I request/suggest that you change the "would be" or
"would not be" to "is" or "is not" or whatever present tense words make the
most sense.


> + */
> +noinline int memparse_safe(const char *s, enum memparse_suffix suffixes,
> +			   unsigned long long *res, char **retptr)
> +{
> +	unsigned long long value;
> +	unsigned int rv;
> +	int shift = 0;
> +	int base = 0;
> +
> +	s = _parse_integer_fixup_radix(s, &base);
> +	rv = _parse_integer(s, base, &value);
> +	if (rv & KSTRTOX_OVERFLOW)
> +		return -ERANGE;
> +	if (rv == 0)
> +		return -EINVAL;
> +
> +	s += rv;
> +	switch (*s) {
> +	case 'K':
> +	case 'k':
> +		if (!(suffixes & MEMPARSE_SUFFIX_K))
> +			break;
> +		shift = 10;
> +		break;
> +	case 'M':
> +	case 'm':
> +		if (!(suffixes & MEMPARSE_SUFFIX_M))
> +			break;
> +		shift = 20;
> +		break;
> +	case 'G':
> +	case 'g':
> +		if (!(suffixes & MEMPARSE_SUFFIX_G))
> +			break;
> +		shift = 30;
> +		break;
> +	case 'T':
> +	case 't':
> +		if (!(suffixes & MEMPARSE_SUFFIX_T))
> +			break;
> +		shift = 40;
> +		break;
> +	case 'P':
> +	case 'p':
> +		if (!(suffixes & MEMPARSE_SUFFIX_P))
> +			break;
> +		shift = 50;
> +		break;
> +	case 'E':
> +	case 'e':
> +		if (!(suffixes & MEMPARSE_SUFFIX_E))
> +			break;
> +		shift = 60;
> +		break;
> +	}
> +	if (shift) {
> +		s++;
> +		if (value >> (64 - shift))
> +			return -ERANGE;
> +		value <<= shift;
> +	}
> +	*res = value;
> +	if (retptr)
> +		*retptr = (char *)s;
> +	return 0;
> +}
> +EXPORT_SYMBOL(memparse_safe);
> +
>  /**
>   * kstrtoull - convert a string to an unsigned long long
>   * @s: The start of the string. The string must be null-terminated, and may also

Thanks.
-- 
#Randy

