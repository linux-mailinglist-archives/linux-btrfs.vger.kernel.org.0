Return-Path: <linux-btrfs+bounces-15083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06060AED3F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C113A78F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD81A76DE;
	Mon, 30 Jun 2025 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L4yjNU8/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC086359
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262037; cv=none; b=AFwb/98yuH8UNquxMNw8H4u8YMYoxXYDRYPYWZl27johzpfrnNTxuoSibX4xBCM4FSRwpGYRPfs///ZxirmeOGK9FdLEwrbGMfwTwFxvADRAL1k0jpS1XgqrXA8zrM3pBSwglIhx3t56PDcLvCRJ+LYsw4tZVycjvMSibCf9Xv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262037; c=relaxed/simple;
	bh=P7yEHbhd+EwwLoSXcD+JNYKFqb+mm1kVQ94GBkoux4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0lfs4pk5iCdt8OmF74Shk0PfpfYwgb3ON6MYwo5ekbx3Up3OsqIcnUxA5hT4xYNtQdlfsm9hf9EWtqWY3foaSPlLHUB1J52AkLssEHwJcvux6L4yeSfY+ZUYkK7jPP4rQOGxyRmOSQsQOXB/g9SXsLI5AxnENiD0quvjwihw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L4yjNU8/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P7yEHbhd+EwwLoSXcD+JNYKFqb+mm1kVQ94GBkoux4c=; b=L4yjNU8/rWR7Q+DQUtVXNQp33r
	yh8YJLt0R7vSJ7hFeIBGQfg2GKoFmbwQCSR1me6l2ix5sCRRkaFWLrHN1QbDW4VmloiLH+M/EWAFW
	tZvlQ/gOJebRFlTxs1Bd2JzJE6GYM85flVFTSHDRRHjWNYoesAGIgDSFZXeNfuy3XwP/wOrYuUhaw
	F5/8gfkCVXreBfVYpbQOoRjS2s1GNtx/BclB3RK9qNdJve36mpWSgo/jxdr2pl2cI45j+aJ5f/qyV
	xkmfAAFdVL9pf57hMnvhBYcLWB4x3IoDhV2hyB63Vjtae6PJAl7U2Ta05nx9RJiRWooeZhPWZCXjw
	GkHx/hhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW7Fq-00000001Gym-1VSU;
	Mon, 30 Jun 2025 05:40:34 +0000
Date: Sun, 29 Jun 2025 22:40:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 0/8] btrfs: use fs_holder_ops for btrfs
Message-ID: <aGIjUs7rVy05sQXd@infradead.org>
References: <cover.1751261286.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751261286.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks like this doesn't add the remove_dev method and thus does the
wrong thing when a device underlying a raid configuration gets removed?


