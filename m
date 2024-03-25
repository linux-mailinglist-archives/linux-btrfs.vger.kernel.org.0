Return-Path: <linux-btrfs+bounces-3556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E108088AB76
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 18:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB4A2A7F87
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2412D1EC;
	Mon, 25 Mar 2024 16:11:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5579D3;
	Mon, 25 Mar 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383072; cv=none; b=UlDx8gpJ8LBt9IEjacuIvv0OszUA0OEQimGdTJ2J/JSVYoQTYfn85rowSzIOym14g5p/SXKyki9U9gZ+4mU6XBaGGARs4YUo7o1Qls/FAJjwlvNKuFrUFNcKu4jVLZQPr1V4veybPhAzHdi2sfI05uGekDoimNMk6PRagw4Hb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383072; c=relaxed/simple;
	bh=e6PTf8m/SdwclEKU0xg7xc3gQO12sSEwiHUQ7QTw0os=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dr1X4VWX4pcEibZKqJHgioS2nU0K1xrenyuPRgCpYPz4f5afTZbmtEiXaMufXivy2MRJoWD4MW4y50LtomdP5C5EPVtBbg9jbwsB4/vEI13NqMiq9w+LfM4vaeCdN5TXPBboWLZVg52AnwiDO/KjkWaJrn5TPhDKmfEwG1O3I5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3Hql1KNtz67CxC;
	Tue, 26 Mar 2024 00:06:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BC5E140D1D;
	Tue, 26 Mar 2024 00:11:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 16:11:07 +0000
Date: Mon, 25 Mar 2024 16:11:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/26] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <20240325161106.00006041@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
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

On Sun, 24 Mar 2024 16:18:04 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Per the CXL 3.1 specification software must check the Command Effects
> Log (CEL) to know if a device supports dynamic capacity (DC).  If the
> device does support DC the specifics of the DC Regions (0-7) are read
> through the mailbox.
> 
> Flag DC Device (DCD) commands in a device if they are supported.
> Subsequent patches will key off these bits to configure DCD.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
This aligns with similar existing code etc and the opcodes are right so
There is a vague argument that maybe we shouldn't claim to support the
command in the debug message at that point in the patch set, but I don't
think we really care either way as expectation is this set should go
in all together.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


