Return-Path: <linux-btrfs+bounces-899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A5810CC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B48B20D39
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECFD1EB47;
	Wed, 13 Dec 2023 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z+/71fcK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3650B7;
	Wed, 13 Dec 2023 00:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VsEFfbXYkoEiyCW2AjPqmE6JGQ/NnRAbJd6BX+OhLPk=; b=z+/71fcKw5r2E+N+ihmNs5HSEc
	04Pl7NkpysRUp4baIDPUaVi46NzGq8+EUuO4jQ5xsBtRzwgQ5+wN1kIMOG/8BBA46Q28I4azn8oou
	RoftrV8TAlcJ7kb9aGOOFjVaZnUKo0n0lp2ib4acoa4gXXXEdWBj56EKW/rlLjnCiSMAHPoX0qtM2
	HlaErUGqF6MvNpFr9+m5JA3INKoIwPc7vWzeLrIhLe6kWQdWw6LSM9T3HYszgevThamw2oZTSjThu
	EoxIE0gZeY9Z6pCLzx+h7HnJr9jSGfNK7WNvvNfkiXKz/YttEfUQ5GRJIgHGIBGqxG2nYhxeOuw0v
	O9ohzDvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKxC-00E5Ke-1f;
	Wed, 13 Dec 2023 08:50:54 +0000
Date: Wed, 13 Dec 2023 00:50:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] btrfs: factor out block-mapping for RAID0
Message-ID: <ZXlwbjflk9EwEE7A@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-3-b2d954d9a55b@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-3-b2d954d9a55b@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static void map_blocks_for_raid0(struct btrfs_chunk_map *map,

I'd skip the _for here as it is a bit redundant.

> +				 enum btrfs_map_op op,

Looking at all the patches: shouldn't the op also go into the
btrfs_io_geometry structure?


