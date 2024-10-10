Return-Path: <linux-btrfs+bounces-8791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4836E998954
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BAA1C22196
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8321CEAB8;
	Thu, 10 Oct 2024 14:15:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD41CDA31;
	Thu, 10 Oct 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569723; cv=none; b=mGJ0pQUIrZTDrfX6NVHQXmw0/O3XHdB3oTbDD0j+ESqJ7wm5LAKTFkJnK3LUmK/knZ8bmaOBS8A5RnaVJJ+K+CHlbRFuNPlwneAPwG/efvQMrXjBUtvQ0CPmLwvxw5wMR8OFtKEF7skhnpnztzUFRuwq8gYmeSjL5Wa2tQxFycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569723; c=relaxed/simple;
	bh=nEH18siuFStux35L9J5U0l/9WlbYkdBj5AVCDkC4Bio=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9T82XaVJ6drZN/S/U/jCONoWDsFAXJx3QlmeYTpK66bT9a3XVobcNwz6t9zZC/GX6j7MrUdAG6FmmPq3kvahJqSPnSSPrxBbR6g4MxOQmosybgNRpwtDIb06TQ7ZIiJYjymW12njDUU3pXjCYt9WR/gRJ0NkNmsCi9ZWDcJIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPWrK4cbwz6J7tH;
	Thu, 10 Oct 2024 22:10:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FE94140A78;
	Thu, 10 Oct 2024 22:15:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 16:15:17 +0200
Date: Thu, 10 Oct 2024 15:15:16 +0100
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
Subject: Re: [PATCH v4 19/28] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <20241010151516.00001156@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-19-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-19-c261ee6eeded@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 07 Oct 2024 18:16:25 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism.  The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications.  Firmware can't
> configure DCD events to be FW controlled but can retain control of
> memory events.
> 
> Configure DCD event log interrupts on devices supporting dynamic
> capacity.  Disable DCD if interrupts are not supported.
> 
> Care is taken to preserve the interrupt policy set by the FW if FW first
> has been selected by the BIOS.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Ah. I was wondering why policy needed to be initialize to zero outside
this call.  Maybe moving it in here with a memset() would be cleaner.

Either way
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>




