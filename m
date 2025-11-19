Return-Path: <linux-btrfs+bounces-19133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D8C6DC4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C404E34A795
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0633DEF7;
	Wed, 19 Nov 2025 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ebVy+JFf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3F2FC010;
	Wed, 19 Nov 2025 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544734; cv=none; b=LrFt/XJiFjPTVguidor6Bj1EN3Y5ksRu2nIdLxgajHW7Ejl48INZhPPiKuG8Tmwu3U63YnY1xAKkAe3oa8MeJ+1Vx6PEbARIQZWm1CAyrzK0lOPZD5ZCKJJX/gP6+CZhPz8mXIgwY4sFR6bYqikdDAjDsDvQ8MdBk8UvqWB94DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544734; c=relaxed/simple;
	bh=hph9jjwDr/FRq9nT+lJEnPqDVbM5CYZnTmizuAOM2og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnGh9dH9tSWemtUfAnUXXbzFt0+nILUxuMutK+0amJH9hqIE4Mih6l598leT5FNOme0sNY6CI5PRkyGhUX6y+XlFdklAh7aWXZUZ+an2ev8/fq8gJtXK7xy6EP/gwG79x1zpuTvbUxBycyRWClxlmw7SRrcF9IwM4/hAnB3q918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ebVy+JFf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y3le2Uhye/1oGq63Dh86c9QUkeNoDAILKIbUtkMR7ew=; b=ebVy+JFfjfNq0GT1tb4e5DvvyT
	IehZgPFhkt/caYIvryGswiZUDYP5nroCCJIHfDuvttrcY4VFZU/UvA7s3YIlz6BdWaPlPp1k2aLgK
	a7PQ/JJeJ4ZHP181tZZmtziAV5S/G10UrFIR6nCPwRZ1cL6BwoazCSn0mpXBLoiV5GyLWYdAMDuAa
	cdvnVQ7zGY9M6uxX11Axe+cVi+bT1Gq3iAVD7RJvRybGV4QJ99JXBqndXJGyjviApRW31G+4LHHD8
	KAcS3Cj6+21VwjC3Qc59AEh2L51PZMNSss+fb6DFZsU5r+3RuHFSVAB55UlpvNgntW0pTLSE3rWTH
	WvBlGIUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLeXp-00000002s9J-2sG3;
	Wed, 19 Nov 2025 09:32:09 +0000
Date: Wed, 19 Nov 2025 01:32:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Vacek <neelx@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
Message-ID: <aR2OmdwuISWNRkN2@infradead.org>
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com>
 <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com>
 <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
 <84128576-17f4-460a-9d2f-9e40f43f2ef7@gmx.com>
 <CAPjX3FedNEUeGr3sROdHaT0iKhHDfsi4V=GQHcmvhx6wEJqUcg@mail.gmail.com>
 <aR1-TxfczR-Q6ao9@infradead.org>
 <CAPjX3FeGgDbX_JSWN8tf3Aicx2ZSYt5Rwwa+p+WRGN7cQk13sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FeGgDbX_JSWN8tf3Aicx2ZSYt5Rwwa+p+WRGN7cQk13sQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 19, 2025 at 10:28:55AM +0100, Daniel Vacek wrote:
> On Wed, 19 Nov 2025 at 09:22, Christoph Hellwig <hch@infradead.org> wrote:
> > On Wed, Nov 19, 2025 at 08:34:13AM +0100, Daniel Vacek wrote:
> > > That's the case. The bounce bio is created when you submit the
> > > original one. The data is encrypted by fscrypt, then the csum hook is
> > > called and the new bio submitted instead of the original one. Later
> > > the endio frees the new one and calls endio on the original bio. This
> > > means we don't have control over the bounce bio and cannot use it
> > > asynchronously at the moment. The csum needs to be finished directly
> > > in the hook.
> >
> > And as I told you that can be changed.  Please get your entire series
> > out of review to allow people to try to review what you're trying to
> > do.
> 
> It's coming. Stay tuned! I'm just finishing a bit of re-design to
> btrfs crypt context metadata storing which was suggested in code
> review of matching changes in btrfs-progs. The fscrypt part is mostly
> without any changes to the old v5 series from Josef.

The point is that anything directly related should be presented
together.  Patches 1-3 don't make sense without the rest.  And
especially for patch 3 I'm really doubtful it is a good idea to
start with, but that can only be argued when the reset is shown.

