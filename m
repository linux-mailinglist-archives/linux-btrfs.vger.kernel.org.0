Return-Path: <linux-btrfs+bounces-8966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66329A0EF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 17:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA753288196
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F72139CD;
	Wed, 16 Oct 2024 15:48:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C7212EE5;
	Wed, 16 Oct 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093713; cv=none; b=OJDl/oMZW0uARuhplsGzZQzLKvJBh5ON+vqJpiITii2qXl8eDi8YRPsF2tpoUd+MWuXPklBp7KjtkzfZGr29ruhgc33LmkYnr2KhBH/ppu8DvKMBGxwFY7/rVl1xXLqKjlX3WGh5F4EcdaENMENMlY/ksxleu7njTw3zlvcmWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093713; c=relaxed/simple;
	bh=SOQ2c8KSJM+2PRLcOjVRDsewAuvHhY5x/hPLOZ0bp58=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLIgiZBFCeEhSAhhUdIc+fYt7ZejewmU3fLuoeBD81SZGyTtTx+yRq2dRb9ehT6E9RdXM+COanPko5uGCyrKwgcYZXIVNSsCaRiNHgsjQBq/bp3yN0pkZm4j2DNK5xVB6btmASUBUvVinaaA4LVKQLlk6srOLgd9KjksX/0A9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTFjL5h0sz6D8cB;
	Wed, 16 Oct 2024 23:47:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 72483140A71;
	Wed, 16 Oct 2024 23:48:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 17:48:27 +0200
Date: Wed, 16 Oct 2024 16:48:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/28] dax: Document dax dev range tuple
Message-ID: <20241016164826.000068e9@Huawei.com>
In-Reply-To: <67098d5a946b8_9710f29462@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-5-c261ee6eeded@intel.com>
	<20241009134201.000011b4@Huawei.com>
	<67098d5a946b8_9710f29462@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Oct 2024 15:40:58 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Mon, 07 Oct 2024 18:16:11 -0500
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > The device DAX structure is being enhanced to track additional DCD
> > > information.
> > > 
> > > The current range tuple was not fully documented.  Document it prior to
> > > adding information for DC.
> > > 
> > > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >   
> > Isn't this a nested struct?
> > https://docs.kernel.org/doc-guide/kernel-doc.html#nested-structs-unions
> > 
> > I'm not quite sure how we document when it's a nested pointer to a
> > a structure.  Is it the same as for a 'normal' nested struct?  
> 
> In this case I think it best to document the struct and just document the
> reference.  See below.
> 
> >     
> > > ---
> > > Changes:
> > > [iweiny: move to start of series]
> > > ---
> > >  drivers/dax/dax-private.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> > > index 446617b73aea..ccde98c3d4e2 100644
> > > --- a/drivers/dax/dax-private.h
> > > +++ b/drivers/dax/dax-private.h
> > > @@ -58,7 +58,10 @@ struct dax_mapping {
> > >   * @dev - device core
> > >   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
> > >   * @nr_range: size of @ranges
> > > - * @ranges: resource-span + pgoff tuples for the instance
> > > + * @ranges: range tuples of memory used
> > > + * @pgoff: page offset  
> >       @ranges.pgoff?
> > etc  
> 
> Ok yea.
> 
> As for the pointer to a structure.  I think the best thing to do is simply
> document that structure.
> 
> Something like this building on this patch:
> 
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index ccde98c3d4e2..b9816c933575 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -40,6 +40,12 @@ struct dax_region {
>         struct device *youngest;
>  };
>  
> +/**
> + * struct dax_mapping - device to display mapping range attributes
> + * @dev: device representing this range
> + * @range_id: index within dev_dax ranges array
> + * @id: ida of this mapping
> + */
>  struct dax_mapping {
>         struct device dev;
>         int range_id;
> @@ -59,9 +65,9 @@ struct dax_mapping {
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
>   * @nr_range: size of @ranges
>   * @ranges: range tuples of memory used
> - * @pgoff: page offset
> - * @range: resource-span
> - * @mapping: device to assist in interrogating the range layout
> + * @ranges.pgoff: page offset
> + * @ranges.range: resource-span
> + * @ranges.mapping: reference to the dax_mapping for this range

Maybe just pull out definition of struct dev_dax_range?
Avoids this confusion and no particularly obvious reason why it
is embedded in the definition of dev_dax.

>   */
>  struct dev_dax {
>         struct dax_region *region;
> 


