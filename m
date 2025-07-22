Return-Path: <linux-btrfs+bounces-15620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581A2B0D23B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CFA5472F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 06:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE628B7FE;
	Tue, 22 Jul 2025 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rXibn0zP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2DA28A408;
	Tue, 22 Jul 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167361; cv=none; b=OoVLYJZ8YDHUZdvtZVnkXq2OUJfYeqwfq0csfBmFJxhpMjsP10v+Yzvaphx7hH4ezYXXNPDkE3AweUZ4oL3i/u9LyGFGJ6q8+wsW1EYnsKh8V+dG7xD4RyE7/fLf7fX4GnxXSruCA5KjIwuG5RBEqAvdL6CJUcTIZEhhww7+5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167361; c=relaxed/simple;
	bh=gg2taDPW8jgRTBT5TU6Jw1xrDbfjZ9mzG7vuaBSXfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHxuREOCtB0+1Rjrv/sNWBuDb6GAZse/7pTbCL4wpZBIuXwQ9m2d0G/UiFVnyLdjpR/UhmFYQ56S2jjzdq6gZtJ0onYwG+NByRDneAIyfDvcb3IIws5gGCeiVpn9bCqttIhna0Dd2ZG0eEsNxNR5if0nvjSAJgDBlzdRNZ+0EFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rXibn0zP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gg2taDPW8jgRTBT5TU6Jw1xrDbfjZ9mzG7vuaBSXfOk=; b=rXibn0zPHLBMh/9Wc0JlQPqIFK
	LVG6hg/yCbS3vF1YpwldLwPy1WQy+63SIBDDcdetakxHdYB2R+TA7o4ClRviTr3WbTpokaPO5D1uV
	fAMe89QMVgwqciFksnvULN/usFAigWazb16l++m/IOj3UBMUBOUJL/+I+Da3maw0xv+9e7I0uSXgq
	VVirofVO+FWKc8Lt5f0zTrEQGetwHAPN+1/DfWPPi6ZTrlE62YYxT4A1VVE31OiqO1Ivs9yFu9dVN
	MWG9gaKBE7VqrcfE04WjqYleJWNOF/sFUhR5JZcGSYmkoKmUAz2gGlHmNUXspAwW1HKXHJye8j1DY
	QZ+gQu4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6ut-00000001WSu-3vAp;
	Tue, 22 Jul 2025 06:55:59 +0000
Date: Mon, 21 Jul 2025 23:55:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>, linux-xfs@vger.kernel.org,
	johannes.thumshirn@wdc.com, naohiro.aota@wdc.com
Subject: Re: [PATCH v2] generic: test overwriting file with mmap on a full
 filesystem
Message-ID: <aH81_3bxZZrG4R2b@infradead.org>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I just noticed this test failing on zoned xfs in current for-next.

That's because for out of place overwrite file systems writing at
ENOSPC will obviously fail, and I think the test acknowledges that
by forcing nocow for btrfs.

But that leaves "real" out of place write file systems affected, which
should also include zone btrfs, but the test actually fails there
in mkfs already due to some reason.

Can you please rework the patch to see that setting the nocow flag
works first and only try with that or something like that?


