Return-Path: <linux-btrfs+bounces-6833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8793F7D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354A51F226A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5018EFE4;
	Mon, 29 Jul 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1IzM35Up"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEE18D4B2;
	Mon, 29 Jul 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262902; cv=none; b=XCk9YcpYabSqPWu7iEzMzDtgJHAFn8lIVW2DlfPPJOIo6zb5QE5xWphBrxRSv9ZU8DirApM8OY6I00GblsWZsKU0KP0ieH+Z1fh8IYPgRESLRgUDJX9M9LNkEv2JHZEenLLuTQbhPTWvcRAnLsXkbhuB4rznbdu3Kx1/WJYV3dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262902; c=relaxed/simple;
	bh=zdKbNpLBctOzpO+OoIHBSRHVZ2YI1X4Bp8WhHzKjulU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skTFI4g7s0Upu6CrhqpBsxtE4G6AwHGGsGiSJVjIeWCpg0LD6y8xw31Tg3ipIV4UgrxX0pddcHFKDmxNta7/Gl/9u0IO3JagYN1frGlVRgM3KqSQWk2c07rkGvXYYzR2xDNlaFTtabu71/fRkmb8CQqS6Vy9jehLk/lEdekMfVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1IzM35Up; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZVZeP4kn4uvUlHvrkW4ziJmVQXuXAiVc7MV8VWayywk=; b=1IzM35UpR6KGDWE3tLxtYcQHIp
	yXqeIHL3femg7Z7DsYX3hLZcj6sCIzrf4DwmA82MK2shllYdMKOgTB0Eenx+TnR+p1KioCBQDvMvr
	rUTSGiSZLRjEA+rQ29J5IAS+AE8dMSojwUD4/anF2dqh+FKD9ROyRl3FpoBKClZBHmvPjBg4Jw2o3
	d5GIKoADwwOUK6tMbQrYDwhYt8WuvFFP76ARRkjUz9RjINECABCkCIP4BOZDc2qqh4w8CdErPKYF9
	ixeDoOBAayQnolnxG1PbVEut5rlVfXdc8U3n8vdRg8nLZYd99NAY90+V4mg3BcYEZRl4m0vbe4a6P
	MukraIdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRFp-0000000BXow-1eN3;
	Mon, 29 Jul 2024 14:21:37 +0000
Date: Mon, 29 Jul 2024 07:21:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: yangerkun <yangerkun@huawei.com>
Cc: Filipe Manana <fdmanana@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, chuck.lever@oracle.com,
	zlang@kernel.org, fstests@vger.kernel.org, linux-mm@kvack.org,
	hughd@google.com, akpm@linux-foundation.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
Message-ID: <ZqelcfdBQzc93w80@infradead.org>
References: <20240720083538.2999155-1-yangerkun@huawei.com>
 <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
 <4188b7b5-3576-9e5f-6297-794558d7a01e@huawei.com>
 <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 29, 2024 at 09:53:52PM +0800, yangerkun wrote:
> But after commit a2e459555c5f("shmem: stable directory offsets"),
> simple_offset_rename will just add the new dentry to the maple tree of
> &SHMEM_I(inode)->dir_offsets->mt with the key always inc by 1(since
> simple_offset_add we will find free entry start with octx->newx_offset, so
> the entry freed in simple_offset_remove won't be found). And the same case
> upper will be break since we loop too many times(we can fall into infinite
> readdir without this break).
> 
> I prefer this is really a bug, and for the way to fix it, I think we can
> just use the same logic what 9b378f6ad48cf("btrfs: fix infinite directory
> reads") has did, introduce a last_index when we open the dir, and then
> readdir will not return the entry which index greater than the last index.
> 
> Looking forward to your comments!

I agree to all of the above.


