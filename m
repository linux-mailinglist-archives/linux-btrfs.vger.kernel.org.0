Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A707C5287F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244936AbiEPPFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244731AbiEPPFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 11:05:17 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501023B55C
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:05:08 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id kj8so12311652qvb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W34md6UR2q7uEnkNtrmvv6exofz4Bpa3AbMo/+9DL9Q=;
        b=2CKWX73BTk55uniGjIjQt8bF9dCuNW2UkWvZ/8uUry2AVUwM4Dtd+qCG28l9EYI6rd
         vO4f3NxUJbRvM/UxNIoPh3Lxa4GtLoV7xtYnxirRvFiMfftITz8phSAgfAbD/7m/ZIG0
         E1qjCTxHFgtotDAhEvZUOzLssTqR5IIcl+zcYAH7nUX1OlWAf98bkfRbmBgoDESJxAiB
         4ujQTb5t2Vz/DLtvLhuaID44+UgxeCz0isCX7B4HOE50bDT2qbYFOlP+zjej+RwDa4Y0
         qriA/iEFNAE2+DdvC1jp9JEFdHhLEVKeH9DHaOHlRIkEV7rqFAqW+SvYXNWh/kWQyW+9
         AY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W34md6UR2q7uEnkNtrmvv6exofz4Bpa3AbMo/+9DL9Q=;
        b=Q+23wvCIYAw7ZgjUIeyG+62uEzLxod293soHnp2cJ5U0nQuSLLp9v7dmlZqJnuf4zX
         ig5NhjFG6akbwQDo1dmL0bNOP0Ep2+N4rQy7UPKijGbiNJMSgh1MxGgOIJXo7jr4cDL1
         +6MS1830a/nc5KM5Wkv12B+B5xOO7TymB1won1B0u6cAT7/DjXjN52yNQpwLRIrKVw0Y
         85mJd1E71vSj8AuLW1BnIWKkUikuxeCNKfSVP4BkryM5CNg7ozQ4Jrlh9upX1+susGlk
         nQeZCLkzQNLP1DPe5UjiK2Ysnve94ka+W1m0fA3WT1g8OkcDeKPx9D4Zfw2zTepObGfo
         vaBg==
X-Gm-Message-State: AOAM530HAXvdLcHs45yJHx45+Q0SCNuIlDzTenc40fKy2+9GxxhsepSS
        CrxslyE7dCwHUW6SrUKvzdz/Iw==
X-Google-Smtp-Source: ABdhPJy5Z9RsbYTtFlvFHPbiXKFh/59gJ3ZzvRIoWqJbNb5QzC6ZnPGDsSa7GkCxu73VeBiCIp9btw==
X-Received: by 2002:a05:6214:e86:b0:461:ca87:44aa with SMTP id hf6-20020a0562140e8600b00461ca8744aamr5713583qvb.112.1652713507158;
        Mon, 16 May 2022 08:05:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n4-20020ac85b44000000b002f3b561957asm6809251qtw.13.2022.05.16.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:05:06 -0700 (PDT)
Date:   Mon, 16 May 2022 11:05:05 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: prevent remounting to v1 space cache for subpage
 mount
Message-ID: <YoJoIeDHKTOKljfv@localhost.localdomain>
References: <1e09cf20ca9309f2b9daf57136c3e2c1b22f94f6.1652682383.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e09cf20ca9309f2b9daf57136c3e2c1b22f94f6.1652682383.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 16, 2022 at 02:26:53PM +0800, Qu Wenruo wrote:
> Upstream commit 9f73f1aef98b ("btrfs: force v2 space cache usage for
> subpage mount") forces subpage mount to use v2 cache, to avoid
> deprecated v1 cache which doesn't support subpage properly.
> 
> But there is a loophole that user can still remount to v1 cache.
> 
> The existing check will only give users a warning, but not really
> prevents the users to do the remount.
> 
> Although remounting to v1 will not cause any problems since the v1 cache
> will always be marked invalid when mounted with a different page size,
> it's still better to prevent v1 cache at all for subpage mounts.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index b1fdc6a26c76..1617528a3367 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1985,6 +1985,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  	if (ret)
>  		goto restore;
>  
> +	/* V1 cache is not supported for subpage mount. */
> +	if (fs_info->sectorsize < PAGE_SIZE &&
> +	    btrfs_test_opt(fs_info, SPACE_CACHE)) {
> +		btrfs_warn(fs_info,
> +	"v1 space cache is not supported for page size %lu with sectorsize %u",
> +			   PAGE_SIZE, fs_info->sectorsize);

Shouldn't we be doing ret = -EINVAL; here?  Thanks,

Josef
