Return-Path: <linux-btrfs+bounces-7555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516299609B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7512B1C22E01
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F01A2577;
	Tue, 27 Aug 2024 12:08:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B31A0B02;
	Tue, 27 Aug 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760515; cv=none; b=f59MXm5Qt2Jcdb8Y5QtbPyrWOYJSKtGN7KZrWuRLWY8UttKIKYqpO0MYNRLRMLYAGDDrWERtqYNHyjnjdsC7jgVM4kfHUec1185OilJ/XoO/wvAgfzfyiQoIKGQgSu5McUW5UuXrVfZD6anNFs1yc910/ZeFcggWUB6+YBByCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760515; c=relaxed/simple;
	bh=52M/8BWHhEzkUmRkv6Kdv6Vqv/i/kvJFaeCUvFN1u34=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeSJZe/EajLB0Ix2Ios7srKtej3G+TgSk2IuH11R10WKOqaG6XcllaDgnmrxrBxV2dLUEJN2kt6Q080F4KFw4niSJ9Im9rU6y27ZA+delT1M8SKCRGg33mncuCMsa7/p/A2LPzqwiGbZRqE8Iu78lw6brhapFaSYbvBbKSLeMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtR7c3s8Bz6DBfS;
	Tue, 27 Aug 2024 20:05:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E3121400D4;
	Tue, 27 Aug 2024 20:08:31 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 13:08:30 +0100
Date: Tue, 27 Aug 2024 13:08:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Navneet Singh
	<navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef Bacik
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
Message-ID: <20240827130829.00004660@Huawei.com>
In-Reply-To: <Zsj_8IckEFpwmA5L@fan>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
	<Zsj_8IckEFpwmA5L@fan>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 14:32:32 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Fri, Aug 16, 2024 at 09:44:26AM -0500, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > A dynamic capacity device (DCD) sends events to signal the host for
> > changes in the availability of Dynamic Capacity (DC) memory.  These
> > events contain extents describing a DPA range and meta data for memory
> > to be added or removed.  Events may be sent from the device at any time.
> > 
> > Three types of events can be signaled, Add, Release, and Force Release.
> > 
> > On add, the host may accept or reject the memory being offered.  If no
> > region exists, or the extent is invalid, the extent should be rejected.
> > Add extent events may be grouped by a 'more' bit which indicates those
> > extents should be processed as a group.
> > 
> > On remove, the host can delay the response until the host is safely not
> > using the memory.  If no region exists the release can be sent
> > immediately.  The host may also release extents (or partial extents) at
> > any time.  Thus the 'more' bit grouping of release events is of less
> > value and can be ignored in favor of sending multiple release capacity
> > responses for groups of release events.
> > 
> > Force removal is intended as a mechanism between the FM and the device
> > and intended only when the host is unresponsive, out of sync, or
> > otherwise broken.  Purposely ignore force removal events.
> > 
> > Regions are made up of one or more devices which may be surfacing memory
> > to the host.  Once all devices in a region have surfaced an extent the
> > region can expose a corresponding extent for the user to consume.
> > Without interleaving a device extent forms a 1:1 relationship with the
> > region extent.  Immediately surface a region extent upon getting a
> > device extent.
> > 
> > Per the specification the device is allowed to offer or remove extents
> > at any time.  However, anticipated use cases can expect extents to be
> > offered, accepted, and removed in well defined chunks.
> > 
> > Simplify extent tracking with the following restrictions.
> > 
> > 	1) Flag for removal any extent which overlaps a requested
> > 	   release range.
> > 	2) Refuse the offer of extents which overlap already accepted
> > 	   memory ranges.
> > 	3) Accept again a range which has already been accepted by the
> > 	   host.  (It is likely the device has an error because it
> > 	   should already know that this range was accepted.  But from
> > 	   the host point of view it is safe to acknowledge that
> > 	   acceptance again.)
> > 
> > Management of the region extent devices must be synchronized with
> > potential uses of the memory within the DAX layer.  Create region extent
> > devices as children of the cxl_dax_region device such that the DAX
> > region driver can co-drive them and synchronize with the DAX layer.
> > Synchronization and management is handled in a subsequent patch.
> > 
> > Process DCD events and create region devices.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >   
> 
> One minor change inline.
Hi Fan,

Crop please.  I scanned past it 3 times when scrolling without noticing
what you'd actually commented on.

> > +/* See CXL 3.0 8.2.9.2.1.5 */  
> 
> Update the reference to reflect CXL 3.1.
> 
> Fan
> 

