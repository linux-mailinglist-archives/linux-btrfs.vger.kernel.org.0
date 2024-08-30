Return-Path: <linux-btrfs+bounces-7689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0084A965C90
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69219B23B7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ED0170854;
	Fri, 30 Aug 2024 09:21:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058816F910;
	Fri, 30 Aug 2024 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009711; cv=none; b=gJBbM01Lr8nGP/hkBtEGtXctdpqUBNgMwRWNXOJdAZc/xE9CVdddEXGo/bP/zBdODsElIUM6+aRbDFiVZESzQewKjhigVuvVxO50R2EmiQXLe/Qa9pbipZoxkxYZA0/7/MS9fqMm/PP9wmYTHrFjTsj5eKDQB0LQC8wq8Ffw8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009711; c=relaxed/simple;
	bh=w1KE5YtnyEVz+JccDJR6K2o6T6AbXIzzJ/ppMYoM4Bo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlzEaDuPOEBYjfSe8Sb9zj5Fe5FEvI10sKq/HBllPIl7cOzLRmvLJk5HHJ/IKhdKkbGM9GYFNuFDuG1PePTbx/efHxnbmSfXdpVilw9ac+3uNe9x9+/kJ3eofNikLO4bdOnnc33ks+FTym4sPgkla4mZwTQmqC/nPKqWRUlSVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwCHk2wp1z6J7qd;
	Fri, 30 Aug 2024 17:18:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B5511408F9;
	Fri, 30 Aug 2024 17:21:45 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 10:21:44 +0100
Date: Fri, 30 Aug 2024 10:21:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 18/25] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <20240830102143.000048fc@Huawei.com>
In-Reply-To: <66d0e53e9d3e9_f937b294b7@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
	<20240827141852.0000553d@Huawei.com>
	<66d0e53e9d3e9_f937b294b7@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> > > +int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> > > +{
> > > +	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> > > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > > +	struct cxl_endpoint_decoder *cxled;
> > > +	struct range hpa_range, dpa_range;
> > > +	struct cxl_region *cxlr;
> > > +
> > > +	dpa_range = (struct range) {
> > > +		.start = start_dpa,
> > > +		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> > > +	};
> > > +
> > > +	guard(rwsem_read)(&cxl_region_rwsem);
> > > +	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> > > +	if (!cxlr) {
> > > +		memdev_release_extent(mds, &dpa_range);  
> > 
> > How does this condition happen?  Perhaps a comment needed.  
> 
> Fair enough.  Proposed comment.
> 
> 	/*
> 	 * No region can happen here for a few reasons:
> 	 *
> 	 * 1) Extents were accepted and the host crashed/rebooted
> 	 *    leaving them in an accepted state.  On reboot the host
> 	 *    has not yet created a region to own them.
> 	 *
> 	 * 2) Region destruction won the race with the device releasing
> 	 *    all the extents.  Here the release will be a duplicate of
> 	 *    the one sent via region destruction.
> 	 *
> 	 * 3) The device is confused and releasing extents for which no
> 	 *    region ever existed.
> 	 *
> 	 * In all these cases make sure the device knows we are not
> 	 * using this extent.
> 	 */
> 
> Item 2 is AFAICS ok with the spec.

I'm not sure I follow 2.  Why would device be releasing extents
if we haven't given them back? We aren't supporting the mess that
is force removal.

> 
> >   
> > > +		return -ENXIO;
> > > +	}
> > > +
> > > +	calc_hpa_range(cxled, cxlr->cxlr_dax, &dpa_range, &hpa_range);
> > > +
> > > +	/* Remove region extents which overlap */
> > > +	return device_for_each_child(&cxlr->cxlr_dax->dev, &hpa_range,
> > > +				     cxlr_rm_extent);
> > > +}
> > > +
> > > +/* Callers are expected to ensure cxled has been attached to a region */
> > > +int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> > > +{
> > > +	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> > > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > > +	struct cxl_endpoint_decoder *cxled;
> > > +	struct range ed_range, ext_range;
> > > +	struct cxl_dax_region *cxlr_dax;
> > > +	struct cxled_extent *ed_extent;
> > > +	struct cxl_region *cxlr;
> > > +	struct device *dev;
> > > +
> > > +	ext_range = (struct range) {
> > > +		.start = start_dpa,
> > > +		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> > > +	};
> > > +
> > > +	guard(rwsem_read)(&cxl_region_rwsem);
> > > +	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> > > +	if (!cxlr)
> > > +		return -ENXIO;
> > > +
> > > +	cxlr_dax = cxled->cxld.region->cxlr_dax;
> > > +	dev = &cxled->cxld.dev;
> > > +	ed_range = (struct range) {
> > > +		.start = cxled->dpa_res->start,
> > > +		.end = cxled->dpa_res->end,
> > > +	};
> > > +
> > > +	dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent %par\n",
> > > +		cxled->dpa_res, &ext_range);
> > > +
> > > +	if (!range_contains(&ed_range, &ext_range)) {
> > > +		dev_err_ratelimited(dev,
> > > +				    "DC extent DPA %par (%*phC) is not fully in ED %par\n",
> > > +				    &ext_range.start, CXL_EXTENT_TAG_LEN,
> > > +				    extent->tag, &ed_range);
> > > +		return -ENXIO;
> > > +	}
> > > +
> > > +	if (extents_contain(cxlr_dax, cxled, &ext_range))  
> > 
> > This case confuses me. If the extents are already there I think we should
> > error out or at least print something as that's very wrong.  
> 
> I thought we discussed this in one of the community meetings that it would be
> ok to accept these.  We could certainly print a warning here.

A warning probably does the job of indicating that 'something' odd is going on.
A device should never resend an extent overlapping one it sent before, (assuming
no removal happened inbetween) so this should never happen, but who knows :(

> 
> In all honestly I'm wondering if these restrictions are really needed anymore.
> But at the same time I really, really, really don't think anyone has a good use
> case to have to support these cases.  So I'm keeping the code simple for now.

Fair enough.
> 
> >   
> > > +		return 0;
> > > +
> > > +	if (extents_overlap(cxlr_dax, cxled, &ext_range))
> > > +		return -ENXIO;
> > > +
> > > +	ed_extent = kzalloc(sizeof(*ed_extent), GFP_KERNEL);
> > > +	if (!ed_extent)
> > > +		return -ENOMEM;
> > > +
> > > +	ed_extent->cxled = cxled;
> > > +	ed_extent->dpa_range = ext_range;
> > > +	memcpy(ed_extent->tag, extent->tag, CXL_EXTENT_TAG_LEN);
> > > +
> > > +	dev_dbg(dev, "Add extent %par (%*phC)\n", &ed_extent->dpa_range,
> > > +		CXL_EXTENT_TAG_LEN, ed_extent->tag);
> > > +
> > > +	return cxlr_add_extent(cxlr_dax, cxled, ed_extent);
> > > +}
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index 01a447aaa1b1..f629ad7488ac 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -882,6 +882,48 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> > >  
> > > +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> > > +			       struct cxl_extent *extent)
> > > +{
> > > +	u64 start = le64_to_cpu(extent->start_dpa);
> > > +	u64 length = le64_to_cpu(extent->length);
> > > +	struct device *dev = mds->cxlds.dev;
> > > +
> > > +	struct range ext_range = (struct range){
> > > +		.start = start,
> > > +		.end = start + length - 1,
> > > +	};
> > > +
> > > +	if (le16_to_cpu(extent->shared_extn_seq) != 0) {  
> > 
> > That's not the 'main' way to tell if an extent is shared because
> > we could have a single extent (so seq == 0).
> > Should verify it's not in a DCD region that
> > is shareable to make this decision.  
> 
> Ah...  :-/
> 
> > 
> > I've lost track on the region handling so maybe you already do
> > this by not including those regions at all?  
> 
> I don't think so.
> 
> I'll add the region check.  I see now why I glossed over this though.  The
> shared nature of a DCD partition is defined in the DSMAS.
> 
> Is that correct?  Or am I missing something in the spec?

Yes. That's matches my understanding (I might also be missing something
of course :)


> > > +static int cxl_add_pending(struct cxl_memdev_state *mds)
> > > +{
> > > +	struct device *dev = mds->cxlds.dev;
> > > +	struct cxl_extent *extent;
> > > +	unsigned long index;
> > > +	unsigned long cnt = 0;
> > > +	int rc;
> > > +
> > > +	xa_for_each(&mds->pending_extents, index, extent) {
> > > +		if (validate_add_extent(mds, extent)) {  
> > 
> > 
> > Add a comment here that not accepting an extent but
> > accepting some or none means this one was rejected (I'd forgotten how
> > that bit worked)  
> 
> Ok yeah that may not be clear without reading the spec closely.
> 
> 	/*
> 	 * Any extents which are to be rejected are omitted from
> 	 * the response.  An empty response means all are
> 	 * rejected.
> 	 */

Perfect.

> 
> >   
> > > +			dev_dbg(dev, "unconsumed DC extent DPA:%#llx LEN:%#llx\n",
> > > +				le64_to_cpu(extent->start_dpa),
> > > +				le64_to_cpu(extent->length));
> > > +			xa_erase(&mds->pending_extents, index);
> > > +			kfree(extent);
> > > +			continue;
> > > +		}
> > > +		cnt++;
> > > +	}
> > > +	rc = cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
> > > +				  &mds->pending_extents, cnt);
> > > +	xa_for_each(&mds->pending_extents, index, extent) {
> > > +		xa_erase(&mds->pending_extents, index);
> > > +		kfree(extent);
> > > +	}
> > > +	return rc;
> > > +}
> > > +

> > >  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > >  				    enum cxl_event_log_type type)
> > >  {
> > > @@ -1044,9 +1287,17 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > >  		if (!nr_rec)
> > >  			break;
> > >  
> > > -		for (i = 0; i < nr_rec; i++)
> > > +		for (i = 0; i < nr_rec; i++) {
> > >  			__cxl_event_trace_record(cxlmd, type,
> > >  						 &payload->records[i]);
> > > +			if (type == CXL_EVENT_TYPE_DCD) {  
> > Bit of a deep indent so maybe flip logic?
> > 
> > Logic wise it's a bit dubious as we might want to match other
> > types in future though so up to you.  
> 
> I was thinking more along these lines.  But the rc is unneeded.  That print
> can be in the handle function.
> 
> 
> Something like this:
Looks good to me. (cut to save on scrolling!)

Jonathan

