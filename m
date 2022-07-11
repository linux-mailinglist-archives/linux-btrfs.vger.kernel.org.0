Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D9657051C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiGKOKX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 10:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKOKW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 10:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833F61B23;
        Mon, 11 Jul 2022 07:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D980B80E9C;
        Mon, 11 Jul 2022 14:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3064EC34115;
        Mon, 11 Jul 2022 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657548617;
        bh=7ZMuFt2WYzhlAVjLYLZtEfpDk09OQI2rTOmJRCE4JYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUtlFjVg6wiHaGG548DL7MIrFuYj9KUyCukSkBLrg7+P2o2cjR15bhN401HOhZ8ra
         EkbpaUYGJs87rZtUVDoAddFL85281GBIvoJm8AgFHOaeGxfKWwZq6Cct7o//hJkrlL
         XC4zgjPNAHrZy134sEYRn4hp2/H+907Hc2DjtuyvII//TyUQIe0nsfXYWxFe+LFgw/
         M7k6Dc+xwowy4UX8hu2n5EaMzjwvxkAimKj+bKdJYdV0jtZ/c0BfkC7XWPFqCDZL2A
         Q+S4wVfEndFcvbHfmqSBywmY8EDZB9xLdhdRW87wZuBRo5fMUWA3eujiZpkXI6iaGX
         17BvyrGRTbsew==
Date:   Mon, 11 Jul 2022 15:10:14 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     bingjing chang <bxxxjxxg@gmail.com>
Cc:     bingjingc <bingjingc@synology.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robbie Ko <robbieko@synology.com>
Subject: Re: [PATCH 2/2] btrfs: send: fix a bug that sending a link command
 on existing file path
Message-ID: <20220711141014.GA1029724@falcondesktop>
References: <20220706130903.1661-1-bingjingc@synology.com>
 <20220706130903.1661-3-bingjingc@synology.com>
 <20220706160357.GA826504@falcondesktop>
 <CAMmgxWE5Ph4hF7d1N8M1btf2FsFro6mBsQDDf=Cx8szeg207vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMmgxWE5Ph4hF7d1N8M1btf2FsFro6mBsQDDf=Cx8szeg207vQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 10, 2022 at 11:07:10PM +0800, bingjing chang wrote:
> Hi Filipe,
> 
> Thank you for the review and comments. It really helps.
> I will submit a patch v2 to fix the problems.
> 
> Filipe Manana <fdmanana@kernel.org> 於 2022年7月7日 週四 凌晨12:04寫道：
> >
> > On Wed, Jul 06, 2022 at 09:09:03PM +0800, bingjingc wrote:
> > > From: BingJing Chang <bingjingc@synology.com>
> > >
> > > btrfs_ioctl_send processes recorded btrfs_keys in a defined order. (First,
> > > we process a btrfs_key with a samller objectid. If btrfs_keys have the same
> > > objectid, then we compare their types and offsets accordingly.)
> >
> > That's a very convoluted way to simply say that send processes keys in the order
> > they are found in the btrees, from the leftmost to the rightmost.
> >
> > > However,
> > > reference paths for an inode can be stored in either BTRFS_INODE_REF_KEY
> > > btrfs_keys or BTRFS_INODE_EXTREF_KEY btrfs_keys. And due to the limitation
> > > of the helper function - iterate_inode_ref, we can only iterate the entries
> > > of ONE btrfs_inode_ref or btrfs_inode_extref. That is, there must be a bug
> > > in processing the same reference paths, which are stored in different ways.
> >
> > When you say "there must be a bug", you want to say "there is a bug", and then
> > explain what the bug is.
> >
> > However the bug has nothing to do with the order of how keys are processed.
> >
> > What happens is that when we are processing an inode we go over all references
> > and add all the new names to the "new_refs" list and add all the deleted names
> > to the "deleted_refs" list.
> >
> > Then in the end, when we finish processing the inode, we iterate over all the
> > new names in the "new_refs" list and send link commands for those names. After
> > that we go over all the names in the "deleted_refs" list and send unlink commands
> > for those names.
> >
> > The problem in this case, is that we have names duplicated in both lists.
> > So we try to create them before we remove them, therefore the receiver gets an
> > -EEXIST error when trying the link operations.
> >
> 
> Yes, the problem happens when we have names duplicated in both lists.
> And with the current logics in process_recorded_refs(), we will issue
> links on existing files.
> 
> I will try to make the description clear in patch v2.
> 
> > >
> > > Here is an exmple that btrfs_ioctl_send will send a link command on an
> >
> > exmple -> example
> >
> > > existing file path:
> > >
> > >   $ btrfs subvolume create test
> > >
> > >   # create a file and 2000 hard links to the same inode
> > >   $ dd if=/dev/zero of=test/1M bs=1M count=1
> >
> > touch test/1M
> >
> > The data is completely irrelevant here, all we care about are the
> > hard links of the file. Making the reproducer the minimum necessary
> > to trigger a bug, makes it much less distracting and easier to grasp.
> >
> > >   $ for i in {1..2000}; do link test/1M test/$i ; done
> > >
> > >   # take a snapshot for parent snapshot
> > >   $ btrfs sub snap -r test snap1
> > >
> > >   # remove 2000 hard links and re-create the last 1000 links
> > >   $ for i in {1..2000}; do rm test/$i; done;
> > >   $ for i in {1001..2000}; do link test/1M test/$i; done
> > >
> > >   # take another one for sned snapshot
> >
> > sned -> send
> >
> > >   $ btrfs sub snap -r test snap2
> > >
> > >   $ mkdir tmp
> > >   $ btrfs send -e snap2 -p snap1 | btrfs receive tmp/
> >
> > The -e is not necessary.
> >
> > >   At subvol snap2
> > >   link 1238 -> 1M
> > >   ERROR: link 1238 -> 1M failed: File exists
> > >
> > > In the parent snapshot snap1, reference paths 1 - 1237 are stored in a
> > > INODE_REF item and the rest ones are stored in other INODE_EXTREF items.
> > > But in the send snapshot snap2, all reference paths can be stored within a
> > > INODE_REF item. During the send process, btrfs_ioctl_send will process the
> > > INODE_REF item first. Then it found that reference paths 1 - 1000 were
> > > gone in the send snapshot, so it recorded them in sctx->deleted_refs for
> > > unlink. And it found that reference paths 1238 - 2000 were new paths in
> > > the send snapshot, so it recorded them in sctx->new_refs for link. Since
> > > we do not load all contents of its INODE_EXTREF items to make comparison,
> > > afterwards, btrfs_ioctl_send may make a mistake sending a link command on
> > > an existing file path.
> >
> > So this explanation is not correct, it's neither about the names being stored
> > in an INODE_REF or INODE_EXTREF item nor about processing one item before or
> > after the other. As mentioned before, it's because we always process the
> > "new_refs" list before the "deleted_refs" list, and in this case we have the
> > same names (paths) in both lists.
> >
> 
> Sorry, I didn't make this paragraph easy to understand.
> Here, I want to address that there is already a function find_iref(), which
> can be used to check duplications. But it has limitations.

Yes, I got it. Its problem is that it works only for the names inside a single
ref (or extref) item.

Your solution basically is a version of find_iref() that works across all the
ref/extref items of an inode.

> 
> For this example, we delete 2000 files and recreate 1000 files. Not all of
> the 2000 file paths are added to the "deleted_refs" list. And not all of
> the 1000 re-created file paths are added to the "new_refs" list. With
> find_iref(), when processing inode references, {1001..1237} are not added
> to any lists because they appear in both inode references. Afterwards,
> two lists contain items as below:
> "new_refs" list: {1238..2000}
> "deleted_refs" list: {1..1000} + {1238..2000}
> Therefore, there are duplicated items {1238..2000} in both lists. It results
> in link failure.

Yep. Many names got moved from an extref item into a regular ref item, which
is what leads to the duplicate names in both lists.

> 
> > >
> > > To fix the bug, we can either remove the duplicated items both in
> > > sctx->new_refs and sctx->deleted_refs before generating link/unlink
> > > commands or prevent them from being added into list. Both of them require
> > > efficient data structures like C++ sets to look up duplicated items.
> >
> > There's a much more obvious alternative, which is processing first the
> > "deleted_refs" list before the "new_refs" list.
> >
> > It's inefficient because we do a bunch of unlinks followed by links for
> > the same paths. On the other hand, it does not require maintaining two
> > new rbtrees and allocating memory for records in these rbtrees.
> >
> 
> Thank you for mentioning this. I will describe the intuition idea and the
> difficulties. I was unable to reshuffle the processing order. If someone can
> do this, we are glad to pick that solution.

I just tried that today, but it's harder than I though, I couldn't find a way
for it to work without breaking other scenarios (mostly to get orphanization
right and the need to recompute paths after orphanization).

So I think we can go with your solution.
I would just like to see two changes:

1) An updated changelog as mentioned before;

2) Change the code to only use the new infrastructure to manage refs.
   The code you added is a parallel infrastructure that is more robust and
   deals with that case of names being moved from an extref item to a ref
   item. Having only one infrastructure makes things much easier to maintain
   and a lot less code, and it also allows to rename record_ref2() to simply
   record_ref(), as the old record_ref() is now gone.
   I made those changes in the following patch, which you can apply on top
   of your patch, or if you prefer I can send it separately.

What do you think?

The cleanup patch is the following, and it passes fstests and some light
stress testing:

From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 11 Jul 2022 14:55:26 +0100
Subject: [PATCH] btrfs: send: always use the rbtree based inode ref management
 infrastructure

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 203 +++++-------------------------------------------
 1 file changed, 20 insertions(+), 183 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 37e3ba5c8586..797e2fb3b26b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2189,7 +2189,7 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	/*
 	 * If the inode is not existent yet, add the orphan name and return 1.
 	 * This should only happen for the parent dir that we determine in
-	 * __record_new_ref
+	 * __record_new_ref_if_needed().
 	 */
 	ret = is_inode_existent(sctx, ino, gen);
 	if (ret < 0)
@@ -2790,27 +2790,6 @@ static void set_ref_path(struct recorded_ref *ref, struct fs_path *path)
 	ref->name_len = ref->full_path->end - ref->name;
 }
 
-/*
- * We need to process new refs before deleted refs, but compare_tree gives us
- * everything mixed. So we first record all refs and later process them.
- * This function is a helper to record one ref.
- */
-static int __record_ref(struct list_head *head, u64 dir,
-		      u64 dir_gen, struct fs_path *path)
-{
-	struct recorded_ref *ref;
-
-	ref = recorded_ref_alloc();
-	if (!ref)
-		return -ENOMEM;
-
-	ref->dir = dir;
-	ref->dir_gen = dir_gen;
-	set_ref_path(ref, path);
-	list_add_tail(&ref->list, head);
-	return 0;
-}
-
 static int dup_ref(struct recorded_ref *ref, struct list_head *list)
 {
 	struct recorded_ref *new;
@@ -4337,56 +4316,6 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	return ret;
 }
 
-static int record_ref(struct btrfs_root *root, u64 dir, struct fs_path *name,
-		      void *ctx, struct list_head *refs)
-{
-	int ret = 0;
-	struct send_ctx *sctx = ctx;
-	struct fs_path *p;
-	u64 gen;
-
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
-	ret = get_inode_info(root, dir, NULL, &gen, NULL, NULL,
-			NULL, NULL);
-	if (ret < 0)
-		goto out;
-
-	ret = get_cur_path(sctx, dir, gen, p);
-	if (ret < 0)
-		goto out;
-	ret = fs_path_add_path(p, name);
-	if (ret < 0)
-		goto out;
-
-	ret = __record_ref(refs, dir, gen, p);
-
-out:
-	if (ret)
-		fs_path_free(p);
-	return ret;
-}
-
-static int __record_new_ref(int num, u64 dir, int index,
-			    struct fs_path *name,
-			    void *ctx)
-{
-	struct send_ctx *sctx = ctx;
-	return record_ref(sctx->send_root, dir, name, ctx, &sctx->new_refs);
-}
-
-
-static int __record_deleted_ref(int num, u64 dir, int index,
-				struct fs_path *name,
-				void *ctx)
-{
-	struct send_ctx *sctx = ctx;
-	return record_ref(sctx->parent_root, dir, name, ctx,
-			  &sctx->deleted_refs);
-}
-
 static int rbtree_ref_comp(const void *k, const struct rb_node *node)
 {
 	const struct recorded_ref *data = k;
@@ -4422,9 +4351,9 @@ static bool rbtree_ref_less(struct rb_node *node, const struct rb_node *parent)
 	return rbtree_ref_comp(entry, parent) < 0;
 }
 
-static int record_ref2(struct rb_root *root, struct list_head *refs,
-			     struct fs_path *name, u64 dir, u64 dir_gen,
-			     struct send_ctx *sctx)
+static int record_ref(struct rb_root *root, struct list_head *refs,
+		      struct fs_path *name, u64 dir, u64 dir_gen,
+		      struct send_ctx *sctx)
 {
 	int ret = 0;
 	struct fs_path *path = NULL;
@@ -4487,8 +4416,8 @@ static int __record_new_ref_if_needed(int num, u64 dir, int index,
 		ref = rb_entry(node, struct recorded_ref, node);
 		recorded_ref_free(ref);
 	} else {
-		ret = record_ref2(&sctx->rbtree_new_refs, &sctx->new_refs,
-				  name, dir, dir_gen, sctx);
+		ret = record_ref(&sctx->rbtree_new_refs, &sctx->new_refs,
+				 name, dir, dir_gen, sctx);
 	}
 out:
 	return ret;
@@ -4518,9 +4447,9 @@ static int __record_deleted_ref_if_needed(int num, u64 dir, int index,
 		ref = rb_entry(node, struct recorded_ref, node);
 		recorded_ref_free(ref);
 	} else {
-		ret = record_ref2(&sctx->rbtree_deleted_refs,
-				  &sctx->deleted_refs, name, dir, dir_gen,
-				  sctx);
+		ret = record_ref(&sctx->rbtree_deleted_refs,
+				 &sctx->deleted_refs, name, dir, dir_gen,
+				 sctx);
 	}
 out:
 	return ret;
@@ -4564,113 +4493,16 @@ struct find_ref_ctx {
 	int found_idx;
 };
 
-static int __find_iref(int num, u64 dir, int index,
-		       struct fs_path *name,
-		       void *ctx_)
-{
-	struct find_ref_ctx *ctx = ctx_;
-	u64 dir_gen;
-	int ret;
-
-	if (dir == ctx->dir && fs_path_len(name) == fs_path_len(ctx->name) &&
-	    strncmp(name->start, ctx->name->start, fs_path_len(name)) == 0) {
-		/*
-		 * To avoid doing extra lookups we'll only do this if everything
-		 * else matches.
-		 */
-		ret = get_inode_info(ctx->root, dir, NULL, &dir_gen, NULL,
-				     NULL, NULL, NULL);
-		if (ret)
-			return ret;
-		if (dir_gen != ctx->dir_gen)
-			return 0;
-		ctx->found_idx = num;
-		return 1;
-	}
-	return 0;
-}
-
-static int find_iref(struct btrfs_root *root,
-		     struct btrfs_path *path,
-		     struct btrfs_key *key,
-		     u64 dir, u64 dir_gen, struct fs_path *name)
-{
-	int ret;
-	struct find_ref_ctx ctx;
-
-	ctx.dir = dir;
-	ctx.name = name;
-	ctx.dir_gen = dir_gen;
-	ctx.found_idx = -1;
-	ctx.root = root;
-
-	ret = iterate_inode_ref(root, path, key, 0, __find_iref, &ctx);
-	if (ret < 0)
-		return ret;
-
-	if (ctx.found_idx == -1)
-		return -ENOENT;
-
-	return ctx.found_idx;
-}
-
-static int __record_changed_new_ref(int num, u64 dir, int index,
-				    struct fs_path *name,
-				    void *ctx)
-{
-	u64 dir_gen;
-	int ret;
-	struct send_ctx *sctx = ctx;
-
-	ret = get_inode_info(sctx->send_root, dir, NULL, &dir_gen, NULL,
-			     NULL, NULL, NULL);
-	if (ret)
-		return ret;
-
-	ret = find_iref(sctx->parent_root, sctx->right_path,
-			sctx->cmp_key, dir, dir_gen, name);
-	if (ret == -ENOENT)
-		ret = __record_new_ref_if_needed(num, dir, index, name, sctx);
-	else if (ret > 0)
-		ret = 0;
-
-	return ret;
-}
-
-static int __record_changed_deleted_ref(int num, u64 dir, int index,
-					struct fs_path *name,
-					void *ctx)
-{
-	u64 dir_gen;
-	int ret;
-	struct send_ctx *sctx = ctx;
-
-	ret = get_inode_info(sctx->parent_root, dir, NULL, &dir_gen, NULL,
-			     NULL, NULL, NULL);
-	if (ret)
-		return ret;
-
-	ret = find_iref(sctx->send_root, sctx->left_path, sctx->cmp_key,
-			dir, dir_gen, name);
-	if (ret == -ENOENT)
-		ret = __record_deleted_ref_if_needed(num, dir, index, name,
-						     sctx);
-	else if (ret > 0)
-		ret = 0;
-
-	return ret;
-}
-
 static int record_changed_ref(struct send_ctx *sctx)
 {
 	int ret = 0;
 
 	ret = iterate_inode_ref(sctx->send_root, sctx->left_path,
-			sctx->cmp_key, 0, __record_changed_new_ref, sctx);
+			sctx->cmp_key, 0, __record_new_ref_if_needed, sctx);
 	if (ret < 0)
 		goto out;
 	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path,
-			sctx->cmp_key, 0, __record_changed_deleted_ref, sctx);
+			sctx->cmp_key, 0, __record_deleted_ref_if_needed, sctx);
 	if (ret < 0)
 		goto out;
 	ret = 0;
@@ -4701,10 +4533,10 @@ static int process_all_refs(struct send_ctx *sctx,
 
 	if (cmd == BTRFS_COMPARE_TREE_NEW) {
 		root = sctx->send_root;
-		cb = __record_new_ref;
+		cb = __record_new_ref_if_needed;
 	} else if (cmd == BTRFS_COMPARE_TREE_DELETED) {
 		root = sctx->parent_root;
-		cb = __record_deleted_ref;
+		cb = __record_deleted_ref_if_needed;
 	} else {
 		btrfs_err(sctx->send_root->fs_info,
 				"Wrong command %d in process_all_refs", cmd);
@@ -6544,8 +6376,13 @@ static int record_parent_ref(int num, u64 dir, int index, struct fs_path *name,
 {
 	struct parent_paths_ctx *ppctx = ctx;
 
-	return record_ref(ppctx->sctx->parent_root, dir, name, ppctx->sctx,
-			  ppctx->refs);
+	/*
+	 * Pass 0 as the generation for the directory, we don't care about it
+	 * here as we have no new references to add, we just want to delete all
+	 * references for an inode.
+	 */
+	return record_ref(&ppctx->sctx->rbtree_deleted_refs, ppctx->refs, name,
+			  dir, 0, ppctx->sctx);
 }
 
 /*
-- 
2.35.1


Thanks.


> 
> > Plus this type of scenario should be very rare. It requires having at least
> > hundreds of hard links in an inode in order to trigger the creation of extended
> > references, and then removing and recreating a bunch of those hard links in the
> > send snapshot. How common is that?
> >
> > Is this a case you got into in some user workload, or was it found by reading
> > and inspecting the code?
> >
> 
> It's not common. But it happened in the real world. Some version backup
> applications seem to use large hard links for some purposes.
> 
> > I would like to have in the changelog this alternative mentioned, and if it's
> > not good, then explain why it is not, and why we must follow a different solution.
> >
> 
> > It's probably not easy, because at process_recorded_refs() when we unlink we
> > need to know if any ancestor was orphanized before, which we figure out when
> > we iterate over the "new_refs" list. So it would likely need some reshuffling
> > in the logic of how we do things there.
> >
> > > And
> > > we also need to take two scenarios into consideration. One is the most
> > > common case that one inode has only one reference path. The other is the
> > > worst case that there are ten thousands of hard links of an inode.
> > > (BTRFS_LINK_MAX is 65536) So we'd like to introduce rbtree to store the
> > > computing references. (The tree depth of the worst cases is just 16. And
> >
> > computing -> computed
> >
> > > it takes less memory to store few entries than hash sets.) And in order
> > > not to occupy too much moemory, we also introduce
> >
> > moemory -> memory
> >
> > > __record_new_ref_if_needed() and __record_deleted_ref_if_needed() for
> > > changed_ref() to check and remove the duplications early.
> >
> > Also, the subject:
> >
> > "btrfs: send: fix a bug that sending a link command on existing file path"
> >
> > sounds a bit awkward, mostly because of the "that".
> > Something like the following would be more concise:
> >
> > "btrfs: send: fix sending link commands for existing file paths"
> >
> > >
> > > Reviewed-by: Robbie Ko <robbieko@synology.com>
> > > Signed-off-by: BingJing Chang <bingjingc@synology.com>
> > > ---
> > >  fs/btrfs/send.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 156 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > > index 420a86720aa2..23ae631ef23b 100644
> > > --- a/fs/btrfs/send.c
> > > +++ b/fs/btrfs/send.c
> > > @@ -234,6 +234,9 @@ struct send_ctx {
> > >        * Indexed by the inode number of the directory to be deleted.
> > >        */
> > >       struct rb_root orphan_dirs;
> > > +
> > > +     struct rb_root rbtree_new_refs;
> > > +     struct rb_root rbtree_deleted_refs;
> > >  };
> > >
> > >  struct pending_dir_move {
> > > @@ -2747,6 +2750,8 @@ struct recorded_ref {
> > >       u64 dir;
> > >       u64 dir_gen;
> > >       int name_len;
> > > +     struct rb_node node;
> > > +     struct rb_root *root;
> > >  };
> > >
> > >  static struct recorded_ref *recorded_ref_alloc(void)
> > > @@ -2756,6 +2761,7 @@ static struct recorded_ref *recorded_ref_alloc(void)
> > >       ref = kzalloc(sizeof(*ref), GFP_KERNEL);
> > >       if (!ref)
> > >               return NULL;
> > > +     RB_CLEAR_NODE(&ref->node);
> > >       INIT_LIST_HEAD(&ref->list);
> > >       return ref;
> > >  }
> > > @@ -2764,6 +2770,8 @@ static void recorded_ref_free(struct recorded_ref *ref)
> > >  {
> > >       if (!ref)
> > >               return;
> > > +     if (!RB_EMPTY_NODE(&ref->node))
> > > +             rb_erase(&ref->node, ref->root);
> > >       list_del(&ref->list);
> > >       fs_path_free(ref->full_path);
> > >       kfree(ref);
> > > @@ -4373,12 +4381,152 @@ static int __record_deleted_ref(int num, u64 dir, int index,
> > >                         &sctx->deleted_refs);
> > >  }
> > >
> > > +static int rbtree_ref_comp(const void *k, const struct rb_node *node)
> > > +{
> > > +     const struct recorded_ref *data = k;
> > > +     const struct recorded_ref *ref = rb_entry(node, struct recorded_ref, node);
> > > +     int result;
> > > +
> > > +     if (data->dir > ref->dir)
> > > +             return 1;
> > > +     if (data->dir < ref->dir)
> > > +             return -1;
> > > +     if (data->dir_gen > ref->dir_gen)
> > > +             return 1;
> > > +     if (data->dir_gen < ref->dir_gen)
> > > +             return -1;
> > > +     if (data->name_len > ref->name_len)
> > > +             return 1;
> > > +     if (data->name_len < ref->name_len)
> > > +             return -1;
> > > +     result = strcmp(data->name, ref->name);
> > > +     if (result > 0)
> > > +             return 1;
> > > +     if (result < 0)
> > > +             return -1;
> > > +     return 0;
> > > +}
> > > +
> > > +static bool rbtree_ref_less(struct rb_node *node, const struct rb_node *parent)
> > > +{
> > > +     const struct recorded_ref *entry = rb_entry(node,
> > > +                                                 struct recorded_ref,
> > > +                                                 node);
> > > +
> > > +     return rbtree_ref_comp(entry, parent) < 0;
> > > +}
> > > +
> > > +static int record_ref2(struct rb_root *root, struct list_head *refs,
> >
> > This is a terrible function name.
> >
> > If we end up with this solution, please rename it to something more clear
> > like record_ref_in_tree() for example. Almost anything other than an existing
> > function name followed by a number is a better choice.
> >
> 
> Thank you for the naming.
> 
> > This bug is a very good finding, and has been around since forever.
> >
> > Thanks.
> >
> > > +                          struct fs_path *name, u64 dir, u64 dir_gen,
> > > +                          struct send_ctx *sctx)
> > > +{
> > > +     int ret = 0;
> > > +     struct fs_path *path = NULL;
> > > +     struct recorded_ref *ref = NULL;
> > > +
> > > +     path = fs_path_alloc();
> > > +     if (!path) {
> > > +             ret = -ENOMEM;
> > > +             goto out;
> > > +     }
> > > +
> > > +     ref = recorded_ref_alloc();
> > > +     if (!ref) {
> > > +             ret = -ENOMEM;
> > > +             goto out;
> > > +     }
> > > +
> > > +     ret = get_cur_path(sctx, dir, dir_gen, path);
> > > +     if (ret < 0)
> > > +             goto out;
> > > +     ret = fs_path_add_path(path, name);
> > > +     if (ret < 0)
> > > +             goto out;
> > > +
> > > +     ref->dir = dir;
> > > +     ref->dir_gen = dir_gen;
> > > +     set_ref_path(ref, path);
> > > +     list_add_tail(&ref->list, refs);
> > > +     rb_add(&ref->node, root, rbtree_ref_less);
> > > +     ref->root = root;
> > > +out:
> > > +     if (ret) {
> > > +             if (path && (!ref || !ref->full_path))
> > > +                     fs_path_free(path);
> > > +             recorded_ref_free(ref);
> > > +     }
> > > +     return ret;
> > > +}
> > > +
> > > +static int __record_new_ref_if_needed(int num, u64 dir, int index,
> > > +                                   struct fs_path *name, void *ctx)
> > > +{
> > > +     int ret = 0;
> > > +     struct send_ctx *sctx = ctx;
> > > +     struct rb_node *node = NULL;
> > > +     struct recorded_ref data;
> > > +     struct recorded_ref *ref;
> > > +     u64 dir_gen;
> > > +
> > > +     ret = get_inode_info(sctx->send_root, dir, NULL, &dir_gen, NULL,
> > > +                          NULL, NULL, NULL);
> > > +     if (ret < 0)
> > > +             goto out;
> > > +
> > > +     data.dir = dir;
> > > +     data.dir_gen = dir_gen;
> > > +     set_ref_path(&data, name);
> > > +     node = rb_find(&data, &sctx->rbtree_deleted_refs, rbtree_ref_comp);
> > > +     if (node) {
> > > +             ref = rb_entry(node, struct recorded_ref, node);
> > > +             recorded_ref_free(ref);
> > > +     } else {
> > > +             ret = record_ref2(&sctx->rbtree_new_refs, &sctx->new_refs,
> > > +                               name, dir, dir_gen, sctx);
> > > +     }
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static int __record_deleted_ref_if_needed(int num, u64 dir, int index,
> > > +                         struct fs_path *name,
> > > +                         void *ctx)
> > > +{
> > > +     int ret = 0;
> > > +     struct send_ctx *sctx = ctx;
> > > +     struct rb_node *node = NULL;
> > > +     struct recorded_ref data;
> > > +     struct recorded_ref *ref;
> > > +     u64 dir_gen;
> > > +
> > > +     ret = get_inode_info(sctx->parent_root, dir, NULL, &dir_gen, NULL,
> > > +                          NULL, NULL, NULL);
> > > +     if (ret < 0)
> > > +             goto out;
> > > +
> > > +     data.dir = dir;
> > > +     data.dir_gen = dir_gen;
> > > +     set_ref_path(&data, name);
> > > +     node = rb_find(&data, &sctx->rbtree_new_refs, rbtree_ref_comp);
> > > +     if (node) {
> > > +             ref = rb_entry(node, struct recorded_ref, node);
> > > +             recorded_ref_free(ref);
> > > +     } else {
> > > +             ret = record_ref2(&sctx->rbtree_deleted_refs,
> > > +                               &sctx->deleted_refs, name, dir, dir_gen,
> > > +                               sctx);
> > > +     }
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > >  static int record_new_ref(struct send_ctx *sctx)
> > >  {
> > >       int ret;
> > >
> > >       ret = iterate_inode_ref(sctx->send_root, sctx->left_path,
> > > -                             sctx->cmp_key, 0, __record_new_ref, sctx);
> > > +                             sctx->cmp_key, 0, __record_new_ref_if_needed,
> > > +                             sctx);
> > >       if (ret < 0)
> > >               goto out;
> > >       ret = 0;
> > > @@ -4392,7 +4540,8 @@ static int record_deleted_ref(struct send_ctx *sctx)
> > >       int ret;
> > >
> > >       ret = iterate_inode_ref(sctx->parent_root, sctx->right_path,
> > > -                             sctx->cmp_key, 0, __record_deleted_ref, sctx);
> > > +                             sctx->cmp_key, 0,
> > > +                             __record_deleted_ref_if_needed, sctx);
> > >       if (ret < 0)
> > >               goto out;
> > >       ret = 0;
> > > @@ -4475,7 +4624,7 @@ static int __record_changed_new_ref(int num, u64 dir, int index,
> > >       ret = find_iref(sctx->parent_root, sctx->right_path,
> > >                       sctx->cmp_key, dir, dir_gen, name);
> > >       if (ret == -ENOENT)
> > > -             ret = __record_new_ref(num, dir, index, name, sctx);
> > > +             ret = __record_new_ref_if_needed(num, dir, index, name, sctx);
> > >       else if (ret > 0)
> > >               ret = 0;
> > >
> > > @@ -4498,7 +4647,8 @@ static int __record_changed_deleted_ref(int num, u64 dir, int index,
> > >       ret = find_iref(sctx->send_root, sctx->left_path, sctx->cmp_key,
> > >                       dir, dir_gen, name);
> > >       if (ret == -ENOENT)
> > > -             ret = __record_deleted_ref(num, dir, index, name, sctx);
> > > +             ret = __record_deleted_ref_if_needed(num, dir, index, name,
> > > +                                                  sctx);
> > >       else if (ret > 0)
> > >               ret = 0;
> > >
> > > @@ -7576,6 +7726,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
> > >       sctx->pending_dir_moves = RB_ROOT;
> > >       sctx->waiting_dir_moves = RB_ROOT;
> > >       sctx->orphan_dirs = RB_ROOT;
> > > +     sctx->rbtree_new_refs = RB_ROOT;
> > > +     sctx->rbtree_deleted_refs = RB_ROOT;
> > >
> > >       sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
> > >                                    arg->clone_sources_count + 1,
> > > --
> > > 2.37.0
> > >
