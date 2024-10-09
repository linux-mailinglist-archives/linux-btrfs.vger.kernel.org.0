Return-Path: <linux-btrfs+bounces-8684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E529969F6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611841F23C75
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A4194096;
	Wed,  9 Oct 2024 12:27:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AF193078;
	Wed,  9 Oct 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476864; cv=none; b=kZuncqsI9XzNrySitCjZVHCqO8wFneAqp6P209pHBToWJX8NU/2TGJL5UXsBM7Bwp6lP5zIRUm1euK1FrDPQrpqQ0IwwOVNLQb5gA4nydx3N4PqJpl+PCO1QUs1T3O0x/H0zcyipjLkHLyXd7UnIuRA/MrAcIwNccHxeCV81c1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476864; c=relaxed/simple;
	bh=TQgk9wHKP8uEeuStVa+AK8szS3Jtpcul4x79xd0MLxo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUD25TLDdbdCaQ0oTKNgRpg0nEOlEtjrzooA/qgre6U+VJBcJuE6O/PNoRkUO8VwCsVzmXxzbNy1YVwpTbCOUuLBeyJLfOLK4iwfXQ+UCvG5xBN3LYRvPQ+QZRqv3J8B1NzxOuNk/PopFZllrO/rhTt72sTuD+ZGwG6uy1ygbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNsVd4CvPz67cSV;
	Wed,  9 Oct 2024 20:23:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D63BC14058E;
	Wed,  9 Oct 2024 20:27:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 9 Oct
 2024 14:27:39 +0200
Date: Wed, 9 Oct 2024 13:27:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Fan
 Ni" <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 02/28] printk: Add print format (%pra) for struct
 range
Message-ID: <20241009132737.000046ca@Huawei.com>
In-Reply-To: <ZwVkNNpVrJ4lHQ8p@black.fi.intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
	<ZwVkNNpVrJ4lHQ8p@black.fi.intel.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 19:56:20 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Oct 07, 2024 at 06:16:08PM -0500, Ira Weiny wrote:
> > The use of struct range in the CXL subsystem is growing.  In particular,
> > the addition of Dynamic Capacity devices uses struct range in a number
> > of places which are reported in debug and error messages.
> > 
> > To wit requiring the printing of the start/end fields in each print
> > became cumbersome.  Dan Williams mentions in [1] that it might be time
> > to have a print specifier for struct range similar to struct resource
> > 
> > A few alternatives were considered including '%par', '%r', and '%pn'.
> > %pra follows that struct range is similar to struct resource (%p[rR])
> > but need to be different.  Based on discussions with Petr and Andy
> > '%pra' was chosen.[2]
> > 
> > Andy also suggested to keep the range prints similar to struct resource
> > though combined code.  Add hex_range() to handle printing for both
> > pointer types.  
> 
> ...
> 
> > +static void __init
> > +struct_range(void)
> > +{
> > +	struct range test_range = {
> > +		.start = 0xc0ffee00ba5eba11,
> > +		.end = 0xc0ffee00ba5eba11,
> > +	};  
> 
> A side note, can we add something like
> 
> #define DEFINE_RANGE(start, end)	\
> 	(struct range) {		\
> 		.start = (start),	\
> 		.end = (end),		\
> 	}
> 
> in range.h and use here and in the similar cases?

DEFINE_XXXX at least sometimes is used in cases that create the
variable as well.  E.g. DEFINE_MUTEX()

INIT_RANGE() maybe?


