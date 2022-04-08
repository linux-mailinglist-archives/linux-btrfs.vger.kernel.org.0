Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3B44F9DC4
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 21:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiDHTvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 15:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiDHTvh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 15:51:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875821C115
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 12:49:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 41FF81F862;
        Fri,  8 Apr 2022 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649447372;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MFQf+oKIGkR22HBji5qg5AbNiC1iv03V+JdhYZ17WKY=;
        b=u7K/C8XHX8jJ5yU8yTpQdtFKRuThOxzkyB8LUkvWsb9o8Ho+k+y66Uf3MKQi6/btNBg+ON
        1V88gBXGqM4DutWnfOsppVmp9lfzdVh0XbiJn+OcQqhuj2XKP5wwx6B4zxhsPqrZJvuZYx
        iYdQOA0Yf+x611kF/kcXWYfx+srpXfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649447372;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MFQf+oKIGkR22HBji5qg5AbNiC1iv03V+JdhYZ17WKY=;
        b=rxCx2bFF0q65BQ51VujAiPLpuGgXZZRnCRjt6W4aZdaTT8jOHJqYICrXM+udl52+xPym4a
        mNJj2yBSQdKLjNDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0B10CA3B82;
        Fri,  8 Apr 2022 19:49:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28B0ADA832; Fri,  8 Apr 2022 21:45:28 +0200 (CEST)
Date:   Fri, 8 Apr 2022 21:45:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs-progs: zoned: export sb_zone_number() and
 related constants
Message-ID: <20220408194528.GC15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220406014313.993961-1-naohiro.aota@wdc.com>
 <20220406014313.993961-2-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406014313.993961-2-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06, 2022 at 10:43:10AM +0900, Naohiro Aota wrote:
> Move sb_zone_number() and related constants from zoned.c to the
> corresponding header for later use.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  kernel-shared/zoned.c | 33 ---------------------------------
>  kernel-shared/zoned.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index 2a11a1d723aa..396b74f0d906 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -33,20 +33,6 @@
>  /* Pseudo write pointer value for conventional zone */
>  #define WP_CONVENTIONAL			((u64)-2)
>  
> -/*
> - * Location of the first zone of superblock logging zone pairs.
> - *
> - * - primary superblock:    0B (zone 0)
> - * - first copy:          512G (zone starting at that offset)
> - * - second copy:           4T (zone starting at that offset)
> - */
> -#define BTRFS_SB_LOG_PRIMARY_OFFSET	(0ULL)
> -#define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
> -#define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
> -
> -#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
> -#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
> -
>  #define EMULATED_ZONE_SIZE		SZ_256M
>  
>  static int btrfs_get_dev_zone_info(struct btrfs_device *device);
> @@ -220,25 +206,6 @@ static int sb_write_pointer(int fd, struct blk_zone *zones, u64 *wp_ret)
>  	return 0;
>  }
>  
> -/*
> - * Get the first zone number of the superblock mirror
> - */
> -static inline u32 sb_zone_number(int shift, int mirror)
> -{
> -	u64 zone = 0;
> -
> -	ASSERT(0 <= mirror && mirror < BTRFS_SUPER_MIRROR_MAX);
> -	switch (mirror) {
> -	case 0: zone = 0; break;
> -	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
> -	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
> -	}
> -
> -	ASSERT(zone <= U32_MAX);
> -
> -	return (u32)zone;
> -}
> -
>  int btrfs_reset_dev_zone(int fd, struct blk_zone *zone)
>  {
>  	struct blk_zone_range range;
> diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
> index 75327610e537..cc0d6b6f166d 100644
> --- a/kernel-shared/zoned.h
> +++ b/kernel-shared/zoned.h
> @@ -36,6 +36,20 @@ struct blk_zone {
>  /* Number of superblock log zones */
>  #define BTRFS_NR_SB_LOG_ZONES		2
>  
> +/*
> + * Location of the first zone of superblock logging zone pairs.
> + *
> + * - primary superblock:    0B (zone 0)
> + * - first copy:          512G (zone starting at that offset)
> + * - second copy:           4T (zone starting at that offset)
> + */
> +#define BTRFS_SB_LOG_PRIMARY_OFFSET	(0ULL)
> +#define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
> +#define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
> +
> +#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
> +#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
> +
>  /*
>   * Zoned block device models
>   */
> @@ -206,6 +220,25 @@ static inline bool zoned_profile_supported(u64 map_type)
>  
>  #endif /* BTRFS_ZONED */
>  
> +/*
> + * Get the first zone number of the superblock mirror
> + */
> +static inline u32 sb_zone_number(int shift, int mirror)
> +{

This does not need to be static inline but not a big deal.

> +	u64 zone = 0;
> +
> +	ASSERT(0 <= mirror && mirror < BTRFS_SUPER_MIRROR_MAX);
> +	switch (mirror) {
> +	case 0: zone = 0; break;
> +	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
> +	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
> +	}
> +
> +	ASSERT(zone <= U32_MAX);
> +
> +	return (u32)zone;
> +}
> +
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
>  {
>  	return zone_is_sequential(device->zone_info, pos);
> -- 
> 2.35.1
