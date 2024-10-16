Return-Path: <linux-btrfs+bounces-8971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286979A1038
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3ED1C21188
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2CA2101B1;
	Wed, 16 Oct 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrxJzigD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A820C031;
	Wed, 16 Oct 2024 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097973; cv=none; b=lDtu7cG4vRrsdcYvqhlreFI5G0ob0D4cCy3rgBe9FPI86fdOtWZukAGuLj7gdU4XSNShKPtxJ+vZouRZkhgWCrbundy0sL+e0XRorgVTW7oYrC7/jrI+fKXKOtEqC4EEYZJJtXkOLGjIo/K+qhmEPW6yOgE2ioScBRrF6j3XbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097973; c=relaxed/simple;
	bh=WSA6cXI9paugRSBVmePqzHVAXr82KSH6RNrOaBQM73M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEvEyhV8jobc+JOX0QzNuauAzZtzuS7KwYmhVT07yDDgYmeH8Qh8LhH80677J7xAp3edEvyAYMNwdn5RFr+9uaWHXYY8siqCmu+h747B6KoEsEXifnXKrMNQdqv7lRdJepkC80WK9ZwNOlcsMcK9rjuYROo6pSE1cdI8A8Z0WZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrxJzigD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332EEC4CEC5;
	Wed, 16 Oct 2024 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729097973;
	bh=WSA6cXI9paugRSBVmePqzHVAXr82KSH6RNrOaBQM73M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrxJzigDbh/gSdc+iOlC5oMELDYBbHtNqAYPRBzoy+vyQbY2/i51f38aJ2fNQwR5c
	 VD1PdckDwndDgVDRZuK0aTdQEZnBMKzRusul/NI+9DCHZkGgPYagx9G7ZYqZQQdFRz
	 HRULNwqmDNyjZuscgs8xkU16p3K4gqxjwxXvWvzBjJAkldomwCJ4DCuxJu/Klht+/M
	 kH4Rf/ifTnkNO7XtnN5He2fSGBCY+h6y4oug/PYQh/MZknJQ3+YxaZ8odjEVQu4R0G
	 oOrLvlZkJ1G2piOWN1TQieA/CDwtXoQAGc3hJUyd1QhGx7UYZYi46RR+TJQIgcjoUR
	 LGgfppYeG14Yw==
Date: Wed, 16 Oct 2024 09:59:29 -0700
From: Kees Cook <kees@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, "Li, Ming" <ming4.li@intel.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 08/28] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <202410160958.518EB9DB6@keescook>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-8-c261ee6eeded@intel.com>
 <20241009134936.00003e0e@Huawei.com>
 <670c6037718f_9710f294d0@iweiny-mobl.notmuch>
 <20241016165415.00002bad@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016165415.00002bad@Huawei.com>

On Wed, Oct 16, 2024 at 04:54:15PM +0100, Jonathan Cameron wrote:
> On Sun, 13 Oct 2024 19:05:11 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Mon, 07 Oct 2024 18:16:14 -0500
> > > ira.weiny@intel.com wrote:
> > >   
> > > > From: Navneet Singh <navneet.singh@intel.com>
> > > > 
> > > > Devices which optionally support Dynamic Capacity (DC) are configured
> > > > via mailbox commands.  CXL 3.1 requires the host to issue the Get DC
> > > > Configuration command in order to properly configure DCDs.  Without the
> > > > Get DC Configuration command DCD can't be supported.
> > > > 
> > > > Implement the DC mailbox commands as specified in CXL 3.1 section
> > > > 8.2.9.9.9 (opcodes 48XXh) to read and store the DCD configuration
> > > > information.  Disable DCD if DCD is not supported.  Leverage the Get DC
> > > > Configuration command supported bit to indicate if DCD support.
> > > > 
> > > > Linux has no use for the trailing fields of the Get Dynamic Capacity
> > > > Configuration Output Payload (Total number of supported extents, number
> > > > of available extents, total number of supported tags, and number of
> > > > available tags). Avoid defining those fields to use the more useful
> > > > dynamic C array.
> > > > 
> > > > Cc: "Li, Ming" <ming4.li@intel.com>
> > > > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > > 
> > > Looks fine to me.  Trivial comment inline  
> > 
> > Thanks.
> > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > 
> > >   
> > > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > > index e8907c403edb..0690b917b1e0 100644
> > > > --- a/drivers/cxl/cxlmem.h
> > > > +++ b/drivers/cxl/cxlmem.h  
> > > ...
> > >   
> > > > +/* See CXL 3.1 Table 8-164 get dynamic capacity config Output Payload */
> > > > +struct cxl_mbox_get_dc_config_out {
> > > > +	u8 avail_region_count;
> > > > +	u8 regions_returned;
> > > > +	u8 rsvd[6];
> > > > +	/* See CXL 3.1 Table 8-165 */
> > > > +	struct cxl_dc_region_config {
> > > > +		__le64 region_base;
> > > > +		__le64 region_decode_length;
> > > > +		__le64 region_length;
> > > > +		__le64 region_block_size;
> > > > +		__le32 region_dsmad_handle;
> > > > +		u8 flags;
> > > > +		u8 rsvd[3];
> > > > +	} __packed region[];  
> > > 
> > > Could throw in a __counted_by I think?  
> > 
> > I was not sure if this would work considering this is coming from the hardware.
> > From what I have read I think it will but only because the region count can't
> > be byte swapped.
> 
> __counted_by_le() deals potentially larger values by just making
> the __counted_by go away on big endian architectures.
> 
> 
> > 
> > Is this something we want to do with structs coming from hardware when we can?
> 
> I think we still do.  Gustavo, Kees?

As long as "regions_returned" got correctly set by hardware before
anything in the kernel touches the "region" array, it can totally be
used by a __counted_by annotation.

-- 
Kees Cook

