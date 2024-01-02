Return-Path: <linux-btrfs+bounces-1189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94446821D87
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E210CB21A74
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9D12E47;
	Tue,  2 Jan 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O1tcSs+j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ihUiKeJo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O1tcSs+j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ihUiKeJo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464011C8A;
	Tue,  2 Jan 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8987921CE8;
	Tue,  2 Jan 2024 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704205157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xw1oH03+8xSWxb6Z0KzsDNFf/QYm77f29ZK366NLK9Q=;
	b=O1tcSs+jwGAy0axqHw8fs0DX2IaNJCZWfooGX/11HgzPjsxLuSYQeFwOGasMvxMj4M60Gz
	PxPTvOIdNqgn+FW94imhXML9n+kBagOhMRk2xwZobvURzj4WeWLEtxTt6Vlc6PjyihOYdH
	PEBCg/v5CNmYpSk2NpE/iIkWaL3aa24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704205157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xw1oH03+8xSWxb6Z0KzsDNFf/QYm77f29ZK366NLK9Q=;
	b=ihUiKeJohIgFtxkpWa2CS+4ytyG4JAVjF31G7l200VRk4806Ak5QdpLoLD4dPQ6aIOv6dG
	13YoCSas95RnRHAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704205157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xw1oH03+8xSWxb6Z0KzsDNFf/QYm77f29ZK366NLK9Q=;
	b=O1tcSs+jwGAy0axqHw8fs0DX2IaNJCZWfooGX/11HgzPjsxLuSYQeFwOGasMvxMj4M60Gz
	PxPTvOIdNqgn+FW94imhXML9n+kBagOhMRk2xwZobvURzj4WeWLEtxTt6Vlc6PjyihOYdH
	PEBCg/v5CNmYpSk2NpE/iIkWaL3aa24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704205157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xw1oH03+8xSWxb6Z0KzsDNFf/QYm77f29ZK366NLK9Q=;
	b=ihUiKeJohIgFtxkpWa2CS+4ytyG4JAVjF31G7l200VRk4806Ak5QdpLoLD4dPQ6aIOv6dG
	13YoCSas95RnRHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 958EB1340C;
	Tue,  2 Jan 2024 14:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id plgqEWIblGVcXgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 02 Jan 2024 14:19:14 +0000
Date: Wed, 3 Jan 2024 01:19:08 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH v2 2/4] kstrtox: introduce a safer version of memparse()
Message-ID: <20240103011908.3a25c567@echidna>
In-Reply-To: <12f3cbc956800709b2d5e1072bd22edc5720cbae.1704168510.git.wqu@suse.com>
References: <cover.1704168510.git.wqu@suse.com>
	<12f3cbc956800709b2d5e1072bd22edc5720cbae.1704168510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O1tcSs+j;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ihUiKeJo
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -6.01
X-Rspamd-Queue-Id: 8987921CE8
X-Spam-Flag: NO

On Tue,  2 Jan 2024 14:42:12 +1030, Qu Wenruo wrote:

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
> + *		parameter.
> + *
> + * @suffixes:	The suffixes which should be parsed. Use logical ORed
> + *		memparse_suffix enum to indicate the supported suffixes.
> + *		The suffixes are case-insensive, all 2 ^ 10 based.
> + *		Supported ones are "KMGPTE".
> + *		NOTE: If one suffix out of the supported one is hit, it would
> + *		end the parse normally, with @retptr pointed to the unsupported
> + *		suffix.
> + *
> + * @res:	Where to write the result.
> + *
> + * @retptr:	(output) Optional pointer to the next char after parse completes.
> + *
> + * Return 0 if any valid numberic string can be parsed, and @retptr updated.
> + * Return -INVALID if no valid number string can be found.
> + * Return -ERANGE if the number overflows.
> + * For minus return values, @retptr would not be updated.
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

Still not a fan of the MEMPARSE_SUFFIXES_DEFAULT naming, but won't
bikeshed on that further. Looks good otherwise.
Reviewed-by: David Disseldorp <ddiss@suse.de>

