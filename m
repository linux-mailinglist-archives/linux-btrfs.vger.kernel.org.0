Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636AD75249E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjGMOIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjGMOH7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:07:59 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661031998
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:07:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-576a9507a9bso29582517b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689257276; x=1691849276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kIu4SfuBE/d3wcs+rro93jNJsSbaOfeXjFqPs34PLQ=;
        b=kHgjx8qbgxD2PTBgHT2mR4/qcwE76kM+51JpImEfTacxVqUYuTmYK7vgiMoKE+COAq
         GtRPmDeB+Gzo7sz5IJLuUS2Yaj1zdPl/5DFiCvOr643gTaF1N/VbYEqU37xtfruUuIZo
         V+Iw6FGupJKcBGSPQPaERxI2uwS59eAlUeagPNU1UfbMu7kmtDT51DRXWmWEnGNOnT4P
         UypgmZFqG2WwK8KUw/bp+aCOD/NPw4CxxoljSwYKyFgMj5FFi1aD/H1WjjLEfbPQOxgv
         mYpMUtrOAMfBbBPlOeP4MGgtIUQQNAxXAkqP1f6wbuOXQw8h308UKz3jQrngkvsGkbaW
         j1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257276; x=1691849276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kIu4SfuBE/d3wcs+rro93jNJsSbaOfeXjFqPs34PLQ=;
        b=LbBieuOh0oVBBwB2i1ELZtVn2QHFPXbBZ3Chl7c2WqU6qjyTgtp8kMuFCbTqjuFi4e
         wk0ak1n0cDpTBB7X1AD9PB1sbp4z2/62eub7+bwffRaTqpnOmExWU39D4HNxZwtSaeEK
         R9AalJMVSRPZln44zi72VlJS/U5bJu1oWbMPUjlr3/cPqyrzIo3Oc5kr8aQ3w9lMopvB
         3LyXm3nTn5cd1o7laYPHI1w2NXASFq7QlDNjmDM2WDw4i6z6sSZ2gb9aV4an9ehWi4Sb
         swh7kCzk417EAdwBrd0WhDmceWSzL0ytnOLLNjztEL5nU1VDfgWc0kJYaEKesXwc2Yot
         0lvg==
X-Gm-Message-State: ABy/qLagSerPzPQVSwOVuKLWThotweiEa6J7Q1zI616XJXXirT3DZvme
        Dn5/Pg/AsreOnrl39xwryyFragCurvAJiZaaSBgrmg==
X-Google-Smtp-Source: APBJJlFOrL0u3NWI5P/RaP03mm5ExxLBnfdl8HmWWCAs4znuxAO7Fr+Zx6HwRdmgCEleAvwza+gYFQ==
X-Received: by 2002:a81:83c7:0:b0:56c:f0c7:7d72 with SMTP id t190-20020a8183c7000000b0056cf0c77d72mr1823215ywf.4.1689257276337;
        Thu, 13 Jul 2023 07:07:56 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q64-20020a0de743000000b0054bfc94a10dsm1775710ywe.47.2023.07.13.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:07:55 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:07:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 04/18] btrfs: add new quota mode for simple quotas
Message-ID: <20230713140755.GD207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <668b2472739b712195d9520fdaed205ec7e4ee15.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668b2472739b712195d9520fdaed205ec7e4ee15.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:41PM -0700, Boris Burkov wrote:
> Add a new quota mode called "simple quotas". It can be enabled by the
> existing quota enable ioctl via an unused field, and sets an incompat
> bit, as the implementation of simple quotas will make backwards
> incompatible changes to the disk format of the extent tree.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/delayed-ref.c     |  4 +-
>  fs/btrfs/fs.h              |  5 +--
>  fs/btrfs/ioctl.c           |  2 +-
>  fs/btrfs/qgroup.c          | 88 ++++++++++++++++++++++++++------------
>  fs/btrfs/qgroup.h          |  4 +-
>  fs/btrfs/root-tree.c       |  2 +-
>  fs/btrfs/transaction.c     |  4 +-
>  include/uapi/linux/btrfs.h |  2 +
>  8 files changed, 74 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 6a13cf00218b..a9b938d3a531 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -898,7 +898,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  		return -ENOMEM;
>  	}
>  
> -	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED &&
>  	    !generic_ref->skip_qgroup) {
>  		record = kzalloc(sizeof(*record), GFP_NOFS);
>  		if (!record) {
> @@ -1002,7 +1002,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>  		return -ENOMEM;
>  	}
>  
> -	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED &&
>  	    !generic_ref->skip_qgroup) {
>  		record = kzalloc(sizeof(*record), GFP_NOFS);
>  		if (!record) {
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 203d2a267828..f76f450c2abf 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -218,7 +218,8 @@ enum {
>  	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
>  	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
>  	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
> -	 BTRFS_FEATURE_INCOMPAT_ZONED)
> +	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
> +	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
>  
>  #ifdef CONFIG_BTRFS_DEBUG
>  	/*
> @@ -233,7 +234,6 @@ enum {
>  
>  #define BTRFS_FEATURE_INCOMPAT_SUPP		\
>  	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE)
> -
>  #endif
>  
>  #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
> @@ -790,7 +790,6 @@ struct btrfs_fs_info {
>  	struct lockdep_map btrfs_state_change_map[4];
>  	struct lockdep_map btrfs_trans_pending_ordered_map;
>  	struct lockdep_map btrfs_ordered_extent_map;
> -
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index edbbd5cf23fc..63c1a9258a1b 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3691,7 +3691,7 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
>  
>  	switch (sa->cmd) {
>  	case BTRFS_QUOTA_CTL_ENABLE:
> -		ret = btrfs_quota_enable(fs_info);
> +		ret = btrfs_quota_enable(fs_info, sa);
>  		break;
>  	case BTRFS_QUOTA_CTL_DISABLE:
>  		ret = btrfs_quota_disable(fs_info);
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 2b4473cb77d6..80c1f500b6cc 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2011 STRATO.  All rights reserved.
>   */
>  
> +#include "linux/btrfs.h"
> +#include <linux/btrfs.h>
>  #include <linux/sched.h>
>  #include <linux/pagemap.h>
>  #include <linux/writeback.h>
> @@ -10,7 +12,6 @@
>  #include <linux/rbtree.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> -#include <linux/btrfs.h>
>  #include <linux/sched/mm.h>
>  

Something wonky happened here.

<snip>

>  #include "ctree.h"
> @@ -34,6 +35,8 @@ enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
>  {
>  	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
>  		return BTRFS_QGROUP_MODE_DISABLED;
> +	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))
> +		return BTRFS_QGROUP_MODE_SIMPLE;
>  	return BTRFS_QGROUP_MODE_FULL;
>  }
>  
> @@ -347,6 +350,8 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
>  
>  static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
>  {
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> +		return;
>  	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
>  				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
>  				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
> @@ -368,7 +373,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>  	u64 flags = 0;
>  	u64 rescan_progress = 0;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
>  		return 0;
>  
>  	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
> @@ -419,7 +424,8 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>  				goto out;
>  			}
>  			if (btrfs_qgroup_status_generation(l, ptr) !=
> -			    fs_info->generation) {
> +			    fs_info->generation &&
> +			    btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE) {
>  				qgroup_mark_inconsistent(fs_info);
>  				btrfs_err(fs_info,
>  					"qgroup generation mismatch, marked as inconsistent");
> @@ -557,7 +563,7 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
>  	struct rb_node *node;
>  	bool ret = false;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
>  		return ret;
>  	/*
>  	 * Since we're unmounting, there is no race and no need to grab qgroup
> @@ -956,7 +962,8 @@ static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> -int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
> +int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
> +		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args)
>  {
>  	struct btrfs_root *quota_root;
>  	struct btrfs_root *tree_root = fs_info->tree_root;
> @@ -968,6 +975,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  	struct btrfs_qgroup *qgroup = NULL;
>  	struct btrfs_trans_handle *trans = NULL;
>  	struct ulist *ulist = NULL;
> +	bool simple = quota_ctl_args->status == BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA;

Why are you using status here?  Just use it as a different command.

<snip>

> @@ -3010,11 +3033,10 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  		qgroup_dirty(fs_info, dstgroup);
>  	}
>  
> -	if (srcid) {
> +	if (srcid && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL) {
>  		srcgroup = find_qgroup_rb(fs_info, srcid);
>  		if (!srcgroup)
>  			goto unlock;
> -

Errant change.

<snip>

> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index dbb8b96da50d..1cdabdd92338 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -333,6 +333,7 @@ struct btrfs_ioctl_fs_info_args {
>  #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
>  #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
>  #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
> +#define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 14)
>  
>  struct btrfs_ioctl_feature_flags {
>  	__u64 compat_flags;
> @@ -753,6 +754,7 @@ struct btrfs_ioctl_get_dev_stats {
>  #define BTRFS_QUOTA_CTL_ENABLE	1
>  #define BTRFS_QUOTA_CTL_DISABLE	2
>  #define BTRFS_QUOTA_CTL_RESCAN__NOTUSED	3
> +#define BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA (1UL)
>  struct btrfs_ioctl_quota_ctl_args {
>  	__u64 cmd;
>  	__u64 status;

Yeah this just has cmd and status, and cmd can be whatever we want, so just make
ENABLE_SIMPLE_QUOTA 4 and use it in cmd.  Thanks,

Josef
