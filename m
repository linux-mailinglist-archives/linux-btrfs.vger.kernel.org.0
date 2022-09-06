Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE78A5AF256
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 19:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiIFRYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbiIFRXu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 13:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A068A6F4
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 10:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D578F615A4
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 17:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94F8C433C1;
        Tue,  6 Sep 2022 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662484397;
        bh=mcueDLvP661P32bo+AnNzN/EKaXX43pS3+lv6/VJ5fA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+wx+t+yKFZcn1oGTDEX4okzfgnPhplJ/5aaul9SDh1SMxfXhPpteceCjdxjcYZyG
         k52hj2SZk5Vz7QPKSthNZweNNWu9oPbvxiza9T9V/IL1d80UpDbfvKpR9WYWO/wVfS
         5yaPrv5tmYSsTDfqtg9B1wRAMIFd8fIPFpEcYQn3lqbYkiqMJ1vRqZ0Y6QwP1LzvA3
         g+vUbsvBrQfg7F8OWMUkgzZUBxRfxnZ6spkuRUasQ7aJCCdMU7w/pL3AcTA5grolFR
         P5+cLLAw2UXo5dheW7wB+tVFY0hRQ3gbpJWpKAhw8wjFLRkm++zZjtyCZMG5geDzKs
         nzXvF/0DF5mdQ==
Date:   Tue, 6 Sep 2022 18:13:14 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/10] btrfs: make lseek and fiemap much more efficient
Message-ID: <20220906171314.GA50948@falcondesktop>
References: <cover.1662022922.git.fdmanana@suse.com>
 <20220906162006.GS13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906162006.GS13489@twin.jikos.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 06, 2022 at 06:20:06PM +0200, David Sterba wrote:
> On Thu, Sep 01, 2022 at 02:18:20PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > We often get reports of fiemap and hole/data seeking (lseek) being too slow
> > on btrfs, or even unusable in some cases due to being extremely slow.
> > 
> > Some recent reports for fiemap:
> > 
> >     https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
> >     https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> > 
> > For lseek (LSF/MM from 2017):
> > 
> >    https://lwn.net/Articles/718805/
> > 
> > Basically both are slow due to very high algorithmic complexity which
> > scales badly with the number of extents in a file and the heigth of
> > subvolume and extent b+trees.
> > 
> > Using Pavel's test case (first Link tag for fiemap), which uses files with
> > many 4K extents and holes before and after each extent (kind of a worst
> > case scenario), the speedup is of several orders of magnitude (for the 1G
> > file, from ~225 seconds down to ~0.1 seconds).
> > 
> > Finally the new algorithm for fiemap also ends up solving a bug with the
> > current algorithm. This happens because we are currently relying on extent
> > maps to report extents, which can be merged, and this may cause us to
> > report 2 different extents as a single one that is not shared but one of
> > them is shared (or the other way around). More details on this on patches
> > 9/10 and 10/10.
> > 
> > Patches 1/10 and 2/10 are for lseek, introducing some code that will later
> > be used by fiemap too (patch 10/10). More details in the changelogs.
> 
> The speedup is unbelievable, thank you very much!

I left something for cleanup in patch 10/10:

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 50bb2182e795..62a643020e10 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5408,14 +5408,12 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
         *    So truly compressed (physical size smaller than logical size)
         *    extents won't get merged with each other
         *
-        * 3) Share same flags except FIEMAP_EXTENT_LAST
-        *    So regular extent won't get merged with prealloc extent
+        * 3) Share same flags
         */
        if (cache->offset + cache->len  == offset &&
            cache->phys + cache->len == phys  &&
            cache->flags == flags) {
                cache->len += len;
-               cache->flags |= flags;
                return 0;
        }
 

Can you fold this up to 10/10, or do you want to me resend or send separately?
Thanks.
