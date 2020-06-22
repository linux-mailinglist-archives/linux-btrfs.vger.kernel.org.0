Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B2204400
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 00:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgFVWp6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 22 Jun 2020 18:45:58 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41880 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbgFVWp6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 18:45:58 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 21A7272990D; Mon, 22 Jun 2020 18:45:57 -0400 (EDT)
Date:   Mon, 22 Jun 2020 18:45:57 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     dsterba@suse.cz,
        DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
Message-ID: <20200622224556.GP10769@hungrycats.org>
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
 <20200618204317.GM10769@hungrycats.org>
 <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
 <20200619050402.GN10769@hungrycats.org>
 <20200619131117.GD27795@twin.jikos.cz>
 <79672577-6189-10fe-b4bc-8cf45547b192@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <79672577-6189-10fe-b4bc-8cf45547b192@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 22, 2020 at 09:49:55PM +0200, Goffredo Baroncelli wrote:
> On 6/19/20 3:11 PM, David Sterba wrote:
> > > If there wasn't some insurmountable reason
> > > why duperemove can't be merged with btrfs-progs, then it would have
> > > happened already, so there must be a reason why this can't ever happen
> > > (which might be as simple as neither maintainer wants to merge).
> > I'm not against adding the functionality to btrfs-progs, but merging
> > whole duperemove feature set might not happen due to additional
> > dependencies. This would need to be evaluated, but I'm not aware of any
> > other technical reasons.
> > 
> > I don't remember exactly why duperemove started as a separate project
> > instead of a subcommand or progs, but we can revisit that.
> > 
> Even tough I don't think that this was the reason at the time, now the
> ioctl FIDEDUPERANGE (aka BTRFS_IOC_FILE_EXTENT_SAME) is "filesystem
> agnostic". So I think that does make sense a tool more generic than
> btrfs(-progs).
> 
> What I mean is: because this is not a BTRFS specific ioctl anymore,
> why we should have a BTRFS specific implementation ?

First, to take advantage of unique btrfs capabilities:  incremental
scanning using transid and TREE_SEARCH_V2, and user data block csums.
Second, to take advantage of generic filesystem capabilities that
require btrfs-specific implementation details.  Third, btrfs has immutable
extents while other filesystems don't, and ignoring that fact in a generic
multi-filesystem tool will cost a lot of dedupe efficiency on btrfs.

On a big filesystem, the difference between a filesystem-specific
dedupe tool and a filesystem-agnostic one could be many orders of
magnitude better performance and a doubling of space recovery.

duperemove is implemented using generic filesystem APIs:  you point it at
a directory tree, it scans all the files in the tree (including
previously deduped files) and dedupes them.  In incremental mode it
scans the entire tree and compares the tree with a database.  This is
the slowest way to keep a filesystem deduplicated at scale.

XFS and btrfs are both capable of doing dedupe at wire speeds by
bypassing most of the filesystem (similar to a scrub, and can even
be combined with scrub).  That level of performance makes incremental
scanning and filesystem csum support unnecessary for many use cases,
since users would just run full dedupe instead of scrub.  One tool
can support both XFS and btrfs this way, though it would have to have
specialized support for each individual filesystem as the details on each
filesystem are very different (GETFSMAP and pread, vs LOGICAL_INO and all
the different btrfs raid profiles and compression formats).  It could be
done as a dedupe core with plugin support for each filesystem, provided
that the core algorithm is designed to handle btrfs's immutable extents.
AFAIK nobody has built such a tool yet.

XFS doesn't maintain csums of user data or support incremental scans,
so XFS can dedupe _only_ as fast as it can scrub (*).  btrfs has the
extra information in the filesystem, so in theory we can start with the
wire-speed dedupe from above, and make it up to 1000 times faster by
reading the csums instead of reading the data blocks, and then faster
still by scanning only the parts of the filesystem that changed from one
dedupe run to the next.

(*) XFS has some very fast tools for rapidly finding modified inodes,
and it doesn't have immutable extents like btrfs does.  XFS might win
by brute force against btrfs's slower equivalents.  It would depend on
the mix of file sizes in the workload.

> From a technical point of view: dupremover could take advantage of
> the btrfs csum. So the question could be : is it better to add the
> capability to use the BTRFS csum to duperemover or to add the code of
> dupremover to BTRFS ?

The options are orthogonal.  csum read support can be added to any dedupe
tool, whether it's part of the official btrfs code or not.  We can decide
on an official tool and add csum support to that tool in either order.

> From an user point of view, I think that the former makes sense.
> 
> BR
> G.Baroncelli
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
