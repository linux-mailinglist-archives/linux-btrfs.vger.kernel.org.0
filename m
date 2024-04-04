Return-Path: <linux-btrfs+bounces-3916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7432F898AA6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D428FB2A17F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3095C8FE;
	Thu,  4 Apr 2024 15:07:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA36A1BDC4;
	Thu,  4 Apr 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243266; cv=none; b=Pk0iUMGXKQTFCE3y0jmxHQd3jMzat3FhWYmOWOA4UuqxkZVTUNPWeS9dWVVBRSqUTzqHvoFWLY8J7mFN6HbgYU2pO0pwvaukpAKKA/RTqLnNV3YYmunJgNZ8qXtTXLlJWvxRV5ExAMsVzpu/1H9chIXyc1R3S0NpbhrHECY44nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243266; c=relaxed/simple;
	bh=6HTfC8+YFwLrSuzDoKsSVxoX7tFzPMaNNkBIPbjN5vY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trZVw5ONc9nNkdgQZ/1+Z06y4ZPupXNU//v9WqD11pjmqQlnlJGe/CM6wqwWeT+oLu+O7BZsf6+j8Z/vdQikAIDzIXyDgh0eJciXUM561CuNCafiyJef/Bk2rP2SRchvFjWOmv+3SJE8LCDSn0NRKqG/PD0EHUqpshhvuUZXlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9Q1P3Y4Rz6J9Zf;
	Thu,  4 Apr 2024 23:06:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E8A201400DC;
	Thu,  4 Apr 2024 23:07:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 16:07:39 +0100
Date: Thu, 4 Apr 2024 16:07:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/26] cxl/events: Factor out event msgnum configuration
Message-ID: <20240404160738.00006bde@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-10-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-10-b7b00d623625@intel.com>
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

On Sun, 24 Mar 2024 16:18:13 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Dynamic Capacity Devices (DCD) require events to process extent addition
> or removal.  BIOS may have control over memory event processing.
> 
> Factor out cxl_event_config_msgnums() in preparation for setting up DCD
> event interrupts separate from memory events.

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

