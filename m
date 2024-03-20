Return-Path: <linux-btrfs+bounces-3464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9CD880E8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 10:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A67281B1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41F3BBDD;
	Wed, 20 Mar 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="VJf53SXM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC583A1DD;
	Wed, 20 Mar 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926858; cv=none; b=hzdp57nL6SlTCz2J2eaKcP0a26ED3meA333pplDcLcky0nrKBS1hMnOEZ0TT3OErcZ9nkddUvoUwUew7IvxHfMzjoGRsLpROKYUGlN9a/EU8qzPl4B5BAkSd1VGKF9AXXJuAPYPD+JmyzkzGYujjeWSkqTDXqDX1DjyPWWlU2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926858; c=relaxed/simple;
	bh=lp1e1UQxMWOSt3Zp9g29wtJjqc8yh0PpEqjoculsiHI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRYGbEom5/l1c/23DOYHrJmFO6LI6+GziX65F56AeZ4b1749LP8uR2pOAOTazxki7ve6+Pe8KCtNwLIhrFtVlBbArF7f0xUjgtWIXaX51qYfn/sz3afCljow/8FZENscXJpxlC4ovgQFWkQhdyunsnetw9fRYZMAHZ27ZN8gesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=VJf53SXM; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1710926857; x=1742462857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=stUwsaFKUBgVcg251AdzsJPX2dWe+VXKiXVSvKHe/bM=;
  b=VJf53SXMIgNvhCAT53cxENjkINB070tDO/of6K5qr8Uuai9CMem3p+CF
   rusHfTbnXglUAdVAmthToSdUX4EqiWcFWhX6swbo5mm2vo9prDod/DLgw
   vYC93izWc5F2PhjA9mOOyzMQdyiAeZwqxwPmpPGiIADki+kL0kM3QGeVS
   E=;
X-IronPort-AV: E=Sophos;i="6.07,139,1708387200"; 
   d="scan'208";a="394576354"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 09:27:23 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:23942]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.16.115:2525] with esmtp (Farcaster)
 id 485e31d1-a74d-46a6-8a77-0dfab6552ef5; Wed, 20 Mar 2024 09:27:22 +0000 (UTC)
X-Farcaster-Flow-ID: 485e31d1-a74d-46a6-8a77-0dfab6552ef5
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 20 Mar 2024 09:27:22 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 20 Mar 2024 09:27:22 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 20 Mar 2024 09:27:22 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
	id E670196F; Wed, 20 Mar 2024 09:27:21 +0000 (UTC)
Date: Wed, 20 Mar 2024 09:27:21 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: David Sterba <dsterba@suse.cz>
CC: <stable@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Filipe Manana
	<fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.19 5.4 5.15] btrfs: defrag: fix memory leak in
 btrfs_ioctl_defrag
Message-ID: <Zfqr-V_6-ibIsHiD@amazon.de>
References: <20240319170055.17942-1-mheyne@amazon.de>
 <20240319185711.GA14596@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240319185711.GA14596@suse.cz>

On Tue, Mar 19, 2024 at 07:57:11PM +0100, David Sterba wrote:
> 
> On Tue, Mar 19, 2024 at 05:00:55PM +0000, Maximilian Heyne wrote:
> > Prior to commit c853a5783ebe ("btrfs: allocate
> > btrfs_ioctl_defrag_range_args on stack") range is allocated on the heap
> > and must be freed. However, commit 173431b274a9 ("btrfs: defrag: reject
> > unknown flags of btrfs_ioctl_defrag_range_args") didn't take care of
> > this when it was backported to kernel < 5.15.
> >
> > Add a kfree on the error path for stable kernels that lack
> > commit c853a5783ebe ("btrfs: allocate btrfs_ioctl_defrag_range_args on
> > stack").
> >
> > This bug was discovered and resolved using Coverity Static Analysis
> > Security Testing (SAST) by Synopsys, Inc.
> 
> Good catch, thanks.
> 
> The affected versions are as you say 4.19, 5.4, 5.15, the fixup is

I had a typo. Should go to 5.10 because c853a5783ebe is already in 5.15.

> sufficient and minimal fix, c853a5783ebe is reasonably safe for backport
> too.

I think you're right. To avoid divergence it might be better to simply
backport c853a5783ebe. Let me send this out.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




