Return-Path: <linux-btrfs+bounces-8742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE139972B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 19:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED537283B0D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F561DE4D9;
	Wed,  9 Oct 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLfaMd0h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB514A611;
	Wed,  9 Oct 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493822; cv=none; b=gEVau1y9ORiljUkC1DoZaW5fmMs7S5MbXPoQYwTWLAjp36RWzMqCfXe6sUpjwBhv2rmTM7So6j+9fvi8VehK1KnYRm2umNATubdzI54sBMrKha8fALLJymb+mudMsI8prMWJHtXicg7xc3RfyyTIKBRoxQvKtVe86n0u4YIQJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493822; c=relaxed/simple;
	bh=ji/gakLu/qIT18qKQ000acOtbeI7Zd5eSJ/x/GSUR+U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsi30tLJ7tlYCis/PFySXKaFiotNBYwKe4utb8YYPtBUTNHaL7JEmKQR0ucqMw3AkCzEzlvft6uRlxYG2w7ozWrB1IyB3Zd3r1/TAivxjLdv8KJoMxODI7XyZuZI8r7bpYtrAteF6SUPSwjfLdp1jIpJG01aBPmQ3zR/7Eo87ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLfaMd0h; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso5783108276.1;
        Wed, 09 Oct 2024 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728493819; x=1729098619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Chk44cch0ltIQeofSD5CiqT4vY5iO0SSNHIRHVLIjtY=;
        b=mLfaMd0hG3R3vhSB6pTMtWZ6XeKphKalAMq4K+uHdc8B2fBt2tqjh5QILz9k3wqrWd
         1bhTwZ2Ufxmaavuyh6dPZwXA9Ohf/ODVerz7ippB6anY37LsZHUhREsq96vWdD2SQN+U
         2E1QowxkB8zhtCv6UDFP0qj3g6RaPmm8xxhJtEVn9lJdZZ7E24zoFkugB4OA8gZBkAz2
         z8k1ri6dQz8vy7nbS9KgjFIuLVend3i7tdU1wFU3hVMJZBkT8p+VXA/Nz0b/Wsm97+EO
         FRDTMe8s6RKsT5AjTURRMlF/GF8KYkPj70mT9eV1rZzeGhEZDQofrb2MbQ2VYa2Imi6r
         vCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493819; x=1729098619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chk44cch0ltIQeofSD5CiqT4vY5iO0SSNHIRHVLIjtY=;
        b=v16owEesMfiTHnTDpzuggyRgd8+5lZD3xDRKPW+CMCVSaSQCb4wJiBwuep3YxauR8I
         Aquw7JUL/Hnfjn/YogWmkLQrtRmb0yjyA+8wMR7S+Ogn8WVDLSWvnqiqs+HcAMruKzUf
         t1EqtNKG713ZyXdaEBwaa/E+q4V/CwYgnDaoF/O7JvTjOFE/W2OFDXEKJOIjotdiJeeZ
         0VKS+QG7UPyazNSm5m4e63IJVjgui0PV9iW3s1K+QU80ia+4eVX4HwvI163BzS/npdjq
         AJ0oWXB3ySQl/sYcuhQpmfd2y8QT70C9m2Zm5f68smwZtv1/lkjB5NQb7rCnVKvyW1MQ
         5gtw==
X-Forwarded-Encrypted: i=1; AJvYcCUNdrX+lWORyPT4XbuDoavndh1Tgdn/IcX/0v0zlkDUoHNgG/kqe85FXt3QdKmWxuVp9/4tpWzM+QTZ@vger.kernel.org, AJvYcCUpE1RdgjdAiL56IxiGKom9m87sS5r0cozFiBnAbJ3qy/2Ez9Bh0EhucVO01fMMKItTuoGr719NKT0S@vger.kernel.org, AJvYcCVzBq2KPwXk9nmXrqHnhamZB1+gDVmX1R3sVWleMeuDl4n/Xq6iIpqcUaxxBk8v0PKujdMHhW4ACQnRZQ==@vger.kernel.org, AJvYcCVzO7c+SlpwWubV31w6PG5+ZefypCNscmpKE7HmP95E9gv/KgyaCkSLF9QMD2kAUAb0euLx6Juca0jllRGh@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjYMdtBooP3nfdk74osaZv8Fzu31K5JfL+KEeWNPXiQV4qZoT
	T4dp4qtQNFbR32n8vw9h5kfiMuYq9EdhFkN2ArwT+qV4ra/RxXBp
X-Google-Smtp-Source: AGHT+IE3r5HC98b7ltN7b94kiIbfr65zeIie3Egdm+UMr/y40gIfmJ3yDynf8CUNg4QQRZxCtnDuuw==
X-Received: by 2002:a25:fc12:0:b0:e28:fee0:e971 with SMTP id 3f1490d57ef6-e28fee0eae8mr2393108276.22.1728493818638;
        Wed, 09 Oct 2024 10:10:18 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5dbd3a7sm1828233276.63.2024.10.09.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:10:18 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 9 Oct 2024 10:09:41 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 01/28] test printk: Add very basic struct resource
 tests
Message-ID: <Zwa41SFUfDH0LCPJ@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-1-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-1-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:07PM -0500, Ira Weiny wrote:
> The printk tests for struct resource were stubbed out.  struct range
> printing will leverage the struct resource implementation.
> 
> To prevent regression add some basic sanity tests for struct resource.
> 
> To: Petr Mladek <pmladek@suse.com>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> To: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>

> 
> ---
> [lkp: ensure phys_addr_t is within limits for all arch's]
> ---
>  lib/test_printf.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 8448b6d02bd9..5afdf5efc627 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -386,6 +386,50 @@ kernel_ptr(void)
>  static void __init
>  struct_resource(void)
>  {
> +	struct resource test_resource = {
> +		.start = 0xc0ffee00,
> +		.end = 0xc0ffee00,
> +		.flags = IORESOURCE_MEM,
> +	};
> +
> +	test("[mem 0xc0ffee00 flags 0x200]",
> +	     "%pr", &test_resource);
> +
> +	test_resource = (struct resource) {
> +		.start = 0xc0ffee,
> +		.end = 0xba5eba11,
> +		.flags = IORESOURCE_MEM,
> +	};
> +	test("[mem 0x00c0ffee-0xba5eba11 flags 0x200]",
> +	     "%pr", &test_resource);
> +
> +	test_resource = (struct resource) {
> +		.start = 0xba5eba11,
> +		.end = 0xc0ffee,
> +		.flags = IORESOURCE_MEM,
> +	};
> +	test("[mem 0xba5eba11-0x00c0ffee flags 0x200]",
> +	     "%pr", &test_resource);
> +
> +	test_resource = (struct resource) {
> +		.start = 0xba5eba11,
> +		.end = 0xba5eca11,
> +		.flags = IORESOURCE_MEM,
> +	};
> +
> +	test("[mem 0xba5eba11-0xba5eca11 flags 0x200]",
> +	     "%pr", &test_resource);
> +
> +	test_resource = (struct resource) {
> +		.start = 0xba11,
> +		.end = 0xca10,
> +		.flags = IORESOURCE_IO |
> +			 IORESOURCE_DISABLED |
> +			 IORESOURCE_UNSET,
> +	};
> +
> +	test("[io  size 0x1000 disabled]",
> +	     "%pR", &test_resource);
>  }
>  
>  static void __init
> 
> -- 
> 2.46.0
> 

-- 
Fan Ni

