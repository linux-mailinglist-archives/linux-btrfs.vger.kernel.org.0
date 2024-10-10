Return-Path: <linux-btrfs+bounces-8782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5926C9986A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000B21F23C24
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9301C6F75;
	Thu, 10 Oct 2024 12:51:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8A1C232C;
	Thu, 10 Oct 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564681; cv=none; b=M9IxCZr19B3RIfQuUb9QXzXDyg5aPCqW1WR87MsaRhI4wEks7cFmEHB84akHh/i1kKKV90Ij3nd4teDDimvQlO0zt3mHCmIxJFLJtrVa9Bo1xElJ9zGm3AHALKLhaKNDhn/MlI5KJqMNhBNYhkK7bu9QO4mYSvRTswOaTab/1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564681; c=relaxed/simple;
	bh=kuek4LvQty7bWRHjQpDSPPA/0p7libjuJtkPrGUM6ZA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfeiyqxZAbxOFC5vnjZr8vAtwAmBGqZPOoredMYkTNMjBVuL4hCxyfRGOeu1AF+wanThzWalHmjeUUaain2zB5ARxTdaGL8v8gGxs2gziZKv3WLj5dLxuptf6H66/dPnj30M6dHXGEezTlOR5lj1zD10NTha0tIhG8e7ciinWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPV2q1smPz6K6yr;
	Thu, 10 Oct 2024 20:49:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B02B1400D9;
	Thu, 10 Oct 2024 20:51:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 14:51:15 +0200
Date: Thu, 10 Oct 2024 13:51:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 12/28] cxl/cdat: Gather DSMAS data for DCD regions
Message-ID: <20241010135113.00001135@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 07 Oct 2024 18:16:18 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Additional DCD region (partition) information is contained in the DSMAS
> CDAT tables, including performance, read only, and shareable attributes.
> 
> Match DCD partitions with DSMAS tables and store the meta data.
> 
> To: Robert Moore <robert.moore@intel.com>
> To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> To: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: acpica-devel@lists.linux.dev
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
One trivial comment from me.
As Rafael has raised, the ACPICA dependency in here is
going to be the blocker :(

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +static void update_dcd_perf(struct cxl_dev_state *cxlds,
> +			    struct dsmas_entry *dent)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct device *dev = cxlds->dev;
> +
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		/* CXL defines a u32 handle while cdat defines u8, ignore upper bits */

CDAT

> +		u8 dc_handle = mds->dc_region[i].dsmad_handle & 0xff;
> +
> +		if (resource_size(&cxlds->dc_res[i])) {
> +			struct range dc_range = {
> +				.start = cxlds->dc_res[i].start,
> +				.end = cxlds->dc_res[i].end,
> +			};
> +
> +			if (range_contains(&dent->dpa_range, &dc_range)) {
> +				if (dent->handle != dc_handle)
> +					dev_warn(dev, "DC Region/DSMAS mis-matched handle/range; region %pra (%u); dsmas %pra (%u)\n"
> +						      "   setting DC region attributes regardless\n",
> +						&dent->dpa_range, dent->handle,
> +						&dc_range, dc_handle);
> +
> +				mds->dc_region[i].shareable = dent->shareable;
> +				mds->dc_region[i].read_only = dent->read_only;
> +				update_perf_entry(dev, dent, &mds->dc_perf[i]);
> +			}
> +		}
> +	}
> +}


