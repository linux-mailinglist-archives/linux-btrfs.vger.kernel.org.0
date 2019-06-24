Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B3518D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 18:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfFXQjy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 12:39:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:56448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbfFXQjx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 12:39:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E4A5AE5E;
        Mon, 24 Jun 2019 16:39:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3FFA11E2F23; Mon, 24 Jun 2019 18:39:52 +0200 (CEST)
Date:   Mon, 24 Jun 2019 18:39:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/9] cgroup, blkcg: Prepare some symbols for module and
 !CONFIG_CGROUP usages
Message-ID: <20190624163952.GM32376@quack2.suse.cz>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190615182453.843275-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615182453.843275-2-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 15-06-19 11:24:45, Tejun Heo wrote:
> btrfs is going to use css_put() and wbc helpers to improve cgroup
> writeback support.  Add dummy css_get() definition and export wbc
> helpers to prepare for module and !CONFIG_CGROUP builds.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: kbuild test robot <lkp@intel.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-cgroup.c     | 1 +
>  fs/fs-writeback.c      | 3 +++
>  include/linux/cgroup.h | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 617a2b3f7582..07600d3c9520 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -46,6 +46,7 @@ struct blkcg blkcg_root;
>  EXPORT_SYMBOL_GPL(blkcg_root);
>  
>  struct cgroup_subsys_state * const blkcg_root_css = &blkcg_root.css;
> +EXPORT_SYMBOL_GPL(blkcg_root_css);
>  
>  static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
>  
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 36855c1f8daf..c29cff345b1f 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -269,6 +269,7 @@ void __inode_attach_wb(struct inode *inode, struct page *page)
>  	if (unlikely(cmpxchg(&inode->i_wb, NULL, wb)))
>  		wb_put(wb);
>  }
> +EXPORT_SYMBOL_GPL(__inode_attach_wb);
>  
>  /**
>   * locked_inode_to_wb_and_lock_list - determine a locked inode's wb and lock it
> @@ -580,6 +581,7 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
>  	if (unlikely(wb_dying(wbc->wb)))
>  		inode_switch_wbs(inode, wbc->wb_id);
>  }
> +EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
>  
>  /**
>   * wbc_detach_inode - disassociate wbc from inode and perform foreign detection
> @@ -699,6 +701,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
>  	wb_put(wbc->wb);
>  	wbc->wb = NULL;
>  }
> +EXPORT_SYMBOL_GPL(wbc_detach_inode);
>  
>  /**
>   * wbc_account_io - account IO issued during writeback
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 81f58b4a5418..4cb5d5646986 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -687,6 +687,7 @@ void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
>  struct cgroup_subsys_state;
>  struct cgroup;
>  
> +static inline void css_get(struct cgroup_subsys_state *css) {}
>  static inline void css_put(struct cgroup_subsys_state *css) {}
>  static inline int cgroup_attach_task_all(struct task_struct *from,
>  					 struct task_struct *t) { return 0; }
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
