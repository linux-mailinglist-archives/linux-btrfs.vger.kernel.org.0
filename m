Return-Path: <linux-btrfs+bounces-6436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6872B930150
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 22:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38D01F23A99
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364F450EE;
	Fri, 12 Jul 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kycuXnSD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0L4JJg6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40E2C879
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jul 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720816839; cv=none; b=eXuLYRp+d+szeCjSAtObzuiOdKV7FskOh+e9Ap2ORmraPZw9lPH5aorG7GyWQbV39J/8HVEyiNAQgP5KvQmr6I4XmQRWr0u+V4mkA+4cxCx+WOWaFQKh0oM6ep6l6142XlKzvTPhat6dK5AIM8DO0hlRXefcs4bWdrqexm/BWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720816839; c=relaxed/simple;
	bh=JYqHtay+6NZRI2Gd3KmaU6NYP5lqLmSzYWL1u9I7vhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIubL7ayo46RwwbgUSxj5jPjnu5ENIqGWUg1jsgPYWmWeP4Z+c+DckkJcLxRCbY/p4HCJ8sJArExWy045aas6iITM8QyAG2k8WVzxXRl7/sLkpB5H2J+z0MvBDFNFxEqrJyjqyJnc4EOyIh3obeXD6lvd3X8aCPHCpt/StTdFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kycuXnSD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0L4JJg6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B23261140B26;
	Fri, 12 Jul 2024 16:40:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 12 Jul 2024 16:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1720816835; x=1720903235; bh=9pWrWT2V8B
	BOC8Q9aGZ4QUY6bzs2UMlp6kHYJ4C4aLM=; b=kycuXnSDxUf4sChZtvsTdENJEf
	GgOyodKbTbjlO0tBblCyYwOfwPDm0d9UaQtIfEPe5zw6FoNMp55VIYSJ8pUAQnR6
	zxnKY4WeOb4P58QS9QnGJJQBpl2SlrUDvpVqK/bWaH8YvSBO9mewilGv5mUkOfAZ
	xGjXtm3/o1k201e8xv+tTYBnTTSMdKvt7eA4yWdxRRk0kiWVUjV0CMOERk+Y6udS
	VlZnXW/48qNuo4WnCyvLTZDVjPMUgXhyJ/JscH6C9SrfeBpGUUfWbcdARGEDIU57
	6XRhXlW+NR5XG5zt6fvtuDSdn7mv1lrcmrSuD6y93YrDu9ymSjRqPRpQ0czg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720816835; x=1720903235; bh=9pWrWT2V8BBOC8Q9aGZ4QUY6bzs2
	UMlp6kHYJ4C4aLM=; b=O0L4JJg6hW4bZjsWyXFsXKE48oZ924d8ODNfXt7W55OQ
	qSO807yQYysYom4laYrHDuWvMVugUXNeqCFddn8k0FRbRFlTwiajLZUhaFzFdtEw
	pf7GjOTirE3NSikA3Ab6p8CX1oQ65rcKc7+dkkwFPadz8pSApKL//RodmXlnL4I8
	cAlMMMeyQW2HuC9v05zaacrv7dMH6cxJdC5erR0vCaly1jSMAt0m2yUxkI6Zl4+O
	RZwZTN+JoX+9VJRLaVUY5luO4PXAdZkVhsDwHQdZpex+2IkHFNmPjeLXdwz279Gc
	61aBDqGS0Xeiev6htuF7Oh4UJz7BrlQ5g2JAVXvu6g==
X-ME-Sender: <xms:wpSRZje3VpCx5aBDZNgsZ4iRNf1x3rgVvSQko6Rd5ep_M6irpGDhiw>
    <xme:wpSRZpOIMT5_7aEZy9nk9cqJsNaRNhM2-W5ztaRYMSqrLOu64YoHbg0RdnSl19ZoA
    Vp5sIEMbcMyAppn1No>
X-ME-Received: <xmr:wpSRZsiQr1SPgHlMFQMoPd-Yd_WzpsnoS8E75tZboX15MGLjA6nkrEcOqfN3bqtCTCl3XgZ5yfltH8y9YFO2OA3L_pY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:wpSRZk_BF_g8U07Nvd2J93pDbgh0cXoyWYbymCVVclynRFvzPx3Niw>
    <xmx:wpSRZvsM4uxG5VmzuQw-VfbJRuJQJQIxEmQzebaO7BZYVXE6EIDnYA>
    <xmx:wpSRZjGlMxa7Nt2TLGfRJ5W344tiwp-1pIALtgBYt2OpGfmd9p8LuQ>
    <xmx:wpSRZmPtMBSNZBIqkAL3wYMjLU322joI5qpx5H85z1oDWmQb45SH5g>
    <xmx:w5SRZo6eRXFsshiERK8gjDj83Y3LNtyzheEpYQV_Nz9cfdTx_hdqUIPP>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jul 2024 16:40:34 -0400 (EDT)
Date: Fri, 12 Jul 2024 13:39:37 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: add rudimentary log checking
Message-ID: <20240712203937.GB3474272@zen.localdomain>
References: <20240711142412.4139062-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711142412.4139062-1-maharmstone@fb.com>

On Thu, Jul 11, 2024 at 03:23:38PM +0100, Mark Harmstone wrote:
> Currently the transaction log is more or less ignored by btrfs check,
> meaning that it's possible for a FS with a corrupt log to pass btrfs
> check, but be immediately corrupted by the kernel when it's mounted.
> 
> This patch adds a check that if there's an inode in the log, any pending
> non-compressed writes also have corresponding csum entries.
> 
> This is a resubmission, taking into account Josef and Qu's suggestions
> from the first patch. It also fixes a logic error in check_log_csum that
> I only noticed after submission.
> 

LGTM. A few small notes inline. Also, wondering if you think this could
be reasonably tested with a new test in tests/fsck-tests. It appears you
would have to craft an offending fs image and store it in the test's
directory?

If you add a test (or there's a good reason it's a dumb idea),
Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---

edit the output of git format-patch to add changelog notes in your email,
here below the '---' not in the commit message.
e.g. something like:

Changes:
v2:
helper to load log root
handle compressed extents
loop logic improvements
fix bug in check_log_csum

>  check/main.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 290 insertions(+), 12 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 83c721d3..bd524a32 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9787,6 +9787,272 @@ static int zero_log_tree(struct btrfs_root *root)
>  	return ret;
>  }
>  

The loop logic looks good to me. I think it would be helpful to add some
high level description of the invariant of the check, e.g. "return 1
upon finding a hole in the csums for the range [addr, addr+length],
return 0 if no hole is found".

I think specifically this name might confuse people to think that it is
actually verifying the csums or something.

> +static int check_log_csum(struct btrfs_root *root, u64 addr, u64 length)
> +{
> +	struct btrfs_path path = { 0 };
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	u16 csum_size = gfs_info->csum_size;
> +	u16 num_entries;
> +	u64 data_len;
> +	int ret;
> +
> +	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
> +	key.type = BTRFS_EXTENT_CSUM_KEY;
> +	key.offset = addr;
> +
> +	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret > 0 && path.slots[0])
> +		path.slots[0]--;
> +
> +	ret = 0;
> +
> +	while (1) {
> +		leaf = path.nodes[0];
> +		if (path.slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(root, &path);
> +			if (ret) {
> +				if (ret > 0)
> +					ret = 0;
> +
> +				break;
> +			}
> +			leaf = path.nodes[0];
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
> +
> +		if (key.objectid > BTRFS_EXTENT_CSUM_OBJECTID)
> +			break;
> +
> +		if (key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
> +		    key.type != BTRFS_EXTENT_CSUM_KEY)
> +			goto next;
> +
> +		if (key.offset >= addr + length)
> +			break;
> +
> +		num_entries = btrfs_item_size(leaf, path.slots[0]) / csum_size;
> +		data_len = num_entries * gfs_info->sectorsize;
> +
> +		if (addr >= key.offset && addr <= key.offset + data_len) {
> +			u64 end = min(addr + length, key.offset + data_len);
> +
> +			length = addr + length - end;

total nit, but I think something like
length -= (end - addr);
conveys the decreasing nature of length in this loop more clearly.

> +			addr = end;
> +
> +			if (length == 0)
> +				break;
> +		}
> +
> +next:
> +		path.slots[0]++;
> +	}
> +
> +	btrfs_release_path(&path);
> +
> +	if (ret >= 0)
> +		ret = length == 0 ? 1 : 0;
> +
> +	return ret;
> +}
> +
> +static int check_log_root(struct btrfs_root *root, struct cache_tree *root_cache,
> +			  struct walk_control *wc)
> +{
> +	struct btrfs_path path = { 0 };
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	int ret, err = 0;
> +	u64 last_csum_inode = 0;
> +
> +	key.objectid = BTRFS_FIRST_FREE_OBJECTID;
> +	key.type = BTRFS_INODE_ITEM_KEY;
> +	key.offset = 0;
> +	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	if (ret < 0)
> +		return 1;
> +
> +	while (1) {
> +		leaf = path.nodes[0];
> +		if (path.slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(root, &path);
> +			if (ret) {
> +				if (ret < 0)
> +					err = 1;
> +
> +				break;
> +			}
> +			leaf = path.nodes[0];
> +		}
> +		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
> +
> +		if (key.objectid == BTRFS_EXTENT_CSUM_OBJECTID)
> +			break;
> +
> +		if (key.type == BTRFS_INODE_ITEM_KEY) {
> +			struct btrfs_inode_item *item;
> +
> +			item = btrfs_item_ptr(leaf, path.slots[0],
> +					      struct btrfs_inode_item);
> +
> +			if (!(btrfs_inode_flags(leaf, item) & BTRFS_INODE_NODATASUM))
> +				last_csum_inode = key.objectid;
> +		} else if (key.type == BTRFS_EXTENT_DATA_KEY &&
> +			   key.objectid == last_csum_inode) {
> +			struct btrfs_file_extent_item *fi;
> +			u64 addr, length;
> +
> +			fi = btrfs_item_ptr(leaf, path.slots[0],
> +					    struct btrfs_file_extent_item);
> +
> +			if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG)
> +				goto next;
> +
> +			addr = btrfs_file_extent_disk_bytenr(leaf, fi) +
> +				btrfs_file_extent_offset(leaf, fi);
> +			length = btrfs_file_extent_num_bytes(leaf, fi);
> +
> +			ret = check_log_csum(root, addr, length);
> +			if (ret < 0) {
> +				err = 1;
> +				break;
> +			}
> +
> +			if (!ret) {
> +				error("csum missing in log (root %llu, inode %llu, "
> +				      "offset %llu, address 0x%llx, length %llu)",
> +				      root->objectid, last_csum_inode, key.offset,
> +				      addr, length);
> +				err = 1;
> +			}
> +		}
> +
> +next:
> +		path.slots[0]++;
> +	}
> +
> +	btrfs_release_path(&path);
> +
> +	return err;
> +}
> +
> +static int load_log_root(u64 root_id, struct btrfs_path *path,
> +			 struct btrfs_root *tmp_root)
> +{
> +	struct extent_buffer *l;
> +	struct btrfs_tree_parent_check check = { 0 };
> +
> +	btrfs_setup_root(tmp_root, gfs_info, root_id);
> +
> +	l = path->nodes[0];
> +	read_extent_buffer(l, &tmp_root->root_item,
> +			btrfs_item_ptr_offset(l, path->slots[0]),
> +			sizeof(tmp_root->root_item));
> +
> +	tmp_root->root_key.objectid = root_id;
> +	tmp_root->root_key.type = BTRFS_ROOT_ITEM_KEY;
> +	tmp_root->root_key.offset = 0;
> +
> +	check.owner_root = btrfs_root_id(tmp_root);
> +	check.transid = btrfs_root_generation(&tmp_root->root_item);
> +	check.level = btrfs_root_level(&tmp_root->root_item);
> +
> +	tmp_root->node = read_tree_block(gfs_info,
> +					 btrfs_root_bytenr(&tmp_root->root_item),
> +					 &check);
> +	if (IS_ERR(tmp_root->node)) {
> +		tmp_root->node = NULL;
> +		return 1;
> +	}
> +
> +	if (btrfs_header_level(tmp_root->node) != btrfs_root_level(&tmp_root->root_item)) {
> +		error("root [%llu %llu] level %d does not match %d",
> +			tmp_root->root_key.objectid,
> +			tmp_root->root_key.offset,
> +			btrfs_header_level(tmp_root->node),
> +			btrfs_root_level(&tmp_root->root_item));
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int check_log(struct cache_tree *root_cache)
> +{
> +	struct btrfs_path path = { 0 };
> +	struct walk_control wc = { 0 };
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_root *log_root = gfs_info->log_root_tree;
> +	int ret;
> +	int err = 0;
> +
> +	cache_tree_init(&wc.shared);
> +
> +	key.objectid = BTRFS_TREE_LOG_OBJECTID;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = 0;
> +	ret = btrfs_search_slot(NULL, log_root, &key, &path, 0, 0);
> +	if (ret < 0) {
> +		err = 1;
> +		goto out;
> +	}
> +
> +	while (1) {
> +		leaf = path.nodes[0];
> +		if (path.slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(log_root, &path);
> +			if (ret) {
> +				if (ret < 0)
> +					err = 1;
> +				break;
> +			}
> +			leaf = path.nodes[0];
> +		}
> +		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
> +
> +		if (key.objectid > BTRFS_TREE_LOG_OBJECTID ||
> +		    key.type > BTRFS_ROOT_ITEM_KEY)
> +			break;
> +
> +		if (key.objectid == BTRFS_TREE_LOG_OBJECTID &&
> +		    key.type == BTRFS_ROOT_ITEM_KEY &&
> +		    fs_root_objectid(key.offset)) {
> +			struct btrfs_root tmp_root;
> +
> +			memset(&tmp_root, 0, sizeof(tmp_root));
> +
> +			ret = load_log_root(key.offset, &path, &tmp_root);
> +			if (ret) {
> +				err = 1;
> +				goto next;
> +			}
> +
> +			ret = check_log_root(&tmp_root, root_cache, &wc);
> +			if (ret)
> +				err = 1;
> +
> +next:
> +			if (tmp_root.node)
> +				free_extent_buffer(tmp_root.node);
> +		}
> +
> +		path.slots[0]++;
> +	}
> +out:
> +	btrfs_release_path(&path);
> +	if (err)
> +		free_extent_cache_tree(&wc.shared);
> +	if (!cache_tree_empty(&wc.shared))
> +		fprintf(stderr, "warning line %d\n", __LINE__);
> +
> +	return err;
> +}
> +
>  static void free_roots_info_cache(void)
>  {
>  	if (!roots_info_cache)
> @@ -10585,9 +10851,21 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  		goto close_out;
>  	}
>  
> +	if (gfs_info->log_root_tree) {
> +		fprintf(stderr, "[1/8] checking log\n");
> +		ret = check_log(&root_cache);
> +
> +		if (ret)
> +			error("errors found in log");
> +		err |= !!ret;
> +	} else {
> +		fprintf(stderr,
> +		"[1/8] checking log skipped (none written)\n");
> +	}
> +
>  	if (!init_extent_tree) {
>  		if (!g_task_ctx.progress_enabled) {
> -			fprintf(stderr, "[1/7] checking root items\n");
> +			fprintf(stderr, "[2/8] checking root items\n");
>  		} else {
>  			g_task_ctx.tp = TASK_ROOT_ITEMS;
>  			task_start(g_task_ctx.info, &g_task_ctx.start_time,
> @@ -10622,11 +10900,11 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  			}
>  		}
>  	} else {
> -		fprintf(stderr, "[1/7] checking root items... skipped\n");
> +		fprintf(stderr, "[2/8] checking root items... skipped\n");
>  	}
>  
>  	if (!g_task_ctx.progress_enabled) {
> -		fprintf(stderr, "[2/7] checking extents\n");
> +		fprintf(stderr, "[3/8] checking extents\n");
>  	} else {
>  		g_task_ctx.tp = TASK_EXTENTS;
>  		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
> @@ -10644,9 +10922,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  
>  	if (!g_task_ctx.progress_enabled) {
>  		if (is_free_space_tree)
> -			fprintf(stderr, "[3/7] checking free space tree\n");
> +			fprintf(stderr, "[4/8] checking free space tree\n");
>  		else
> -			fprintf(stderr, "[3/7] checking free space cache\n");
> +			fprintf(stderr, "[4/8] checking free space cache\n");
>  	} else {
>  		g_task_ctx.tp = TASK_FREE_SPACE;
>  		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
> @@ -10664,7 +10942,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  	 */
>  	no_holes = btrfs_fs_incompat(gfs_info, NO_HOLES);
>  	if (!g_task_ctx.progress_enabled) {
> -		fprintf(stderr, "[4/7] checking fs roots\n");
> +		fprintf(stderr, "[5/8] checking fs roots\n");
>  	} else {
>  		g_task_ctx.tp = TASK_FS_ROOTS;
>  		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
> @@ -10680,10 +10958,10 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  
>  	if (!g_task_ctx.progress_enabled) {
>  		if (check_data_csum)
> -			fprintf(stderr, "[5/7] checking csums against data\n");
> +			fprintf(stderr, "[6/8] checking csums against data\n");
>  		else
>  			fprintf(stderr,
> -		"[5/7] checking only csums items (without verifying data)\n");
> +		"[6/8] checking only csums items (without verifying data)\n");
>  	} else {
>  		g_task_ctx.tp = TASK_CSUMS;
>  		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
> @@ -10702,7 +10980,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  	/* For low memory mode, check_fs_roots_v2 handles root refs */
>          if (check_mode != CHECK_MODE_LOWMEM) {
>  		if (!g_task_ctx.progress_enabled) {
> -			fprintf(stderr, "[6/7] checking root refs\n");
> +			fprintf(stderr, "[7/8] checking root refs\n");
>  		} else {
>  			g_task_ctx.tp = TASK_ROOT_REFS;
>  			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
> @@ -10717,7 +10995,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  		}
>  	} else {
>  		fprintf(stderr,
> -	"[6/7] checking root refs done with fs roots in lowmem mode, skipping\n");
> +	"[7/8] checking root refs done with fs roots in lowmem mode, skipping\n");
>  	}
>  
>  	while (opt_check_repair && !list_empty(&gfs_info->recow_ebs)) {
> @@ -10749,7 +11027,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  
>  	if (gfs_info->quota_enabled) {
>  		if (!g_task_ctx.progress_enabled) {
> -			fprintf(stderr, "[7/7] checking quota groups\n");
> +			fprintf(stderr, "[8/8] checking quota groups\n");
>  		} else {
>  			g_task_ctx.tp = TASK_QGROUPS;
>  			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
> @@ -10772,7 +11050,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  		ret = 0;
>  	} else {
>  		fprintf(stderr,
> -		"[7/7] checking quota groups skipped (not enabled on this FS)\n");
> +		"[8/8] checking quota groups skipped (not enabled on this FS)\n");
>  	}
>  
>  	if (!list_empty(&gfs_info->recow_ebs)) {
> -- 
> 2.45.2
> 

