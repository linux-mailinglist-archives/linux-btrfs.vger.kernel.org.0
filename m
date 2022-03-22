Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5904E46F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiCVTxh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCVTxg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 15:53:36 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C226241
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 12:52:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 1so14847079qke.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VckA+2qDNUbyQgSXD+goljizdgb60HWM8uzaR481PVU=;
        b=UxEgpY7R5Gjz4RS3thzmwbBAWRaIAbdAOL6No/hxTrbDoIqCD4Dt7mFofYq8aCpPj1
         1FvZAxai09MkeQlgB3igi7+LS1ELWo9gRDDhTXHKQ6BFSFOyniTj1WvdV1H963ZOWtGH
         YT/lrmbkTB3i3Dwo6OGoESqWKyqW4iDuI151RBz/3XHXXVnx73E5rQ2OPXBFJ8GdrmKv
         WRT1id/Sl2eVUrFKMK4tsNkcy0R0nWIou7Ku07gTWfkH4TGRhWsRTun5r+2ELAIsBQIa
         HL+FvTFYy7xpNpdER+zMMHSgetZwGpTNRFVBc5vZBCW8iQGaJKQbnICtb+pXyUQU3CfX
         vIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VckA+2qDNUbyQgSXD+goljizdgb60HWM8uzaR481PVU=;
        b=SK4cr4pWLWeczQ/LrhBegWIqB6XWSGPelilwspQ7cjGsCTbKRo0CQVVmq3Mz7KpuYs
         nTXmOkdJ5Wvl1PWDxaHnNeP128M65HuubYdwouPD0pEteENrV1pmWN8BKigwjqMReR8n
         0whGc7SOmHVfez180qCVm5c9VQ4P13uGT/JXXnlVFrQIXYBhIJM71nBkXPcwo7Wliszu
         TPnIu27/DY36fiEC1W5XyKKIGQb8c3HvgT/gJDdXZEX9lqFzy1nboWBg6POun0q7x0aa
         f+/IFXcS/MuYk/eakCsp0h8oAVeha/sS9Rzql2MPuzvQRZknegElvZqFokgU6eupxJD/
         Na+A==
X-Gm-Message-State: AOAM531S4qmrTr0uQV5rbCKpvA9MfTbGw6WZurDd1LtbufTlQPWZmdy8
        Qt14savC4/0NIuLliTiJ7hdRlQ==
X-Google-Smtp-Source: ABdhPJzzSNkdUk7MiiJ/tmb4BTwpt7lW2m8UyGcVNDDVObHu3Xupzl+EPgg9+bfbBodcPcmxPRCQfw==
X-Received: by 2002:a05:620a:254d:b0:67e:3a57:8119 with SMTP id s13-20020a05620a254d00b0067e3a578119mr15308208qko.690.1647978726755;
        Tue, 22 Mar 2022 12:52:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm15056601qtx.89.2022.03.22.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:52:06 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:52:05 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 1/5] btrfs: add flags to give an hint to the chunk
 allocator
Message-ID: <Yjoo5TOlfGXgAUyk@localhost.localdomain>
References: <cover.1646589622.git.kreijack@inwind.it>
 <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 06, 2022 at 07:14:39PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Add the following flags to give an hint about which chunk should be
> allocated in which disk:
> 
> - BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
>   preferred for data chunk, but metadata chunk allowed
> - BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
>   preferred for metadata chunk, but data chunk allowed
> - BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
>   only metadata chunk allowed
> - BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
>   only data chunk allowed
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index b069752a8ecf..e0d842c2e616 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -389,6 +389,22 @@ struct btrfs_key {
>  	__u64 offset;
>  } __attribute__ ((__packed__));
>  
> +/* dev_item.type */
> +
> +/* btrfs chunk allocation hint */
> +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
> +/* btrfs chunk allocation hint mask */
> +#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
> +	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
> +/* preferred data chunk, but metadata chunk allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	(0ULL)
> +/* preferred metadata chunk, but data chunk allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED	(1ULL)
> +/* only metadata chunk are allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
> +/* only data chunk allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
> +

I also just realized you're using these as flags, so they need to be

(1ULL << 0)
(1ULL << 1)
(1ULL << 2)
(1ULL << 3)

Thanks,

Josef
