Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77C0617890
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 09:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiKCIUm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiKCIUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 04:20:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8786401;
        Thu,  3 Nov 2022 01:20:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B603220CC;
        Thu,  3 Nov 2022 08:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667463633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ouZNBMNvvrnkZSRBeuTvoKMw9UcQXO1wNpACVbg3cbo=;
        b=FHIiUHpq8kqmiBvbiZIzQZcHVVijmK/UpBmXYgGDDpKMjhoes0eoyBDNsIOT+feaqkxFxg
        YaUrdak8yGX8ckWchrmP7gtE+g+RW3hVqzIizF+UtLlNdv0/3dRac3hSUr2TMFwMX+wv1A
        EpaQKNqflIpCrvhc/yLew8VCMAP9ZTE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25B3C13AAF;
        Thu,  3 Nov 2022 08:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lweEBtF5Y2NYNgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 03 Nov 2022 08:20:33 +0000
Message-ID: <357d9e4e-a975-7198-a496-1832d1ade3e9@suse.com>
Date:   Thu, 3 Nov 2022 10:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] btrfs: fix match incorrectly in dev_args_match_device
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103083301.626561-1-liushixin2@huawei.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20221103083301.626561-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.11.22 г. 10:33 ч., Liu Shixin wrote:
> syzkaller found an assert failed:
> 
>   assertion failed: (args->devid != (u64)-1) || args->missing, in fs/btrfs/volumes.c:6921
> 
> This can be trigger when we set devid to (u64)-1) by ioctl. In this case,
> the match of devid will be skipped and the match of device may be succeed
> incorrectly.
> 
> Patch 562d7b1512f7 introduced this function which is used to match device.
> This function contaions two matching scenarios, we can distinguish them by
> checking the value of args->missing rather than check whether args->devid
> and args->uuid is default value.
> 
> Reported-by: syzbot+031687116258450f9853@syzkaller.appspotmail.com
> Fixes: 562d7b1512f7 ("btrfs: handle device lookup with btrfs_dev_lookup_args")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>   fs/btrfs/volumes.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 94ba46d57920..bf2d886cfb4b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6918,18 +6918,18 @@ static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
>   static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
>   				  const struct btrfs_device *device)
>   {
> -	ASSERT((args->devid != (u64)-1) || args->missing);
> +	if (args->missing) {
> +		if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
> +		    !device->bdev)
> +			return true;
> +		return false;
> +	}
>   
> -	if ((args->devid != (u64)-1) && device->devid != args->devid)
> +	if (device->devid != args->devid)
>   		return false;
>   	if (args->uuid && memcmp(device->uuid, args->uuid, BTRFS_UUID_SIZE) != 0)
>   		return false;
> -	if (!args->missing)
> -		return true;
> -	if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
> -	    !device->bdev)
> -		return true;
> -	return false;
> +	return true;
>   }
>   
>   /*
