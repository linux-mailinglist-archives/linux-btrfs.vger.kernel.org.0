Return-Path: <linux-btrfs+bounces-7447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B169395D2F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E928916C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E118CC0B;
	Fri, 23 Aug 2024 16:14:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68C189F30;
	Fri, 23 Aug 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429696; cv=none; b=YXTRSz0PqUnQcKpD9hhQD16spPrIem9iwLFFshMO9HeMwloAuZxo8tePNDzCTh58eFV1I4MGrg6aPMjnl6ygV8Clj/qSUds/C3ufObY0a6J9KidXMhyAlMEdkMguanExmTR4BcZoImujWu3dYkcWN9WFmnvRpLn9rlKEm4px7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429696; c=relaxed/simple;
	bh=BxE+Xupm139zg462Cjs0vMijPCyBQD6iq3AylruF/IM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyKpcwUcL5V2mKaX0h8Lu4gcxeVKe9r6muFJIbXBI5NeLWEN5V27yow43uDXvqviVL5dJhvoBPyiS3437lmbpUd8rZkloByri79ZIGfJIlegZGYF+5qtV2ee5CKKdY2kPluRUL5B+/a3jzDNG/+hMrG+XEg9qhzj51eCKl+dMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr4nt5mdWz6K61S;
	Sat, 24 Aug 2024 00:11:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B97A3140A35;
	Sat, 24 Aug 2024 00:14:51 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 17:14:51 +0100
Date: Fri, 23 Aug 2024 17:14:50 +0100
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
Subject: Re: [PATCH v3 11/25] cxl/mem: Expose DCD partition capabilities in
 sysfs
Message-ID: <20240823171450.00007af4@Huawei.com>
In-Reply-To: <66c7f3d977851_1719d29424@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-11-7c9b96cba6d7@intel.com>
	<8649e30c-a43a-4096-a32f-e31bf3e71d90@intel.com>
	<66c7f3d977851_1719d29424@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 22 Aug 2024 21:28:41 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Dave Jiang wrote:
> > 
> > 
> > On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:  
> > > From: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> > > user space will need to know the details of the DC partitions available.
> > > 
> > > Expose dynamic capacity capabilities through sysfs.
> > > 
> > > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > Changes:
> > > [iweiny: remove review tags]
> > > [Davidlohr/Fan/Jonathan: omit 'dc' attribute directory if device is not DC]
> > > [Jonathan: update documentation for dc visibility]
> > > [Jonathan: Add a comment to DC region X attributes to ensure visibility checks work]
> > > [iweiny: push sysfs version to 6.12]
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl | 12 ++++
> > >  drivers/cxl/core/memdev.c               | 97 +++++++++++++++++++++++++++++++++
> > >  2 files changed, 109 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > index 957717264709..6227ae0ab3fc 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -54,6 +54,18 @@ Description:
> > >  		identically named field in the Identify Memory Device Output
> > >  		Payload in the CXL-2.0 specification.
> > >  
> > > +What:		/sys/bus/cxl/devices/memX/dc/region_count
> > > +		/sys/bus/cxl/devices/memX/dc/regionY_size  
> > 
> > Just make it into 2 separate entries?  
> 
> Do you mean in the docs?

Assuming yes, then I think it would be cleaner as two separate entries
+ Maybe even one for the directory which can then have
the visibility statement.

> 
> Ira
> 
> > 
> > DJ  
> > > +Date:		August, 2024
> > > +KernelVersion:	v6.12
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) Dynamic Capacity (DC) region information.  The dc
> > > +		directory is only visible on devices which support Dynamic
> > > +		Capacity.
> > > +		The region_count is the number of Dynamic Capacity (DC)
> > > +		partitions (regions) supported on the device.
> > > +		regionY_size is the size of each of those partitions.
> > >  
> > >  What:		/sys/bus/cxl/devices/memX/pmem/qos_class
> > >  Date:		May, 2023  
> 
> [snip]
> 


