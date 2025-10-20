Return-Path: <linux-btrfs+bounces-18030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A75BEFA7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E18A3E1832
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 07:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C12D9795;
	Mon, 20 Oct 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z5jKU3Jf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3F29E0F6
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944918; cv=none; b=pHUDnl2m03fg+ZlPiAI5xRs4xfzzJribWu8buKFbQdrZzYrChYEcvJWhlQO22GQPoXTTj5FRXk8r2wduoZV/dJAYBjwaPu9I9xGJYgLs+0bm2nCQoLqKd/qGX+vAUnlrFRHeSCRQHzHen5D1D+9YL0sJ76Pb/gb0y/aUVmw+yW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944918; c=relaxed/simple;
	bh=EuLTctaitAaVSnbXZvz+g4efGGK1UM/WP6sW2ZnEq00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3+lOobBqyggyH5RkxegZit41bCaWCKZpJ7K85qnskbAsFvYoMVcuj1kOrp9KUTYjjl85JEsZSPRNjVfI+zhHNxk4eGtzdgGWA8NSlHLm+uglrwiV/iQzQysYvgk3HJk/LSUhFXDkAU0EPr9VL+nk0coMiuSLi0EcQynDwU7Xfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z5jKU3Jf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rb9IVoK/zz8Qa57OgjBqYeiRlMYS1WkTiEIINHR7vfA=; b=z5jKU3JfU1PaZkRHmRrMzswrFH
	/urReCy6EDBFOHXbaJVZxdb/zpXtHzqoxzLVu3LjoG6adAX/biZUgSN6CZzLjpASp1G9RbvCZnUwW
	8QiS2maSI5OWeHOp5ius3Dty0uDlO+MEVIjhFdOwn/aBRxXihmC8OQyFUuNLVwboU5/GOF1lV6sbY
	FsRLAKvgYEmN2ge5AtOkcSe8alM7cQymu+9PbMPv6admsyDqvoI1VNBHdbIAb2x6C0xbhJD9cuFXv
	WeLh6vkN+4ri8vjxMa6ySyTH0Q3LU9I2EYElhzCcDlIJPYYYheC/ypPDotwp6yznPf/CN7W+/7IOn
	ePXpu6JQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAkDM-0000000CC47-1kOY;
	Mon, 20 Oct 2025 07:21:56 +0000
Date: Mon, 20 Oct 2025 00:21:56 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Message-ID: <aPXjFL6vz6UM_CH5@infradead.org>
References: <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
 <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
 <aPCXz7ktsyE8BLeG@infradead.org>
 <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
 <aPXa9gR4l3WnI8kh@infradead.org>
 <506e7292-d795-4a78-9c0d-8442cb3b7a15@wdc.com>
 <aPXcYQPPYtA98MBM@infradead.org>
 <0f067fa8-acaf-400f-a36c-e124ae95e337@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f067fa8-acaf-400f-a36c-e124ae95e337@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 06:55:46AM +0000, Johannes Thumshirn wrote:
> On 10/20/25 8:53 AM, hch@infradead.org wrote:
> > On Mon, Oct 20, 2025 at 06:52:04AM +0000, Johannes Thumshirn wrote:
> >> OK, maybe I tested wrong. Does it also hang if you only run zbd/009 or
> >> do you need to run the other zbd tests before?
> > Just running zbd/009 is fine.
> >
> > Also make sure to try to use my kvm script as-is as it gets, given
> > the bisected commit I might be sensitive to the open zone limits or
> > zone append size or something like that.
> 
> Yeah the issue on my side could be that I don't have virtio-blk devices 
> attached to the VM as I don't have debian images lying aroudn for the 
> rootfs (I'm using my hosts' root as a RO virtiofs mount).

Actually, the zbd tests emulate the zoned devices on top of the regular
ones, so it should not matter.  Here is my blktests config, btw:

TEST_DEVS=(/dev/vdb)
nvme_trtype=loop

so nothing special.

