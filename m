Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF90653A08F
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351131AbiFAJek (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 05:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbiFAJek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 05:34:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503A28FD67
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 02:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BAEA1CE1A3F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 09:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB643C3411D;
        Wed,  1 Jun 2022 09:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654076076;
        bh=1I0thsQTAHVl4c1iLaQa2Vbcdxj5quNgiycPajU/Vcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gOjJCxz4UsdlCf6Oc3qrV9WP2Ca/kKV6sQDE9GcscPCovqUHhfoZDZCbjk5R1rfEd
         bx8x3erN2Zm5UwtUTZGCA2Sy65qt9BBG6W8iO7dZM035rW4zSY2W9NNsdkdiRizK33
         HFvdJXCsZbCx65n9pSs/bdPV0FIzed1JJiyKx7dpKhWl9Xi96RocrI3CD30i/eQWId
         gOEStbV6FsBYExbMdiNVPRiQ1q1DtOsL9+/12f5Lap/aAhky9T9qP+bgKgGq35c1PD
         68J3Fi3l92xyuIB+4uaPqPHaTjO+BbTYCDfQaqxQiJcotQ1zd+2m8aMZ3xmyFuNSef
         5q2y5wXDyY3Dw==
Date:   Wed, 1 Jun 2022 10:34:33 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/12] btrfs: free the path earlier when creating a new
 inode
Message-ID: <20220601093433.GA3279070@falcondesktop>
References: <cover.1654009356.git.fdmanana@suse.com>
 <b3c7ae5b6d09c442fc7546660dd5535302d11a7e.1654009356.git.fdmanana@suse.com>
 <44eeb8b2-e826-4aa0-56dd-5ec90e157018@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44eeb8b2-e826-4aa0-56dd-5ec90e157018@oracle.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 01, 2022 at 04:52:54AM +0530, Anand Jain wrote:
> On 5/31/22 20:36, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > When creating an inode, through btrfs_create_new_inode(), we release the
> > path we allocated before once we don't need it anymore. But we keep it
> > allocated until we return from that function, which is wasteful because
> > after we release the path we do several things that can allocate yet
> > another path: inheriting properties, setting the xattrs used by ACLs and
> > secutiry modules, adding an orphan item (O_TMPFILE case) or adding a
> > dir item (for the non-O_TMPFILE case).
> > 
> > So instead of releasing the path once we don't need it anymore, free it
> > instead. This way we avoid having two paths allocated until we return
> > from btrfs_create_new_inode().
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/inode.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 06d5bfa84d38..3ede3e873c2a 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -6380,7 +6380,13 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
> >   	}
> >   	btrfs_mark_buffer_dirty(path->nodes[0]);
> > -	btrfs_release_path(path);
> > +	/*
> > +	 * We don't need the path anymore, plus inheriting properties, adding
> > +	 * ACLs, security xattrs, orphan item or adding the link, will result in
> > +	 * allocating yet another path. So just free our path.
> > +	 */
> > +	btrfs_free_path(path);
> > +	path = NULL;
> >   	if (args->subvol) {
> >   		struct inode *parent;
> 
> 
> 
> > @@ -6437,8 +6443,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
> >   		goto discard;
> >   	}
> 
> At discard, we free path again and leads to double free.

No, there's no double free. The path was set to NULL after being freed.

> 
> Thanks, Anand
> 
> >  > -	ret = 0;
> > -	goto out;
> > +	return 0;
> >   discard:
> >   	/*
> 
