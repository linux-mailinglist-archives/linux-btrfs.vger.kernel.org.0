Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B06B4D8C6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 20:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiCNTcR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiCNTcQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 15:32:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427E0344E7
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 12:31:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F3F1F1F387;
        Mon, 14 Mar 2022 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647286262;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKWkR814tuSUNjOkOLcnue2/AHoasrSKXC44qFFyU3Y=;
        b=ThLsX4aGOX70J4Ln+NMY53UjHMXLPqcnf10wCA8qkbbB4UxI39C/WXVSGf5RY0emXiocu2
        4pZBTVvB54mL6yg7htBwBrJbINdd/yR7LbepC17oXXL2mHCM+dx49JYnutrPl9rlcs0Zau
        JXPws+thUsXmy3lBcv7Aqff764AU5aY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647286262;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKWkR814tuSUNjOkOLcnue2/AHoasrSKXC44qFFyU3Y=;
        b=aneKsaCc0/rDTaNobbQa55ZscZRs365hHJss+RH3Ds77UfAokectNGwzGOJ4l6m7w0LDRy
        ikHTstokf5eK96Bg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E7155A3B87;
        Mon, 14 Mar 2022 19:31:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4B30DA7E1; Mon, 14 Mar 2022 20:27:03 +0100 (CET)
Date:   Mon, 14 Mar 2022 20:27:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/16] btrfs: inode creation cleanups and fixes
Message-ID: <20220314192703.GO12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1646875648.git.osandov@fb.com>
 <20220314125059.GH12643@twin.jikos.cz>
 <Yi+MiU4D4i0tBG7T@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi+MiU4D4i0tBG7T@relinquished.localdomain>
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

On Mon, Mar 14, 2022 at 11:42:17AM -0700, Omar Sandoval wrote:
> On Mon, Mar 14, 2022 at 01:50:59PM +0100, David Sterba wrote:
> > On Wed, Mar 09, 2022 at 05:31:30PM -0800, Omar Sandoval wrote:
> > > - Added Sweet Tea's reviewed-by to the remaining patches.
> > > - Rebased on latest misc-next.
> > > 
> > > Thanks!
> > > 
> > > 1: https://lore.kernel.org/linux-btrfs/cover.1646348486.git.osandov@fb.com/
> > > 
> > > Omar Sandoval (16):
> > >   btrfs: reserve correct number of items for unlink and rmdir
> > >   btrfs: reserve correct number of items for rename
> > >   btrfs: fix anon_dev leak in create_subvol()
> > >   btrfs: get rid of btrfs_add_nondir()
> > >   btrfs: remove unnecessary btrfs_i_size_write(0) calls
> > >   btrfs: remove unnecessary inode_set_bytes(0) call
> > >   btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
> > >   btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
> > >   btrfs: remove redundant name and name_len parameters to create_subvol
> > >   btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
> > >   btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
> > >   btrfs: set inode flags earlier in btrfs_new_inode()
> > >   btrfs: allocate inode outside of btrfs_new_inode()
> > 
> > Patches 1-13 added to misc-next. The remaining patches seem to be still
> > a bit big for review.
> 
> I see that misc-next has the whole series, did you change your mind? I

I added the branch to misc-next on friday and noticed some comments for
the the patches at the end, so I removed them again.
