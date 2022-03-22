Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1F4E459A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 18:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiCVR5q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 13:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbiCVR5o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 13:57:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF123BE3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:56:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b189so14532793qkf.11
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79QGpeOenOwbMRmYF+OGKBvl9oaceigLLywBHEos7Bk=;
        b=j4up9UWKbh1NDbcQig9tyrbQGMx9JLNnVwRKRmRmko7+KGXEXXKeHi+yPKM1Gcf/MS
         mf67Da1EIpgcM1ddhBrN+eOUfqTyKnQjJQLk0F0hb+qFSUKY40JNPf1s1p0iqBW3A6VE
         dhBMGiaOy8sNlfbMc8pg3wpZE8XsF3rOdUGGwBtwlscIMMWEtx3gL7uGXligDxlIgmJa
         HQ5THakLLavnKBz0IX96hmD0ooPHXsXtE3GBNoSS1SG5oy9qpntHbqN7ArJXX4AjTr8p
         ngLcym4avb1Wp6q32LYKGLCNTEO4+ULEbd4lCtepV3CHclmg2TY6SKjLHb32hZOigK6s
         A8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79QGpeOenOwbMRmYF+OGKBvl9oaceigLLywBHEos7Bk=;
        b=dmq8vYr1VgmL5gjAOTfH4uU4kvO/eEkgDwePDV0KQzwH6Cngr9dnbmrp8ysK+JEYLM
         BJ1VddJbN2UsvNHLD7vnPIjMBPBJDWGJ1yEFUGK53C2+mynCS1Oyl6ekHNfs1mHh8lii
         VUKx8J93FU3tAAy9sLncBB+DDgOhPPOqukKUHiugkJ966/PM+yY/HMm5V87Qgo4eaiUK
         jQqS/HyaKQOhNPbU1FKVl5yt3g8Cvz279w28ry6eCdlJuh7sTyGFXN0dxRnVPvzCGP4t
         oqRM9KNjt5RgTxOLrBczJVDDzEkCdXfRuUQz3uGnfxr788gqUjXY0QHsVe4yBAP+nX65
         W9Qw==
X-Gm-Message-State: AOAM531+L0A8ZHmJMN1Ghlj6WXYoP/0j+CMIUk8rrhwvDHri1YuerW3A
        etachWk0dQA4eDI4ZcsjtAvCmxL1Mf+1GA==
X-Google-Smtp-Source: ABdhPJzG2tvSmNfUmcS8JEmuAPaxPWT4D0iISAZar+0jaZbPhTkZ89p8dyqXNEGjnsxyrPyngo5HnA==
X-Received: by 2002:a37:993:0:b0:67b:1331:6abf with SMTP id 141-20020a370993000000b0067b13316abfmr16210021qkj.201.1647971775767;
        Tue, 22 Mar 2022 10:56:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r8-20020a05622a034800b002e1d615484bsm14527952qtw.37.2022.03.22.10.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:56:15 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:56:14 -0400
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
Message-ID: <YjoNvoIy/WmulvEc@localhost.localdomain>
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

Actually don't we have 0 set on type already?  So this will make all existing
file systems have DATA_PREFERRED, when in reality they may not want that
behavior.  So should we start at 1?  Thanks,

Josef
