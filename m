Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D895D31DDF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 18:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhBQRK5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 12:10:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:44386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234291AbhBQRK4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 12:10:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E010B7A9;
        Wed, 17 Feb 2021 17:10:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B8BE6DA7C5; Wed, 17 Feb 2021 18:08:17 +0100 (CET)
Date:   Wed, 17 Feb 2021 18:08:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Tuomas =?iso-8859-1?Q?L=E4hdekorpi?= 
        <tuomas.lahdekorpi@gmail.com>
Subject: Re: [PATCH] btrfs: do not error out if the extent ref hash doesn't
 match
Message-ID: <20210217170817.GT1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Tuomas =?iso-8859-1?Q?L=E4hdekorpi?= <tuomas.lahdekorpi@gmail.com>
References: <c801971bb6f1318ae71440504d8631333b7dddc7.1613508186.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c801971bb6f1318ae71440504d8631333b7dddc7.1613508186.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 03:43:22PM -0500, Josef Bacik wrote:
> The tree checker checks the extent ref hash at read and write time to
> make sure we do not corrupt the file system.  Generally extent
> references go inline, but if we have enough of them we need to make an
> item, which looks like
> 
> key.objectid	= <bytenr>
> key.type	= <BTRFS_EXTENT_DATA_REF_KEY|BTRFS_TREE_BLOCK_REF_KEY>
> key.offset	= hash(tree, owner, offset)
> 
> However if key.offset collide with an unrelated extent reference we'll
> simply key.offset++ until we get something that doesn't collide.
> Obviously this doesn't match at tree checker time, and thus we error
> while writing out the transaction.  This is relatively easy to
> reproduce, simply do something like the following
> 
> xfs_io -f -c "pwrite 0 1M" file
> offset=2
> 
> for i in {0..10000}
> do
> 	xfs_io -c "reflink file 0 ${offset}M 1M" file
> 	offset=$(( offset + 2 ))
> done
> 
> xfs_io -c "reflink file 0 17999258914816 1M" file
> xfs_io -c "reflink file 0 35998517829632 1M" file
> xfs_io -c "reflink file 0 53752752058368 1M" file
> 
> btrfs filesystem sync
> 
> And the sync will error out because we'll abort the transaction.  The
> magic values above are used because they generate hash collisions with
> the first file in the main subvol.
> 
> The fix for this is to remove the hash value check from tree checker, as
> we have no idea which offset ours should belong to.
> 
> Reported-by: Tuomas Lähdekorpi <tuomas.lahdekorpi@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks, I've added a comment stating that we can't check the hash there.
