Return-Path: <linux-btrfs+bounces-18399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BC4C1B64A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 15:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE5F1AA2176
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A2B34FF4E;
	Wed, 29 Oct 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GEuqbie/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAF29B8D9;
	Wed, 29 Oct 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748701; cv=none; b=s4xRSZn9cdh8OuRL//2JjdBIfL/smueyQmQVB/kbcXVD8Q7VfUAgz7cZdCYzEdtXa2CP+I44cu72UDBxw9hNnylS1axRAtAAvB6QESN4oh1kAhRJcrR5ALWAMm01kZhnVLunWAV32K6j8rYxxn1mQX9Nw+EoWDkPu4bCz5QUFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748701; c=relaxed/simple;
	bh=GC14kFMWPtWt2Gtkk0MgEoVLhYTmCarqJXnxSpavDAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9Lr1N1ZryIq9NvUwKMQKWLHvkSmdDgLydQHDy8QFRFiCjvtYsrFHBUAYBvAK08pms9QcG1JfPWn73FFACsBGHPj5LW96dbTbTUhPc2RLnMNv7Qdg8ZwzPFcg74W/NbQBGkEFJD2F7USmuQ0+Q2MM7LtZCuT1IkRAznNgH/Bxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GEuqbie/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZSNefP3kGlhfDPKLLTZZZwOAu0fb7rvyzu/Kl7KhTYU=; b=GEuqbie/FD8XRtOvpksnrYmVM/
	yxBYrL3OAGeTQjnvYE8lWldox55/VPUDo9bbo1GS/N63U9F8V1KN/y+de3zS+l34ZZ03nWBteFZf7
	DMo3ovFyKPDMV9Q+jJqEW5TtTYwBtOrXcu2CkMdedFvHOJYFYA0QU4HSxPXmAPQjp70karpYHfF4O
	nqq9/8I505ZPmHqy0s/iYCPoIpcCrpUjAP5mLXSWZ9Frnp5NhnbQ6ph6uxqUu3PaXLSQWfAtupK5+
	hqOpHXJS4gGOGpyAUHrK8m1Pr/s3mdU+EyQQCElhMSxXXZ+fs9CJo/mdnfHuAYJD1R7FpPyQ2fBBj
	2g12CylA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE7JV-00000001cIo-3QHR;
	Wed, 29 Oct 2025 14:38:13 +0000
Date: Wed, 29 Oct 2025 07:38:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Askar Safin <safinaskar@gmail.com>, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-lvm@lists.linux.dev,
	lvm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	DellClientKernel <Dell.Client.Kernel@dell.com>,
	dm-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	Nhat Pham <nphamcs@gmail.com>, Kairui Song <ryncsn@gmail.com>,
	Pavel Machek <pavel@ucw.cz>,
	Rodolfo =?iso-8859-1?Q?Garc=EDa_Pe=F1as?= <kix@kix.es>,
	Eric Biggers <ebiggers@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Milan Broz <milan@mazyland.cz>
Subject: Re: [PATCH] pm-hibernate: flush block device cache when hibernating
Message-ID: <aQIm1bfwKlwaak52@infradead.org>
References: <20251023112920.133897-1-safinaskar@gmail.com>
 <4cd2d217-f97d-4923-b852-4f8746456704@mazyland.cz>
 <03e58462-5045-e12f-9af6-be2aaf19f32c@redhat.com>
 <CAJZ5v0gcEjZPVtKrysS=ek7kHpH3afinwY-apKm3Yd4PmKDHdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gcEjZPVtKrysS=ek7kHpH3afinwY-apKm3Yd4PmKDHdA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 29, 2025 at 02:31:05PM +0100, Rafael J. Wysocki wrote:
> > This commit fixes the suspend code so that it issues flushes before
> > writing the header and after writing the header.
> 
> Hmm, shouldn't it flush every time it does a sync write, and not just
> in these two cases?

It certainly should not use the PREFLUSH flag that flushes before
writing, as the cache will be dirty again after that.

I'd expect a single blkdev_issue_flush after all writing is done,
under the assumption that the swsusp swap writing doesn't have
transaction integrity for individual writes anyway.

