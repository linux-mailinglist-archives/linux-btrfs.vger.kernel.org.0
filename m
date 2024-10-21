Return-Path: <linux-btrfs+bounces-9027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FD79A6C9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0EDB254E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9A1FA251;
	Mon, 21 Oct 2024 14:47:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE02225D6;
	Mon, 21 Oct 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522076; cv=none; b=h/ZtCklw8PQxJoQ8NuHypJklJBRZ9kixdaJq6gijC8tT4+Hks6LJyS12rqtqK6SKshIu3agB+xfvyhMx4PPvHG5IS61bxxGdrzR+BOUBBzlh4+A9Ax/mpdsJIt1emLNmKYOctA7KFM7Opja4gjz9xkTkPCnBag3/GCrAfVRskLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522076; c=relaxed/simple;
	bh=ZOSS2hOM8T08mcDGkrpsqNLlWsIDkx5JSsR2TyOeeQ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWaLd55pMDpBxTm4tznwp6kPRnfhJJUYBCX/5ORdmdbTzcwwvscOTwo+TuAxoGKUfwy9fIzOuDliCcbB/1o+jy2hw/phHPpQrrHJENzGKvzgWmmoG/h9/jJjCXJYURfbP10lDzpIS5YIkYx84hhAol9sFAtas8zoofKv0yirZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXJ5Z5zgxz6G8yg;
	Mon, 21 Oct 2024 22:45:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CD1E6140A30;
	Mon, 21 Oct 2024 22:47:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Oct
 2024 16:47:51 +0200
Date: Mon, 21 Oct 2024 15:47:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: "Li, Ming4" <ming4.li@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Fan
 Ni" <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <20241021154749.00003e22@Huawei.com>
In-Reply-To: <67165f7447c77_8cb17294f0@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
	<4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
	<6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
	<20241010155014.00004bdd@Huawei.com>
	<67117e57479b3_2cee2942d@iweiny-mobl.notmuch>
	<20241018100307.000008a9@Huawei.com>
	<67165f7447c77_8cb17294f0@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

<snip>
              
> > 
> > 
> > Alternative form for what you have...  
> 
> Sure but lots of indentation on the common path which I have grown
> to avoid...  :-/
> 
> Looking at this fresh...  A helper function works best.
Agreed this looks better


Jonathan

