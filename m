Return-Path: <linux-btrfs+bounces-3906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E14F898355
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2D31C26A6B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB871B27;
	Thu,  4 Apr 2024 08:44:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74E59B61;
	Thu,  4 Apr 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220269; cv=none; b=K4Sfhr9Ia/BV3u6fbDXZDyUvePikFIrRUiu9XHP0b5ErCnYPV04mWUBVBpGVUflj4szZfk3WaNTpw07hcE/bxT4GzVxMRQ+jdHXvmTVpR2PviQcGZ/Ok7t9xx22jtLwgCF7uQdMYeQwuL4tqN2VKEE+YWB1+WcXo+YANo80LZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220269; c=relaxed/simple;
	bh=BcdZknaQF2gm2/CUy0K8n7HnhaH5F3abfzSXR1LizX0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nw3c6CvpMwDqUQjQeosMh8nSDKeNWGM+tVC2t3/qdbztBpTpxyi9L2rjcBHwfGJ7JFghz7O4E6R1TGzIl6Ur+p7pH4lZODJ7dbtIvxZA9wdpZKu0npYIW4zpxf7r4ES3B+smsz3RR37LPJ8u9hKCdSmjXNcRNPLGdEurk9/reRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9FRN5kTQz6D92t;
	Thu,  4 Apr 2024 16:39:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B5A8C140B35;
	Thu,  4 Apr 2024 16:44:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 09:44:23 +0100
Date: Thu, 4 Apr 2024 09:44:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/26] cxl/mem: Expose device dynamic capacity
 capabilities
Message-ID: <20240404094422.00004a13@Huawei.com>
In-Reply-To: <ZgMUTq6HasHOiR15@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-8-b7b00d623625@intel.com>
	<w4jkueqpvh7hzbywk42m7gxclg56nbgzhaqcgeb3q2b6dt3w6n@5vwicganqpsu>
	<ZgMUTq6HasHOiR15@debian>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 26 Mar 2024 11:30:38 -0700
fan <nifan.cxl@gmail.com> wrote:

> On Mon, Mar 25, 2024 at 04:40:16PM -0700, Davidlohr Bueso wrote:
> > On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:
> >   
> > > +What:		/sys/bus/cxl/devices/memX/dc/region_count
> > > +Date:		June, 2024
> > > +KernelVersion:	v6.10
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) Number of Dynamic Capacity (DC) regions supported on the
> > > +		device.  May be 0 if the device does not support Dynamic
> > > +		Capacity.  
> > 
> > If dcd is not supported then we should not have the dc/ directory
> > altogether.
> > 
> > Thanks,
> > Davidlohr   
> 
> I also think so. However, I also noticed one thing (not DCD related).
> Even for a PMEM device, for example, we have a ram directory under the
> device directory.

True, but it's new ABI so we don't have to copy and Dan's patch to
allow for hiding static attribute directories has landed in the meantime.
So I vote for hiding it.

> 
> ===================
> root@DT:~# cxl list
> [
>   {
>     "memdev":"mem0",
>     "pmem_size":536870912,
>     "serial":0,
>     "host":"0000:0d:00.0"
>   }
> ]
> root@DT:~# ls /sys/bus/cxl/devices/mem0/
> dc  dev  driver  firmware  firmware_version  label_storage_size  numa_node  payload_max  pmem  pmem0  ram  security  serial  subsystem	trigger_poison_list  uevent
> root@DT:~#
> ===================
> 
> Fan
> 


