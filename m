Return-Path: <linux-btrfs+bounces-8996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B76529A395C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36716B22205
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191B19006A;
	Fri, 18 Oct 2024 09:03:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F718E028;
	Fri, 18 Oct 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242195; cv=none; b=Pe5PPM6glP11oNLaHaEONOovxBko4nPFxHXs+HEyn6OZrSS6BZNFvKQQQcUASmmy5KLeVoa2sSfFeXvehnwrZsmoK6dHKeGf80U5ksQDUrntkl+f29iLEOX+1h7Dvelbv/vR1Yw0MFSe/ix7Xa63kJkXPci617aXzvdgna0VXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242195; c=relaxed/simple;
	bh=7nnWLfvroPjQ3WSiLUmBIOWohRKgJsHdFTrjyFHfjxA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae/PNii/UMjffZE1stMFk/rnBcD9WpeY7MEFme4HpUp96YvdLjtgBwTbcm3LgFz9zb07UJk8CvsAimrtTBpjAECMGFirEqI4wgRnn9KJPAg3Pr8zEUIF1m2qP5jlqGGuawJJ4puNMkSZ9hrqD+HeTHM73tV1TgvP/VClahiytC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVJbR06lDz6K6YX;
	Fri, 18 Oct 2024 17:01:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C6075140CF4;
	Fri, 18 Oct 2024 17:03:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 11:03:09 +0200
Date: Fri, 18 Oct 2024 10:03:07 +0100
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
Message-ID: <20241018100307.000008a9@Huawei.com>
In-Reply-To: <67117e57479b3_2cee2942d@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
	<4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
	<6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
	<20241010155014.00004bdd@Huawei.com>
	<67117e57479b3_2cee2942d@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 16:15:03 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 9 Oct 2024 14:49:09 -0500
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > Li, Ming4 wrote:  
> > > > On 10/8/2024 7:16 AM, ira.weiny@intel.com wrote:    
> > > > > From: Navneet Singh <navneet.singh@intel.com>
> > > > >    
> 
> [snip]
> 
> > >   
> > > > > +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> > > > > +				struct xarray *extent_array, int cnt)
> > > > > +{
> > > > > +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> > > > > +	struct cxl_mbox_dc_response *p;
> > > > > +	struct cxl_mbox_cmd mbox_cmd;
> > > > > +	struct cxl_extent *extent;
> > > > > +	unsigned long index;
> > > > > +	u32 pl_index;
> > > > > +	int rc;
> > > > > +
> > > > > +	size_t pl_size = struct_size(p, extent_list, cnt);
> > > > > +	u32 max_extents = cnt;
> > > > > +
> > > > > +	/* May have to use more bit on response. */
> > > > > +	if (pl_size > cxl_mbox->payload_size) {
> > > > > +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
> > > > > +			      sizeof(struct updated_extent_list);
> > > > > +		pl_size = struct_size(p, extent_list, max_extents);
> > > > > +	}
> > > > > +
> > > > > +	struct cxl_mbox_dc_response *response __free(kfree) =
> > > > > +						kzalloc(pl_size, GFP_KERNEL);
> > > > > +	if (!response)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	pl_index = 0;
> > > > > +	xa_for_each(extent_array, index, extent) {
> > > > > +
> > > > > +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> > > > > +		response->extent_list[pl_index].length = extent->length;
> > > > > +		pl_index++;
> > > > > +		response->extent_list_size = cpu_to_le32(pl_index);
> > > > > +
> > > > > +		if (pl_index == max_extents) {
> > > > > +			mbox_cmd = (struct cxl_mbox_cmd) {
> > > > > +				.opcode = opcode,
> > > > > +				.size_in = struct_size(response, extent_list,
> > > > > +						       pl_index),
> > > > > +				.payload_in = response,
> > > > > +			};
> > > > > +
> > > > > +			response->flags = 0;
> > > > > +			if (pl_index < cnt)
> > > > > +				response->flags &= CXL_DCD_EVENT_MORE;    
> > > > 
> > > > It should be 'response->flags |= CXL_DCD_EVENT_MORE' here.    
> > > 
> > > Ah yea.  Good catch.
> > >   
> > > > 
> > > > Another issue is if 'cnt' is N times bigger than 'max_extents'(e,g. cnt=20, max_extents=10). all responses will be sent in this xa_for_each(), and CXL_DCD_EVENT_MORE will be set in the last response but it should not be set in these cases.
> > > >     
> > > 
> > > Ah yes.  cnt must be decremented.  As I looked at the patch just now the
> > > 
> > > 	if (cnt == 0 || pl_index)
> > > 
> > > ... seemed very wrong to me.  That change masked this bug.
> > > 
> > > This should fix it:
> > > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index d66beec687a0..99200274dea8 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -1119,10 +1119,11 @@ static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> > >                         if (rc)
> > >                                 return rc;
> > >                         pl_index = 0;
> > > +                       cnt -= pl_index;
> > >                 }
> > >         }
> > >  
> > > -       if (cnt == 0 || pl_index) {  
> > 
> > I thought this cnt == 0 check was to deal with the no valid
> > extents case where an empty reply is needed.  
> 
> Yes but the bug found by Ming needs to be handled too.  I see Fan is also
> questioning this code.
> 
> So...  for clarity among all of us here is the new function.  I'm not thrilled
> with the use of a goto but I think it is ok here.

Easy enough to avoid and I don't think it hurts readability much to do so.

Your code should work though.

> 
> Ira
> 
> static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,      
>                                struct xarray *extent_array, int cnt)           
> {                                                                              
>        struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;                    
>        struct cxl_mbox_dc_response *p;                                         
>        struct cxl_mbox_cmd mbox_cmd;                                           
>        struct cxl_extent *extent;                                              
>        unsigned long index;                                                    
>        u32 pl_index;                                                           
>        int rc;                                                                 
>                                                                                
>        size_t pl_size = struct_size(p, extent_list, cnt);                      
>        u32 max_extents = cnt;                                              
>                                                                                
>        /* May have to use more bit on response. */                             
>        if (pl_size > cxl_mbox->payload_size) {                                 
>                max_extents = (cxl_mbox->payload_size - sizeof(*p)) /           
>                              sizeof(struct updated_extent_list);               
>                pl_size = struct_size(p, extent_list, max_extents);
             
>        }                                                                       
>                                                                                
>        struct cxl_mbox_dc_response *response __free(kfree) =                   
>                                                kzalloc(pl_size, GFP_KERNEL);   
>        if (!response)                                                          
>                return -ENOMEM;                                                 
>                                                                                
>        pl_index = 0;                                                           
>        if (cnt == 0)                                                           
>                goto send_zero_accepted;
>        xa_for_each(extent_array, index, extent) {                              
>                response->extent_list[pl_index].dpa_start = extent->start_dpa;  
>                response->extent_list[pl_index].length = extent->length;        
>                pl_index++;                                                     
>                response->extent_list_size = cpu_to_le32(pl_index);    

Why set this here - to me makes more sense to set it only once but I can
see the logic either way.
         
>   
>                if (pl_index == max_extents) {                                  
>                        mbox_cmd = (struct cxl_mbox_cmd) {                      
>                                .opcode = opcode,                               
>                                .size_in = struct_size(response, extent_list,   
>                                                       pl_index),               
>                                .payload_in = response,                         
>                        };                                                      
>                                                                                
>                        response->flags = 0;                                    
>                        if (pl_index < cnt)                                     
>                                response->flags &= CXL_DCD_EVENT_MORE;          
>                                                                                
>                        rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);        
>                        if (rc)                                                 
>                                return rc;                                      
>                        cnt -= pl_index;                                        
>                        pl_index = 0;                                          
>                }                                                               
>        }                                                                       
>                                                                                
>        if (!pl_index)                                                          
>                return 0;                                                       
>                                                                                
> send_zero_accepted:                                                            
>        mbox_cmd = (struct cxl_mbox_cmd) {                                      
>                .opcode = opcode,                                               
>                .size_in = struct_size(response, extent_list,                   
>                                       pl_index),                               
>                .payload_in = response,                                         
>        };                                                                      
>                                                                                
>        response->flags = 0;                                                    
>        return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);                      
> }                


Alternative form for what you have...
                                                              
	if (cnt != 0) { /* Something to send */
                 xa_for_each(extent_array, index, extent) {
			response->extent_list[pl_index].dpa_start = extent->start_dpa;
			response->extent_list[pl_index].length = extent->length;
			pl_index++;
			response->extent_list_size = cpu_to_le32(pl_index);                 
			if (pl_index != max_extents) /* Space for more? */
				continue;

			/* Send what we have */
			response->flags = 0; 
			if (pl_index < cnt)                                     
				response->flags &= CXL_DCD_EVENT_MORE;
			
			mbox_cmd = (struct cxl_mbox_cmd) {                      
				.opcode = opcode,                               
				.size_in = struct_size(response, extent_list,   
						       pl_index),               
				.payload_in = response,                         
			};

			rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);        
			if (rc)                                                 
				return rc;                                      
			cnt -= pl_index;                                        
			pl_index = 0;
		}
		if (!pl_index)
			return 0;
	}

	/* Catch left overs + send if zero length */
	response->flags = 0;
	mbox_cmd = (struct cxl_mbox_cmd) {                                      
		.opcode = opcode,                                               
		.size_in = struct_size(response, extent_list, pl_index),                               
		.payload_in = response,                                         
	};                                                                      
                                                                                                                                    
	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);                      
}

                                                

> 


