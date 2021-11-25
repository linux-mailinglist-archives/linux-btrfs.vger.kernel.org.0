Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D0045DCE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 16:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbhKYPKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 10:10:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhKYPIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 10:08:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FC7E212BD;
        Thu, 25 Nov 2021 15:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637852743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoVmc707/Ywnm4Ar1x9adlBDKX/kbCT39b4dvTZgSdQ=;
        b=S1hxShFkGqQsbWWxK1l/ksE6SxZlKcbvrcE0/yyD5Dih9VBVorTjldiDyTQ72yZlImkGQg
        uj4jomn9/hNEqRVXyAb2sD5gTSwgaBDKYaDWNvkUhIrulwuxePSeWdNQuU/pAuK9EIKzUy
        XJ9d5bauZi1ttoplZSLQ1sHrFHbBI8I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFA7013C3A;
        Thu, 25 Nov 2021 15:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HhgcMEamn2GcJAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 15:05:42 +0000
Subject: Re: [PATCH 21/25] btrfs: set BTRFS_FS_STATE_NO_CSUMS if we fail to
 load the csum root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636144971.git.josef@toxicpanda.com>
 <4cc384d51e895b2aaaaf302b909f5eec39a06adb.1636144971.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3d3829ba-961e-ab0c-fda4-4ce8a751fdba@suse.com>
Date:   Thu, 25 Nov 2021 17:05:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4cc384d51e895b2aaaaf302b909f5eec39a06adb.1636144971.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.11.21 г. 22:45, Josef Bacik wrote:
> We have a few places where we skip doing csums if we mounted with one of
> the rescue options that ignores bad csum roots.  In the future when
> there are multiple csum roots it'll be costly to check and see if there
> are any missing csum roots, so simply add a flag to indicate the fs
> should skip loading csums in case of errors.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/compression.c | 3 ++-
>  fs/btrfs/ctree.h       | 2 ++
>  fs/btrfs/disk-io.c     | 5 +++++
>  fs/btrfs/file-item.c   | 3 ++-
>  fs/btrfs/inode.c       | 4 ++--
>  5 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 1d071c8d6fff..a76107d6f7f2 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -156,7 +156,8 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
>  	struct compressed_bio *cb = bio->bi_private;
>  	u8 *cb_sum = cb->sums;
>  
> -	if (!fs_info->csum_root || (inode->flags & BTRFS_INODE_NODATASUM))
> +	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
> +	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
>  		return 0;
>  
>  	shash->tfm = fs_info->csum_shash;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index dac5741cb6fa..13bd6fc3901a 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -143,6 +143,8 @@ enum {
>  	BTRFS_FS_STATE_DEV_REPLACING,
>  	/* The btrfs_fs_info created for self-tests */
>  	BTRFS_FS_STATE_DUMMY_FS_INFO,
> +
> +	BTRFS_FS_STATE_NO_CSUMS,
>  };
>  
>  #define BTRFS_BACKREF_REV_MAX		256
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1ada4c96ef71..898b4ff83718 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2475,11 +2475,16 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>  			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
>  				ret = PTR_ERR(root);
>  				goto out;
> +			} else {
> +				set_bit(BTRFS_FS_STATE_NO_CSUMS,
> +					&fs_info->fs_state);
>  			}
>  		} else {
>  			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>  			fs_info->csum_root = root;
>  		}
> +	} else {
> +		set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
>  	}
>  
>  	/*
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 359f3a047360..4904286139bf 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -376,7 +376,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
>  	const unsigned int nblocks = orig_len >> fs_info->sectorsize_bits;
>  	int count = 0;
>  
> -	if (!fs_info->csum_root || (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
> +	if ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
> +	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
>  		return BLK_STS_OK;
>  
>  	/*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9e81fd94ab09..6d14dd2cf36e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2516,7 +2516,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>  	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
>  
>  	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
> -		   !fs_info->csum_root;
> +		test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
>  
>  	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
>  		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
> @@ -3314,7 +3314,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>  	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
>  		return 0;
>  
> -	if (!root->fs_info->csum_root)
> +	if (unlikely(test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)))
>  		return 0;

Should writes be allowed to proceed when FS_STATE_NO_CSUMS is set, which
indicates errors while loading trees?

>  
>  	ASSERT(page_offset(page) <= start &&
> 
