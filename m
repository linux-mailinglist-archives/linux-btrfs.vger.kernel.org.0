Return-Path: <linux-btrfs+bounces-4883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95ED8C1CF3
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 05:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75221C21A64
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 03:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F045148FF9;
	Fri, 10 May 2024 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik4jBxvM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11C13BAC8
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311291; cv=none; b=U6z4aci7NhxL169lNqXacT7a9nw9/geDaJ9wqCyB6qJqmMBiMniwQXDCYNOAYC1dYAeL6NO+q6sVS/I322tgFFqpN8R6iQk5T6C9J3hOrwggHiU/relj8Xh9yiZCfdXcxr0hl6bOAw3tyRAPucIp3IoXY4bUS+pA3KgfP/OwvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311291; c=relaxed/simple;
	bh=dfj1a9mMMxT4kK+dZUBfu/t7gAVZmC7ec0NRlZI6TxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtLSnf1QaaliLwZ3SpDqwVUrZ8oTkiYaSRTHaiSzqe+RNEy1y7Lgp28RGf5sKlal1Gl0nXvwqGn0ShbCFoqTFoVz8wApCdoJtQCGtlzhSRnc4lmm3JEa3IG7/X2C5sTQnNH83AOFejQ5olj6aeyMlAfN8nAP7gzNbxVtj4I54jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ik4jBxvM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715311288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F93Nx1PCHKVz+GEqI50pwrgN+2Fg4a5U/4umyOXXuI8=;
	b=ik4jBxvMGgd4Du5yDylrZzGntN3l3rjwMl7RdKbibQAvglcD4wmaJZuF95uPoOjRlr+KvD
	192zFNFFhsoJkuj6f2nR5jQGQ4Dl1EaUcWW/JCazYTff533Zoxh8dgJWIYj8kMyVEZASPI
	3wT/XmiFyjIyP8RL+zIByg5oLsTCnss=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-nbNkfRQANA6nLO2rQwj_Rg-1; Thu, 09 May 2024 23:21:27 -0400
X-MC-Unique: nbNkfRQANA6nLO2rQwj_Rg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c9959c7ee7so855158b6e.1
        for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 20:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715311286; x=1715916086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F93Nx1PCHKVz+GEqI50pwrgN+2Fg4a5U/4umyOXXuI8=;
        b=MrmRmtHKw3Dc5Rukrxe5Cc85wLemN/A4/z+NdvG4DUDhrlDto6Nz3ba3pHDFYD8GI/
         5xIYGbTuC+aq5mCv/13wiMYQhEBCSkiZ/kiZHeTP5L0BIS9i+tWZ6TKuKc+mkLSKGp68
         J6wUppl2qR0K0p4OVqKHUzH2jf2HPpZ43NiO3uahoeWMir2FlkxT5kO7fyqRnjxuT2e/
         IxwwqCJl1HkqeIRSvbeuqBHfdU82JC7rv0epRrJOdz7UEin62E0vaEcvhlk4n0yQpxAC
         fW6GFaYxcOrvShX4BVzR5HutI7CG4Ejrh8TyG3V4U3Jmusx+pVBpoUT9DVP4sytTk+Ph
         RjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUwyH9QVkYKAND03OCN8eWOfgSMaXwRh626NkBcvXEQy0Ds/pYosI/RctgO4eXAg7e7fZrEgT0VXL3bQvEM+cY1o00to1HSRzqkZk=
X-Gm-Message-State: AOJu0Yyi3uciShNzEwauqE+G2A9nHSt222ruMoBvi0W/P4HojU/WwQw4
	lz5wcKLjOhsMeFCBufoEHCHhqR7Zz3IFFCRzHZJZQjvUoQO1O8Tk3D3Bg8+cGWPKGOhrCaxyBl+
	pvx4GF99OEDaRNPrm9jjkTf+4qoZem/oP9nVtHz8DlzYxIiNy9AClOdicYKgI
X-Received: by 2002:a05:6808:a96:b0:3c5:f86f:a5e5 with SMTP id 5614622812f47-3c9970b95aamr1467579b6e.38.1715311286370;
        Thu, 09 May 2024 20:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVK0mX2Zr8NcBzEuHFd8MYcbtUE1gM4CdantqigyBVvdCDdLMA2R32p1LAEkQ3iSAkLsuB0g==
X-Received: by 2002:a05:6808:a96:b0:3c5:f86f:a5e5 with SMTP id 5614622812f47-3c9970b95aamr1467563b6e.38.1715311285849;
        Thu, 09 May 2024 20:21:25 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346dc1sm1795584a12.83.2024.05.09.20.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 20:21:25 -0700 (PDT)
Date: Fri, 10 May 2024 11:21:20 +0800
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
	"daeho43@gmail.com" <daeho43@gmail.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] generic: add gc stress test
Message-ID: <20240510032120.5oywsrifwxr2jjuz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240416185437.GC11935@frogsfrogsfrogs>
 <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com>
 <20240417140648.k3drgreciyiozkbq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <edcb31e0-cddb-4458-b45e-34518fbb828d@wdc.com>
 <20b38963-2994-401c-88f8-0a9d0729a101@wdc.com>
 <20240508085135.gwo3wiaqwhptdkju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240509054347.GA5519@lst.de>
 <20240509094208.ulez6lg7ymesmhej@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240509125412.GA12191@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509125412.GA12191@lst.de>

On Thu, May 09, 2024 at 02:54:12PM +0200, hch@lst.de wrote:
> On Thu, May 09, 2024 at 05:42:08PM +0800, Zorro Lang wrote:
> > Hmm, what kind of situation is this _expected_failure for?
> 
> Well, the one we are talking about here.  We have a new and useful
> test, and a file systems fails it because it has a bug.
> 
> Personally I'd be fine with just letting it fail, but you seemed to
> indicate that this is a reason to not merge the test yet.

The failure itself is not the reason to not merge :) It's not clear
what this case tests for, especially there's a failure. If it's a
regression test case, we can mark the kernel commit.

Or if we treat it as a simple stress test for "garbage collection in
file systems", does it bring in more test coverage? As the "garbage
collection" is common, most of random stress test cases cover that.
But sure, I can treat it as a generic version of btrfs/273. It's copied
from btrfs case, then fail on btrfs. So I hope to know what's wrong :)

> 
> > I hope we can fix the obvious case issue in reviewing phase, or deal with the
> > failure by 1) or 2). For this patch, I think we can find a way to avoid the
> > failure for btrfs, or let this test "not supported" by btrfs. Or any other
> > better ideas :)
> 
> It is a normal use case that every file system should handle and btrfs
> developers are looking into it, but it might take a while.

If it needs longer time to fix, and if btrfs list (has known and) doesn't mind
this failure, I can merge it into "patches-in-queue" branch at first. If we
find a way to fix it before next release, let's fix, or I'll push it. Does that
make sense to you?
(CC btrfs list)

Thanks,
Zorro

> 


