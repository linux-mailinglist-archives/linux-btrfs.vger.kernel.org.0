Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3F618BB13
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCSP1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:27:21 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36860 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgCSP1V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:27:21 -0400
Received: by mail-qv1-f65.google.com with SMTP id z13so1211089qvw.3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7vBWFthsp3Ic0lvkNEP0SRd4PwbNG9lqSyuyhiDNvcU=;
        b=eiEmPs6wi7W+oTSU+RkpJr87Gu1clpWW+hU82lhZ7V5563p3E6m10AR3IyEVIHcIHL
         UHg5f2OENBvyGYIvdbDlKfmL7yGyjk/lwY4HkUfDaWL4htaVxGO0wuGsAVSGU9sVXAHz
         4qZ3chdcWWl3aDAMrd4sx6DWefXxggL9YYK7Pkg9SwPYZtYkK4HS5Z0xg+maqWBs9UJc
         LX/ycp71mXTb3yvB/KxOaAEr/EB8N7zAD2W8Gb5pVw10Ty6dBpdYK658ICZ+mO/mdWx2
         XOYrvwMs7Rt+rZOqvfF4DK3P3FkZEcZVtvVS+q2gMrJw0BK854Wc4hunizur60iqwzoJ
         2Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7vBWFthsp3Ic0lvkNEP0SRd4PwbNG9lqSyuyhiDNvcU=;
        b=XB0KUJbFWmE7WoPRERG/5fstEDNRetkLY6kqUj8sNaph7ByPnr6QjFQ5KPzH5G0qsn
         WWwErrVL5VNOxcXNOlgeE2jC8yECc7ZwA3Nd8UfAg/NuI46j+cI6LP6pM6iwhzACCrc4
         3MTE8b/MK5spsgcicF8itoG7Gt55ilZA3m35vjwcERRAiF9dKPtXMGQWNOnSzd7FDwEJ
         nLMXpKHRXOlI6YwfjGyXWMdmeTrJcMHRMaDorT93j3K9kpwKLT0AhoMT1HYN37//7Sps
         8iQ7kkcumv1mL25FcUzMlPprPv3WeYFMEIUQ7H9/5MX5iuyVUz/KFESIhp4UDqoxFScB
         rZtw==
X-Gm-Message-State: ANhLgQ1qmeL2txX69SoebsYVMeWOo9/i2T46xjJnlqwcYKXtsyRaUfKJ
        6JDJ3B9DrXj2Xa1Hy7WuQqhyg2IVgp8=
X-Google-Smtp-Source: ADFU+vulTNmb0oAGU6RKb4+B77wxpAQHgLOZhOAPFMrIOOGY0C6sGuEyoXrxq3SBKKAd0yME9YenKw==
X-Received: by 2002:a05:6214:138a:: with SMTP id g10mr3535286qvz.231.1584631637676;
        Thu, 19 Mar 2020 08:27:17 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z9sm1783542qtu.20.2020.03.19.08.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:27:16 -0700 (PDT)
Subject: Re: [PATCH RFC 07/39] btrfs: relocation: Make reloc root search
 specific for relocation backref cache
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-8-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cd579196-b799-49fe-03d4-6319c9c375b6@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:27:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> find_reloc_root() searches reloc_control::reloc_root_tree to find the
> reloc root.
> This behavior is only useful for relocation backref cache.
> 
> For the incoming more generic purposed backref cache, we don't care
> about who owns the reloc root, but only care if it's a reloc root.
> 
> So this patch makes the following modifications to make the reloc root
> search more specific to relocation backref:
> - Add backref_node::is_reloc_root
>    This will be an extra indicator for generic purposed backref cache.
>    User doesn't need to read root key from backref_node::root to
>    determine if it's a reloc root.
>    Also for reloc tree root, it's useless and will be queued to useless
>    list.
> 
> - Add backref_cache::is_reloc
>    This will allow backref cache code to do different behavior for
>    generic purposed backref cache and relocation backref cache.
> 
> - Make find_reloc_root() to accept fs_info
>    Just a personal taste.
> 
> - Export find_reloc_root()
>    So backref.c can utilize this function.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ctree.h      |  2 ++
>   fs/btrfs/relocation.c | 50 +++++++++++++++++++++++++++++++++----------
>   2 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index ea5d0675465a..b57bb3e5f1f2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3381,6 +3381,8 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
>   			      u64 *bytes_to_reserve);
>   int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
>   			      struct btrfs_pending_snapshot *pending);
> +struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
> +				   u64 bytenr);
>   
>   /* scrub.c */
>   int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 560a144d5b95..37d102564e72 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -121,6 +121,12 @@ struct backref_node {
>   	 * backref node.
>   	 */
>   	unsigned int detached:1;
> +
> +	/*
> +	 * For generic purpose backref cache, where we only care if it's a reloc
> +	 * root, doesn't care the source subvolid.
> +	 */
> +	unsigned int is_reloc_root:1;
>   };
>   
>   /*
> @@ -165,6 +171,14 @@ struct backref_cache {
>   	struct list_head useless_node;
>   
>   	struct btrfs_fs_info *fs_info;
> +
> +	/*
> +	 * Whether this cache is for relocation
> +	 *
> +	 * Reloction backref cache require more info for reloc root compared
> +	 * to generic backref cache.
> +	 */
> +	unsigned int is_reloc;
>   };
>   
>   /*
> @@ -267,7 +281,7 @@ static void mapping_tree_init(struct mapping_tree *tree)
>   }
>   
>   static void backref_cache_init(struct btrfs_fs_info *fs_info,
> -			       struct backref_cache *cache)
> +			       struct backref_cache *cache, int is_reloc)
>   {
>   	int i;
>   	cache->rb_root = RB_ROOT;
> @@ -279,6 +293,7 @@ static void backref_cache_init(struct btrfs_fs_info *fs_info,
>   	INIT_LIST_HEAD(&cache->pending_edge);
>   	INIT_LIST_HEAD(&cache->useless_node);
>   	cache->fs_info = fs_info;
> +	cache->is_reloc = is_reloc;
>   }
>   
>   static void backref_cache_cleanup(struct backref_cache *cache)
> @@ -651,13 +666,14 @@ static int should_ignore_root(struct btrfs_root *root)
>   /*
>    * find reloc tree by address of tree root
>    */
> -static struct btrfs_root *find_reloc_root(struct reloc_control *rc,
> -					  u64 bytenr)
> +struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr)
>   {
> +	struct reloc_control *rc = fs_info->reloc_ctl;
>   	struct rb_node *rb_node;
>   	struct mapping_node *node;
>   	struct btrfs_root *root = NULL;
>   
> +	ASSERT(rc);
>   	spin_lock(&rc->reloc_root_tree.lock);
>   	rb_node = tree_search(&rc->reloc_root_tree.rb_root, bytenr);
>   	if (rb_node) {
> @@ -701,6 +717,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>   {
>   	struct btrfs_backref_iter *iter;
>   	struct backref_cache *cache = &rc->backref_cache;
> +	struct btrfs_fs_info *fs_info = cache->fs_info;
>   	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
>   	struct btrfs_root *root;
>   	struct backref_node *cur;
> @@ -823,13 +840,24 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>   		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
>   		if (key.type == BTRFS_SHARED_BLOCK_REF_KEY) {
>   			if (key.objectid == key.offset) {
> -				/*
> -				 * Only root blocks of reloc trees use backref
> -				 * pointing to itself.
> -				 */
> -				root = find_reloc_root(rc, cur->bytenr);
> -				ASSERT(root);
> -				cur->root = root;
> +				cur->is_reloc_root = 1;
> +				/* Only reloc backref cache cares exact root */
> +				if (cache->is_reloc) {
> +					root = find_reloc_root(fs_info,
> +							cur->bytenr);
> +					if (WARN_ON(!root)) {
> +						err = -ENOENT;
> +						goto out;
> +					}
> +					cur->root = root;
> +				} else {
> +					/*
> +					 * For generic purpose backref cache,
> +					 * reloc root node is useless.
> +					 */
> +					list_add(&cur->list,
> +						&cache->useless_node);
> +				}

Can we clean this up?  Maybe something like

if (!cache->is_reloc) {
	list_add(&cur->list, &cache->useless_node);
	break;
}
root = find_reloc_root(fs_info, cur_bytenr);

We're so deeply nested at this point we're getting scrunched up.  Thanks,

Josef
