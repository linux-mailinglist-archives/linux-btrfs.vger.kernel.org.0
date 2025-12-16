Return-Path: <linux-btrfs+bounces-19777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F1FCC18CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14955308A3BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD7341AAE;
	Tue, 16 Dec 2025 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S/+3nlWQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B72EDD5F;
	Tue, 16 Dec 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872052; cv=none; b=Jat0PZMu1wJNZJnpsgkZDPl+6zYTg8BsH9Sr7ER8Eg3xOtX0Mr0+5gGOvVLZqpSQ0kRVwft4ZUd7lK6rXxRslR4I0HAO51OEhPFpodFvHN/6xw63xZTn1XfUriKxfSxrXH7dCu3zHwyQHZSQQ++BBtu5ZY6hkoXtaN32RNQxZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872052; c=relaxed/simple;
	bh=+1w1ClCVVwqqorIcvTS4btJlfzeWG4qIC5lBnT6oZsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYe3zkITuAFna1dHaFrXirgy8GJEX3GV+Q9d0JrEHWeHtD/AikX6lO1BH0J3bwzKF3t1jalQ7s7biITILQGdHbRV2MeiegSJg2CcjmDiTizSjgexWD+BdBE6vgEXKavlZ1zyQXCHKy/iDEC2UDV53iteRfzaVbvufPCo9I6Yd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S/+3nlWQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+1w1ClCVVwqqorIcvTS4btJlfzeWG4qIC5lBnT6oZsg=; b=S/+3nlWQnZVLw2m2ZfFMn7CgsE
	Oz+8gl6qAQKBa15eDgkwi+0bVJ3TZsWmUP4pAOsBneHRmYtrB90MQKOWbZhLul1dykbUfMlXlm2Jt
	agCv3mdPCXDivyClyDnOVDnuQjMQ8gNmkaCsCQ0KmpPPqZlRm/guIQIdUYDcVmXfTVYu4U3IKbdne
	5yKWyNbBsY42gJV5yEejpWSKQLT++QAB7rYZGDlGNqXQtWaG9kDJtjoaFQB51LVoYAVPE4UofmyY5
	iUEARf0l7runrwNwfm+z2hGVteSruRVyhvxVkJn5V0G6ANOz7tHmEepiZsNEM1Yw45DTGmFfFzGAh
	JF7aMF3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPzC-00000004t9m-3Xsg;
	Tue, 16 Dec 2025 08:00:46 +0000
Date: Tue, 16 Dec 2025 00:00:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 11/12] bio: add bio_endio_errno
Message-ID: <aUERrkGTA1enfVst@infradead.org>
References: <20251208121020.1780402-1-agruenba@redhat.com>
 <20251208121020.1780402-12-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208121020.1780402-12-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please push out usage of errno from block code instead of making
this more easy.


