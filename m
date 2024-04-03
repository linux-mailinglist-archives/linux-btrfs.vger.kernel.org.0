Return-Path: <linux-btrfs+bounces-3893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62CA897A32
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 22:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BFE28D447
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 20:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE80156999;
	Wed,  3 Apr 2024 20:40:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341715697E;
	Wed,  3 Apr 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176806; cv=none; b=TMPILrkRuj2JCSILkz4Yf9A0dBNVciEff8BjNHtGlWwWSZ/5MIk9+sQabhZYiDo8r8KiRlVWhbx5xqyaByKFQ5yBF0PFOKnvh65oTXcxBcB7O6A6HEbdg4gg9EMGuuGyY7LYsY6Uq4Nart9+Eua5lOYULkJe02X3boH3Z8qXxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176806; c=relaxed/simple;
	bh=qgljfKihg3TTZ+DcxNAtMO2QNJhWdpZgN0ADjmVw1dw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9aoZIHDE7JqS+8PZ9YpwILaoboTxlI4ZWRtFQ0ToA3gncR+ym6IwbCw0MS0XMkFaj0Ly0KprFQoV/U+9FNrk74IRV/ngMCzZ+gh/vpl0FmUhyUyg5a0NF+i3Fy2loyuACOXP0gqrjGoF+i5ySmZRKK8JfcTKBvhUian+g5SKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8xMZ35Cnz6DBMD;
	Thu,  4 Apr 2024 04:35:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 92FDB140B67;
	Thu,  4 Apr 2024 04:40:00 +0800 (CST)
Received: from localhost (10.126.171.13) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 21:39:59 +0100
Date: Wed, 3 Apr 2024 21:39:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: fan <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chris Mason
	<clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <20240403213958.00000f0d@Huawei.com>
In-Reply-To: <6604fe2dae8ea_2089029486@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<ZgHPUggTfSCIx8cI@debian>
	<6604fe2dae8ea_2089029486@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 27 Mar 2024 22:20:45 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> fan wrote:
> > On Sun, Mar 24, 2024 at 04:18:03PM -0700, ira.weiny@intel.com wrote:  
> > > A git tree of this series can be found here:  
> 
> [snip]
> 
> > >   
> > 
> > Hi Ira,
> > Have not got a chance to check the code yet, but I noticed one thing
> > when testing with my DCD emulation code.
> > Currently, if we do partial release, it seems the whole extent will be
> > removed. Is it designed intentionally?
> >   
> 
> Yes that is my intent.  I specifically called that out in patch 18.
> 
> https://lore.kernel.org/all/20240324-dcd-type2-upstream-v1-18-b7b00d623625@intel.com/
> 
> I thought we discussed this in one of the collaboration calls.  Mainly
> this is to simplify by not attempting any split of the extents the host is
> tracking.  It really is expected that the FM/device is going to keep those
> extents offered and release them in their entirety.  I understand this may
> complicate the device because it may see a release of memory prior to the
> request of that release.  And perhaps this complicates the device.  But in
> that case it (or the FM really) should not attempt to release partial
> extents.

It was discussed at some point as you say. Feels like something that might not
be set in stone for ever, but for now it is a reasonable simplifying assumption.
The device might not maintain the separation of neighboring extents
but the FM probably will.  If it turns out real use models are different,
then we 'guessed' wrong and get to write more complex code. 

Device always has to cope with unsolicited release so don't think this adds
any burden.  That includes a race where the host releases capacity when
it hasn't yet seen the event the device has sent to release part of the same
capacity.  There is text about async release always being possible in the
spec to cover these overlapping cases but upshot of that one is it must be
permissible to release a containing capacity as you are doing.

Jonathan

> Ira
> 
> [snip]


