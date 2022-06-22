Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE622555151
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358897AbiFVQ2O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 12:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350478AbiFVQ2M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 12:28:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD970E86
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 09:28:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7DA6F21B63;
        Wed, 22 Jun 2022 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655915289;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbntdjJOb2Hm9QLweaAQKdYN/pXH9lmW2cJeOxQzoX4=;
        b=F6QJXAcb5CO7RutX/ldgeDYBqmG7j1OdyFi2osfMUrhmb/YdSe6ucxalmFuqKy0dhs46g2
        hy/O59Ra/7mkNTihgQUCTZQJxxY/b6e8KV4v0IvtO6SLaGLh5jEWqmZAJGlyuT3+i4VoiM
        iqfUvmqxhPGNATvcfBHSNM/920eFDpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655915289;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbntdjJOb2Hm9QLweaAQKdYN/pXH9lmW2cJeOxQzoX4=;
        b=mzfg7RPbXwRuPYEJ/HLw67ELA3427msyLV2YiHPA5ynHYcOFDZsRFB9x25i15DemVHXekh
        twsFyYr6X04LttAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48BC713A5D;
        Wed, 22 Jun 2022 16:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iXe2EBlDs2I9EwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Jun 2022 16:28:09 +0000
Date:   Wed, 22 Jun 2022 18:23:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: output mirror number for bad metadata
Message-ID: <20220622162331.GL20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <ae3c7264a3aefe55c64e3c6a0426289800023742.1655646447.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3c7264a3aefe55c64e3c6a0426289800023742.1655646447.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 19, 2022 at 09:47:56PM +0800, Qu Wenruo wrote:
> When handling a real world transid mismatch image, it's hard to know
> which copy is corrupted, as the error messages just look like this:
> 
> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
> 
> We don't even know if the retry is caused by btrfs or the VFS retry.
> 
> To make things a little easier to read, this patch will add mirror
> number for all related tree block read errors.
> 
> So the above messages would look like this:
> 
>  BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 1 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>  BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 2 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>  BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 1 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>  BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 2 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/disk-io.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..506d48b5fd7e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -220,8 +220,8 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
>  		goto out;
>  	}
>  	btrfs_err_rl(eb->fs_info,
> -		"parent transid verify failed on %llu wanted %llu found %llu",
> -			eb->start,
> +	"parent transid verify failed on %llu mirror %u wanted %llu found %llu",

I've added "logical" in front of all %llu that refer to logical block address.


> +			eb->start, eb->read_mirror,
>  			parent_transid, btrfs_header_generation(eb));
>  	ret = 1;
>  	clear_extent_buffer_uptodate(eb);
> @@ -551,21 +551,22 @@ static int validate_extent_buffer(struct extent_buffer *eb)
>  
>  	found_start = btrfs_header_bytenr(eb);
>  	if (found_start != eb->start) {
> -		btrfs_err_rl(fs_info, "bad tree block start, want %llu have %llu",
> -			     eb->start, found_start);
> +		btrfs_err_rl(fs_info,
> +			"bad tree block start, mirror %u want %llu have %llu",
> +			     eb->read_mirror, eb->start, found_start);
>  		ret = -EIO;
>  		goto out;
>  	}
>  	if (check_tree_block_fsid(eb)) {
> -		btrfs_err_rl(fs_info, "bad fsid on block %llu",
> -			     eb->start);
> +		btrfs_err_rl(fs_info, "bad fsid on block %llu mirror %u",

Though this says 'block' it's not in fact block address (ie. a multiple
of a block size) but the logical address.

> +			     eb->start, eb->read_mirror);
>  		ret = -EIO;
>  		goto out;
>  	}
>  	found_level = btrfs_header_level(eb);
>  	if (found_level >= BTRFS_MAX_LEVEL) {
> -		btrfs_err(fs_info, "bad tree block level %d on %llu",
> -			  (int)btrfs_header_level(eb), eb->start);
> +		btrfs_err(fs_info, "bad tree block mirror %u level %d on %llu",
> +			  eb->read_mirror, btrfs_header_level(eb), eb->start);
>  		ret = -EIO;
>  		goto out;
>  	}
> @@ -576,8 +577,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
>  
>  	if (memcmp(result, header_csum, csum_size) != 0) {
>  		btrfs_warn_rl(fs_info,
> -	"checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT " level %d",
> -			      eb->start,
> +	"checksum verify failed on %llu mirror %u wanted " CSUM_FMT " found " CSUM_FMT " level %d",
> +			      eb->start, eb->read_mirror,
>  			      CSUM_FMT_VALUE(csum_size, header_csum),
>  			      CSUM_FMT_VALUE(csum_size, result),
>  			      btrfs_header_level(eb));
> @@ -602,8 +603,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
>  		set_extent_buffer_uptodate(eb);
>  	else
>  		btrfs_err(fs_info,
> -			  "block=%llu read time tree block corruption detected",
> -			  eb->start);
> +		"block=%llu mirror %u read time tree block corruption detected",
> +			  eb->start, eb->read_mirror);
>  out:
>  	return ret;
>  }
> -- 
> 2.36.1
