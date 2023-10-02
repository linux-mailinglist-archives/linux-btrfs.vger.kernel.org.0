Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF0E7B4CEE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 09:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbjJBH5j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 03:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJBH5h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 03:57:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E755BC;
        Mon,  2 Oct 2023 00:57:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB8121F459;
        Mon,  2 Oct 2023 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696233452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRtvvsbDRmaIGA2qlEwuFNnN4SG9to1RwhMyTnDS1Ek=;
        b=AelUG9FSlQyUcQTA9I9qRJmPzMA6mvk2OLx4Qv2PacqmgU2FkeI54uQfwuwk8GDISDrHf1
        K6okkr5Yua+jK8r2TTOukY7745vay4e4z1caiTsHAigkH18O5VWdMY9s+0PKMe8/Ta1ITc
        H4lySULw9TgNQsjwAFd513U/tj8Iifc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696233452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRtvvsbDRmaIGA2qlEwuFNnN4SG9to1RwhMyTnDS1Ek=;
        b=4yX5F6ZD5YaXQ1SgLuHClpbWfxc1xKg7esoSW59wSh/oO7HSeTROmd590v4TgEevJu81R5
        RAceDQWhH8NjA0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83FA513434;
        Mon,  2 Oct 2023 07:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JLsgIOx3GmUuEgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 07:57:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 27D44A07C9; Mon,  2 Oct 2023 09:57:32 +0200 (CEST)
Date:   Mon, 2 Oct 2023 09:57:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, Gao Xiang <xiang@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Joern Engel <joern@lazybastard.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Song Liu <song@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 0/29] block: Make blkdev_get_by_*() return handle
Message-ID: <20231002075732.4c5oslpabrmw3niz@quack3>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230927-prahlen-reintreten-93706074e58d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-prahlen-reintreten-93706074e58d@brauner>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed 27-09-23 18:21:19, Christian Brauner wrote:
> On Wed, 27 Sep 2023 11:34:07 +0200, Jan Kara wrote:
> > Create struct bdev_handle that contains all parameters that need to be
> > passed to blkdev_put() and provide bdev_open_* functions that return
> > this structure instead of plain bdev pointer. This will eventually allow
> > us to pass one more argument to blkdev_put() (renamed to bdev_release())
> > without too much hassle.
> > 
> > 
> > [...]
> 
> > to ease review / testing. Christian, can you pull the patches to your tree
> > to get some exposure in linux-next as well? Thanks!
> 
> Yep. So I did it slighly differently. I pulled in the btrfs prereqs and
> then applied your series on top of it so we get all the Link: tags right.
> I'm running tests right now. Please double-check.

Thanks for picking patches up! I've checked the branch and it looks good to
me. 

								Honza

> 
> ---
> 
> Applied to the vfs.super branch of the vfs/vfs.git tree.
> Patches in the vfs.super branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.super
> 
> [01/29] block: Provide bdev_open_* functions
>        https://git.kernel.org/vfs/vfs/c/b7c828aa0b3c
> [02/29] block: Use bdev_open_by_dev() in blkdev_open()
>         https://git.kernel.org/vfs/vfs/c/d4e36f27b45a
> [03/29] block: Use bdev_open_by_dev() in disk_scan_partitions() and blkdev_bszset()
>         https://git.kernel.org/vfs/vfs/c/5f9bd6764c7a
> [04/29] drdb: Convert to use bdev_open_by_path()
>         https://git.kernel.org/vfs/vfs/c/0220ca8e443d
> [05/29] pktcdvd: Convert to bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/7af10b889789
> [06/29] rnbd-srv: Convert to use bdev_open_by_path()
>         https://git.kernel.org/vfs/vfs/c/3d27892a4be7
> [07/29] xen/blkback: Convert to bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/26afb0ed10b3
> [08/29] zram: Convert to use bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/efc8e3f4c6dc
> [09/29] bcache: Convert to bdev_open_by_path()
>         https://git.kernel.org/vfs/vfs/c/dc893f51d24a
> [10/29] dm: Convert to bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/80c2267c6d07
> [11/29] md: Convert to bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/15db36126ca6
> [12/29] mtd: block2mtd: Convert to bdev_open_by_dev/path()
>         https://git.kernel.org/vfs/vfs/c/4c27234bf3ce
> [13/29] nvmet: Convert to bdev_open_by_path()
>         https://git.kernel.org/vfs/vfs/c/70cffddcc300
> [14/29] s390/dasd: Convert to bdev_open_by_path()
>         https://git.kernel.org/vfs/vfs/c/5581d03457f8
> [15/29] scsi: target: Convert to bdev_open_by_path()
>         https://git.kernel.org/vfs/vfs/c/43de7d844d47
> [16/29] PM: hibernate: Convert to bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/105ea4a2fd18
> [17/29] PM: hibernate: Drop unused snapshot_test argument
>         https://git.kernel.org/vfs/vfs/c/b589a66e3688
> [18/29] mm/swap: Convert to use bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/615af8e29233
> [19/29] fs: Convert to bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/5173192bcfe6
> [20/29] btrfs: Convert to bdev_open_by_path()
>         https://git.kernel.org/vfs/vfs/c/8cf64782764f
> [21/29] erofs: Convert to use bdev_open_by_path()
>         https://git.kernel.org/vfs/vfs/c/4d41880bf249
> [22/29] ext4: Convert to bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/f7507612395e
> [23/29] f2fs: Convert to bdev_open_by_dev/path()
>         https://git.kernel.org/vfs/vfs/c/d9ff8e3b6498
> [24/29] jfs: Convert to bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/459dc6376338
> [25/29] nfs/blocklayout: Convert to use bdev_open_by_dev/path()
>         https://git.kernel.org/vfs/vfs/c/5b1df9a40929
> [26/29] ocfs2: Convert to use bdev_open_by_dev()
>         https://git.kernel.org/vfs/vfs/c/b6b95acbd943
> [27/29] reiserfs: Convert to bdev_open_by_dev/path()
>         https://git.kernel.org/vfs/vfs/c/7e3615ff6119
> [28/29] xfs: Convert to bdev_open_by_path()
>         https://git.kernel.org/vfs/vfs/c/176ccb99e207
> [29/29] block: Remove blkdev_get_by_*() functions
>         https://git.kernel.org/vfs/vfs/c/953863a5a2ff
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
