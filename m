Return-Path: <linux-btrfs+bounces-3108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0987679C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 16:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3764B2139B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA612C853;
	Fri,  8 Mar 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnjqZFAS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27561F93E;
	Fri,  8 Mar 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912902; cv=none; b=uTA8kzX+jGZP2jFt8iiXJnXzfSqSECrNVrvW2esuWuEkFKlz6s8cQhnM6jW0qHIhJPKKtZJPuG0hukoEFciWfXXdiD9CkU/n2Mu/+AlQfkERiJvwDJEPI91AvxW0a/4jB6NIVM+pq0ns7zcOFBjysVQfVdach/vYG4uBLpYT+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912902; c=relaxed/simple;
	bh=FPGG/Moc5+LlyjBEHgM3jCsSpFnnhW5r9DKq5YcU7DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc1iJq5DoY0IZXVx015yGZcaINpNjxMdKPYVrL63vjse8eFbgXmYi3pz6SlWOIiC91HZVt07KAgbpiJIHE/UrzhWti+ViPEHSAiEc8XBIXcVfUnecK00svbUHBnJAS2y5iVevcKAVzPpDk1TZkYJMSLeZIXPQHOa1bxYtS64juQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rnjqZFAS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vw6XUXllEsfYqKvS4Grfl1n0/8cGt2GLiCRaDpyeZqc=; b=rnjqZFASa2R+d6Dphn4uk3C7vn
	LVK0w9dmULOeZL1/9I4pwVZPN4diF5bzhj/QaWE8wxfsE1wlcTbwae8BhlBYwrmHhJxRzLI0ZdBE8
	gL31VSO8afw1xEK/jQxlLdmvryC60+ndyiq2hFHk6AdeYc+kBlX1KF3xYijVPpgQoMXfn5wc6HZ3z
	1jeYrEDvnN5s6Bp+ijsEcRCVduH9N6vHQ3zI9/eT3YrR/w8dWeLhKoCviWAXhecyy0mxA2PnQEzCo
	KE2ft2tezbYdGe5QyxBLHynEC2SIldLkgXLB3Ar/mIfDiLhu8hGk03TXQ7awvzcXm/u7VoH9axd3l
	Kd9oUnNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricSJ-00000009yoX-1FG8;
	Fri, 08 Mar 2024 15:48:19 +0000
Date: Fri, 8 Mar 2024 07:48:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: boris@bur.io, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Message-ID: <ZeszQwa8721XnZsY@infradead.org>
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 08, 2024 at 08:15:07AM +0530, Anand Jain wrote:
> @@ -692,6 +692,16 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	device->bdev = bdev_handle->bdev;
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  
> +	if (device->devt != device->bdev->bd_dev) {
> +		btrfs_warn(NULL,
> +			   "device %s maj:min changed from %d:%d to %d:%d",
> +			   device->name->str, MAJOR(device->devt),
> +			   MINOR(device->devt), MAJOR(device->bdev->bd_dev),
> +			   MINOR(device->bdev->bd_dev));
> +
> +		device->devt = device->bdev->bd_dev;
> +	}

Just above this calls btrfs_get_bdev_and_sb, which calls
bdev_open_by_path.  bdev_open_by_path bdev_open_by_path calls
lookup_bdev to translate the path to a dev_t and then calls
bdev_open_by_dev on the dev_t, which stored the passes in dev_t in
bdev->bd_dev.  I see absolutely no way how this check could ever
trigger.


