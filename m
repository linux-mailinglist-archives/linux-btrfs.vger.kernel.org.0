Return-Path: <linux-btrfs+bounces-9095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A569AC8D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 13:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EECB236D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44105199384;
	Wed, 23 Oct 2024 11:22:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5770154439;
	Wed, 23 Oct 2024 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682533; cv=none; b=lub6637LkqAeV+F70DqkFx2NZUFm4dYtEBixtqEq1tJOdoXtb9PG7Jg3PmvH4uod0tStaACVyrOySeBFhoWsrAJVFJXtPuE/3ueuJL+QAM+DreKsAjlGRFq90R/eLWRo+5OhdNFnXsq3SaI88YXV2KiIpKLsB6aN3iMvL+Td2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682533; c=relaxed/simple;
	bh=64C3SPxTd7AQQp65zjJ4dsy+GxKDPAo+C0dNOzIWPkw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXPPKGm3nqxRcauuWItyrCqFnyAHmyRaC3tvE/fv4yKwN1bhn9NVimLCCOGZqGWB/dW3ZhUCOW+bwBy0Va81OSWN3k9DXI2OLNSaRUairq3Z3czacOt/wgLvOXUXyOYLLxWxKDo0aZeFeKYWJuehMZcmcJoEOGN4Jk0+/GfGPpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XYRR45Ft1z6FCrJ;
	Wed, 23 Oct 2024 19:20:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A5D3714022E;
	Wed, 23 Oct 2024 19:22:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Oct
 2024 13:22:02 +0200
Date: Wed, 23 Oct 2024 12:22:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 24/28] dax/region: Create resources on sparse DAX
 regions
Message-ID: <20241023122201.000005a4@Huawei.com>
In-Reply-To: <67184f4ef593_7253d294d5@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-24-c261ee6eeded@intel.com>
	<20241010162745.00007b31@Huawei.com>
	<67184f4ef593_7253d294d5@iweiny-mobl.notmuch>
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
 frapeml500008.china.huawei.com (7.182.85.71)


> > > +EXPORT_SYMBOL_GPL(dax_region_add_resource);  
> > Adding quite a few exports. Is it time to namespace DAX exports?
> > Perhaps a follow up series.  
> 
> Perhaps.  The calls have a dax_ prefix.  In addition, I thought use of the
> export namespaces were out of favor?

I guess I missed a change in the wind.
Any references?


Jonathan

