Return-Path: <linux-btrfs+bounces-16040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BBFB23C4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 01:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD577AE2C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A7E2E06D2;
	Tue, 12 Aug 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gudRrYLm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C778F2E2841
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755041427; cv=none; b=ERBD7ABJQnYjdnnI3jGQk852l53bmZu+C7AYNyaZq5RtKB7Wq7aGT7SI1uPIlVduNNfMmVCfcJNuwA5jXkf5+rUunngTwle+74j3k8VOmkcgzpnQZqd8BXLntaooO3a/IYvGklvD+lKmU7X+eM5T967Dot9ia34QQaP3EMk2OGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755041427; c=relaxed/simple;
	bh=/CMvk4ObX9Upb+ATpnoTstB8rfzvKvaKjMQy1qRF2PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8JfjIeyC81GvvdNuWVYK1e1JLH7uoAmHjbdlZPxWnACwNdek0gVzaB2NsgOryZGZ1oAlq0P/lNvBphNsbmOk6SSji+2Ksbds/8caINS2yeiP+IzcW6MwZOjVrDatP1putUMDHNILmA/sMXN+xYUQ1sdPcsmutrzBEfCxp9oV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gudRrYLm; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71c06bb7470so37010747b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755041424; x=1755646224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGauCi3K2erSe+8r1M/gUbXlNAvfL1JW66IdtTbV7sI=;
        b=gudRrYLm0whXVO5AfCZGJXIg7LXWsiw/m5R+tjFwhH/viSokRx7XR3qLlHVfduaB9y
         1kwn7qUWswQHFxVE/fVmNcoC3TnIyDGEimci8oHUb1OTHv9hAUHKrtD4GgNffJ6KDeuz
         8+zRQp+r/wBaD+s1yNd3vUbfgXqgK2K0BGc44MdUI5FVOYVRlfbnK4H32f1lQVoBqwOy
         3QV5tGv40B/YaZDqv+8QHJqA0gYcMYLTH/1TV3yJxKQgIBXEERWX+ebggIrwKVKRdU79
         rkXpWcMvNB9/6PxNHZ0j12GltJdSsAo+udS2zhnUdJxiHutZ6c41Hb6/zKXwXR2xnbVq
         piPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755041424; x=1755646224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGauCi3K2erSe+8r1M/gUbXlNAvfL1JW66IdtTbV7sI=;
        b=KbOjcqcDq8pX/048nAQd3fvCHyUr7yVYCykxkzG1wzh7h+1EgilC/ZVos0N/sXr0DQ
         VhZFSFn4Q20eanXVbCyATWFu6DCbJcipokvOF6NCzdwnKBfI14swkFp1G4nSm7Nks1F+
         usqo5OWe9hQPyys+FBbuyz83FBF/4R1NO9enrTEjPrFT4S1YsyPlt/KSMc71nwC5eOWK
         mfYMKW4ieeCqUWd7xneOe8Bj3UaFS+iyg+BbCT/B+WuAk23KkT7Mp7x0/2AI9IlRjWyg
         FrLdSFbLSDNF6Hm5Twc/SkvZ982Y5xQdc6Q3C4VX9g74TSjut686SVOiKFzds0bADIdg
         s4Ww==
X-Gm-Message-State: AOJu0Yxk735bpAnP4ON+mxrqJ99i4pe8/w/zfLHSZdc+hWgCeJIWHlWI
	ION2+buPqNbouq9By45ozw+1FMxXxFXzcg7S9FLLaYQaFeLBpwjB/vC81ZUU8wRZ
X-Gm-Gg: ASbGncvMtoxGv2LipQ/TG17SYMxZqKrtFTmICKPu6SeGuqvMGcE3iCR3nU7wg73dLlI
	SMUlf98Sh6sdbHWSTCX6TuTVgWi7M6pgdHEBhJeANypYaPSaohgdM5kcpx+IPuz2sAVOeuGLxEt
	JB2yPtCsA+6KbEl+5nVF2jyW1OxHOwaWkvJ/MPY+WB13jq20PK2S6RQCyNprnc1qtdAKD+nFM4t
	kpoMySasHUgnxYX4yvM6+X889npqd6Dt+zK+zLAQVj9cJo/J6WVTYY4ZAZVRYlwPPqno9WMd0eu
	HjI169WvTHj0/PnzU+e2sbcP0EvrmZpczyBDXzgRmuZBICGEElahTeDW0vAQ4F6e3oBVVI+ul5u
	48EQzSDfAKTFUZcGN9MNmpaO9Xb92
X-Google-Smtp-Source: AGHT+IEDebCOjFWjvpOujVMizxbOGNpz6LM44WAPYWj+aTOxiVHB5ZTfZTLRNZEN/ZKONT7uDg52Kg==
X-Received: by 2002:a05:690c:6ac2:b0:71c:1a46:48d3 with SMTP id 00721157ae682-71d4e58ab60mr12676457b3.31.1755041423240;
        Tue, 12 Aug 2025 16:30:23 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:52::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5993eesm79473267b3.42.2025.08.12.16.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 16:30:22 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v4 1/3] btrfs: implement ref_tracker for delayed_nodes
Date: Tue, 12 Aug 2025 16:30:05 -0700
Message-ID: <20250812233019.2371148-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f97312e56638279c286304398526b5d4dfb15d88.1755035080.git.loemra.dev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 16:04:39 -0700 Leo Martins <loemra.dev@gmail.com> wrote:

> This patch adds ref_tracker infrastructure for btrfs_delayed_node.
> 
> It is a response to the largest btrfs related crash in our fleet.
> We're seeing softlockups in btrfs_kill_all_delayed_nodes that seem
> to be a result of delayed_nodes not being released properly.
> 
> A ref_tracker object is allocated on reference count increases and
> freed on reference count decreases. The ref_tracker object stores
> a stack trace of where it is allocated. The ref_tracker_dir object
> is embedded in btrfs_delayed_node and keeps track of all current
> and some old/freed ref_tracker objects. When a leak is detected
> we can print the stack traces for all ref_trackers that have not
> yet been freed.
> 
> Here is a common example of taking a reference to a delayed_node
> and freeing it with ref_tracker.
> 
> ```C
> struct btrfs_ref_tracker tracker;
> struct btrfs_delayed_node *node;
> 
> node = btrfs_get_delayed_node(inode, &tracker);
> // use delayed_node...
> btrfs_release_delayed_node(node, &tracker);
> ```
> 
> There are two special cases where the delayed_node reference is "long
> lived", meaning that the thread that takes the reference and the thread
> that releases the reference are different. The `inode_cache_tracker`
> tracks the delayed_node stored in btrfs_inode. The `node_list_tracker`
> tracks the delayed_node stored in the btrfs_delayed_root
> node_list/prepare_list. These trackers are embedded in the
> btrfs_delayed_node.
> 
> btrfs_ref_tracker and btrfs_ref_tracker_dir are wrappers that either
> compile to the corresponding ref_tracker structs or empty structs
> depending on CONFIG_BTRFS_DEBUG. There are also btrfs wrappers for
> the ref_tracker API.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/Kconfig         |   3 +-
>  fs/btrfs/delayed-inode.c | 192 ++++++++++++++++++++++++++++-----------
>  fs/btrfs/delayed-inode.h |  70 ++++++++++++++
>  3 files changed, 209 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index c352f3ae0385..2745de514196 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -61,7 +61,8 @@ config BTRFS_FS_RUN_SANITY_TESTS
>  
>  config BTRFS_DEBUG
>  	bool "Btrfs debugging support"
> -	depends on BTRFS_FS
> +	depends on BTRFS_FS && STACKTRACE_SUPPORT
> +	select REF_TRACKER
>  	help
>  	  Enable run-time debugging support for the btrfs filesystem.
>  
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 0f8d8e275143..c4696c2d5b34 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -57,6 +57,7 @@ static inline void btrfs_init_delayed_node(
>  	delayed_node->root = root;
>  	delayed_node->inode_id = inode_id;
>  	refcount_set(&delayed_node->refs, 0);
> +	btrfs_delayed_node_ref_tracker_dir_init(delayed_node);
>  	delayed_node->ins_root = RB_ROOT_CACHED;
>  	delayed_node->del_root = RB_ROOT_CACHED;
>  	mutex_init(&delayed_node->mutex);
> @@ -65,7 +66,8 @@ static inline void btrfs_init_delayed_node(
>  }
>  
>  static struct btrfs_delayed_node *btrfs_get_delayed_node(
> -		struct btrfs_inode *btrfs_inode)
> +		struct btrfs_inode *btrfs_inode,
> +		struct btrfs_ref_tracker *tracker)
>  {
>  	struct btrfs_root *root = btrfs_inode->root;
>  	u64 ino = btrfs_ino(btrfs_inode);
> @@ -74,6 +76,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>  	node = READ_ONCE(btrfs_inode->delayed_node);
>  	if (node) {
>  		refcount_inc(&node->refs);
> +		btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_NOFS);
>  		return node;
>  	}
>  
> @@ -83,6 +86,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>  	if (node) {
>  		if (btrfs_inode->delayed_node) {
>  			refcount_inc(&node->refs);	/* can be accessed */
> +			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
> +							     GFP_ATOMIC);
>  			BUG_ON(btrfs_inode->delayed_node != node);
>  			xa_unlock(&root->delayed_nodes);
>  			return node;
> @@ -106,6 +111,10 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>  		 */
>  		if (refcount_inc_not_zero(&node->refs)) {
>  			refcount_inc(&node->refs);
> +			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
> +							     GFP_ATOMIC);
> +			btrfs_delayed_node_ref_tracker_alloc(
> +				node, &node->inode_cache_tracker, GFP_ATOMIC);
>  			btrfs_inode->delayed_node = node;
>  		} else {
>  			node = NULL;
> @@ -126,7 +135,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>   * Return the delayed node, or error pointer on failure.
>   */
>  static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> -		struct btrfs_inode *btrfs_inode)
> +		struct btrfs_inode *btrfs_inode,
> +		struct btrfs_ref_tracker *tracker)
>  {
>  	struct btrfs_delayed_node *node;
>  	struct btrfs_root *root = btrfs_inode->root;
> @@ -135,7 +145,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
>  	void *ptr;
>  
>  again:
> -	node = btrfs_get_delayed_node(btrfs_inode);
> +	node = btrfs_get_delayed_node(btrfs_inode, tracker);
>  	if (node)
>  		return node;
>  
> @@ -144,12 +154,10 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
>  		return ERR_PTR(-ENOMEM);
>  	btrfs_init_delayed_node(node, root, ino);
>  
> -	/* Cached in the inode and can be accessed. */
> -	refcount_set(&node->refs, 2);
> -
>  	/* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
>  	ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
>  	if (ret == -ENOMEM) {
> +		btrfs_delayed_node_ref_tracker_dir_exit(node);
>  		kmem_cache_free(delayed_node_cache, node);
>  		return ERR_PTR(-ENOMEM);
>  	}
> @@ -158,6 +166,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
>  	if (ptr) {
>  		/* Somebody inserted it, go back and read it. */
>  		xa_unlock(&root->delayed_nodes);
> +		btrfs_delayed_node_ref_tracker_dir_exit(node);
>  		kmem_cache_free(delayed_node_cache, node);
>  		node = NULL;
>  		goto again;
> @@ -166,6 +175,13 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
>  	ASSERT(xa_err(ptr) != -EINVAL);
>  	ASSERT(xa_err(ptr) != -ENOMEM);
>  	ASSERT(ptr == NULL);
> +
> +	/* Cached in the inode and can be accessed. */
> +	refcount_set(&node->refs, 2);
> +	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> +	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker,
> +					     GFP_ATOMIC);
> +
>  	btrfs_inode->delayed_node = node;
>  	xa_unlock(&root->delayed_nodes);
>  
> @@ -191,6 +207,8 @@ static void btrfs_queue_delayed_node(struct btrfs_delayed_root *root,
>  		list_add_tail(&node->n_list, &root->node_list);
>  		list_add_tail(&node->p_list, &root->prepare_list);
>  		refcount_inc(&node->refs);	/* inserted into list */
> +		btrfs_delayed_node_ref_tracker_alloc(
> +			node, &node->node_list_tracker, GFP_ATOMIC);
>  		root->nodes++;
>  		set_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags);
>  	}
> @@ -204,6 +222,8 @@ static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
>  	spin_lock(&root->lock);
>  	if (test_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags)) {
>  		root->nodes--;
> +		btrfs_delayed_node_ref_tracker_free(node,
> +						    &node->node_list_tracker);
>  		refcount_dec(&node->refs);	/* not in the list */
>  		list_del_init(&node->n_list);
>  		if (!list_empty(&node->p_list))
> @@ -214,22 +234,26 @@ static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
>  }
>  
>  static struct btrfs_delayed_node *btrfs_first_delayed_node(
> -			struct btrfs_delayed_root *delayed_root)
> +			struct btrfs_delayed_root *delayed_root,
> +			struct btrfs_ref_tracker *tracker)
>  {
>  	struct btrfs_delayed_node *node;
>  
>  	spin_lock(&delayed_root->lock);
>  	node = list_first_entry_or_null(&delayed_root->node_list,
>  					struct btrfs_delayed_node, n_list);
> -	if (node)
> +	if (node) {
>  		refcount_inc(&node->refs);
> +		btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> +	}
>  	spin_unlock(&delayed_root->lock);
>  
>  	return node;
>  }
>  
>  static struct btrfs_delayed_node *btrfs_next_delayed_node(
> -						struct btrfs_delayed_node *node)
> +						struct btrfs_delayed_node *node,
> +						struct btrfs_ref_tracker *tracker)
>  {
>  	struct btrfs_delayed_root *delayed_root;
>  	struct list_head *p;
> @@ -249,6 +273,7 @@ static struct btrfs_delayed_node *btrfs_next_delayed_node(
>  
>  	next = list_entry(p, struct btrfs_delayed_node, n_list);
>  	refcount_inc(&next->refs);
> +	btrfs_delayed_node_ref_tracker_alloc(next, tracker, GFP_ATOMIC);
>  out:
>  	spin_unlock(&delayed_root->lock);
>  
> @@ -257,7 +282,7 @@ static struct btrfs_delayed_node *btrfs_next_delayed_node(
>  
>  static void __btrfs_release_delayed_node(
>  				struct btrfs_delayed_node *delayed_node,
> -				int mod)
> +				int mod, struct btrfs_ref_tracker *tracker)
>  {
>  	struct btrfs_delayed_root *delayed_root;
>  
> @@ -273,6 +298,7 @@ static void __btrfs_release_delayed_node(
>  		btrfs_dequeue_delayed_node(delayed_root, delayed_node);
>  	mutex_unlock(&delayed_node->mutex);
>  
> +	btrfs_delayed_node_ref_tracker_free(delayed_node, tracker);
>  	if (refcount_dec_and_test(&delayed_node->refs)) {
>  		struct btrfs_root *root = delayed_node->root;
>  
> @@ -282,17 +308,20 @@ static void __btrfs_release_delayed_node(
>  		 * back up.  We can delete it now.
>  		 */
>  		ASSERT(refcount_read(&delayed_node->refs) == 0);
> +		btrfs_delayed_node_ref_tracker_dir_exit(delayed_node);
>  		kmem_cache_free(delayed_node_cache, delayed_node);
>  	}
>  }
>  
> -static inline void btrfs_release_delayed_node(struct btrfs_delayed_node *node)
> +static inline void btrfs_release_delayed_node(struct btrfs_delayed_node *node,
> +					      struct btrfs_ref_tracker *tracker)
>  {
> -	__btrfs_release_delayed_node(node, 0);
> +	__btrfs_release_delayed_node(node, 0, tracker);
>  }
>  
>  static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
> -					struct btrfs_delayed_root *delayed_root)
> +					struct btrfs_delayed_root *delayed_root,
> +					struct btrfs_ref_tracker *tracker)
>  {
>  	struct btrfs_delayed_node *node;
>  
> @@ -302,6 +331,7 @@ static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
>  	if (node) {
>  		list_del_init(&node->p_list);
>  		refcount_inc(&node->refs);
> +		btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
>  	}
>  	spin_unlock(&delayed_root->lock);
>  
> @@ -309,9 +339,10 @@ static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
>  }
>  
>  static inline void btrfs_release_prepared_delayed_node(
> -					struct btrfs_delayed_node *node)
> +					struct btrfs_delayed_node *node,
> +					struct btrfs_ref_tracker *tracker)
>  {
> -	__btrfs_release_delayed_node(node, 1);
> +	__btrfs_release_delayed_node(node, 1, tracker);
>  }
>  
>  static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
> @@ -1126,6 +1157,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_delayed_root *delayed_root;
>  	struct btrfs_delayed_node *curr_node, *prev_node;
> +	struct btrfs_ref_tracker curr_delayed_node_tracker,
> +		prev_delayed_node_tracker;
>  	struct btrfs_path *path;
>  	struct btrfs_block_rsv *block_rsv;
>  	int ret = 0;
> @@ -1143,7 +1176,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
>  
>  	delayed_root = fs_info->delayed_root;
>  
> -	curr_node = btrfs_first_delayed_node(delayed_root);
> +	curr_node = btrfs_first_delayed_node(delayed_root,
> +					     &curr_delayed_node_tracker);
>  	while (curr_node && (!count || nr--)) {
>  		ret = __btrfs_commit_inode_delayed_items(trans, path,
>  							 curr_node);
> @@ -1153,7 +1187,9 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
>  		}
>  
>  		prev_node = curr_node;
> -		curr_node = btrfs_next_delayed_node(curr_node);
> +		prev_delayed_node_tracker = curr_delayed_node_tracker;
> +		curr_node = btrfs_next_delayed_node(curr_node,
> +						    &curr_delayed_node_tracker);
>  		/*
>  		 * See the comment below about releasing path before releasing
>  		 * node. If the commit of delayed items was successful the path
> @@ -1161,7 +1197,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
>  		 * point to locked extent buffers (a leaf at the very least).
>  		 */
>  		ASSERT(path->nodes[0] == NULL);
> -		btrfs_release_delayed_node(prev_node);
> +		btrfs_release_delayed_node(prev_node,
> +					   &prev_delayed_node_tracker);
>  	}
>  
>  	/*
> @@ -1174,7 +1211,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
>  	btrfs_free_path(path);
>  
>  	if (curr_node)
> -		btrfs_release_delayed_node(curr_node);
> +		btrfs_release_delayed_node(curr_node,
> +					   &curr_delayed_node_tracker);
>  	trans->block_rsv = block_rsv;
>  
>  	return ret;
> @@ -1193,7 +1231,9 @@ int btrfs_run_delayed_items_nr(struct btrfs_trans_handle *trans, int nr)
>  int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
>  				     struct btrfs_inode *inode)
>  {
> -	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
> +	struct btrfs_ref_tracker delayed_node_tracker;
> +	struct btrfs_delayed_node *delayed_node =
> +		btrfs_get_delayed_node(inode, &delayed_node_tracker);
>  	BTRFS_PATH_AUTO_FREE(path);
>  	struct btrfs_block_rsv *block_rsv;
>  	int ret;
> @@ -1204,14 +1244,14 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
>  	mutex_lock(&delayed_node->mutex);
>  	if (!delayed_node->count) {
>  		mutex_unlock(&delayed_node->mutex);
> -		btrfs_release_delayed_node(delayed_node);
> +		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  		return 0;
>  	}
>  	mutex_unlock(&delayed_node->mutex);
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> -		btrfs_release_delayed_node(delayed_node);
> +		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  		return -ENOMEM;
>  	}
>  
> @@ -1220,7 +1260,7 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
>  
>  	ret = __btrfs_commit_inode_delayed_items(trans, path, delayed_node);
>  
> -	btrfs_release_delayed_node(delayed_node);
> +	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  	trans->block_rsv = block_rsv;
>  
>  	return ret;
> @@ -1230,7 +1270,9 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	struct btrfs_trans_handle *trans;
> -	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
> +	struct btrfs_ref_tracker delayed_node_tracker;
> +	struct btrfs_delayed_node *delayed_node =
> +		btrfs_get_delayed_node(inode, &delayed_node_tracker);
>  	struct btrfs_path *path;
>  	struct btrfs_block_rsv *block_rsv;
>  	int ret;
> @@ -1241,7 +1283,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
>  	mutex_lock(&delayed_node->mutex);
>  	if (!test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
>  		mutex_unlock(&delayed_node->mutex);
> -		btrfs_release_delayed_node(delayed_node);
> +		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  		return 0;
>  	}
>  	mutex_unlock(&delayed_node->mutex);
> @@ -1275,7 +1317,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
>  	btrfs_end_transaction(trans);
>  	btrfs_btree_balance_dirty(fs_info);
>  out:
> -	btrfs_release_delayed_node(delayed_node);
> +	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  
>  	return ret;
>  }
> @@ -1289,7 +1331,9 @@ void btrfs_remove_delayed_node(struct btrfs_inode *inode)
>  		return;
>  
>  	inode->delayed_node = NULL;
> -	btrfs_release_delayed_node(delayed_node);
> +
> +	btrfs_release_delayed_node(delayed_node,
> +				   &delayed_node->inode_cache_tracker);
>  }
>  
>  struct btrfs_async_delayed_work {
> @@ -1305,6 +1349,7 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_path *path;
>  	struct btrfs_delayed_node *delayed_node = NULL;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  	struct btrfs_root *root;
>  	struct btrfs_block_rsv *block_rsv;
>  	int total_done = 0;
> @@ -1321,7 +1366,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
>  		    BTRFS_DELAYED_BACKGROUND / 2)
>  			break;
>  
> -		delayed_node = btrfs_first_prepared_delayed_node(delayed_root);
> +		delayed_node = btrfs_first_prepared_delayed_node(
> +			delayed_root, &delayed_node_tracker);
>  		if (!delayed_node)
>  			break;
>  
> @@ -1330,7 +1376,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
>  		trans = btrfs_join_transaction(root);
>  		if (IS_ERR(trans)) {
>  			btrfs_release_path(path);
> -			btrfs_release_prepared_delayed_node(delayed_node);
> +			btrfs_release_prepared_delayed_node(
> +				delayed_node, &delayed_node_tracker);
>  			total_done++;
>  			continue;
>  		}
> @@ -1345,7 +1392,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
>  		btrfs_btree_balance_dirty_nodelay(root->fs_info);
>  
>  		btrfs_release_path(path);
> -		btrfs_release_prepared_delayed_node(delayed_node);
> +		btrfs_release_prepared_delayed_node(delayed_node,
> +						    &delayed_node_tracker);
>  		total_done++;
>  
>  	} while ((async_work->nr == 0 && total_done < BTRFS_DELAYED_WRITEBACK)
> @@ -1377,10 +1425,15 @@ static int btrfs_wq_run_delayed_node(struct btrfs_delayed_root *delayed_root,
>  
>  void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_delayed_node *node = btrfs_first_delayed_node(fs_info->delayed_root);
> +	struct btrfs_ref_tracker delayed_node_tracker;
> +	struct btrfs_delayed_node *node = btrfs_first_delayed_node(
> +		fs_info->delayed_root, &delayed_node_tracker);
>  
> -	if (WARN_ON(node))
> +	if (WARN_ON(node)) {
> +		btrfs_delayed_node_ref_tracker_free(node,
> +						    &delayed_node_tracker);
>  		refcount_dec(&node->refs);
> +	}
>  }
>  
>  static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int seq)
> @@ -1454,13 +1507,15 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	const unsigned int leaf_data_size = BTRFS_LEAF_DATA_SIZE(fs_info);
>  	struct btrfs_delayed_node *delayed_node;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  	struct btrfs_delayed_item *delayed_item;
>  	struct btrfs_dir_item *dir_item;
>  	bool reserve_leaf_space;
>  	u32 data_len;
>  	int ret;
>  
> -	delayed_node = btrfs_get_or_create_delayed_node(dir);
> +	delayed_node =
> +		btrfs_get_or_create_delayed_node(dir, &delayed_node_tracker);
>  	if (IS_ERR(delayed_node))
>  		return PTR_ERR(delayed_node);
>  
> @@ -1536,7 +1591,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
>  	mutex_unlock(&delayed_node->mutex);
>  
>  release_node:
> -	btrfs_release_delayed_node(delayed_node);
> +	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  	return ret;
>  }
>  
> @@ -1591,10 +1646,11 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
>  				   struct btrfs_inode *dir, u64 index)
>  {
>  	struct btrfs_delayed_node *node;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  	struct btrfs_delayed_item *item;
>  	int ret;
>  
> -	node = btrfs_get_or_create_delayed_node(dir);
> +	node = btrfs_get_or_create_delayed_node(dir, &delayed_node_tracker);
>  	if (IS_ERR(node))
>  		return PTR_ERR(node);
>  
> @@ -1635,13 +1691,15 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
>  	}
>  	mutex_unlock(&node->mutex);
>  end:
> -	btrfs_release_delayed_node(node);
> +	btrfs_release_delayed_node(node, &delayed_node_tracker);
>  	return ret;
>  }
>  
>  int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
>  {
> -	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
> +	struct btrfs_ref_tracker delayed_node_tracker;
> +	struct btrfs_delayed_node *delayed_node =
> +		btrfs_get_delayed_node(inode, &delayed_node_tracker);
>  
>  	if (!delayed_node)
>  		return -ENOENT;
> @@ -1652,12 +1710,12 @@ int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
>  	 * is updated now. So we needn't lock the delayed node.
>  	 */
>  	if (!delayed_node->index_cnt) {
> -		btrfs_release_delayed_node(delayed_node);
> +		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  		return -EINVAL;
>  	}
>  
>  	inode->index_cnt = delayed_node->index_cnt;
> -	btrfs_release_delayed_node(delayed_node);
> +	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  	return 0;
>  }
>  
> @@ -1668,8 +1726,9 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
>  {
>  	struct btrfs_delayed_node *delayed_node;
>  	struct btrfs_delayed_item *item;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  
> -	delayed_node = btrfs_get_delayed_node(inode);
> +	delayed_node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
>  	if (!delayed_node)
>  		return false;
>  
> @@ -1704,6 +1763,8 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
>  	 * insert/delete delayed items in this period. So we also needn't
>  	 * requeue or dequeue this delayed node.
>  	 */
> +	btrfs_delayed_node_ref_tracker_free(delayed_node,
> +					    &delayed_node_tracker);
>  	refcount_dec(&delayed_node->refs);
>  
>  	return true;
> @@ -1845,17 +1906,18 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	struct btrfs_delayed_node *delayed_node;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  	struct btrfs_inode_item *inode_item;
>  	struct inode *vfs_inode = &inode->vfs_inode;
>  
> -	delayed_node = btrfs_get_delayed_node(inode);
> +	delayed_node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
>  	if (!delayed_node)
>  		return -ENOENT;
>  
>  	mutex_lock(&delayed_node->mutex);
>  	if (!test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
>  		mutex_unlock(&delayed_node->mutex);
> -		btrfs_release_delayed_node(delayed_node);
> +		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  		return -ENOENT;
>  	}
>  
> @@ -1895,7 +1957,7 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
>  		inode->index_cnt = (u64)-1;
>  
>  	mutex_unlock(&delayed_node->mutex);
> -	btrfs_release_delayed_node(delayed_node);
> +	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  	return 0;
>  }
>  
> @@ -1904,9 +1966,11 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
>  {
>  	struct btrfs_root *root = inode->root;
>  	struct btrfs_delayed_node *delayed_node;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  	int ret = 0;
>  
> -	delayed_node = btrfs_get_or_create_delayed_node(inode);
> +	delayed_node =
> +		btrfs_get_or_create_delayed_node(inode, &delayed_node_tracker);
>  	if (IS_ERR(delayed_node))
>  		return PTR_ERR(delayed_node);
>  
> @@ -1926,7 +1990,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
>  	atomic_inc(&root->fs_info->delayed_root->items);
>  release_node:
>  	mutex_unlock(&delayed_node->mutex);
> -	btrfs_release_delayed_node(delayed_node);
> +	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  	return ret;
>  }
>  
> @@ -1934,6 +1998,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	struct btrfs_delayed_node *delayed_node;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  
>  	/*
>  	 * we don't do delayed inode updates during log recovery because it
> @@ -1943,7 +2008,8 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
>  	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
>  		return -EAGAIN;
>  
> -	delayed_node = btrfs_get_or_create_delayed_node(inode);
> +	delayed_node =
> +		btrfs_get_or_create_delayed_node(inode, &delayed_node_tracker);
>  	if (IS_ERR(delayed_node))
>  		return PTR_ERR(delayed_node);
>  
> @@ -1970,7 +2036,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
>  	atomic_inc(&fs_info->delayed_root->items);
>  release_node:
>  	mutex_unlock(&delayed_node->mutex);
> -	btrfs_release_delayed_node(delayed_node);
> +	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  	return 0;
>  }
>  
> @@ -2014,19 +2080,21 @@ static void __btrfs_kill_delayed_node(struct btrfs_delayed_node *delayed_node)
>  void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
>  {
>  	struct btrfs_delayed_node *delayed_node;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  
> -	delayed_node = btrfs_get_delayed_node(inode);
> +	delayed_node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
>  	if (!delayed_node)
>  		return;
>  
>  	__btrfs_kill_delayed_node(delayed_node);
> -	btrfs_release_delayed_node(delayed_node);
> +	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  }
>  
>  void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>  {
>  	unsigned long index = 0;
>  	struct btrfs_delayed_node *delayed_nodes[8];
> +	struct btrfs_ref_tracker delayed_node_trackers[8];
>  
>  	while (1) {
>  		struct btrfs_delayed_node *node;
> @@ -2045,6 +2113,9 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>  			 * about to be removed from the tree in the loop below
>  			 */
>  			if (refcount_inc_not_zero(&node->refs)) {
> +				btrfs_delayed_node_ref_tracker_alloc(
> +					node, &delayed_node_trackers[count],
> +					GFP_ATOMIC);
>  				delayed_nodes[count] = node;
>  				count++;
>  			}
> @@ -2056,7 +2127,8 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>  
>  		for (int i = 0; i < count; i++) {
>  			__btrfs_kill_delayed_node(delayed_nodes[i]);
> -			btrfs_release_delayed_node(delayed_nodes[i]);
> +			btrfs_release_delayed_node(delayed_nodes[i],
> +						   &delayed_node_trackers[i]);
>  		}
>  	}
>  }
> @@ -2064,14 +2136,20 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>  void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info)
>  {
>  	struct btrfs_delayed_node *curr_node, *prev_node;
> +	struct btrfs_ref_tracker curr_delayed_node_tracker,
> +		prev_delayed_node_tracker;
>  
> -	curr_node = btrfs_first_delayed_node(fs_info->delayed_root);
> +	curr_node = btrfs_first_delayed_node(fs_info->delayed_root,
> +					     &curr_delayed_node_tracker);
>  	while (curr_node) {
>  		__btrfs_kill_delayed_node(curr_node);
>  
>  		prev_node = curr_node;
> -		curr_node = btrfs_next_delayed_node(curr_node);
> -		btrfs_release_delayed_node(prev_node);
> +		prev_delayed_node_tracker = curr_delayed_node_tracker;
> +		curr_node = btrfs_next_delayed_node(curr_node,
> +						    &curr_delayed_node_tracker);
> +		btrfs_release_delayed_node(prev_node,
> +					   &prev_delayed_node_tracker);
>  	}
>  }
>  
> @@ -2081,8 +2159,9 @@ void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
>  {
>  	struct btrfs_delayed_node *node;
>  	struct btrfs_delayed_item *item;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  
> -	node = btrfs_get_delayed_node(inode);
> +	node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
>  	if (!node)
>  		return;
>  
> @@ -2140,6 +2219,7 @@ void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
>  	 * delete delayed items.
>  	 */
>  	ASSERT(refcount_read(&node->refs) > 1);
> +	btrfs_delayed_node_ref_tracker_free(node, &delayed_node_tracker);
>  	refcount_dec(&node->refs);
>  }
>  
> @@ -2150,8 +2230,9 @@ void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
>  	struct btrfs_delayed_node *node;
>  	struct btrfs_delayed_item *item;
>  	struct btrfs_delayed_item *next;
> +	struct btrfs_ref_tracker delayed_node_tracker;
>  
> -	node = btrfs_get_delayed_node(inode);
> +	node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
>  	if (!node)
>  		return;
>  
> @@ -2183,5 +2264,6 @@ void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
>  	 * delete delayed items.
>  	 */
>  	ASSERT(refcount_read(&node->refs) > 1);
> +	btrfs_delayed_node_ref_tracker_free(node, &delayed_node_tracker);
>  	refcount_dec(&node->refs);
>  }
> diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
> index e6e763ad2d42..a01f2ab59adb 100644
> --- a/fs/btrfs/delayed-inode.h
> +++ b/fs/btrfs/delayed-inode.h
> @@ -7,6 +7,7 @@
>  #ifndef BTRFS_DELAYED_INODE_H
>  #define BTRFS_DELAYED_INODE_H
>  
> +#include <linux/ref_tracker.h>
>  #include <linux/types.h>
>  #include <linux/rbtree.h>
>  #include <linux/spinlock.h>
> @@ -44,6 +45,22 @@ struct btrfs_delayed_root {
>  	wait_queue_head_t wait;
>  };
>  
> +struct btrfs_ref_tracker_dir {
> +#ifdef CONFIG_BTRFS_DEBUG
> +	struct ref_tracker_dir dir;
> +#else
> +	struct {} tracker;
> +#endif
> +};
> +
> +struct btrfs_ref_tracker {
> +#ifdef CONFIG_BTRFS_DEBUG
> +	struct ref_tracker *tracker;
> +#else
> +	struct {} tracker;
> +#endif
> +};
> +
>  #define BTRFS_DELAYED_NODE_IN_LIST	0
>  #define BTRFS_DELAYED_NODE_INODE_DIRTY	1
>  #define BTRFS_DELAYED_NODE_DEL_IREF	2
> @@ -78,6 +95,12 @@ struct btrfs_delayed_node {
>  	 * actual number of leaves we end up using. Protected by @mutex.
>  	 */
>  	u32 index_item_leaves;
> +	/* Used to track all references to this delayed node. */
> +	struct btrfs_ref_tracker_dir ref_dir;
> + 	/* Used to track delayed node reference stored in node list. */
> +	struct btrfs_ref_tracker node_list_tracker;
> + 	/* Used to track delayed node reference stored in inode cache. */
> +	struct btrfs_ref_tracker inode_cache_tracker;
>  };
>  
>  struct btrfs_delayed_item {
> @@ -169,4 +192,51 @@ void __cold btrfs_delayed_inode_exit(void);
>  /* for debugging */
>  void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info);
>  
> +#define BTRFS_DELAYED_NODE_REF_TRACKER_QUARANTINE_COUNT 16
> +#define BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT 16
> +
> +#ifdef CONFIG_BTRFS_DEBUG
> +static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_node *node)
> +{
> +	ref_tracker_dir_init(&node->ref_dir.dir, 
> +			     BTRFS_DELAYED_NODE_REF_TRACKER_QUARANTINE_COUNT,
> +			     "delayed_node");
> +}
> +
> +static inline void btrfs_delayed_node_ref_tracker_dir_exit(struct btrfs_delayed_node *node)
> +{
> +	ref_tracker_dir_exit(&node->ref_dir.dir);
> +}
> +
> +static inline int btrfs_delayed_node_ref_tracker_alloc(struct btrfs_delayed_node *node,
> +						       struct btrfs_ref_tracker *tracker,
> +						       gfp_t gfp)
> +{
> +	return ref_tracker_alloc(&node->ref_dir.dir, &tracker->tracker, gfp);
> +}
> +
> +static inline int btrfs_delayed_node_ref_tracker_free(struct btrfs_delayed_node *node,
> +						      struct btrfs_ref_tracker *tracker)
> +{
> +	return ref_tracker_free(&node->ref_dir.dir, &tracker->tracker);
> +}
> +#else
> +static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_node *node) { }
> +
> +static inline void btrfs_delayed_node_ref_tracker_dir_exit(struct btrfs_delayed_node *node) { }
> +
> +static inline int btrfs_delayed_node_ref_tracker_alloc(struct btrfs_delayed_node *node,
> +						       struct btrfs_ref_tracker *tracker,
> +						       gfp_t gfp)
> +{
> +	return 0;
> +}
> +
> +static inline int btrfs_delayed_node_ref_tracker_free(struct btrfs_delayed_node *node,
> +						      struct btrfs_ref_tracker *tracker)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_BTRFS_REF_TRACKER */

Sorry, this should be:

/* CONFIG_BTRFS_DEBUG */

> +
>  #endif
> -- 
> 2.47.3

Sent using hkml (https://github.com/sjp38/hackermail)

