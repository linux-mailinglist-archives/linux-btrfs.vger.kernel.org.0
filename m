Return-Path: <linux-btrfs+bounces-7501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9441095F3A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8F01C2179B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCBF189BA2;
	Mon, 26 Aug 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Mq7Qsp9v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CC4A21
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681586; cv=none; b=suMaU6BqTSfqeZOirxDtoxjqhPOP2uRnRVm6+jmAgrl8moMiu6nc014GS9kfbhtJwIJ3iwv3/dbQ+rnrp8oy+CLdPJkfYHZVeC7kKBFkYgmWCOs88Dq+v6bM7cRHJ8wkPNCTL5eCYljfEJNwctna9DfHWdc8c1Jd1ZY/Ej/zT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681586; c=relaxed/simple;
	bh=vgxKA6FWhMy663VABrCTlH9dOkWoQRcuaPc5kwvP7q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsxetuGMIs2qq7d8RKLbB55WwzI5t4xi4L757vTeLt50yx6YOukVlRobO0DacBtD8gHE2C33/OFA8TgPwWcmyZEBhHaiTx3Prfp0E6J8JjOWa3yxmDOSPymVDiGnj/FLHqpMzblEgz6kppaKruPdOOhAzBuDzulWxVpHgPqxJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Mq7Qsp9v; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d6f4714bso435396985a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724681583; x=1725286383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LAvOeGF70b/tyNQvzVHIYtL85WLQSXPqWBdn9OCUIrQ=;
        b=Mq7Qsp9vYRgHnBlBCMg8FLnALvHq0yAr0+nvzb1um3P7SIOGWatwZ4r3gzsICjOBB0
         b3cQHjx4r7n6lLFi93LRJ+0HAD4ZfGJf57d/Lp2bPscGDEmGVITa3kOxwrYJ1N2cdv1F
         OL3/IZt/26HyhfR1fFMi42Zgu2kfznoDxxF5QF74mVivUeJWaFZmxvU2FN2kc/8VVmyM
         phKlOw+UgOj57RzJyoUQnpn5OSSOR+1/RGs7bKlLo2QF19sDffUoX4tokFKgKEkV+SqF
         HrQqjvBDLWRyXtldC66SHox+n7wqqFduD07t43wWYmZJzmfVUHgplWlzEBuVldZsCK5w
         aWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681583; x=1725286383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAvOeGF70b/tyNQvzVHIYtL85WLQSXPqWBdn9OCUIrQ=;
        b=I+P4DJNpGSKRnZHGASZYm5pm2+fmVciVlsNIiGhPPOemmEGyNIyaGJe/hRn8Jsg7kK
         zOD+TasmdIEBYaD4XyWjZ+PXTPNmE/8jausGVT6Xh4D8IYu12BInAihY3ITLGhfCbFa6
         ZJKdJCVlarS69Xt8ECZg/+mUZz9ya7pUTkR6zXmxiOrMTkM/RRfxdPlDdohiyta8X3uk
         EN7qbahwZ8eg5bvYJdgiOUXCWZU2JrfMkBhh7hbilq4V28z613tBthEp9nOTAb/Z6b0o
         3Lh4iEYytl+0Puy8ew0eRMVB3VymewSCa+prvt1A8lQr+kNLzi1emyKs4hDIBPuQOpah
         M0bg==
X-Forwarded-Encrypted: i=1; AJvYcCXK0Tmdf7eGSmtF6czNZIHMrvjcw9wKpXrtWeLgxEbBmNsLhfCKhKQsdVQ8hl5VcLLjECoimhxFcShrZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ud1XP53nTrQfL+u5qE173eRQlEVJF9X9DwfSsxpuen5K5rS3
	cqpogMkWkrihfgIPHHaTfFnl5zq22JtbpGmPsmXu6MHwO03ZPUHoYOSz7DUz78A=
X-Google-Smtp-Source: AGHT+IFju7ySUA3x2Z+qp7YrSg1R12K+A25Sxpx8ZwVX2aZ7NPHJcqfZDGHdJBnFyQUJpOVMD7R+sw==
X-Received: by 2002:a05:620a:462b:b0:79d:554d:731f with SMTP id af79cd13be357-7a67d4b1d4fmr2413233585a.29.1724681583196;
        Mon, 26 Aug 2024 07:13:03 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3f798esm456097485a.106.2024.08.26.07.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:13:02 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:13:01 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-f2fs-devel@lists.sourceforge.net, clm@fb.com, terrelln@fb.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 02/14] btrfs: convert get_next_extent_buffer()
 to take a folio
Message-ID: <20240826141301.GB2393039@perftesting>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
 <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>
 <ZscqGAMm1tofHSSG@casper.infradead.org>
 <38247c40-604b-443a-a600-0876b596a284@gmx.com>
 <7a04ac3b-e655-4a80-89dc-19962db50f05@gmx.com>
 <Zsis82IKSAq6Mgms@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zsis82IKSAq6Mgms@casper.infradead.org>

On Fri, Aug 23, 2024 at 04:38:27PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 23, 2024 at 11:43:41AM +0930, Qu Wenruo wrote:
> > 在 2024/8/23 07:55, Qu Wenruo 写道:
> > > 在 2024/8/22 21:37, Matthew Wilcox 写道:
> > > > On Thu, Aug 22, 2024 at 08:28:09PM +0930, Qu Wenruo wrote:
> > > > > But what will happen if some writes happened to that larger folio?
> > > > > Do MM layer detects that and split the folios? Or the fs has to go the
> > > > > subpage routine (with an extra structure recording all the subpage flags
> > > > > bitmap)?
> > > > 
> > > > Entirely up to the filesystem.  It would help if btrfs used the same
> > > > terminology as the rest of the filesystems instead of inventing its own
> > > > "subpage" thing.  As far as I can tell, "subpage" means "fs block size",
> > > > but maybe it has a different meaning that I haven't ascertained.
> > > 
> > > Then tell me the correct terminology to describe fs block size smaller
> > > than page size in the first place.
> > > 
> > > "fs block size" is not good enough, we want a terminology to describe
> > > "fs block size" smaller than page size.
> 
> Oh dear.  btrfs really has corrupted your brain.  Here's the terminology
> used in the rest of Linux:

This isn't necessary commentary, this gives the impression that we're
wrong/stupid/etc.  We're all in this community together, having public, negative
commentary like this is unnecessary, and frankly contributes to my growing
desire/priorities to shift most of my development outside of the kernel
community.  And if somebody with my experience and history in this community is
becoming more and more disillusioned with this work and making serious efforts
to extricate themselves from the project, then what does that say about our
ability to bring in new developers?  Thanks,

Josef

