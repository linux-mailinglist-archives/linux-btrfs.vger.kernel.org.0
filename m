Return-Path: <linux-btrfs+bounces-6684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868D93B64D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B4E1F22274
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0D315F41F;
	Wed, 24 Jul 2024 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qTkepaOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4CnXmlg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDA2E639
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843832; cv=none; b=PpYdKRU4vZm+9MtQz9w1FSUIcIGpJFeVsc25hm/fmYJx8M3oVSHMe2xGkyxOLd1FVtz6f19w2U78hPVeNIQDJC1KlepkrQwoQ+QDk5E7KlKRUfpKuPfuuIXC8aNJmEjbHY4N2gwzlP/KUtQ9eSp0CL2nezOyBqQPFTM2IDHvrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843832; c=relaxed/simple;
	bh=DfVTv4jL+19uUwYGmuS636AFbvI+jeIKzt/HlFlUcls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQRmcowJZFDYQn7ZJgRgrqdMQdnqK0us97AbPh4/ITmTN+r8D+1O7EwqEXz+asOdEx/p5jJNfZ54o8aI0zjx/lVEgkXOmpIE9PcxIkExRBjLM4b7NhK2G8455IjVcemy2xdzd3XhjWv6IPLV/+z8PEa7obflNR/2RikT90MlQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qTkepaOM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4CnXmlg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 47A9E11400C4;
	Wed, 24 Jul 2024 13:57:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 24 Jul 2024 13:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1721843826; x=1721930226; bh=YKe3ZCrFbv
	J4+gZ8mBWP5zHuUF2qjsxX+nrtuIlV07g=; b=qTkepaOM6HcLq/z7QnoHNv455E
	OomiR56NYMx0R+n85mUFShXwoGlO2ORA1j1hc3F4YysUf0Nd6AAsQu9Ga/rJEaSx
	5WJ5VtkQhjY21cCYGaifxWdHaJrVrSONGEMyGFdiCTmY23ThZ/qrub8t+P0HCd1r
	mw5Pv5y4XQQetMIESEh6AzEF98TN5/oGFugqCmcpuiRmoel/GcGuBDg9DtoXU6gv
	TJz2nyHkhgn7yX9jg9zElqkpxPuIDmDaFBmSZfd0OFw5QmSEYscd0JCdyNJQTLuP
	48btegYnDeP7WtPjShWPs9S/ScHWU4gLby4L82NzPvmZW6tzdzVzVyK2YwuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721843826; x=1721930226; bh=YKe3ZCrFbvJ4+gZ8mBWP5zHuUF2q
	jsxX+nrtuIlV07g=; b=k4CnXmlgTLkHGTZCaSDdYPmHT40kXPeV2RpchTS21A5w
	O7H60rH8iXzPdTVoHZp+ZyKZEcggm2fjc+53bchmQ3Z+KixkEX0gDpPmrutFJJG6
	3SGnSlzPeZ8EswGMaDwriJHp0h5Uqa+nz/0Ok+Xi/4ASew2DqQ3ELVX5s8EjW2XI
	WnqSgBfgMvkgpFTxQXFdGmfE+buQOsWZP/kASerRFc7lm6f/HSiCn4/K8xw9MsM9
	qzVQz9jZgqyjcbpS7tVzRJutAE1FfUa/YB0Ruup09IAhYL0vpOmQ9kg15+pr26DS
	tAtsUO39hNY05FXFOQmIZ953O/Qi0etfttcIPhj4Ag==
X-ME-Sender: <xms:ckChZok3S62a0qQTIKWjFP99asA2QuhSOaAvhxGpGvTSIxT6sjnNcg>
    <xme:ckChZn3XLaVhRTv1mHCjao5yX5doM2ca21_YrMNYef8-4rGHNlmQC5oceI-8bgTdc
    4GzRYigZkBS1Tcj_RI>
X-ME-Received: <xmr:ckChZmpmu4gIATU1AdsOShbusRSHpSuUoFVxMg1s82gEts1BqgzXwxnGLwj_Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhiohdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:ckChZklDaTAYsO5T1l5e-HMd1OmwSFfD2xZfI2YTsVdwZsatMBuuww>
    <xmx:ckChZm0A1cBbSKHMVsKTeSl07ZwUp5ngBVGYIpxFEXvyg-HGHn5GeQ>
    <xmx:ckChZru4deRSxWK_bJjnebOTvltILaN15J0MZHXFu-Jy8DwIKAvafQ>
    <xmx:ckChZiU7GfMaVlQwn8Ii94-RtllLdnxD-vdDul265f6a1LOHfKeHZw>
    <xmx:ckChZkDORKb2xzD7fupw6PHAnrE24pIn2yXtd5sxhiUHaHvU3NePEp7K>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 13:57:05 -0400 (EDT)
Date: Wed, 24 Jul 2024 10:57:01 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs-progs: add rudimentary log checking
Message-ID: <ZqFAbWBFWJk5Qjq+@devvm12410.ftw0.facebook.com>
References: <20240715143830.2067478-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715143830.2067478-1-maharmstone@fb.com>

On Mon, Jul 15, 2024 at 03:38:24PM +0100, Mark Harmstone wrote:
> Currently the transaction log is more or less ignored by btrfs check,
> meaning that it's possible for a FS with a corrupt log to pass btrfs
> check, but be immediately corrupted by the kernel when it's mounted.
> 
> This patch adds a check that if there's an inode in the log, any pending
> non-compressed writes also have corresponding csum entries.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
> Changes:
> v2:
> helper to load log root
> handle compressed extents
> loop logic improvements
> fix bug in check_log_csum
> 
> v3:
> added test
> added explanatory comment to check_log_csum
> changed length operation to -=
> 
>  check/main.c                                  | 304 +++++++++++++++++-
>  .../063-log-missing-csum/default.img.xz       | Bin 0 -> 1288 bytes
>  tests/fsck-tests/063-log-missing-csum/test.sh |  14 +
>  3 files changed, 306 insertions(+), 12 deletions(-)
>  create mode 100644 tests/fsck-tests/063-log-missing-csum/default.img.xz
>  create mode 100755 tests/fsck-tests/063-log-missing-csum/test.sh
> 
> diff --git a/check/main.c b/check/main.c
> index 83c721d3..eaae3042 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9787,6 +9787,274 @@ static int zero_log_tree(struct btrfs_root *root)
>  	return ret;
>  }
>  
> +/* Searches the given root for checksums in the range [addr, addr+length].
> + * Returns 1 if found, 0 if not found, and < 0 for an error. */
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
> +			length -= (end - addr);
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
> @@ -10585,9 +10853,21 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
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
> @@ -10622,11 +10902,11 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
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
> @@ -10644,9 +10924,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
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
> @@ -10664,7 +10944,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  	 */
>  	no_holes = btrfs_fs_incompat(gfs_info, NO_HOLES);
>  	if (!g_task_ctx.progress_enabled) {
> -		fprintf(stderr, "[4/7] checking fs roots\n");
> +		fprintf(stderr, "[5/8] checking fs roots\n");
>  	} else {
>  		g_task_ctx.tp = TASK_FS_ROOTS;
>  		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
> @@ -10680,10 +10960,10 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
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
> @@ -10702,7 +10982,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  	/* For low memory mode, check_fs_roots_v2 handles root refs */
>          if (check_mode != CHECK_MODE_LOWMEM) {
>  		if (!g_task_ctx.progress_enabled) {
> -			fprintf(stderr, "[6/7] checking root refs\n");
> +			fprintf(stderr, "[7/8] checking root refs\n");
>  		} else {
>  			g_task_ctx.tp = TASK_ROOT_REFS;
>  			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
> @@ -10717,7 +10997,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  		}
>  	} else {
>  		fprintf(stderr,
> -	"[6/7] checking root refs done with fs roots in lowmem mode, skipping\n");
> +	"[7/8] checking root refs done with fs roots in lowmem mode, skipping\n");
>  	}
>  
>  	while (opt_check_repair && !list_empty(&gfs_info->recow_ebs)) {
> @@ -10749,7 +11029,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  
>  	if (gfs_info->quota_enabled) {
>  		if (!g_task_ctx.progress_enabled) {
> -			fprintf(stderr, "[7/7] checking quota groups\n");
> +			fprintf(stderr, "[8/8] checking quota groups\n");
>  		} else {
>  			g_task_ctx.tp = TASK_QGROUPS;
>  			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
> @@ -10772,7 +11052,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  		ret = 0;
>  	} else {
>  		fprintf(stderr,
> -		"[7/7] checking quota groups skipped (not enabled on this FS)\n");
> +		"[8/8] checking quota groups skipped (not enabled on this FS)\n");
>  	}
>  
>  	if (!list_empty(&gfs_info->recow_ebs)) {
> diff --git a/tests/fsck-tests/063-log-missing-csum/default.img.xz b/tests/fsck-tests/063-log-missing-csum/default.img.xz
> new file mode 100644
> index 0000000000000000000000000000000000000000..c9b4f420ac23866cd142428daf21739efda0762d
> GIT binary patch
> literal 1288
> zcmV+j1^4>>H+ooF000E$*0e?f03iVu0001VFXf}+)Bgm;T>wRyj;C3^v%$$4d1wo3
> zjjaF1$8Jv*pMMm%#Ch6IM%}7&=@^TvKIIdYjZ@t7T($M|Hz%Cr>ZwJ6sj_bRsY^a*
> zIr#q#U>$p<Go1bOhu5#Q<?@08{(UO6n<sqYIY$<RXz3}#&sBuS|AUrsgQ{%?z1>tr
> zW^k~hR~HJs$P?zuw_V+%>i2AU4x-C~^RmH%0#2o7VY;D>d@D<+CC=J4l?Bs2d@5yC
> z&pKh_V}nG$A*f{hGHlfKeT*E3NA1Q(Nt;TxvV6m2A_RVpD=`*t<8b6_KTom1S=|eG
> z>OMhPCcl7*3tYx)YhtFm-3)~e_SPBasmqw|$jnE_-QZfatuNh^bkJ5yW{ZX7NmD)i
> zLKCQYs5y!To5G>tIYzSNigXu|<l&x%JzxMA5aW-t+nod|B!efqr+_#STUo@Xu>wY=
> z*;zh8-nLPC+GYq6HU^A<Qjkh41{(MMB=p?8i7|;p<cL9o>Q7;56uclyq=uCMb1GmZ
> zuq5@iwv1^<TQdlj9#Xdq$Vj!1d~GO$P#HmKmPt*t2iPme{8~y6{{T++2nv+X7)Fnf
> z`$pgevh)w!LR&hx2a|{sW@ac43(Sl>??<SGJB`t-nDXvSDSY*87<ziAenKb9p4UlP
> z*(x(s)OBgD_f*R-*yBUaiD3U<uhy+{P{T&x@o^!9gXa@=Kts_p@u`Tb)rQcu{)tzQ
> zhCXcu`CGkyKuQRy(M0c#fPDWJwyhC`w2mizWqVSf==Sk-nywG!nJzNT5aM0tVb}Va
> zK?^BQbY*CPLeJtG``VF4F@BVWBpSVWDFk`J!cOhagXH=GB1GApQ?zsg8%y=J$Fgl1
> z)+=jFc)g}pALW^HG}wkoY7fOfbZ274b~+dEoA?l%Xzz`P-F)vb1^UziIz|no!02bS
> zWPfo?`TiKe8aIuiPilXte381GZ4tQc6=Y*KS0rehLE^7!W+MOr0AEFmQgw<KSH}Ix
> ze4qlov3aIg5e(Oh1%CwTZN^`UI!7g(U;iDFt(>e4XDB-M)l0stJd3pf<XujqB2}MW
> z6EY1#$l>s;T1IYy#{A9ljl@Ba_*dh)Qfq@8Y1A#q%p|d;USrIAZ*n1`%ho*!-RYOY
> z4j%X?D?CoiaW8A*7aue82GA9jmMGg6Bv&mO#v6uKVw1V~Uu01wXbz(RJN_|xw{`8K
> zSfdyQCJOdIwdN%h+Jr{$9!6otgQ8^`lkU4u;5wJlsy#P<D{Nc39m@=*OHZ533tvD<
> zfb=c>-IWOj%>%mQ@Ja!#!QIOVuluA}ecSFg;*v@<bR@g*YX>1-?kl9WGes{ulrRWq
> zTCW@Om{iybhK+m8SiS%n^)Kgk21T`IEW#){Czvz;Fix;5bdkB$BFXimx9iBaRZ9r=
> zV(H0OD8mK94(j^6gF8)|^i-78H`hR#ebBvFq}>vK6-ni7j1S>*viG^nA7<~Bn2KW0
> zw%D36qxTcpO;c2bYwf)K?p#^LFL4Ifq8?kP?#;(Jo8*(twFPRBj*u~h%Ej$X6JI2E
> z<L5)YZY#@aM-2sxodox#)=G1ycE6A6j?am&HLbKPv@FI{(HAJ#D*V@xG^U`bnRtH<
> y%w+Y9$G2sBKv@6)0000tuOhH&%TnS10pSUNs0#q29h=Ir#Ao{g000001X)@}7Iu~Z
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/fsck-tests/063-log-missing-csum/test.sh b/tests/fsck-tests/063-log-missing-csum/test.sh
> new file mode 100755
> index 00000000..40a48508
> --- /dev/null
> +++ b/tests/fsck-tests/063-log-missing-csum/test.sh
> @@ -0,0 +1,14 @@
> +#!/bin/bash
> +#
> +# Verify that check can detect missing log csum items.
> +
> +source "$TEST_TOP/common" || exit
> +
> +check_prereq btrfs
> +
> +check_image() {
> +	run_mustfail "missing log csum items not detected" \
> +		"$TOP/btrfs" check "$1"
> +}
> +
> +check_all_images
> -- 
> 2.45.2
> 

