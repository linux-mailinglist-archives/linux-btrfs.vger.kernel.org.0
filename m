Return-Path: <linux-btrfs+bounces-4734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F058BB4E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 22:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16F4283E3A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D8282E5;
	Fri,  3 May 2024 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mg7cESue"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D818EB0;
	Fri,  3 May 2024 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768393; cv=none; b=qvDWOsPj5CNZtLff7rA8C55cgStnVPGFn5CkaJLR5m51D45b/zA8yFtLRbJT5WNyc9rDG+pFXP70m3Mw8exFnq6Rirnkxaw8DagRyc/If7A07MSWqRZWdyefetzZZ4r5NvCmi2CvDz1GZU2gYAowl01Q/QXOtaA61kicDgAtsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768393; c=relaxed/simple;
	bh=xNrH/b7XdzLMDSODlqM+fBKWye1+YkW33nUfkQPiS5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N44T1Dd3VFvDlekP71eiqC/WCk4dpN95Mra3QZJzoYQ8BHhChejeHHxe3GJsZmwnF1H976iL39y8tZMGiLaiNFMI3iIGJZNtzbasYJg0FnnvXb4bH7H6NKUpALguNam6KIJbblyxQYE7zSnAnqs70TTiFZq5k+FP0EsNkJf5FP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mg7cESue; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714768392; x=1746304392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xNrH/b7XdzLMDSODlqM+fBKWye1+YkW33nUfkQPiS5g=;
  b=mg7cESueNzIvieG8QjHJs16bVLOxg88ETAAZzelhxhVuA/JxZyUZtTDj
   UVW9PEogDuBn1BgKUFSxXnEASJxQzKJNiEawx32woOBY5MvpggcCnxAOl
   ABd/as0vBOI5SYT7qA+JLb5ZPgm/VYx/UIaz7rCp97QTzyKw8NUGekuZ8
   TQf6IvddD+r9ri6VXTCn360pagsSbxW10C5BjOGjXUdL2ZvYjE+Ko7d6g
   OEE1k89AyHboCwxbcL3r4YSUSXi4zXGS86n5AMbR7uV4JRjLdxDCncLQM
   I3/KtY/xzqqG2aJwZhq6eLgNeAGDn94dNKdUiyNgXjolXU/sywLU6UYJd
   A==;
X-CSE-ConnectionGUID: I/QZLbVqS4GIXJhDMwg47w==
X-CSE-MsgGUID: JCbKB6mcRzuBtfL5qOb++w==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10751465"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10751465"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:11 -0700
X-CSE-ConnectionGUID: 4E8LX40rSHuI7uxCGNM6FA==
X-CSE-MsgGUID: Es9jDY8sTsuflYoHPbAfpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="32355696"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.82.66])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:11 -0700
Date: Fri, 3 May 2024 13:33:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <ZjVKBYhiCSWA89s0@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
 <ZhSPHvoTHl28GXt1@aschofie-mobl2>
 <6635366717079_e1f582941d@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6635366717079_e1f582941d@iweiny-mobl.notmuch>

On Fri, May 03, 2024 at 12:09:27PM -0700, Ira Weiny wrote:

snip

> 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 7d97790b893d..66b8419fd0c3 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -411,44 +411,35 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> > >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > >  	struct device *dev = &cxled->cxld.dev;
> > > -	int rc;
> > >  
> > > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> > > +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> > > +		return -EBUSY;
> > > +
> > > +	/*
> > > +	 * Check that the mode is supported by the current partition
> > > +	 * configuration
> > > +	 */
> > >  	switch (mode) {
> > >  	case CXL_DECODER_RAM:
> > > +		if (!resource_size(&cxlds->ram_res)) {
> > > +			dev_dbg(dev, "no available ram capacity\n");
> > > +			return -ENXIO;
> > > +		}
> > > +		break;
> > >  	case CXL_DECODER_PMEM:
> > > +		if (!resource_size(&cxlds->pmem_res)) {
> > > +			dev_dbg(dev, "no available pmem capacity\n");
> > > +			return -ENXIO;
> > > +		}
> > >  		break;
> > >  	default:
> > >  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> > >  		return -EINVAL;
> > >  	}
> > >  
> > 
> > delete extra line
> 
> You don't like the space following the switch?
> 
> Ira

Sorry - looks fine. Ignore my comment.


