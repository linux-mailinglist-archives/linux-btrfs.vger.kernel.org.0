Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFC1C8702
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 13:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfJBLJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 07:09:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:47584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfJBLJp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 07:09:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AE37AF3B;
        Wed,  2 Oct 2019 11:09:42 +0000 (UTC)
Subject: Re: [PATCH 3/3] btrfs: add __pure attribute to functions
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1569587835.git.dsterba@suse.com>
 <faadfd67d10404a342d91a910e40fc2d0f5f4e6c.1569587835.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b6c85e60-dff8-4495-0914-e7aa05a0d9ab@suse.com>
Date:   Wed, 2 Oct 2019 14:09:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <faadfd67d10404a342d91a910e40fc2d0f5f4e6c.1569587835.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1.10.19 г. 20:57 ч., David Sterba wrote:
> The attribute is more relaxed than const and the functions could
> dereference pointers, as long as the observable state is not changed. We
> do have such functions, based on -Wsuggest-attribute=pure .
> 
> The visible effects of this patch are negligible, there are differences
> in the assembly but hard to summarize.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

one remark: I'm not sure the attribute needs to be duplicated in the
declaration and definition.

> ---
>  fs/btrfs/async-thread.c | 6 ++----
>  fs/btrfs/async-thread.h | 4 ++--
>  fs/btrfs/ctree.c        | 2 +-
>  fs/btrfs/ctree.h        | 4 ++--
>  fs/btrfs/dev-replace.c  | 2 +-
>  fs/btrfs/dev-replace.h  | 2 +-
>  fs/btrfs/ioctl.c        | 2 +-
>  fs/btrfs/space-info.c   | 2 +-
>  fs/btrfs/space-info.h   | 2 +-
>  9 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index b97ae1b03417..1d32a07bb2d1 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -53,14 +53,12 @@ struct btrfs_workqueue {
>  	struct __btrfs_workqueue *high;
>  };
>  
> -struct btrfs_fs_info *
> -btrfs_workqueue_owner(const struct __btrfs_workqueue *wq)
> +struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct __btrfs_workqueue *wq)
>  {
>  	return wq->fs_info;
>  }
>  
> -struct btrfs_fs_info *
> -btrfs_work_owner(const struct btrfs_work *work)
> +struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work)
>  {
>  	return work->wq->fs_info;
>  }
> diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
> index c5bf2b117c05..a4434301d84d 100644
> --- a/fs/btrfs/async-thread.h
> +++ b/fs/btrfs/async-thread.h
> @@ -41,8 +41,8 @@ void btrfs_queue_work(struct btrfs_workqueue *wq,
>  void btrfs_destroy_workqueue(struct btrfs_workqueue *wq);
>  void btrfs_workqueue_set_max(struct btrfs_workqueue *wq, int max);
>  void btrfs_set_work_high_priority(struct btrfs_work *work);
> -struct btrfs_fs_info *btrfs_work_owner(const struct btrfs_work *work);
> -struct btrfs_fs_info *btrfs_workqueue_owner(const struct __btrfs_workqueue *wq);
> +struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work);
> +struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct __btrfs_workqueue *wq);
>  bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq);
>  
>  #endif
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index f2f9cf1149a4..3a4d8e27e565 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1538,7 +1538,7 @@ static int comp_keys(const struct btrfs_disk_key *disk,
>  /*
>   * same as comp_keys only with two btrfs_key's
>   */
> -int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2)
> +int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2)
>  {
>  	if (k1->objectid > k2->objectid)
>  		return 1;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 793085770c84..df0f2de69991 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2511,7 +2511,7 @@ void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
>  /* ctree.c */
>  int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
>  		     int level, int *slot);
> -int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
> +int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
>  int btrfs_previous_item(struct btrfs_root *root,
>  			struct btrfs_path *path, u64 min_objectid,
>  			int type);
> @@ -2912,7 +2912,7 @@ long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>  long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>  int btrfs_ioctl_get_supported_features(void __user *arg);
>  void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
> -int btrfs_is_empty_uuid(u8 *uuid);
> +int __pure btrfs_is_empty_uuid(u8 *uuid);
>  int btrfs_defrag_file(struct inode *inode, struct file *file,
>  		      struct btrfs_ioctl_defrag_range_args *range,
>  		      u64 newer_than, unsigned long max_pages);
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 48890826b5e6..f639dde2a679 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -986,7 +986,7 @@ static int btrfs_dev_replace_kthread(void *data)
>  	return 0;
>  }
>  
> -int btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
> +int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
>  {
>  	if (!dev_replace->is_valid)
>  		return 0;
> diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
> index 78c5d8f1adda..60b70dacc299 100644
> --- a/fs/btrfs/dev-replace.h
> +++ b/fs/btrfs/dev-replace.h
> @@ -17,6 +17,6 @@ void btrfs_dev_replace_status(struct btrfs_fs_info *fs_info,
>  int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info);
>  void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info);
>  int btrfs_resume_dev_replace_async(struct btrfs_fs_info *fs_info);
> -int btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
> +int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
>  
>  #endif
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index de730e56d3f5..55b41d5e7ea9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -541,7 +541,7 @@ static noinline int btrfs_ioctl_fitrim(struct file *file, void __user *arg)
>  	return 0;
>  }
>  
> -int btrfs_is_empty_uuid(u8 *uuid)
> +int __pure btrfs_is_empty_uuid(u8 *uuid)
>  {
>  	int i;
>  
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 98dc092a905e..f32993efbf61 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -10,7 +10,7 @@
>  #include "transaction.h"
>  #include "block-group.h"
>  
> -u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
> +u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
>  			  bool may_use_included)
>  {
>  	ASSERT(s_info);
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 8867e84aa33d..2d8c811a9792 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -116,7 +116,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
>  			     struct btrfs_space_info **space_info);
>  struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
>  					       u64 flags);
> -u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
> +u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
>  			  bool may_use_included);
>  void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
>  void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
> 
