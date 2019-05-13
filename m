Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166881B68B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfEMM7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 08:59:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:41810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728786AbfEMM7H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 08:59:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38082AD4F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 12:59:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36647DAC58; Mon, 13 May 2019 15:00:03 +0200 (CEST)
Date:   Mon, 13 May 2019 15:00:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Message-ID: <20190513130003.GD20156@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-15-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510111547.15310-15-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 01:15:44PM +0200, Johannes Thumshirn wrote:
> Currently btrfs_csum_data() relied on the crc32c() wrapper around the crypto
> framework for calculating the CRCs.
> 
> As we have our own crypto_shash structure in the fs_info now, we can
> directly call into the crypto framework without going trough the wrapper.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/disk-io.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index fb0b06b7b9f6..0c9ac7b45ce8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -253,12 +253,36 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
>  u32 btrfs_csum_data(struct btrfs_fs_info *fs_info, const char *data,
>  		    u32 seed, size_t len)
>  {
> -	return crc32c(seed, data, len);
> +	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> +	u32 *ctx = (u32 *)shash_desc_ctx(shash);
> +	u32 retval;
> +	int err;
> +
> +	shash->tfm = fs_info->csum_shash;
> +	shash->flags = 0;
> +	*ctx = seed;
> +
> +	err = crypto_shash_update(shash, data, len);
> +	ASSERT(err);
> +
> +	retval = *ctx;
> +	barrier_data(ctx);
> +
> +	return retval;

I unfortunatelly had a dive into the crypto API calls and since then I'm
biased against using it (too much indirection and extra memory
references). So my idea of this function is:

switch (fs_info->csum_type) {
case CRC32:
	... calculate crc32c;
	break;
case SHA256:
	... calculate sha56;
	break;
}

with direct calls to the hash primitives rather than thravelling trough
the shash.
