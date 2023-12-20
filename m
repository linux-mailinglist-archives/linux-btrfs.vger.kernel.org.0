Return-Path: <linux-btrfs+bounces-1072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A9819845
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 06:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61386282479
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 05:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E61170D;
	Wed, 20 Dec 2023 05:39:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0BFBE1;
	Wed, 20 Dec 2023 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 347DD2214C;
	Wed, 20 Dec 2023 05:39:10 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1966513926;
	Wed, 20 Dec 2023 05:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HYZxLfp9gmXUIwAAn2gu4w
	(envelope-from <ddiss@suse.de>); Wed, 20 Dec 2023 05:39:06 +0000
Date: Wed, 20 Dec 2023 16:38:56 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Laight
 <David.Laight@ACULAB.COM>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <20231220163856.274f84a3@echidna>
In-Reply-To: <e042f40ea5cf7fa8251713d5bb7a485f42c5615b.1703030510.git.wqu@suse.com>
References: <cover.1703030510.git.wqu@suse.com>
	<e042f40ea5cf7fa8251713d5bb7a485f42c5615b.1703030510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 347DD2214C

On Wed, 20 Dec 2023 10:40:00 +1030, Qu Wenruo wrote:

> Just as mentioned in the comment of memparse(), the simple_stroull()
> usage can lead to overflow all by itself.
> 
> Furthermore, the suffix calculation is also super overflow prone because
> that some suffix like "E" itself would eat 60bits, leaving only 4 bits
> available.
> 
> And that suffix "E" can also lead to confusion since it's using the same
> char of hex Ox'E'.
> 
> One simple example to expose all the problem is to use memparse() on
> "25E".
> The correct value should be 28823037615171174400, but the suffix E makes
> it super simple to overflow, resulting the incorrect value
> 10376293541461622784 (9E).
> 
> So here we introduce a new helper to address the problem,
> kstrtoull_suffix():
> 
> - Enhance _kstrtoull()
>   This allow _kstrtoull() to return even if it hits an invalid char, as
>   long as the optional parameter @retptr is provided.
> 
>   If @retptr is provided, _kstrtoull() would try its best to parse the
>   valid part, and leave the remaining to be handled by the caller.
> 
>   If @retptr is not provided, the behavior is not altered.
> 
> - New kstrtoull_suffix() helper
>   This new helper utilize the new @retptr capability of _kstrtoull(),
>   and provides 2 new ability:
> 
>   * Allow certain suffixes to be chosen
>     The recommended suffix list is "KMGTP" (using the new unit_suffix
>     enum as a bitmap), excluding the overflow prone "E".
>     Undermost cases there is really no need to use "E" suffix anyway.
>     And for those who really need that exabytes suffix, they can enable
>     that suffix pretty easily.
> 
>   * Add overflow checks for the suffixes
>     If the original number string is fine, but with the extra left
>     shift overflow happens, then -EOVERFLOW is returned.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> ----
> Changelog:
> v2:
> - Use enum bitmap to describe the suffixes
>   This gets rid of the upper/lower case problem, and enum makes it
>   a little more readable.
> 
> - Fix the suffix overflow detection
> 
> - Move the left shift out of the switch block
> 
> - Remove the "done" tag
>   Since no tailing character can already be handled properly.

nit: git am puts this changelog in the commit message when applied.
Please use `git send-email --annotate` and put it next to the diffstat,
so that it gets discarded.

> ---
>  include/linux/kstrtox.h |  20 ++++++++
>  lib/kstrtox.c           | 108 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 123 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
> index 7fcf29a4e0de..edac52d18a8e 100644
> --- a/include/linux/kstrtox.h
> +++ b/include/linux/kstrtox.h
> @@ -9,6 +9,26 @@
>  int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
>  int __must_check _kstrtol(const char *s, unsigned int base, long *res);
>  
> +/*
> + * The default suffix list would not include "E" since it's too easy to overflow
> + * and not much real world usage.
> + */
> +enum unit_suffix {
> +	SUFFIX_K = (1 << 0),
> +	SUFFIX_M = (1 << 1),
> +	SUFFIX_G = (1 << 2),
> +	SUFFIX_T = (1 << 3),
> +	SUFFIX_P = (1 << 4),
> +	SUFFIX_E = (1 << 5),
> +};
> +
> +/*
> + * The default suffix list would not include "E" since it's too easy to overflow
> + * and not much real world usage.
> + */

^ this comment is a duplicate.

> +#define KSTRTOULL_SUFFIX_DEFAULT (SUFFIX_K | SUFFIX_M | SUFFIX_G | SUFFIX_T | SUFFIX_P)

I think it'd be clearer if you dropped this default and had callers
explicitly provide the desired suffix mask.

> +int kstrtoull_suffix(const char *s, unsigned int base, unsigned long long *res,
> +		     enum unit_suffix suffixes);

__must_check would be consistent with the other helpers...

>  int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
>  int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
>  
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index d586e6af5e5a..8a2fdd1e3376 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -93,7 +93,8 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
>  	return _parse_integer_limit(s, base, p, INT_MAX);
>  }
>  
> -static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
> +static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res,
> +		      char **retptr)
>  {
>  	unsigned long long _res;
>  	unsigned int rv;
> @@ -105,11 +106,19 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  	if (rv == 0)
>  		return -EINVAL;
>  	s += rv;
> -	if (*s == '\n')
> +
> +	/*
> +	 * If @retptr is provided, caller is responsible to detect
> +	 * the extra chars, otherwise we can skip one newline.
> +	 */
> +	if (!retptr && *s == '\n')
>  		s++;
> -	if (*s)
> +	if (!retptr && *s)
>  		return -EINVAL;
> +
>  	*res = _res;
> +	if (retptr)
> +		*retptr = (char *)s;
>  	return 0;
>  }
>  
> @@ -133,10 +142,99 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  {
>  	if (s[0] == '+')
>  		s++;
> -	return _kstrtoull(s, base, res);
> +	return _kstrtoull(s, base, res, NULL);
>  }
>  EXPORT_SYMBOL(kstrtoull);
>  
> +/**
> + * kstrtoull_suffix - convert a string to ull with suffixes support
> + * @s: The start of the string. The string must be null-terminated, and may also
> + *  include a single newline before its terminating null.
> + * @base: The number base to use. The maximum supported base is 16. If base is
> + *  given as 0, then the base of the string is automatically detected with the
> + *  conventional semantics - If it begins with 0x the number will be parsed as a
> + *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
> + *  parsed as an octal number. Otherwise it will be parsed as a decimal.
> + * @res: Where to write the result of the conversion on success.
> + * @suffixes: bitmap of acceptable suffixes, unknown bits would be ignored.
> + *
> + * Return 0 on success.
> + *
> + * Return -ERANGE on overflow or -EINVAL if invalid chars found.
> + * Return value must be checked.
> + */
> +int kstrtoull_suffix(const char *s, unsigned int base, unsigned long long *res,
> +		     enum unit_suffix suffixes)
> +{
> +	unsigned long long value;
> +	int shift = 0;
> +	char *endptr;
> +	int ret;
> +
> +	ret = _kstrtoull(s, base, &value, &endptr);
> +	/* Either already overflow or no number string at all. */
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (*endptr) {
> +	case 'K':
> +	case 'k':
> +		if (!(suffixes & SUFFIX_K))
> +			return -EINVAL;
> +		shift = 10;
> +		break;
> +	case 'M':
> +	case 'm':
> +		if (!(suffixes & SUFFIX_M))
> +			return -EINVAL;
> +		shift = 20;
> +		break;
> +	case 'G':
> +	case 'g':
> +		if (!(suffixes & SUFFIX_G))
> +			return -EINVAL;
> +		shift = 30;
> +		break;
> +	case 'T':
> +	case 't':
> +		if (!(suffixes & SUFFIX_T))
> +			return -EINVAL;
> +		shift = 40;
> +		break;
> +	case 'P':
> +	case 'p':
> +		if (!(suffixes & SUFFIX_P))
> +			return -EINVAL;
> +		shift = 50;
> +		break;
> +	case 'E':
> +	case 'e':
> +		if (!(suffixes & SUFFIX_E))
> +			return -EINVAL;
> +		shift = 60;
> +		break;
> +	}
> +	if (shift)
> +		endptr++;
> +	if (*endptr == '\n')
> +		endptr++;
> +	if (*endptr)
> +		return -EINVAL;
> +
> +	/*
> +	 * Overflow check.
> +	 *
> +	 * Check @shift before doing right shift, as if right shift bit is
> +	 * greater than or equal to the number of bits, the result is undefined.
> +	 */
> +	if (shift && value >> (64 - shift))
> +		return -EOVERFLOW;
> +	value <<= shift;

Might as well roll this logic in with the existing "if (shift)"
above, e.g.
	if (shift) {
		/*
		 * Overflow check...
		 */
		if (value >> (64 - shift))
			return -EOVERFLOW;
		value <<= shift;
		endptr++;
	}
	if (*endptr == '\n')
	...

> +	*res = value;
> +	return 0;
> +}
> +EXPORT_SYMBOL(kstrtoull_suffix);
> +
>  /**
>   * kstrtoll - convert a string to a long long
>   * @s: The start of the string. The string must be null-terminated, and may also
> @@ -159,7 +257,7 @@ int kstrtoll(const char *s, unsigned int base, long long *res)
>  	int rv;
>  
>  	if (s[0] == '-') {
> -		rv = _kstrtoull(s + 1, base, &tmp);
> +		rv = _kstrtoull(s + 1, base, &tmp, NULL);
>  		if (rv < 0)
>  			return rv;
>  		if ((long long)-tmp > 0)


With the above changes made, feel free to add
Reviewed-by: David Disseldorp <ddiss@suse.de>

I'll leave the review of patch 2/2 up to others, as I'm still a little
worried about sysfs trailing whitespace regressions.

