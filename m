Return-Path: <linux-btrfs+bounces-15107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA03AEDF5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5821892E2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF428B7C1;
	Mon, 30 Jun 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1jMDW+Hg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73D2580E7
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290868; cv=none; b=n5yAlVXGaW28QWgJbEdLyANN1Ul5RPI4//hF0Mz5cAd9YC3sytybKKd+341OUPldqn+BkKqdfxDT/PAploMBbjbhfkdQbSB1yQPqlCNMJTu6HucT4iuAIWFJM77C4pnHCSYEbw1D2IsBkwqVH2isquUXvo0ppQIggBAvpXWmdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290868; c=relaxed/simple;
	bh=jY84mQder141gtawXFz3IwL6ke2q2dJKs0tle8qFUfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzLkInY6CIUrk+X8inYjJRs1RtlwwqpR56wdr7zjiQQoBjBsFJiouGsXHo5dcA/iz12n3Q0TdeBL4wnPBYEDqgag20FTBDNRdnafa5eBAuUpqIWt80yycDC2qXg4aHEyXOMJYKctZzKZLYqEynbpC+c+89gn7mxbFcFB2890NoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1jMDW+Hg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bEZ/443GI6+54YCQVUQYh/ikofjRRR6AvIO+uS0syhY=; b=1jMDW+HgXlRYSqf2ZYOZZ948DU
	nSuCB9ghgSz04NoMLzxddpT8NS0+YAQtfqLp7hBsegAgRETEaKnQfrFFoPMf+ezGNUarlWX9a11h6
	og7xIN6Ub1i9KsVY0tjcaNI6a5t7azxckuIL0GbxOK/HnxULEaqxFbjpKk+b5HXMD6cO/WDnHfZb9
	h6jsAWo09jma7m9h1o0jPxdmlP92Rn0Q5pCvkOS/uMY0i2U0fbA5yZ4+GbQqQHQxSzLITaTmziki1
	MmGJ77EnxsyHpgem9sC2LHZ0xvioF29y2ojVD5UxOCO+qbHv+4kGJZ2bq3BuWsL/UvE5/pTxYNApG
	zf4nfBGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWEkr-00000002POi-0G4T;
	Mon, 30 Jun 2025 13:41:05 +0000
Date: Mon, 30 Jun 2025 06:41:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, framstag@rus.uni-stuttgart.de
Subject: Re: restic backup with btrfs /
Message-ID: <aGKT8dcPQjhyWu8m@infradead.org>
References: <20250628173308.GB847325@tik.uni-stuttgart.de>
 <82b6ddab-0eef-47b8-8010-9b09fcb70444@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82b6ddab-0eef-47b8-8010-9b09fcb70444@harmstone.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 30, 2025 at 11:07:06AM +0100, Mark Harmstone wrote:
> On 28/06/2025 6.33 pm, Ulli Horlacher wrote:
> > restic (https://restic.net/) is a great backup tool but has some
> > limitations or design flaws: one is, it believes that any subvolume is on a
> > different filesystem. This means: "restic backup --one-file-system /" will
> > only backup the root subvolume, but no other subvolumes like /home
> > /var/spool etc...
> > 
> > One has to add every subvolume to the argument list. Bad if you
> > create new subvolumes and forget to update the backup cronjob.
> > When you later need to restore a file, there will be none...
> 
> This is a bug in Restic that needs to be fixed, though they may not see
> it that way.

.. because it isn't.  btrfs is the buggy one here breaking the old
Unix tradition also (somewhat vaguely) encoded in Posix that st_dev must
not changed except at a mount point.


