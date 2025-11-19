Return-Path: <linux-btrfs+bounces-19127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ED5C6D62B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 09:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9B2912D645
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B91328603;
	Wed, 19 Nov 2025 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xy5cpqz3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE626AA91;
	Wed, 19 Nov 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540564; cv=none; b=tHgBIalQ83kOMbCJ6p6Cl372/MmbbVp3U/tTxqyWsnk/e+nMDu4JbT1KctFd8jilFEJVEaJ93rUb5G6wz/uRahBM33TzK7oEAisNg4AuaOr7fGJRPVOOtMwWwRllRWLwtGe5xlV3qqa+2Fqm/KpH/tYdiW7bRQdFnj+O4PnB3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540564; c=relaxed/simple;
	bh=oqpwHYxshyON2GcZiPgb1Q0gR5Zh1Ggqk4g5bV8hmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG41/J1An2RgPMSWViabBz10sF/gOyV0+4OdOy17sOd1Xz/w2eA/p8A0N7y40z9wf64+4fSsvRFgfHrlDl+LJ1gfmcia8hBMbKHqNQtXfZf777adl3m6dPUUrkfl/bRizmGWI905Y/NS5YZUu3nYnH/cMkcSNmtaU4Y/bTQjVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xy5cpqz3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WN4plxs/5laYn2fHLoE7cAiLYI6wazHszjlzW8ouQLo=; b=Xy5cpqz37r4cMnN7TG0CjrX+Ky
	CoB4fMl59aPt576nlf9+Ntn7g4dY5Tm8xqi1lq45jXEzoGDwtaH8SM09T7s4EWlZUHN/jlVF/8i6B
	fSAWVk5aAcxSPkHMJjIMtk7KEu0hKjv1SXdCaW77Rz4NmlQKnmh0oMw8tP7WnV+NLjOm026x2Lp8i
	Jw1vrseLdJPGPQRCV5ViiXKziCa9IkvPWAuAA72JhqqY6PKAuFu4DzhUiE853lwXRU5oY6cBXe9On
	QYgqc0BOtQeIpxyeLcERAr1iahsfWVRz5HgEUGy4GIwO2VcF1XHqOi2E+AxUbrAS1VD21qlKXYKHN
	XqpCWkgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLdSZ-00000002mnq-2AM8;
	Wed, 19 Nov 2025 08:22:39 +0000
Date: Wed, 19 Nov 2025 00:22:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Vacek <neelx@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
Message-ID: <aR1-TxfczR-Q6ao9@infradead.org>
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com>
 <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com>
 <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
 <84128576-17f4-460a-9d2f-9e40f43f2ef7@gmx.com>
 <CAPjX3FedNEUeGr3sROdHaT0iKhHDfsi4V=GQHcmvhx6wEJqUcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FedNEUeGr3sROdHaT0iKhHDfsi4V=GQHcmvhx6wEJqUcg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 19, 2025 at 08:34:13AM +0100, Daniel Vacek wrote:
> That's the case. The bounce bio is created when you submit the
> original one. The data is encrypted by fscrypt, then the csum hook is
> called and the new bio submitted instead of the original one. Later
> the endio frees the new one and calls endio on the original bio. This
> means we don't have control over the bounce bio and cannot use it
> asynchronously at the moment. The csum needs to be finished directly
> in the hook.

And as I told you that can be changed.  Please get your entire series
out of review to allow people to try to review what you're trying to
do.


