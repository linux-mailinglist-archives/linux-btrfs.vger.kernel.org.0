Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509EF4D3945
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 19:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiCISx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 13:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiCISxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 13:53:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3A338
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 10:52:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 64B4B1F384;
        Wed,  9 Mar 2022 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646851974;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8imi6Lc5pld1OPYyRUvSlDkm1gDlsvsAj/bDIf+vyj4=;
        b=y8im7wz3jWhaIbqd5fA2OJuDjE+bXkiB6m6fBy/F8XFCbKFuHGATubp+aMgBvO3ha+X0Rd
        CKGHKKMHRmAxHZYyppMo1qvLwAI3XaYQ2Dr6wY9d8uh1bzEBTnwnGfOJsnMrbOeWytSl7O
        PEZjR/O2jE5Nh0t73ifYDa6bVgv9tQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646851974;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8imi6Lc5pld1OPYyRUvSlDkm1gDlsvsAj/bDIf+vyj4=;
        b=xCC3rIYSfdg5trJMb2Aga6GGjIwOpaVcXcLbf56R1i8xNcWVjYdOyyfxsAuEQiqXc3QK1Z
        dJbF8ANtxMXsHWDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6188BA3B83;
        Wed,  9 Mar 2022 18:52:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ADF98DA7DE; Wed,  9 Mar 2022 19:48:58 +0100 (CET)
Date:   Wed, 9 Mar 2022 19:48:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 00/19] btrfs-progs: extent tree v2 support, global
 roots
Message-ID: <20220309184858.GA12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1646690972.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
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

On Mon, Mar 07, 2022 at 05:10:45PM -0500, Josef Bacik wrote:
> v4->v3:
> - Rebase onto devel, depends on "btrfs-progs: cleanup btrfs_item* accessors".
> - Dropped the various patches that have already been merged into -progs.
> 
> v3->v4:
> - Rebase onto devel, depends on the v3 prep patches that were sent on December
>   1st which has the rest of the "don't access ->*_root" patches.
> - I think I screwed up the versioning of this, but I lost the other submission,
>   so call this v3.
> 
> v1->v2:
> - These depend on the v3 of the prep patches (it's marked as v2 because I'm
>   stupid, but the second v2 posting I sent.)
> - I've moved the global root rb tree patches into this series to differentiate
>   them from the actual fixes in the prep series.
> 
> --- Original email ---
> Hello,
> 
> These patches are the first chunk of the extent tree v2 format changes.  This
> includes the separate block group root which will hold all of the block group
> items.  This also includes the global root support, which is the work to allow
> us to have multiple extent, csum, and free space trees in the same file system.
> 
> The goal of these two changes are straightforward.  For the block group root, on
> very large file systems the block group items are very widely separated, which
> means it takes a very long time to mount the file system on large, slow disks.
> Putting the block group items in their own root will allow us to densely
> populate the tree and dramatically increase mount times in these cases.
> 
> The global roots change is motivated by lock contention on the root nodes of
> these global roots.  I've had to make many changes to how we run delayed refs to
> speed up things like the transaction commit because of all the delayed refs
> going into one tree and contending on the root node of the extent tree.  In the
> same token you can have heavy lock contention on the csum roots when writing to
> many files.  Allowing for multiple roots will let us spread the lock contention
> load around.
> 
> I have disabled a few key features, namely balance and qgroups.  There will be
> more to come as I make more and more invasive changes, and then they will slowly
> be re-enabled as the work is added.  These are disabled to avoid a bunch of work
> that would be thrown away by future changes.
> 
> These patches have passed xfstests without panicing, but clearly failing a lot
> of tests because of the disabled features.  I've also run it through fsperf to
> validate that there are no major performance regressions.
> 
> WARNING: there are many more format changes planned, this is just the first
> batch.  If you want to test then please feel free, but know that the format is
> still in flux.  Thanks,
> 
> Josef
> 
> Josef Bacik (19):
>   btrfs-progs: add support for loading the block group root
>   btrfs-progs: add print support for the block group tree
>   btrfs-progs: mkfs: use the btrfs_block_group_root helper
>   btrfs-progs: check-lowmem: use the btrfs_block_group_root helper
>   btrfs-progs: handle no bg item in extent tree for free space tree
>   btrfs-progs: mkfs: add support for the block group tree
>   btrfs-progs: check: add block group tree support
>   btrfs-progs: qgroup-verify: scan extents based on block groups
>   btrfs-progs: check: make free space tree validation extent tree v2
>     aware
>   btrfs-progs: check: add helper to reinit the root based on a key
>   btrfs-progs: check: handle the block group tree properly
>   btrfs-progs: set the number of global roots in the super block
>   btrfs-progs: handle the per-block group global root id
>   btrfs-progs: add a btrfs_delete_and_free_root helper
>   btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
>   btrfs-progs: make btrfs_create_tree take a key for the root key
>   btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
>   btrfs-progs: mkfs: create the global root's
>   btrfs-progs: check: don't do the root item check for extent tree v2

Added to devel, thanks.
