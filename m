Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933725AD43E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiIENry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 09:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiIENrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 09:47:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21058DC4
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 06:47:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D7E420607;
        Mon,  5 Sep 2022 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662385668;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OG8LC9QwE79xLzSFCdtW4irCMoK1sY/Bs1kfJ9AMaL8=;
        b=wxJV4nJ36tIkokmEvzqCRhmLzzAUEq6W2If6Rm283ahsgKXPSY84jBvukdF7ARmed0TCPf
        kCmens60LLMzBwxGGDULKF3ufhiyqHvCb2Zt7v4IA0K4TJnyC9dMN4Qm1kHmG5N0iMya0o
        QUxBrzcsm94sGmTil6vVnFQ9tFOINW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662385668;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OG8LC9QwE79xLzSFCdtW4irCMoK1sY/Bs1kfJ9AMaL8=;
        b=x0GLfVW3oaHPDv63Urjs7E6/XIqtCum1gFIREAcD8UXK8ervsa2DJV9E6p8XsgcUWQo44r
        VKMxFKJghrrIRhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2AFE139C7;
        Mon,  5 Sep 2022 13:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cOv9OQP+FWOtKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Sep 2022 13:47:47 +0000
Date:   Mon, 5 Sep 2022 15:42:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: fix mounting with conventional zones
Message-ID: <20220905134226.GE13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4c82ad00b9241a4c31ac153a3ca9c2c78fbcd551.1662381459.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c82ad00b9241a4c31ac153a3ca9c2c78fbcd551.1662381459.git.johannes.thumshirn@wdc.com>
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

On Mon, Sep 05, 2022 at 05:38:24AM -0700, Johannes Thumshirn wrote:
> Since commit 6a921de58992 ("btrfs: zoned: introduce
> space_info->active_total_bytes"), we're only counting the bytes of a
> block-group on an active zone as usable for metadata writes. But on a SMR
> drive, we don't have active zones and short circuit some of the logic.
> 
> This leads to an error on mount, because we cannot reserve space for
> metadata writes.
> 
> Fix this by also setting the BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE bit in the
> block-group's runtime flag if the zone is a conventional zone.
> 
> Fixes: 6a921de58992 ("btrfs: zoned: introduce space_info->active_total_bytes")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

I'm going to send this with other zoned fixes and there's a minor change
compared to misc-next

> -		ret = calculate_alloc_pointer(cache, &last_alloc);
> -		if (ret || map->num_stripes == num_conventional) {
> -			if (!ret)
> -				cache->alloc_offset = last_alloc;
> -			else
> -				btrfs_err(fs_info,
> -			"zoned: failed to determine allocation offset of bg %llu",
> -					  cache->start);
> +		} else if (map->num_stripes == num_conventional) {
> +			cache->alloc_offset = last_alloc;
> +			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> +				&cache->runtime_flags);

Changed to

			cache->zone_is_active = 1;

>  			goto out;
>  		}
>  	}
> @@ -1538,10 +1532,17 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>  		ret = -EIO;
>  	}
>  
> -	if (!ret)
> +	if (!ret) {
>  		cache->meta_write_pointer = cache->alloc_offset + cache->start;
> -
> -	if (ret) {
> +		if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,

Similar here, if (cache->zone_is_active).

> +			     &cache->runtime_flags)) {
> +			btrfs_get_block_group(cache);
> +			spin_lock(&fs_info->zone_active_bgs_lock);
> +			list_add_tail(&cache->active_bg_list,
> +				      &fs_info->zone_active_bgs);
> +			spin_unlock(&fs_info->zone_active_bgs_lock);
> +		}
> +	} else {
