Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD2752515
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGMO0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGMO0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:26:05 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65E26B6
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:26:02 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b73741a632so603892a34.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689258362; x=1691850362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJEJzUtofvSqq5czKGnuyr+gHlGi41iv6sFFBCD1w0Y=;
        b=lJVIlxHMYOudICyDnNKIgHAz2qYL+WVRcZrBssyRNakMbiNMGfZz9U60Sh6L6SMTq2
         91TJP5sUYrn2hVWL4mLYyon6ef+K47F+hfWj0G0djkUqAJADNXOnLwXVaLjUJg5JhDSl
         ZNIkaIsR2/+3y2OaMLDBnswxrjof8X5X7IvYzc2lO2IniFkqPenGEcj/nMn9u3yrBUvs
         sUV4AwVcGSuiVPkEPhowOnn84WkWbORzCdYIOIMlKJrjltm7ONip8tp4fpP4zxnsxODO
         FP24rYW2/FndW5PwmJjlXmjF//988gh6aB4P7Pa8HmQY5GWgfVwDxBYjSeuB92tJ5qvN
         2KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689258362; x=1691850362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJEJzUtofvSqq5czKGnuyr+gHlGi41iv6sFFBCD1w0Y=;
        b=LrxlY/h++p+XOdQskK0DWbX72Grs4z6Kvkra9Lltc08uby1UQjRN/lRDtxFsa4MaZd
         /jpgC0d955LG0zHc1HFKQTG9OZaenwr5BNE1NFJ52DQACT2sQb2sKLMFlUCoK3I0mRh8
         Sl6KJ/EYs2vo1BszaOYIAJgMZCxayPAs48k8s1LAiyY4W8RKNXEh15xOSWyfEE1dpWjn
         kWdSydc4iaDPcvY2mpwvsEYvyMeChjxNesl5xSI31DSDoDl7ulTO8R0TT8NV4t6cPL74
         OYkw3jK50FGmZKUQBcpioQ/tuv5RtXtwBuEWIXzgsploRiTpepyY7OXvjzhu0dVZDkpy
         Know==
X-Gm-Message-State: ABy/qLbkgCEsPV3r+DdtQERuURPjX+58cdI68M4Dh+mS82A0aGEetTPc
        Nsq7wc/HcJLESUk/McX7moEcbw==
X-Google-Smtp-Source: APBJJlGxrAYx0CMvcjcbkKfNWyIEKI2LDrNwCrlgPkzHIC5v6gA4AJl7lAL/jnRd69Imh8G2mrfDVQ==
X-Received: by 2002:a05:6358:7205:b0:134:ea45:53d7 with SMTP id h5-20020a056358720500b00134ea4553d7mr2467555rwa.26.1689258361935;
        Thu, 13 Jul 2023 07:26:01 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 66-20020a251145000000b00ca6d2ad070csm694055ybr.29.2023.07.13.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:26:01 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:26:00 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 07/18] btrfs: create qgroup earlier in snapshot creation
Message-ID: <20230713142600.GG207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <5aff5ceb6555f8026f414c4de9341c698837820b.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aff5ceb6555f8026f414c4de9341c698837820b.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:44PM -0700, Boris Burkov wrote:
> Pull creating the qgroup earlier in the snapshot. This allows simple
> quotas qgroups to see all the metadata writes related to the snapshot
> being created and to be born with the root node accounted.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/qgroup.c      | 3 +++
>  fs/btrfs/transaction.c | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 75afd8212bc0..8419270f7417 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1670,6 +1670,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  	struct btrfs_qgroup *qgroup;
>  	int ret = 0;
>  
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
> +		return 0;
> +
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
>  		ret = -ENOTCONN;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index f644c7c04d53..2bb5a64f6d84 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1716,6 +1716,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>  	}
>  	btrfs_release_path(path);
>  
> +	ret = btrfs_create_qgroup(trans, objectid);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto fail;
> +	}

Newline please.

How is this ok with normal qgroups?  We weren't creating a qgroup at snapshot
creation time at all it seems, so I don't understand how this is ok for qgroups.
Thanks,

Josef
