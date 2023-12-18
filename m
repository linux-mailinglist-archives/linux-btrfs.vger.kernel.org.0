Return-Path: <linux-btrfs+bounces-1025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F9816FE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 14:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18501F23EE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935D73480;
	Mon, 18 Dec 2023 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NjQoozoi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kRg4eUEW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NjQoozoi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kRg4eUEW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CC7207C;
	Mon, 18 Dec 2023 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F9D2222E3;
	Mon, 18 Dec 2023 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702904413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa1drJ9kvwPNwGrFYZA6AQkMFI1n+Wy4qJgVFHb+Cbc=;
	b=NjQoozoiYGmznZj/xaMaAAIEKHUAcrIjMSroVZK7V+4n99cSipFJNzSLZ0J+9dQY34DBy4
	cR18vv2eeWyaogqcGocGuv229FuwRgRMBxWNYhrJPYbJKVpbtGID7LNbboHN8uVNYkKMd0
	K6GNt10IkaBzv1CCBrQ7No1ls/iPN1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702904413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa1drJ9kvwPNwGrFYZA6AQkMFI1n+Wy4qJgVFHb+Cbc=;
	b=kRg4eUEWurPzeMFzTbcgHr7FR/DuF6I/Qz6jvgM6mZFnVq3TGT+1sUJJ6zaEPkNZY2wbBH
	p7Ybh4/B8w4g/1DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702904413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa1drJ9kvwPNwGrFYZA6AQkMFI1n+Wy4qJgVFHb+Cbc=;
	b=NjQoozoiYGmznZj/xaMaAAIEKHUAcrIjMSroVZK7V+4n99cSipFJNzSLZ0J+9dQY34DBy4
	cR18vv2eeWyaogqcGocGuv229FuwRgRMBxWNYhrJPYbJKVpbtGID7LNbboHN8uVNYkKMd0
	K6GNt10IkaBzv1CCBrQ7No1ls/iPN1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702904413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa1drJ9kvwPNwGrFYZA6AQkMFI1n+Wy4qJgVFHb+Cbc=;
	b=kRg4eUEWurPzeMFzTbcgHr7FR/DuF6I/Qz6jvgM6mZFnVq3TGT+1sUJJ6zaEPkNZY2wbBH
	p7Ybh4/B8w4g/1DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E3B4B13927;
	Mon, 18 Dec 2023 13:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id whQxH1lCgGUoVAAAn2gu4w
	(envelope-from <ddiss@suse.de>); Mon, 18 Dec 2023 13:00:09 +0000
Date: Mon, 18 Dec 2023 23:59:46 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <20231218235946.32ab7a69@echidna>
In-Reply-To: <11da10b4d07bf472cd47410db65dc0e222d61e83.1702628925.git.wqu@suse.com>
References: <cover.1702628925.git.wqu@suse.com>
 <11da10b4d07bf472cd47410db65dc0e222d61e83.1702628925.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-6.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NjQoozoi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kRg4eUEW
X-Spam-Score: -6.31
X-Rspamd-Queue-Id: 1F9D2222E3

Hi Qu,

On Fri, 15 Dec 2023 19:09:23 +1030, Qu Wenruo wrote:

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
>     The recommended suffix list is "KkMmGgTtPp", excluding the overflow
>     prone "Ee". Undermost cases there is really no need to use "E" suffix
>     anyway.
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
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  include/linux/kstrtox.h |   7 +++
>  lib/kstrtox.c           | 113 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 115 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
> index 7fcf29a4e0de..12c754152c15 100644
> --- a/include/linux/kstrtox.h
> +++ b/include/linux/kstrtox.h
> @@ -9,6 +9,13 @@
>  int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
>  int __must_check _kstrtol(const char *s, unsigned int base, long *res);
>  
> +/*
> + * The default suffix list would not include "E" since it's too easy to overflow
> + * and not much real world usage.
> + */
> +#define KSTRTOULL_SUFFIX_DEFAULT		("KkMmGgTtPp")
> +int kstrtoull_suffix(const char *s, unsigned int base, unsigned long long *res,
> +		     const char *suffixes);
>  int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
>  int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
>  
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index d586e6af5e5a..63831207dfdd 100644
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
> @@ -133,10 +142,104 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
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
> + * @suffixes: A string of acceptable suffixes, must be provided. Or caller
> + *  should use kstrtoull() directly.

The suffixes parameter seems a bit cumbersome; callers need to provide
both upper and lower cases, and unsupported characters aren't checked
for. However, I can't think of any better suggestions at this stage.

> + *
> + *
> + * Return 0 on success.
> + *
> + * Return -ERANGE on overflow or -EINVAL if invalid chars found.
> + * Return value must be checked.
> + */
> +int kstrtoull_suffix(const char *s, unsigned int base, unsigned long long *res,
> +		     const char *suffixes)
> +{
> +	unsigned long long init_value;
> +	unsigned long long final_value;
> +	char *endptr;
> +	int ret;
> +
> +	ret = _kstrtoull(s, base, &init_value, &endptr);
> +	/* Either already overflow or no number string at all. */
> +	if (ret < 0)
> +		return ret;
> +	final_value = init_value;
> +	/* No suffixes. */
> +	if (!*endptr)
> +		goto done;
> +
> +	switch (*endptr) {
> +	case 'K':
> +	case 'k':
> +		if (!strchr(suffixes, *endptr))
> +			return -EINVAL;
> +		final_value <<= 10;
> +		endptr++;
> +		break;
> +	case 'M':
> +	case 'm':
> +		if (!strchr(suffixes, *endptr))
> +			return -EINVAL;
> +		final_value <<= 20;
> +		endptr++;
> +		break;
> +	case 'G':
> +	case 'g':
> +		if (!strchr(suffixes, *endptr))
> +			return -EINVAL;
> +		final_value <<= 30;
> +		endptr++;
> +		break;
> +	case 'T':
> +	case 't':
> +		if (!strchr(suffixes, *endptr))
> +			return -EINVAL;
> +		final_value <<= 40;
> +		endptr++;
> +		break;
> +	case 'P':
> +	case 'p':
> +		if (!strchr(suffixes, *endptr))
> +			return -EINVAL;
> +		final_value <<= 50;
> +		endptr++;
> +		break;
> +	case 'E':
> +	case 'e':
> +		if (!strchr(suffixes, *endptr))
> +			return -EINVAL;
> +		final_value <<= 60;
> +		endptr++;
> +		break;
> +	}
> +	if (*endptr == '\n')

Nit: the per-case logic could be simplified to a single "shift_val = X"
if you initialise and handle !shift_val.

> +		endptr++;
> +	if (*endptr)
> +		return -EINVAL;
> +
> +	/* Overflow check. */
> +	if (final_value < init_value)
> +		return -EOVERFLOW;
> +done:
> +	*res = final_value;
> +	return 0;
> +}
> +EXPORT_SYMBOL(kstrtoull_suffix);
> +
>  /**
>   * kstrtoll - convert a string to a long long
>   * @s: The start of the string. The string must be null-terminated, and may also
> @@ -159,7 +262,7 @@ int kstrtoll(const char *s, unsigned int base, long long *res)
>  	int rv;
>  
>  	if (s[0] == '-') {
> -		rv = _kstrtoull(s + 1, base, &tmp);
> +		rv = _kstrtoull(s + 1, base, &tmp, NULL);
>  		if (rv < 0)
>  			return rv;
>  		if ((long long)-tmp > 0)



