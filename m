Return-Path: <linux-btrfs+bounces-8789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A873F99882B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401E11F245B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 13:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533C21CBEB5;
	Thu, 10 Oct 2024 13:46:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF81C9EDC;
	Thu, 10 Oct 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567989; cv=none; b=XX1KYRNPY1nrsGC+LmzzpBdI/Wu+k3jQ+HslFMA59camc0a+gH7A3UX/R2CYofpQ2xrey4xJCJUQztLUWzx4b5mEZt1hBplRBS3ys85TAQ1qj3gFW5N1X1VTxlOsqEtltfxzukRbq3rYSFm6WBJceE8OJNp/jxvO6VAq5fzFfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567989; c=relaxed/simple;
	bh=tduX1cVH5cRmQ/zb5Aub7C4XL6iKaXBAoe6tGLPwXWE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pV+i7cF7EHP4zVeR9dpFxGygy7PoLSvEO+MjRMpOUFfBPH9M4eY5QeXeApzvKt5p4iwIFCAuPgi9ZjvKIHeOGdNtber93dSq+bLsnQ6pNKRpZng+DVWywagFC8acoUqbxeAOelqw0q7T4yMNg/boZUETsJENjDTRab/mFq2jD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPWBz1K6Hz6LDG5;
	Thu, 10 Oct 2024 21:42:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 06F93140AE5;
	Thu, 10 Oct 2024 21:46:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 15:46:23 +0200
Date: Thu, 10 Oct 2024 14:46:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 16/28] cxl/region: Add sparse DAX region support
Message-ID: <20241010144622.00000afe@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-16-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-16-c261ee6eeded@intel.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 07 Oct 2024 18:16:22 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic Capacity CXL regions must allow memory to be added or removed
> dynamically.  In addition to the quantity of memory available the
> location of the memory within a DC partition is dynamic based on the
> extents offered by a device.  CXL DAX regions must accommodate the
> sparseness of this memory in the management of DAX regions and devices.
> 
> Introduce the concept of a sparse DAX region.  Add a create_dc_region()
> sysfs entry to create such regions.  Special case DC capable regions to
> create a 0 sized seed DAX device to maintain compatibility which
> requires a default DAX device to hold a region reference.
> 
> Indicate 0 byte available capacity until such time that capacity is
> added.
> 
> Sparse regions complicate the range mapping of dax devices.  There is no
> known use case for range mapping on sparse regions.  Avoid the
> complication by preventing range mapping of dax devices on sparse
> regions.
> 
> Interleaving is deferred for now.  Add checks.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Looks fine to me, though the DAX bit is not an area I know enough about.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


