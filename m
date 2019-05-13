Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F93A1B685
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfEMMzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 08:55:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:41300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727462AbfEMMzy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 08:55:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9779BAD4F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 12:55:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 96DA1DA95A; Mon, 13 May 2019 14:56:50 +0200 (CEST)
Date:   Mon, 13 May 2019 14:56:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 15/17] btrfs: remove assumption about csum type form
 btrfs_csum_{data,final}()
Message-ID: <20190513125649.GC20156@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-16-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510111547.15310-16-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 01:15:45PM +0200, Johannes Thumshirn wrote:
> btrfs_csum_data() and btrfs_csum_final() still have assumptions on the
> checksums' type and size. Remove it so we can plumb in more types.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/check-integrity.c |  6 ++---
>  fs/btrfs/compression.c     | 13 ++++++-----
>  fs/btrfs/disk-io.c         | 58 +++++++++++++++++++++++++---------------------
>  fs/btrfs/disk-io.h         |  6 ++---
>  fs/btrfs/file-item.c       | 13 +++++------
>  fs/btrfs/inode.c           | 18 +++++++-------
>  fs/btrfs/scrub.c           | 20 +++++++++-------
>  7 files changed, 72 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index 6aad0c3d197f..54c8a549b505 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -1712,7 +1712,6 @@ static int btrfsic_test_for_metadata(struct btrfsic_state *state,
>  	struct btrfs_fs_info *fs_info = state->fs_info;
>  	struct btrfs_header *h;
>  	u8 csum[BTRFS_CSUM_SIZE];
> -	u32 crc = ~(u32)0;
>  	unsigned int i;
>  
>  	if (num_pages * PAGE_SIZE < state->metablock_size)
> @@ -1723,14 +1722,15 @@ static int btrfsic_test_for_metadata(struct btrfsic_state *state,
>  	if (memcmp(h->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE))
>  		return 1;
>  
> +	memset(csum, 0xff, btrfs_super_csum_size(fs_info->super_copy));

This should be added to the csum API as eg. btrfs_csum_init and not
opencoded.
