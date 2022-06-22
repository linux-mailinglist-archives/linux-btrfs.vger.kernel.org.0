Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF7554C1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357735AbiFVODD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357862AbiFVODB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 10:03:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DDDF10
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 07:02:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6378F21C09;
        Wed, 22 Jun 2022 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655906573;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nSMa4RZhz/c1t3rVnYTewRmnzamvKgA5fJ7WQisbRAI=;
        b=MMM160LOQyO4vgRzxtuy20KQpuX3c7+owbD593iratYMHSIKBm/mZeWLWH2+nGtc/2w8jw
        Cv9bTkjT3+uHemZPgWytG8ukAmAUDyf/RJ2a6MqPSoo0vKAFL2dGAGYHRwUnrdMRy61Xjj
        Hh5kIxfFHahLiwTnsrSZ6C9FBmFhifk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655906573;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nSMa4RZhz/c1t3rVnYTewRmnzamvKgA5fJ7WQisbRAI=;
        b=aSLZNGtF6JIYnR5+ZdZKrMcn3DWtv1CyBpwZm5z14DomPb08tuu7gUJC0q8dBgy/LNUj1l
        pYSPlT4dHxOOfQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3849813A5D;
        Wed, 22 Jun 2022 14:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GOzIDA0hs2K/RwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Jun 2022 14:02:53 +0000
Date:   Wed, 22 Jun 2022 15:58:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 4/4] btrfs: replace unnecessary goto with direct
 return at cow_file_range()
Message-ID: <20220622135815.GG20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, fdmanana@kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1655791781.git.naohiro.aota@wdc.com>
 <a294ac30ec431016710e8dda1e778e18bfeff9c5.1655791781.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a294ac30ec431016710e8dda1e778e18bfeff9c5.1655791781.git.naohiro.aota@wdc.com>
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

On Tue, Jun 21, 2022 at 03:41:02PM +0900, Naohiro Aota wrote:
> The "goto out;"s in cow_file_range() just results in a simple "return
> ret;" which are not really useful. Replace them with proper direct
> "return"s. It also makes the success path vs failure path stands out.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/inode.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 38d8e6d78e77..b9633b35a35f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1250,7 +1250,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  			 * inline extent or a compressed extent.
>  			 */
>  			unlock_page(locked_page);
> -			goto out;
> +			return 0;

This return is too easy to miss, I'd rather keep it there. This is the
anti-pattern where there are gotos and returns mixed so it's not obvious
what's the flow and breaks reading the function top-down.

>  		} else if (ret < 0) {
>  			goto out_unlock;
>  		}
> @@ -1359,8 +1359,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  		if (ret)
>  			goto out_unlock;
>  	}
> -out:
> -	return ret;
> +	return 0;
>  
>  out_drop_extent_cache:
>  	btrfs_drop_extent_cache(inode, start, start + ram_size - 1, 0);
> @@ -1418,7 +1417,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  					     page_ops);
>  		start += cur_alloc_size;
>  		if (start >= end)
> -			goto out;
> +			return ret;
>  	}
>  
>  	/*
> @@ -1430,7 +1429,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	extent_clear_unlock_delalloc(inode, start, end, locked_page,
>  				     clear_bits | EXTENT_CLEAR_DATA_RESV,
>  				     page_ops);
> -	goto out;
> +	return ret;

These two are in the exit block, so jumping back is indeed worth
cleaning up.

>  }
>  
>  /*
> -- 
> 2.35.1
