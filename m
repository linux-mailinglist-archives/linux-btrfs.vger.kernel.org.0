Return-Path: <linux-btrfs+bounces-3931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F820898D7F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 19:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31FA1F29386
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E112FB1E;
	Thu,  4 Apr 2024 17:49:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBC12CDAE;
	Thu,  4 Apr 2024 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252949; cv=none; b=iZPk+ea/8e0ITs44WubCCqFmu/WT544+ullBuEjabgJ7xmIkpBkOTiFDYvmFNIu73UT0ZaC1Sd75VbcCsofJPRtgm1d2YL+shbK3k8XRePRTIGMljoPA53zHU61YvpxKHisdFKQ8KvQNJAsw/Y42vSqKfxX4cP3d/4W04BxNcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252949; c=relaxed/simple;
	bh=H8se5+kd6ksm1gohnXEwyKYq8XehoQCbyLFZucTxlPM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW16NgBWy8Q2w7ZeOj8EngPtVrErQj0FRIhytkKgOe7B8SPKjzPBoui4AdKUEyw+OHnH0KNdrVUFBc1rOJO3U7wLNxEu/V1HvpcCulgM5abmavHLb2bRNncBWMeL4OJ2kgzM8zeEgxUPpaGcS5zdrmlzUrS7xvGF0I0e/33lt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9TWq47Sfz6K6wd;
	Fri,  5 Apr 2024 01:44:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E9A21400D4;
	Fri,  5 Apr 2024 01:49:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 18:49:02 +0100
Date: Thu, 4 Apr 2024 18:49:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <20240404184901.00002104@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)


> 
> Fan Ni's latest v5 of Qemu DCD was used for testing.[2]
Hi Ira, Navneet.
> 
> Remaining work:
> 
> 	1) Integrate the QoS work from Dave Jiang
> 	2) Interleave support


More flag.  This one I think is potentially important and don't
see any handling in here.

Whilst an FM could in theory be careful to avoid sending a
sparse set of extents, if the device is managing the memory range
(which is possible all it supports) and the FM issues an Initiate Dynamic
Capacity Add with Free (again may be all device supports) then we
can't stop the device issuing a bunch of sparse extents.

Now it won't be broken as such without this, but every time we
accept the first extent that will implicitly reject the rest.
That will look very ugly to an FM which has to poke potentially many
times to successfully allocate memory to a host.

I also don't think it will be that hard to support, but maybe I'm
missing something? 

My first thought is it's just a loop in cxl_handle_dcd_add_extent()
over a list of extents passed in then slightly more complex response
generation.

I don't want this to block getting initial DCD support in but it
will be a bit ugly if we quickly support the more flag and then end
up with just one kernel that an FM has to be careful with...

Jonathan

