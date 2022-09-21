Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C45BFB25
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiIUJjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 05:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIUJjr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 05:39:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3054F1159
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 02:39:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so8229299lfo.7
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=V+OPczDdE/HaaYcY94VXHIGGTZJYLEmKyZA99aRzniE=;
        b=qNfM5ghitxD+dCybYzuUciHbDrVPTldxBXRQAoWYC3n+MPXHTESlBxwM4vWUx8maMo
         BhaVVwuCVjsCSAMVU5wIPIY4EiiaBBqa0esFwiZ4FcR8SdRKnNUPtd8MqVufgMK+ARIE
         4klHaKwyUEW6nTLBYgcDM+AHiQLpuyjYTkEsSbqcMyGlXqIuuhwyWy0LM8vHbw5X79S8
         qkrcpnJG27p5VnkRzMKJLqVI0H308amCEVkOe945g4lYyF6Bxbd7aulwyXOgHnjLs4lF
         4KFWuSS4xdjEb/yF/E1S0OVHxwBPRkRrceSVs7615dxKDU2Jvo/MCry1MAdG1rV3ZrrK
         RZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=V+OPczDdE/HaaYcY94VXHIGGTZJYLEmKyZA99aRzniE=;
        b=WzNM3HDR62E3JpYKqX1TaWCFHNZoyZMyiMKpsnLzB8g5b/EC4OvmLMw8OLbiAANqGs
         zpEu1ckKCQGJ95QVTwzGqBmfjJX52RLG8jCiNkAxWjJ3nn0qlhH81B0HZCbDOVYnOZO+
         CAmMrwo3BSj9r3gSVnzndUjpJgSO9EEWJLC4c3s0NTe0dV/pLLD5cqmAt2SM5ZvheY3M
         DCKSHp9x0hUTzgp62vSdf8V1yojy6llOreMU1mK515vmXSFuioQyPfccltc21vAKSxFM
         /3FMow12YUTAR0oYg8IU+FH94CZoYhzHplDDGRoISXTWhxfyfK/6mavKn2xahD69QHec
         9/hA==
X-Gm-Message-State: ACrzQf1fYI56AZV1NZhmnUkC6iCuunwrI8sZL6PLlDOAg3TfXIYik4p3
        kRDFc8ggTyh0HPr2ULfzWvM=
X-Google-Smtp-Source: AMsMyM4VZJI445+cIuL+X479ZvjkhG5jrwEqP2PhE41r99xEOHlerQnjU0uIq8oVZpqzsixxHDSbMw==
X-Received: by 2002:a05:6512:3185:b0:49c:3310:6910 with SMTP id i5-20020a056512318500b0049c33106910mr11062125lfe.352.1663753182303;
        Wed, 21 Sep 2022 02:39:42 -0700 (PDT)
Received: from localhost (80-62-117-68-mobile.dk.customer.tdc.net. [80.62.117.68])
        by smtp.gmail.com with ESMTPSA id q23-20020a056512211700b0048a9b197863sm350460lfr.235.2022.09.21.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:39:41 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:39:40 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 01/10] btrfs: add a helper for opening a new device to
 add to the fs
Message-ID: <20220921093940.4fjljoyc37d5jt2z@quentin>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <280fe61f3405e88a0a4a5ac0cacff3993f9f31ff.1663196746.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280fe61f3405e88a0a4a5ac0cacff3993f9f31ff.1663196746.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>  	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 09c1434c3cae..ea76458d7c70 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2583,6 +2583,26 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>  	return ret;
>  }
>  
> +struct block_device *btrfs_open_device_for_adding(struct btrfs_fs_info *fs_info,
> +						  const char *device_path)
> +{
> +	struct block_device *bdev;
> +
> +	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
> +				  fs_info->bdev_holder);
> +	if (IS_ERR(bdev))
> +		return bdev;
> +
> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
> +		btrfs_err(fs_info,
> +			  "dev-replace: zoned type of target device mismatch with filesystem");

Shouldn't the `dev-replace` be removed as this helper is used from
dev-replace.c and volumes.c?

> +		blkdev_put(bdev, FMODE_EXCL);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return bdev;
> +}
> +
>  int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
>  {
>  	struct btrfs_root *root = fs_info->dev_root;
> @@ -2602,16 +2622,10 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	if (sb_rdonly(sb) && !fs_devices->seeding)
>  		return -EROFS;
>  
> -	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
> -				  fs_info->bdev_holder);
> +	bdev = btrfs_open_device_for_adding(fs_info, device_path);
