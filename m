Return-Path: <linux-btrfs+bounces-2332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3AD851877
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 16:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B896A285837
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719FD3CF60;
	Mon, 12 Feb 2024 15:52:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679653CF45
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753158; cv=none; b=liTPp5i2IXe9iZ9lT5S3Gyv7GaNTI4+pj2DCYcGxD/7PBcq415EsPFdhi+oQubtu7o0GQMhKKY3cFbzARvPCyumlAQgroVPLnuU0KR6Hx9e/WCAGUrToSJJWctzR/8er/R9RRfi6atHw/G3N7m3tsqMNGAM63alPpSPj7yHATNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753158; c=relaxed/simple;
	bh=YQJrZTWHPnn0HgbHIy//Z3pdxMfjdxH45HOSokaNLUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2ic08MnCfQpOveXioj2eXMN6qWXfmfADa+ZNVwMvCfUDzsQcj8CWvl/4yr2cxHTE8YA8iYKpTdm3yX6jkO5B/qEuy12a2Hfx8ZUtuwAZjAsOd3sGnjCYEBnlgHSf20esE9zcmDNINw/NnWpi8kWEhX3gNipkC95bdPJHL+qQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DF0A227A87; Mon, 12 Feb 2024 16:52:31 +0100 (CET)
Date: Mon, 12 Feb 2024 16:52:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/16] btrfs: remove non-standard extent handling in
 __extent_writepage_io
Message-ID: <20240212155230.GA29259@lst.de>
References: <20230531060505.468704-1-hch@lst.de> <20230531060505.468704-11-hch@lst.de> <91eda445-e58c-4fab-ae49-a10951edfa8d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91eda445-e58c-4fab-ae49-a10951edfa8d@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Feb 10, 2024 at 08:09:47PM +1030, Qu Wenruo wrote:
>> @@ -1419,10 +1418,14 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>>   		ASSERT(cur < end);
>>   		ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
>>   		ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
>> +
>>   		block_start = em->block_start;
>> -		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
>>   		disk_bytenr = em->block_start + extent_offset;
>>
>> +		ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
>> +		ASSERT(block_start != EXTENT_MAP_HOLE);
>
> For subpage cases, __extent_writepage_io() can be triggered to write
> only a subset of the page, from extent_write_locked_range().

Yes.

> In that case, if we have submitted the target range, since our @len is
> to the end of the page, we can hit a hole.
>
> In that case, this ASSERT() would be triggered.
> And even worse, if CONFIG_BTRFS_ASSERT() is not enabled, we can do wrong
> writeback using the wrong disk_bytenr.
>
> So at least we need to skip the hole ranges for subpage.
> And thankfully the remaining two cases are impossible for subpage.

The patch below reinstates the hole handling.  I don't have a system
that tests the btrfs subpage code right now, so this is untested:

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cfd2967f04a293..a106036641104c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1388,7 +1388,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		disk_bytenr = em->block_start + extent_offset;
 
 		ASSERT(!extent_map_is_compressed(em));
-		ASSERT(block_start != EXTENT_MAP_HOLE);
 		ASSERT(block_start != EXTENT_MAP_INLINE);
 
 		/*
@@ -1399,6 +1398,15 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		free_extent_map(em);
 		em = NULL;
 
+		if (block_start == EXTENT_MAP_HOLE) {
+			btrfs_mark_ordered_io_finished(inode, page, cur, iosize,
+						       true);
+			btrfs_folio_clear_dirty(fs_info, page_folio(page), cur,
+						iosize);
+			cur += iosize;
+			continue;
+		}
+
 		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
 		if (!PageWriteback(page)) {
 			btrfs_err(inode->root->fs_info,

