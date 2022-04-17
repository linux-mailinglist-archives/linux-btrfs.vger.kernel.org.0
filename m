Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB0504769
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Apr 2022 11:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiDQJfv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Apr 2022 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiDQJft (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Apr 2022 05:35:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6314F3CFF9
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 02:33:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5so10896523pjr.0
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fydeos.io; s=fydeos;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=rbpt6SrSc/QgFoHqnVgYbms+e7L0+iwGeLzpbadSmrM=;
        b=FCUXBP9zjwj4f3CL2vCyYxFZmBZMHrGHk8PqOc6w4U5o9OsLuBtahBvzPlN14QoAet
         RlWC5+gQhBUDzh2c1g1NoDPW5YeIY3Dl6rg+7WmMy7Pn0FNwMkPBuGMiG7pg6oxlhylo
         w7zFVxU9fQSSjB73rc2evN6vRwC2CDhVeqcc+treSpIGBRH0lOFT2HUGDSq5eGqsB6aw
         YV5WA//tdUK8NiM6I3tr62XW8YEQ/11HX+wTFjYLppMvzyI0twZTiJcuZPrVaRiRk2qf
         ApZ6Oo49RiaIa4h4Wxu3yaaKKBHxWebEw7eitLMK26/VgDUL+eC07+ZE2a7yY+ptU1Qe
         oX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbpt6SrSc/QgFoHqnVgYbms+e7L0+iwGeLzpbadSmrM=;
        b=yP5vW0Jae7n/iOC3UpPA8ynIegkKAtO88sFEMiIj8Ynwxd7VrpOR6NBo6P6vQJD+D7
         Gi0cGdHVqL6V7KCZ6q9SGLjVuY6bnV12vYE1yvsZEUFLrwSqjAJWbbQXG0SNbT+L7YZT
         PoY+FVE1mjP3urh/PNoRsTph71NBBE+wBc/Do+62JEpSa6Yf5ZdVhRCICp+2G+N4rbbG
         2BDduRMCPuGxgBuoPO1IXdoCzQBOXU5E7LvHePUDZn1nFbpOWAnGb9O+UiAiaml0YdaZ
         w3x3lp2RIHDlYZDiAhPB0+oViKVLbd65qWs3dDZM6mS13FwWfzE8Oyt/k9obX++gdiZ/
         audg==
X-Gm-Message-State: AOAM5328e43j2mj+wPYkin1ofSmVvd5SEvz8uulMeCE+NDxquRVkH732
        PTsnWREWWFy/fytqWNTEew/5MRxMq9tvbDtS3sZMUA==
X-Google-Smtp-Source: ABdhPJy3pF00BD9HP6/i8+vn/CmFKarFhin7sRO3pVGYy/2q3MpPDI5/Axv663ZYtrAqlAr2KN8awQ==
X-Received: by 2002:a17:90b:4f91:b0:1cd:3a73:3a5d with SMTP id qe17-20020a17090b4f9100b001cd3a733a5dmr7554467pjb.98.1650187993776;
        Sun, 17 Apr 2022 02:33:13 -0700 (PDT)
Received: from [192.168.66.144] ([103.177.44.12])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090aca0300b001d26c525be1sm3246125pjt.12.2022.04.17.02.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 02:33:13 -0700 (PDT)
Message-ID: <1ea30dc4-2380-7e04-cab8-deeb63d967ed@fydeos.io>
Date:   Sun, 17 Apr 2022 17:33:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] btrfs-progs: check: fix wrong total bytes check for
 seed device
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1650180472.git.wqu@suse.com>
 <8ed9c80d960090f44b11c4420b5bfbe04170c4a4.1650180472.git.wqu@suse.com>
From:   Su Yue <glass@fydeos.io>
In-Reply-To: <8ed9c80d960090f44b11c4420b5bfbe04170c4a4.1650180472.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/17 15:30, Qu Wenruo wrote:
> [BUG]
> The following script can lead to false positive from btrfs check:
> 
>    mkfs.btrfs -f $dev1
>    mount $dev1 $mnt
>    btrfstune -S1 $dev1
>    mount $dev1 $mnt
>    btrfs dev add -f $dev2 $mnt
>    umount $mnt
> 
>    # Now dev1 is seed, and dev2 is the rw fs.
>    btrfs check $dev2
>    ...
>    [2/7] checking extents
>    WARNING: minor unaligned/mismatch device size detected
>    WARNING: recommended to use 'btrfs rescue fix-device-size' to fix it
>    ...
> 
> This false positive only happens on $dev2, $dev1 is completely fine.
> 
> [CAUSE]
> The warning is from is_super_size_valid(), in that function we verify
> the super block total bytes (@super_bytes) is correct against the total
> device bytes (@total_bytes).
> 
> However the when calculating @total_bytes, we only use devices in
> current fs_devices, which only contains RW devices.
> 
> Thus all bytes from seed device are not taken into consideration, and
> trigger the false positive.
> 
> [FIX]
> Fix it by also iterating seed devices.
> 
> Since we're here, also output @total_bytes and @super_bytes when
> outputting the warning message, to allow end users have a better idea on
> what's going wrong.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Su Yue <glass@fydeos.io>
> ---
>   check/main.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index e6e85784d5ea..64fc6f2ebdb7 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -8550,13 +8550,17 @@ static int check_device_used(struct device_record *dev_rec,
>    */
>   static bool is_super_size_valid(void)
>   {
> -	struct btrfs_device *dev;
> -	struct list_head *dev_list = &gfs_info->fs_devices->devices;
> +	struct btrfs_fs_devices *fs_devices = gfs_info->fs_devices;
> +	const u64 super_bytes = btrfs_super_total_bytes(gfs_info->super_copy);
>   	u64 total_bytes = 0;
> -	u64 super_bytes = btrfs_super_total_bytes(gfs_info->super_copy);
>   
> -	list_for_each_entry(dev, dev_list, dev_list)
> -		total_bytes += dev->total_bytes;
> +	while (fs_devices) {
> +		struct btrfs_device *dev;
> +
> +		list_for_each_entry(dev, &fs_devices->devices, dev_list)
> +			total_bytes += dev->total_bytes;
> +		fs_devices = fs_devices->seed;
> +	}
>   
>   	/* Important check, which can cause unmountable fs */
>   	if (super_bytes < total_bytes) {
> @@ -8579,7 +8583,9 @@ static bool is_super_size_valid(void)
>   	if (!IS_ALIGNED(super_bytes, gfs_info->sectorsize) ||
>   	    !IS_ALIGNED(total_bytes, gfs_info->sectorsize) ||
>   	    super_bytes != total_bytes) {
> -		warning("minor unaligned/mismatch device size detected");
> +		warning("minor unaligned/mismatch device size detected:");
> +		warning("  super block total bytes=%llu found total bytes=%llu",
> +			super_bytes, total_bytes);
>   		warning(
>   		"recommended to use 'btrfs rescue fix-device-size' to fix it");
>   	}
