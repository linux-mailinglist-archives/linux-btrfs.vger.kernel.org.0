Return-Path: <linux-btrfs+bounces-3919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 269AC898AFE
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 17:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94B01F2B1E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FB21292E5;
	Thu,  4 Apr 2024 15:22:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829354905;
	Thu,  4 Apr 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244173; cv=none; b=moDvLx796axkDjFTkt7ac8CYQpzl5hScZPwCztOIVnN8TNgJ7rYltD5JeNGd3TQvUkG6CpL0ATdFYzIOXKjHN1j9EfAsd8Q5cZYUPGQQlr4Fv3j8RhOanF5l7q3UoVFqmKh/13XOJCLXn1qfkx8kKjKftI0sArRC4TPtqrYGLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244173; c=relaxed/simple;
	bh=pbUrWoLTt60RMl4SBLLdVoc3LE5DMHxvXjAxlhr3pLQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Efle/ojEaYo0WdJgyB2mwcRuy8FTXZ4d/eWXfqft5omapH13LZ4hV1nIXHSCUbPErRDKIFuZ0q9+62H+ujzCvSllKsKBfNqllaqBj+iNq6DDX1V46wGxOvIyEr3vz3gYWxJUEWyDMuis7mOk4SebX8iDd2BwFd/DSnHaVXUAMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9QH34qBCz6J7YY;
	Thu,  4 Apr 2024 23:18:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 028B5140A87;
	Thu,  4 Apr 2024 23:22:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 16:22:46 +0100
Date: Thu, 4 Apr 2024 16:22:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/26] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <20240404162245.000032f3@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:16 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism.  The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications.
> 
> Firmware can't configure DCD events to be FW controlled but can retain
> control of memory events.  Split irq configuration of memory events and
> DCD events to allow for FW control of memory events while DCD is host
> controlled.
> 
> Configure DCD event log interrupts on devices supporting dynamic
> capacity.  Disable DCD if interrupts are not supported.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Trivial comment inline and Fan's suggestion on the debug print seems sensible
to me. Either way

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  /**
>   * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 15d418b3bc9b..d585f5fdd3ae 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -164,11 +164,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
>  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
>  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
>  
>  #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
>  				 CXLDEV_EVENT_STATUS_WARN |	\
>  				 CXLDEV_EVENT_STATUS_FAIL |	\
> -				 CXLDEV_EVENT_STATUS_FATAL)
> +				 CXLDEV_EVENT_STATUS_FATAL|	\

Space after L
You could realign the others but I wouldn't bother.


> +				 CXLDEV_EVENT_STATUS_DCD)




