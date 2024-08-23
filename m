Return-Path: <linux-btrfs+bounces-7457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E852A95D3E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 19:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A529B28472A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DCD18BC25;
	Fri, 23 Aug 2024 17:01:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4A185926;
	Fri, 23 Aug 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432482; cv=none; b=p1Z/yeYGs7IlZOpS9QbvfBPif5wX6h2sjuQZFhaSr6nUA9gf1UUE2hU2Vd9xSFGLOJUE4EokhVibuPDxpcGk8wYamtIfdVmOxKopi4uz5PDqY0KYXbUj2GHTigpL+JS919UfBDfVqHSG8OVevADQJAxAhGptPQtzSOM37X2e9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432482; c=relaxed/simple;
	bh=AJcv/tPtKfv8hd+nhv6iszcG6/a0Ba1YIilo39XftuE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL4p3QVHsd86c3SSUwQ5KKCnuGkbYhbytnoVtVQrBg+uNFshoTF9nkBqsrywUnrl3ZSzIk7rvcnj5vDlDjspY2YrRCCiMqxRS8AhGLMjtZGXIaf9rgRazRKQdm5wQgT9FN5EIPZfTjqXwnPTZblQHoEoOvZUnhO/4MFvPeOZJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr5qT2sswz6K5lm;
	Sat, 24 Aug 2024 00:58:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B0A5140B33;
	Sat, 24 Aug 2024 01:01:18 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 18:01:17 +0100
Date: Fri, 23 Aug 2024 18:01:17 +0100
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
Subject: Re: [PATCH v3 14/25] cxl/events: Split event msgnum configuration
 from irq setup
Message-ID: <20240823180117.00004561@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-14-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-14-7c9b96cba6d7@intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 09:44:22 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
> 
> Split cxl_event_config_msgnums() from irq setup in preparation for
> separate DCD interrupts configuration.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

