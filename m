Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10FA3E4892
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhHIPUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 11:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232717AbhHIPUh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Aug 2021 11:20:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7F7260F93;
        Mon,  9 Aug 2021 15:20:14 +0000 (UTC)
Date:   Mon, 9 Aug 2021 17:20:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 00/21] btrfs: support idmapped mounts
Message-ID: <20210809152012.lnd4aai34kdhuijf@wittgenstein>
References: <20210727104900.829215-1-brauner@kernel.org>
 <20210802122827.aomsh5i3rljgm2r3@wittgenstein>
 <20210809144439.GP5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210809144439.GP5047@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 09, 2021 at 04:44:39PM +0200, David Sterba wrote:
> On Mon, Aug 02, 2021 at 02:28:27PM +0200, Christian Brauner wrote:
> > On Tue, Jul 27, 2021 at 12:48:39PM +0200, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Hey everyone,
> > > 
> > > /* v4 */
> > > Rename new helper to lookup_one() and add new Reviewed-bys.
> > > 
> > > This series enables the creation of idmapped mounts on btrfs. On the list of
> > > filesystems btrfs was pretty high-up and requested quite often from userspace
> > > (cf. [1]). This series requires just a few changes to the vfs for specific
> > > lookup helpers that btrfs relies on to perform permission checking when looking
> > > up an inode. The changes are required to port some other filesystem as well.
> > > 
> > > The conversion of the necessary btrfs internals was fairly straightforward. No
> > > invasive changes were needed. I've decided to split up the patchset into very
> > > small individual patches. This hopefully makes the series more readable and
> > > fairly easy to review. The overall changeset is quite small.
> > > 
> > > All non-filesystem wide ioctls that peform permission checking based on inodes
> > > can be supported on idmapped mounts. There are really just a few restrictions.
> > > This should really only affect the deletion of subvolumes by subvolume id which
> > > can be used to delete any subvolume in the filesystem even though the caller
> > > might not even be able to see the subvolume under their mount. Other than that
> > > behavior on idmapped and non-idmapped mounts is identical for all enabled
> > > ioctls. People interested in idmappings on idmapped mounts should read [2].
> > > 
> > > The changeset has an associated new testsuite specific to btrfs. The
> > > core vfs operations that btrfs implements are covered by the generic
> > > idmapped mount testsuite. For the ioctls a new testsuite was added. It
> > > is sent alongside this patchset for ease of review but will very likely
> > > be merged independent of it.
> > > 
> > > All patches are based on v5.14-rc3.
> > > 
> > > The series can be pulled from:
> > > https://git.kernel.org/brauner/h/fs.idmapped.btrfs
> > > https://github.com/brauner/linux/tree/fs.idmapped.btrfs
> > > 
> > > The xfstests can be pulled from:
> > > https://git.kernel.org/brauner/xfstests-dev/h/fs.idmapped.btrfs
> > > https://github.com/brauner/xfstests/tree/fs.idmapped.btrfs
> > > 
> > > Note, the new btrfs xfstests patch is on top of a branch of mine
> > > containing a few more preliminary patches. So if you want to run the
> > > tests, please simply pull the branch and build from there.
> > > 
> > > The series has been tested with xfstests including the newly added btrfs
> > > specific test. All tests pass.
> > > There were three unrelated failures that I observed: btrfs/219,
> > > btrfs/2020 and btrfs/235. All three also fail on earlier kernels
> > > without the patch series applied.
> > 
> > Hey David,
> > 
> > Sorry to ping, could I answer the outstanding questions you had and are
> > you okay with this series?
> 
> I'll need to do one more pass but I don't remember any big issues or
> anything that couldn't be adjusted later. This is going to be the last
> nontrivial patchset, time is almost up for next merge window code
> freeze.
> 
> Patch 1, the VFS part, does not have acks but for inclusion into
> for-next I don't think it's necessary. I'll let you know once I push the
> idmap branch to for-next so you can drop the patch.

Ok, sounds good. I wasn't sure if you wanted to base your branch on the
tag or just carry it yourself. Whatever works best.

Christian
