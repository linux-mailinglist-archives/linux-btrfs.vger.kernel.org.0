Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105B66065F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 18:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJTQj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJTQjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:39:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935FB4B0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:39:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8420522B63;
        Thu, 20 Oct 2022 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666283960;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4VnXI6IQ/0gGqmZ4lj8xgQT8ZueIO1pNLUz+eE4wTto=;
        b=gAnbF6jNNHkYYTKnRbvvFzFdNiGYp2XtVNluI4GbqszAQ3uQWybSq0ssseGZEj9e3L7q/D
        xzsunI7ypoD7VP7Yg2lrMNleR38BJ+4APINVXcfXvrCm1a1Z74LHLL7rzl9OUg+9ZRmGlv
        w/I85ctbO1LHl39GACkw9h8BQwq4mB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666283960;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4VnXI6IQ/0gGqmZ4lj8xgQT8ZueIO1pNLUz+eE4wTto=;
        b=boAs6kvkjVpHUQGDDiB829pnSPIRtho9eewiKBf8XGZM2d3chvXbpp7TbGCGyjriRvmS1Q
        eTZMLPAur2trwjBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5527813494;
        Thu, 20 Oct 2022 16:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dxreE7h5UWOcKgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Oct 2022 16:39:20 +0000
Date:   Thu, 20 Oct 2022 18:39:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: sink gfp_t parameter to
 btrfs_qgroup_trace_extent
Message-ID: <20221020163909.GN13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666103172.git.dsterba@suse.com>
 <851400b247c547bd420dafa4b7ae78345f4a7ae4.1666103172.git.dsterba@suse.com>
 <0c79b07b-88bc-0fb1-804d-724e046f6b44@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c79b07b-88bc-0fb1-804d-724e046f6b44@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 20, 2022 at 02:01:56PM +0800, Anand Jain wrote:
> On 18/10/2022 22:27, David Sterba wrote:
> > All callers pass GFP_NOFS, we can drop the parameter and use it
> > directly.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/qgroup.c     | 17 +++++++----------
> >   fs/btrfs/qgroup.h     |  2 +-
> >   fs/btrfs/relocation.c |  2 +-
> >   fs/btrfs/tree-log.c   |  3 +--
> >   4 files changed, 10 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 9334c3157c22..34f0e4dabe25 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1840,7 +1840,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
> >   }
> >   
> >   int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
> > -			      u64 num_bytes, gfp_t gfp_flag)
> > +			      u64 num_bytes)
> >   {
> >   	struct btrfs_fs_info *fs_info = trans->fs_info;
> >   	struct btrfs_qgroup_extent_record *record;
> > @@ -1850,7 +1850,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
> >   	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)
> >   	    || bytenr == 0 || num_bytes == 0)
> >   		return 0;
> > -	record = kzalloc(sizeof(*record), gfp_flag);
> > +	record = kzalloc(sizeof(*record), GFP_NOFS);
> >   	if (!record)
> >   		return -ENOMEM;
> >   
> > @@ -1902,8 +1902,7 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
> >   
> >   		num_bytes = btrfs_file_extent_disk_num_bytes(eb, fi);
> >   
> > -		ret = btrfs_qgroup_trace_extent(trans, bytenr, num_bytes,
> > -						GFP_NOFS);
> > +		ret = btrfs_qgroup_trace_extent(trans, bytenr, num_bytes);
> >   		if (ret)
> >   			return ret;
> >   	}
> > @@ -2102,12 +2101,11 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
> >   	 * blocks for qgroup accounting.
> >   	 */
> >   	ret = btrfs_qgroup_trace_extent(trans, src_path->nodes[dst_level]->start,
> > -			nodesize, GFP_NOFS);
> > +					nodesize);
> >   	if (ret < 0)
> >   		goto out;
> > -	ret = btrfs_qgroup_trace_extent(trans,
> > -			dst_path->nodes[dst_level]->start,
> > -			nodesize, GFP_NOFS);
> > +	ret = btrfs_qgroup_trace_extent(trans, dst_path->nodes[dst_level]->start,
> > +					nodesize);
> >   	if (ret < 0)
> >   		goto out;
> >   
> > @@ -2391,8 +2389,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
> >   			path->locks[level] = BTRFS_READ_LOCK;
> >   
> >   			ret = btrfs_qgroup_trace_extent(trans, child_bytenr,
> > -							fs_info->nodesize,
> > -							GFP_NOFS);
> > +							fs_info->nodesize);
> >   			if (ret)
> >   				goto out;
> >   		}
> > diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> > index 3fb5459c9309..7bffa10589d6 100644
> > --- a/fs/btrfs/qgroup.h
> > +++ b/fs/btrfs/qgroup.h
> > @@ -321,7 +321,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
> >    * (NULL trans)
> >    */
> >   int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
> > -			      u64 num_bytes, gfp_t gfp_flag);
> > +			      u64 num_bytes);
> >   
> >   /*
> >    * Inform qgroup to trace all leaf items of data
> 
> 
> 
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 216a4485d914..f5564aa313f5 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -471,7 +471,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
> >   	int ret;
> >   	int err = 0;
> >   
> > -	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
> > +	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info);
> >   	if (!iter)
> >   		return ERR_PTR(-ENOMEM);
> >   	path = btrfs_alloc_path();
> 
> 
>   This change should be part of the patch 1/4.
>   Except that, rest looks good.

Ah I see, that's what was Johannes complained about, I did not realize
that the change was split. I'll fix it.
