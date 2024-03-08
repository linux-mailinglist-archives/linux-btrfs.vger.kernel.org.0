Return-Path: <linux-btrfs+bounces-3112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E8C876826
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68142B2354C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD754F9F;
	Fri,  8 Mar 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F/vUhKki"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD424205;
	Fri,  8 Mar 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914254; cv=none; b=Xooxudka2GPmSn9j/aC/qID7thpk6iZe+KDZih9iR4U9jT4deaFjwgETkgb9cGt86n6AP/S5ONnR15xumAJ0TWHjQust3is9skrOljohU+uvpBw6fE0UxMn/V26eYKuchxm3uqkhixB9jo8I/+RqCHs2vYFZzBK1HIUc4URVkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914254; c=relaxed/simple;
	bh=qjJYfwa+pOTRc+vltZoQZHc84aF7ssCb/jIXC3stAak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwgSwWJ3JANeIXwyB988zDFRcX1hy3Rtvmk3oQ15eX5jPgjzxA4rxot4/43J2yF46L82URFflyhubnEBN0ZsAC3ULWUnpEtz3BbzYgmBG7E/P7FqaBkB+piBmg4X4fJGFijZg14r+Y3HRWJg/NXUcvg/noFeVHs7siV0uM/F0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F/vUhKki; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pKIHn/StlQTY2KNq+RwxD5E0SP4dz0OFm6Qt5OGNjIQ=; b=F/vUhKki/3keYSUS12PrpjJSfu
	jAK4MraSQbJQPU1y8z/WUREKxnV/DGxh/XqaT7guR8fCiyckKJKewVFfy0UCQP49OGXXJT7OaNirX
	6GUEeOZ+w2XMGU8nZG11d0TiTeH/KgskATP7juuRBIOmnCdyj59Xbt2va/fTQbMyEC6gNDejKx8h+
	DHNKekoH2mLp78zddkVoQs2bJcA/2Eo/kieiFPek6vadY9zmZjbZN56/e2mR8VLiTjCmzOtcU2SOV
	gKCLNCGuo+ea7x+6LS+UKw95JoaG0UAp63Q1xAucYFkId+6t+xa9avirXXjei5Q29/Hz4cAqa/tNE
	4RJufrsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rico7-0000000A4vH-42PG;
	Fri, 08 Mar 2024 16:10:51 +0000
Date: Fri, 8 Mar 2024 08:10:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, boris@bur.io, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Message-ID: <Zes4i3qvFk2nWjyY@infradead.org>
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <ZeszQwa8721XnZsY@infradead.org>
 <be3571d7-2bfe-4bad-b2c6-84a0bf121140@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3571d7-2bfe-4bad-b2c6-84a0bf121140@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 08, 2024 at 09:34:03PM +0530, Anand Jain wrote:
> > bdev_open_by_path.  bdev_open_by_path bdev_open_by_path calls
> > lookup_bdev to translate the path to a dev_t and then calls
> > bdev_open_by_dev on the dev_t, which stored the passes in dev_t in
> > bdev->bd_dev.  I see absolutely no way how this check could ever
> > trigger.
> > 
> 
> Prior to this patch, the device->devt value of the device could become
> stale, as it might not have been updated since the last scan of the
> device. During this interval, the device could have undergone changes
> to its devt.

How can it become stale here? btrfs_open_one_device exits early
if device->bdev is set, so you set up a new device->bdev and
stash the just opened bdev there.  The dev_t of an existing
struct block_device never changes, so it must match the one
in the btrfs_device that was just initialized from it.


