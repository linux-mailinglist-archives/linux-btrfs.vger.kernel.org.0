Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED3E5148A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 13:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358775AbiD2L6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358760AbiD2L6a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 07:58:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234521FA54
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 04:55:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so13560932lfa.12
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 04:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a5Z8Jx/dEBM01mYWNgTRbsAdY1cC6C5iAA0Vuh/nJ9I=;
        b=QtI6ZtFefdXc0v88SOvUuzjCE55ktVrOSx6x0otm5fcTuunJuSg0A0rhRYiWV8/3VF
         qprwvMjbYNPyGTg24D37aY7OcIcwxG5nLJ8SBhPGGHR9SU5jbBLbkaKMMlIBBSF7bGUb
         afa/nTiys3E/ND56oJjQDuFTqofduys62GjQEPcda6EMA966lOz95nXPxwhuF8AJZfYO
         sB6Bhe+Iv5tG24I3jP2Bv9PUHbA27TqSaYTJ7LMr2Ti+4pR83im3Zi4IrzdIqH9/0PXG
         7qcdzg2J3xOrrfnXevJH9YgHMI1LRS8mD4INvZynloFdyxiV99+NPIk2A4EhqDoirMMi
         1iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a5Z8Jx/dEBM01mYWNgTRbsAdY1cC6C5iAA0Vuh/nJ9I=;
        b=Jgvp0t44uQzABhaKwGjuSpzvwEZH7zQh519QSpDOPAqH2KZXlSFZM3fWQg4U16XnCv
         bB+Y4qcZFao4ZAqvyqxLFQ1XhNrfrwQw6OpDFxEpAdnLc5yQ747VVo9jUvNUdpLnPeAd
         g2PugyE7EqFGX4tf/2oCf13AHv4jG0/nz/AFLShCJPD/G86+C17NavPJTXuDUVU/TtBz
         7p285brUaKTVWBql0Bs+sRzoLTEQTLPmltAD1Q0xvW8nTDMPRudWrDqlutqW6a2K6n1+
         t3Kf6+U2TV122J3ZwVkvMsi8tvDaMA/f0Cf/DgnlDaL1PrZmozZT/F8E09XCAcWI+vhP
         BofQ==
X-Gm-Message-State: AOAM533/NKZKNRizHPuNHpWR1Sp0DqHW0MTl5MdaCAgH4CXUSpbxOnSy
        OBsMcFG39md+WKW9uWeVcJU=
X-Google-Smtp-Source: ABdhPJxAKor5dzJbBsQ5o+7uKmbL39jkrSRXDWdlQHw5FA8U57Q0ziypFAEm2hzWuE0+0mldz8pD0g==
X-Received: by 2002:ac2:42c8:0:b0:471:f95d:efec with SMTP id n8-20020ac242c8000000b00471f95defecmr22723990lfl.686.1651233309490;
        Fri, 29 Apr 2022 04:55:09 -0700 (PDT)
Received: from localhost (80-62-117-19-mobile.dk.customer.tdc.net. [80.62.117.19])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eb7ca000000b0024f3d1daebbsm249944ljo.67.2022.04.29.04.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:55:08 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:55:07 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 2/4] btrfs: zoned: finish BG when there are no more
 allocatable bytes left
Message-ID: <20220429115507.l2zxgcj634nw2ytd@quentin>
References: <cover.1651157034.git.naohiro.aota@wdc.com>
 <42758829d8696a471a27f7aaeab5468f60b1565d.1651157034.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42758829d8696a471a27f7aaeab5468f60b1565d.1651157034.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 12:02:16AM +0900, Naohiro Aota wrote:
> +++ b/fs/btrfs/zoned.c
> @@ -2017,6 +2017,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
>  void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 length)
>  {
>  	struct btrfs_block_group *block_group;
> +	u64 min_use;
minor nit:
Could you rename this variable to `min_alloc_bytes` or something else
more descriptive?
>  
>  	if (!btrfs_is_zoned(fs_info))
>  		return;
> @@ -2024,7 +2025,14 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
>  	block_group = btrfs_lookup_block_group(fs_info, logical);
>  	ASSERT(block_group);
>  
> -	if (logical + length < block_group->start + block_group->zone_capacity)
> +	/* No MIXED BG on zoned btrfs. */
> +	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
> +		min_use = fs_info->sectorsize;
> +	else
> +		min_use = fs_info->nodesize;
> +
> +	/* Bail out if we can allocate more data from this BG. */
> +	if (logical + length + min_use <= block_group->start + block_group->zone_capacity)
>  		goto out;
>  
>  	__btrfs_zone_finish(block_group, true);
> -- 
> 2.35.1
> 
Otherwise the changes look good to me.

Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

-- 
Pankaj Raghav
