Return-Path: <linux-btrfs+bounces-4116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094A89FF55
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 20:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0224288D9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66417F39C;
	Wed, 10 Apr 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqWu4Yy5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616E17B519;
	Wed, 10 Apr 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772067; cv=none; b=CuQCQpHC7408xeJs23zcPlsfBTK/Eky86rbEc22MYLEPWJwYkeYuTEtbxK+aU4eiQISX0iRvzZ/PL7InduSxIy32DypVnw3DDfPiUJO9mEyXAC7LbI812lNYW2GT1yc+7DbuO8xONIuSxpiljsLTA1U4PnPZl2cchHoghULAvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772067; c=relaxed/simple;
	bh=m7vzr6Xsp6x0UdSPwpx85bTxXCe++bmRp1TOsXgox2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0sHrCCej9gWB8fWdH5tjzer1kjtToJJzn8VtTZTW4iE69KkAMuxQpcprYo3zfVsyCl73DTuoJXPnIPigJvb0igRGELL5KEz0scmAEUscTGXBD3XQgbirV1zf59VqzLBFocKwE5nbhqMiAv63cY2lqhDaGisJWCzlrlDnyn2CMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqWu4Yy5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712772066; x=1744308066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m7vzr6Xsp6x0UdSPwpx85bTxXCe++bmRp1TOsXgox2M=;
  b=eqWu4Yy5/1byCHn4FR0OSXoJTnaEIgqDnhXJXpyqwQvFjGB0Ur3jqCmL
   NRaYOtCfyD71/JcPcbcfmyZk0WWmYErP4wNjSKnj56V9Zx4jHrG9oKv73
   phJzU5x42pjvqmtkk/KmhVQW471GUDmo8dI5suOu0YPy72BoXTNMIxfCu
   Z2UIzsnDlDeAchF3KnWPBrSGYAHsbOzoqDg6KsgficScpOiffceANTjWg
   7jSyB2lnvKKtZuql3D7RTfLWy4Y6fcqONhGXh8d++0dh6rDSQGdjwRQq8
   xz2WkOXt8V+1k3FithNN29y9VJMxyslfUo1yT0W+DOwDd1R5W6BrIB3y4
   w==;
X-CSE-ConnectionGUID: JMswz/NuT86xCnyPrJOnPQ==
X-CSE-MsgGUID: q1Dg7c9pTl6/8OSfNURZVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8376447"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8376447"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:01:05 -0700
X-CSE-ConnectionGUID: W367HOkPS7a9fdJV6XUIag==
X-CSE-MsgGUID: +ZxT0+YlQXS7QmmivLthjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20589842"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.146])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:01:04 -0700
Date: Wed, 10 Apr 2024 11:01:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices (DCD)
Message-ID: <ZhbT3gXO9fhCfJzF@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:03PM -0700, Ira Weiny wrote:
> A git tree of this series can be found here:
> 
> 	https://github.com/weiny2/linux-kernel/tree/dcd-2024-03-24

This would benefit from another checkpatch run and cleanup.

--Alison

