Return-Path: <linux-btrfs+bounces-2799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79B867731
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 14:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2E7293472
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF9129A7A;
	Mon, 26 Feb 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEiqsU6V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6851292EC;
	Mon, 26 Feb 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955377; cv=none; b=uTLO6qatNAI5BG8hBhlQ2Em/mh1ZLh2mAuWbxLl0q9KlwewuIzNd7eJC6MOjzOpBtbljucfrpCPcFpqhl/ZQHwWUZecvZC6HC010oL0r1oqj2DxYpFinj/up5Muw04WU6rRC2CA9NYMmew/6e97kHdNqzI+yfx7ikn0wtHMpkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955377; c=relaxed/simple;
	bh=pvNoWlR6n7C1X0wVqVMTZ0QCQDSV/TFduBNq9aZ39pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve4uiG2VHHQbpDbPCYAGxmB4qjX5yXMCrbMxd7MpleXZfq7iz/4XZ4iPfiObjlgYoZALG9l4N9vHPDtp8rAE6TUjpcdrmz7dMSDBPpidzDUN3PkVJZ7YdttaLPkW7+NzGb4ddJpri6VGHvg9JmcC66SuimUUukte30jaFiPfBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEiqsU6V; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so2319071a12.0;
        Mon, 26 Feb 2024 05:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708955375; x=1709560175; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qBPhfWiIRjZC5D/bWwBB183M9L4X0x/HRgLAvZqCqHM=;
        b=AEiqsU6VUCghquDjB7ntRe1FAn2eXHY9Npt1ZV2JShUH8onsot6Wh0Qg4zfHartJph
         U2T634WmN+lNHn3w3m2ozOdEqSf0ykuatTB9edZ+QmCg7t80Ot/PSSABcfXnYTQoEePV
         R33VTRbGj+zd+NsL93gSZUkJEPQhEbFUFFSo5JLlkGeAWlNANSagPI4kfq02u5DYeV7B
         l5EkixrOMxm3My0GFxZrDS0BrKEwIh38ovZEhpQHAvbROsBzJSurV3ImvKRRt78BOuPV
         xqweIo2CA3/GNJ6yAThhpyqgUIwKxqGnKfulWpBcuSKpQix8au6gTyaoQ1sdkO1+KBwv
         ATRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955375; x=1709560175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBPhfWiIRjZC5D/bWwBB183M9L4X0x/HRgLAvZqCqHM=;
        b=iSsG8x+TT0GnVewr2Mo4c6bIr17KD45wLFr//3/LlfyEgqOo/Ms7dlK8nkXJg2w56R
         LkkHjaoFICKQoyCtTjZP2PUVdjpdkzTvKHHip+35Bbx2qS9ygNyee9Kyy8KuFvJb0oyN
         r0P6lULCSltuabTly3GZ5eacrjNfofU0/lX9k9elran4MtDMxtbi7dXSZkP1ewNJbiOc
         pSSL4gk/L3pu7xaReOeB6m8Sp08Rqrs9yxVgrtPGMOFHMeKT3MQ702pZVkoj+Ai+Q2Q+
         wG8ve3VJGCQGYsjzwgHSLj0VPUtzlZBDYJwFXduE0piH/PFpeC+qkWUzu5n5WG9N3Drw
         F7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpsQfQQR1/tLrQL6/dtHmb3aKO5/4fLiq71yFIWbKOFd/dxW/V2xEiw4BSkcXdBshnc40LMPyyceoEX9GZBwQytaKkmWD5Y5nLR5j6kAoMxk0Jt7I7pI0sYCIuWPvw9vG8p5Wc
X-Gm-Message-State: AOJu0YylUtA3beNDKR3Odh6RcKN8etEvtTOwIXX5/mOOun9yXTbh02zb
	Jw/W47p2sdJ7zmi3t7EimFYbAFUHIqfYJT+1zFdrqMO3flMtmW//
X-Google-Smtp-Source: AGHT+IHqsd3aQp/wnLx8iLJ7Y8mPaJO3ByzQttlDyfYN7demkWbmxSlLoCseFT291+3e1kX1E5vlMA==
X-Received: by 2002:a05:6a20:e609:b0:1a1:94c:5ce9 with SMTP id my9-20020a056a20e60900b001a1094c5ce9mr272319pzb.28.1708955375449;
        Mon, 26 Feb 2024 05:49:35 -0800 (PST)
Received: from realwakka-Home ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170903131400b001db3bffd1a8sm3940442plb.42.2024.02.26.05.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:49:34 -0800 (PST)
Date: Mon, 26 Feb 2024 22:49:19 +0900
From: Sidong Yang <realwakka@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/224: do not assign snapshot to a
 subvolume qgroup
Message-ID: <ZdyW36o4QT6JFpqU@realwakka-Home>
References: <20240226040234.102767-1-wqu@suse.com>
 <e4703a32-9b16-48c2-b5ea-9477be071a9b@oracle.com>
 <57068435-f797-4eec-ab7d-79161269cd0d@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57068435-f797-4eec-ab7d-79161269cd0d@suse.com>

On Mon, Feb 26, 2024 at 06:31:31PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/2/26 16:58, Anand Jain 写道:
> > On 2/26/24 09:32, Qu Wenruo wrote:
> > > For "btrfs subvolume snapshot -i <qgroupid>", we only expect the target
> > > qgroup to be a higher level one.
> > > 
> > > Assigning a 0 level qgroup to another 0 level qgroup is only going to
> > > cause confusion, and I'm planning to do extra sanity checks both in
> > > kernel and btrfs-progs to reject such behavior.
> > > 
> > > So change the test case to do regular higher level qgroup assignment
> > > only.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > looks good.
> > 
> > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > 
> >   Applied to
> >     https://github.com/asj/fstests.git for-next
> 
> Thanks for the review and merge, although I'd also like to get some feedback
> from the original author, to make sure there are not some weird use case.

It seems that this line intented to assign a qgroup for new snapshot same as
subvolume. But I agree that 0 level qgroup doesn't make sense. This patch
Looks good to me. Thanks for asking to me. 

Thanks,
Sidong

> 
> Thanks,
> Qu
> > 
> > Thanks, Anand
> > 
> > > ---
> > >   tests/btrfs/224 | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tests/btrfs/224 b/tests/btrfs/224
> > > index de10942f..611df3ab 100755
> > > --- a/tests/btrfs/224
> > > +++ b/tests/btrfs/224
> > > @@ -67,7 +67,7 @@ assign_no_shared_test()
> > >       _check_scratch_fs
> > >   }
> > > -# Test snapshot with assigning qgroup for submodule
> > > +# Test snapshot with assigning qgroup for higher level qgroup
> > >   snapshot_test()
> > >   {
> > >       _scratch_mkfs > /dev/null 2>&1
> > > @@ -78,9 +78,9 @@ snapshot_test()
> > >       _qgroup_rescan $SCRATCH_MNT >> $seqres.full
> > >       $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> > > +    $BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
> > >       _ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
> > > -    subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> > > -    $BTRFS_UTIL_PROG subvolume snapshot -i 0/$subvolid
> > > $SCRATCH_MNT/a $SCRATCH_MNT/b >> $seqres.full
> > > +    $BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/a
> > > $SCRATCH_MNT/b >> $seqres.full
> > >       _scratch_unmount
> > >       _check_scratch_fs
> > 

