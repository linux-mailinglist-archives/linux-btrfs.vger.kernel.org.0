Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205D4752546
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGMOfL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjGMOfK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:35:10 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3B213F
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:34:56 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-56fff21c2ebso7031387b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689258896; x=1691850896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfmpHp4KfQoiYSY1O86PRQFnqtkf0pqP4upRc+EIwgo=;
        b=anH0D66T1y4DG7kclbShL5BOTVa+xGqxxnPxISXSvTS+Ir1Ho9tALRjkqUQIX6zJxp
         4fLxJFJbpT/1r5YrADIJ6jl2dmmngd4iT6Wcz0d4M8SghhFnNaXKMisgKJATIR0uqgTa
         0Ydtf3tWBQfdET2zKSAL+tTTDRmE/3h5CpvvX5v5ds5l4VK5CGNQ/wx+sYoJ97kKZI0B
         cZyLB2uXxj5gavSopbeSVEXwtIklHoyOAYzqDWnfSqyusHUMRu5pcwFQqhYmtRh6ISJr
         2+NyV+xIqCCnvoX7OixOPrJ6fHNx0i5dtB47UXS8VLC7Tgt8CvalCbxysXZ+dHTZJkxG
         xKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689258896; x=1691850896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfmpHp4KfQoiYSY1O86PRQFnqtkf0pqP4upRc+EIwgo=;
        b=kMTzw9259cmXLyXli0vt6O9U+HzrAgoqBfuy6WyXAFZbGV4jmGlsRINb5v+XdWOm7V
         quRytB7E/GZVbkmLXheAuKAH13xh+ENoLD4PhqyW4P/JomTHR+egJfhimvPk7IorBIYz
         yL4sFDkyk56UTCk/nqIBJpDcavu7SCjPsUcVgwhFpXD7BLC3Oo4wVH+qp0Z/q2k7bHks
         yXh/rJ8xbx29MoxXVIZNJZi9YQYDap2kOCzJ6muyiFvZ8Tn5tK6xlAa6+c66MAOlMuA9
         V9WVbX9dPfBBq/7EsfSQEQYCUjgH/2/lagXu6PANb8IuNTPRgtyTSpf2rYJ9lMb656v2
         uYyg==
X-Gm-Message-State: ABy/qLY9mOJWIOYmMEUN+crEAzKD0iZDxlE1HAOvk5AQuchstC3ryX/M
        Tetajq6wfHCU4iiSGTmT0XI6K4FWmrh0t67ZDBlO0g==
X-Google-Smtp-Source: APBJJlEkhhl0gEG6x0tZKeXr43VBb9CLBlesfwzhBqqFKyYeqI4aRYkamx6J7e3EOi0C2XvPmb3QQw==
X-Received: by 2002:a81:5b57:0:b0:55d:a9d7:521e with SMTP id p84-20020a815b57000000b0055da9d7521emr2078015ywb.18.1689258895760;
        Thu, 13 Jul 2023 07:34:55 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s7-20020a81bf47000000b005773e0ee56bsm1769147ywk.77.2023.07.13.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:34:55 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:34:54 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 08/18] btrfs: function for recording simple quota deltas
Message-ID: <20230713143454.GH207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <17e93036e598545781cb13376abb868dc22d51b2.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e93036e598545781cb13376abb868dc22d51b2.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:45PM -0700, Boris Burkov wrote:
> Rather than re-computing shared/exclusive ownership based on backrefs
> and walking roots for implicit backrefs, simple quotas does an increment
> when creating an extent and a decrement when deleting it. Add the API
> for the extent item code to use to track those events.
> 
> Also add a helper function to make collecting parent qgroups in a ulist
> easier for functions like this.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/qgroup.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/qgroup.h | 11 ++++++-
>  2 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 8419270f7417..97c00697b475 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -333,6 +333,44 @@ static int del_relation_rb(struct btrfs_fs_info *fs_info,
>  	return -ENOENT;
>  }
>  
> +static int qgroup_collect_parents(struct btrfs_qgroup *qgroup,
> +				  struct ulist *ul)
> +{
> +	struct ulist_iterator uiter;
> +	struct ulist_node *unode;
> +	struct btrfs_qgroup_list *glist;
> +	struct btrfs_qgroup *qg;
> +	bool err_free = false;
> +	int ret = 0;
> +
> +	if (!ul) {
> +		ul = ulist_alloc(GFP_KERNEL);
> +		err_free = true;
> +	} else {
> +		ulist_reinit(ul);
> +	}

You're calling this under a spin_lock, so GFP_KERNEL isn't allowed here.
Additionally it doesn't seem like you ever call it with a NULL ulist, so
probably just get rid of the above.

> +
> +	ret = ulist_add(ul, qgroup->qgroupid,
> +			qgroup_to_aux(qgroup), GFP_ATOMIC);

We're going to hit ENOMEM in production here, we used to hit it all the time
with the extent state stuff.  How will this affect us?  Will it screw up
accounting?  If so we need to figure out a way to back up out of the lock and
pre-allocate a node to use in this case.

> +	if (ret < 0)
> +		goto out;
> +	ULIST_ITER_INIT(&uiter);
> +	while ((unode = ulist_next(ul, &uiter))) {
> +		qg = unode_aux_to_qgroup(unode);
> +		list_for_each_entry(glist, &qg->groups, next_group) {
> +			ret = ulist_add(ul, glist->group->qgroupid,
> +					qgroup_to_aux(glist->group), GFP_ATOMIC);
> +			if (ret < 0)
> +				goto out;
> +		}
> +	}
> +	ret = 0;
> +out:
> +	if (ret && err_free)
> +		ulist_free(ul);
> +	return ret;
> +}
> +
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
>  			       u64 rfer, u64 excl)
> @@ -4531,3 +4569,47 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
>  		kfree(entry);
>  	}
>  }
> +
> +int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
> +				    struct btrfs_simple_quota_delta *delta)
> +{
> +	int ret;
> +	struct ulist *ul = fs_info->qgroup_ulist;

This isn't NULL if we're enabled right?  Thanks,

Josef
