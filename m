Return-Path: <linux-btrfs+bounces-7621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709BD962945
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 15:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38A01C218AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FC6188016;
	Wed, 28 Aug 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEn+qXGe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB26F241E7;
	Wed, 28 Aug 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853036; cv=none; b=cbwZ/tq3YruktocR6MOt3GuThvTWKjadFJao81fUk2y8/L8IttpFWud1vSIBop9b1ogNXmcL9xKH2uCYB/LX86C8E1Ny9sdp3VqDrI7vg8F/iUL7EyPLdcizgGMmBfSPdEExxFdsFIXUN/obq/j40kGFocat/boCPbbcwnpt8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853036; c=relaxed/simple;
	bh=T1rGWrRBFWAIrukoKtCDRzTZ0Z/EyiwmKHPNYsl0+N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I371xligg9612MyNhQnceUP1B3r/32m4xVIGHHZsdi7xS8djJUY85AJRONPhjeUuxtYCvXpt0aoBt0q0Bp4ficfS0xeJ24DdDqgYSvZuokW5R+8jxWljQScaLn/gZd0UTRLbeOxpaDXrEPwYobd1ZLP75T47YSHa7+ObUxj/pcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEn+qXGe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724853035; x=1756389035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T1rGWrRBFWAIrukoKtCDRzTZ0Z/EyiwmKHPNYsl0+N8=;
  b=nEn+qXGeX+c/YbYdkEB0YjAhPRHz/tWITi+nBs2SuSN58ggBrZ9qc6BR
   +wmRupLcLeOubiRv0zX8QsqMn6nySS1F/RvBBAatB1vM3kE+tH953U0nU
   Y5p3cSx0W1GfmqNPe9ZfGNm9OPfWkfGXoRJ63jGqE6jQwJMKJLHo/7q09
   x2vWXfp7Sp8QbGZCjDCOSatsZzmeF2erh414uXiN3yQ1/Hu58vw4BVIt7
   3hJhwWLIaMnlkA39jAgwStS7y4H5pWUw1ynM33Zy50HJa+BCocS0GruQz
   ceXRifWPBZDxM641oUjiry6uuoDjSApvWafqxAinFJfd7FSXR0MQ/1Ket
   g==;
X-CSE-ConnectionGUID: Tfqj3+NtTfSp8QX5akIYNw==
X-CSE-MsgGUID: gxM16SfbQZaqoYmSDA3rPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="26280565"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="26280565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:50:34 -0700
X-CSE-ConnectionGUID: 35NnCYRhR7WyfmuC21zOEA==
X-CSE-MsgGUID: Gbv0dmn8SoKC/WXnq4ZaCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63560144"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:50:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjJ45-00000002f8e-1KT8;
	Wed, 28 Aug 2024 16:50:25 +0300
Date: Wed, 28 Aug 2024 16:50:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 02/25] printk: Add print format (%par) for struct range
Message-ID: <Zs8rIIKAsaMrVsCk@smile.fi.intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
 <Zsd_EctNZ80fuKMu@smile.fi.intel.com>
 <ZsyB5rqhaZ-oRwny@pathway.suse.cz>
 <Zsy6BbJiYqiXORGu@smile.fi.intel.com>
 <66ccf10089b0_e0732294ef@iweiny-mobl.notmuch>
 <Zs3SB48QdLmUEdzw@smile.fi.intel.com>
 <66cea3bf3332f_f937b29424@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cea3bf3332f_f937b29424@iweiny-mobl.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 11:12:47PM -0500, Ira Weiny wrote:
> Andy Shevchenko wrote:
> > On Mon, Aug 26, 2024 at 04:17:52PM -0500, Ira Weiny wrote:
> > > Andy Shevchenko wrote:
> > > > On Mon, Aug 26, 2024 at 03:23:50PM +0200, Petr Mladek wrote:
> > > > > On Thu 2024-08-22 21:10:25, Andy Shevchenko wrote:
> > > > > > On Thu, Aug 22, 2024 at 12:53:32PM -0500, Ira Weiny wrote:
> > > > > > > Petr Mladek wrote:
> > > > > > > > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:

[snip]

> > > +char *range_string(char *buf, char *end, const struct range *range,
> > > +                     struct printf_spec spec, const char *fmt)
> > > +{
> > > +#define RANGE_DECODED_BUF_SIZE         ((2 * sizeof(struct range)) + 4)
> > > +#define RANGE_PRINT_BUF_SIZE           sizeof("[range -]")
> > > +       char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
> > > +       char *p = sym, *pend = sym + sizeof(sym);
> > 
> > Missing check for pointer, but it's not that I wanted to tell.
> 
> No it was not missing.  It was checked in address_val() already.  However, with
> %pra I'll have to add it in.

Ah, I haven't noticed the address_val() implementation details, thanks for
elaborating!

> > > +       *p++ = '[';
> > > +       p = string_nocheck(p, pend, "range ", default_str_spec);
> > 
> > Hmm... %pr uses str_spec, what the difference can be here?
> 
> str_spec is designed for variable length strings which are used based on the
> struct resource flags.  Struct range does not vary so default_str_spec works.

Okay, makes sense.

> > > +       p = special_hex_number(p, pend, range->start, sizeof(range->start));
> > > +       *p++ = '-';
> > > +       p = special_hex_number(p, pend, range->end, sizeof(range->end));
> > 
> > This is basically the copy of %pr implementation.
> 
> Only at a very basic level.  struct resource has a variable spec while struct
> range does not.  This causes complexity to make the code the same.

Fair enough, that's why I said "as much as possible to deduplicate". If you
think this is not worth it, let's do without an additional complications then.

> > 	p = number(p, pend, res->start, *specp);
> > 	if (res->start != res->end) {
> > 		*p++ = '-';
> > 		p = number(p, pend, res->end, *specp);
> > 	}
> > 
> > Would it be possible to unify? I think so, but it requires a bit of thinking.
> 
> Not much thinking.  But the issue is that they are not close enough to justify
> the extra complexity IMHO.

Okay!

> Making the outputs match with a common function takes 13 lines of code[1]
> including the declaration of a print specification which, as this thread
> already showed, is non-trivial to understand.

> __Also__ this is currently crashing on me and I can't figure out why.
> 
> $ git diff --stat
>  lib/vsprintf.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> OTOH to force a unified output, only takes 2 lines of duplicated code.[2]  This
> is a very minor expense of duplicate code which is much easier to follow.
> 
> $ git diff --stat
>  lib/vsprintf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Yep, got it.

> > That's why testing is very important in this kind of generic code.
> 
> Yep.  But the struct resource test was stubbed out.  I've added some basic
> ones.  But there are many more variations of struct resource prints.  I'm not
> sure I've not broken them.

Yeah, so make it then separated branches for %pr and %pra. You will take the
correct argument type in each of them. There are existing examples there.

Probably an initial 'r'/'R' parsing should be moved to pointer().

> > > +       *p++ = ']';
> > > +       *p = '\0';
> > > +
> > > +       return string_nocheck(buf, end, sym, spec);
> > > +}

...

> > > +       struct range test_range = {
> > > +               .start = 0xc0ffee00ba5eba11,
> > > +               .end = 0xc0ffee00ba5eba11,
> > > +       };
> > > +
> > > +       test("[range 0xc0ffee00ba5eba11-0xc0ffee00ba5eba11]",
> > > +            "%par", &test_range);
> > > +
> > > +       test_range = (struct range) {
> > > +               .start = 0xc0ffee,
> > > +               .end = 0xba5eba11,
> > > +       };
> > > +       test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
> > > +            "%par", &test_range);
> > 
> > Case when start == end?
> 
> Yes, that is the 1st case.

Thumb up!

> > Case when end < start?
> 
> I had no intention of having the output dictated by the values.
> 
> 	test("[range 0x0000000000c0ffee-0x0000000000c0ffee]",
> and
> 	test("[range 0x00000000ba5eba11-0x0000000000c0ffee]",
> 
> ... are acceptable to me.

But it seems the %pr in the first case doesn't do range, just a single value,
which makes sense to me (and this thread proved it) to avoid needless pedantic
checking of each value. It means that at a glance you may tell start == end.
Not sure about end < start case, but the point is just let's make it mimicing
%pr behaviour.

...

> +static noinline_for_stack
> +char *hex_range(char *buf, char *end, u64 start_val, u64 end_val,
> +               struct printf_spec spec)
> +{
> +       buf = number(buf, end, start_val, spec);
> +       if (start_val != end_val) {
> +               *buf++ = '-';
> +               buf = number(buf, end, end_val, spec);
> +       }
> +       return buf;
> +}
> +
>  static noinline_for_stack
>  char *resource_string(char *buf, char *end, struct resource *res,
>                       struct printf_spec spec, const char *fmt)
> @@ -1115,11 +1127,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
>                 p = string_nocheck(p, pend, "size ", str_spec);
>                 p = number(p, pend, resource_size(res), *specp);
>         } else {
> -               p = number(p, pend, res->start, *specp);
> -               if (res->start != res->end) {
> -                       *p++ = '-';
> -                       p = number(p, pend, res->end, *specp);
> -               }
> +               p = hex_range(p, pend, res->start, res->end, *specp);
>         }
>         if (decode) {
>                 if (res->flags & IORESOURCE_MEM_64)
> @@ -1149,11 +1157,19 @@ char *range_string(char *buf, char *end, const struct range *range,
>         char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
>         char *p = sym, *pend = sym + sizeof(sym);
>  
> +       struct printf_spec range_spec = {
> +               spec.field_width = 2 + 2 * sizeof(range->start), /* 0x + 2 * u64 */
> +               spec.flags = SPECIAL | SMALL | ZEROPAD,
> +               spec.base = 16,
> +               spec.precision = -1,
> +       };

But this can be deduplicated from special_hex_number(), no?
Something like

fill_special_hex_number_spec()
{
}

special_hex_number()
{
	fill_special_hex_number_spec();
}

special_hex_range()
{
	fill_special_hex_number_spec();
}

Would it be better?

> +       if (check_pointer(&buf, end, range, spec))
> +               return buf;
> +
>         *p++ = '[';
>         p = string_nocheck(p, pend, "range ", default_str_spec);
> -       p = special_hex_number(p, pend, range->start, sizeof(range->start));
> -       *p++ = '-';
> -       p = special_hex_number(p, pend, range->end, sizeof(range->end));
> +       p = hex_range(p, pend, range->start, range->end, range_spec);
>         *p++ = ']';
>         *p = '\0';

so, can you check if with the above implemented we can actually enforce unified
format for %pr and %pra?

...

> [2] sample diff

>         p = special_hex_number(p, pend, range->start, sizeof(range->start));
> -       *p++ = '-';
> -       p = special_hex_number(p, pend, range->end, sizeof(range->end));
> +       if (range->start != range->end) {
> +               *p++ = '-';
> +               p = special_hex_number(p, pend, range->end, sizeof(range->end));
> +       }

There is a possibility to supply a callback, but it seems to me much
overcomplicated approach.

...

If we go the second way (the latter one here) can you add a comment in both
%pr/%pra code excerpts to point to each other that the format is unified
between them? It might help in the future to optimise the code if needed at
all.

-- 
With Best Regards,
Andy Shevchenko



