Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BBD59D3C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbiHWIQj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 04:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242340AbiHWIOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 04:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EABE0E0
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 01:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C12726129A
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 08:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97A8C433D6;
        Tue, 23 Aug 2022 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661242176;
        bh=HCBT+4WDFK3SiPmq++GMAid/ekHAKg3Psi1S5WQnfiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cq3/2V0v6e1yXql8xpWbwlcXXxAGqJg/FnmzDpHDjBjsqvyacCvBgYv8TYaD5WB40
         Kfi+HZyNCbmJF9eiVVM38J8Upa0pBPJWlVyWuH+1/OwOASuty5QLV5OgWjluZHlTB8
         yQIhu62drSQST4vBKSqZjh7Knha0ul7k+qgg6LRwo4Ca1EdAeTHunMjz9FlueByuNs
         6RAW/kmeTuydJlJtHGzUly0KbvycapER3fQxEAxAsHJlW78XUuUk5PhdHP4ht5X7w2
         ShYu+LHwh8J1aRas/otw9bZ5SWQbz1dFapbk6wtuMBa0FQ3UYTDgYhTj3LgwbhA2ed
         iWb1do07/r5bQ==
Date:   Tue, 23 Aug 2022 09:09:33 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: simplify error handling at
 btrfs_del_root_ref()
Message-ID: <20220823080933.GA3171944@falcondesktop>
References: <cover.1661179270.git.fdmanana@suse.com>
 <5a96945dcc12befa8fd85f6c3766b52c1b652e41.1661179270.git.fdmanana@suse.com>
 <73c13724-8bd4-ae1e-f35f-8d22d3b9a3d2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c13724-8bd4-ae1e-f35f-8d22d3b9a3d2@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 23, 2022 at 07:54:12AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/8/22 22:47, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > At btrfs_del_root_ref() we are using two return variables, named 'ret' and
> > 'err'. This makes it harder to follow and easier to return the wrong value
> > in case an error happens - the previous patch in the series, which has the
> > subject "btrfs: fix silent failure when deleting root reference", fixed a
> > bug due to confusion created by these two variables.
> > 
> > So change the function to use a single variable for tracking the return
> > value of the function, using only 'ret', which is consistent with most of
> > the codebase.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Although one small nitpick inlined below.
> 
> > ---
> >   fs/btrfs/root-tree.c | 16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > index d647cb2938c0..e1f599d7a916 100644
> > --- a/fs/btrfs/root-tree.c
> > +++ b/fs/btrfs/root-tree.c
> > @@ -337,7 +337,6 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
> >   	struct extent_buffer *leaf;
> >   	struct btrfs_key key;
> >   	unsigned long ptr;
> > -	int err = 0;
> >   	int ret;
> > 
> >   	path = btrfs_alloc_path();
> > @@ -350,7 +349,6 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
> >   again:
> >   	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
> >   	if (ret < 0) {
> > -		err = ret;
> >   		goto out;
> >   	} else if (ret == 0) {
> >   		leaf = path->nodes[0];
> > @@ -360,18 +358,18 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
> >   		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
> >   		    (btrfs_root_ref_name_len(leaf, ref) != name_len) ||
> >   		    memcmp_extent_buffer(leaf, name, ptr, name_len)) {
> > -			err = -ENOENT;
> > +			ret = -ENOENT;
> >   			goto out;
> >   		}
> >   		*sequence = btrfs_root_ref_sequence(leaf, ref);
> > 
> >   		ret = btrfs_del_item(trans, tree_root, path);
> > -		if (ret) {
> > -			err = ret;
> > +		if (ret)
> >   			goto out;
> > -		}
> > -	} else
> > -		err = -ENOENT;
> > +	} else {
> > +		ret = -ENOENT;
> > +		goto out;
> > +	}
> > 
> >   	if (key.type == BTRFS_ROOT_BACKREF_KEY) {
> >   		btrfs_release_path(path);
> 
> To the if () check here can also be a cause of confusion.
> 
> Can we split it into two dedicated btrfs_search_slot() calls (instead of
> current goto again with different keys) in a separate patch?
> 
> I guess that's why the v1 version had some error got overriden, right?

The problem in v1 was because I didn't think properly.
I was under the wrong idea that we could have either one key type or
the other, that it was to deal with some old format - like the v0
backref thing.

Then I realized we got all v0 compatibility stuff removed some years ago,
and that this is something different - both keys must always exist.
In other words, it was not because of the if + goto or because of having
two variables for the return value.

I'm not sure getting rid of the if + goto logic and duplicating the deletion
is better. It would duplicate a lot of code. Either way, my intention of
this patch is really just to have a single variable for the return value
instead of two.

> 
> Thanks,
> Qu
> > @@ -383,7 +381,7 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
> > 
> >   out:
> >   	btrfs_free_path(path);
> > -	return err;
> > +	return ret;
> >   }
> > 
> >   /*
