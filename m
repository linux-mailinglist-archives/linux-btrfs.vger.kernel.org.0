Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B82339C8C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Mar 2021 08:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhCMH0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Mar 2021 02:26:46 -0500
Received: from out20-61.mail.aliyun.com ([115.124.20.61]:38090 "EHLO
        out20-61.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMH0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Mar 2021 02:26:36 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04487189|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.044086-0.00226411-0.95365;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JkPmWs2_1615620393;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JkPmWs2_1615620393)
          by smtp.aliyun-inc.com(10.147.42.16);
          Sat, 13 Mar 2021 15:26:33 +0800
Date:   Sat, 13 Mar 2021 15:26:37 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org
Subject: Re: [PATCH 5/9] btrfs: use a bit to track the existence of tree mod log users
Cc:     linux-btrfs@vger.kernel.org, ce3g8jdj@umail.furryterror.org,
        Filipe Manana <fdmanana@suse.com>
In-Reply-To: <08ccdf842ceb0e05bccbdd087b9ef48efc4144db.1615472583.git.fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com> <08ccdf842ceb0e05bccbdd087b9ef48efc4144db.1615472583.git.fdmanana@suse.com>
Message-Id: <20210313152637.1D83.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

It will be more easy to backport for heavy i/o load if we put this patch
before '[PATCH 3/9] btrfs: move the tree mod log code into its own file' ?

And this patch can be merged into one with the following 
'[PATCH 6/9] btrfs: use the new bit BTRFS_FS_TREE_MOD_LOG_USERS at btrfs_free_tree_block()'?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/03/13

> From: Filipe Manana <fdmanana@suse.com>
> 
> The tree modification log functions are called very frequently, basically
> they are called everytime a btree is modified (a pointer added or removed
> to a node, a new root for a btree is set, etc). Because of that, to avoid
> heavy lock contention on the lock that protects the list of tree mod log
> users, we have checks that test the emptiness of the list with a full
> memory barrier before the checks, so that when there are no tree mod log
> users we avoid taking the lock.
> 
> Replace the memory barrier and list emptiness check with a test for a new
> bit set at fs_info->flags. This bit is used to indicate when there are
> tree mod log users, set whenever a user is added to the list and cleared
> when the last user is removed from the list. This makes the intention a
> bit more obvious and possibly more efficient (assuming test_bit() may be
> cheaper than a full memory barrier on some architectures).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ctree.h        |  3 +++
>  fs/btrfs/tree-mod-log.c | 11 ++++++-----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 50208673bd55..90184ee2f832 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -580,6 +580,9 @@ enum {
>  
>  	/* Indicate that we can't trust the free space tree for caching yet */
>  	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
> +
> +	/* Indicate whether there are any tree modification log users. */
> +	BTRFS_FS_TREE_MOD_LOG_USERS,
>  };
>  
>  /*
> diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> index f2a6da1b2903..b912b82c36c9 100644
> --- a/fs/btrfs/tree-mod-log.c
> +++ b/fs/btrfs/tree-mod-log.c
> @@ -60,6 +60,7 @@ u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
>  	if (!elem->seq) {
>  		elem->seq = btrfs_inc_tree_mod_seq(fs_info);
>  		list_add_tail(&elem->list, &fs_info->tree_mod_seq_list);
> +		set_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags);
>  	}
>  	write_unlock(&fs_info->tree_mod_log_lock);
>  
> @@ -83,7 +84,9 @@ void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
>  	list_del(&elem->list);
>  	elem->seq = 0;
>  
> -	if (!list_empty(&fs_info->tree_mod_seq_list)) {
> +	if (list_empty(&fs_info->tree_mod_seq_list)) {
> +		clear_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags);
> +	} else {
>  		struct btrfs_seq_list *first;
>  
>  		first = list_first_entry(&fs_info->tree_mod_seq_list,
> @@ -166,8 +169,7 @@ static noinline int tree_mod_log_insert(struct btrfs_fs_info *fs_info,
>  static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
>  				    struct extent_buffer *eb)
>  {
> -	smp_mb();
> -	if (list_empty(&(fs_info)->tree_mod_seq_list))
> +	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
>  		return true;
>  	if (eb && btrfs_header_level(eb) == 0)
>  		return true;
> @@ -185,8 +187,7 @@ static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
>  static inline bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
>  				    struct extent_buffer *eb)
>  {
> -	smp_mb();
> -	if (list_empty(&(fs_info)->tree_mod_seq_list))
> +	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
>  		return false;
>  	if (eb && btrfs_header_level(eb) == 0)
>  		return false;
> -- 
> 2.28.0


