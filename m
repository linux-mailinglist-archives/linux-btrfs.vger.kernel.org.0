Return-Path: <linux-btrfs+bounces-7500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C695F395
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8251F2328A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 14:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E86188A07;
	Mon, 26 Aug 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wOqO0n95"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99D187870
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681303; cv=none; b=mR4QADcFzMoudRAD5mO2T7YIjj/If/PmtEyTtuYj+ZSFdw05PEMhEfVL/PXRad1B0wGttdRjJYYeQ4jnml2au7gypc7k1T42uDzFdkMWEPQuRiO3UWbR/BxSqdLt4Ak6QU0iMNxttRzoYSQeK/09Mi3ugzYYtbkrwYhLrVOLPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681303; c=relaxed/simple;
	bh=mkj1HAN/9Qw3dIioCkhB8J7nZoN7rqHdTW+tN0lUqgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHQqsCI9AtsCh0p9v/ZNFi1Li5DvkAgn56dshPhCMkTN2FuQoSvQDKXi+e4de4fW8Uy14WKDOYAIuU9KzEtKMK7b4OY1Qg8dkGwYW7aK40l3p+ET28Xxghzoz2bl418mFVuYeHEbaK3GWgFzf5PjtC3oqIbcJ+avvGG1gBfwMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wOqO0n95; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf6755323cso25297076d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724681300; x=1725286100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GV5lG+ZmIq1xOZJ846hJ9M+BmOAVFkfHIXGG4hkbdEc=;
        b=wOqO0n95RMdq876Kf+yH8LLUZHNw4vyg6qLfmsI7x3wL2DW0T0TYpEVBRD9luFReqi
         F6u1Lm8zk8ldtU59kbfINxDFHPgxULO0epoaJ2oOA+n/3hoMZw7Q4o00tgu+sIW0rxa5
         fSOP2byQEBrvXUwWvyMZYUCuK9KCxY0mD+dVr6yyDnIXrG7ve/efa1n+J1RjzV+ylCsi
         1nHZpwz5ID+O7mwgIZ3LHJ/hmku2OXRQY+Xjgi9Y442yWnWXFkL/esdtS+V0nPdAg3cp
         0qkMpSkYfiiij5v9khNRix/Gyi02NkngCyb3gQ1RmzQa7C7zJirZMUzM1wxP35bB6XLh
         Gpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681300; x=1725286100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV5lG+ZmIq1xOZJ846hJ9M+BmOAVFkfHIXGG4hkbdEc=;
        b=UP+2FPWh5sRGkWkIyBQv8FPu8Hf2slErr9zil0qe2BERhtw4RNhiwXeJfRT7uWrpHT
         02i52k5FBQKD0s8lYLXl2KkBf76RSOkTjtZzhfR2upSP8m200wIL6hlLYgyM5YszZ8cf
         F9qlZhGcLO1OEVu4EiAkxxEKNT3JUWaov/nzwAQr50JBanif686gr0tH01qPRK6ibzF8
         cisOpj9x1trjwfQndTzzKo9X3bf9nbnPmLFfxU2xWp5ps5FIaSscIY0YuZiZCgJ7PHZR
         eIB9dXQVLQpLOuCYidzvD1/uvkE+UohcuAAN6ICtIOOKsbxJXoMVzz0g/ST5YPQZE49J
         mlxw==
X-Forwarded-Encrypted: i=1; AJvYcCUdnl16lPy+IEExiVwFPvTV9pMowbd0boCWFoykxLBu54489KngZP3cCB3e0yrYGd45xpT3ViFWfXTUAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2Xzl/hTMrueKN+aMpUN3tzvdRbmzTIzqCzQjIbMqqNurND3d
	ObUt3t7IIORCXFQrr1UjBDm3ykwKU+APQummtytjd7AopF2cckjSf13+cLp/ivU=
X-Google-Smtp-Source: AGHT+IEfl39oZI31D86xNJOEhJWW2ikyPBsl4fMysjSYhPMRZGDNPry8iG+JXjxWSDfUlCHmH0bM0Q==
X-Received: by 2002:a05:6214:3f90:b0:6bf:66e6:476f with SMTP id 6a1803df08f44-6c16dcc9108mr127120076d6.47.1724681300034;
        Mon, 26 Aug 2024 07:08:20 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162de7b1fsm46499926d6.138.2024.08.26.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:08:19 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:08:18 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: willy@infradead.org, linux-f2fs-devel@lists.sourceforge.net, clm@fb.com,
	terrelln@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH -next 00/14] btrfs: Cleaned up folio->page
 conversion
Message-ID: <20240826140818.GA2393039@perftesting>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240823195051.GD2237731@perftesting>
 <20240823211522.GA2305223@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823211522.GA2305223@perftesting>

On Fri, Aug 23, 2024 at 05:15:22PM -0400, Josef Bacik wrote:
> On Fri, Aug 23, 2024 at 03:50:51PM -0400, Josef Bacik wrote:
> > On Thu, Aug 22, 2024 at 09:37:00AM +0800, Li Zetao wrote:
> > > Hi all,
> > > 
> > > In btrfs, because there are some interfaces that do not use folio,
> > > there is page-folio-page mutual conversion. This patch set should
> > > clean up folio-page conversion as much as possible and use folio
> > > directly to reduce invalid conversions.
> > > 
> > > This patch set starts with the rectification of function parameters,
> > > using folio as parameters directly. And some of those functions have
> > > already been converted to folio internally, so this part has little
> > > impact. 
> > > 
> > > I have tested with fsstress more than 10 hours, and no problems were
> > > found. For the convenience of reviewing, I try my best to only modify
> > > a single interface in each patch.
> > > 
> > > Josef also worked on converting pages to folios, and this patch set was
> > > inspired by him:
> > > https://lore.kernel.org/all/cover.1722022376.git.josef@toxicpanda.com/
> > > 
> > 
> > This looks good, I'm running it through the CI.  If that comes out clean then
> > I'll put my reviewed-by on it and push it to our for-next branch.  The CI run
> > can be seen here
> > 
> > https://github.com/btrfs/linux/actions/runs/10531503734
> > 
> 
> Looks like the compression stuff panic'ed, the run has to finish before it
> collects the dmesg so IDK where it failed yet, but I'd go over the compression
> stuff again to see if you can spot it.  When the whole run finishes there will
> be test artifacts you can get to.  If you don't have permissions (I honestly
> don't know how the artifacts permission stuff works) then no worries, I'll grab
> it in the morning and send you the test and dmesg of what fell over.  Thanks,
> 

They all fell over, so I suggest running fstests against your series before you
resend.  btrfs/069 paniced on one machine, btrfs/060 paniced on one machine.
None of the machines passsed without panicing.  Thanks,

Josef

