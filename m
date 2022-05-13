Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5149C526982
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383385AbiEMSmz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 14:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348518AbiEMSmx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 14:42:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8CC3C493
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 11:42:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 664631F8F4;
        Fri, 13 May 2022 18:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652467370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQB7gDTCx+yiCQjR0WjOxgc8ovkU38PmP6zpfKpK+g8=;
        b=ct1AnIP7ke7t/lARBwBe6ln7V1M1jyzkJrXofNg00pqkcHMG4uQTt9G0Qb8cPH7cW7YAut
        0mYelNmpX+YjCeNYMi2/Oi/9Wtld390oZDz5jM1LY2MyY2IjYnEq41+88RZPFDTNsIiYcO
        cFltsaAPtFY5vDPXqhDUHM/Dgm7OGOY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3023C13A84;
        Fri, 13 May 2022 18:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S9D8CKqmfmIQbwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 13 May 2022 18:42:50 +0000
Message-ID: <235ab912-7e32-e215-71a8-6438abe12dba@suse.com>
Date:   Fri, 13 May 2022 21:42:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] btrfs: zoned: introduce a minimal zone size and reject
 mount
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <8aa15bbbacbafa2ab77c01bfdfdabe65d6bfa606.1652457157.git.johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <8aa15bbbacbafa2ab77c01bfdfdabe65d6bfa606.1652457157.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.05.22 г. 18:52 ч., Johannes Thumshirn wrote:
> Zoned devices are expected to have zone sizes in the range of 1-2GB for
> ZNS SSDs and SMR HDDs have zone sizes of 256MB, so there is no need to
> allow arbitrarily small zone sizes on btrfs.
> 
> But for testing purposes with emulated devices it is sometimes desirable
> to create devices with as small as 4MB zone size to uncover errors.
> 
> So use 4MB as the smallest possible zone size and reject mounts of devices
> with a smaller zone size.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/zoned.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1b1b310c3c51..d9579d4ec0f2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -51,11 +51,13 @@
>   #define BTRFS_MIN_ACTIVE_ZONES		(BTRFS_SUPER_MIRROR_MAX + 5)
>   
>   /*
> - * Maximum supported zone size. Currently, SMR disks have a zone size of
> - * 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range. We do not
> - * expect the zone size to become larger than 8GiB in the near future.
> + * Minimum / maximum supported zone size. Currently, SMR disks have a zone
> + * size of 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range.
> + * We do not expect the zone size to become larger than 8GiB or smaller than
> + * 4MiB in the near future.
>    */
>   #define BTRFS_MAX_ZONE_SIZE		SZ_8G
> +#define BTRFS_MIN_ZONE_SIZE		(4 * SZ_1M)

nit: we already have SZ_4M

>   
>   #define SUPER_INFO_SECTORS	((u64)BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT)
>   
> @@ -402,6 +404,13 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>   				 zone_info->zone_size, BTRFS_MAX_ZONE_SIZE);
>   		ret = -EINVAL;
>   		goto out;
> +	} else if (zone_info->zone_size < BTRFS_MIN_ZONE_SIZE) {
> +		btrfs_err_in_rcu(fs_info,
> +		"zoned: %s: zone size %llu smaller than supported minimum %u",
> +				 rcu_str_deref(device->name),
> +				 zone_info->zone_size, BTRFS_MIN_ZONE_SIZE);
> +		ret = -EINVAL;
> +		goto out;
>   	}
>   
>   	nr_sectors = bdev_nr_sectors(bdev);
