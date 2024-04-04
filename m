Return-Path: <linux-btrfs+bounces-3928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D57D898D23
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67131C25D32
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD81712DD9E;
	Thu,  4 Apr 2024 17:19:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B414A8B;
	Thu,  4 Apr 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251195; cv=none; b=Sf0LYT21qNtwR1VTBUmD+e5RF+FcyUTmdAZysFCZBZon1GkHH0knmqCmjdoPek9p2gVljEs7qOQ9EWdOfm069IwG3EQC8Ic7cnbWcDWMy1Azf/tro3uyrrOWu20FZVcIrkK3N9QW9Q0tx4U5FdMOVQ+AulMiet4l0rf2lRfNl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251195; c=relaxed/simple;
	bh=yD9gdc9DZs6Cc5MiJ5TdowOyM3xU2yJ4MReDIH+Q1VY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHMoYFp34GXeR7YSBDfeR5s19I1p6AJWPcxafjxqtnTb/xTQaJR0wBrfO+7A7TWmYGs0/jwJK3Y4MXoo+nLBSBs1jygDgJyu8cKsgKeSICmwZe1xtKmSfXgRJ7Ck989RRa0282FeBmT5xMElVd9T8c+nocdDa9BrtVc+NPOkvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9Sxv3MCmz6J9bQ;
	Fri,  5 Apr 2024 01:18:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 91888140A86;
	Fri,  5 Apr 2024 01:19:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 18:19:50 +0100
Date: Thu, 4 Apr 2024 18:19:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 20/26] dax: Document dax dev range tuple
Message-ID: <20240404181949.0000505b@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-20-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-20-b7b00d623625@intel.com>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:23 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> The device DAX structure is being enhanced to track additional DCD
> information.
> 
> The current range tuple was not fully documented.  Document it prior to
> adding information for DC.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

There is a style convention for nested structs.
Maybe needs tweaking for a pointer like this though... 

Perhaps poke it with kernel-doc script an see what comes out.

https://docs.kernel.org/doc-guide/kernel-doc.html#nested-structs-unions
> 
> ---
> Changes for v1
> [iweiny: new patch]
> ---
>  drivers/dax/dax-private.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index c6319c6567fb..ac1ccf158650 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -70,7 +70,10 @@ struct dax_mapping {
>   * @dev - device core
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
>   * @nr_range: size of @ranges
> - * @ranges: resource-span + pgoff tuples for the instance
> + * @ranges: range tuples of memory used
> + * @pgoff: page offset
> + * @range: resource-span
> + * @mapping: device to assist in interrogating the range layout
>   */
>  struct dev_dax {
>  	struct dax_region *region;
> 


