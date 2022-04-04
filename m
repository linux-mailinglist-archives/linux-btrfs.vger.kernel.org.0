Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DEF4F18E4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378737AbiDDPyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 11:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378738AbiDDPya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 11:54:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9220042491
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 08:52:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3FD0D1F385;
        Mon,  4 Apr 2022 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649087553;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJ/NfmRLGiCSTx0YhT+sXlqUr6LIFMzNFTwoZZaRcKo=;
        b=qAFuPYCR1lgy8MBpqfOXqdYGVlOHqZzOyWdQtnMJKMBSlN/SlsGozzZKondm9e1JSIrN/1
        B/96iOXT0fLA1+/mBSbQNWNk0Bx7FV0DrwHSTspJW9gRlSKHPwp+7XeoEFjrSKPIbX5I92
        IqJLoK52nZ8CMePMrThP0Fsavt4jnPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649087553;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJ/NfmRLGiCSTx0YhT+sXlqUr6LIFMzNFTwoZZaRcKo=;
        b=AQ3hSE8sm3fjaV0gCe7LEVL4tU3FUl+e0+TpRi16HcpjuMI6AIfQsiAjT3j5L4yhhPdj9O
        VkMcqZx2mopW6FBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D9833A3B89;
        Mon,  4 Apr 2022 15:52:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 11B24DA80E; Mon,  4 Apr 2022 17:48:31 +0200 (CEST)
Date:   Mon, 4 Apr 2022 17:48:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] btrfs: zoned: make auto-reclaim less aggressive
Message-ID: <20220404154831.GP15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <cover.1648543951.git.johannes.thumshirn@wdc.com>
 <c69adfe62944e32a0d2e37b25c34cd49edc15f43.1648543951.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69adfe62944e32a0d2e37b25c34cd49edc15f43.1648543951.git.johannes.thumshirn@wdc.com>
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

On Tue, Mar 29, 2022 at 01:56:09AM -0700, Johannes Thumshirn wrote:
> The current auto-reclaim algorithm starts reclaiming all block-group's

Please write it as 'block group' in the text, also the use of 's is not
plural.

> with a zone_unusable value above a configured threshold. This is causing a
> lot of reclaim IO even if there would be enough free zones on the device.
> 
> Instead of only accounting a block-group's zone_unusable value, also take
> the ratio of free and not usable (written as well as zone_unusable) bytes
> a device has into account.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 10 ++++++++++
>  fs/btrfs/zoned.c       | 28 ++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h       |  6 ++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 628741ecb97b..12454304bb85 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1512,6 +1512,13 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
>  	return bg1->used > bg2->used;
>  }
>  
> +static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
> +{
> +	if (btrfs_is_zoned(fs_info))
> +		return btrfs_zoned_should_reclaim(fs_info);
> +	return true;
> +}
> +
>  void btrfs_reclaim_bgs_work(struct work_struct *work)
>  {
>  	struct btrfs_fs_info *fs_info =
> @@ -1522,6 +1529,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
>  		return;
>  
> +	if (!btrfs_should_reclaim(fs_info))
> +		return;
> +
>  	sb_start_write(fs_info->sb);
>  
>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1b1b310c3c51..c0c460749b74 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2079,3 +2079,31 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
>  	}
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  }
> +
> +bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 used = 0;
> +	u64 total = 0;
> +	u64 factor;
> +
> +	ASSERT(btrfs_is_zoned(fs_info));
> +
> +	if (!fs_info->bg_reclaim_threshold)

For integer values it's IMHO better to use == 0 as ! is for bool
variables.

> +		return false;
> +
> +	mutex_lock(&fs_devices->device_list_mutex);
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (!device->bdev)
> +			continue;
> +
> +		total += device->disk_total_bytes;
> +		used += device->bytes_used;
> +
> +	}
> +	mutex_unlock(&fs_devices->device_list_mutex);
> +
> +	factor = div64_u64(used * 100, total);

Seems we can't avoid 64bit division here, at least it's not perf
critical.

> +	return factor >= fs_info->bg_reclaim_threshold;
> +}
