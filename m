Return-Path: <linux-btrfs+bounces-5510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A68FF612
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 22:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483BF284E28
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96F812BE9F;
	Thu,  6 Jun 2024 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="1L7RQcaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hF6+1B9O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783813A8CB
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707050; cv=none; b=ocKLu/7qnAkh1TIf9cGNYJouCm1zcMb1llwyjNU4XCh4SdxWGXE6T699j8XP+OVSE+OX2jsvt38k8kvAR2mzRQuw8INIfYVH8w5yJseOPm88IgKs+pSOXShLnptRk+lF0KusDGoKiYVKT7uivDCENL+Uqfa5utd7lVMwnad8htg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707050; c=relaxed/simple;
	bh=RQt9DRN0ddqGqHijo63w+gHqUq0Prh+dDpZLdfSwYgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE9L88+n5uUZIThcTfzFm6VYhREjW5u8uUmIsvljb45DNvh479xxmpqPYxoeecXIy6ASTh1lTudULKE2Ow/vBsVZ3U2mVqprQtupEXgt4jt9wGIDGvmyY1od/SwK26CwPdi8r3uk9UoxOrZTdTrUp+MgaenRz90kx9uJn6hMOUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=1L7RQcaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hF6+1B9O; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8D46C11401C9;
	Thu,  6 Jun 2024 16:50:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 16:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1717707047;
	 x=1717793447; bh=xVYpqhmbD+3afCKWxxMnbiL7OM8b2q9NgvwYF2w/u3M=; b=
	1L7RQcaLLZLEU/B0EQJzqhXR1EBD031n4+nUephVgmnAHbc6cv7duwBF22vu3oFH
	gbiM0VGKqaUzhkyLmwLJV7GVt4r77mWNnSHbm34EImZ6wXnjUs7nmo/VZ+IkIQyN
	igVo+njiR61Kk2Y0UhRtzdwgaNLJ1V4mt7dXrakZm3cp7oTn9Roh6M6wi8SQHUQx
	tXgSrwqSO/X1Vf8oELK2V1W4JDyaUZQeeE3yirqMbAV4bwM8Tf52woqGVSqrpnNm
	KFiHLBrld5vtFlDCJgWWn9/9o+WiPGlbFWIIBJh0vM3tcGdudM2DYujZ5+7Bews0
	cIt3ttU4QdrFw11+2hYF4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717707047; x=
	1717793447; bh=xVYpqhmbD+3afCKWxxMnbiL7OM8b2q9NgvwYF2w/u3M=; b=h
	F6+1B9OMlT8i/7meh/Lf8C/KcD4o4k9Lk7qlMY+5oMjf1AxLpSGeYPb0i49UoTSD
	ElbKctHNmPzaqtzDRQ2CeeYKRXEJUg1I1OouceUwmg5xPYydgruQDPtbLxvVTPxO
	nykb+C41O7SIf2trByMg8C47pybg+dzP6v0YwVTBmOcxrWSJb+QqKQPq2v5ctpUa
	ScZWsQq83km9yFkY7aUKX8UxkgJT5a7G35IdZNmVyOIg0vUXgHSTnHrUqVeerZn3
	zgHaoRKpxZ7Ys75rxf0O7iXoUIBSbu3NR7oO0/BRfh9Y/N2JEslYlwUuebiPAQFT
	+L3qzK1O9xBdbh34I8aRg==
X-ME-Sender: <xms:JyFiZsQsptEwoVK2Qz81eevHF1_X9sGMTXIH5YOpE_r47tXHxc6JJg>
    <xme:JyFiZpxDnxRNrzejH6CVqj6AoEu2cI5iWEZnqB4a0RfCmGMnxmwHziCVmYPELMwog
    2HOMmczPrIRK-BxTW8>
X-ME-Received: <xmr:JyFiZp1JvnGvvTFoVGJP4O9A0FcFmkqDRuTJv6x3B2xMBNY1gc1fS_Nt8modeP7LRsUCVX98-Wq6NJX8bC52OrDzVzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    rhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrh
    hnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveegtdeuuddtiedtieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrih
    hssegsuhhrrdhioh
X-ME-Proxy: <xmx:JyFiZgDSx6sJsYGrB4v-vU8ELJUwJhntChpl7E9eoWE9457udrx71g>
    <xmx:JyFiZlguBH8h774opudlSN_nB5YToIRsT617BKGSxzrhxgUYymNGDA>
    <xmx:JyFiZspncWBXra3Zu7OomL88D866nq4Ig8C7UUrImZj-rX38_d9mcA>
    <xmx:JyFiZog-XkAqYVBeEI4kiWFK1huGWB5KEzpIXh_rLffRYNelCYGdSQ>
    <xmx:JyFiZouu1Q8KMS_I9qG03A0GCQR32QyfDmruMEITQzJZzLUSUuTcrNkf>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 16:50:46 -0400 (EDT)
Date: Thu, 6 Jun 2024 13:50:45 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove pointless code when creating and deleting
 a subvolume
Message-ID: <20240606205045.GA32373@zen.localdomain>
References: <292b2e90e9a64cd3156b0545f6e62b253ea17b9e.1717662443.git.fdmanana@suse.com>
 <20240606190633.GA11027@zen.localdomain>
 <CAL3q7H6JQG510-c3YZUBpAra8kww1bi3_yqH+NbbFJCAvG84sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6JQG510-c3YZUBpAra8kww1bi3_yqH+NbbFJCAvG84sA@mail.gmail.com>

On Thu, Jun 06, 2024 at 08:56:31PM +0100, Filipe Manana wrote:
> On Thu, Jun 6, 2024 at 8:06 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Thu, Jun 06, 2024 at 09:30:07AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When creating and deleting a subvolume, after starting a transaction we
> > > are explicitly calling btrfs_record_root_in_trans() for the root which we
> > > passed to btrfs_start_transaction(). This is pointless because at
> > > transaction.c:start_transaction() we end up doing that call, regardless
> > > of whether we actually start a new transaction or join an existing one,
> > > and if we were not it would mean the root item of that root would not
> > > be updated in the root tree when committing the transaction, leading to
> > > problems easy to spot with fstests for example.
> > >
> > > Remove these redundant calls. They were introduced with commit
> > > 74e97958121a ("btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume
> > > operations").
> >
> > Re-reading it now, I agree that start_transaction will ensure what we need,
> > and if it fails we go to paths that result in freeing the reserved space
> > here in the subvolume code.
> >
> > With that said, I spent like two weeks on this battling generic/269 so
> > there might be something subtle that I'm forgetting and didn't explain
> > well enough in the patch. Reading it now, I do think it's most likely
> > that the fixes to the release path were sufficient to fix the bug.
> 
> I think it's obvious these calls are redundant.
> Things would be seriously broken if start_transaction() didn't call
> btrfs_record_root_in_trans().
> 

+1

> >
> > Just to be safe, can you run generic/269 with squotas turned on via mkfs
> > ~10 times? It usually reproduced for me in 5-10 runs, so if it's not too
> > much bother, maybe 20 to be really safe.
> 
> I tried that, yes, but the test sometimes fails qgroup cleanups with
> -ENOSPC, both before and after this patch.
> The failure is reported as a warning message in dmesg, it doesn't make
> the test case fail:
> 
> [99872.487855] run fstests generic/269 at 2024-06-06 20:53:33
> [99872.771632] BTRFS: device fsid 7a9e9120-5656-486a-8ea2-e0f7e12648b7
> devid 1 transid 10 /dev/sdc (8:32) scanned by mount (2754727)
> [99872.772502] BTRFS info (device sdc): first mount of filesystem
> 7a9e9120-5656-486a-8ea2-e0f7e12648b7
> [99872.772515] BTRFS info (device sdc): using crc32c (crc32c-intel)
> checksum algorithm
> [99872.772519] BTRFS info (device sdc): using free-space-tree
> [99872.774615] BTRFS info (device sdc): checking UUID tree
> [99877.835179] btrfs_drop_snapshot: 10 callbacks suppressed
> [99877.835191] BTRFS warning (device sdc): failed to cleanup qgroup 0/342: -28
> [99901.986789] BTRFS info (device sdc): last unmount of filesystem
> 7a9e9120-5656-486a-8ea2-e0f7e12648b7
> [99902.004561] BTRFS info (device sda): last unmount of filesystem
> 4dea6050-7fd2-4823-a0c6-23a321b9f183

No the patch fixed space reservation leaks that showed up as test
failures from the unmount reservation checking. I'll keep an eye out for
the ENOSPC errors, haven't seen that before.

> 
> If that's what the commit tried to fix, then it wasn't not enough or
> some change after it introduced a regression.
> 
> Thanks.
> 
> >
> > Thanks,
> > Boris
> >
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> > > ---
> > >  fs/btrfs/inode.c | 5 -----
> > >  fs/btrfs/ioctl.c | 3 ---
> > >  2 files changed, 8 deletions(-)
> > >
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 0610b9fa6fae..ddf96c4cc858 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -4552,11 +4552,6 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
> > >               ret = PTR_ERR(trans);
> > >               goto out_release;
> > >       }
> > > -     ret = btrfs_record_root_in_trans(trans, root);
> > > -     if (ret) {
> > > -             btrfs_abort_transaction(trans, ret);
> > > -             goto out_end_trans;
> > > -     }
> > >       btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
> > >       qgroup_reserved = 0;
> > >       trans->block_rsv = &block_rsv;
> > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > index 5e3cb0210869..d00d49338ecb 100644
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -658,9 +658,6 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
> > >               ret = PTR_ERR(trans);
> > >               goto out_release_rsv;
> > >       }
> > > -     ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
> > > -     if (ret)
> > > -             goto out;
> > >       btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
> > >       qgroup_reserved = 0;
> > >       trans->block_rsv = &block_rsv;
> > > --
> > > 2.43.0
> > >

