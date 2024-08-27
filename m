Return-Path: <linux-btrfs+bounces-7562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B88960D70
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 16:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544EC2835A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B61C4EC8;
	Tue, 27 Aug 2024 14:20:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E71C4607;
	Tue, 27 Aug 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768399; cv=none; b=Ix2TY/BxhoJnYUtNNYkclFKy1TPgriCBMK698AklTws7nUlDnf+Y3Za4EDDuuRE0zHVdcNbu+AKLuZ7nXk8yRp0WkiV7VMHh3RPRcWsAE5Dtz1b9Qy0re0Y3rXzg6SXbo+iew48jUHdHgRi08xssUM/O+AuWXxXS1zjT4GRc1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768399; c=relaxed/simple;
	bh=ROAVgVxCQ6JZDW6x6Yr7XXe28tpvhUqGvbymD5+oZLM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=selD88DBUGXMDS6ev9NnpK0taRhihcbO6TP+4cskwzmrZk26LESQeC8XOixXLTN37CHjlXIu/styZr/OrejxEUNJ+EKXI5dK1jvh/JAd6N4lDt/C65S8qIHE6OGRu/y7DMySV5lrwBcnZcdLglpE03R8J3N9D4c0loh1RIEzKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtV3C1bd1z6D8XS;
	Tue, 27 Aug 2024 22:16:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 13943140B39;
	Tue, 27 Aug 2024 22:19:54 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 15:19:53 +0100
Date: Tue, 27 Aug 2024 15:19:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
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
Subject: Re: [PATCH v3 22/25] cxl/region: Read existing extents on region
 creation
Message-ID: <20240827151952.0000429b@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-22-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-22-7c9b96cba6d7@intel.com>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 09:44:30 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic capacity device extents may be left in an accepted state on a
> device due to an unexpected host crash.  In this case it is expected
> that the creation of a new region on top of a DC partition can read
> those extents and surface them for continued use.
> 
> Once all endpoint decoders are part of a region and the region is being
> realized a read of the devices extent list can reveal these previously
> accepted extents.
> 
> CXL r3.1 specifies the mailbox call Get Dynamic Capacity Extent List for
> this purpose.  The call returns all the extents for all dynamic capacity
> partitions.  If the fabric manager is adding extents to any DCD
> partition, the extent list for the recovered region may change.  In this
> case the query must retry.  Upon retry the query could encounter extents
> which were accepted on a previous list query.  Adding such extents is
> ignored without error because they are entirely within a previous
> accepted extent.
> 
> The scan for existing extents races with the dax_cxl driver.  This is
> synchronized through the region device lock.  Extents which are found
> after the driver has loaded will surface through the normal notification
> path while extents seen prior to the driver are read during driver load.

Ah. So the earlier code to just eat duplicates was to handle this race.
Add a comment there perhaps so people like me get less confused :)

Jonathan

> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


