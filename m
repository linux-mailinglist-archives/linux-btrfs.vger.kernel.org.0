Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17F742308
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjF2JPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 05:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF2JPJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 05:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18502210B
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 02:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FB2D6150B
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 09:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7FEC433C8;
        Thu, 29 Jun 2023 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688030107;
        bh=Zue6xsSO9rTKQpwOt50oLue/OAbgKDNpWKiXXBDv/IE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=sUQS6245zIWqDGqjLCKlXMMv6R3bNwhWZeTzH16f9nk0aTiXmkDL+HIbSEJLMXLRL
         aTmeaNfD2k1eUbv7aY9Lv9DW5RkADfgw5UWfjehH3tykGm1KKIZL42w/k0uyKYKfvF
         29GzJ164xG9klvAVZ0mgAHZ5uX1x5WCyx84Ue807ND8QQh0TlLX+2noHVTr+QROh3W
         5rh4u4MlAXCxMnguztd6Lpw73/Op2NmbJcpvf0PkNAB5foiFWVKJV3GfODbZLiDve+
         wOTZ1fGz/4VzUckMfE3LNsca1e+jezVWVAhgEOV8gT5itDhRETGs6buSMLGeWcIfIQ
         mgMxw47HcEJvg==
Message-ID: <e803b649-299b-05b6-6528-06437548e974@kernel.org>
Date:   Thu, 29 Jun 2023 18:15:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] btrfs: zoned: do not enable async discard
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <e22f5f69d881de1ec0e381f1be6bfe61b822c064.1688027756.git.naohiro.aota@wdc.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e22f5f69d881de1ec0e381f1be6bfe61b822c064.1688027756.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/29/23 17:37, Naohiro Aota wrote:
> The zoned mode need to reset a zone before using it. We rely on btrfs's
> original discard functionality (discarding unused block group range) to do
> the resetting.
> 
> While the commit 63a7cb130718 ("btrfs: auto enable discard=async when
> possible") made the discard done in an async manner, a zoned reset do not
> need to be async, as it is fast enough.
> 
> Even worth, delaying zone rests prevents using those zones again. So, let's
> disable async discard on the zoned mode.
> 
> Fixes: 63a7cb130718 ("btrfs: auto enable discard=async when possible")
> CC: stable@vger.kernel.org # 6.3+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/disk-io.c | 7 ++++++-
>  fs/btrfs/zoned.c   | 5 +++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7513388b0567..9b9914e5f03d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3438,11 +3438,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	 * For devices supporting discard turn on discard=async automatically,
>  	 * unless it's already set or disabled. This could be turned off by
>  	 * nodiscard for the same mount.
> +	 *
> +	 * The zoned mode piggy backs on the discard functionality for
> +	 * resetting a zone. There is no reason to delay the zone reset as it is
> +	 * fast enough. So, do not enable async discard for zoned mode.
>  	 */
>  	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
>  	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
>  	      btrfs_test_opt(fs_info, NODISCARD)) &&
> -	    fs_info->fs_devices->discardable) {
> +	    fs_info->fs_devices->discardable &&
> +	    !btrfs_is_zoned(fs_info)) {
>  		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
>  				   "auto enabling async discard");
>  	}
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 85b8b332add9..65d17306c2d4 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -805,6 +805,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
>  		return -EINVAL;
>  	}
>  
> +	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
> +		btrfs_warn(info, "zoned: disabling async discard as it is not supported");

The "not supported" mention here kind of imply that we are not finished with
this support yet. So may be a simple: "zoned: ignoring async discard" would
suffice ?

Otherwise, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +		btrfs_clear_opt(info->mount_opt, DISCARD_ASYNC);
> +	}
> +
>  	return 0;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

