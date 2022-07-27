Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E62583305
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiG0TI5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiG0TIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 15:08:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAFB1120
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 11:45:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B28935C0165;
        Wed, 27 Jul 2022 14:45:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 27 Jul 2022 14:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658947557; x=1659033957; bh=Ni2KuqICsP
        cqhCStz5ez0H7T9D2/ZP9y0IoFuCvIxPw=; b=X1j/VeS8eUMwwo9MeLRNpKVnzT
        ndiATnVQkJGJeKpTiANEQejaXuKlwc0JaUGtoDFs3AzU8fk4vpg5yzeJJJyD+NlV
        pN9awr7qyZRKMS8SviyJvHZPap0QlIn8XtQuIjL2dqd320AmgyvsWOiUdsmrU5Lx
        XM2gDmS6VeNay8of38A6A9ovoPF72xTWZ+qNY00WOVbDPMzLXauronIM2Bl7nl9h
        R675PxvbNN4oHMfeVA4kqraoRYkRouIF3c3E865qMAn03rMe22NOOz7t3mjAaB3k
        nbmXh6GIdfy7Cqla58EciKJtNwzFzMF6nOr03V6F+GXoGiGbxGbn/O8j3QVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658947557; x=1659033957; bh=Ni2KuqICsPcqhCStz5ez0H7T9D2/
        ZP9y0IoFuCvIxPw=; b=2m5Ceu31FkLtR8qPelg5lkUBTh5ySgLxyOOYjon+OiWi
        hpa5e2tYa9NcyKTBxvcvWd21W8QlSnzmb1qbaZPJNhsdIYT/USvhaZX29YFwxaYX
        ISgnALycm2UuYZDlOpG4hx5SVcpDS3T4MjfgvescpDzmHLMB1IwkLphRQIozz/Bk
        Uz69rQ38rO36sTIdaCIh8IhEVAIwSmDcTOqfnvp24ZW95kGCWT1eHH+zjuY4tVGX
        ANcV/MSK9vezryaaZAWfMeXzKAbdYczhGufDbkcVjjHh931SMMZkr3SQ6IdwLgwy
        AGmiSk5Og+lrtJ5NRxnWdgPGPVfc4/dJeOyRVGHmqw==
X-ME-Sender: <xms:5YfhYhm0_0wkxCIQ4jAh6EjFDq9FK6pgrCMLo-4EfYCQyFrR48cwNA>
    <xme:5YfhYs1AsIGWe-95tv-iYINJpe2rBRc4jmZGM7gwg-8fa0iwhyKlfiHlvRhVX7oDu
    9nSa5uGJL5EFLnjNoI>
X-ME-Received: <xmr:5YfhYnodoAzVGiHAQ2Do_z5BFnQZq_wQWzimfyWjQwsB-cvu_ZBEx62feRPFQTqCGa3ESjEozdm39eXMlOhB7BXGhPWE6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnheptddvffdtvdevudeijeetudefuedufeeufefhud
    ejuddtgedttdffffeigfetgfdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:5YfhYhmVA3gDgNb68Eayq2F0hQ1h5ID8o-iRYvTDeXQw118uudZy-A>
    <xmx:5YfhYv21yq6Bc9TvX0MKQBH44nizE2fDCX89tw8NVngZQ_xoet-rZQ>
    <xmx:5YfhYgtn8zfm3D-KXg_BZqFx6d_L2W_KM0k_Gg63rQLbGzVoVps_eA>
    <xmx:5YfhYs-v4UPyJPD-KmdeJLvpJMYkRugB-Cn3PHUDRN13yeuXyQzAAA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Jul 2022 14:45:57 -0400 (EDT)
Date:   Wed, 27 Jul 2022 11:46:14 -0700
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: auto enable discard=async when possible
Message-ID: <YuGH9pOwvW0ttrdc@zen>
References: <20220727150158.GT13489@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727150158.GT13489@suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 05:01:58PM +0200, David Sterba wrote:
> There's a request to automatically enable async discard for capable
> devices. We can do that, the async mode is designed to wait for larger
> freed extents and is not intrusive, with limits to iops, kbps or latency.
> 
> The status and tunables will be exported in /sys/fs/btrfs/FSID/discard .
> 
> The automatic selection is done if there's at least one discard capable
> device in the filesystem (not capable devices are skipped). Mounting
> with any other discard option will honor that option, notably mounting
> with nodiscard will keep it disabled.
> 
> Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/
> Signed-off-by: David Sterba <dsterba@suse.com>
Works for me, on mount and ro mount.
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/disk-io.c | 14 ++++++++++++++
>  fs/btrfs/super.c   |  2 ++
>  fs/btrfs/volumes.c |  3 +++
>  fs/btrfs/volumes.h |  2 ++
>  5 files changed, 22 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4db85b9dc7ed..0a338311f8e2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1503,6 +1503,7 @@ enum {
>  	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
>  	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
>  	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
> +	BTRFS_MOUNT_NODISCARD			= (1UL << 31),
>  };
>  
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3fac429cf8a4..8f8e33219d4d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3767,6 +3767,20 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
>  	}
>  
> +	/*
> +	 * For devices supporting discard turn on discard=async automatically,
> +	 * unless it's already set or disabled. This could be turned off by
> +	 * nodiscard for the same mount.
> +	 */
> +	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
> +	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
> +	      btrfs_test_opt(fs_info, NODISCARD)) &&
> +	    fs_info->fs_devices->discardable) {
> +		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
> +				"auto enabling discard=async");
> +	      btrfs_clear_opt(fs_info->mount_opt, NODISCARD);
> +	}
> +
>  	/*
>  	 * Mount does not set all options immediately, we can do it now and do
>  	 * not have to wait for transaction commit
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4c7089b1681b..1032aaa2c2f4 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -915,12 +915,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  				ret = -EINVAL;
>  				goto out;
>  			}
> +			btrfs_clear_opt(info->mount_opt, NODISCARD);
>  			break;
>  		case Opt_nodiscard:
>  			btrfs_clear_and_info(info, DISCARD_SYNC,
>  					     "turning off discard");
>  			btrfs_clear_and_info(info, DISCARD_ASYNC,
>  					     "turning off async discard");
> +			btrfs_set_opt(info->mount_opt, NODISCARD);
>  			break;
>  		case Opt_space_cache:
>  		case Opt_space_cache_version:
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 272901514b0c..22bfc7806ccb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -639,6 +639,9 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	if (!bdev_nonrot(bdev))
>  		fs_devices->rotating = true;
>  
> +	if (bdev_max_discard_sectors(bdev))
> +		fs_devices->discardable = true;
> +
>  	device->bdev = bdev;
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  	device->mode = flags;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5639961b3626..4c716603449d 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -329,6 +329,8 @@ struct btrfs_fs_devices {
>  	 * nonrot flag set
>  	 */
>  	bool rotating;
> +	/* Devices support TRIM/discard commands */
> +	bool discardable;
>  
>  	struct btrfs_fs_info *fs_info;
>  	/* sysfs kobjects */
> -- 
> 2.36.1
> 
