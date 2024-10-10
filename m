Return-Path: <linux-btrfs+bounces-8794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED422998AAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 16:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B22C1C245FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25E41F4736;
	Thu, 10 Oct 2024 14:50:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB941CCB2A;
	Thu, 10 Oct 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571825; cv=none; b=TlnVL3EQP5y3GEcxhCZ030tj/Afon6+gVhP8EWhHs1d7iLWqLkkRJEo4+prlANEiUnH5yZaug1uN9kXbCs/qMBiw5nq8JJV80QDewUWgLYjGoG1+7Xzek8+NO8fHmupfP1KCa0FkdQU9dQGOFv2ueOWKgsAlAFDwQJkpX/730Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571825; c=relaxed/simple;
	bh=zTZrKpc3++acJH71wcSToxcmBGqF9xoved3uUzneqK0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPLBKU5s3AK9IJod/E9js/1fjg2ot92Qm3yG4I6gipzMaPXd27g4fdI6XTxiL5jQLI5gh3L5tqbmxwB01vAn/M7UdRFgd08obWTVeVxpb4hz9G5jAl8vUKg1hcgqp/zdxKCYSglAvTIcxBuQ2LqpPFSCgQINIyOS8DcOHrmxUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPXh76qqKz6J6Lx;
	Thu, 10 Oct 2024 22:48:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2257D140A78;
	Thu, 10 Oct 2024 22:50:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 16:50:15 +0200
Date: Thu, 10 Oct 2024 15:50:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: "Li, Ming4" <ming4.li@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Fan
 Ni" <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <20241010155014.00004bdd@Huawei.com>
In-Reply-To: <6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
	<4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
	<6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 14:49:09 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Li, Ming4 wrote:
> > On 10/8/2024 7:16 AM, ira.weiny@intel.com wrote:  
> > > From: Navneet Singh <navneet.singh@intel.com>
> > >  
> 
> [snip]
> 
> > >
> > > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >  
> > Hi Ira,
> > 
> > I guess you missed my comments for V3, I comment it again for this patch.  
> 
> Apologies.  Yes I totally missed your reply.  :-(
> 
> >   
> > > +static bool extents_contain(struct cxl_dax_region *cxlr_dax,
> > > +			    struct cxl_endpoint_decoder *cxled,
> > > +			    struct range *new_range)
> > > +{
> > > +	struct device *extent_device;
> > > +	struct match_data md = {
> > > +		.cxled = cxled,
> > > +		.new_range = new_range,
> > > +	};
> > > +
> > > +	extent_device = device_find_child(&cxlr_dax->dev, &md, match_contains);
> > > +	if (!extent_device)
> > > +		return false;
> > > +
> > > +	put_device(extent_device);  
> > could use __free(put_device) to drop this 'put_device(extent_device)'  
> 
> Yep.
> 
> > > +	return true;
> > > +}  
> > [...]  
> > > +static bool extents_overlap(struct cxl_dax_region *cxlr_dax,
> > > +			    struct cxl_endpoint_decoder *cxled,
> > > +			    struct range *new_range)
> > > +{
> > > +	struct device *extent_device;
> > > +	struct match_data md = {
> > > +		.cxled = cxled,
> > > +		.new_range = new_range,
> > > +	};
> > > +
> > > +	extent_device = device_find_child(&cxlr_dax->dev, &md, match_overlaps);
> > > +	if (!extent_device)
> > > +		return false;
> > > +
> > > +	put_device(extent_device);  
> > Same as above.  
> 
> Done.
> 
> > > +	return true;
> > > +}
> > > +  
> > [...]  
> > > +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> > > +				struct xarray *extent_array, int cnt)
> > > +{
> > > +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> > > +	struct cxl_mbox_dc_response *p;
> > > +	struct cxl_mbox_cmd mbox_cmd;
> > > +	struct cxl_extent *extent;
> > > +	unsigned long index;
> > > +	u32 pl_index;
> > > +	int rc;
> > > +
> > > +	size_t pl_size = struct_size(p, extent_list, cnt);
> > > +	u32 max_extents = cnt;
> > > +
> > > +	/* May have to use more bit on response. */
> > > +	if (pl_size > cxl_mbox->payload_size) {
> > > +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
> > > +			      sizeof(struct updated_extent_list);
> > > +		pl_size = struct_size(p, extent_list, max_extents);
> > > +	}
> > > +
> > > +	struct cxl_mbox_dc_response *response __free(kfree) =
> > > +						kzalloc(pl_size, GFP_KERNEL);
> > > +	if (!response)
> > > +		return -ENOMEM;
> > > +
> > > +	pl_index = 0;
> > > +	xa_for_each(extent_array, index, extent) {
> > > +
> > > +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> > > +		response->extent_list[pl_index].length = extent->length;
> > > +		pl_index++;
> > > +		response->extent_list_size = cpu_to_le32(pl_index);
> > > +
> > > +		if (pl_index == max_extents) {
> > > +			mbox_cmd = (struct cxl_mbox_cmd) {
> > > +				.opcode = opcode,
> > > +				.size_in = struct_size(response, extent_list,
> > > +						       pl_index),
> > > +				.payload_in = response,
> > > +			};
> > > +
> > > +			response->flags = 0;
> > > +			if (pl_index < cnt)
> > > +				response->flags &= CXL_DCD_EVENT_MORE;  
> > 
> > It should be 'response->flags |= CXL_DCD_EVENT_MORE' here.  
> 
> Ah yea.  Good catch.
> 
> > 
> > Another issue is if 'cnt' is N times bigger than 'max_extents'(e,g. cnt=20, max_extents=10). all responses will be sent in this xa_for_each(), and CXL_DCD_EVENT_MORE will be set in the last response but it should not be set in these cases.
> >   
> 
> Ah yes.  cnt must be decremented.  As I looked at the patch just now the
> 
> 	if (cnt == 0 || pl_index)
> 
> ... seemed very wrong to me.  That change masked this bug.
> 
> This should fix it:
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d66beec687a0..99200274dea8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1119,10 +1119,11 @@ static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
>                         if (rc)
>                                 return rc;
>                         pl_index = 0;
> +                       cnt -= pl_index;
>                 }
>         }
>  
> -       if (cnt == 0 || pl_index) {

I thought this cnt == 0 check was to deal with the no valid
extents case where an empty reply is needed.


> +       if (pl_index) {
>                 mbox_cmd = (struct cxl_mbox_cmd) {
>                         .opcode = opcode,
>                         .size_in = struct_size(response, extent_list,
> 
> 
> Thank you, and sorry again for missing your feedback.
> 
> Ira
> 
> [snip]
> 


