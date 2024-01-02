Return-Path: <linux-btrfs+bounces-1188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160CB821D83
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 15:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A844283504
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4A1429F;
	Tue,  2 Jan 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pbAkvJyh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8MIkLS4K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pbAkvJyh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8MIkLS4K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6D13AE9;
	Tue,  2 Jan 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C28121CE8;
	Tue,  2 Jan 2024 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704205031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDb2Ne+ljxvNZ4THtkSmNI9AMQQEwXoJz9dtg15FflA=;
	b=pbAkvJyhaKIJFAhpNqVqvL32F8WbWt6krQhjvtgQz5QjDIyfdbt5+xzXU72CIGJVR1N2ig
	/c67HP+74aXcGaL+tC416a9XMtyEqeHt1VCggvtM/yBte0hNIoC1cDbyWPHTMvmQsI2WPC
	nnTiSQ74EKJRKOW4GHjScENF4rNrruQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704205031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDb2Ne+ljxvNZ4THtkSmNI9AMQQEwXoJz9dtg15FflA=;
	b=8MIkLS4KSQsJJG1rYN+vhm/V0zdmpaEqKcBHiogFRaDhtBJv4A9K30NfHSXvBy1Ub0EIPB
	jpNPSzi18yY0fKCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704205031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDb2Ne+ljxvNZ4THtkSmNI9AMQQEwXoJz9dtg15FflA=;
	b=pbAkvJyhaKIJFAhpNqVqvL32F8WbWt6krQhjvtgQz5QjDIyfdbt5+xzXU72CIGJVR1N2ig
	/c67HP+74aXcGaL+tC416a9XMtyEqeHt1VCggvtM/yBte0hNIoC1cDbyWPHTMvmQsI2WPC
	nnTiSQ74EKJRKOW4GHjScENF4rNrruQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704205031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDb2Ne+ljxvNZ4THtkSmNI9AMQQEwXoJz9dtg15FflA=;
	b=8MIkLS4KSQsJJG1rYN+vhm/V0zdmpaEqKcBHiogFRaDhtBJv4A9K30NfHSXvBy1Ub0EIPB
	jpNPSzi18yY0fKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2387B1340C;
	Tue,  2 Jan 2024 14:17:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J+mFMOMalGW5XQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 02 Jan 2024 14:17:07 +0000
Date: Wed, 3 Jan 2024 01:17:00 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH v2 3/4] kstrtox: add unit tests for memparse_safe()
Message-ID: <20240103011700.222b2b5c@echidna>
In-Reply-To: <a56def269d7885840a19a57aca0169891f5f0f32.1704168510.git.wqu@suse.com>
References: <cover.1704168510.git.wqu@suse.com>
	<a56def269d7885840a19a57aca0169891f5f0f32.1704168510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue,  2 Jan 2024 14:42:13 +1030, Qu Wenruo wrote:

> The new tests cases for memparse_safe() include:
> 
> - The existing test cases for kstrtoull()
>   Including all the 3 bases (8, 10, 16), and all the ok and failure
>   cases.
>   Although there are something we need to verify specific for
>   memparse_safe():
> 
>   * @retptr and @value are not modified for failure cases
> 
>   * return value are correct for failure cases
> 
>   * @retptr is correct for the good cases
> 
> - New test cases
>   Not only testing the result value, but also the @retptr, including:
> 
>   * good cases with extra tailing chars, but without valid prefix
>     The @retptr should point to the first char after a valid string.
>     3 cases for all the 3 bases.
> 
>   * good cases with extra tailing chars, with valid prefix
>     5 cases for all the suffixes.
> 
>   * bad cases without any number but stray suffix
>     Should be rejected with -EINVAL
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  lib/test-kstrtox.c | 235 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 235 insertions(+)
> 
> diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
> index f355f67169b6..97c2f65a16cb 100644
> --- a/lib/test-kstrtox.c
> +++ b/lib/test-kstrtox.c
> @@ -268,6 +268,237 @@ static void __init test_kstrtoll_ok(void)
>  	TEST_OK(kstrtoll, long long, "%lld", test_ll_ok);
>  }
>  
> +/*
> + * The special pattern to make sure the result is not modified for error cases.
> + */
> +#define ULL_PATTERN		(0xefefefef7a7a7a7aULL)
> +#if BITS_PER_LONG == 32
> +#define POINTER_PATTERN		(0xefef7a7a7aUL)
> +#else
> +#define POINTER_PATTERN		(ULL_PATTERN)
> +#endif
> +
> +/* Want to include "E" suffix for full coverage. */
> +#define MEMPARSE_TEST_SUFFIX	(MEMPARSE_SUFFIX_K | MEMPARSE_SUFFIX_M |\
> +				 MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T |\
> +				 MEMPARSE_SUFFIX_P | MEMPARSE_SUFFIX_E)
> +
> +static void __init test_memparse_safe_fail(void)
> +{
> +	struct memparse_test_fail {
> +		const char *str;
> +		/* Expected error number, either -EINVAL or -ERANGE. */
> +		unsigned int expected_ret;
> +	};
> +	static const struct memparse_test_fail tests[] __initconst = {
> +		/* No valid string can be found at all. */
> +		{"", -EINVAL},
> +		{"\n", -EINVAL},
> +		{"\n0", -EINVAL},
> +		{"+", -EINVAL},
> +		{"-", -EINVAL},
> +
> +		/* Only hex prefix, but no valid string. */
> +		{"0x", -EINVAL},
> +		{"0X", -EINVAL},
> +
> +		/* Only hex prefix, with suffix but still no valid string. */
> +		{"0xK", -EINVAL},
> +		{"0xM", -EINVAL},
> +		{"0xG", -EINVAL},
> +
> +		/* Only hex prefix, with invalid chars. */
> +		{"0xH", -EINVAL},
> +		{"0xy", -EINVAL},
> +
> +		/*
> +		 * No support for any leading "+-" chars, even followed by a valid
> +		 * number.
> +		 */
> +		{"-0", -EINVAL},
> +		{"+0", -EINVAL},
> +		{"-1", -EINVAL},
> +		{"+1", -EINVAL},
> +
> +		/* Stray suffix would also be rejected. */
> +		{"K", -EINVAL},
> +		{"P", -EINVAL},
> +
> +		/* Overflow in the string itself*/
> +		{"18446744073709551616", -ERANGE},
> +		{"02000000000000000000000", -ERANGE},
> +		{"0x10000000000000000",	-ERANGE},
nit:                                   ^ whitespace damage
> +
> +		/*
> +		 * Good string but would overflow with suffix.
> +		 *
> +		 * Note, for "E" suffix, one should not use with hex, or "0x1E"
> +		 * would be treated as 0x1e (30 in decimal), not 0x1 and "E" suffix.
> +		 * Another reason "E" suffix is cursed.
> +		 */
> +		{"16E", -ERANGE},
> +		{"020E", -ERANGE},
> +		{"16384P", -ERANGE},
> +		{"040000P", -ERANGE},
> +		{"16777216T", -ERANGE},
> +		{"0100000000T", -ERANGE},
> +		{"17179869184G", -ERANGE},
> +		{"0200000000000G", -ERANGE},
> +		{"17592186044416M", -ERANGE},
> +		{"0400000000000000M", -ERANGE},
> +		{"18014398509481984K", -ERANGE},
> +		{"01000000000000000000K", -ERANGE},
> +	};
> +	unsigned int i;
> +
> +	for_each_test(i, tests) {
> +		const struct memparse_test_fail *t = &tests[i];
> +		unsigned long long tmp = ULL_PATTERN;
> +		char *retptr = (char *)POINTER_PATTERN;
> +		int ret;
> +
> +		ret = memparse_safe(t->str, MEMPARSE_TEST_SUFFIX, &tmp, &retptr);
> +		if (ret != t->expected_ret) {
> +			WARN(1, "str '%s', expected ret %d got %d\n", t->str,
> +			     t->expected_ret, ret);
> +			continue;
> +		}
> +		if (tmp != ULL_PATTERN)
> +			WARN(1, "str '%s' failed as expected, but result got modified",
> +			     t->str);
> +		if (retptr != (char *)POINTER_PATTERN)
> +			WARN(1, "str '%s' failed as expected, but pointer got modified",
> +			     t->str);
> +	}
> +}
> +
> +static void __init test_memparse_safe_ok(void)
> +{
> +	struct memparse_test_ok {
> +		const char *str;
> +		unsigned long long expected_value;
> +		/* How many bytes the @retptr pointer should be moved forward. */
> +		unsigned int retptr_off;
> +	};
> +	static DEFINE_TEST_OK(struct memparse_test_ok, tests) = {
> +		/*
> +		 * The same pattern of kstrtoull, just with extra @retptr
> +		 * verification.
> +		 */
> +		{"0",			0ULL,			1},
> +		{"1",			1ULL,			1},
> +		{"127",			127ULL,			3},
> +		{"128",			128ULL,			3},
> +		{"129",			129ULL,			3},
> +		{"255",			255ULL,			3},
> +		{"256",			256ULL,			3},
> +		{"257",			257ULL,			3},
> +		{"32767",		32767ULL,		5},
> +		{"32768",		32768ULL,		5},
> +		{"32769",		32769ULL,		5},
> +		{"65535",		65535ULL,		5},
> +		{"65536",		65536ULL,		5},
> +		{"65537",		65537ULL,		5},
> +		{"2147483647",		2147483647ULL,		10},
> +		{"2147483648",		2147483648ULL,		10},
> +		{"2147483649",		2147483649ULL,		10},
> +		{"4294967295",		4294967295ULL,		10},
> +		{"4294967296",		4294967296ULL,		10},
> +		{"4294967297",		4294967297ULL,		10},
> +		{"9223372036854775807",	9223372036854775807ULL,	19},
> +		{"9223372036854775808",	9223372036854775808ULL,	19},
> +		{"9223372036854775809",	9223372036854775809ULL,	19},
> +		{"18446744073709551614", 18446744073709551614ULL, 20},
> +		{"18446744073709551615", 18446744073709551615ULL, 20},
> +
> +		{"00",				00ULL,		2},
> +		{"01",				01ULL,		2},
> +		{"0177",			0177ULL,	4},
> +		{"0200",			0200ULL,	4},
> +		{"0201",			0201ULL,	4},
> +		{"0377",			0377ULL,	4},
> +		{"0400",			0400ULL,	4},
> +		{"0401",			0401ULL,	4},
> +		{"077777",			077777ULL,	6},
> +		{"0100000",			0100000ULL,	7},
> +		{"0100001",			0100001ULL,	7},
> +		{"0177777",			0177777ULL,	7},
> +		{"0200000",			0200000ULL,	7},
> +		{"0200001",			0200001ULL,	7},
> +		{"017777777777",		017777777777ULL,	12},
> +		{"020000000000",		020000000000ULL,	12},
> +		{"020000000001",		020000000001ULL,	12},
> +		{"037777777777",		037777777777ULL,	12},
> +		{"040000000000",		040000000000ULL,	12},
> +		{"040000000001",		040000000001ULL,	12},
> +		{"0777777777777777777777",	0777777777777777777777ULL, 22},
> +		{"01000000000000000000000",	01000000000000000000000ULL, 23},
> +		{"01000000000000000000001",	01000000000000000000001ULL, 23},
> +		{"01777777777777777777776",	01777777777777777777776ULL, 23},
> +		{"01777777777777777777777",	01777777777777777777777ULL, 23},
> +
> +		{"0x0",			0x0ULL,			3},
> +		{"0x1",			0x1ULL,			3},
> +		{"0x7f",		0x7fULL,		4},
> +		{"0x80",		0x80ULL,		4},
> +		{"0x81",		0x81ULL,		4},
> +		{"0xff",		0xffULL,		4},
> +		{"0x100",		0x100ULL,		5},
> +		{"0x101",		0x101ULL,		5},
> +		{"0x7fff",		0x7fffULL,		6},
> +		{"0x8000",		0x8000ULL,		6},
> +		{"0x8001",		0x8001ULL,		6},
> +		{"0xffff",		0xffffULL,		6},
> +		{"0x10000",		0x10000ULL,		7},
> +		{"0x10001",		0x10001ULL,		7},
> +		{"0x7fffffff",		0x7fffffffULL,		10},
> +		{"0x80000000",		0x80000000ULL,		10},
> +		{"0x80000001",		0x80000001ULL,		10},
> +		{"0xffffffff",		0xffffffffULL,		10},
> +		{"0x100000000",		0x100000000ULL,		11},
> +		{"0x100000001",		0x100000001ULL,		11},
> +		{"0x7fffffffffffffff",	0x7fffffffffffffffULL,	18},
> +		{"0x8000000000000000",	0x8000000000000000ULL,	18},
> +		{"0x8000000000000001",	0x8000000000000001ULL,	18},
> +		{"0xfffffffffffffffe",	0xfffffffffffffffeULL,	18},
> +		{"0xffffffffffffffff",	0xffffffffffffffffULL,	18},
> +
> +		/* Now with extra non-suffix chars to test @retptr update. */
> +		{"1q84",		1,			1},
> +		{"02o45",		2,			2},
> +		{"0xffvii",		0xff,			4},
> +
> +		/*
> +		 * Finally one suffix then tailing chars, to test the @retptr
> +		 * behavior.
> +		 */
> +		{"68k ",		69632,			3},
> +		{"8MS",			8388608,		2},
> +		{"0xaeGis",		0x2b80000000,		5},
> +		{"0xaTx",		0xa0000000000,		4},
> +		{"3E8",			0x3000000000000000,	2},

In future it'd be good to get some coverage for non-MEMPARSE_TEST_SUFFIX
use cases, e.g.:
  /* supported suffix, but not provided with @suffixes */
  {"7K", (MEMPARSE_SUFFIX_M |\
          MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T |\
          MEMPARSE_SUFFIX_P | MEMPARSE_SUFFIX_E), 7, 1},

> +	};
> +	unsigned int i;
> +
> +	for_each_test(i, tests) {
> +		const struct memparse_test_ok *t = &tests[i];
> +		unsigned long long tmp;
> +		char *retptr;
> +		int ret;
> +
> +		ret = memparse_safe(t->str, MEMPARSE_TEST_SUFFIX, &tmp, &retptr);
> +		if (ret != 0) {
> +			WARN(1, "str '%s', expected ret 0 got %d\n", t->str, ret);
> +			continue;
> +		}
> +		if (tmp != t->expected_value)
> +			WARN(1, "str '%s' incorrect result, expected %llu got %llu",
> +			     t->str, t->expected_value, tmp);
> +		if (retptr != t->str + t->retptr_off)
> +			WARN(1, "str '%s' incorrect endptr, expected %u got %zu",
> +			     t->str, t->retptr_off, retptr - t->str);
> +	}
> +}
>  static void __init test_kstrtoll_fail(void)
>  {
>  	static DEFINE_TEST_FAIL(test_ll_fail) = {
> @@ -710,6 +941,10 @@ static int __init test_kstrtox_init(void)
>  	test_kstrtoll_ok();
>  	test_kstrtoll_fail();
>  
> +	test_memparse_safe_ok();
> +	test_memparse_safe_fail();
> +
> +
nit: whitespace ^

>  	test_kstrtou64_ok();
>  	test_kstrtou64_fail();
>  	test_kstrtos64_ok();

With Geert's comments addressed:
Reviewed-by: David Disseldorp <ddiss@suse.de>

