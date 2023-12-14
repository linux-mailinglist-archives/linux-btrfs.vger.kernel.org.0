Return-Path: <linux-btrfs+bounces-956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678188135E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 17:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228B2281923
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 16:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD15F1D9;
	Thu, 14 Dec 2023 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VC8O7OZf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D8E8
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 08:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=1faX2j6ztTbgGq3oCx4KsuIdr8SFefn0me4AXBHGi0Q=; b=VC8O7OZfxWg8xU+f6xGfg5EY8v
	WT52HshRTVndM/XZ0ZeOI7nmZi1f2YFgVk2a03IL6L3qEL+BZcnqPc0XAlJau6aZHiGz4tZC2808J
	a+NszLtom/i6r2Kcjys8169sLm5O2wNh92l2A45qqQfYuFKjWuZKY6h8qyBai8XwiipN4MExXYFiK
	wkR8s74hOkidB25RyE9h2bm2y415kAzTt59FpU8//tt3KRYNcV4pYIlGnwi9bgid54E7ep0h0zMtl
	HUCtDjY1JfuVf8M3fSnXHmv/Vf3ulSDpGkrpuHIiVzFQ22XUF7rWUYWvG2T5cjHtTW40SIy8/LrDi
	+0iTkP3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDoL6-008U8B-Ny; Thu, 14 Dec 2023 16:13:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] Convert btrfs defrag to use folios
Date: Thu, 14 Dec 2023 16:13:28 +0000
Message-Id: <20231214161331.2022416-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the folio APIs throughout the defrag process.

v2:
 - Add set_folio_extent_mapped()
 - Rebase to next-20231214

Matthew Wilcox (Oracle) (3):
  btrfs; Add set_folio_extent_mapped()
  btrfs: Convert defrag_prepare_one_page() to use a folio
  btrfs: Use a folio array throughout the defrag process

 fs/btrfs/defrag.c    | 93 ++++++++++++++++++++++----------------------
 fs/btrfs/extent_io.c | 12 ++++--
 fs/btrfs/extent_io.h |  1 +
 3 files changed, 55 insertions(+), 51 deletions(-)

-- 
2.42.0


