Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5100AB2935
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2019 02:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfINA5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 20:57:34 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45794 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728789AbfINA5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 20:57:33 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6DE5F425719; Fri, 13 Sep 2019 20:56:55 -0400 (EDT)
Date:   Fri, 13 Sep 2019 20:56:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190914005655.GH22121@hungrycats.org>
References: <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
 <20190913010552.Horde.cUL303XsYbqREB5g0iiCDKd@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913010552.Horde.cUL303XsYbqREB5g0iiCDKd@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 13, 2019 at 01:05:52AM -0400, General Zed wrote:
> 
> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> 
> > On Thu, Sep 12, 2019 at 08:26:04PM -0400, General Zed wrote:
> > > 
> > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> > > 
> > > > Don't forget you have to write new checksum and free space tree pages.
> > > > In the worst case, you'll need about 1GB of new metadata pages for each
> > > > 128MB you defrag (though you get to delete 99.5% of them immediately
> > > > after).
> > > 
> > > Yes, here we are debating some worst-case scenaraio which is actually
> > > imposible in practice due to various reasons.
> > 
> > No, it's quite possible.  A log file written slowly on an active
> > filesystem above a few TB will do that accidentally.  Every now and then
> > I hit that case.  It can take several hours to do a logrotate on spinning
> > arrays because of all the metadata fetches and updates associated with
> > worst-case file delete.  Long enough to watch the delete happen, and
> > even follow along in the source code.
> > 
> > I guess if I did a proactive defrag every few hours, it might take less
> > time to do the logrotate, but that would mean spreading out all the
> > seeky IO load during the day instead of getting it all done at night.
> > Logrotate does the same job as defrag in this case (replacing a file in
> > thousands of fragments spread across the disk with a few large fragments
> > close together), except logrotate gets better compression.
> > 
> > To be more accurate, the example I gave above is the worst case you
> > can expect from normal user workloads.  If I throw in some reflinks
> > and snapshots, I can make it arbitrarily worse, until the entire disk
> > is consumed by the metadata update of a single extent defrag.
> > 
> 
> I can't believe I am considering this case.
> 
> So, we have a 1TB log file "ultralog" split into 256 million 4 KB extents
> randomly over the entire disk. We have 512 GB free RAM and 2% free disk
> space. The file needs to be defragmented.
> 
> In order to do that, defrag needs to be able to copy-move multiple extents
> in one batch, and update the metadata.
> 
> The metadata has a total of at least 256 million entries, each of some size,
> but each one should hold at least a pointer to the extent (8 bytes) and a
> checksum (8 bytes): In reality, it could be that there is a lot of other
> data there per entry.

It's about 48KB per 4K extent, plus a few hundred bytes on average for each
reference.

> The metadata is organized as a b-tree. Therefore, nearby nodes should
> contain data of consecutive file extents.

It's 48KB per item.  As you remove the original data extents, you will
be touching a 16KB page in three trees for each extent that is removed:
Free space tree, csum tree, and extent tree.  This happens after the
merged extent is created.  It is part of the cleanup operation that
gets rid of the original 4K extents.

Because the file was written very slowly on a big filesystem, the extents
are scattered pessimally all over the virtual address space, not packed
close together.  If there are a few hundred extent allocations between
each log extent, then they will all occupy separate metadata pages.
When it is time to remove them, each of these pages must be updated.
This can be hit in a number of places in btrfs, including overwrite
and delete.

There's also 60ish bytes per extent in any subvol trees the file
actually appears in, but you do get locality in that one (the key is
inode and offset, so nothing can get between them and space them apart).
That's 12GB and change (you'll probably completely empty most of the
updated subvol metadata pages, so we can expect maybe 5 pages to remain
including root and interior nodes).  I haven't been unlucky enough to
get a "natural" 12GB, but I got over 1GB a few times recently.

Reflinks can be used to multiply that 12GB arbitrarily--you only get
locality if the reflinks are consecutive in (inode, offset) space,
so if the reflinks are scattered across subvols or files, they won't
share pages.

> The trick, in this case, is to select one part of "ultralog" which is
> localized in the metadata, and defragment it. Repeating this step will
> ultimately defragment the entire file.
> 
> So, the defrag selects some part of metadata which is entirely a descendant
> of some b-tree node not far from the bottom of b-tree. It selects it such
> that the required update to the metadata is less than, let's say, 64 MB, and
> simultaneously the affected "ultralog" file fragments total less han 512 MB
> (therefore, less than 128 thousand metadata leaf entries, each pointing to a
> 4 KB fragment). Then it finds all the file extents pointed to by that part
> of metadata. They are consecutive (as file fragments), because we have
> selected such part of metadata. Now the defrag can safely copy-move those
> fragments to a new area and update the metadata.
> 
> In order to quickly select that small part of metadata, the defrag needs a
> metatdata cache that can hold somewhat more than 128 thousand localized
> metadata leaf entries. That fits into 128 MB RAM definitely.
> 
> Of course, there are many other small issues there, but this outlines the
> general procedure.
> 
> Problem solved?

Problem missed completely.  The forward reference updates were the only
easy part.

My solution is to detect this is happening in real time, and merge the
extents while they're still too few to be a problem.  Now you might be
thinking "but doesn't that mean you'll merge the same data blocks over
and over, wasting iops?" but really it's a perfectly reasonable trade
considering the interest rates those unspent iops can collect on btrfs.
If the target minimum extent size is 192K, you turn this 12GB problem into
a 250MB one, and the 1GB problem that actually occurs becomes trivial.

Another solution would be to get the allocator to reserve some space
near growing files reserved for use by those files, so that the small
fragments don't explode across the address space.  Then we'd get locality
in all four btrees.  Other filesystems have heuristics all over their
allocators to do things like this--btrfs seems to have a very minimal
allocator that could stand much improvement.
