Return-Path: <linux-btrfs+bounces-8724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89608996E7F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D8A281619
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647E19DFA4;
	Wed,  9 Oct 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YncfTl34"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C9F197A93;
	Wed,  9 Oct 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485118; cv=none; b=CiQ2O+Uc9e4ZkNrMx0OzqTB9yEeqBzPh3uGIWPonmq7Nirv23dmuJoVJNZSMqsF6yAn0Gwd8dMK4u0BQ6JGTJPvVYQjhRHDxGFzbY+yKhxcTPCIzbkqKzVw/B4dYWio+xhXN+a5CLeBkbOs9wCFB60en5myyvWLAZ+DoOV434zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485118; c=relaxed/simple;
	bh=pcrRBcin5eVHiulaTxxDdcU8Xs3eEuCUrJpszwQGHwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B70Ie05Wz5oH5XEdM5GwYxFHxixRykYqAP3T0jm4L/QmidvJ4l3tb88BURslJWO7IcGnKDFIIqDNYdReqDPXuF2iYECHL9+S4Qe4hCxCs4jxLaW2zZK0a63H5cPPKzlhlgIeL0nwZyG8tvha9wHN79XKnN1u9JBPxHrvbg8OTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YncfTl34; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728485117; x=1760021117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pcrRBcin5eVHiulaTxxDdcU8Xs3eEuCUrJpszwQGHwQ=;
  b=YncfTl34vQCPqHctTMI3D8RmR8qoB5ph+dSs/NFDUjhF54gpSP5LWJFz
   g2l191QPRQLZ51XRPqRrlTo1DngZeVJ9xxDvJw0faTqIpDxR0Yd6S206m
   BSkf3yYzOFhfU0RAN5RTR9BbXnuDKVRrmmnYkw2iVWFERkE3i9QKf9OFc
   tqc7s/1rLfHM+IdrXO8OPvAuNXaAggld1s6dibccTHYV/QSjMHqVBSHt7
   g2lw20G5sd+ZonMb55ENymfbKfmghsMXgHNcP4pqH6vipqeFSeXnzou6G
   6jO9wjZMAstOII0C7XOSJGAOEjQZsQrzslQPVzZ0Ok91fbkbgfAZNoWUV
   A==;
X-CSE-ConnectionGUID: 0IYdgPHtSkKc+WuYj8bQyA==
X-CSE-MsgGUID: N4WZGcHATzu7Ku+63SZnQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27920804"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27920804"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:45:16 -0700
X-CSE-ConnectionGUID: xF709bT2TeWdUpwqlwL7tg==
X-CSE-MsgGUID: wIj0JS0uRPSqndpiRClpIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="77101383"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 09 Oct 2024 07:45:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 37F4D807; Wed, 09 Oct 2024 17:45:10 +0300 (EEST)
Date: Wed, 9 Oct 2024 17:45:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Sterba <dsterba@suse.cz>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
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
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 04/28] range: Add range_overlaps()
Message-ID: <ZwaW9gXuh_JzqRfh@black.fi.intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-4-c261ee6eeded@intel.com>
 <20241008161032.GB1609@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008161032.GB1609@twin.jikos.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 08, 2024 at 06:10:32PM +0200, David Sterba wrote:
> On Mon, Oct 07, 2024 at 06:16:10PM -0500, Ira Weiny wrote:

...

> > +static inline bool range_overlaps(struct range *r1, struct range *r2)
> 
> I've noticed only now, you can constify the arguments, but this applise
> to other range_* functions so that can be done later in one go.

Frankly you may add the same to each new API being added to the file and
the "one go" will never happen. So, I support your first part with
constifying, but I think it would be rather done now to start that "one
go" to happen.

-- 
With Best Regards,
Andy Shevchenko



