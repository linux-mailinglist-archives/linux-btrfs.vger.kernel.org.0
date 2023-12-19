Return-Path: <linux-btrfs+bounces-1058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB176818740
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 13:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2091F2497E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 12:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC15171CD;
	Tue, 19 Dec 2023 12:19:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3E168DF
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA05F68C4E; Tue, 19 Dec 2023 13:19:11 +0100 (CET)
Date: Tue, 19 Dec 2023 13:19:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 5/5] btrfs: use the super_block as holder when mounting
 file systems
Message-ID: <20231219121911.GA21959@lst.de>
References: <20231218044933.706042-1-hch@lst.de> <20231218044933.706042-6-hch@lst.de> <04e599b9-5d6d-4ac0-bf74-da9bedfb585f@wdc.com> <20231218150234.GB19041@lst.de> <5dc7ecdd-8bd3-4016-b8da-49ff306bcd3c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc7ecdd-8bd3-4016-b8da-49ff306bcd3c@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 19, 2023 at 01:33:54PM +0800, Gao Xiang wrote:
>>> ext4, f2fs and xfs use the super_block, erofs uses 'sb->s_type' as well
>>> here. Reiser uses the journal and so does jfs. So while these two might
>>> not be the best examples in the world, all other is an exaggeration.
>>
>> As of 6.8-rc every file system but btrfs should be using the superblock.
>
> Just saw this by chance.  Currently EROFS uses 'sb->s_type' to refer
> external binary source devices (blobs) across different mounts.  Since
> these devices are treated readonly so such external sources can be
> shared between mounts as some shared data layer.

Makes sense for that somewhat unusual use case.  Note that this means
you can't really use blk_holder_ops based notifications from the block
driver, but for read-only devices that's not all that important anyway.


