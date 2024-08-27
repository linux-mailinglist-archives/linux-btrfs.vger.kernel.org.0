Return-Path: <linux-btrfs+bounces-7565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7C4960DC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24C7284FA5
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 14:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C731C57BA;
	Tue, 27 Aug 2024 14:39:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA391C57A0;
	Tue, 27 Aug 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769593; cv=none; b=jK25NDX3VZ+haLDJ5kD+qqgt+YuCJg87NYpZBZv4yN43SWozd92Mah5bZHMkgpdfejkHf3Hw/qeVZXa8oaDHDiIxRLzDaKZpN8kRn4FKOLEqgYx0pmVlDbECxZEXSZf9Czdu6SYirVQj8Szoh8odqA+XTG7JjtGjjkkbBCvYZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769593; c=relaxed/simple;
	bh=ycBV1GwfJbUzMLkqjFSOpR9l/UgpJd2KCvbAx7tUV6E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/T/C5T2cZgaQXomsxIDAAYbyzgJjBMg2BJzFk6vPXVtEO7fL6Eh92WZMwOT7syGmUCO2cul8cQF56yVtU2THJQXskSFKMcoLOjwnwc6h32aGIUSEro6tyIN6FZPsHksKYTFgYsvV847tz3djq+Mmi4YElirOPa/xqjaAYPA63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtVTL1m2Tz6J7Bw;
	Tue, 27 Aug 2024 22:35:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A526A140C98;
	Tue, 27 Aug 2024 22:39:48 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 15:39:47 +0100
Date: Tue, 27 Aug 2024 15:39:47 +0100
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
Subject: Re: [PATCH v3 25/25] tools/testing/cxl: Add DC Regions to mock mem
 data
Message-ID: <20240827153947.000077a8@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-25-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-25-7c9b96cba6d7@intel.com>
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

On Fri, 16 Aug 2024 09:44:33 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> cxl_test provides a good way to ensure quick smoke and regression
> testing.  The complexity of Dynamic Capacity (DC) extent processing as
> well as the complexity of the new sparse DAX regions can mostly be
> tested through cxl_test.  This includes management of sparse regions and
> DAX devices on those regions; the management of extent device lifetimes;
> and the processing of DCD events.
> 
> The only missing functionality from this test is actual interrupt
> processing.
> 
> Mock memory devices can easily mock DC information and manage fake
> extent data.
> 
> Define mock_dc_region information within the mock memory data.  Add
> sysfs entries on the mock device to inject and delete extents.
> 
> The inject format is <start>:<length>:<tag>:<more_flag>
> The delete format is <start>:<length>
> 
> Directly call the event irq callback to simulate irqs to process the
> test extents.
> 
> Add DC mailbox commands to the CEL and implement those commands.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Minor stuff inline.

Thanks,

Jonathan

> +static int mock_get_dc_config(struct device *dev,
> +			      struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_get_dc_config_in *dc_config = cmd->payload_in;
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	u8 region_requested, region_start_idx, region_ret_cnt;
> +	struct cxl_mbox_get_dc_config_out *resp;
> +	int i;
> +
> +	region_requested = dc_config->region_count;
> +	if (region_requested > NUM_MOCK_DC_REGIONS)
> +		region_requested = NUM_MOCK_DC_REGIONS;

	region_requested = min(...)

> +
> +	if (cmd->size_out < struct_size(resp, region, region_requested))
> +		return -EINVAL;
> +
> +	memset(cmd->payload_out, 0, cmd->size_out);
> +	resp = cmd->payload_out;
> +
> +	region_start_idx = dc_config->start_region_index;
> +	region_ret_cnt = 0;
> +	for (i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
> +		if (i >= region_start_idx) {
> +			memcpy(&resp->region[region_ret_cnt],
> +				&mdata->dc_regions[i],
> +				sizeof(resp->region[region_ret_cnt]));
> +			region_ret_cnt++;
> +		}
> +	}
> +	resp->avail_region_count = NUM_MOCK_DC_REGIONS;
> +	resp->regions_returned = i;
> +
> +	dev_dbg(dev, "Returning %d dc regions\n", region_ret_cnt);
> +	return 0;
> +}



> +static void cxl_mock_mem_remove(struct platform_device *pdev)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(&pdev->dev);
> +	struct cxl_memdev_state *mds = mdata->mds;
> +
> +	dev_dbg(mds->cxlds.dev, "Removing extents\n");

Clean this up as it doesn't do anything!

> +}
> +

> @@ -1689,14 +2142,261 @@ static ssize_t sanitize_timeout_store(struct device *dev,
>  
>  	return count;
>  }
> -
Grump ;)  No whitespace changes in a patch doing anything 'useful'.
>  static DEVICE_ATTR_RW(sanitize_timeout);
>  

> +static int log_dc_event(struct cxl_mockmem_data *mdata, enum dc_event type,
> +			u64 start, u64 length, const char *tag_str, bool more)
> +{
> +	struct device *dev = mdata->mds->cxlds.dev;
> +	struct cxl_test_dcd *dcd_event;
> +
> +	dev_dbg(dev, "mock device log event %d\n", type);
> +
> +	dcd_event = devm_kmemdup(dev, &dcd_event_rec_template,
> +				     sizeof(*dcd_event), GFP_KERNEL);
> +	if (!dcd_event)
> +		return -ENOMEM;
> +
> +	dcd_event->rec.flags = 0;
> +	if (more)
> +		dcd_event->rec.flags |= CXL_DCD_EVENT_MORE;
> +	dcd_event->rec.event_type = type;
> +	dcd_event->rec.extent.start_dpa = cpu_to_le64(start);
> +	dcd_event->rec.extent.length = cpu_to_le64(length);
> +	memcpy(dcd_event->rec.extent.tag, tag_str,
> +	       min(sizeof(dcd_event->rec.extent.tag),
> +		   strlen(tag_str)));
> +
> +	mes_add_event(mdata, CXL_EVENT_TYPE_DCD,
> +		      (struct cxl_event_record_raw *)dcd_event);
I guess this is where the missing event in previous patch come from.

Increment the number here, not back in that patch.

Jonathan


