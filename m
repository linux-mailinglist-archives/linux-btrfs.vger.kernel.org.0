Return-Path: <linux-btrfs+bounces-9113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257CB9AD9F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 04:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D980D28366A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 02:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021ED14F12F;
	Thu, 24 Oct 2024 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaMiVMKy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6B339A0;
	Thu, 24 Oct 2024 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737075; cv=none; b=f7xzn/vQtWo5RmsFAu2GTrTlsFfa/U6ioaWA9VvS+6VscQE7l4yUuzipugbHKiX2x5JFjRaoG3vXziE62QbhWEIR4oHqTFXsJDierqP4vWA1ESxdanKv3xMmYytHrIfd9ncMgduVVG3N82UtK4vGJzuPhzSMHqgey+voQwo6yPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737075; c=relaxed/simple;
	bh=3gPDbpxeAad/3hbgmxkPBQLN7nUzwrGrc2f1U4pDXlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQrqd5MPGVLe5Qpj3fJjQKUVz4tzV2zcZ9j31tLrMkl4Vd2QDPqeF1CD2Se2ueZ8wXQAToUHQcCMgLXn2p/d+lfFshmM7iJw57ffYOVXhzP/ExGgWe/Vj6xw1LZsebLsFG6x9DHSYfwsT7CAv44wrTrbgk71opQUy9CaRkx0E24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaMiVMKy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729737072; x=1761273072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3gPDbpxeAad/3hbgmxkPBQLN7nUzwrGrc2f1U4pDXlw=;
  b=iaMiVMKy9Gqxr1tG9eQu+y1QSHUnMZDnv2Ob0nDq3BxrN6PI31Nrss2f
   VK8PJxSdqaErTzXwkudj1+6nyU8hrB7zPxpNJkijcR126lFrsPpWJDKZb
   yH7Sc85pWdZ2qJ+9toApvz+bApWikzi2tMFfUpN6erQshchdi7JOY5dLR
   EXikw46oU5KYyhC3cpP4F/0l7StHAhT2vd2lG/lJapSDqddeOnuqTmFml
   Lrsy06QRuv+zr5wc8ShfDXfU82/BIvafWyStt416QC3/0nB7Qq3bkWvC0
   MAn5B57xLhnEgdI4Al2ZeozcmtxTzTh+wEo5t2j9hKABtEB5f7MvKZkWa
   g==;
X-CSE-ConnectionGUID: PLd6+dD8QMCOYiRnWP5RWA==
X-CSE-MsgGUID: oQ/jqMGvSoaf2hEm0mqzQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28793263"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="28793263"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:31:11 -0700
X-CSE-ConnectionGUID: w4ONfiewTWeW9xcD1BYo5Q==
X-CSE-MsgGUID: g5s1ciq4Q3CG+JLPCSS5FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80114351"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.250])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:30:42 -0700
Date: Wed, 23 Oct 2024 19:30:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 20/28] cxl/core: Return endpoint decoder information
 from region search
Message-ID: <ZxmxUCGDuqeIp4TW@aschofie-mobl2.lan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-20-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-20-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:26PM -0500, Ira Weiny wrote:
> cxl_dpa_to_region() finds the region from a <DPA, device> tuple.
> The search involves finding the device endpoint decoder as well.
> 
> Dynamic capacity extent processing uses the endpoint decoder HPA
> information to calculate the HPA offset.  In addition, well behaved
> extents should be contained within an endpoint decoder.
> 
> Return the endpoint decoder found to be used in subsequent DCD code.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

BTW - I reviewed this patch when it first appeard in the DCD series
and looked for other ways to layer the delivery of cxled and cxlr.
Nothing clever appeared and looking at how DCD uses it in the 
future patch made this feel less yucky - it does want both cxled &
cxlr so it can have them here all at once ;)


snip

