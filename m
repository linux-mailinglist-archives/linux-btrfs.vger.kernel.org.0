Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57268F8AC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 21:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjBHUQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 15:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjBHUQ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 15:16:27 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4F21A0A
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 12:16:26 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z5so22296442qtn.8
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 12:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JvYw+xZrVEo1ZLpmUPLVw/m2+amVcwbt/nYWa/UVXk=;
        b=i0bzzTMIO8wnV+aYIaIr86uXOrRIYNYwGwOdr85uv6My8XB7WG+TQJ4LhW9DmJo7Yz
         ANBsXeDhhL1HN5X643IAL9YUpIXnZbvGfc4auoLO+KZ9QjZ7l+ZMbcl87phmirAR0VD/
         b69EvXeSmpIxEEKkqqK+m/o+W4lkHY8F4AdfDYhwQdb/Urj+s9b/QVBuYFOUzrCjpDeH
         XkP84CoyZcI4Fp6K76CHtvquSkgiEuPt/SxMhPDrAVhTp5ytWV4TlB3dAxj8vwhvJVEi
         CmEbof7z43Ma30eUxApUvTvPxz+VtWBVp9EcvoGWAmaYg3f3z6CDeFHmQmiz5hCEbMnw
         K6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JvYw+xZrVEo1ZLpmUPLVw/m2+amVcwbt/nYWa/UVXk=;
        b=knQ2aGJrauY9OIKP58sJ64AQa6gBF0zmsBsSYMTK0V9hbY8jg3WlHKB6zWnFS6fJ9+
         Z9hNCT99ZdjgOdf91WKWGVxiADhny5jpj1aP0/3KxiRuKpjPH9Zkl8oECuPlgPujrx73
         HUhbA9fzqzZJuf4pCEdKEggDRWMdVK6rLR1sKFcOXx1wwM+wq3kUKG0FRdijs4O6ybc1
         I5Pe1FkKVH3u/JTkk7XLMmesApFaVRwEYkhuSGrYXuFXmCwQsSOOZpS9R8SefuR1Kk02
         /ucd3nsl3zjUADdAtFkKPgq/oYVV5mWII4u2+mG1+yPVPyF/fbt9/W7jxgNr8OJn92U2
         le5Q==
X-Gm-Message-State: AO0yUKVMMRwGdoHGeY9OXWV3lrWUjGoBx/VBGrUu6IzvkpYIH5YvggXd
        0KE538YgCCXj8rdv+f969CBVrD+2ZYP/30KtAMM=
X-Google-Smtp-Source: AK7set9QW7rlRYTNerA/Q8fIUnhEapzBFWg6PrdNa4kkU1wr8VNv4nquhlbSPh5yXMeRhJ9RTodnxA==
X-Received: by 2002:a05:622a:1301:b0:3b8:4adb:c603 with SMTP id v1-20020a05622a130100b003b84adbc603mr13941255qtk.60.1675887385404;
        Wed, 08 Feb 2023 12:16:25 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id 67-20020a370846000000b0073185aef96csm8957804qki.51.2023.02.08.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:16:24 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:16:24 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 06/13] btrfs: lookup physical address from stripe
 extent
Message-ID: <Y+QDGMuAOkIOuvZh@localhost.localdomain>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <f1ee4f592ce63640fec2caf9d1b5ce64da11a733.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ee4f592ce63640fec2caf9d1b5ce64da11a733.1675853489.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:43AM -0800, Johannes Thumshirn wrote:
> Lookup the physical address from the raid stripe tree when a read on an
> RAID volume formatted with the raid stripe tree was attempted.
> 
> If the requested logical address was not found in the stripe tree, it may
> still be in the in-memory ordered stripe tree, so fallback to searching
> the ordered stripe tree in this case.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 145 ++++++++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |   3 +
>  fs/btrfs/volumes.c          |  31 ++++++--
>  3 files changed, 172 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index ff5787a19454..ba7015a8012c 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -231,3 +231,148 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
>  
>  	return ret;
>  }
> +
> +static bool btrfs_physical_from_ordered_stripe(struct btrfs_fs_info *fs_info,
> +					      u64 logical, u64 *length,
> +					      int num_stripes,
> +					      struct btrfs_io_stripe *stripe)
> +{
> +	struct btrfs_ordered_stripe *os;
> +	u64 offset;
> +	u64 found_end;
> +	u64 end;
> +	int i;
> +
> +	os = btrfs_lookup_ordered_stripe(fs_info, logical);
> +	if (!os)
> +		return false;
> +
> +	end = logical + *length;
> +	found_end = os->logical + os->num_bytes;
> +	if (end > found_end)
> +		*length -= end - found_end;
> +
> +	for (i = 0; i < num_stripes; i++) {
> +		if (os->stripes[i].dev != stripe->dev)
> +			continue;
> +
> +		offset = logical - os->logical;
> +		ASSERT(offset >= 0);

This is always going to be true, should probably be

ASSERT(logical >= os->logical);

otherwise you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
