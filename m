Return-Path: <linux-btrfs+bounces-9018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D523F9A6042
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 11:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019CF1C21932
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 09:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6E1E32C2;
	Mon, 21 Oct 2024 09:38:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982DA198837;
	Mon, 21 Oct 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503484; cv=none; b=ZgFIDGxtwW8NeRWEnfmXz3swZzjoiixPSGAVZKJv6QEAkdpyBeQW6TOmwYd9Vy5p7yD9iw0RhaV4IfIiV5E3oOgOrD+Dim+1TRdvxqpK6uFI/OeVdbVqx5Wg67cMFRPW1c0PgdmUFPyWIHXoi3RDni+9MNOnUVnzWWmmanT+h/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503484; c=relaxed/simple;
	bh=PEW3DFyuQciELtV+7Gvo/3gVm39aoucp79oCe+Jyz9Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMGI1WZPZlD3uyKwy4jHwJ65J4jPq1VMRPNvZ8gyepoJm7dwyfxduPwxdTBMUSCSS8J33NG4Gnc/SZqWISpLKStPGxY65I78eRxlAULfrOYhoA1mCHBs98noIg9Pfz5QduL0ml3zjK342zF0J1Z08uwFe040S4kNBQyJ4CTpYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XX9Cz06ftz6GBTY;
	Mon, 21 Oct 2024 17:35:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 507A31409EA;
	Mon, 21 Oct 2024 17:37:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Oct
 2024 11:37:54 +0200
Date: Mon, 21 Oct 2024 10:37:52 +0100
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
Subject: Re: [PATCH v4 22/28] cxl/region/extent: Expose region extent
 information in sysfs
Message-ID: <20241021103752.00002741@Huawei.com>
In-Reply-To: <6712a846dad09_2cee2945a@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-22-c261ee6eeded@intel.com>
	<20241010160142.00005a5c@Huawei.com>
	<6712a846dad09_2cee2945a@iweiny-mobl.notmuch>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Oct 2024 13:26:14 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Mon, 07 Oct 2024 18:16:28 -0500
> > ira.weiny@intel.com wrote:
> >   
> > > From: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > Extent information can be helpful to the user to coordinate memory usage
> > > with the external orchestrator and FM.
> > > 
> > > Expose the details of region extents by creating the following
> > > sysfs entries.
> > > 
> > >         /sys/bus/cxl/devices/dax_regionX/extentX.Y
> > >         /sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> > >         /sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> > >         /sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
> > > 
> > > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >   
> > Trivial comments inline.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Thanks!
> 
> >   
> > > ---
> > > Changes:
> > > [djiang: Split sysfs docs up]
> > > [iweiny: Adjust sysfs docs dates]
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl | 32 ++++++++++++++++++
> > >  drivers/cxl/core/extent.c               | 58 +++++++++++++++++++++++++++++++++
> > >  2 files changed, 90 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > index b63ab622515f..64918180a3c9 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -632,3 +632,35 @@ Description:
> > >  		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
> > >  		the number to the closest initiator and access1 provides the
> > >  		number to the closest CPU.
> > > +
> > > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> > > +Date:		December, 2024
> > > +KernelVersion:	v6.13
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) [For Dynamic Capacity regions only] Users can use the
> > > +		extent information to create DAX devices on specific extents.
> > > +		This is done by creating and destroying DAX devices in specific
> > > +		sequences and looking at the mappings created.   
> > 
> > Similar to earlier patch, maybe put this doc for the directory, then
> > have much less duplication?
> >   
> 
> But none of the other directories are done this way so I'm inclined to keep it.

Fair enough. Maybe a topic for a future cleanup to reduce duplication.

> 
> >   
> > > Extent offset
> > > +		within the region.
> > > +
> > > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> > > +Date:		December, 2024
> > > +KernelVersion:	v6.13
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) [For Dynamic Capacity regions only] Users can use the
> > > +		extent information to create DAX devices on specific extents.
> > > +		This is done by creating and destroying DAX devices in specific
> > > +		sequences and looking at the mappings created.  Extent length
> > > +		within the region.
> > > +
> > > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
> > > +Date:		December, 2024
> > > +KernelVersion:	v6.13
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) [For Dynamic Capacity regions only] Users can use the
> > > +		extent information to create DAX devices on specific extents.
> > > +		This is done by creating and destroying DAX devices in specific
> > > +		sequences and looking at the mappings created.  Extent tag.  
> > 
> > Maybe say we are treating it as a UUID?  
> 
> ok...  How about?
> 
> <quote>
> ...  looking at the mappings created.  UUID extent tag.
That's fine.

> </quote>
> 
> > > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > > index 69a7614ba6a9..a1eb6e8e4f1a 100644
> > > --- a/drivers/cxl/core/extent.c
> > > +++ b/drivers/cxl/core/extent.c
> > > @@ -6,6 +6,63 @@  
> >   
> > > +static struct attribute *region_extent_attrs[] = {
> > > +	&dev_attr_offset.attr,
> > > +	&dev_attr_length.attr,
> > > +	&dev_attr_tag.attr,
> > > +	NULL,  
> > No need for trailing comma (one of my 'favourite' review comments :)  
> 
> I'm noticing...  :-D
Maybe I'll one day add to checkpatch.  If it weren't written in perl
I'd do it now ;)

Jonathan

> 
> Ira
> 


