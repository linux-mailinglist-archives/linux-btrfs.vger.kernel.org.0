Return-Path: <linux-btrfs+bounces-7557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22777960BAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971011F2425F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D671BF329;
	Tue, 27 Aug 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhBKY6F9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0EF1BD50A;
	Tue, 27 Aug 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764691; cv=none; b=lafksIWCYPON3LmhSKuMh5xUwOChyFein7CRE2azUMhVpUt28XFLA+a7/E9P2ekAPnn/ouMn4GQoi4S9tzG9osnE6mM87Gvd6qNb9AiohE4SZaNKSzL6I0nSvRfjVxnobqmuAblpZy+km3V8nnBivGtgZHY/8x3u4jTblQXe7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764691; c=relaxed/simple;
	bh=RCzuKTFN/faQNgu04Bbp5FM+f12nyS0HtynHkBTLOXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/YxBPVwb1+JRgJQmarlGA9aVQ7DWKpNU1SS6mScz1P3XODN2AoWxZYtuNVrPfckiizjJ/zmxrLzOgKe1Uj6lTCB8kcUQMn1i8eC9dS2wxpIRYZDXB66PAvxd72iSJCf+7ACOGlGSDWjkn22vByE4olCsTF1Qi5aPX7QvsiU/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhBKY6F9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764689; x=1756300689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCzuKTFN/faQNgu04Bbp5FM+f12nyS0HtynHkBTLOXs=;
  b=EhBKY6F9Qo5wv/1I9PpF3gcSzSb2WBdyY00Uv4hFz7fc0AC6T87rqS+t
   7lxBtK6s4PvghQ3FNLD9UNfzkLXW5SgI5gN+sJrIvJKWoHfQ9cZW3Jwve
   fLvx+aDj2Siy7zpvY/kBjIiuLkwmNHBvdeQJW25cXCbRFHKL9qN+dqfeo
   iJzWHi2DLnXvW7aZ64/XBu1epRY63T6h6n3w8cMjnIzZhwB68cLUOpgBZ
   Z2ooH2wlPdGDrwGUO6u3FwNAltgcUokGqZfl+nK0NNggisBdDpsgpaUfj
   zzuY9oSTK8dXjAOZXq9r9cY+JryIUuKdNDHLIkDvR7LXw15vlFbjsYhfh
   g==;
X-CSE-ConnectionGUID: 41BgJiuERRW/pFsjCRiaXQ==
X-CSE-MsgGUID: xPc++jevT7GeJZZfVrX9jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22832196"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="22832196"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:18:08 -0700
X-CSE-ConnectionGUID: aWjBSD9HS0qNntGcBGBgkQ==
X-CSE-MsgGUID: a54sve+dTjG+tvt3RMGuOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="100365065"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:18:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siw59-00000002Guo-3fuh;
	Tue, 27 Aug 2024 16:17:59 +0300
Date: Tue, 27 Aug 2024 16:17:59 +0300
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
Message-ID: <Zs3SB48QdLmUEdzw@smile.fi.intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
 <Zsd_EctNZ80fuKMu@smile.fi.intel.com>
 <ZsyB5rqhaZ-oRwny@pathway.suse.cz>
 <Zsy6BbJiYqiXORGu@smile.fi.intel.com>
 <66ccf10089b0_e0732294ef@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ccf10089b0_e0732294ef@iweiny-mobl.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 04:17:52PM -0500, Ira Weiny wrote:
> Andy Shevchenko wrote:
> > On Mon, Aug 26, 2024 at 03:23:50PM +0200, Petr Mladek wrote:
> > > On Thu 2024-08-22 21:10:25, Andy Shevchenko wrote:
> > > > On Thu, Aug 22, 2024 at 12:53:32PM -0500, Ira Weiny wrote:
> > > > > Petr Mladek wrote:
> > > > > > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:

...

> > > > > > > +	%par	[range 0x60000000-0x6fffffff] or
> > > > > > 
> > > > > > It seems that it is always 64-bit. It prints:
> > > > > > 
> > > > > > struct range {
> > > > > > 	u64   start;
> > > > > > 	u64   end;
> > > > > > };
> > > > > 
> > > > > Indeed.  Thanks I should not have just copied/pasted.
> > > > 
> > > > With that said, I'm not sure the %pa is a good placeholder for this ('a' stands
> > > > to "address" AFAIU). Perhaps this should go somewhere under %pr/%pR?
> 
> I'm speaking a bit for Dan here but also the logical way I thought of
> things.
> 
> 1) %p does not dictate anything about the format of the data.  Rather
>    indicates that what is passed is a pointer.  Because we are passing a
>    pointer to a range struct %pXX makes sense.

There is no objection to that.

> 2) %pa indicates what follows is 'address'.  This was a bit of creative
>    license because, as I said in the commit message most of the time
>    struct range contains an address range.  So for this narrow use case it
>    also makes sense.

As in the discussion it was pointed out that struct range is always 64-bit,
limiting it to the "address" is a wrong assumption as we are talking generic
printing routine here. We don't know what users will be in the future on 32-bit
platforms, or what data (semantically) is being held by this structure.

> 3) %par r for range.

I understand, but again struct range != address.

> %p[rR] is taken.
> %pra confuses things IMO.

It doesn't confuse me. :-) But I believe Petr also has a rationale behind this
proposal as he described earlier.

> > > The r/R in %pr/%pR actually stands for "resource".
> > > 
> > > But "%ra" really looks like a better choice than "%par". Both
> > > "resource"  and "range" starts with 'r'. Also the struct resource
> > > is printed as a range of values.
> 
> %r could be used I think.  But this breaks with the convention of passing a
> pointer and how to interpret it.  The other idea I had, mentioned in the commit
> message was %pn.  Meaning passed by pointer 'raNge'.

No, we can't use %r or anything else that is documented for the standard
printf() format specifiers, otherwise you will get a compiler warning and
basically it means no go.

> I think that follows better than %r.  That would be another break from C99.
> But we don't have to follow that.
> 
> > Fine with me as long as it:
> > 1) doesn't collide with %pa namespace
> > 2) tries to deduplicate existing code as much as possible.
> 
> Andy, I'm not quite following how you expect to share the code between
> resource_string() and range_string()?
> 
> There is very little duplicated code.  In fact with Petr's suggestions and some
> more work range_string() is quite simple:
> 
> +static noinline_for_stack
> +char *range_string(char *buf, char *end, const struct range *range,
> +                     struct printf_spec spec, const char *fmt)
> +{
> +#define RANGE_DECODED_BUF_SIZE         ((2 * sizeof(struct range)) + 4)
> +#define RANGE_PRINT_BUF_SIZE           sizeof("[range -]")
> +       char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
> +       char *p = sym, *pend = sym + sizeof(sym);


Missing check for pointer, but it's not that I wanted to tell.

> +       *p++ = '[';
> +       p = string_nocheck(p, pend, "range ", default_str_spec);

Hmm... %pr uses str_spec, what the difference can be here?

> +       p = special_hex_number(p, pend, range->start, sizeof(range->start));
> +       *p++ = '-';
> +       p = special_hex_number(p, pend, range->end, sizeof(range->end));

This is basically the copy of %pr implementation.

	p = number(p, pend, res->start, *specp);
	if (res->start != res->end) {
		*p++ = '-';
		p = number(p, pend, res->end, *specp);
	}

Would it be possible to unify? I think so, but it requires a bit of thinking.

That's why testing is very important in this kind of generic code.

> +       *p++ = ']';
> +       *p = '\0';
> +
> +       return string_nocheck(buf, end, sym, spec);
> +}
> 
> Also this is the bulk of the patch except for documentation and the new
> testing code.  [new patch below]
> 
> Am I missing your point somehow?

See above.

> I considered cramming a struct range into a
> struct resource to let resource_string() process the data.  But that would
> involve creating a new IORESOURCE_* flag (not ideal) and also does not allow
> for the larger u64 data in struct range should this be a 32 bit physical
> address config.

No, that's not what I was expecting.

> Most importantly that would not be much less code AFAICT.

...

> +       %par    [range 0x0000000060000000-0x000000006fffffff]

I still think this is not okay to use %pa namespace.

...

> +static void __init
> +struct_range(void)
> +{
> +       struct range test_range = {
> +               .start = 0xc0ffee00ba5eba11,
> +               .end = 0xc0ffee00ba5eba11,
> +       };
> +
> +       test("[range 0xc0ffee00ba5eba11-0xc0ffee00ba5eba11]",
> +            "%par", &test_range);
> +
> +       test_range = (struct range) {
> +               .start = 0xc0ffee,
> +               .end = 0xba5eba11,
> +       };
> +       test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
> +            "%par", &test_range);

Case when start == end?
Case when end < start?

> +}

...

> +       *p++ = '[';
> +       p = string_nocheck(p, pend, "range ", default_str_spec);
> +       p = special_hex_number(p, pend, range->start, sizeof(range->start));
> +       *p++ = '-';
> +       p = special_hex_number(p, pend, range->end, sizeof(range->end));
> +       *p++ = ']';
> +       *p = '\0';

As per above comments.

-- 
With Best Regards,
Andy Shevchenko



