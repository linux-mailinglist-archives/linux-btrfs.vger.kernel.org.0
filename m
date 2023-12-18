Return-Path: <linux-btrfs+bounces-1030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76205817495
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 16:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B9C1C253E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941753D557;
	Mon, 18 Dec 2023 15:02:40 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202753A1C5
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D07D068AFE; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Date: Mon, 18 Dec 2023 16:02:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 5/5] btrfs: use the super_block as holder when mounting
 file systems
Message-ID: <20231218150234.GB19041@lst.de>
References: <20231218044933.706042-1-hch@lst.de> <20231218044933.706042-6-hch@lst.de> <04e599b9-5d6d-4ac0-bf74-da9bedfb585f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e599b9-5d6d-4ac0-bf74-da9bedfb585f@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 12:14:35PM +0000, Johannes Thumshirn wrote:
> Small Nit:
> ext4, f2fs and xfs use the super_block, erofs uses 'sb->s_type' as well 
> here. Reiser uses the journal and so does jfs. So while these two might 
> not be the best examples in the world, all other is an exaggeration.

As of 6.8-rc every file system but btrfs should be using the superblock.

