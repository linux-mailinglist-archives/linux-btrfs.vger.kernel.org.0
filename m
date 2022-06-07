Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE75403F7
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345131AbiFGQlq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 12:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbiFGQlp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 12:41:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830ABDFD36
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 09:41:43 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E5CDB5C0153;
        Tue,  7 Jun 2022 12:41:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Jun 2022 12:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1654620102; x=1654706502; bh=Ei+8Put7t+
        +6Lh0PErTVKfXo3pUgp0Njss2nXk/2brQ=; b=XaUDPgCElhwYEAlYXvUyrm27mg
        GFNy9RIRAZuyOdcVJfM1m9k6Nr2hCX5VAEmrvB4IVMpS8vRWIU4uh23orbif8A7o
        juIdhfC7jkYlTybz0+5djdyFi628LOevTC6dwr2pEMqz1mERr6qm6FenvQ2pViWm
        rjQL42T6P7otzFIvahl2alpfTLp0qJoeWC0sclzvCVJg2H8JNP4bsZD8a6WlgIZP
        8Hbz/kaSa7eqXK6AGoE6qYveDp5o+JLuBinNG/ghqTSFD2IPE3nvVrINIIc9I9O2
        ApWtogcZzTToQNOj36KkFmBR71NCLWfJAqdFzCUnhMqgD8PT5Mm5TCdf0bjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654620102; x=1654706502; bh=Ei+8Put7t++6Lh0PErTVKfXo3pUg
        p0Njss2nXk/2brQ=; b=j8SXhpq+rAPSfIolY9LEVBqS7VEBwdfoNw0Y/MBK5bXS
        Ynp4ktN5onNhAg66KN/ImEBgRLKomf4NA5o4f11SGAmLogirv7OipLJm6bVabTcv
        PUAfj+SixrB1hH/uz0IwvlgrG+70a2ufbXhpHMk03WQa37IHZmL+9KUlxbSLjBLm
        bF3zRdRdWZz02I9WKyIi0CIZezf1QMucCft6P3GISnQViYYGp1soK8Udv90oDSah
        lhgM33KFhJu74IjvXLLNA71j3GLaYZlTEn41x6s9cDm8rGJ8z9Z6A3IQ4qVRdJpm
        biyOhdbJeLr68DZPXTtG3RQfkJ6t21KUSQmfl/+rew==
X-ME-Sender: <xms:xn-fYoQtNERIYSaY3CuhM3oth6P5SLET-gsbNSK5P9MFNRLo_aBl4Q>
    <xme:xn-fYlwVwqBeT8MpF5zQ5OykWiasFBsK-XFZhsrADB8lcWU-rw2fnvr2N2U41czkR
    6CwThmftZkyHGytuKI>
X-ME-Received: <xmr:xn-fYl0YBEIjrTKCoaZaNiuCyRn4mxqxu3d-bt-U6HH6cllQhnm7V8CQrjiC1n4h7rRQU-W4ptGkE6a0XXrRa-FScOOBCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:xn-fYsBZQSoISRD27qT05htJC71MEQxWHIiP1TaJp5iBa7D3ZhQfLA>
    <xmx:xn-fYhh7uS32iw0Rayc9ohokzDROSC7iZkPJ1Q2qf331PZ-amdufhA>
    <xmx:xn-fYoqVl-foJ2pch-TDK5gXhbLlFx9iszF85ZmhEwoZ8UGDR_4j-g>
    <xmx:xn-fYhIEZ35MCtKWdSfikGEP7Gh0qZbEDtrfU1a0r0mDjynv5NvLxg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jun 2022 12:41:42 -0400 (EDT)
Date:   Tue, 7 Jun 2022 09:41:40 -0700
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: add missing inode updates on each iteration
 when replacing extents
Message-ID: <Yp9/xIkX137VLByJ@zen>
References: <cover.1654508104.git.fdmanana@suse.com>
 <980e6be197825045a08ad6d463456bc73521e4d4.1654508104.git.fdmanana@suse.com>
 <Yp57qB5gjZ1wpnja@zen>
 <20220607093139.GA3554947@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093139.GA3554947@falcondesktop>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 10:31:39AM +0100, Filipe Manana wrote:
> On Mon, Jun 06, 2022 at 03:11:52PM -0700, Boris Burkov wrote:
> > On Mon, Jun 06, 2022 at 10:41:18AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > > 
> > > When replacing file extents, called during fallocate, hole punching,
> > > clone and deduplication, we may not be able to replace/drop all the
> > > target file extent items with a single transaction handle. We may get
> > > -ENOSPC while doing it, in which case we release the transaction handle,
> > > balance the dirty pages of the btree inode, flush delayed items and get
> > > a new transaction handle to operate on what's left of the target range.
> > > 
> > > By dropping and replacing file extent items we have effectively modified
> > 
> > How can you be sure that you definitely modified it? Is it possible for
> > btrfs_drop_extents to return ENOSPC without dropping extents?
> 
> If btrfs_drop_extents() fails with -ENOSPC, it means it tried to modify
> more than one leaf. Since we reserved enough space for modifying one leaf,
> it can only fail if it tries to modify more leaves, and if it tries to do
> so, it means it dropped or trimmed file extent items from a leaf already.
> 
> > 
> > > the inode, so we should bump its iversion and update its mtime/ctime
> > > before we update the inode item. This is because if the transaction
> > > we used for partially modifying the inode gets committed by someone after
> > > we release it and before we finish the rest of the range, a power failure
> > > happens, then after mounting the filesystem our inode has an outdated
> > > iversion and mtime/ctime, corresponding to the values it had before we
> > > changed it.
> > > 
> > > So add the missing iversion and mtime/ctime updates.
> > > 
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> > > ---
> > >  fs/btrfs/ctree.h   |  2 ++
> > >  fs/btrfs/file.c    | 19 +++++++++++++++++++
> > >  fs/btrfs/inode.c   |  1 +
> > >  fs/btrfs/reflink.c |  1 +
> > >  4 files changed, 23 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > index 55dee1564e90..737cd59d16b6 100644
> > > --- a/fs/btrfs/ctree.h
> > > +++ b/fs/btrfs/ctree.h
> > > @@ -1330,6 +1330,8 @@ struct btrfs_replace_extent_info {
> > >  	 * existing extent into a file range.
> > >  	 */
> > >  	bool is_new_extent;
> > > +	/* Indicate if we should update the inode's mtime and ctime. */
> > > +	bool update_times;
> > >  	/* Meaningful only if is_new_extent is true. */
> > >  	int qgroup_reserved;
> > >  	/*
> > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > index 1fd827b99c1b..29de433b7804 100644
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -2803,6 +2803,25 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
> > >  			extent_info->file_offset += replace_len;
> > >  		}
> > >  
> > > +		/*
> > > +		 * We are releasing our handle on the transaction, balance the
> > > +		 * dirty pages of the btree inode and flush delayed items, and
> > > +		 * then get a new transaction handle, which may now point to a
> > > +		 * new transaction in case someone else may have committed the
> > > +		 * transaction we used to replace/drop file extent items. So
> > > +		 * bump the inode's iversion and update mtime and ctime except
> > > +		 * if we are called from a dedupe context. This is because a
> > > +		 * power failure/crash may happen after the transaction is
> > > +		 * committed and before we finish replacing/dropping all the
> > > +		 * file extent items we need.
> > > +		 */
> > > +		inode_inc_iversion(&inode->vfs_inode);
> > > +
> > > +		if (!extent_info || extent_info->update_times) {
> > > +			inode->vfs_inode.i_mtime = current_time(&inode->vfs_inode);
> > > +			inode->vfs_inode.i_ctime = inode->vfs_inode.i_mtime;
> > > +		}
> > > +
> > >  		ret = btrfs_update_inode(trans, root, inode);
> > >  		if (ret)
> > >  			break;
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 3ede3e873c2a..ab4ebcb7878c 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -9907,6 +9907,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
> > >  	extent_info.file_offset = file_offset;
> > >  	extent_info.extent_buf = (char *)&stack_fi;
> > >  	extent_info.is_new_extent = true;
> > > +	extent_info.update_times = true;
> > >  	extent_info.qgroup_reserved = qgroup_released;
> > >  	extent_info.insertions = 0;
> > >  
> > > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > > index 7e3b0aa318c1..977e0d218d79 100644
> > > --- a/fs/btrfs/reflink.c
> > > +++ b/fs/btrfs/reflink.c
> > > @@ -497,6 +497,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
> > >  			clone_info.file_offset = new_key.offset;
> > >  			clone_info.extent_buf = buf;
> > >  			clone_info.is_new_extent = false;
> > > +			clone_info.update_times = !no_time_update;
> > >  			ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
> > >  					drop_start, new_key.offset + datal - 1,
> > >  					&clone_info, &trans);
> > > -- 
> > > 2.35.1
> > > 
