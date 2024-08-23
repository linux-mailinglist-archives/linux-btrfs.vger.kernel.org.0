Return-Path: <linux-btrfs+bounces-7461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593395D429
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 19:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C502A2848AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2018EFC9;
	Fri, 23 Aug 2024 17:19:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80564188A1A;
	Fri, 23 Aug 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433548; cv=none; b=eG8nZLQbvEHKUEhHX5WJ9moz6kOEKw8jcKMTzPaxJU6l08jCVI7+j1Nk5zadqa0y3pxpUnbZWIzaQ8QLUbn/m45uIKTlKE+izzD6MSTyghNdZ5VsCE3ApRjmnFkfp7k4k25oY39nuadNSHmnFKZ52mK+2wisa1pmIZtjCTCeyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433548; c=relaxed/simple;
	bh=9YcnjxOmPwgsEbTMkN8O2cu3lgxmm8MAhniHGU3e9ic=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaUjZDjUcaNuZxxSsEbO9sBFQHhD35rdXlzFjjK9U4ls1L5UnfkKCN0VR2YsI9JbZKkyAFX5Kc8GtSi2Wf+C7L86D0eYYhiK79lfQNNgg96VxcnVu3r2A+M0RFeKrNczzZWsd9qARI32Yfd5FvBuiqaYBCqbgsYxO2Jz1SWaRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr6CB5gLkz6J6xf;
	Sat, 24 Aug 2024 01:15:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 778E9140447;
	Sat, 24 Aug 2024 01:19:04 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 18:19:03 +0100
Date: Fri, 23 Aug 2024 18:19:03 +0100
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
Subject: Re: [PATCH v3 19/25] cxl/region/extent: Expose region extent
 information in sysfs
Message-ID: <20240823181903.000064c2@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-19-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-19-7c9b96cba6d7@intel.com>
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

On Fri, 16 Aug 2024 09:44:27 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Extent information can be helpful to the user to coordinate memory usage
> with the external orchestrator and FM.
> 
> Expose the details of region extents by creating the following
> sysfs entries.
> 
>         /sys/bus/cxl/devices/dax_regionX/extentX.Y
>         /sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
>         /sys/bus/cxl/devices/dax_regionX/extentX.Y/length
>         /sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
LGTM with or without the docs split.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



