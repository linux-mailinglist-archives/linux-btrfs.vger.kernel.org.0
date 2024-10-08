Return-Path: <linux-btrfs+bounces-8646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B05C995483
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 18:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D0C1F2636D
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F71E0DF2;
	Tue,  8 Oct 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSOUAmHI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8E1E0DBF;
	Tue,  8 Oct 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405368; cv=none; b=gv8EY77xY7nCqEN5ghFkV1YZ+p01n3t6qR5aOEGdE9sJl8dt1bpqrrF/3OqOyOL8YNJ23Thtvh0edonuhGZNQq+JRcfmj3nX0CWYyh4H7nBUhQVlEBX4lTR2npF3GNv/Vl0a+3IMuFWhFxmeFv85nSnbXDwW8vKQXtW/KkDo0Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405368; c=relaxed/simple;
	bh=oZcQukqGx5bUQm6yXcjn2BsYy0HPcJMlVrzSQquwZDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3tztvLn2XqcXukVM/CXEBVhQeG1ocfMindx/BgUsJ5F3sf7flxdiYb0OPl6kpSF46rspwH6fE8H8ApyQBI+Y1WfnWExEOdjF5mvXEysW7yberwYBziSeeMTd059GvjLmQU/bbmgYGRKAvhWDODmbq8Xv+wsFOxOz9wgu3qKh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSOUAmHI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728405367; x=1759941367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oZcQukqGx5bUQm6yXcjn2BsYy0HPcJMlVrzSQquwZDI=;
  b=RSOUAmHI5nTeUeKt8OmsF0cfS/UEx1lgozrl6Vo7DaLOfSiR1B7wLuM6
   CruhzKiGCGgLHXdB5ctYOvTSrlTVhC4EZRPcaqwXdjYJzd4zkSFS/0s26
   ZQWJY5FOqd4723l0eaCcHJICQMWKwpWz9zx35zpdnwHA40bm5D0fHBccv
   SjUAAWzYAVKy9sIUteA7OWx3FBxC7pQNxE4zbJ+xkIzMD3CXyxbqKQMgA
   Tp/rf+QEL9hJngZcVdFBdQPVU45VzLAjfUVBho0TIkc6BUVll71vKiiYM
   Ng5nLAqaNbrvRWcfZQtMG/GgBzU/fhukuJSfPZyqmWHW3nbIrvERnsNId
   A==;
X-CSE-ConnectionGUID: c9IifAZMQMGDZFnEsq3Dmg==
X-CSE-MsgGUID: T/e09TbvRXqWeHJlnXjOAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27752786"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27752786"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:35:08 -0700
X-CSE-ConnectionGUID: exbY07Q4S4ywNqgKJVohvg==
X-CSE-MsgGUID: TeIMBjbkQ5SrMCPO3QSHbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75998570"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 08 Oct 2024 09:35:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 98EB220F; Tue, 08 Oct 2024 19:35:02 +0300 (EEST)
Date: Tue, 8 Oct 2024 19:35:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
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
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 01/28] test printk: Add very basic struct resource
 tests
Message-ID: <ZwVfNpg3yuLx3W6F@black.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 07, 2024 at 06:16:07PM -0500, Ira Weiny wrote:
> The printk tests for struct resource were stubbed out.  struct range
> printing will leverage the struct resource implementation.
> 
> To prevent regression add some basic sanity tests for struct resource.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Good we start having them!

-- 
With Best Regards,
Andy Shevchenko



