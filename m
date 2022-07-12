Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AEE57271F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 22:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiGLUTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiGLUTh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 16:19:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992A4C920E;
        Tue, 12 Jul 2022 13:19:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 742FB1F8C4;
        Tue, 12 Jul 2022 20:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657657172;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g8Up8zoFgwsaz54kdPGna8GaNO42glSGkL73QZZzE8E=;
        b=ardXdV44a/EvtyPZ4ppx4vCUj/6hg8INpfuK+ogYx/sxAFHNPsqTo8hD/lfzhTUVlitrzb
        Am2sWWP8WvYHP6vYCSSOu4uqDDMZHAPvwHlXZZFdasoAvtxxTNTMQu3bATp6VyhN/90VCM
        yBOjalLaqsXnAKGPTx7c2MtXJ6mYauE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657657172;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g8Up8zoFgwsaz54kdPGna8GaNO42glSGkL73QZZzE8E=;
        b=r11aLmqP1drE81h23AanP76XVIJ6mWaF8XSkjAgAAXAi0UrNcCeWNorxXHIerHuApWTQth
        s1qk91TW6PtFwUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2430213A94;
        Tue, 12 Jul 2022 20:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /q7JB1TXzWIfWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 12 Jul 2022 20:19:32 +0000
Date:   Tue, 12 Jul 2022 22:14:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     bingjingc <bingjingc@synology.com>
Cc:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        fdmanana@kernel.org, robbieko@synology.com, bxxxjxxg@gmail.com
Subject: Re: [PATCH v2 2/2] btrfs: send: fix sending link commands for
 existing file paths
Message-ID: <20220712201442.GC15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, bingjingc <bingjingc@synology.com>,
        josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        fdmanana@kernel.org, robbieko@synology.com, bxxxjxxg@gmail.com
References: <20220712013632.7042-1-bingjingc@synology.com>
 <20220712013632.7042-3-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712013632.7042-3-bingjingc@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 12, 2022 at 09:36:32AM +0800, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> There is a bug sending link commands for existing file paths. When we're
> processing an inode, we go over all references. All the new file paths are
> added to the "new_refs" list. And all the deleted file paths are added to
> the "deleted_refs" list. In the end, when we finish processing the inode,
> we iterate over all the items in the "new_refs" list and send link commands
> for those file paths. After that, we go over all the items in the
> "deleted_refs" list and send unlink commands for them. If there are
> duplicated file paths in both lists, we will try to create them before we
> remove them. Then the receiver gets an -EEXIST error when trying the link
> operations.
> 
> Example for having duplicated file paths in both list:
> 
>   $ btrfs subvolume create vol
> 
>   # create a file and 2000 hard links to the same inode
>   $ touch vol/foo
>   $ for i in {1..2000}; do link vol/foo vol/$i ; done
> 
>   # take a snapshot for a parent snapshot
>   $ btrfs subvolume snapshot -r vol snap1
> 
>   # remove 2000 hard links and re-create the last 1000 links
>   $ for i in {1..2000}; do rm vol/$i; done;
>   $ for i in {1001..2000}; do link vol/foo vol/$i; done
> 
>   # take another one for a send snapshot
>   $ btrfs subvolume snapshot -r vol snap2
> 
>   $ mkdir receive_dir
>   $ btrfs send snap2 -p snap1 | btrfs receive receive_dir/
>   At subvol snap2
>   link 1238 -> foo
>   ERROR: link 1238 -> foo failed: File exists
> 
> In this case, we will have the same file paths added to both lists. In the
> parent snapshot, reference paths {1..1237} are stored in inode references,
> but reference paths {1238..2000} are stored in inode extended references.
> In the send snapshot, all reference paths {1001..2000} are stored in inode
> references. During the incremental send, we process their inode references
> first. In record_changed_ref(), we iterate all its inode references in the
> send/parent snapshot. For every inode reference, we also use find_iref() to
> check whether the same file path also appears in the parent/send snapshot
> or not. Inode references {1238..2000} which appear in the send snapshot but
> not in the parent snapshot are added to the "new_refs" list. On the other
> hand, Inode references {1..1000} which appear in the parent snapshot but
> not in the send snapshot are added to the "deleted_refs" list. Next, when
> we process their inode extended references, reference paths {1238..2000}
> are added to the "deleted_refs" list because all of them only appear in the
> parent snapshot. Now two lists contain items as below:
> "new_refs" list: {1238..2000}
> "deleted_refs" list: {1..1000}, {1238..2000}
> 
> Reference paths {1238..2000} appear in both lists. And as the processing
> order talked about before, the receiver gets an -EEXIST error when trying
> the link operations.
> 
> To fix the bug, the intuition is to process the "deleted_refs" list before
> the "new_refs" list. However, it's not easy to reshuffle the processing
> order. For one reason, if we do so, we may unlink all the existing paths
> first, there's no valid path anymore for links. And it's inefficient
> because we do a bunch of unlinks followed by links for the same paths.
> Moreover, it makes less sense to have duplications in both lists. A
> reference path cannot not only be regarded as new but also has been seen in
> the past, or we won't call it a new path. However, it's also not a good
> idea to make find_iref() to check a reference against all inode references
> and all inode extended references because it may result in large disk
> reads. So we introduce two rbtrees to make the references easier for
> lookups. And we also introduce __record_new_ref_if_needed() and
> __record_deleted_ref_if_needed() for changed_ref() to check and remove
> duplicated references early.
> 
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>

Added to misc-next with some fixups, thanks.

> +static int rbtree_ref_comp(const void *k, const struct rb_node *node)
> +{
> +	const struct recorded_ref *data = k;
> +	const struct recorded_ref *ref = rb_entry(node, struct recorded_ref, node);
> +	int result;
> +
> +	if (data->dir > ref->dir)
> +		return 1;
> +	if (data->dir < ref->dir)
> +		return -1;
> +	if (data->dir_gen > ref->dir_gen)
> +		return 1;
> +	if (data->dir_gen < ref->dir_gen)
> +		return -1;
> +	if (data->name_len > ref->name_len)
> +		return 1;
> +	if (data->name_len < ref->name_len)
> +		return -1;
> +	result = strcmp(data->name, ref->name);

I think this is the same as

	return strcmp(...);

but I have kept it as is for now.

> +	if (result > 0)
> +		return 1;
> +	if (result < 0)
> +		return -1;
> +	return 0;
> +}
> +
> +static int __record_new_ref_if_needed(int num, u64 dir, int index,

I've dropped the __ and updated all callers, it's not appropriate to be
used here.

> +				      struct fs_path *name, void *ctx)
> +{
> +	int ret = 0;
> +	struct send_ctx *sctx = ctx;
> +	struct rb_node *node = NULL;
> +	struct recorded_ref data;
> +	struct recorded_ref *ref;
> +	u64 dir_gen;
> +
> +	ret = get_inode_info(sctx->send_root, dir, NULL, &dir_gen, NULL,
> +			     NULL, NULL, NULL);

This function got a new parameter in "btrfs: send: add new command
FILEATTR for file attributes", so added NULL in all new instances.

> +	if (ret < 0)
> +		goto out;
> +
> +	data.dir = dir;
> +	data.dir_gen = dir_gen;
> +	set_ref_path(&data, name);
> +	node = rb_find(&data, &sctx->rbtree_deleted_refs, rbtree_ref_comp);
> +	if (node) {
> +		ref = rb_entry(node, struct recorded_ref, node);
> +		recorded_ref_free(ref);
> +	} else {
> +		ret = record_ref_in_tree(&sctx->rbtree_new_refs,
> +					 &sctx->new_refs, name, dir, dir_gen,
> +					 sctx);
> +	}
> +out:
> +	return ret;
> +}
> +
> +static int __record_deleted_ref_if_needed(int num, u64 dir, int index,

Same, dropped __

> +			    struct fs_path *name,
> +			    void *ctx)
> +{
> +	int ret = 0;
> +	struct send_ctx *sctx = ctx;
> +	struct rb_node *node = NULL;
> +	struct recorded_ref data;
> +	struct recorded_ref *ref;
> +	u64 dir_gen;
> +
> +	ret = get_inode_info(sctx->parent_root, dir, NULL, &dir_gen, NULL,
> +			     NULL, NULL, NULL);
> +	if (ret < 0)
> +		goto out;
> +
> +	data.dir = dir;
> +	data.dir_gen = dir_gen;
> +	set_ref_path(&data, name);
> +	node = rb_find(&data, &sctx->rbtree_new_refs, rbtree_ref_comp);
> +	if (node) {
> +		ref = rb_entry(node, struct recorded_ref, node);
> +		recorded_ref_free(ref);
> +	} else {
> +		ret = record_ref_in_tree(&sctx->rbtree_deleted_refs,
> +					 &sctx->deleted_refs, name, dir,
> +					 dir_gen, sctx);
> +	}
> +out:
> +	return ret;
> +}
