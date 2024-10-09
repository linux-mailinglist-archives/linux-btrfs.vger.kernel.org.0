Return-Path: <linux-btrfs+bounces-8687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E5996AC2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE32C1C220E6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA721AE864;
	Wed,  9 Oct 2024 12:49:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B75194C76;
	Wed,  9 Oct 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478183; cv=none; b=YzNvdiya+4EGGjBWqyfq1KF6hH96sh+PRFvqdOzVCTmROqP7VcJu+ewPcKR4pIyPUYjZ1L8NYgrgdyZhsU84vuJ3p7pCAef7UPAH1XKFHKPKxPPNTyscGVzXBi2n6FNUjydT5ZtfDnMhB7DJJU2REhaqViKy795K8rFPs2jswCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478183; c=relaxed/simple;
	bh=BaVk3s2KAvoqDvsifoqUDpefeIGff22P2TiuTCvppqk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H16KZ7ut3ss0uf2HGGtq4j99o/gLAcg+l24Uj9kIvK7JNswfiaDFLP+R4Y/Ip+Dw+INVZ+HZzwGqsjTeyTkE8Puw/aGad0dpVGUvKKcv8D8ywbg764PHYxx/iaPtTidvixwkuk16sGGZKpbVLEH+rkJT09nIXR2s6LNJwoNeXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNt4f1v2bz6GD69;
	Wed,  9 Oct 2024 20:49:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B01A140133;
	Wed,  9 Oct 2024 20:49:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 9 Oct
 2024 14:49:38 +0200
Date: Wed, 9 Oct 2024 13:49:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, "Li, Ming" <ming4.li@intel.com>
Subject: Re: [PATCH v4 08/28] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <20241009134936.00003e0e@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-8-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-8-c261ee6eeded@intel.com>
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

On Mon, 07 Oct 2024 18:16:14 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Devices which optionally support Dynamic Capacity (DC) are configured
> via mailbox commands.  CXL 3.1 requires the host to issue the Get DC
> Configuration command in order to properly configure DCDs.  Without the
> Get DC Configuration command DCD can't be supported.
> 
> Implement the DC mailbox commands as specified in CXL 3.1 section
> 8.2.9.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information.  Disable DCD if DCD is not supported.  Leverage the Get DC
> Configuration command supported bit to indicate if DCD support.
> 
> Linux has no use for the trailing fields of the Get Dynamic Capacity
> Configuration Output Payload (Total number of supported extents, number
> of available extents, total number of supported tags, and number of
> available tags). Avoid defining those fields to use the more useful
> dynamic C array.
> 
> Cc: "Li, Ming" <ming4.li@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks fine to me.  Trivial comment inline
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e8907c403edb..0690b917b1e0 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
...

> +/* See CXL 3.1 Table 8-164 get dynamic capacity config Output Payload */
> +struct cxl_mbox_get_dc_config_out {
> +	u8 avail_region_count;
> +	u8 regions_returned;
> +	u8 rsvd[6];
> +	/* See CXL 3.1 Table 8-165 */
> +	struct cxl_dc_region_config {
> +		__le64 region_base;
> +		__le64 region_decode_length;
> +		__le64 region_length;
> +		__le64 region_block_size;
> +		__le32 region_dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed region[];

Could throw in a __counted_by I think?

> +	/* Trailing fields unused */
> +} __packed;
> +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> +#define CXL_DCD_BLOCK_LINE_SIZE 0x40

