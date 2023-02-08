Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76E268F87F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 21:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjBHUAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 15:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHUAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 15:00:17 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2CA1E1F6
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 12:00:16 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c2so22251606qtw.5
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQFFAYfQRLsDNXnJ1Y1yUXs+A2IsDyDbevw287DCX9Y=;
        b=Fq0IJjhrJaOSQFyUUNxMKB55frzp7BWvjbH+MGpAeby9JPqiLPWpK1s6fKgdURy7XU
         JWKZxEu+1sHXwtaTZ9I40LDOCcAbPYjB+CiP/N8ikuR/rSskSvXsKUxcDo5GnforSmkU
         BcVxupiWiUjK9dhojMbxzjZBhWYZeZoBYTBNIrCzyrTvgN5m3V50IKmwSg/CnaiyFnkz
         QGRQZvoCuSoCGv3q2VgaBim0m2u9SKNwQF4WPrENRGIvOWXEqFvQEr0Rhe4fOvBF43Yl
         GMQIXsOL1mjaBHc7jn3nyCMxaH+iLc+UUKYYNMocjxdb1rSLY5x1pv8PSLnKyVECOxga
         yRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQFFAYfQRLsDNXnJ1Y1yUXs+A2IsDyDbevw287DCX9Y=;
        b=3UuNLKxxivGJP7Co8xFoqLK3PJ1N/28f8BjJzqm5CbqETvK8XiogeY9aNm1Xt8ETxr
         erpMg9eH6Buac6D4pIuke6R3FgaLNws/NLSnPBUBxYegl3u4S2sPGvNwWfakXStZjYg2
         +pjzPHmHUXx08fCqqmnKlM1joll63WcjkfUi4Ye+4L7GVoTX/svz1gbMs/oLbTnzSR47
         afEZVvxwGiQypqX9zhReO9hE/9d4EL9f7LO1GB68sxZUWFW1RTMLU0Hz39TlYjdf8PTl
         nu0po6P7bqG1FAhGecvSQ4cUSZevU3DV/mC8ulpskby2gOQazZM5KWIaWogHv7SBGT51
         2hwg==
X-Gm-Message-State: AO0yUKWLAkFBW+wFCD2Y8qzTXs2/IL/Ema4S+MsVWBvD5DEmZYkeIsb/
        reNwdvvdU3HtXJNLfZsdzNItSPEdLpfFzhVALQQ=
X-Google-Smtp-Source: AK7set9By2Ai0tUoCu9RfclBlVbOBVg8ZIjFWK3Ak3Q3eG6C8LrRg90ds+t77bWm1mx5gRcL+JBmKw==
X-Received: by 2002:ac8:5913:0:b0:3b9:bd05:bde1 with SMTP id 19-20020ac85913000000b003b9bd05bde1mr13485964qty.8.1675886415680;
        Wed, 08 Feb 2023 12:00:15 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id o5-20020ac80245000000b003ab7aee56a0sm11888047qtg.39.2023.02.08.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:00:15 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:00:13 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 05/13] btrfs: delete stripe extent on extent deletion
Message-ID: <Y+P/TefZ1nwTpkAn@localhost.localdomain>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <28ff4b0398d52b27c93fac93297be8f0e2a18fab.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ff4b0398d52b27c93fac93297be8f0e2a18fab.1675853489.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:42AM -0800, Johannes Thumshirn wrote:
> As each stripe extent is tied to an extent item, delete the stripe extent
> once the corresponding extent item is deleted.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/extent-tree.c      |  8 ++++++++
>  fs/btrfs/raid-stripe-tree.c | 31 +++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |  2 ++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 50b3a2c3c0dd..f08ee7d9211c 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3238,6 +3238,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  			}
>  		}
>  
> +		if (is_data) {
> +			ret = btrfs_delete_raid_extent(trans, bytenr, num_bytes);
> +			if (ret) {
> +				btrfs_abort_transaction(trans, ret);
> +				return ret;
> +			}
> +		}
> +

We're still holding the path open, so now we have a lockdep thing of extent root
-> RST, which will for sure bite us in the ass in the future.  Push this part
just under this part of the code, after the btrfs_release_path().

Also since we have a path here, add it to the arguments for
btrfs_delete_raid_extent() so we don't have to allocate a new path.  Thanks,

Josef
