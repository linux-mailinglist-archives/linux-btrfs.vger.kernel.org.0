Return-Path: <linux-btrfs+bounces-4454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392D28AB544
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5811C21AAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1931311AD;
	Fri, 19 Apr 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GCHOIwEu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7122071
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552753; cv=none; b=oFenBxRz7BJRRnrVI4GQ3Me+hfL1L6EDgnw9ub6xz6beIC05THyhEOHnsBYCI3JHYTj8lbfv+zCI4cECEA439/tuqDv42Cks3hwbhfmh4PBOn43EsqQtLnxFLVnJUUeHrpz6UMqvmIUYxXcNKfksX/YrTGYpkcRgreO7MTLYpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552753; c=relaxed/simple;
	bh=gUY/OkXCx7aywIh2/Kua2mslfdnSJqeo+DAFMLtK9j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fomi1xyyq1rqCw8DArBNJOuyy22d2u6oqu/Rou+qIm8HikDh8BwTs2EA7MuRKWgOe/9SwYewAcMRp+gest7/b4Y+q0TSWnga759EPMbCPf519qbp4/5MSsNPHimY+7fQG9K1YzYq846seUgVPAKORQZ30rN4hRFFaqZBo1hppGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=GCHOIwEu; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b5ece41dfso10778666d6.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713552750; x=1714157550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZOyTK6C7slb3OG7MTzL/pkIq/IOJPMYQV8xt6NKg2U=;
        b=GCHOIwEuaRGmyED/gHQaACqJuY+SpganMnZ5UMLbkVHcqvuOxzEGznvtGbKVRsi40x
         9WXACZDBuhBujYjqx2HKHmGMp6+AOVtAAE/Bj5KWfi0oPn8immt8z6kYNLqnIS9Mj8mz
         xuzYf6oi5Bn6iEIYgKG6yfctxporviHK/FMKFMolnNvPogcy7mQs43KF3xszmeicU8VN
         jOGXN0QpRler43oA1AAWidC+vavzpjZp8HphzUVMTb7Cyhy21xn8H8yhyKkcAABJS+Vp
         RZCAI1CdhXtNQWDvP5IPh2S+YvhRc2vMhMT1QAh7bHfoCGUdMqxyAkH9FHfVrcCRX5lJ
         2e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713552750; x=1714157550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZOyTK6C7slb3OG7MTzL/pkIq/IOJPMYQV8xt6NKg2U=;
        b=lWgtercS4Q8wW2owIWEYsMiajzwjHzavOzTPFEF7TwTTDzRtq766FFSnjbyylrzn3Q
         OIaWqHGzCzipUtrkgiVMSKg1e9F1465VI62wMflxJGffgB0OOLAEg7KrvXRH1tDmH7gh
         HkiqkDcuTzfOKO+QExHjFsaXyBHLgqBkdxMrvlAQrcHVGqC73yAMo+oXpwxxYqc2I1MT
         w4OAJuDlzrdeErfhSlAhxiEBIxJBkfuWOsX3p727oF3urkQHu3QbIVW4snKw3shWs3AE
         J6Kdv16J8oZGEDL046p4oiDTqt8FhUcyU4/gX+gPA05K0OJ/ZQgPjzlojsbB+YB+B4pJ
         jKJw==
X-Gm-Message-State: AOJu0Yzpmu0ZnsCLRjj4+eTixSf4/R/qAVcl/b110LUln8OvuT6CCj2V
	FXsEjFC38leRD1Y/jIA+jbq56gL1hIAGrxaQDxfHQmgNSYvSeOasFUnjNLEjhxzu86wkCCW4CHq
	6
X-Google-Smtp-Source: AGHT+IEvPiyFy5XMUKKyBzWJP9ArwSoqFM2d6sAIJ9nuqaIRkVikL1AkYAMjw7yXAaBrP62tN8+kyg==
X-Received: by 2002:a0c:ab14:0:b0:699:2086:8918 with SMTP id h20-20020a0cab14000000b0069920868918mr3295181qvb.47.1713552749858;
        Fri, 19 Apr 2024 11:52:29 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x1-20020a0c8e81000000b0069b40c06b11sm1774995qvb.105.2024.04.19.11.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:52:29 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:52:28 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 05/17] btrfs: lock extent when doing inline extent in
 compression
Message-ID: <20240419185228.GA2725564@perftesting>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <99be1657b5273f3a9d24e53f6be9303b381a51eb.1713363472.git.josef@toxicpanda.com>
 <5d8ff6d5-1703-4255-a442-16f9fdbecc41@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8ff6d5-1703-4255-a442-16f9fdbecc41@wdc.com>

On Wed, Apr 17, 2024 at 04:29:52PM +0000, Johannes Thumshirn wrote:
> On 17.04.24 16:36, Josef Bacik wrote:
> > We currently don't lock the extent when we're doing a
> > cow_file_range_inline() for a compressed extent.  This isn't a problem
> > necessarily, but it's inconsistent with the rest of our usage of
> > cow_file_range_inline().  This also leads to some extra weird logic
> > around whether the extent is locked or not.  Fix this to lock the extent
> > before calling cow_file_range_inline() in compression to make it
> > consistent with the rest of the inline users.  In future patches this
> > will be pushed down into the cow_file_range_inline() helper, so we're
> > fine with the quick and dirty locking here.  This patch exists to make
> > the behavior change obvious.
> 
> But in btrfs_do_encoded_write() we're still not locking the compressed 
> extents and call __cow_file_range_inline().

We are though, the extent is locked the entire operation during encoded writes.
Thanks,

Josef

