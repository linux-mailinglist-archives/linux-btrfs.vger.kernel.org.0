Return-Path: <linux-btrfs+bounces-3560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D23FB88B59E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46235B28CA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB98134C6;
	Mon, 25 Mar 2024 17:46:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA578F48;
	Mon, 25 Mar 2024 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388777; cv=none; b=n7t3NFYKlUeOtk4n6EXOX6g5JCCy1/adEIPvydhiMRTdtz5ne96QYyTD0D6gBMaFv7OpErFpSz9AjrKJ5HiHacmPpGhGNa6pZLGNXwKbLZUMUiYvUflZHvac726xiJI7WYFRSm9zEvT1jB/EdsQzTe20UWdQaxOwNkzyheplFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388777; c=relaxed/simple;
	bh=ZJ8ukYnDZoEFr9eoi9abepsnBhzy11uF5svrMsTITIE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYCNqqfWJMsHrBqYUi2aJj/X+sTBJRFGsUe+GMB+fT9+zx0eOPS6f2dq8cv6rguuaiS2iwjEhW6nrmjNVmhcaJp7xOm4zcnZdoB1w9WD0bxvJkoOYrab2PwTUtb+fjFodIa15I9ziR+dDOOc6Driiz3rDW/Ok7rNOdoLafegO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3KxS3XGnz67mnJ;
	Tue, 26 Mar 2024 01:41:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0428B1400DC;
	Tue, 26 Mar 2024 01:46:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 17:46:12 +0000
Date: Mon, 25 Mar 2024 17:46:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <20240325174611.00006e0c@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:08 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> cxl_dpa_set_mode() checks the mode for validity two times, once outside
> of the DPA RW semaphore and again within.  The function is not in a
> critical path.  Prior to Dynamic Capacity the extra check was not much
> of an issue.  The addition of DC modes increases the complexity of
> the check.
> 
> Simplify the mode check before adding the more complex DC modes.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Nice. Maybe drag this earlier in series so it could potentially be
picked up as a cleanup?  Same with patch 2 potentially.
If Dave is fine with doing that sort of precursor patches going
earlier, it will save carrying quite so many in this series for
future versions (and make it look less terrifying :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


