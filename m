Return-Path: <linux-btrfs+bounces-16522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 148D0B3B192
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 05:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD461BA3A14
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 03:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855718C03F;
	Fri, 29 Aug 2025 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="kNGtpbl2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383417E0
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438279; cv=none; b=MoLPM3ALf2m7F12Fr0VmCl5hx8DU+SotHiVDsyuMSBgfZhdcZ/G/YUdvr8koallKWYsGd5b6K8Xfcn9Kw2sqxB2/oFLqtsnLLpU2wjHIMhqMCPFBmvJXjbkL+Bh4W6eXuaCJYk2qUovJ+BRQXBUYJKEbbfaVwGzFAAFTHGEajh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438279; c=relaxed/simple;
	bh=kPe9OV7qNekg2+SCEDXOmwMiuUdGNXFHeQjynKdWfdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpDNUbrM9MnO6cvNdgVzFPZclWfWU98nCC8fsi4EJHysJzd14U2UIqpmlv6dtWVQ5LOAwV6tnEwz4vfpUdV1Ej8HBJXe/4bg/2xjQyVplm5ryLRDRdSRv5GedRmatJMK4isWq+fSJnMU+F2lOwMQ4Etg/deGw/iIEuPjqfGYYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=kNGtpbl2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24498e93b8fso2136555ad.3
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 20:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1756438276; x=1757043076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmhM55GdvggsaOBaKin/IaT2LlT+f5EHEnNi8hN3u+Y=;
        b=kNGtpbl2bO5Tnx9cgEcx8WXKICS6ukl7oIb5UUVFo5Yz9CWylv/fSQ13kN5qgU1lq+
         RCTNR7s494zAwUn3jigFTvhwlNVbiU9p1XVCae0ajep+aDbhMg7vMFRpwarIFy2TDBIy
         FNAJYBgHTqIgsYHS672PqIqaMvzdpTiv/zKVRRaO2YYwS9Iy3eBKaKz2h6gdM9HOfSbj
         Q545+AuB8mU1WFbAp7FnHegidYPyGaqyqhPiuoQp6M0xs1AFJc7wpV6qBlIDsOF3n6Ut
         Id4oIlTFAa7CgmPrj5Dt2bLJ+70zuAcxWjnCkQj7kmT6K+8tNKyjZMYTWk0yN6l17Zbz
         Imvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438276; x=1757043076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmhM55GdvggsaOBaKin/IaT2LlT+f5EHEnNi8hN3u+Y=;
        b=stGGPWmRappG3J9tLSTS3qjFQKyodWeK/oMstwtUNSLB8NcqO/lnULzM1rr8bBX6Dz
         3TFELNlK5nC4GGlu9Zp5Z4oH1i5NyqpfPTyIoJuxlfqzBlNAqOFYxTRaaP0LEY+43YwF
         aIvUekto3M//U/AyQuAbsgCoQQsWtgnV7nFakrtWTAT+PfyjQAemCp1uAV9TD/NPp9Xm
         /mjvjdOZBAVCtmm2Y8/DGteCBe36qfa5q2hGn2aJpmSrXuCHplLLlxBpucwt53HRhdeV
         HMne0J394XRySx+j5OfwSD7n7US81bILMn5ImWZ8/Je7d3upgCZPpY32qDa9Th5t3Lmo
         gHwQ==
X-Gm-Message-State: AOJu0YxajJaVIxcII54DpQ9adIXZagq3oclG78T7u5bA98Tt+ugLAqdC
	LM7jZmvI+2hV0V+/EUWJkBqVKWyLWfNtU513bvncieu2cmi2vJuu9j4dLSYVblVH7fI=
X-Gm-Gg: ASbGncvnz4poqo4kPVD3QVa5WiItAkt6f7J+GBBSeiRJLuD03p0WMOhDSDGNtOVAcgT
	KyH5ueu9+KOTA03S+UQ3jgzTe/43fF+Iz74pQEqlHSD2F8lV0l8kRKefYYwoO36M0WX1DXhLUH9
	Of6R/S+TcFgK+LQ80Gw3W3FWTfMClGiVW4CUEmz/5jrVQVEHO8TEA3JpbcwRD67QDq9fl7ngfo0
	6ZYzM1PoQ8ePTHSCyKQbOPrTsN49yIwiqrfXgi9RVJov6gSxXJ5Z16LND+TRlekW5ThMky7ZDOE
	5GT7U3fzSVOMe3dNwudd/uSgp/q0b/fCb9OUSu7sflo3nbl9ejIfmGeaOymli38QGwRwYCvyBZA
	tmhlPo8m40374
X-Google-Smtp-Source: AGHT+IEAY8oxvX+lDy4ovYs54L++2UZtGGdQZu/hHFlxt2EW2MJB3N5L5jMrIkFiw/ardSMA6iHSPA==
X-Received: by 2002:a05:6a20:72a4:b0:243:aa41:647b with SMTP id adf61e73a8af0-243c2de0545mr804898637.0.1756438276171;
        Thu, 28 Aug 2025 20:31:16 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:400::5:5a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0e1c0besm832444a12.24.2025.08.28.20.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 20:31:15 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Filipe Manana <fdmanana@suse.com>,
	Leo Martins <loemra.dev@gmail.com>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH] btrfs: fix subvolume deletion lockup caused by inodes
 xarray race
Message-ID: <aLEfAc75VnQ5pcwu@telecaster>
References: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>
 <20250828232346.GD29826@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828232346.GD29826@twin.jikos.cz>

On Fri, Aug 29, 2025 at 01:23:46AM +0200, David Sterba wrote:
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
> 
> Is this correct Fixes commit? The xarray conversion was done in two
> steps, first the rbtree to xarray and then the locking got changed in
> e2844cce75c9e6 ("btrfs: remove inode_lock from struct btrfs_root and use
> xarray locks").

Yes, this is the correct Fixes commit. inode_lock didn't synchronize
with the VFS's inode hash at all, so it didn't help with this. The
reason it was okay with the rbtree was that each struct btrfs_inode had
its own rb_node, so deleting one wouldn't affect any others with the
same ino.

> The root->inode_lock is an outer lock, and with rbtree it worked.  The
> new code relies on xa_lock, which could be released by xarray internally
> or elsewhere we need the atomic operations. Like in this case it's the
> __xa_cmpxchg which I find quite unobvious regarding the xarray API and
> who knows where something like it could be still missing. The simplicity
> of root->inode_lock feels a bit safer.

The documentation of __xa_cmpxchg() says:

 * Context: Any context.  Expects xa_lock to be held on entry.  May
 * release and reacquire xa_lock if @gfp flags permit.

And GFP_ATOMIC does not permit that.

