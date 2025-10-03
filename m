Return-Path: <linux-btrfs+bounces-17374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29820BB6320
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 09:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA41F3AD212
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BF6245006;
	Fri,  3 Oct 2025 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="at1bdTwB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4B189F20
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759477531; cv=none; b=HCX9y3p+Ci9MB5o8gx5TtI8AeOSfLvw/kYs578cOsvT9Ki+eBKQkCMjtgLcpGL+mTstUEP4wpe+Q0OzoYGAojgXtCHe6IanMvKipv667dBrTTbW3ptmAewliX5h9ljie8Uv8ldZCZvRXlqiSM1l+uLi5UxXBf+qkO/nQ/NqNUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759477531; c=relaxed/simple;
	bh=T+qpAfmQ3ddPI8i6kPAQXkOOEG6uaqsUI8lXt7BIWB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XajCT0AR2n19Cbz6el3XlEjIhGMB6fdho98b57hqkhv+Rw1+Pb9jlsZVRpFzOwjflejBZpYBnhGoKmyt/M6rWgAImHcYoUEYvz9St6nc/Ce1bvB767bD5s/xoU6SYr4z1U1vtMDhWecAF33b8hSjuHuGpzdQjRZl1CoR78VEIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=at1bdTwB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y/w3OMMGpM2VbY9pVKKa7KkQxU6beWI7+Pf+Sr1n5YQ=; b=at1bdTwB62kx+LqWVW9WRpBE2U
	+i7lAyHIzoGDKSzl5y4rtuYTSOkE72iF4GHC9W/76swIXyaq9BxiOZA0CjsyBXUaTLU93GhnqPTyj
	o35UqKc2vMNK202A7lXYuccYj/nvOaSRIq6hjRobJkUZ/64wSEuXm+fawW1PRbfUgJoGA8WTc6CxU
	VsEdeLiqeeHcmYKbXGqT419OSY++F9RtrFqC0C5k3SeKNW0evfg7teSP5qeNp5kj3mwWLPjtvXC4w
	a+8KtDcZMDwRIgC2dQ206aIpJvjG1GGChfhW+sFxbvmO4pBfBimlbAj/CKpG3MJJ1HAfEnzwJtpXw
	Gn9fLHLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aTp-0000000Bq0v-1oZB;
	Fri, 03 Oct 2025 07:45:29 +0000
Date: Fri, 3 Oct 2025 00:45:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
Message-ID: <aN9_GeMp4jIlISuk@infradead.org>
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <aNF9xH30pAEq5y4r@infradead.org>
 <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
 <aNGFdxq6Xqduoj6w@infradead.org>
 <7b756bc3-fae4-4cbb-99a1-117880269269@gmail.com>
 <aNGH9s0xoIg9Isk5@infradead.org>
 <0b428deb-3711-4671-96dd-69c149fd8ccb@gmail.com>
 <aNpIZ2iMChSUzD3y@infradead.org>
 <4ffbf6f3-1a6d-44fb-ad9b-df5f4cae79c1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffbf6f3-1a6d-44fb-ad9b-df5f4cae79c1@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 29, 2025 at 09:34:32PM -0400, Demi Marie Obenour wrote:
> On 9/29/25 04:50, Christoph Hellwig wrote:
> > On Mon, Sep 22, 2025 at 01:54:56PM -0400, Demi Marie Obenour wrote:
> >> This leaves the question of whether the needed information is in the
> >> filesystem metadata.  If so, xfsprogs and/or btrfsprogs could obtain
> >> it from a block-layer snapshot offline without needing kernel changes.
> >> Otherwise, kernel changes will be needed.  I don't know if the changes
> >> to the userspace tools will be accepted, though.  Until then, btrfs
> >> send/receive will be the only way to efficiently back up a BTRFS
> >> filesystem, and XFS will only be able to be efficiently backed up
> >> at the block level.
> > 
> > Using userspace tools that poke at the block-level mapping is
> > fundamentally unsafe because it is not synchronized with the file
> > system.
> 
> Is it unsafe even if the filesystem is not mounted?

Well, if the file system is not mounted whoever pokes at it is obviously
in control.  And needs full understanding of the on-disk structures.


