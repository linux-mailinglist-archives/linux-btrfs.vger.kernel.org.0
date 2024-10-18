Return-Path: <linux-btrfs+bounces-8997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084849A397D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3EA281901
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB7A190471;
	Fri, 18 Oct 2024 09:09:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B0188CC6;
	Fri, 18 Oct 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242556; cv=none; b=H+XJ7vDxXJ5qyDVin2R98JUcGQ1UHEB1boApbZiMXgyTkCn8lWIVhAOW1jxiwaRvA1z36+bw0zBNDmiFMjrwIGukdMeKwLI0hi5ytFObFpeJcFBWIHC/7OuLUVGx/jhQi2V1HSrsl+X/lxDqJTJDUpM2mOZZtqP3kDY5IIEYkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242556; c=relaxed/simple;
	bh=zq5IqV+uN//63mIFv4C0Jcw3ezylJ76s+LvLJwbSsMM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHqV2JtVXiGj7EUS7+wwG+T+wOLA0onJln3x7hsjsbY3N24lHUJQUgt0jQdzyWEJmz92/RO4ByMaOcW/5IB8l3JKGfhNWPD6B5WfZWW3yw1gg7zBYi4hLgXnFmbLdXS0UdLubbzjOAY/EtuRkvAf27kWjgCuoM7rMpuetC6Mvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVJld0RxZz6JBBn;
	Fri, 18 Oct 2024 17:08:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B5BA8140B67;
	Fri, 18 Oct 2024 17:09:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 11:09:11 +0200
Date: Fri, 18 Oct 2024 10:09:09 +0100
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
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <20241018100909.00001ec2@Huawei.com>
In-Reply-To: <6711842d88fa_2cee2946a@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
	<20241010155821.00005079@Huawei.com>
	<6711842d88fa_2cee2946a@iweiny-mobl.notmuch>
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

On Thu, 17 Oct 2024 16:39:57 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Mon, 07 Oct 2024 18:16:27 -0500
> > ira.weiny@intel.com wrote:
> >   
> > > From: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > A dynamic capacity device (DCD) sends events to signal the host for
> > > changes in the availability of Dynamic Capacity (DC) memory.  These
> > > events contain extents describing a DPA range and meta data for memory
> > > to be added or removed.  Events may be sent from the device at any time.
> > > 
> > > Three types of events can be signaled, Add, Release, and Force Release.
> > > 
> > > On add, the host may accept or reject the memory being offered.  If no
> > > region exists, or the extent is invalid, the extent should be rejected.
> > > Add extent events may be grouped by a 'more' bit which indicates those
> > > extents should be processed as a group.
> > > 
> > > On remove, the host can delay the response until the host is safely not
> > > using the memory.  If no region exists the release can be sent
> > > immediately.  The host may also release extents (or partial extents) at
> > > any time.  Thus the 'more' bit grouping of release events is of less
> > > value and can be ignored in favor of sending multiple release capacity
> > > responses for groups of release events.  
> > 
> > True today - I think that would be an error for shared extents
> > though as they need to be released in one go.  We can deal with
> > that when it matters.  
> > 
> > 
> > Mind you patch seems to try to handle more bit anyway, so maybe just
> > remove that discussion from this description?  
> 
> It only handles more bit response on ADD because on RELEASE the count is always
> 1.
> 
> 
> +       if (cxl_send_dc_response(mds, CXL_MBOX_OP_RELEASE_DC, &extent_list, 1)) 
> +               dev_dbg(dev, "Failed to release [range 0x%016llx-0x%016llx]\n", 
> +                       range->start, range->end);                              
> 
> 
> For shared; a flag will need to be added to the extents and additional logic to
> group these extents for checking use etc.  
> 
> I agree, we need to handle that later on and get this basic support in.  For
> now I think my comments are correct WRT the sending of release responses.
> 
> > > 
> > > Simplify extent tracking with the following restrictions.
> > > 
> > > 	1) Flag for removal any extent which overlaps a requested
> > > 	   release range.
> > > 	2) Refuse the offer of extents which overlap already accepted
> > > 	   memory ranges.
> > > 	3) Accept again a range which has already been accepted by the
> > > 	   host.  Eating duplicates serves three purposes.  First, this
> > > 	   simplifies the code if the device should get out of sync with
> > > 	   the host.   
> > 
> > Maybe scream about this a little.  AFAIK that happening is a device
> > bug.  
> 
> Agreed but because of the 2nd purpose this is difficult to scream about because
> this situation can come up in normal operation.  Here is the scenario:
> 
> 1) Device has 2 DCD partitions active, A and B
> 2) Host crashes
> 3) Region X is created on A
> 4) Region Y is created on B
> 5) Region Y scans for extents
> 6) Region X surfaces a new extent while Y is scanning
> 7) Gen number changes due to new extent in X
> 8) Region Y rescans for existing extents and sees duplicates.
> 
> These duplicates need to be ignored without signaling an error.
Hmm. If we can know that path is the trigger (should be able to
as it's a scan after a gen number change), can we just muffle the
screams on that path? (Halloween is close, the analogies will get
ever worse :)

Jonathan


