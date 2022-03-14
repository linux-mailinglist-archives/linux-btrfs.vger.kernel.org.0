Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137054D8581
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 13:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiCNM4J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 08:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiCNM4I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 08:56:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40C411A16
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 05:54:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8B1931F391;
        Mon, 14 Mar 2022 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647262497;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1o63nSHEUjpo3VxPtLKsy6WTYd6j/MXvpDdOMtrrfWs=;
        b=hj7I4Ly0mWFDVkJ0679a5cuj+AlS4/MSZQrssuUjypNx2ebWRz7E36TAOv8WXiS4TELgAs
        T/9XlfU8icyqIqbZb/rMNGMOH5oZBvtFFRlymNJHh6eGvzSTBfOJBTv5wRelr+ggP0nC1G
        xQRpuB4o1760uM0JuIvrLyQ3SI5bK3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647262497;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1o63nSHEUjpo3VxPtLKsy6WTYd6j/MXvpDdOMtrrfWs=;
        b=bZNz7+4T2EOLfq0WEwZF7MELBP2ukhOvpmv0OqOszdKZLGqBueak+5Ja/HKjYilV/whY/b
        EvJygmUBkInuVYCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E21AA3B83;
        Mon, 14 Mar 2022 12:54:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32831DA7E1; Mon, 14 Mar 2022 13:50:59 +0100 (CET)
Date:   Mon, 14 Mar 2022 13:50:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/16] btrfs: inode creation cleanups and fixes
Message-ID: <20220314125059.GH12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1646875648.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
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

On Wed, Mar 09, 2022 at 05:31:30PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This series contains several cleanups and fixes for our inode creation
> codepaths. The main motivation for this is preparation for fscrypt
> support (in particular, setting up the fscrypt context and encrypted
> names at inode creation time). But, it also reduces a lot of code
> duplication and fixes some minor bugs, so it's worth getting in ahead of
> time.
> 
> Patches 1-3 are small fixes. Patches 5-12 are small cleanups. Patches
> 13-16 are the bulk of the change.
> 
> Based on misc-next.
> 
> Changes since v1 [1]:
> 
> - Split the big final patch into patches 3 and 13-16.
> - Added Sweet Tea's reviewed-by to the remaining patches.
> - Rebased on latest misc-next.
> 
> Thanks!
> 
> 1: https://lore.kernel.org/linux-btrfs/cover.1646348486.git.osandov@fb.com/
> 
> Omar Sandoval (16):
>   btrfs: reserve correct number of items for unlink and rmdir
>   btrfs: reserve correct number of items for rename
>   btrfs: fix anon_dev leak in create_subvol()
>   btrfs: get rid of btrfs_add_nondir()
>   btrfs: remove unnecessary btrfs_i_size_write(0) calls
>   btrfs: remove unnecessary inode_set_bytes(0) call
>   btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
>   btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
>   btrfs: remove redundant name and name_len parameters to create_subvol
>   btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
>   btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
>   btrfs: set inode flags earlier in btrfs_new_inode()
>   btrfs: allocate inode outside of btrfs_new_inode()

Patches 1-13 added to misc-next. The remaining patches seem to be still
a bit big for review.

>   btrfs: factor out common part of btrfs_{mknod,create,mkdir}()
>   btrfs: reserve correct number of items for inode creation
>   btrfs: move common inode creation code into btrfs_create_new_inode()
> 
>  fs/btrfs/acl.c   |  39 +-
>  fs/btrfs/ctree.h |  37 +-
>  fs/btrfs/inode.c | 942 +++++++++++++++++++++++------------------------
>  fs/btrfs/ioctl.c | 176 ++++-----
>  fs/btrfs/props.c |  40 +-
>  fs/btrfs/props.h |   4 -
>  6 files changed, 579 insertions(+), 659 deletions(-)
> 
> -- 
> 2.35.1
