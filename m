Return-Path: <linux-btrfs+bounces-9076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726209AB49D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 19:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22941C23249
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A11BCA14;
	Tue, 22 Oct 2024 17:01:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E117483;
	Tue, 22 Oct 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616490; cv=none; b=KBrFrlkbvYQQ1peRTDNXO3jrcijLWJEL0/8lRI+V93k0lOElJ3zONBqH5s3lPg0NhrSNTqG4qh8eZimppT//ATB8xdZTK05Aw+aXtcB4bkvSMdM4QtncKn/FNmo/nbFWQnvTuO/pkMfdW9SxthwTkJY3OJWPJ4IZ6b2PDkTll8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616490; c=relaxed/simple;
	bh=PPNSYZKPWMLanxucQDtSVxv8/bs3/sUN4XUPU8RmAq4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZWj7lHJs2dVZwgyfnB7WFfrl3Xl1hc0dJ9Wwp1kPjneS4J4qoqrsoRT0wJtp/wzAleRJeOE82LcbusENR1jEvJwtVMAK6Pnc+o3MXxo9B0dkrJ9HxX8CZVeyzYF6Df5+W6WAIRH+P6fjmbpDDtnIXtuXm6cMKYQ2ekAU2rdvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXyy56sgYz6LD5g;
	Wed, 23 Oct 2024 00:56:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E2DD140B55;
	Wed, 23 Oct 2024 01:01:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Oct
 2024 19:01:24 +0200
Date: Tue, 22 Oct 2024 18:01:22 +0100
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
Message-ID: <20241022180122.00006074@Huawei.com>
In-Reply-To: <6716a165823b7_8cb1729437@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
	<20241010155821.00005079@Huawei.com>
	<6711842d88fa_2cee2946a@iweiny-mobl.notmuch>
	<20241018100909.00001ec2@Huawei.com>
	<6716a165823b7_8cb1729437@iweiny-mobl.notmuch>
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

On Mon, 21 Oct 2024 13:45:57 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Thu, 17 Oct 2024 16:39:57 -0500
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > Jonathan Cameron wrote:  
> > > > On Mon, 07 Oct 2024 18:16:27 -0500
> > > > ira.weiny@intel.com wrote:
> > > >     
> 
> [snip]
> 
> > > > > Simplify extent tracking with the following restrictions.
> > > > > 
> > > > > 	1) Flag for removal any extent which overlaps a requested
> > > > > 	   release range.
> > > > > 	2) Refuse the offer of extents which overlap already accepted
> > > > > 	   memory ranges.
> > > > > 	3) Accept again a range which has already been accepted by the
> > > > > 	   host.  Eating duplicates serves three purposes.  First, this
> > > > > 	   simplifies the code if the device should get out of sync with
> > > > > 	   the host.     
> > > > 
> > > > Maybe scream about this a little.  AFAIK that happening is a device
> > > > bug.    
> > > 
> > > Agreed but because of the 2nd purpose this is difficult to scream about because
> > > this situation can come up in normal operation.  Here is the scenario:
> > > 
> > > 1) Device has 2 DCD partitions active, A and B
> > > 2) Host crashes
> > > 3) Region X is created on A
> > > 4) Region Y is created on B
> > > 5) Region Y scans for extents
> > > 6) Region X surfaces a new extent while Y is scanning
> > > 7) Gen number changes due to new extent in X
> > > 8) Region Y rescans for existing extents and sees duplicates.
> > > 
> > > These duplicates need to be ignored without signaling an error.  
> > Hmm. If we can know that path is the trigger (should be able to
> > as it's a scan after a gen number change), can we just muffle the
> > screams on that path? (Halloween is close, the analogies will get
> > ever worse :)  
> 
> Ok yea since this would be a device error we should do something here.  But the
> code is going to be somewhat convoluted to print an error whenever this
> happens.
> 
> What if we make this a warning and change the rescan debug message to a warning
> as well?  This would allow enough bread crumbs to determine if a device is
> failing without a lot of extra code to alter print messages on the fly?

Sounds ok to me.

Jonathan

> 
> Ira
> 


