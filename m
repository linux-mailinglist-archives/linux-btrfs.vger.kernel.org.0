Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB3D604B31
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiJSPXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiJSPX1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 11:23:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72F190E50
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 08:16:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8E03200B7;
        Wed, 19 Oct 2022 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666192576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yI/Yqx049ChVZjbkQi3zj4m/G+6Hb3gvJsWBVHASC9I=;
        b=IlKTsHe5eV7dSF6ROLzQmHwCu4R76Jwf4ioO3TWeKpqqLQfuGuNFW8IoGU7aAzWAp82dhL
        pmS8/LD1Z7VzaJtcvvyT9pZooAdKckDl3bhKg/lxdppIVsFxi1DfKfx8FZC7lcZ2sBnsxS
        MxfrehO8ZjcpTK/Kp0j7OJqG/qxYE+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666192576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yI/Yqx049ChVZjbkQi3zj4m/G+6Hb3gvJsWBVHASC9I=;
        b=G/1QXTjuR7rYm9/L3gz0Pec1F9WjizN2UrErmZOhY03nufLikF0vD8us4dS1I7OR0DQN3F
        Lt97qHHIFw3AGkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFE1413345;
        Wed, 19 Oct 2022 15:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JLvQLcAUUGONSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 19 Oct 2022 15:16:16 +0000
Date:   Wed, 19 Oct 2022 17:16:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] Parameter cleanup
Message-ID: <20221019151606.GC13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666103172.git.dsterba@suse.com>
 <4be6c68f-efe7-5dfa-e4cc-054e3f6badcb@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4be6c68f-efe7-5dfa-e4cc-054e3f6badcb@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 19, 2022 at 10:28:53AM +0000, Johannes Thumshirn wrote:
> On 18.10.22 16:27, David Sterba wrote:
> > A few more cases where value passed by parameter can be used directly.
> > 
> > David Sterba (4):
> >   btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
> >   btrfs: sink gfp_t parameter to btrfs_qgroup_trace_extent
> >   btrfs: switch GFP_NOFS to GFP_KERNEL in scrub_setup_recheck_block
> >   btrfs: sink gfp_t parameter to alloc_scrub_sector
> > 
> >  fs/btrfs/backref.c    |  5 ++---
> >  fs/btrfs/backref.h    |  3 +--
> >  fs/btrfs/qgroup.c     | 17 +++++++----------
> >  fs/btrfs/qgroup.h     |  2 +-
> >  fs/btrfs/relocation.c |  2 +-
> >  fs/btrfs/scrub.c      | 14 +++++++-------
> >  fs/btrfs/tree-log.c   |  3 +--
> >  7 files changed, 20 insertions(+), 26 deletions(-)
> > 
> 
> What base is this on?
> 
> I got the following when applying it for review:
> 
> [johannes@redsun91:linux (review)]$ b4 am -o - cover.1666103172.git.dsterba@suse.com | git am
> Looking up https://lore.kernel.org/r/cover.1666103172.git.dsterba%40suse.com
> Grabbing thread from lore.kernel.org/all/cover.1666103172.git.dsterba%40suse.com/t.mbox.gz
> Analyzing 5 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH 1/4] btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
>   ✓ [PATCH 2/4] btrfs: sink gfp_t parameter to btrfs_qgroup_trace_extent
>   ✓ [PATCH 3/4] btrfs: switch GFP_NOFS to GFP_KERNEL in scrub_setup_recheck_block
>   ✓ [PATCH 4/4] btrfs: sink gfp_t parameter to alloc_scrub_sector
>   ---
>   ✓ Signed: DKIM/suse.com
> ---
> Total patches: 4
> ---
>  Link: https://lore.kernel.org/r/cover.1666103172.git.dsterba@suse.com
>  Base: not specified
> Applying: btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
> 
> Error in reading or end of file.
> fs/btrfs/relocation.c: In function ‘build_backref_tree’:
> fs/btrfs/relocation.c:474:16: error: too many arguments to function ‘btrfs_backref_iter_alloc’
>   474 |         iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from fs/btrfs/relocation.c:25:
> fs/btrfs/backref.h:158:28: note: declared here
>   158 | struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info);
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~

I have it in a branch on top of some misc-next snapshot, the date is
from 3 days ago and rebase to current misc-next is clean and builds.
