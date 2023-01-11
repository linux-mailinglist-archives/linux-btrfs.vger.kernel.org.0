Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE776662DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 19:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjAKShi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 13:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjAKShg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 13:37:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6905D13F06
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 10:37:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17C3033E47;
        Wed, 11 Jan 2023 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673462254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nk946uI2YxCJDXj7YUt4zzjJsi0Q0HoNYw4LzoeuUk4=;
        b=c9ms+182SoZlWa+D6VrBlmZyl4AXkT+q2w3ZGqdKgoBRhpozbddUJ1b6nY4AXVyWiTHbUG
        umj5IH8/5UmtEC8s3rIGYBZs3MQ0TjZt8QyrlURS8Tlnf1KfjdZdY92AeQJ2/MuTG2i+pJ
        yU68+8w2UZ1rK3TTILB9OYnrDYJBYK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673462254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nk946uI2YxCJDXj7YUt4zzjJsi0Q0HoNYw4LzoeuUk4=;
        b=cXvQdkVoWz9poDTxf49lttefSD5SB7F5tYhxJukLjhEXEbASZh5tOzXuNNoPKkb/5XdOEY
        vbDcbQcQfzWgeRDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E088E1358A;
        Wed, 11 Jan 2023 18:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HQW4Ne0Bv2PfFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 11 Jan 2023 18:37:33 +0000
Date:   Wed, 11 Jan 2023 19:31:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: enable metadata over-commit for non-ZNS
 setup
Message-ID: <20230111183158.GG11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e0290c4d7af96991ddee4442a1c602cfb3a79ba3.1673330455.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0290c4d7af96991ddee4442a1c602cfb3a79ba3.1673330455.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 10, 2023 at 03:04:32PM +0900, Naohiro Aota wrote:
> The commit 79417d040f4f ("btrfs: zoned: disable metadata overcommit for
> zoned") disabled the metadata over-commit to track active zones properly.
> 
> However, it also introduced a heavy overhead by allocating new metadata
> block groups and/or flushing dirty buffers to release the space
> reservations. Specifically, a workload (write only without any sync
> operations) worsen its performance from 343.77 MB/sec (v5.19) to 182.89
> MB/sec (v6.0).
> 
> The performance is still bad on current misc-next which is 187.95 MB/sec.
> And, with this patch applied, it improves back to 326.70 MB/sec (+73.82%).
> 
> This patch introduces a new fs_info->flag BTRFS_FS_NO_OVERCOMMIT to
> indicate it needs to disable the metadata over-commit. The flag is enabled
> when a device with max active zones limit is loaded into a file-system.
> 
> Fixes: 79417d040f4f ("btrfs: zoned: disable metadata overcommit for zoned")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/fs.h         | 6 ++++++
>  fs/btrfs/space-info.c | 3 ++-
>  fs/btrfs/zoned.c      | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index a749367e5ae2..37b86acfcbcf 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -119,6 +119,12 @@ enum {
>  	/* Indicate that we want to commit the transaction. */
>  	BTRFS_FS_NEED_TRANS_COMMIT,
>  
> +	/*
> +	 * Indicate metadata over-commit is disabled. This is set when active
> +	 * zone tracking is needed.
> +	 */
> +	BTRFS_FS_NO_OVERCOMMIT,
> +
>  #if BITS_PER_LONG == 32
>  	/* Indicate if we have error/warn message printed on 32bit systems */
>  	BTRFS_FS_32BIT_ERROR,
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d28ee4e36f3d..69c09508afb5 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -407,7 +407,8 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
>  		return 0;
>  
>  	used = btrfs_space_info_used(space_info, true);
> -	if (btrfs_is_zoned(fs_info) && (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
> +	if (test_bit(BTRFS_FS_NO_OVERCOMMIT, &fs_info->flags) &&
> +	    (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
>  		avail = 0;
>  	else
>  		avail = calc_available_free_space(fs_info, space_info, flush);
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index bca9feb34c0c..f93215b377b3 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -542,6 +542,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>  		}
>  		atomic_set(&zone_info->active_zones_left,
>  			   max_active_zones - nactive);
> +		set_bit(BTRFS_FS_NO_OVERCOMMIT, &fs_info->flags);

I've added the commit why it's here as well.
