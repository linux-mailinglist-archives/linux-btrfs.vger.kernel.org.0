Return-Path: <linux-btrfs+bounces-13836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606ABAAFD68
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 16:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883AB1C255F6
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B326FA42;
	Thu,  8 May 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mew+Hpya"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044626FA52
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715312; cv=none; b=oQ974IFOn9yimHgOZFi1uHzjx7Jxy7IQC/VjU8rfBS1X0d9McNxApluP1h6q5WUEnW8mHKHMXYclBYjSORpC0JYlgev/8nUKO6HnzrC836I3Ss5bmFUa4Fs7Ggr1r3wAkKPeUWS8tuQW2NcMy0bl+8JApVhYvjhbhOHjpjl5Hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715312; c=relaxed/simple;
	bh=z+G9Ba6FZ81liiQ5TCsKzbfblwbjdndnIIjzmHTNLMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m96L2wddhFIBvqic2mlZrAHSXUpM5KtISxA2CxD2LS3aa5LE9JQPrpdSjpdpyft0OtKZH32dpqmHLF7qpPxFRQsw0fKuF/qHzvb/2Btl/Xs9S1gHmD9VqXdi1CevBRnW1d+bx8f46L/9p38qlUj69ypTS7sA9ciwJ7Y1hoxYPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mew+Hpya; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xksPQr4k+dyXybCdk1b91MfhJYNDr0Joqg+ZhGH0NWI=; b=mew+HpyaaJRhJwh0B3KtXSiI+8
	5v05FtzeoiWFzjgRwpQH7/XwVPJElTXTD7nP1bl5HEZnjEPbhRGz4AWhxMeP+a2jx9Cp9JwQqm1PJ
	ggb0EovbqxWvwVI/puU42TbOTUChW8Amr2IW1zudZGujuvTdYlimf8j4dNKqvQqpnHdzHV1vskysh
	zR2mq5bNDh4csI7571fGYVivdbLI/dS1AUu229DCHhnQl313dS+0AgEGgBU4uOzTlwoXlqe2NMNGC
	hM4mCmLtMyLwEtS9Bp10j4kSvlxZOBSno0+zPbfV7E2m9Gu1ZrDgZBb03H/j1q6k/odM/t5s8IPIi
	od8AcBlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD2Ra-00000000y2p-0HYt;
	Thu, 08 May 2025 14:41:50 +0000
Date: Thu, 8 May 2025 07:41:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>,
	linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-mm@kvack.org
Subject: Re: What is the point of the wbc->for_kupdate check in
 btree_writepages
Message-ID: <aBzCrkI7Jfisdnaw@infradead.org>
References: <aBxJ8uBi5Cgz-CPu@infradead.org>
 <2d1a8e78-b57a-4726-a566-4d916a36be8f@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1a8e78-b57a-4726-a566-4d916a36be8f@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 08, 2025 at 10:33:24AM -0400, Chris Mason wrote:
> btrfs can keep changing dirty tree blocks in memory, but once we write
> them, we have to recow.  Between transaction writeback kicking in every
> 30 seconds and us calling balance_dirty_pages on the btree inode,
> kupdate was doing more harm than good (back in 2007).

I totally understand why you'd want to avoid background writeback.  I
just don't understand why it singles out for_kupdate.

> Is the goal to get rid of for_kupdate?

At least getting rid of exposing it to file systems, yes.

> I wonder if we can just flag the
> btree inode to exclude from kupdate, or keep it off whatever list
> kupdate cares about etc.

Not having the VM do writeback on metadata but running it from a fs
LRU was a huge win in XFS.  I'm not sure we have interfaces that keep
data in the pagecache but never do any background writeback.  But
if you are fine with treating all background writeback equal that
would be exactly where I'd like to go to.


