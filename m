Return-Path: <linux-btrfs+bounces-7568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A585896137F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 18:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD04284D2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67C1C9DF7;
	Tue, 27 Aug 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRfrdUMQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD711CF96;
	Tue, 27 Aug 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774563; cv=none; b=uEF7BFzW3KRXLRG0qBMdOPDiqWcApZnGSqjCtSL3DWs2xJmfPrz7Ro/21FQNGWJI1WcdkZRPAh0f2hvbuz8kEcFd7f/ePkskVNzOzXBRwYxSHoRAY+UMbaUBsFNo8uNA5zkqeor5XtpHJ4FL+frNve/eu6p0CQEUyA2F2Pr46ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774563; c=relaxed/simple;
	bh=bftQR8XAiOa4Kj1zRha66tu+wQd2k7qmj7VrqkjwAew=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXZDM0hW3ua2TAocsU5uDcjkYQNbEvJRCKoQH1auWO/z+/RyqQd6fOGb5/sETRUmxlbT4Pou2bZCMIbSgz9dbO3Z3pg1bmbdcjOSVXLEse0mvqrCNR/uYzFGlPGZIuoDDu9F1EQJ5v/Adxok519jMzuBEuBDbTLNZgUMuXNaTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRfrdUMQ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e13d5cbc067so5833920276.2;
        Tue, 27 Aug 2024 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724774561; x=1725379361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUynhOlcmLN7T5QW4XtgVMkPbI5R+at4MqJPO3psk2k=;
        b=IRfrdUMQ5LIBSERPSFNw1r4BKjv6Lpg23bTF7uQ6mpb/lVGuQiNitZUY4JAt9Je3yz
         jmqRbZrKaqkwaPEsPvvj1K0lf40zlSp0FNItxkKiPgu6dYTutXfa3yoIbd+e6asRBftl
         EG5UVJa5FtD9fCDhLAiFybdy2hgKdyzNxGmP5Q0hTKqX7TNayg9oSV7tYzn0y7vK0QB4
         /Qy7nAZkxaATBs90V4xvweZQXC2BXrsAvVJxhs8WbFVq68/9wt/E6Z+wfKnACTmENo1A
         jnKfVL87Rd5MkZablrCdk0wru87gYZgVYizFLKkNryNEHGno4vYqQfOi/+iwvCUm09sH
         dYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724774561; x=1725379361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUynhOlcmLN7T5QW4XtgVMkPbI5R+at4MqJPO3psk2k=;
        b=QFhinz2ZacM7SBPxLyr84YVhCqpLeztL/lOCVcf3nWzzXgXnS0+4t1VYuwNjbhItb1
         1JM5GXXvRME1PkpLgyzPrPrA7fQ/L1g1d3lqSdccNsxtggkZKnvktgcDUEvWn4kmM9Z8
         3RmkEAVBrDeESNZi/fA9wpC1jqplRPEnCxlzk8CqDDCmX9oGiXfUSwLJAo4sLPY43Ocb
         ev2wfZLT3YIMCfhnsxKJwhvNOyGXf9FrEbKQT9LRmmu1O2WzvX71PX58n+FKxdSiojAS
         8G3c30t2rcfxWUvJG9MNtUBWMq3hlvfhqUwFQgt49ZE18UFXDMwjvik4sQO9xE2lFEgP
         TjWA==
X-Forwarded-Encrypted: i=1; AJvYcCVjfcoOQMifa3mSSBK17V6/iePZSNbprLwTVzDCPJ7ZnfeplfVd+akYh+GhnTvORQiza9+M89A5Fk2w@vger.kernel.org, AJvYcCWHxyzijiUI/xfvyQrqXMwm4Gsk4ZlnwmiAZaZwZoXVYSHAmG10+/+qWBi1WAObpVicF57lEYrhzfAB@vger.kernel.org, AJvYcCWfeP/snpfXeNZUdyXcdbyZLNSB5Jy7WslA35UV7JgGH1hmOSyD+MAV7HTFpsU7f5tCUKOqF6/PVnTHMw==@vger.kernel.org, AJvYcCXnb2b+Ol88KjNC8yQHuMAE97ojuo/MUeryafbIthXFU3MOXUVymkIjXff2W0anrdb01RBJiNTXLIEwqxpV@vger.kernel.org
X-Gm-Message-State: AOJu0YxIna3bSwY4ne/QeP2/rMgUYHUmqLQ4UN4CrqxoXY23CFp3C8DB
	zpwGkCJxYufztGgesmoZ439vQ7LoGJDcAV6RMKSPbj9y7n4wBKZ8
X-Google-Smtp-Source: AGHT+IExAE08HkQ1ORhHjbfWeAfdnCQmLvshPsVsu4uByYzu2KqQJJMTlxqXuTwlDzVPJS9Zd5JWcQ==
X-Received: by 2002:a05:6902:2202:b0:e13:d6f2:1181 with SMTP id 3f1490d57ef6-e1a2a5da391mr3211223276.26.1724774560695;
        Tue, 27 Aug 2024 09:02:40 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4b3883sm2584126276.32.2024.08.27.09.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:02:40 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 27 Aug 2024 09:02:11 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, ira.weiny@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 18/25] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <Zs34b4DoMmd9GO28@fan>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
 <Zsj_8IckEFpwmA5L@fan>
 <20240827130829.00004660@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827130829.00004660@Huawei.com>

On Tue, Aug 27, 2024 at 01:08:29PM +0100, Jonathan Cameron wrote:
> On Fri, 23 Aug 2024 14:32:32 -0700
> Fan Ni <nifan.cxl@gmail.com> wrote:
> 
> > On Fri, Aug 16, 2024 at 09:44:26AM -0500, ira.weiny@intel.com wrote:
> > > From: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > A dynamic capacity device (DCD) sends events to signal the host for
> > > changes in the availability of Dynamic Capacity (DC) memory.  These
> > > events contain extents describing a DPA range and meta data for memory
> > > to be added or removed.  Events may be sent from the device at any time.
> > > 
> > > Three types of events can be signaled, Add, Release, and Force Release.
> > > 
> > > On add, the host may accept or reject the memory being offered.  If no
> > > region exists, or the extent is invalid, the extent should be rejected.
> > > Add extent events may be grouped by a 'more' bit which indicates those
> > > extents should be processed as a group.
> > > 
> > > On remove, the host can delay the response until the host is safely not
> > > using the memory.  If no region exists the release can be sent
> > > immediately.  The host may also release extents (or partial extents) at
> > > any time.  Thus the 'more' bit grouping of release events is of less
> > > value and can be ignored in favor of sending multiple release capacity
> > > responses for groups of release events.
> > > 
> > > Force removal is intended as a mechanism between the FM and the device
> > > and intended only when the host is unresponsive, out of sync, or
> > > otherwise broken.  Purposely ignore force removal events.
> > > 
> > > Regions are made up of one or more devices which may be surfacing memory
> > > to the host.  Once all devices in a region have surfaced an extent the
> > > region can expose a corresponding extent for the user to consume.
> > > Without interleaving a device extent forms a 1:1 relationship with the
> > > region extent.  Immediately surface a region extent upon getting a
> > > device extent.
> > > 
> > > Per the specification the device is allowed to offer or remove extents
> > > at any time.  However, anticipated use cases can expect extents to be
> > > offered, accepted, and removed in well defined chunks.
> > > 
> > > Simplify extent tracking with the following restrictions.
> > > 
> > > 	1) Flag for removal any extent which overlaps a requested
> > > 	   release range.
> > > 	2) Refuse the offer of extents which overlap already accepted
> > > 	   memory ranges.
> > > 	3) Accept again a range which has already been accepted by the
> > > 	   host.  (It is likely the device has an error because it
> > > 	   should already know that this range was accepted.  But from
> > > 	   the host point of view it is safe to acknowledge that
> > > 	   acceptance again.)
> > > 
> > > Management of the region extent devices must be synchronized with
> > > potential uses of the memory within the DAX layer.  Create region extent
> > > devices as children of the cxl_dax_region device such that the DAX
> > > region driver can co-drive them and synchronize with the DAX layer.
> > > Synchronization and management is handled in a subsequent patch.
> > > 
> > > Process DCD events and create region devices.
> > > 
> > > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >   
> > 
> > One minor change inline.
> Hi Fan,
> 
> Crop please.  I scanned past it 3 times when scrolling without noticing
> what you'd actually commented on.

Sure. I will crop in the future.
Thanks for the tips, Jonathan.

Fan

> 
> > > +/* See CXL 3.0 8.2.9.2.1.5 */  
> > 
> > Update the reference to reflect CXL 3.1.
> > 
> > Fan
> > 

