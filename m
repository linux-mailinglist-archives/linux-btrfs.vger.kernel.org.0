Return-Path: <linux-btrfs+bounces-8685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C88996A1E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502B61F2392E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294B1946C8;
	Wed,  9 Oct 2024 12:33:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3B192580;
	Wed,  9 Oct 2024 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477206; cv=none; b=jYbXtQX/T0uuqy335dRpBIadnMUBZYRyzhZngjN2jigGfeN0h7U872yTh93fAJLeDQ/+MdUVNnB2kqR5Jh6S8yOSYu5QN7lHwY/MavrKlkOzBVItzPpGYVs1DQih+Ch0o48TKqUn9wzQuj/33iPF4D93WA/ONZC9VJFlIunT0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477206; c=relaxed/simple;
	bh=b65hF2U+3sNGVgnLKjRrxIPVfKhcLDPXgHg5Z42m/Pw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYr9e8k8sOR/8s/dIKBsRBOWYJ2soanv23qB/CED3uP78mrECtx0kjmB8LGy7gQYXwo59WGsxxiJCfvC6cod44p1e1RCpQAycAetII8GMa2wBuUSjWHb2h+Tej06YItcZMEy9rbvvMVg+zzn/feLe/s3YVewo3KVrqPNglYqjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNshj1QFJz6K63T;
	Wed,  9 Oct 2024 20:32:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D2386140A90;
	Wed,  9 Oct 2024 20:33:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 9 Oct
 2024 14:33:21 +0200
Date: Wed, 9 Oct 2024 13:33:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 03/28] cxl/cdat: Use %pra for dpa range outputs
Message-ID: <20241009133320.00006a69@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-3-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-3-c261ee6eeded@intel.com>
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

On Mon, 07 Oct 2024 18:16:09 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Now that there is a printk specifier for struct range use it in
> debug output of CDAT data.
> 
> To: Petr Mladek <pmladek@suse.com>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> To: Sergey Senozhatsky <senozhatsky@chromium.org>
> To: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org (open list)
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

