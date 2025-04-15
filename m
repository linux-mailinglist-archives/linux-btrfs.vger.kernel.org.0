Return-Path: <linux-btrfs+bounces-13041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D97A8A552
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 19:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DF53B8FB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791A21CA12;
	Tue, 15 Apr 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oafT0fIx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5571BC2A
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737829; cv=none; b=IlbmAp8aguwh1RnegCx4fLvwRK34UIBPnTY/2WgcuWg8DJOkrepLTSQ1dz7VIv1KUeAOz0eNfImfwILRyagaqqzIC5budmt7VWMIK7u30z4qua8UpzsFtRtPRoVeTJCE2aDrxRGLsoLjt6hbsQzSZQRE8VQOYAi5xPDnOuLZ5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737829; c=relaxed/simple;
	bh=NTqZv0LweOqDAOoEVD7QgVB3NdEftyTX3tSygtnm0Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzP3l2FAh616GaUuAlxW/EGvDUEgMPSu6zCSiS5OOPEg8sq5Jb5l5prpa1jlPxKkmsnd7VCuURV9xOWyCxf47528AfL91O6T0mSJSM5d2qZT7ozmGXmdW7rnRTXUvnq5pMrFlkR4txZQFG4B7It7i7CObzdnQr+fdmLhwxvrCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oafT0fIx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fda22908d9so42542757b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744737826; x=1745342626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7W75hKr6skQYI33NoQ5yNiiOVYsJacph1/bL8lCb+04=;
        b=oafT0fIxtm5+hS4yZ4LRXpVpWxfT2kVdgOGTD3LTGY13uJX70baI3rtiCNTzfH11FW
         RWPwPAK72dD9ANw4QxlW9pWvlWx9zb8UyYfxMhmuhjCNC4FltEPJHCgmX1PZoq1+srIP
         +UElMD2MPhPYl/Pl+7SDtDV19cJWDSfi1FhClPm0RC+HjdCtg86f9uyiwydKrgJmW2gi
         P3IQFBaYAsCJ0WIJZkVgkO1Kd1LrTanXeJXUsnZy5OIiwu63qIH3BGtKHGzu3nZpR5Rz
         HXjcOXAN9MNbmEAEosEzrVsfcLTePrhkvt/zgqeGnz+lbtwEQvhCwGmHLLdSeohUvvqy
         wtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744737826; x=1745342626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W75hKr6skQYI33NoQ5yNiiOVYsJacph1/bL8lCb+04=;
        b=h5dkMd7lpU9h/pKle+lagweja5h2lnWx7eyfivhk10wYSH74j6kdbljxNF/bYvTMEf
         Tm35ydYJikeBp54BP49SeH9/nxVs0C4EGsTqu/XqpE2wRO9V7oTo3XvrvYfwXDG+iLSd
         OE4oMfjScahr1uiaID7bAiyK1hpTy4wMIJgeb9AtAlMbxjcAwKPZRwpin8dE+U2XVeoj
         tNGhid7XtF8b/rOqywc9E0RDcCsRCRzjQSL/K8QqYmKmdEHNjpR0/Q7Lgjb68Fx7uS/U
         CyTy4Ig2OvOFlrAz/ZjluhbsAXwnkstnPLqRrFB9QXm2Xm6oPP4PlHBvvQ0hLIjXrtYq
         gXAw==
X-Gm-Message-State: AOJu0YwNUknIFROr8+aNNCfL3Enmc0m81e/rA+GERwlEMOZgrUJs7EY6
	xKUxX4UF/YNd2rDVociQT8O+hhHKtWqCG3haZnpC+NNtKNtKBTZnY/J0+MFrhew=
X-Gm-Gg: ASbGncvAIDLmpzDBiayemtl4DX22OjrVfhIbB1mqjGzWe6xBXzxFFw9kroP0IyRpI6T
	NJmUPrnz0ku4iM0/vVg2xAH9bUkcXQ9MY0UWz3Fre+C4YLYILx9447TRu2sLZQA2SwvG3Wzw6p3
	KLMDLgXeErt/3Y7BsuH/30Lh8xFICxx0r8QVHo7WHkrb9N7QTaHjKy/EEHw2tqwRAq8N300pvXQ
	/4rbqsP71OKdQXvRFz20H68PxexRza2MDITY2i23bOWvK2k/Ph4Z9p9qXEI/uPNmAFkMvjgnVnt
	87in1gV3j59DPU/4NexfARPZiiRACYuZv3vDD3Mmjdijm+OQXvCxdaNAOOn6m/OSBzV+XKsq/yZ
	22w==
X-Google-Smtp-Source: AGHT+IGDgauFlTLpY/cXC2Y/BLnsUjk9oQ8XYGxk6VPw47KeBqzZok6Oqbz1+dudUYaLe1YMb3ngZA==
X-Received: by 2002:a05:690c:6483:b0:6fd:3743:1e31 with SMTP id 00721157ae682-706acf09c01mr1697407b3.18.1744737826376;
        Tue, 15 Apr 2025 10:23:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e11d349sm37430157b3.43.2025.04.15.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:23:45 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:23:44 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
Message-ID: <20250415172344.GB2701859@perftesting>
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
 <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>

On Tue, Apr 15, 2025 at 07:38:29AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/15 04:38, Josef Bacik 写道:
> > When running machines with 64k page size and a 16k nodesize we started
> > seeing tree log corruption in production.  This turned out to be because
> > we were not writing out dirty blocks sometimes, so this in fact affects
> > all metadata writes.
> > 
> > When writing out a subpage EB we scan the subpage bitmap for a dirty
> > range.  If the range isn't dirty we do
> > 
> > bit_start++;
> > 
> > to move onto the next bit.  The problem is the bitmap is based on the
> > number of sectors that an EB has.  So in this case, we have a 64k
> > pagesize, 16k nodesize, but a 4k sectorsize.  This means our bitmap is 4
> > bits for every node.  With a 64k page size we end up with 4 nodes per
> > page.
> > 
> > To make this easier this is how everything looks
> > 
> > [0         16k       32k       48k     ] logical address
> > [0         4         8         12      ] radix tree offset
> > [               64k page               ] folio
> > [ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
> > [ | | | |  | | | |   | | | |   | | | | ] bitmap
> > 
> > Now we use all of our addressing based on fs_info->sectorsize_bits, so
> > as you can see the above our 16k eb->start turns into radix entry 4.
> > 
> > When we find a dirty range for our eb, we correctly do bit_start +=
> > sectors_per_node, because if we start at bit 0, the next bit for the
> > next eb is 4, to correspond to eb->start 16k.
> > 
> > However if our range is clean, we will do bit_start++, which will now
> > put us offset from our radix tree entries.
> > 
> > In our case, assume that the first time we check the bitmap the block is
> > not dirty, we increment bit_start so now it == 1, and then we loop
> > around and check again.  This time it is dirty, and we go to find that
> > start using the following equation
> > 
> > start = folio_start + bit_start * fs_info->sectorsize;
> > 
> > so in the case above, eb->start 0 is now dirty, and we calculate start
> > as
> > 
> > 0 + 1 * fs_info->sectorsize = 4096
> > 4096 >> 12 = 1
> > 
> > Now we're looking up the radix tree for 1, and we won't find an eb.
> > What's worse is now we're using bit_start == 1, so we do bit_start +=
> > sectors_per_node, which is now 5.  If that eb is dirty we will run into
> > the same thing, we will look at an offset that is not populated in the
> > radix tree, and now we're skipping the writeout of dirty extent buffers.
> > 
> > The best fix for this is to not use sectorsize_bits to address nodes,
> > but that's a larger change.  Since this is a fs corruption problem fix
> > it simply by always using sectors_per_node to increment the start bit.
> > 
> > Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   fs/btrfs/extent_io.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 5f08615b334f..6cfd286b8bbc 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
> >   			      subpage->bitmaps)) {
> >   			spin_unlock_irqrestore(&subpage->lock, flags);
> >   			spin_unlock(&folio->mapping->i_private_lock);
> > -			bit_start++;
> > +			bit_start += sectors_per_node;
> 
> The problem is, we can not ensure all extent buffers are nodesize aligned.
> 
> If we have an eb whose bytenr is only block aligned but not node size
> aligned, this will lead to the same problem.
> 
> We need an extra check to reject tree blocks which are not node size
> aligned, which is another big change and not suitable for a quick fix.

We already have this.

> 
> 
> Can we do a gang radix tree lookup for the involved ranges that can cover
> the block, then increase bit_start to the end of the found eb instead?

That's a followup patch that I'm testing now.  I've started with the simplest
fix so that they can be pulled back to all the affected kernels, and then I'm
following up with much more invasive changes to make these problems go away in
general.  Thanks,

Josef

