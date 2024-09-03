Return-Path: <linux-btrfs+bounces-7761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E028A969314
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968361F23CB4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 05:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F081CE713;
	Tue,  3 Sep 2024 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mwoXGi+k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8323BE;
	Tue,  3 Sep 2024 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725340059; cv=none; b=o09Mej2eR4gQoMhUZ7knVm8Fte/4Qw+9rkOI7d+aj2Q+Qe972j3BAQ7vugw9K4GYBJY9QW5mwdZlcDxEFsDUTla2iD/EMbc8iBTtieeTftjlDqdiFNTJg5sVc/+4tKGtT4fC8GuCblEaukpM/0d67CRs2vGK/yyvxy5/lfEMVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725340059; c=relaxed/simple;
	bh=QR8KpexYClL8IRdLArHW+kdkxdQgfrxTW44YiOqZjJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JebwGJNHtuNRY7PJYnZltUWmoSxzYVMIJXbfzO7IABvoPy8v1hIa4pRc0ZxM0EGKj7yRJ2bQmzSf4SQnNLwjZth4DpGdxD/vLCyQGHoNwY/w64s3hztuNpbcQaz8wK5enBuxm5211167x74UGbirbwxFHYwoz7wjEx01iyyqUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mwoXGi+k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N8iGEs+2ha/BJEgUuLI0GQcUU0NjYe0cpQh9ftE0F4E=; b=mwoXGi+kr23kPbx0IA5m6beSzf
	4+xaWbWViUzuiqGKoacNeJfEYyT8+QZ/XYNVsQfpZ53L/56e+tx6v6wslZ+Ahn54YKlpObbxf/3xu
	StuiCtzttU8gIk13RMLdBcYWf8RUBW7NXoZ46hTZN50xa6o1esXL2XmEdXktztbPePsw33mQVl/Ch
	ahgNKtb5y9in5mi5XNDmMBpEw00ifG9AojJ7OHCJDbM2kzpd6K3v5LB+an70DNHXRd3AW5PuXFSr/
	hMgIfHqnrYKmmhsFsuGzL/5tX4z4WoxylfqqiRh69JpAXDFSJXhNbShoBt9M9FS0i1dOJF3iKKKP8
	H9ENx3fA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slLlP-0000000GLIh-0qUL;
	Tue, 03 Sep 2024 05:07:35 +0000
Date: Mon, 2 Sep 2024 22:07:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] block: Export bio_discard_limit
Message-ID: <ZtaZl99aNYcRZv-2@infradead.org>
References: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
 <20240902205828.943155-2-luca.stefani.ge1@gmail.com>
 <20240902215705.GF26776@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902215705.GF26776@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 02, 2024 at 11:57:05PM +0200, David Sterba wrote:
> On Mon, Sep 02, 2024 at 10:56:10PM +0200, Luca Stefani wrote:
> > It can be used to calculate the sector size limit of each
> > discard call allowing filesystem to implement their own
> > chunked discard logic with customized behavior, for example
> > cancellation due to signals.
> 
> Maybe to add context for block layer people why we want to export this:
> 
> The fs trim loops over ranges and sends discard requests, some ranges
> can be large so it's all transparently handled by blkdev_issue_discard()
> and processed in smaller chunks.

Then don't use blkdev_issue_discard but use blk_alloc_discard_bio
directly.

NAK to the export of bio_discard_limit.


