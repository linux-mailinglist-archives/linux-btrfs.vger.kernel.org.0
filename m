Return-Path: <linux-btrfs+bounces-4868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF48C0DAF
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0677F1F21EAD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B9014B09F;
	Thu,  9 May 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3l46pXj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00EB14B08F
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247740; cv=none; b=jjtmg2hQOQy4cWbnKjnabpFm+/REurGeXWoo/OKTPPmlCwl6Fgl1uuYSeY2Tbl0l1x4znwOuaT9PCR3baYHK8f4w5TvGJihnvbzPAJFwbn3HwUsHseJDCUsMJE17sBFWBJvBfjhbxh64Yy4dhCwKT7qJW5zuHPbS7enTb9p+1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247740; c=relaxed/simple;
	bh=XMqM3z5Dc6oQ4SdVUzaG0GSlWEfmSFSbkadFDxMlSws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZd9leHGSVsxDTXc1YVnAhQotXr9ZlYDuG4d7CejjjRNshH3zD8uuxr2qHOiONMMO0VkCSvOwZILf5N1XXoQsyxR/b9XVjxelEfHU5FGXPcs1cQbnzsngjA/SkP/4qHuCteqgItYPCltojD/bvocyRVr4erxU/x0t2NaqKr6B1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3l46pXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715247737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqh+8QSbSkOoBZk3pRadu9LwOPPbnmF9UEzo6RF70qE=;
	b=V3l46pXj4SRrxjwbZX9dm4W0/yt4kE6q0rZexOaSBIhbI41ensPvrY44XIHBaC8HfYZEZf
	CiWuS8wkh7CtE/gfpZFW+pjuilnG50LC9opTO+7YFDUpjhReFwiQ0zZKfQxjSTqTosH2Qx
	Zk/zcZmM1U28m3LyxUB3NccE7rQU3cg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-7cX3MLWUNVasPvx_AxoVgA-1; Thu, 09 May 2024 05:42:16 -0400
X-MC-Unique: 7cX3MLWUNVasPvx_AxoVgA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ec263943d0so6008665ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 02:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715247735; x=1715852535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqh+8QSbSkOoBZk3pRadu9LwOPPbnmF9UEzo6RF70qE=;
        b=F2E1irtL9nwIn+LqAkYhdKyCN2bo9O0DNNXCD8qGdfiE9hNHMgYXczXbAZ45n4DdwT
         vzHPykX+3B4UTGHNzmcaewshOwP+tlWMlKrh16C0CvSSRbazkRaJPJYM+8vxCWx+wCN0
         3ONzhetbzZKS24RpY17wAZDjetN5dTSAVZWijbHbmcR6pPhPhrkR7TmW1o6icUjLVKo8
         5hONVglT94IFwdMNovqivwMJNL89GP9wToqB8UHn18GNJFB1Litp6sGBz7HYBuLJJlBS
         EitYyl5OexNVbFcaWcuJnmMgkd0oYoe9vG7NwiltBErtCPNcv7aXnpBDl4K7JEhf7R/f
         /djg==
X-Forwarded-Encrypted: i=1; AJvYcCX+tnxBfIpX48zCtC7NtzqAN3/x6sQqgP47CyED9Y0PrwqXV5qIJW4JsabFMCiX88BQfan7UAQiaBI+oB/Urg3jPE/CFz3YE2bPk+M=
X-Gm-Message-State: AOJu0YyTVg4XTZmHmDXswBxKj8Z6OwD280OVaazq/2+znXxc42DAs1gZ
	bYMwg8UlZJbOraoN6t3jArllBy+bI/a4VdKj7ygSFwKCRk9HNs/fd5Up9AIdCZSMdQEGE4Bh9+4
	o3AGKNOh6FCWA83Zsi6UEl4V/peCD6qdKgSdV/Vg3wgkEgad2qpcDGvNlNEvt
X-Received: by 2002:a17:903:41cc:b0:1e3:e093:b5f0 with SMTP id d9443c01a7336-1eeb018707dmr61316775ad.8.1715247735043;
        Thu, 09 May 2024 02:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz+AzRz16AHwoNSL1VXfhuWRJQuY7crCwH+qvCCOX3Z71AblXQ2ogcArxIxEhWcTfO/SRFKA==
X-Received: by 2002:a17:903:41cc:b0:1e3:e093:b5f0 with SMTP id d9443c01a7336-1eeb018707dmr61316555ad.8.1715247734432;
        Thu, 09 May 2024 02:42:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad5f0esm10049455ad.67.2024.05.09.02.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:42:14 -0700 (PDT)
Date: Thu, 9 May 2024 17:42:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: "hch@lst.de" <hch@lst.de>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, Zorro Lang <zlang@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Matias Bj??rling <Matias.Bjorling@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"daeho43@gmail.com" <daeho43@gmail.com>
Subject: Re: [PATCH] generic: add gc stress test
Message-ID: <20240509094208.ulez6lg7ymesmhej@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240415112259.21760-1-hans.holmberg@wdc.com>
 <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com>
 <20240416185437.GC11935@frogsfrogsfrogs>
 <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com>
 <20240417140648.k3drgreciyiozkbq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <edcb31e0-cddb-4458-b45e-34518fbb828d@wdc.com>
 <20b38963-2994-401c-88f8-0a9d0729a101@wdc.com>
 <20240508085135.gwo3wiaqwhptdkju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240509054347.GA5519@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509054347.GA5519@lst.de>

On Thu, May 09, 2024 at 07:43:47AM +0200, hch@lst.de wrote:
> [really annoying multi-level full quote snipped]
> 
> On Wed, May 08, 2024 at 04:51:35PM +0800, Zorro Lang wrote:
> > I remembered you metioned btrfs fails on this test, and I can reproduce it
> > on btrfs [1] with general disk. Have you figured out the reason? I don't
> > want to give btrfs a test failure suddently without a proper explanation :)
> > If it's a case issue, better to fix it for btrfs.
> 
> As a rule of thumb, what do we about generally useful tests that fail
> on a fs due to fs bugs?  Not adding the test seems a bit counter productive.
> Do we need a
> 
> _expected_failure $FSTYP
> 
> helper to annotate them instead of blocking the test?

Hmm, what kind of situation is this _expected_failure for?

For now we have two methods to deal with a test failure:

1) If a test always fails on a fs, and can't be fixed (in case or kernel). We can
add this fs type into black list of the case, e.g. _supported_fs ^$fstype

2) If a test fails on a fs as an expected bug? We have _fixed_by_xxx ... or
_wants_xxx_commit helpers to record that.

3) Besides that, I generally metion some new failures in [ANNOUNCE] email of each
release. (That's the last way I can choose).

I hope we can fix the obvious case issue in reviewing phase, or deal with the
failure by 1) or 2). For this patch, I think we can find a way to avoid the
failure for btrfs, or let this test "not supported" by btrfs. Or any other
better ideas :)

Thanks,
Zorro

> 


