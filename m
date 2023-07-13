Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E467529DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjGMR2p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjGMR2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 13:28:35 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8613C30F4
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:28:24 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57722942374so9425597b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689269304; x=1691861304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1uUeYNv+gyY7SnrdL3AriOY1Wk9+kqnLY27NTztCjs=;
        b=U3MQDv3KABlR/ssJlnLwgSgVfGqgyELVjo40xyuJSOguk3boPMu7i1F0wneck7zlyQ
         Txif1pNpVJ52aMkV0b36bNY31Zl3j+XbRDxGkqjNnRY1xHzBDNuSrz6bb7zyJIuLVFgc
         NiYmSBxAZsjxr71ViJM725vCjYon4iPD1c1KTCEN6TAZBVS7ieRw0XLQ//zAcTbXSxlH
         AqYAQyDjsrLCtD6rhRnH/R1oBopijereqlalQY9TG9P9L3As0/cgRQvUeaE5ykPcv4Aq
         qCPpH4SckeX6+0avkKyq2OMx/0fA0+YncdF5hnG/4FnxN4eiEWUKssyQa9gggVrMexyS
         h9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269304; x=1691861304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1uUeYNv+gyY7SnrdL3AriOY1Wk9+kqnLY27NTztCjs=;
        b=C84YWa6XhW3nvGeh8psexr8nDuWTZUJhloU+rtqI+6SrPD2OhW04M3qRYBRo6HIKrJ
         ag1S6DLP2FhLQgWe/haU2t7GC4SLYbmyvUnJ3lSUETTDD48uokM+okUeFo4jV+2YIB/w
         IZ1BbQnOGMMAIz/2JkVqC+DLcV6tBjiRnYDD6QuuVb8b64MCt4qjiq3/ifprOdYuUiUt
         MiXS/2kScNDROCudvkzhRUNI9XJ/oCRqmcoCs1Coa2EhgmQ4MOsAm2DIdwcKNUDXlFGu
         Jo39rUyDMro+OczRXQsVNrhpNmSDq66Gnnyvm9XfnlLQPacyVmBeREw2l2DPexM09+TU
         Rz0w==
X-Gm-Message-State: ABy/qLY08pu5DCCBrlHMaVVTtQlUC1Lb5cevdjqTbW25W/XdXZHe+CHt
        oPgy0h9KaTc2CBWURosJgRHkGw==
X-Google-Smtp-Source: APBJJlHB/DhawaZJ+xmUf7coilsef0qQhmPOs11AfsYrUfgW1uNu5unvC/SAyQ4nRv6CzXjXanKMsw==
X-Received: by 2002:a0d:d6d0:0:b0:56f:f504:770b with SMTP id y199-20020a0dd6d0000000b0056ff504770bmr2232390ywd.37.1689269303518;
        Thu, 13 Jul 2023 10:28:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t16-20020a818310000000b0057a560a9832sm1876365ywf.1.2023.07.13.10.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:28:23 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:28:22 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 15/18] btrfs: simple quota auto hierarchy for nested
 subvols
Message-ID: <20230713172822.GO207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <140f5eca28de807b8334471d91f31863ce9e1aca.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <140f5eca28de807b8334471d91f31863ce9e1aca.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:52PM -0700, Boris Burkov wrote:
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
>  fs/btrfs/qgroup.c      | 46 +++++++++++++++++++++++++++++++++++++++---
>  fs/btrfs/qgroup.h      |  6 +++---
>  fs/btrfs/transaction.c | 13 ++++++++----
>  4 files changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 63c1a9258a1b..23f5142ef18b 100644
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
> index 97c00697b475..6714c5aeb4e1 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1557,8 +1557,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
> -			      u64 dst)
> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_qgroup *parent;
> @@ -2998,6 +2997,42 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
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
> +	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
> +		++num_qgroups;
> +	}

You can simplify this with

num_qgroups = list_count_nodes(&inode_qg->groups);

Thanks,

Josef
