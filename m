Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17617AD97A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjIYNtK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjIYNtJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 09:49:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E8B3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 06:49:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E86781F74D;
        Mon, 25 Sep 2023 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695649741;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeXcUEb9nv0wLu67KLDRR+4wstzdTNVRRcbIwg+j7H8=;
        b=Q8b/h/u8XiYqAr2MY3XUnHps63T4i1DF+REOpNKML9Oe0XJLhtear4lK1jQ6YouNGwwr+v
        guY3bezzkgEzJ9hWBrAMePOPP3d0XLc0dzfMqK5Kexcr3z2D0svt2MhjDGEBz+/pxvhsAP
        NjIh9eSYQK5sfv18A6wqt7aVHf9i1ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695649741;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeXcUEb9nv0wLu67KLDRR+4wstzdTNVRRcbIwg+j7H8=;
        b=CAHzrNYGE3nrnFJH+d5MpTx0PS/zy9iVJvWivEhUkjvVjHyfQLP2OZt/NO59xUSHllxQwI
        LcuOhCt0cvjTsyBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C75371358F;
        Mon, 25 Sep 2023 13:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 97LlL82PEWW9HAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Sep 2023 13:49:01 +0000
Date:   Mon, 25 Sep 2023 15:42:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/8] btrfs: relocation: use on-stack iterator in
 build_backref_tree
Message-ID: <20230925134224.GL13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695380646.git.dsterba@suse.com>
 <7588cec46a2d548400de33930811fa12026f1dd1.1695380646.git.dsterba@suse.com>
 <0dc65467-c8ba-4fbb-9475-e753c91d4a77@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc65467-c8ba-4fbb-9475-e753c91d4a77@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 23, 2023 at 08:05:25AM +0930, Qu Wenruo wrote:
> On 2023/9/22 20:37, David Sterba wrote:
> > build_backref_tree() is called in a loop by relocate_tree_blocks()
> > for each relocated block. The iterator is allocated and freed repeatedly
> > while we could simply use an on-stack variable to avoid the allocation
> > and remove one more failure case. The stack grows by 48 bytes.
> >
> > This was the only use of btrfs_backref_iter_alloc() so it's changed to
> > be an initializer and btrfs_backref_iter_free() can be removed
> > completely.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/backref.c    | 26 ++++++++++----------------
> >   fs/btrfs/backref.h    | 11 ++---------
> >   fs/btrfs/relocation.c | 12 ++++++------
> >   3 files changed, 18 insertions(+), 31 deletions(-)
> >
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index 0dc91bf654b5..691b20b47065 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -2828,26 +2828,20 @@ void free_ipath(struct inode_fs_paths *ipath)
> >   	kfree(ipath);
> >   }
> >
> > -struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info)
> > +int btrfs_backref_iter_init(struct btrfs_fs_info *fs_info,
> > +			    struct btrfs_backref_iter *iter)
> >   {
> > -	struct btrfs_backref_iter *ret;
> > -
> > -	ret = kzalloc(sizeof(*ret), GFP_NOFS);
> > -	if (!ret)
> > -		return NULL;
> > -
> > -	ret->path = btrfs_alloc_path();
> > -	if (!ret->path) {
> > -		kfree(ret);
> > -		return NULL;
> > -	}
> > +	memset(iter, 0, sizeof(struct btrfs_backref_iter));
> > +	iter->path = btrfs_alloc_path();
> > +	if (!iter->path)
> > +		return -ENOMEM;
> 
> We can do one step further, by integrating the btrfs_path into @iter,
> other than re-allocating it again and again.

Possible but needs to be evaluated separately, the size of path is 112
and this starts to become noticeable on the stack.
