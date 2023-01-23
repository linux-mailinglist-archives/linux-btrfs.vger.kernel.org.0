Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443306773A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jan 2023 01:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjAWA3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Jan 2023 19:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWA3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Jan 2023 19:29:51 -0500
X-Greylist: delayed 531 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Jan 2023 16:29:49 PST
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D90119691
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 16:29:49 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id E47706FD5C0; Sun, 22 Jan 2023 19:20:57 -0500 (EST)
Date:   Sun, 22 Jan 2023 19:20:57 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Will Btrfs have an official command to "uncow" existing files?
Message-ID: <Y83S6QRxiM/L/2qD@hungrycats.org>
References: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
 <c08cea1d-1ae3-c0d1-c164-6453ad73f0c0@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08cea1d-1ae3-c0d1-c164-6453ad73f0c0@libero.it>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 22, 2023 at 09:27:33PM +0100, Goffredo Baroncelli wrote:
> On 22/01/2023 12.41, Cerem Cem ASLAN wrote:
> > Original post is here: https://www.spinics.net/lists/linux-btrfs/msg58055.html
> > 
> > The problem with the "chattr +C ..., move back and forth" approach is
> > that the VM folder is about 300GB and I have ~100GB of free space,
> > plus,
> 
> This can be solvable: it should be possible to make a tool that for
> each unit of copy (eg each 1 GB) does:
> - copy the data from the COW file to the NOCOW file
> - remove the data copied from the NOCOW file (using fallocate+FALLOC_FL_PUNCH_HOLE)
> 
> So you can avoid to have two FULL copy of the same file (in pseudo code:
> 
> block_size = 1024*1024*1024;
> while (pos < file_len) {
> 	l = min(block_size, file_len - pos);
> 	len_copied = copy(srcfd, dstfd, pos, l);
> 	fallocate(srcfd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, pos, l);
> 
> 	pos += l;
> }
> 
> 
> end pseudo code)
> 
> I don't know if there is an algorithm that prevent the data loss in case of
> an interruption of the copy. May be that it exists... We need a file where
> we could log the status.

Start at the end of the file and work backwards, making the source
file shorter with truncate.  The size of the original file provides a
built-in checkpoint that you can resume from, at worst, copying the last
1GB of the file again after resuming.  There's no danger of accidentally
copying a bunch of zeros that would be left behind by PUNCH_HOLE.

Don't forget to open the dst file without O_TRUNC, and call fsync()
(or ideally sync() to force a full commit and avoid possible log tree
replay issues) between writing the copy and truncating the original.

Note that if you're doing this with 300GB of data on a filesystem with
100GB free, and the files are already fragmented because they were used
with a VM, then you'll end up with massively fragmented nodatacow files,
because the parts that are deleted by truncate() will leave behind tiny
free space holes, and those holes will be the only space available after
the first 25% of the copy.  You can partially mitigate this by stopping
to run balance every now and then to defragment free space during the
copy, but at that point you'll be moving 1200+ GB of data around, not
counting metadata tree updates.

Honestly, attaching a second 400GB device and copying the files
straight from one to the other and back will be a *better solution*
to this problem.

> > I have multiple copies which will require that 300GB to
> > re-transfer after deleting all previous snapshots (because there is no
> > enough free space on those backup hard disks).

Note that snapshots are not compatible with nodatacow.  nodatacow will
be disabled for each extent where another reference exists.

> This is a more stronger requirement; but unfortunately if you copy the data you
> will end to have two copy of the data which before was shared between the snapshots.

If there are multiple snapshots of the file, you'll have to do this
in parallel with all of them, cloning into each nodatacow file on
the snapshots from the newly copied nocow file after each GB copied.

Of course all of these files would really be datacow despite the +C
attribute, since they have shared extents.

> > So, we really need to set the NoCow attribute for the existing files.

The main reason why it's not allowed is because nodatacow implies
nodatasum.  datacow can be enabled and disabled for each extent (e.g. when
a snapshot of a nodatacow file is made, the file becomes implicitly
datacow) because nodatacow doesn't impose additional tree lookup costs
compared to datacow.  datasum stores data in a separate tree, and there
are IO costs which must be paid for datasum whether the csum exists in
the tree or not, so btrfs needs to know whether there's a csum _before_
doing a lookup in the csum tree.

Currently the nodatasum flag is stored in the btrfs inode.  Every inode
that references a extent has a separate nodatasum flag, and all of those
inodes must agree on the same flag value.  It is not permitted to change
the nodatasum attribute on a file while it has extents, specifically
to prevent issues with data extents having csums when accessed through
some files but not having csums when accessed through other files.
It's also not allowed to make reflink copies of data from a datasum file
to a non-datasum file (or vice versa) for the same reason:  every inode
referencing an extent must have the same datasum flag value.

Consider what happens when an extent with nodatasum is deleted, but
references previously existed to the extent with datasum--the csums from
the deleted extent wouldn't be removed, causing an EEXIST panic later
when new data is written to the freed blocks, but csums already exist
for those blocks in the tree.  That would be bad, so it's not allowed.

This could be fixed in btrfs by stealing one of the bits in a file extent
item, then using it to indicate whether the data extent has csums present.
This would make datasums behave the same way compression does--each extent
decides whether it is compressed or not, so you can freely enable or
disable compression on a file, and it only affects what happens to new
extents written in the file.  When an extent is reflinked, the reflink
has the same compression setting as the original extent.  btrfs could do
that with datasums too, and then a file could be freely changed from
datacow+datasum to nodatacow+nodatasum, which would only affect the
behavior of extents written to the file in the future.  The csum tree
lookup costs are avoided because btrfs knows whether a csum exists from
the file extent item.

With this new on-disk structure, it would be possible to iterate over all
the extents in a file, change their file extent items to be nodatasum,
then delete the csums on the extent when there are no references remaining
to them, all without copying any data.  That wouldn't be worse than
running balance in terms of metadata IO costs (data costs are zero).

> > Should we currently use a separate partition for VMs and mount it with
> > nodatacow option to avoid that issue?
> 
> Not really, it is enough to do a chmod -C on the directory where
> the VM images are stored.
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
