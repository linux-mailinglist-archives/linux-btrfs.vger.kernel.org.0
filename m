Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB10D5287A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiEPOzX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiEPOzV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:55:21 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E433B2AF
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:55:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id p4so12195136qtq.12
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MaWiXQ3+yZltf9NlpR49BIQi6wrHH66RGBExH/DjQGE=;
        b=Q62eM5zUMzK/sCAslgAyotsh9Kb+i28qWpYR8Qe2WOrdgHi/gB73YPnK+ildPC/37g
         dFLKVurW4+q1p++PLfljwC4EUHZ60frSc/Qz++orAiOmMRyiEuVp44f3fu+P4tCFyk2q
         AXZ5SZ/w1rRnoEsThB5dqUckJyy7GXeMrdq7DI9X7andwiCdNdXv2EsRuK1JoqodmAse
         kI+ve6/7KuL0TpFglBRNdmSUzovJwHC2bi/WufuW9/uR/ndLP/5K8UsS597PiiWQUUk4
         m8YwRXgP2crOFYMq4qO91COdfbqflJdGsOPQDvfc54iuDcs7nhF2CO4euFeHDdxxW1G+
         cHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MaWiXQ3+yZltf9NlpR49BIQi6wrHH66RGBExH/DjQGE=;
        b=oANVAi1mAcQEFNZbXFAoERskg9zKOtMULwtgUoAonftiuOtHtSALp11gOMozEZsI9+
         mr+riIBN33urroNH0ZRufCLFZc+7+iSYfdSK/WcMFdXL6v2XKvtqPb8DKSpAa54x/yr5
         x4HUdyt5aPneBaCy5sAfZFWXCLJRgbzY9J8+YNgnaAh7aBkbD80ZCL/Gx2cjlbGdTFjC
         wNcv3/+3+7XzZPYb6JSDb2fqQ56J4Ikpnodkkoh7XEHGLQdOA/6YsHfIkt3Tb0lDu0BY
         oTSQ0olYeyxgAcFR37MlwA53wuTsvZISivpEul5PHj2Ucuth838XXPrqz9qkTvBUIkYY
         VAOQ==
X-Gm-Message-State: AOAM533yG5ebteExL8ZHQBU1nx8bK/GlUlRuM0d+3Z1Tt4PPUvDxryUM
        JDH8VB+/AF5RTwZoWnoPueL74GqbqFpzZg==
X-Google-Smtp-Source: ABdhPJy016bDEAW9Y4MpIaccc6iTPOMA/w1UKB4C7xvnoDyqC9Br8FHJwp/fKSjnVrWV80V+J9FGXg==
X-Received: by 2002:ac8:5cc7:0:b0:2f3:bab2:92a8 with SMTP id s7-20020ac85cc7000000b002f3bab292a8mr15585949qta.224.1652712919821;
        Mon, 16 May 2022 07:55:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i9-20020ae9ee09000000b006a0ba4b8f48sm5796266qkg.49.2022.05.16.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 07:55:19 -0700 (PDT)
Date:   Mon, 16 May 2022 10:55:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC ONLY 6/8] btrfs: add code to read raid extent
Message-ID: <YoJl1jo5hgDLxFi+@localhost.localdomain>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2aa8aae2f6394b774f480d877f2701fed6fd74c4.1652711187.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa8aae2f6394b774f480d877f2701fed6fd74c4.1652711187.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 16, 2022 at 07:31:41AM -0700, Johannes Thumshirn wrote:
> Add boilerplate code to lookup the physical address from the
> raid-stripe-tree when a read on an RAID volume formatted with the
> raid-stripe-tree was attempted.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 68 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |  3 ++
>  fs/btrfs/volumes.c          | 23 +++++++++++--
>  3 files changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 370ea68fe343..ecc8205be760 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -1,10 +1,78 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/btrfs_tree.h>
> +
>  #include "ctree.h"
>  #include "transaction.h"
>  #include "disk-io.h"
>  #include "raid-stripe-tree.h"
>  #include "volumes.h"
> +#include "misc.h"
> +
> +int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
> +				 u64 logical, u64 length, u64 map_type,
> +				 u64 devid, u64 *physical)
> +{
> +	struct btrfs_root *stripe_root = fs_info->stripe_root;
> +	struct btrfs_dp_stripe *raid_stripe;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_key found_key;
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	u64 offset;
> +	u64 found_logical, found_length;
> +	int num_stripes;
> +	int slot;
> +	int ret;
> +	int i;
> +
> +	stripe_key.objectid = logical;
> +	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
> +	stripe_key.offset = length;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	num_stripes = btrfs_bg_type_to_factor(map_type);
> +
> +	ret = btrfs_search_slot_for_read(stripe_root, &stripe_key, path, 0, 0);
> +	if (ret < 0) {
> +		goto out;
> +	}
> +
> +	if (ret == 1)
> +		ret = 0;
> +
> +	while (1) {
> +		leaf = path->nodes[0];
> +		slot = path->slots[0];
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> +		found_logical = found_key.objectid;
> +		found_length = found_key.offset;
> +
> +		if (!in_range(logical, found_logical, found_length))
> +		    goto next;
> +		offset = logical - found_logical;
> +
> +		raid_stripe = btrfs_item_ptr(leaf, slot, struct btrfs_dp_stripe);
> +		for (i = 0; i < num_stripes; i++) {
> +			if (btrfs_stripe_extent_devid_nr(leaf, raid_stripe, i) != devid)
> +				continue;
> +			*physical = btrfs_stripe_extent_offset_nr(leaf, raid_stripe, i) + offset;
> +			goto out;
> +		}
> +next:
> +		ret = btrfs_next_item(stripe_root, path);
> +		if (ret)

This will leak 1 if we don't find a stripe, probably should do EUCLEAN if we
don't have a raid stripe for this?  Thanks,

Josef
