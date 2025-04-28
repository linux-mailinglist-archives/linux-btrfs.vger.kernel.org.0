Return-Path: <linux-btrfs+bounces-13450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A82CA9E582
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 02:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C5517230B
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 00:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808CC78F51;
	Mon, 28 Apr 2025 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WDvuS+po"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65E1E871;
	Mon, 28 Apr 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745800736; cv=none; b=D5uI50wtGmU6rpXzszI5G3tzXu7UBPJLW4aFer8Owq4H1AobwUJM0JPqiowXmRU0bw19nKSSf/Rd1Fhg8RUwu+E+pQb8f9QqMqwlYoFZchyxcstw5qAKYwLCqkGWFdIv/BVioG+dByQBPPUpyXkcX+kYqLE69GKN8jrLYEJ+f+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745800736; c=relaxed/simple;
	bh=GMCelmTJOEDjiErKUudFvTj7l96E7BnjFXg4cCquDM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcTJx/vHHkoSnr14/42FrvPx/utVd9pWWPyKslChSJbQosmSI2RRL/ToumT4JVRjjKZhMsNShHBTNtd7Tg8jUb98p5zOXpqdoGFM9RqY2QSeSIIt95gIZ48t2B1+Fn0qWyYckzO8ioosP5gcsirw6vxd9yh4THFRXhIKPA6ShJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WDvuS+po; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5rLvH8pJhYps2+lWBXdf1cfAWXXjRrV8V0mx0pzJnLY=; b=WDvuS+poskjYdA+emKUrqk9RL7
	JlB20k2foudKEG3kZdUh6hvRd9nIQtr6bV6GH13uqVPYtBNAd07hzjP465l6Y6xqaPUUZs0t0go9K
	xzERm9xzIraqI/nw3B968Tcek/l6jGnvR5e5k9vY68FIZWPOVrylndIOddHRFKmlS7DCE185FYUar
	FULkaZuctOHJIroy7avOZiS74255Zd28t6OyAhIqUZXlgRmj4PjlF6xzAn/IQk5CwOx89PHATf7kY
	1m+gkpPvzip8leAoi7zETgJ9gzUyzrwdBCpweOV1lkuRwrayH5vl1hkBnb6Ty1uFFcHnDV6ldbylL
	i9fbwYZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9CW4-00000004fvu-0YyB;
	Mon, 28 Apr 2025 00:38:36 +0000
Date: Mon, 28 Apr 2025 01:38:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/6] btrfs: drop usage of folio_index
Message-ID: <aA7OC1d0L1lgZ557@casper.infradead.org>
References: <20250427185908.90450-1-ryncsn@gmail.com>
 <20250427185908.90450-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427185908.90450-3-ryncsn@gmail.com>

On Mon, Apr 28, 2025 at 02:59:04AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> folio_index is only needed for mixed usage of page cache and swap
> cache, for pure page cache usage, the caller can just use
> folio->index instead.
> 
> It can't be a swap cache folio here.  Swap mapping may only call into fs
> through `swap_rw` and that is not supported for btrfs.  So just drop it
> and use folio->index instead.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

