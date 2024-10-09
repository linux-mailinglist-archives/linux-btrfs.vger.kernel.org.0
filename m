Return-Path: <linux-btrfs+bounces-8689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9F996BDE
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A083B281551
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF2F198E61;
	Wed,  9 Oct 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fABxu4P/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9C1917C7
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480614; cv=none; b=mU80Cr5Pao6eih3C0pH5es8vQA16GMUPAltLC+P3RKeu2vVsYQMOZtzRp1rNatYw38/fPaAucN8sjS1Dz1zhlDM1TTuu3R+VhnvpMNk1minq+WanVWIllWZtHJakn+BfGXXqLTkvJYyy55izV+sgl8hBnar0FPZdgxcF2dbSgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480614; c=relaxed/simple;
	bh=l1EOQkhxaNMEb0c23pFrQuttKWwlPFuD+SnneqwfcII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UH8+ELKkXb4+OrVzdXVMZdYjmZh104Fy+gXSduvX7HMU1UiefKDv+bB+BjGnj7AS4YYPyUwuZMnVqhjd+oviuAFMhxZ23j9Vllq9+neT4Fqna3+LAu7OOrKrANXZdrwpTdoJy5X+PGWIhsfpN7VTqwR/E0kM10uGf3Ftc6PJEbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=fABxu4P/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb18f14242so9179861fa.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1728480611; x=1729085411; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=47baqCnQCvkfvrwoy37anFk6NSMQvffBtJAu5gT3YZk=;
        b=fABxu4P/YFN39efjhg8koDiM+kWMECpSs5cDa0gpIA6hDFjrPVMYjkJmCgw5lPSn0x
         A+7B2VHHnY/EPaXl1Lg+ELBqiin9NR9GeTrZXs/ufHlZSMHX21lBInM6Jz7UtRPaCVTe
         zG6/Aew3eX/SyyiGjGoCM2SAbI3cYsvZucgxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728480611; x=1729085411;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47baqCnQCvkfvrwoy37anFk6NSMQvffBtJAu5gT3YZk=;
        b=P4YoO0th7Os9rjtHXoWv+wqpO5FnhhJdvQKvlVj1xTxt79OK9rH7lpMmajQ7Dm1Ra8
         J6L0Ku0kzk+8UwXHuFdINcVyZG4YDmKaYoxYkeWQZZZetriv1FnFbM1ztMSTvDEQfpeo
         ic36xIT2AqmpX0KaGHj8phvdCdz05QKvv3kJh+zpVO7JCczAJKNSDPhLnNywJXsupubW
         idp+ANpWQCCW8d6sITT0BySIenkddJo83tDzGzBS27uiwN877/7LnFnEuMYDtGf2HZlp
         dl+SYSqdi0DkVIdVX+JwTvagPdtDXVFxrgfX+An3xV+D13fUo2kWFCHJ9aC8NyWBP/V9
         AsoA==
X-Forwarded-Encrypted: i=1; AJvYcCUR0AupCLXO+OcBVBW8GW/PhH+ll5uRwXhGTl1SoJEWLrmJ72a7wIpJP96BPC+Kv6jgcTEOwjT65bEHWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXgkVRKVu7QMZZZs467uYqUiAY4HUZLvq78u9GEKHgj0ycIEf
	SimglB9oqjexqDKEmS+1kZGHxOyEWNuCwkS/SCitbblhsGpyv1ZfCtOOmLUSaBw=
X-Google-Smtp-Source: AGHT+IGzs8AU/VidaqWomdqq3zlWcnDvu5kW/cZXUPcR7Heq9OLcNFfOUxKuKAPf8diwyUfBEMfPRw==
X-Received: by 2002:a2e:1312:0:b0:2fa:cdac:8723 with SMTP id 38308e7fff4ca-2fb1f849b4fmr193341fa.29.1728480610830;
        Wed, 09 Oct 2024 06:30:10 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9adcb62sm14228011fa.63.2024.10.09.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:30:10 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,  Fan Ni <fan.ni@samsung.com>,
  Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Navneet Singh
 <navneet.singh@intel.com>,  Jonathan Corbet <corbet@lwn.net>,  Andrew
 Morton <akpm@linux-foundation.org>,  Dan Williams
 <dan.j.williams@intel.com>,  Davidlohr Bueso <dave@stgolabs.net>,  Alison
 Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  linux-btrfs@vger.kernel.org,
  linux-cxl@vger.kernel.org,  linux-doc@vger.kernel.org,
  nvdimm@lists.linux.dev,  linux-kernel@vger.kernel.org,  Petr Mladek
 <pmladek@suse.com>,  Steven Rostedt <rostedt@goodmis.org>,  Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,  Rasmus Villemoes
 <linux@rasmusvillemoes.dk>,  Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 02/28] printk: Add print format (%pra) for struct range
In-Reply-To: <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com> (Ira
	Weiny's message of "Mon, 07 Oct 2024 18:16:08 -0500")
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
Date: Wed, 09 Oct 2024 15:30:14 +0200
Message-ID: <871q0p5rq1.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ira Weiny <ira.weiny@intel.com> writes:

> ---
>  Documentation/core-api/printk-formats.rst | 13 ++++++++
>  lib/test_printf.c                         | 26 +++++++++++++++
>  lib/vsprintf.c                            | 55 +++++++++++++++++++++++++++----
>  3 files changed, 88 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 14e093da3ccd..03b102fc60bb 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -231,6 +231,19 @@ width of the CPU data path.
>  
>  Passed by reference.
>  
> +Struct Range
> +------------

Probably neither of those words should be capitalized.

> +
> +::
> +
> +	%pra    [range 0x0000000060000000-0x000000006fffffff]
> +	%pra    [range 0x0000000060000000]
> +
> +For printing struct range.  struct range holds an arbitrary range of u64
> +values.  If start is equal to end only 1 value is printed.
> +
> +Passed by reference.
> +
>  DMA address types dma_addr_t
>  ----------------------------
>  
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 5afdf5efc627..e3e75b6d10a0 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -432,6 +432,31 @@ struct_resource(void)
>  	     "%pR", &test_resource);
>  }
>  
> +static void __init
> +struct_range(void)
> +{
> +	struct range test_range = {
> +		.start = 0xc0ffee00ba5eba11,
> +		.end = 0xc0ffee00ba5eba11,
> +	};
> +
> +	test("[range 0xc0ffee00ba5eba11]", "%pra", &test_range);
> +
> +	test_range = (struct range) {
> +		.start = 0xc0ffee,
> +		.end = 0xba5eba11,
> +	};
> +	test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
> +	     "%pra", &test_range);
> +
> +	test_range = (struct range) {
> +		.start = 0xba5eba11,
> +		.end = 0xc0ffee,
> +	};
> +	test("[range 0x00000000ba5eba11-0x0000000000c0ffee]",
> +	     "%pra", &test_range);
> +}
> +

Thanks for including tests!

Rather than the struct assignments, I think it's easier to read if you
just do

  struct range r;

  r.start = 0xc0ffee00ba5eba11;
  r.end   = r.start;
  ...

  r.start = 0xc0ffee;
  r.end   = 0xba5eba11;
  ...

which saves two lines per test and for the first one makes it more
obvious that the start and end values are identical.

>  static void __init
>  addr(void)
>  {
> @@ -807,6 +832,7 @@ test_pointer(void)
>  	symbol_ptr();
>  	kernel_ptr();
>  	struct_resource();
> +	struct_range();
>  	addr();
>  	escaped_str();
>  	hex_string();
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 09f022ba1c05..f8f5ed8f4d39 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1039,6 +1039,19 @@ static const struct printf_spec default_dec04_spec = {
>  	.flags = ZEROPAD,
>  };
>  
> +static noinline_for_stack
> +char *hex_range(char *buf, char *end, u64 start_val, u64 end_val,
> +		struct printf_spec spec)
> +{
> +	buf = number(buf, end, start_val, spec);
> +	if (start_val != end_val) {
> +		if (buf < end)
> +			*buf++ = '-';

No. Either all your callers pass a (probably stack-allocated) buffer
which is guaranteed to be big enough, in which case you don't need the
"if (buf < end)", or if some callers may "print" directly to the buffer
passed to vsnprintf(), the buf++ must still be done unconditionally in
order that vsnprintf(NULL, 0, ...) [used by fx kasprintf] can accurately
determine how large the output string would be.

So, either

  *buf++ = '-'

or

  if (buf < end)
    *buf = '-';
  buf++;

Please don't mix the two. 



> +		buf = number(buf, end, end_val, spec);
> +	}
> +	return buf;
> +}
> +
>  static noinline_for_stack
>  char *resource_string(char *buf, char *end, struct resource *res,
>  		      struct printf_spec spec, const char *fmt)
> @@ -1115,11 +1128,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
>  		p = string_nocheck(p, pend, "size ", str_spec);
>  		p = number(p, pend, resource_size(res), *specp);
>  	} else {
> -		p = number(p, pend, res->start, *specp);
> -		if (res->start != res->end) {
> -			*p++ = '-';
> -			p = number(p, pend, res->end, *specp);
> -		}
> +		p = hex_range(p, pend, res->start, res->end, *specp);
>  	}
>  	if (decode) {
>  		if (res->flags & IORESOURCE_MEM_64)
> @@ -1140,6 +1149,34 @@ char *resource_string(char *buf, char *end, struct resource *res,
>  	return string_nocheck(buf, end, sym, spec);
>  }
>  
> +static noinline_for_stack
> +char *range_string(char *buf, char *end, const struct range *range,
> +		   struct printf_spec spec, const char *fmt)
> +{
> +#define RANGE_DECODED_BUF_SIZE		((2 * sizeof(struct range)) + 4)
> +#define RANGE_PRINT_BUF_SIZE		sizeof("[range -]")
> +	char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];

I don't think these names or the split in two constants helps
convincing that's the right amount. I have to think quite a bit to see
that 2*sizeof is because struct range has two u64 and we're printing in
hex so four-bits-per-char and probably the +4 are for two time "0x".

Why not just size the buffer directly using an "example" string?

  char sym[sizeof("[range 0x0123456789abcdef-0x0123456789abcdef]")]

> +	char *p = sym, *pend = sym + sizeof(sym);
> +
> +	struct printf_spec range_spec = {
> +		.field_width = 2 + 2 * sizeof(range->start), /* 0x + 2 * 8 */
> +		.flags = SPECIAL | SMALL | ZEROPAD,
> +		.base = 16,
> +		.precision = -1,
> +	};
> +
> +	if (check_pointer(&buf, end, range, spec))
> +		return buf;
> +
> +	*p++ = '[';
> +	p = string_nocheck(p, pend, "range ", default_str_spec);

We really should have mempcpy or stpcpy. I don't see the point of using
string_nocheck here, or not including the [ in the string copy (however
it's done). But yeah, without stpcpy() that's a bit awkward. 

Rasmus

