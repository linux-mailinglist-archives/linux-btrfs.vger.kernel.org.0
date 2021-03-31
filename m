Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4634F61A
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 03:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhCaBR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 30 Mar 2021 21:17:56 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37898 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhCaBRl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 21:17:41 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E51319F3A37; Tue, 30 Mar 2021 21:17:38 -0400 (EDT)
Date:   Tue, 30 Mar 2021 21:17:38 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Claudius Heine <ch@denx.de>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>
Subject: Re: btrfs-send format that contains binary diffs
Message-ID: <20210331011737.GT32440@hungrycats.org>
References: <f3306b7c-a97a-21f2-0f66-dc94dc2c0272@denx.de>
 <db6fae67-6348-1de3-c953-a4c75c459b65@gmail.com>
 <5ba46b04-f3ba-03ef-6ad5-38fd44f8c67e@denx.de>
 <535709bb-0bde-6193-2cef-0c1d037ba211@gmail.com>
 <3cfc2421-4683-9439-1301-09d013a670ec@gmail.com>
 <c2810b39-d1ef-c0ec-64d6-c1dd2e3e0007@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <c2810b39-d1ef-c0ec-64d6-c1dd2e3e0007@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 30, 2021 at 10:12:40AM +0200, Claudius Heine wrote:
> Hi Andrei,
> 
> On 2021-03-30 07:38, Andrei Borzenkov wrote:
> > On 30.03.2021 08:33, Andrei Borzenkov wrote:
> > > On 29.03.2021 22:14, Claudius Heine wrote:
> > > > Hi Andrei,
> > > > 
> > > > On 2021-03-29 18:30, Andrei Borzenkov wrote:
> > > > > On 29.03.2021 16:16, Claudius Heine wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > I am currently investigating the possibility to use `btrfs-stream` files
> > > > > > (generated by `btrfs send`) for deploying a image based update to
> > > > > > systems (probably embedded ones).
> > > > > > 
> > > > > > One of the issues I encountered here is that btrfs-send does not use any
> > > > > > diff algorithm on files that have changed from one snapshot to the next.
> > > > > > 
> > > > > 
> > > > > btrfs send works on block level. It sends blocks that differ between two
> > > > > snapshots.
> > > > 
> > > > Are you sure?
> > > > 
> > > 
> > > Yes.
> 
> Ok, sorry for doubting you. My assumptions where wrong.
> 
> > > 
> > > > I did a test with a 32MiB random file. I created one snapshot, then
> > > > changed (not deleted or added) one byte in that file and then created a
> > > > snapshot again. `btrfs send` created a >32MiB `btrfs-stream` file. If it
> > > > would be only block based, then I would have expected that it would just
> > > > contain the changed block, not the whole file. And if I use a smaller
> > > > file on the same file system, then the `btrfs-stream` is smaller as well.
> > > > 
> > > > I looked into those `btrfs-stream` files using [1] and also [2] as well
> > > > as the code. While I haven't understood everything there yet, it
> > > > currently looks to me like it is file based.
> > > > 
> > > 
> > > btrfs send is not pure block based image, because it would require two
> > > absolutely identical filesystems. It needs to replicate filesystem
> > > structure so it of course needs to know which files are created/deleted.
> > > But for each file it only sends changed parts since previous snapshot.
> > > This only works if both snapshots refer to the *same* file.
> > > 
> > 
> > Or more precisely - btrfs send knows which filesystem content was part
> > of previous snapshot and so is already present on destination and it
> > will not send this content again. It is actually more or less irrelevant
> > which files this content belongs to.
> 
> I think I understood that now.
> 
> > 
> > > As was already mentioned, you need to understand how your files are
> > > changed. In particular, standard tools for software update do not
> > > rewrite files in place - they create new files with new content. From
> > > btrfs perspective they are completely different; two files with the same
> > > name in two snapshots do not share a single byte. When you compute delta
> > > between two snapshots you get instructions to delete old file and create
> > > new file with new content (that will be renamed to the same name as
> > > deleted old file). This also by necessity sends full new content.
> 
> As you said, many standard tools create new files instead of updating files
> in place. But I guess a `dedupe` run before creating the snapshot could help
> here, right?

Test thoroughly.  btrfs send was designed and implemented before btrfs
had dedupe.  There may be bugs with some use cases.

> If we have a root file system build process that always regenerates all
> files, and then copies those into a file system, then all files are
> 'different' from a btrfs perspective.

It sounds like you want to use rsync or casync instead of btrfs send.
They do more work on the sending side to minimize the cost in transit
and at the receiving side.  They don't particularly care about *how*
the files came to contain the data they do--contrast with btrfs send,
which cares about nothing else.  They both have output stream options,
so you can replicate the data changes on multiple receivers if they have
access to identical pre-delta content.

rsync doesn't do dedupe or reflink (not sure about casync), but it may be
easier to add reflink copy to rsync than it is to add delta compression
to btrfs send (*).  You can also dedupe after the fact on the receiver
side, but that might not be desirable for assorted good reasons.

btrfs send is mostly about extracting data from the source in bulk as
quickly as possible.  The backup use case makes only a single copy,
and the sender wants the cost at their end to be as close to zero
as possible.  Delta compression works against those goals, especially
when considering kernel memory constraints.

(*) maybe...?  rsync and btrfs send (kernel) are both pretty gnarly C
programs, and if it was easy to add reflink to rsync, I would expect
rsync to be already doing reflink by now...

> > > So yes, btrfs replication is block based; similarity is determined by
> > > how much physical data is shared between two files. And you expect file
> > > based replication where file names determine whether files should be
> > > considered the same and changes are computed for two files with the same
> > > name.
> 
> Right. Maybe we could use the file path just as a hint for an opportunity of
> saving resources by creating block based deltas.
> 
> I guess I have to think about this some more.
> 
> Thanks a lot!
> Claudius
