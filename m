Return-Path: <linux-btrfs+bounces-900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0106E810CC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED88B1C20AA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6DB1EB47;
	Wed, 13 Dec 2023 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DRNZLiD1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD8AC;
	Wed, 13 Dec 2023 00:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a3hyHU444stCFxhhDZa/P+PmoLtQc1fA3WonZdHSww0=; b=DRNZLiD1QGXGKtdC6Z8g7cnvH6
	N9xt/UB36lTsK0ABOr/rbBt2Gog0TlyXX3URhEJ7aIoR3V0mjts83wcD4pewINVrmwxHZW1v8eas7
	h0Vb8X2novBlmvvJLgz5s27WbP2MhEjO1uH7SJFbNKOYokc/Yp1CSpvvviMAO1OM9remZVZOn96/m
	Eq0prHkqZOsSe6J1usFzrCrYmnLqDM94MXwc6TARLukzBijMa2Bqk99koujWxM8NIqrCseJupwe+m
	PzVsCr6PwEiUDGHnRg2vISmCOK4WuQJs3b67ObYBUWPPWV/Qbjos5TBddmokkYretenrvE0cWPSUI
	xxwYsaXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKyQ-00E5QW-1D;
	Wed, 13 Dec 2023 08:52:10 +0000
Date: Wed, 13 Dec 2023 00:52:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] btrfs: factor out RAID1 block mapping
Message-ID: <ZXlwurmwHg+oWlv4@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-4-b2d954d9a55b@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-4-b2d954d9a55b@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 12, 2023 at 04:38:02AM -0800, Johannes Thumshirn wrote:
> Now that we have a container for the I/O geometry that has all the needed
> information for the block mappings of RAID1, factor out a helper calculating
> this information.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/volumes.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a5d85a77da25..f6f1e783b3c1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6372,6 +6372,25 @@ static void map_blocks_for_raid0(struct btrfs_chunk_map *map,
>  		io_geom->mirror_num = 1;
>  }
>  
> +static void map_blocks_for_raid1(struct btrfs_fs_info *fs_info,
> +				 struct btrfs_chunk_map *map,
> +				 enum btrfs_map_op op,
> +				 struct btrfs_io_geometry *io_geom, int replace)

replace looks like a bool to me.  Also elsewhere in the code it is
called dev_replace_is_ongoing.  Even if that name is a little clumsy
it's nice to not switch forth and back between names in a call chain.


