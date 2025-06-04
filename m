Return-Path: <linux-btrfs+bounces-14456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1CCACDEFE
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 15:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A8A188C596
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19828FA85;
	Wed,  4 Jun 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fn20OU8i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E3B175A5;
	Wed,  4 Jun 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043466; cv=none; b=sDTbYSHsazDQ9onC5KYoZJsEj/sZDLXg2fcxkEL3LJpfDUpPSw6yETfFuTYxyD2XtlTS19YTyagJLFlzLbe5AEZTc+kKAQLb1SxvJdxjJf4q0lF/C2Y4B8T7wH4uI+Ag3epD3156RemJwNxV2i14G/fuoqscCfu/V4QGIzEWjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043466; c=relaxed/simple;
	bh=mwrdA8RCZC6zG6SM8CoVIafph+UzKTn/4uUkKeBZhsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5gpiHMMDe9B2NwyLArlTJ1YFp5sT+0EbM/Rq9ZZ3pQm8XOXcYUanz6/vU9PZtRuofevsQVapoP4RzKEN8ci1wOtOZOED4ADS+FuOCNPX2P43V4YMTUXYW+7sNo1297QAAoDd7MamrWC5pa9JACB2dOICji5eFAl3tbRjfRTy/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fn20OU8i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NXEOZV3vdIIMNzs/QCkcuGXuGGF0hsMB7HnHUI/XU8A=; b=fn20OU8ilvd22tNu02WildV76o
	P7P7A875gZNultiTZf9gpeH7Zzx9dT0vmnOnbdtE13VCaciU/o+jmbrbDlDlf7/kvZ1+6MKssNH1V
	6PRa51S7tXVwvSa1n95TUA5ydz+jhYU4LYbfH0n3EVtGEyFMXfOKBFV0izX6yuDaGLquem+pzvi/Q
	xgHqf7FxSne85GcoaFU0lmvF+5jfQ7ykKjOlIBQxYsgBG3XmCyb4LEKAISdZdt8FeFr7xV5RRbSdp
	+DS4jNytK5TgTGwZs27aYvGmV6sUFPoB1CrJToC6HbQJBr0dQhq1dJIKkwlKg2SbPsjoAEOBwAjjm
	sB/uUDYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMo6S-0000000DRGF-0WoG;
	Wed, 04 Jun 2025 13:24:24 +0000
Date: Wed, 4 Jun 2025 06:24:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/730: exclude btrfs for now
Message-ID: <aEBJCG1_VRDggo6N@infradead.org>
References: <20250604062509.227462-1-wqu@suse.com>
 <aEAC5WTF_tGh_RpN@infradead.org>
 <76226c51-78c5-4113-a04d-694a50b98557@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76226c51-78c5-4113-a04d-694a50b98557@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 04, 2025 at 06:47:41PM +0930, Qu Wenruo wrote:
> Right, the ext4/xfs can go a superblock shutdown because they are single
> device fs (except the external journal device),

XFS also has a RT device in addition to that.

> and fs_holder_ops handles
> the single device failure by calling back into the super block shutdown call
> back.
> 
> For a multi-device fs, it should go through the blk_holder_ops, which btrfs
> doesn't provide when opening the devices.

Yes, btrfs would need it's own fs_ops.  Alternatively we could add a new
->devloss super_operations method and change fs_bdev_mark_dead to
something like:

	if (sb->s_op->devloss && sb->s_op->devloss(sb, bdev, surprise))
		goto done;

	<sync fs and stuff)
	if (sb->s_op->shutdown)
		sb->s_op->shutdown(sb);
done:
	super_unlock_shared(sb);

so that btrfs or other multi-device file systems don't have to duplicate
the logic.

> I guess it means, if a fs supports per-bdev shutdown, it won't hurt to also
> provide a full-fs shutdown ioctl?

Supporting it is a good idea in general as it enables a lot of good test
coverage in xfstests.


