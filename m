Return-Path: <linux-btrfs+bounces-16425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EAFB3744D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 23:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3777201924
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 21:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8092F6588;
	Tue, 26 Aug 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="alloVifj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E428851E
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243190; cv=none; b=EYINi1l5AByhZ2rjSibo0ULGlL80ZvRsWn54/PdbQrpAVMwmxeYid/saH3ySLRT7k8VOGceWMPS4VoN/p7JT9sy4xpZVUzOrJh1Kw2jixI37vZGA7DwB4Pw440cQPBqZIQxSww+i9DJnXDMqNpo9SRN+hmVn7KqKHbzCva/+EHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243190; c=relaxed/simple;
	bh=IYbT5i1Mef7siPe0pv4BD6XfSdO8znPLCDv3IR1Wt08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyqMXKcpLxTNBMUgakR+xaiO1PnjIaUcwuDQYJgbaZ6cWOo5kOVte1U8oUjad1j/eM4erxx6FKA8Y2JcMusvFQPNz4nlxMiHwhCeFh19znDvUTktagrdo7/sYdu63XxfFoJZJ/Vb0seGrfUTMrVE8Czb7gaMcBujaxItB51ENzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=alloVifj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b49c729577dso884853a12.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1756243188; x=1756847988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OE5Jb64nFSwS1p4ae/38JIYTRfUbO1Ezm8h79l/jSEw=;
        b=alloVifj8oZWZCvh6mlANBFCyOLTMlW1gMJ2XWBHzKU6QjnlZ6zyOOhpgONYc22PlB
         eCEaeJLsqhomriwTz9azZG1p+eXFvUKYwtn7q6/cLWrT9cgE+ZyALoMGNEXyhG3KbTbf
         6i4vcChReh+UY2kUyySattATWfHY+faTLRiveEgCgUaa+N5vRG9/2EbjaEHTOb75ChQB
         rcro4hJ4kN4Q2ZpYjorEtntFhmawCk5v5G85TODl69BzPpPnffU1DG7rnq9u14w/iyAD
         ClJRGe3z9Hv0vX7ovXxO5+X3bxShxdyAOgekbUPTmrCqgw3LHitfUEki69AAbrvM/iSF
         35lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243188; x=1756847988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OE5Jb64nFSwS1p4ae/38JIYTRfUbO1Ezm8h79l/jSEw=;
        b=CP56qT/uddN7c/iNhkz7W01PgJlJBZurcOIbBSMfSbL6MYboUCBOhrfBmU56noqgj8
         l6YfZKMPnelZeG2vOWUl82bSVMkX1SsPdQuD99FcoqNmbnPvvRN/EEerqsWCJyV6p0I7
         oEDvv+5GeeVe9q3a0NiffGFabIkDtwxgROz56JYyXd6Wq1gy0GqGuxW2cDdYIxyhWhmw
         SHIZUgS2opolnHiBbRLc8ZxU+/KoEteL1pRrz12I5Gka7treceMU1PwN/Xha1+4aeLQ1
         P7oLFvq3hJNa0+u9mulvuxE/OpMgzxF1L+ETEhd4Bbrc2XPHI6mR/W/YfeuNPlW03rK4
         8qyg==
X-Gm-Message-State: AOJu0Yzpv4BTVHkDEhQ5ilQw4xzfczp4Cw7XCkZblq4vxMnFXbrTp53P
	OLBeD/3L6DRy7jhRykBOP630CgcDafgDIDxGFK8dFpr2/ragnqBz8FMYtN2XaRujh8E=
X-Gm-Gg: ASbGnctoWRUJ0bJajaCMGAB06Kj+ZK3WF/lxrU77BVmRQSoSVBTYTis3Rlm/qEvDUwa
	y6hGUNd9+KTwOkzXHyRQ+nTpHKGBwx2pKQSRc/CInxBOxnQac1X0mRE82ws4aejz4YTW9OzTIXW
	CA4VVip5I1lRzgNNF7ZkAgORecOcLSerbYigUZznrSool7LQPjN2IHEZB0+wrS4NBwfsHBlRhBp
	H9ifwd3J38yJUCQyWZmen2FhSV9MGtgKC5MLxZnc4y4iy7rvwkKHgfIpYBOUylIqZnRvlOTPTDq
	T6BljN5K61k2NIwkLrDmexVPLoPhcaeZD5tNHFN/uLnFnyY+9+Pp8PNJbyaaB266d7qxuhSPREd
	Hr34vzX1iy0srEk8lHT31wvi5ow==
X-Google-Smtp-Source: AGHT+IG7gu31VAeXFC278oX+WKQcasCFMqzoXaR8Iv4HqPVlPSUc6qR8LGzhTPWie4sJbHiVxzkLKg==
X-Received: by 2002:a05:6a20:1582:b0:243:99c8:c0d2 with SMTP id adf61e73a8af0-24399c8c605mr703427637.2.1756243188562;
        Tue, 26 Aug 2025 14:19:48 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:400::5:f494])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8ca240sm9936869a12.25.2025.08.26.14.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:19:47 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:19:46 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Filipe Manana <fdmanana@suse.com>,
	Leo Martins <loemra.dev@gmail.com>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH] btrfs: fix subvolume deletion lockup caused by inodes
 xarray race
Message-ID: <aK4k8qNb1OdOLk0L@telecaster>
References: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>
 <20250826202507.GA2119633@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826202507.GA2119633@perftesting>

On Tue, Aug 26, 2025 at 04:25:07PM -0400, Josef Bacik wrote:
> On Tue, Aug 26, 2025 at 01:01:38PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > There is a race condition between inode eviction and inode caching that
> > can cause a live struct btrfs_inode to be missing from the root->inodes
> > xarray. Specifically, there is a window during evict() between the inode
> > being unhashed and deleted from the xarray. If btrfs_iget() is called
> > for the same inode in that window, it will be recreated and inserted
> > into the xarray, but then eviction will delete the new entry, leaving
> > nothing in the xarray:
> > 
> > Thread 1                          Thread 2
> > ---------------------------------------------------------------
> > evict()
> >   remove_inode_hash()
> >                                   btrfs_iget_path()
> >                                     btrfs_iget_locked()
> >                                     btrfs_read_locked_inode()
> >                                       btrfs_add_inode_to_root()
> >   destroy_inode()
> >     btrfs_destroy_inode()
> >       btrfs_del_inode_from_root()
> >         __xa_erase
> > 
> > In turn, this can cause issues for subvolume deletion. Specifically, if
> > an inode is in this lost state, and all other inodes are evicted, then
> > btrfs_del_inode_from_root() will call btrfs_add_dead_root() prematurely.
> > If the lost inode has a delayed_node attached to it, then when
> > btrfs_clean_one_deleted_snapshot() calls btrfs_kill_all_delayed_nodes(),
> > it will loop forever because the delayed_nodes xarray will never become
> > empty (unless memory pressure forces the inode out). We saw this
> > manifest as soft lockups in production.
> > 
> > Fix it by only deleting the xarray entry if it matches the given inode
> > (using __xa_cmpxchg()).
> > 
> > Fixes: 310b2f5d5a94 ("btrfs: use an xarray to track open inodes in a root")
> > Cc: stable@vger.kernel.org # 6.11+
> > Co-authored-by: Leo Martins <loemra.dev@gmail.com>
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Heh, I was just noticing weirdness here as I started converting inodes over to
> using an xarray instead of a hash.

Yeah, and there's still some weirdness in btrfs_del_inode_from_root()
with dropping the xa_lock just to check btrfs_root_refs(). I think
that's just left over from f72ff01df9cf ("btrfs: do not call
synchronize_srcu() in inode_tree_del"). Either I or Leo can send a
followup cleanup for that.

> Nice catch,
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks!

