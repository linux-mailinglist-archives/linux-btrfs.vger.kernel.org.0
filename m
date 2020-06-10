Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991731F4B94
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 04:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFJCpC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 9 Jun 2020 22:45:02 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:32906 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCpC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Jun 2020 22:45:02 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3DA2F709821; Tue,  9 Jun 2020 22:45:01 -0400 (EDT)
Date:   Tue, 9 Jun 2020 22:45:01 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS File Delete Speed Scales With File Size?
Message-ID: <20200610024501.GH10769@hungrycats.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 09, 2020 at 11:31:41AM -0400, Ellis H. Wilson III wrote:
> Hi folks,
> 
> We have a few engineers looking through BTRFS code presently for answers to
> this, but I was interested to get input from the experts in parallel to
> hopefully understand this issue quickly.
> 
> We find that removes of large amounts of data can take a significant amount
> of time in BTRFS on HDDs -- in fact it appears to scale linearly with the
> size of the file.  I'd like to better understand the mechanics underpinning
> that behavior.
> 
> See the attached graph for a quick experiment that demonstrates this
> behavior.  In this experiment I use 40 threads to perform deletions of
> previous written data in parallel.  

40 threads doing delete is probably overkill--at the end of the day it all
goes through the same disk(s), and only one or two deleting threads per
disk will be enough to saturate the IO channel (or at least hit btrfs's
current concurrency limits).

> 10,000 files in every case and I scale
> files by powers of two from 16MB to 16GB.  Thus, the raw amount of data
> deleted also expands by 2x every step.  Frankly I expected deletion of a
> file to be predominantly a metadata operation and not scale with the size of
> the file, but perhaps I'm misunderstanding that.  

Metadata size is directly proportional to file size.  An extent takes
up about 100 bytes of metadata and can represent 4K to 128MB of data
(4K to 128KB for compressed data).  That's comparable to most modern
filesystems.

crc32c csums add 0.1% of the file data size in metadata (4 byte csum for
each 4K data block).  All the other csum algos are larger than crc32c and
use proportionally more metadata for each data block.  That's probably
where the majority of the linear scaling effect comes from--the rest is
buried in statistical noise.

You can remove the csum overhead by disabling datasums; however, you lose
self-healing and corruption detection if you do that.

There are also overheads related to sharing of extents.  Whenever a
shared extent is modified (e.g. a file is deleted while a snapshot
containing the file exists) an update to the backrefs is required.
Other filesystems don't have backrefs at all (so they don't support
online shrinking resize), or they only use backrefs when extents are
shared (e.g. XFS rmaps).

> While the overall speed of
> deletion is relatively fast (hovering between 30GB/s and 50GB/s) compared
> with raw ingest of data to the disk array we're using (in our case ~1.5GB/s)
> it can still take a very long time to delete data from the drives and
> removes hang completely until that data is deleted, unlike in some other
> filesystems.  They also compete aggressively with foreground I/O due to the
> intense seeking on the HDDs.

You may also be hitting delayed extent ref throttling.  btrfs doesn't
add or remove references to extents right away--it queues them up in
memory so that it doesn't touch the same metadata page multiple times
in a transaction.  When the batch reaches a certain size (100 to 10000
extents, depending on disk performance), writes are blocked to allow for
the disks to catch up.

Without this throttling, transactions can keep growing indefinitely.  In
the worst case, a crash can roll back the filesystem to a much earlier
state--hours or days earlier, if you have sufficient disk space to keep
appending to the ongoing transaction, and the right mix of aggressive
writer processes to keep the IO channels saturated.  This regressed in
5.0 and hasn't really been fixed properly yet.

> This is with an older version of BTRFS (4.12.14-lp150.12.73-default) so if
> algorithms have changed substantially such that deletion rate is no longer
> tied to file size in newer versions please just say so and I'll be glad to
> take a look at that change and try with a newer version.

That would require significant on-disk format changes.

It is not possible to quickly (i.e. in O(1) or even O(log(n)) time) drop
all the csums or extents that belong to a file in btrfs.  Extents and
csums are owned by the extent tree, files just contain references to them.
When a file is deleted, each individual metadata item contained in the
file has to be removed from its page, which means reading and possibly
also writing the entire page at some point during the transaction.

This isn't different from other filesystems: most modern filesystems,
including ext4, xfs, and btrfs, are O(n*log(n)) in data size for deletes.
The constant term is much larger in btrfs due to the csums.

Ideally, deletes should proceed in the same order the data was written.
This reads metadata pages sequentially from disk and provides the best
benefits of RAM caching.  This is another reason to limit the number of
deleting threads.

> FWIW, we are using the v2 free space cache.  If any other information is
> relevant to this just let me know and I'll be glad to share.
> 
> Thank you for any time people can spare to help us understand this better!
> 
> ellis


