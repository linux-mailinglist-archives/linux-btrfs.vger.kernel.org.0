Return-Path: <linux-btrfs+bounces-10219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573B79EC4A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 07:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A053188B3EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 06:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A001C1F2F;
	Wed, 11 Dec 2024 06:20:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562642451C0
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898043; cv=none; b=V7I2U7Ab1bLb+tuU4Lu+1NZa+LWUmKj9ShYfp6Dh+qsGQjawgny6ZDxNkmLN21kPI0vXfD8srMfsYaIMrcC5X4zr737XGvpYV+3GLYU95wRpevjVa4rgFA/0F9cGs7ivma4Yc+PMb+w4rU0Y2qz666uJ9aW78bE86udsIcZVqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898043; c=relaxed/simple;
	bh=I9XYYG2fonDiv76y+Pz4k3l4+JKcui/I+wtPWKFEDqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1T+GmdVqhH3BLEUkAwLhuZD7ar9VQs5QmYxQhxKxZBGOj14ABpxURWcGml0oZrG/e/LPQWL3iouOkP0AE9jkyEhGkZEdLrbS5t6tAXq/TNbtQ1wBE3hvEJj8/CzhRM/bcxAa5rLXnelsGoCWiiAK0YjF9IJOax66TuH6yENRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB36468D12; Wed, 11 Dec 2024 07:20:37 +0100 (CET)
Date: Wed, 11 Dec 2024 07:20:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: zoned: calculate max_zone_append_size properly
 on non-zoned setup
Message-ID: <20241211062037.GB12285@lst.de>
References: <9c00c066e9529f1a6439c1c8895a8f0d010a07e5.1733887702.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c00c066e9529f1a6439c1c8895a8f0d010a07e5.1733887702.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 11, 2024 at 12:36:00PM +0900, Naohiro Aota wrote:
> Since commit 559218d43ec9 ("block: pre-calculate max_zone_append_sectors"),
> queue_limits's max_zone_append_sectors is default to be 0 and it is only
> updated when there is a zoned device. So, we have
> lim->max_zone_append_sectors = 0 when there is no zoned device in the
> filesystem.

Which makes sense as zoned append isn't used on conventional devices.

> 
> That leads to fs_info->max_zone_append_size and fs_info->max_extent_size to
> be 0, which causes several errors. One example is the divide error as

But max_extent_size == 0 is a real problem.  Can you try the patch below?

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 11ed523e528e..27f4472fb559 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -748,8 +748,9 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		     (u64)lim->max_segments << PAGE_SHIFT),
 		fs_info->sectorsize);
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
-	if (fs_info->max_zone_append_size < fs_info->max_extent_size)
-		fs_info->max_extent_size = fs_info->max_zone_append_size;
+
+	fs_info->max_extent_size = min_not_zero(fs_info->max_extent_size,
+			fs_info->max_zone_append_size);
 
 	/*
 	 * Check mount options here, because we might change fs_info->zoned

