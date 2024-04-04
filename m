Return-Path: <linux-btrfs+bounces-3911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423868984F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 12:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AE5288B0C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C0D7640E;
	Thu,  4 Apr 2024 10:26:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCAE76028;
	Thu,  4 Apr 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226394; cv=none; b=d2Cq/pl0DQyqQwNihl+ljtl9+B/dTtq6AnSop/KGZzKDgaYMdLK1pXlIkQC/TL9TqCcenAnZhh226l05qJXG8dKFzB2P7MngK8+twdXC5S79qVDk2YpbnjZ5VdarxBKAJrRRFG2TRZFKGJkH7oGccqp7ewuu7A1zRQhqz2NoshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226394; c=relaxed/simple;
	bh=mp9N14PVOm0pDhIFYCwd2DzvxM12B5Bpbgg+kpgmT1w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrSYJEqjFhSuYw85zu6FzaaJ0IFT2IhUm2/fLWeSYlyoh4gID/mxp5biNhwz68XBkG1In5rOVBe5mz/aI/NCJMoYn15dO1N/5+KSGP8AUAFFgk1lIYpakOtJnFsrU1zeXz6+4NyD/T7yAdx4BuZs2ndN6YvWiQnG5jIu9wWxFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9Hmz2h71z6HJqS;
	Thu,  4 Apr 2024 18:25:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E78C140C72;
	Thu,  4 Apr 2024 18:26:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 11:26:28 +0100
Date: Thu, 4 Apr 2024 11:26:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/26] cxl/region: Add Dynamic Capacity CXL region
 support
Message-ID: <20240404112628.0000633d@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:12 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> CXL devices optionally support dynamic capacity.  CXL Regions must be
> configured correctly to access this capacity.  Similar to ram and pmem
> partitions, DC Regions, as they are called in CXL 3.1, represent
> different partitions of the DPA space.
> 
> Introduce the concept of a sparse DAX region.  Add the create_dc_region
> sysfs entry to create sparse DC DAX regions.  Special case DC capable
> regions to create a 0 sized seed DAX device to maintain backwards
> compatibility with older software which needs a default DAX device to
> hold the region reference.
> 
> Flag sparse DAX regions to indicate 0 capacity available until such time
> as DC capacity is added.
> 
> Interleaving is deferred in this series.  Add an early check.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
With the -EBUSY others addressed LGTM.  Fan's duplication comment
might be something to tidy up later.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

