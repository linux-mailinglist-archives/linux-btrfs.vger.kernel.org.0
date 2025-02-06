Return-Path: <linux-btrfs+bounces-11325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E882A2AD1A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 16:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDA8188375B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99951F417A;
	Thu,  6 Feb 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn2sB7k0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF24C8E;
	Thu,  6 Feb 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857303; cv=none; b=PxwfKhgwsy3nOx/9g7CE0cqI8EJJSzN4yuX7HKj09jxZhIOUUZmq1V6LeH7bnxo7T0QcatM9YGkNIlfX+RRVeAFFu5HYjeMbSNV41VE6lCL5gHi7pWtTNxRRdwKOIjI718LgWohMBm6ObJ5EWl6HdTnRiBENuJOCc57D63L1H7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857303; c=relaxed/simple;
	bh=mAblgVyLmF8y1qbNp81i1fe9lfCD39IUWlVF35IY51o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8DuRPoGvGqoQwVX+uWxD9878J05H874QnHgxyISuk7kESUntycmbvoIFirs5uRuwlDp7pqtM9mMGRXktdEKecdSgyKSJZFXj2KFOgT+fXO1DJcyKPcY8cajIZK7DR7COHlW+EQupDfkWrtsQOlLLXW7Oir19OsrZn6brPzK+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn2sB7k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E17C4CEDD;
	Thu,  6 Feb 2025 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738857302;
	bh=mAblgVyLmF8y1qbNp81i1fe9lfCD39IUWlVF35IY51o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sn2sB7k0Du1qnkYxClV00KIxOCBhztnTdvRfRu/cNvqxKTk1whVPZBpC8rhrw58VP
	 PVEM1tsLJwQ57e9RD5u0OENJAsH/D5kT0s71PZfGSVf3/kKFB+RHIQ8ioDBEu/eZT/
	 D7JAPcPfRnCEcnwRs5YcJIg0mGkrgzfNqlTWvUlfKNNRkjDTug336Q85oXxWSbEQFp
	 fsUVVboiMPv4+GwZV6zK8dZhkAeoQgae4g8iJh0IS2kTYZ0/+LW5uyT0Uu5PbfpzGq
	 38JAv6CGbfpn6FZ9aXck9Kk2tfWhqHfcZQjRScpGI7STSXcT5P9INicUcQgGScQo7A
	 jDasjq5yXLl8w==
Date: Thu, 6 Feb 2025 07:55:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: fdmanana@kernel.org, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: suggest fs specific fix only if the tested
 filesystem matches
Message-ID: <20250206155501.GM21799@frogsfrogsfrogs>
References: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
 <Z6TC_yP7pTlzDOH4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6TC_yP7pTlzDOH4@infradead.org>

On Thu, Feb 06, 2025 at 06:11:11AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 06, 2025 at 01:05:06PM +0000, fdmanana@kernel.org wrote:
> > +if [ "$FSTYP" = "xfs" ]; then
> > +	_fixed_by_kernel_commit 68415b349f3f \
> > +		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> > +	_fixed_by_kernel_commit ca6448aed4f1 \
> > +		"xfs: Fix missing interval for missing_owner in xfs fsmap"
> > +fi
> 
> How about you add a new helper instead of the boilerplate, something
> like
> 
> _fixed_by_fs_kernel_commit xfs 68415b349f3f \
> 	"xfs: Fix the owner setting issue for rmap query in xfs fsmap"

While we're at it, we should move these _fixed_by* functions to a
separate file to declutter common/rc?

And maybe add a few more dumb wrappers like

_fixed_by_xfsprogs_commit()
{
	test "$FSTYP" = "xfs" && \
		__fixed_by_git_commit xfsprogs "$@"
}

to replace the opencoded versions?

--D

> ?
> 

