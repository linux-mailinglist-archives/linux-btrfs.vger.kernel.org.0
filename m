Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F40C4E4582
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 18:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiCVRxB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiCVRxA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 13:53:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36BA6D3BC
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:51:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t7so15053703qta.10
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FMzhok0yBCuifhf76Tvr+EzYkTDhpzoAb4DJhUSHV0E=;
        b=5uIN4kTQtQ3cuTfUCD4+NK+GT7cA1PVn0dQC6rXwnGsFl5xcCvlchx4IvjfwnuKO8d
         WpoAt3ZulrwBs9c7l0oopSXmrb/K0RKRXi9zO0/URsG0vemxcmaCCVS6DKwTaSEG7Tlm
         MfH4wzBtx9kyuXv2pxrHBWvpYf2v+6wSaqam6+gkI6uON1eh+V5mzoXoyayPouKsJKbw
         DstZG9WbiKb2HF6pgHJX7Tg0MVlKMrp0oerEflyegtdal2MF+xYGZUL86oBodf7MVRnX
         bLZ1gdcGSW17AIYqJYk8HfcHlGKAeIsKS/OUwxia86AbBJUjeqB8YRIhNDusJnNR1OXx
         RCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FMzhok0yBCuifhf76Tvr+EzYkTDhpzoAb4DJhUSHV0E=;
        b=IKWViIpkwTGR08lj1nIxq5tqVfDMBP5eKNk6ixr1cmPiL0ZMFuUsEZxidJ3+tseXPJ
         BLol9hoocTXANEZmA7odMMrBYg0boVaeRQqtIs1i82aCubvPXM5Rahc0A4uNK+Fp6bi0
         sQl0l2cEDIZTsecKe0DRFjfkCzZMjMVFPDfQtyG0NM4ZWtJDbT5wjMtBcyQPp3xvQmyY
         M+s+Oow8yKAT4HZgAuO/D8GjjieoTiiOc34QV6R+OVGoBHNIaI18Smar366LI0lUjBop
         6sEplhOxMe7u0F4NE+HcTYWLQzk4R90dyD3laAml5TrVHjIGS+bDSVsEd7jGY06bsLRm
         L8dw==
X-Gm-Message-State: AOAM531ge74147U/cVCc2z8PPZScWCdGcKrjPupDP5qriotmQW/bigO/
        u6vAP3/ZA9MAa1DHYvpD4C41Yg==
X-Google-Smtp-Source: ABdhPJwXumS3gWcgbpNcMLhAIPTdaXat9Yeu6kXYQWViS4PCquuhrvRHT9tCk+kYaYlXdAOWB4GVCg==
X-Received: by 2002:a05:622a:15cf:b0:2e1:e5cb:aed3 with SMTP id d15-20020a05622a15cf00b002e1e5cbaed3mr21375950qty.524.1647971490790;
        Tue, 22 Mar 2022 10:51:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n70-20020a372749000000b0067d4067ba89sm9299652qkn.100.2022.03.22.10.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:51:30 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:51:29 -0400
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
Message-ID: <YjoMoSLf5YE2sXYS@localhost.localdomain>
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

Just a style thing here, format it to match everything else, and have the bit
stuff later, as well as newlines between everything since we're commenting.
Also we don't need the () around the values, generally it's best to follow the
style of the surrounding code when in doubt.

I know Dave probably has stronger opinions on this than I do, but I think
something like this would be better.

/*
 * btrfs_dev_item.type values.
 *
 * The _PREFERRED options indicate we prefer to allocate the respective type on
 * this device, but will fall back to allocating any chunk type if we run out of
 * space.  The _ONLY options indicate we will only allocate the given type from
 * this device and no other types.
 */
#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	0ULL
#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED	1ULL
....

#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
#define BTRFS_DEV_ALLOCATION_HINT_MASK		\
	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)

This will make it a bit clearer and easier to read.  Thanks,

Josef
