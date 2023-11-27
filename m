Return-Path: <linux-btrfs+bounces-393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7FD7FA615
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 17:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D387DB213C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449E364C3;
	Mon, 27 Nov 2023 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="t//eltwI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A594DE
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:19:48 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4064790276.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701101987; x=1701706787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwZ0Ti+Lc1rloQrH2BoZMnYd6KfEMAUA/GS0pz2k0H8=;
        b=t//eltwIZeTV1Q0oUYMD4ER6mqN8wP8Rh7ECPL7KtKiV+Tev+Bg955FEOCAspuz0xQ
         sbo+rCq0/o8ySYOT5MQbKupaPSJft6cIugQ+gZCGgXUoAYCR4Utb91xyUkFv6o8j3sKZ
         UCsQiHj5sHbdCG/z7Mnq89PjwAs0LQZPocbAliH1ycQMcMcVG3hal5J3EhPcEBnJyBMW
         ZEWVwgopALFl3NrqRXfgUKOlzvSn3uCD/13Z0/tn7R7bNdeGE4qAo1griiY7M0QhZqAV
         QoVmoOjahd3xhUXcV9MqgiIv/VwVWxPn6/per3bCZSOKdVyT3e2l35uSUi4ZFJ+VADIe
         5kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101987; x=1701706787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwZ0Ti+Lc1rloQrH2BoZMnYd6KfEMAUA/GS0pz2k0H8=;
        b=BSnkoS5/kdq3m7Aav6EbxASbq8CIPzxLyr98wRAoQQDJ+s5TTxgEW7836qdmPB8o8y
         lkXOnwKL9/4kh+AIL1360fwNRJViuEgrMJznDgNhuMThQg2H938uO0gPvHFRlhoI1e05
         GS0fzODQ/ho/hQgDjk+fHzpbTm3UoCdh7BujdUnIG2ExtP2ilPr/yUoBZ/gb0PNTdxry
         4aK3qAHsYjn4QIi5OSC+0NRcnJdu33Of/lEbNlX1akoAZlVKMNcShbIzXJeAfXDGfW5o
         hiyihg4bcMYn7pJqemq1uT+GL7Tg3sh3VOvgHV8+0rFeJmFSE4waFUJp089idujPxFbb
         mQFQ==
X-Gm-Message-State: AOJu0YyU7BmMYbeJDx3zmkQyAc7RtuUMO31zH4U9iaAfphwAwLFvJ/FZ
	dwtNFMOG3Vl9sUuia3uU45dRbg==
X-Google-Smtp-Source: AGHT+IGJFdfzSN5YB7+Uyuw1BE3DNlZyzo3XPIoFN5qIppeRZKRCBYzf5BgGcuGWHArdbpf4DpqVrg==
X-Received: by 2002:a25:4d41:0:b0:db0:366a:73ab with SMTP id a62-20020a254d41000000b00db0366a73abmr8099886ybb.57.1701101987603;
        Mon, 27 Nov 2023 08:19:47 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e131-20020a25e789000000b00d815cb9accbsm3136525ybh.32.2023.11.27.08.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:19:47 -0800 (PST)
Date: Mon, 27 Nov 2023 11:19:46 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Should we still go __GFP_NOFAIL? (Was Re: [PATCH] btrfs:
 refactor alloc_extent_buffer() to allocate-then-attach method)
Message-ID: <20231127161946.GD2366036@perftesting>
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
 <20231122143815.GD11264@twin.jikos.cz>
 <71d723c9-8f36-4fd1-bea7-7d962da465e2@gmx.com>
 <793cd840-49cb-4458-9137-30f899100870@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793cd840-49cb-4458-9137-30f899100870@gmx.com>

On Mon, Nov 27, 2023 at 03:40:41PM +1030, Qu Wenruo wrote:
> On 2023/11/23 06:33, Qu Wenruo wrote:
> [...]
> > > I wonder if we still can keep the __GFP_NOFAIL for the fallback
> > > allocation, it's there right now and seems to work on sysmtems under
> > > stress and does not cause random failures due to ENOMEM.
> > > 
> > Oh, I forgot the __NOFAIL gfp flags, that's not hard to fix, just
> > re-introduce the gfp flags to btrfs_alloc_page_array().
> 
> BTW, I think it's a good time to start a new discussion on whether we
> should go __GFP_NOFAIL.
> (Although I have updated the patch to keep the GFP_NOFAIL behavior)
> 
> I totally understand that we need some memory for tree block during
> transaction commitment and other critical sections.
> 
> And it's not that uncommon to see __GFP_NOFAIL usage in other mainstream
> filesystems.
> 
> But my concern is, we also have a lot of memory allocation which can
> lead to a lot of problems either, like btrfs_csum_one_bio() or even
> join_transaction().
> 
> I doubt if btrfs (or any other filesystems) would be to blamed if we're
> really running out of memory.
> Should the memory hungry user space programs to be firstly killed far
> before we failed to allocate memory?
> 
> 
> Furthermore, at least for btrfs, I don't think we would hit a situation
> where memory allocation failure for metadata would lead to any data
> corruption.
> The worst case is we hit transaction abort, and the fs flips RO.
> 
> Thus I'm wondering if we really need __NOFAIL for btrfs?

It's my preference that we don't use GFP_NOFAIL at all, anywhere.  We don't
really have this option for some things, mostly lock_extent/unlock_extent, but
for extent buffers we check for errors here and generally can safely handle
ENOMEM in these cases.  I would prefer to drop it.  Thanks,

Josef

