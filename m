Return-Path: <linux-btrfs+bounces-7441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880BA95D162
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7542284133
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD5D1891BB;
	Fri, 23 Aug 2024 15:29:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B291885AF;
	Fri, 23 Aug 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426969; cv=none; b=oq5rCO8g6y4Ik3u34q6FwKYO2a5p4j61tLV24AkkEljiN5EAoDUof0ueVcCanRCm127SB6fROMSW4VaMnSj4e13rE5lwaHMLQpzr1syVlAzZs9wmsnybOl72RU0u5l594AkPatzlvo/5VGFmYFVXsvogozHLGD+c2nD38KkvdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426969; c=relaxed/simple;
	bh=vNWE4X7Od6kSV4yDxo0oIPx0nA4irekSzmDpa0S/wGY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFCFvffeiN+SI0VusYIYeGvEu4k5AyL5zZmOJQvhsJgenbWETow8Q9/kMnHfyGizfycJjUZRCyRQkuxQdvXgUzvsD8ro6bWRPxu7A7Cu9HBgtbvp7Xbe0EMjbOVn9kF14A+WH3YWSS2pcWQ8LGuP/3+RZTY2PMJ0li7fnEpZIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr3nK21MZz6K92Z;
	Fri, 23 Aug 2024 23:26:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 50064140D1A;
	Fri, 23 Aug 2024 23:29:22 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 16:29:20 +0100
Date: Fri, 23 Aug 2024 16:29:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
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
Subject: Re: [PATCH v3 03/25] dax: Document dax dev range tuple
Message-ID: <20240823162919.000029e5@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-3-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-3-7c9b96cba6d7@intel.com>
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

On Fri, 16 Aug 2024 09:44:11 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> The device DAX structure is being enhanced to track additional DCD
> information.
> 
> The current range tuple was not fully documented.  Document it prior to
> adding information for DC.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [iweiny: move to start of series]
> ---
>  drivers/dax/dax-private.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 446617b73aea..ccde98c3d4e2 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -58,7 +58,10 @@ struct dax_mapping {
>   * @dev - device core
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
>   * @nr_range: size of @ranges
> - * @ranges: resource-span + pgoff tuples for the instance
> + * @ranges: range tuples of memory used
> + * @pgoff: page offset
> + * @range: resource-span
> + * @mapping: device to assist in interrogating the range layout
I think the kernel doc format for this should be
@ranges.pgoff: etc
https://docs.kernel.org/doc-guide/kernel-doc.html#nested-structs-unions

Though not quite sure what happens for pointers to structures, maybe
this is correct as it stands?

>   */
>  struct dev_dax {
>  	struct dax_region *region;
> 


