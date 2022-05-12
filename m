Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E315242D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 May 2022 04:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiELCjF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 22:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiELCjF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 22:39:05 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E68C214A265
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 19:39:02 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id EF73C33C9FF; Wed, 11 May 2022 22:39:00 -0400 (EDT)
Date:   Wed, 11 May 2022 22:39:00 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Josef Bacik <josef@toxicpanda.com>, Marc MERLIN <marc@merlins.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <YnxzRI9eMRJZa+on@hungrycats.org>
References: <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
 <20220511000815.GK12542@merlins.org>
 <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
 <20220511014827.GL12542@merlins.org>
 <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
 <20220511150319.GM29107@merlins.org>
 <CAEzrpqcT0fObDa8XFWtvzeqCKom42t5o+xE9atmFjWyHCHmb=g@mail.gmail.com>
 <20220511160009.GN12542@merlins.org>
 <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
 <6e182895-9998-cf39-04e4-9542d79fc81d@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e182895-9998-cf39-04e4-9542d79fc81d@libero.it>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 11, 2022 at 08:00:07PM +0200, Goffredo Baroncelli wrote:
> On 11/05/2022 18.05, Josef Bacik wrote:
> > On Wed, May 11, 2022 at 12:00 PM Marc MERLIN <marc@merlins.org> wrote:
> > > 
> > > On Wed, May 11, 2022 at 11:21:37AM -0400, Josef Bacik wrote:
> [...]
> 
> Hi Joseph, Marc,
> 
> I looked back in the thread but I was unable to find if it was discussed.
> Even if the size of the FS is quite big, I am wondering if does make sense
> that Marc send to Josef the metadata of the filesystem, to speed up the
> recover.

> I am sure that btrfs-image was considered but then discarded (due to a risk
> of leaking of sensible information ? or may be the image would be too big ?);

The metadata would be 15GB for the csums alone (according to a
btrfs-dump-super in the thread, only 15TB of the 24TB total space is
used).  Subvol metadata would be on top of that.  Too big for an email,
but not impossible to transfer bidirectionally with a tool such as rsync.

Alternatively, Josef could debug the tool on the copy of the metadata,
then send the tool to Marc to run again on the original metadata, and
unidirectional transfer will suffice.  Handily, this also provides Marc
with a restorable backup copy of the metadata, so if there are bugs in
the recovery tool, the original metadata can be restored to try again
with a fixed tool.

Since the metadata tree is damaged, it can't be traversed (fixing
that is the whole point of this exercise), so btrfs-image won't work.
The image would have to be a raw dump of all the metadata block groups
to get all the potentially relevant pages (including orphan leaf pages
whose parents have been lost due to the disk failures).  In most cases
capturing the free space in metadata block groups would at most double
the size, but 30GB is still manageable.

This is a relatively simple tool to build for the case where the chunk
tree is intact, which it seems to be in this case.  If it wasn't, a
brute-force tool could scan the entire disk and pick up anything that
looks like a metadata page, then write a chunk tree that matches the
majority of collected pages (given a metadata page header's bytenr and
the on-disk position, we can identify which metadata chunk it belongs to;
the first and last page within that chunk provides the logical and
physical boundaries of the chunk).

Dropping the csum pages from the image is possible.  They all have
distinct item keys not found in any other metadata page, so they're easy
to spot on disk and leave out of the transfer; however, the more pages
that aren't part of the image, the more pages that are lost or awkwardly
unverifiable, increasing risk that the recovery tool won't be able to
fix the filesystem.  It's likely that at least the interior nodes of the
csum tree will still need to be part of the recovery operation, if not
all the leaf nodes as well.  The alternative is to blow up the csum tree
and generate a new one from subvol data, but that means no data integrity
checking on any of the data blocks (which are likely also corrupted by
the disk failures).  Undetected corruption becomes inevitable.

Assuming no snapshots and the distribution of file sizes and types
mentioned in the thread (100MB..10GB files, no inline), it would be maybe
10-15 MB for one subvol tree, double that to include the extent tree for
eliminating duplicate or obsolete pages.  That _does_ fit in an email,
especially after compression (subvol trees are highly compressible,
half the bits are zero and a third of the rest are consecutive or
constant numbers).

> It would be interested to know the reasons; may be that even if btrfs-image
> doesn't fit this particular case in the current form, it can be extended
> to handle a case like the Marc one..
> 
> BR
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
