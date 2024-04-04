Return-Path: <linux-btrfs+bounces-3922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79226898BE1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A843B1C217DC
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06BD12BEAC;
	Thu,  4 Apr 2024 16:13:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCA1BC46;
	Thu,  4 Apr 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247235; cv=none; b=NnyU0qL2jeLw3c1NMiOdFiqq2H4+AOzcC3mjP6sc3FtgxggkEi3XdIG1Z91zdAsz7BA1yT39WdHp3ixxoneYZG84J+UTCxMdLSCMp8MCAXYvc1NhFDgpL6mqeLfkoPJGCubTtiM9GfgpfvPty4P4ZG95kBq5KBr85WV8hURc6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247235; c=relaxed/simple;
	bh=smLC32iJuY0yye4WDyksXPgIINq4NnqEPI4ivboWM28=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzRHX+MjtEhfTvtLrsHb8qrpM28NZ3RDhq3C4iXaywAYj+h1xUHyerEz3CvYXKk8zwaHVecD9eeAvewlBFvptmNNpIr7GSK4scAckWR7N/7JKNRStl6xsu5XnboszZhi7GH2ACjahW8NmLqP1mwfVEj0+FeqH635Ss7IBtU4l1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9RPy0hFNz67kr9;
	Fri,  5 Apr 2024 00:09:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 74C58141546;
	Fri,  5 Apr 2024 00:13:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 17:13:48 +0100
Date: Thu, 4 Apr 2024 17:13:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <20240404171348.00001cd6@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> +static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> +				struct cxl_dc_extent *extent)
> +{
> +	uint64_t start = le64_to_cpu(extent->start_dpa);
> +	uint64_t length = le64_to_cpu(extent->length);
> +	struct range ext_range = (struct range){
space ) {

> +		.start = start,
> +		.end = start + length - 1,
> +	};
> +	struct range ed_range = (struct range) {
> +		.start = cxled->dpa_res->start,
> +		.end = cxled->dpa_res->end,
> +	};

