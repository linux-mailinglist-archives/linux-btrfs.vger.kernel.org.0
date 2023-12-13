Return-Path: <linux-btrfs+bounces-901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F7810CCF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5DE5B20C6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD91EB49;
	Wed, 13 Dec 2023 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0N7VFaF+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A97AC;
	Wed, 13 Dec 2023 00:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qz0UdSoKEx8DKiO3JaKHyhacTW1PxqeO0PZEU64Vnco=; b=0N7VFaF+09920+5bY2hyGOj5cw
	6z9ZbQDHBaGCrSSS07b9CV20jXslGu76PsFQzZDLbWIWrsecXY61B82L02FQbq376aKZjGrZFAavS
	RpLIHp3FQELsUxkQqlSt7AW6PrC0LQR5Di0w9uPe4wbVEt4iLnk6IOZFztHHctA/1zi+sFJcB9x9C
	Q/KwtgwzGLn7muXC2BqSjcXCz+YkHh3kc/3fTpMeRP9cKb4dtKSVaU3/4HhVDzVD2SpzGYOo3xky+
	Phr+9nhlzDvYG2oJn48gG9oQaRZ4ANLPklhj7LcA0+gKyrH9u6b3YusJIOmPt3WsbbzVvdPFAt182
	FOa1pqIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKzJ-00E5YK-2i;
	Wed, 13 Dec 2023 08:53:05 +0000
Date: Wed, 13 Dec 2023 00:53:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] btrfs: factor out block mapping for RAID5/6
Message-ID: <ZXlw8Ux/HJBSKl1M@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-8-b2d954d9a55b@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-8-b2d954d9a55b@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static void map_blocks_for_raid56(struct btrfs_chunk_map *map,
> +				  enum btrfs_map_op op,
> +				  struct btrfs_io_geometry *io_geom,
> +				  u64 logical, u64 *length)
> +{
> +	int data_stripes = nr_data_stripes(map);
> +
> +	if (op != BTRFS_MAP_READ || io_geom->mirror_num > 1) {

Any reason to not have separate read/write helpers here given that
they don't really share anything?


