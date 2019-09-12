Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE64B16C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 01:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfILXy3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 12 Sep 2019 19:54:29 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47964 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727325AbfILXy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 19:54:29 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D608F4232A1; Thu, 12 Sep 2019 19:54:27 -0400 (EDT)
Date:   Thu, 12 Sep 2019 19:54:27 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190912235427.GE22121@hungrycats.org>
References: <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 06:57:26PM -0400, General Zed wrote:
> 
> Quoting Chris Murphy <lists@colorremedies.com>:
> 
> > On Thu, Sep 12, 2019 at 3:34 PM General Zed <general-zed@zedlx.com> wrote:
> > > 
> > > 
> > > Quoting Chris Murphy <lists@colorremedies.com>:
> > > 
> > > > On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
> > > >>
> > > >> It is normal and common for defrag operation to use some disk space
> > > >> while it is running. I estimate that a reasonable limit would be to
> > > >> use up to 1% of total partition size. So, if a partition size is 100
> > > >> GB, the defrag can use 1 GB. Lets call this "defrag operation space".
> > > >
> > > > The simplest case of a file with no shared extents, the minimum free
> > > > space should be set to the potential maximum rewrite of the file, i.e.
> > > > 100% of the file size. Since Btrfs is COW, the entire operation must
> > > > succeed or fail, no possibility of an ambiguous in between state, and
> > > > this does apply to defragment.
> > > >
> > > > So if you're defragging a 10GiB file, you need 10GiB minimum free
> > > > space to COW those extents to a new, mostly contiguous, set of exents,
> > > 
> > > False.
> > > 
> > > You can defragment just 1 GB of that file, and then just write out to
> > > disk (in new extents) an entire new version of b-trees.
> > > Of course, you don't really need to do all that, as usually only a
> > > small part of the b-trees need to be updated.
> > 
> > The `-l` option allows the user to choose a maximum amount to
> > defragment. Setting up a default defragment behavior that has a
> > variable outcome is not idempotent and probably not a good idea.
> 
> We are talking about a future, imagined defrag. It has no -l option yet, as
> we haven't discussed it yet.
> 
> > As for kernel behavior, it presumably could defragment in portions,
> > but it would have to completely update all affected metadata after
> > each e.g. 1GiB section, translating into 10 separate rewrites of file
> > metadata, all affected nodes, all the way up the tree to the super.
> > There is no such thing as metadata overwrites in Btrfs. You're
> > familiar with the wandering trees problem?
> 
> No, but it doesn't matter.
> 
> At worst, it just has to completely write-out "all metadata", all the way up
> to the super. It needs to be done just once, because what's the point of
> writing it 10 times over? Then, the super is updated as the final commit.

This is kind of a silly discussion.  The biggest extent possible on
btrfs is 128MB, and the incremental gains of forcing 128MB extents to
be consecutive are negligible.  If you're defragging a 10GB file, you're
just going to end up doing 80 separate defrag operations.

128MB is big enough you're going to be seeking in the middle of reading
an extent anyway.  Once you have the file arranged in 128MB contiguous
fragments (or even a tenth of that on medium-fast spinning drives),
the job is done.

> On my comouter the ENTIRE METADATA is 1 GB. That would be very tolerable and
> doable.

You must have a small filesystem...mine range from 16 to 156GB, a bit too
big to fit in RAM comfortably.

Don't forget you have to write new checksum and free space tree pages.
In the worst case, you'll need about 1GB of new metadata pages for each
128MB you defrag (though you get to delete 99.5% of them immediately
after).

> But that is a very bad case, because usually not much metadata has to be
> updated or written out to disk.
> 
> So, there is no problem.
> 
> 
