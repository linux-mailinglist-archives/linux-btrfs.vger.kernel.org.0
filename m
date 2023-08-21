Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C186782FFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjHUSKX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjHUSKW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:10:22 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB5610E
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:10:21 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7766072ba4so852486276.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692641420; x=1693246220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FmxA3slOYbWuGOVt3j5MQuYjwDa9WPabh14JbGnRaQ=;
        b=Zpj1MraBGJ9dcvLz1gFT4JVs7WwVm57ODlLnajAe5BaEZKjuO6/8OlIyD5XBq3Pr+g
         r+jPe81uawcml9CPeCYood13R4PcDyE3FdUw3YLcrcNORrbOegQMPyex069/wuFeGqnd
         bLhKOINULkIgiaV93xCOBfovAvBEpkrEctzKU5cPnOox951/qSibV2hCoxY4LBKWqLYa
         IZa21aVa2z6PI48J2XRmO5cz+7BYCv/gfirJ2jGsxhG6vkKIthS4z2s+2VaWCsPQr4S0
         Kbbup++A4TiPmwA2AXF7VJ0tIevXOMYOfMm4kbOj8C9+IFbETfui2JC8PVxkscXPA9cC
         PPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641420; x=1693246220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FmxA3slOYbWuGOVt3j5MQuYjwDa9WPabh14JbGnRaQ=;
        b=hprlu3lt47Jh5e5RIc9EVGsDsu3VjI5F5lG8RBWv9//akiMbhnCgxM5L5Q87sPslVC
         2iCrihI0ObYN5rYZvltrosHhdcECNVpCt8U31C5w4h02klQojIb8XyKAAg4TVK8NAC2V
         FQnAdiWgzelO9/aPT/0Uhl/aqyFM3MiImNMkTtjZeaVbooJOviyd61s7Z8Un0eBeV//d
         CMKEB1j4TWd1o4mkDVc+CZzis830Dyd48BZddgAOeocZiv3X2vtjGAym4i3QBDY5mHom
         yrhFZhHMIM1j11ICql4YGFXsPcotVocw42PVEwO1O+PxWlw+sPfPD9Tj693qqw4UcADL
         MJuA==
X-Gm-Message-State: AOJu0YyDsGMjrg4Lp3ndHIBt5WJUQ2fXkjsmHHrYS2QwN+OajbfTG+IF
        XcNy9MfHKj4EWedpxegFGQfoS6scRxLWjooyQpc=
X-Google-Smtp-Source: AGHT+IF7Y5zAYdpID/AN/o2ndm269xRDfrI0jTFzVPVQ62Tzl6yGN1APEPLKD5sV8TU6j9+tpHy5dA==
X-Received: by 2002:a25:b189:0:b0:d61:44f9:5d1e with SMTP id h9-20020a25b189000000b00d6144f95d1emr6104798ybj.12.1692641420397;
        Mon, 21 Aug 2023 11:10:20 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y11-20020a2586cb000000b00d20d4ffbbdbsm1891010ybm.0.2023.08.21.11.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:10:20 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:10:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 14/18] btrfs: simple quota auto hierarchy for nested
 subvols
Message-ID: <20230821181019.GJ2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <0e445145d0faff95d0c42e5ebac222d838bb0293.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e445145d0faff95d0c42e5ebac222d838bb0293.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:13:01PM -0700, Boris Burkov wrote:
> Consider the following sequence:
> - enable quotas
> - create subvol S id 256 at dir outer/
> - create a qgroup 1/100
> - add 0/256 (S's auto qgroup) to 1/100
> - create subvol T id 257 at dir outer/inner/
> 
> With full qgroups, there is no relationship between 0/257 and either of
> 0/256 or 1/100. There is an inherit feature that the creator of inner/
> can use to specify it ought to be in 1/100.
> 
> Simple quotas are targeted at container isolation, where such automatic
> inheritance for not necessarily trusted/controlled nested subvol
> creation would be quite helpful. Therefore, add a new default behavior
> for simple quotas: when you create a nested subvol, automatically
> inherit as parents any parents of the qgroup of the subvol the new inode
> is going in.
> 
> In our example, 257/0 would also be under 1/100, allowing easy control
> of a total quota over an arbitrary hierarchy of subvolumes.
> 
> I think this _might_ be a generally useful behavior, so it could be
> interesting to put it behind a new inheritance flag that simple quotas
> always use while traditional quotas let the user specify, but this is a
> minimally intrusive change to start.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ioctl.c       |  2 +-
>  fs/btrfs/qgroup.c      | 44 +++++++++++++++++++++++++++++++++++++++---
>  fs/btrfs/qgroup.h      |  6 +++---
>  fs/btrfs/transaction.c | 13 +++++++++----
>  4 files changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9b61bc62e439..c9b069077fd0 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -652,7 +652,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>  	/* Tree log can't currently deal with an inode which is a new root. */
>  	btrfs_set_log_full_commit(trans);
>  
> -	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
> +	ret = btrfs_qgroup_inherit(trans, 0, objectid, root->root_key.objectid, inherit);
>  	if (ret)
>  		goto out;
>  
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index dedc532669f4..58e9ed0deedd 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1550,8 +1550,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
> -			      u64 dst)
> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_qgroup *parent;
> @@ -2991,6 +2990,40 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>  	return ret;
>  }
>  
> +static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
> +			       u64 inode_rootid,
> +			       struct btrfs_qgroup_inherit **inherit)
> +{
> +	int i = 0;
> +	u64 num_qgroups = 0;
> +	struct btrfs_qgroup *inode_qg;
> +	struct btrfs_qgroup_list *qg_list;
> +
> +	if (*inherit)
> +		return -EEXIST;
> +
> +	inode_qg = find_qgroup_rb(fs_info, inode_rootid);
> +	if (!inode_qg)
> +		return -ENOENT;
> +
> +	num_qgroups = list_count_nodes(&inode_qg->groups);
> +
> +	if (!num_qgroups)
> +		return 0;
> +
> +	*inherit = kzalloc(sizeof(**inherit) + num_qgroups * sizeof(u64), GFP_NOFS);
> +	if (!*inherit)
> +		return -ENOMEM;
> +	(*inherit)->num_qgroups = num_qgroups;
> +
> +	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
> +		u64 qg_id = qg_list->group->qgroupid;
> +		*((u64 *)((*inherit)+1) + i) = qg_id;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Copy the accounting information between qgroups. This is necessary
>   * when a snapshot or a subvolume is created. Throwing an error will
> @@ -2998,7 +3031,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>   * when a readonly fs is a reasonable outcome.
>   */
>  int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> -			 u64 objectid, struct btrfs_qgroup_inherit *inherit)
> +			 u64 objectid, u64 inode_rootid,
> +			 struct btrfs_qgroup_inherit *inherit)
>  {
>  	int ret = 0;
>  	int i;
> @@ -3040,6 +3074,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  		goto out;
>  	}
>  
> +	if (!inherit && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> +		qgroup_auto_inherit(fs_info, inode_rootid, &inherit);
> +
>  	if (inherit) {
>  		i_qgroups = (u64 *)(inherit + 1);
>  		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
> @@ -3066,6 +3103,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  	if (ret)
>  		goto out;
>  
> +

Extraneous whitespace change.  Once fixed you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
