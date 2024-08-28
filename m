Return-Path: <linux-btrfs+bounces-7630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09070962E33
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 19:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1261C23D00
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2F01A4F20;
	Wed, 28 Aug 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="G+EfbIq1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G41VDtnZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD32C4D108
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864961; cv=none; b=K/p2L8l87KHZWp9JjnkaP2QcyUACIEMutJlYBhVEXT/ak/ZtQ6+glDH+0kW06vnCktIx7pHgo9vouAdWolgjHYhVvgkJp6p56KSQmDxVEsJnrZl/fZ0LgLxlhhMggMO1zyLxq90OpoxrMK/71fFe6oT4xEYGCGQ+L5UTrSdTAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864961; c=relaxed/simple;
	bh=7lbaUWqI44b2jg4sVzUnQTIjjzibjZ5eUD2ov255N50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIOZ4WDikOjode4UOemwsZ7VS91uPtFJ1/zPZ5hgJc+tWXAdqQPpELLSFVtRCgWRmn/8sdqr29SXkGqVCzUUVDPBIk3SbRhVZEGIBhPFHmCddy8FjQPXIeOkzHZ0vD1LvQxBfBjdMkDLciNLBqS9oveChleaaL0zwfyJ+SdWijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=G+EfbIq1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G41VDtnZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id C29D2138FF4B;
	Wed, 28 Aug 2024 13:09:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 28 Aug 2024 13:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1724864957; x=1724951357; bh=bJZJEWtT2h
	jv/sR2UZ7TTYp9XZcyjHBHO/MCXlNzkmM=; b=G+EfbIq1On6gA87W3pCSX1gR5A
	c68r2zsI+hY6lzMSjttMhhpqeIJMiTB35YG/2MuVwEIBJQbrdPcqPp58GtGCbYZm
	IOhHi7jr6k2uJMOVpfjP2dPh8adK8clM+lMnvcygpm6X/K3IdH2J1Nj6xSDXUqMU
	S8miJN2FQ2RqTObFPJKHYKVKyfbRlE63rxyJiHGzHruW/tQh+RJzQSbbkCGXlUJm
	IuVKGEoH2nKs2M6OWo3j1zoU6Hd13BOqSLG5lOsN5DVtcekAnw873Y++wz5zRMyp
	ydCW8EmZin+/WAxqQOTm/1o9oGK7zOx82madOXrUb5avkikFK2UE7zCZr6bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724864957; x=1724951357; bh=bJZJEWtT2hjv/sR2UZ7TTYp9XZcy
	jHBHO/MCXlNzkmM=; b=G41VDtnZN5y2TvmdvYFMoRpliB5rU5j7hMVm78+uF7uP
	HoReZ1NSg7jda5vu8ZEpa+gVcBmo55vQnJlz7hrVH5tSHS7W4hO4sBmyX1LB5JXY
	uhUKk8Z82s1PDRf5a6cioVVcVL9un2EgPz8mZLX3RULgyPmhv1U6SyRxT9uE5Xwk
	eZgwdYgrReI9XcOO+eIlnFX0fTcFVHgyLMN7DjGmj8SolBCBJRqTY726nCuQ3MmV
	3s1WzjwYkDtuXk9uhUI/017cy0VgqcFiGbWn4HRp6Ct5IHFCI56jlSZAy/BOooB+
	grh5IFmizVfRiKqR9ElsqWR9JaqaY/9wz8pdkIjtpA==
X-ME-Sender: <xms:vVnPZtrOWRnEnM2yvn9bCTsW35TRahGaPHB61fm84sbhkqQ5JJBmUA>
    <xme:vVnPZvoKA4BXYqaRU0EQ5vKHSgH0T93dPQUOm41D8q-Xs2HHclv9XRotp3lahHyc3
    GIlSEibubPaR3ax1Rw>
X-ME-Received: <xmr:vVnPZqOgAB910cGCjCvGds7aO-woWOdWFjoslbZ_hiZgYyo2ichrmU7_xYtZHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepleffgeevgeetueegledtueeluddtudekhefhudeuheegfeev
    ieehteevieejueetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhi
    ohdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hsthgvrhgsrgesshhushgvrdgtiidprhgtphhtthhopehjohhsvghfsehtohigihgtphgr
    nhgurgdrtghomhdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:vVnPZo5Dvnhekgt7w04KxITxEhTGiakZgQHHXMz9XgMpw27gaXAFhg>
    <xmx:vVnPZs4b4ADaAqtvZgyUgxbcKUA-srfeJ7-OXIVV5Lfbz5YVwxXSqA>
    <xmx:vVnPZgiHNX9wwGo650927Iaj6jZX3tsvO6jHtxFWfypoqhzfmlo2wg>
    <xmx:vVnPZu4_GR-6N07Bcbzy4OU_30eLTWwGHIgLNxElQ1SIrIV0ujKYhQ>
    <xmx:vVnPZmS_9YNKc-xTmsoDdUfF7JHx5sTqAbjogsm9jOmr6i-t7x63_6SY>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 13:09:16 -0400 (EDT)
Date: Wed, 28 Aug 2024 10:09:12 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Leo Martins <loemra.dev@gmail.com>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Message-ID: <Zs9ZuApvQCH4ITT9@devvm12410.ftw0.facebook.com>
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
 <20240827203058.GA2576577@perftesting>
 <20240828001601.GC25962@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828001601.GC25962@twin.jikos.cz>

On Wed, Aug 28, 2024 at 02:16:01AM +0200, David Sterba wrote:
> On Tue, Aug 27, 2024 at 04:30:58PM -0400, Josef Bacik wrote:
> > On Tue, Aug 27, 2024 at 12:08:43PM -0700, Leo Martins wrote:
> > > Add a DEFINE_FREE for btrfs_free_path. This defines a function that can
> > > be called using the __free attribute. Defined a macro
> > > BTRFS_PATH_AUTO_FREE to make the declaration of an auto freeing path
> > > very clear.
> > > ---
> > >  fs/btrfs/ctree.c | 2 +-
> > >  fs/btrfs/ctree.h | 4 ++++
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > > index 451203055bbfb..f0bdea206d672 100644
> > > --- a/fs/btrfs/ctree.c
> > > +++ b/fs/btrfs/ctree.c
> > > @@ -196,7 +196,7 @@ struct btrfs_path *btrfs_alloc_path(void)
> > >  /* this also releases the path */
> > >  void btrfs_free_path(struct btrfs_path *p)
> > >  {
> > > -	if (!p)
> > > +	if (IS_ERR_OR_NULL(p))
> > >  		return;
> > >  	btrfs_release_path(p);
> > >  	kmem_cache_free(btrfs_path_cachep, p);
> > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > index 75fa563e4cacb..babc86af564a2 100644
> > > --- a/fs/btrfs/ctree.h
> > > +++ b/fs/btrfs/ctree.h
> > > @@ -6,6 +6,7 @@
> > >  #ifndef BTRFS_CTREE_H
> > >  #define BTRFS_CTREE_H
> > >  
> > > +#include "linux/cleanup.h"
> > >  #include <linux/pagemap.h>
> > >  #include <linux/spinlock.h>
> > >  #include <linux/rbtree.h>
> > > @@ -599,6 +600,9 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
> > >  void btrfs_release_path(struct btrfs_path *p);
> > >  struct btrfs_path *btrfs_alloc_path(void);
> > >  void btrfs_free_path(struct btrfs_path *p);
> > > +DEFINE_FREE(btrfs_free_path, struct btrfs_path *, if (!IS_ERR_OR_NULL(_T)) btrfs_free_path(_T))
> > 
> > Remember to run "git commit -s" so you get your signed-off-by automatically
> > added.
> > 
> > You don't need the extra IS_ERR_OR_NULL bit if the free has it, so you can keep
> > the change above and just have btrfs_free_path(_T) here.  Thanks,
> 
> The pattern I'd suggest is to keep the special NULL checks in the
> functions so it's obvious that it's done, the macro wrapping the cleanup
> functil will be a simple call to the freeing function.

This pattern came from the cleanup.h documentation:
https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L11

As far as I can tell, it will only be relevant if we end up using the
'return_ptr' functionality in the cleanup library, which seems
relatively unlikely for btrfs_path.

But there is also not much harm in using the common documented pattern,
and seeds future uses in btrfs that are likely to copy this one. For
example, if we do it for allocating something we do have a "factory"
function for.

Thanks,
Boris

