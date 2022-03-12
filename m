Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EE14D6C35
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 04:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiCLDSA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 22:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiCLDRy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 22:17:54 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BA052A0339
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 19:16:50 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 06A352503CF; Fri, 11 Mar 2022 22:16:45 -0500 (EST)
Date:   Fri, 11 Mar 2022 22:16:45 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YiwQnf933PMnhGKI@hungrycats.org>
References: <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
 <CAODFU0pxmTShj7OrgGH+-_YuObhwoLBrgwVvx-v+WbFerHM01A@mail.gmail.com>
 <e7df8c6e-5185-4bea-2863-211214968153@gmx.com>
 <CAODFU0r=9i2mOwNXVx74GcKUSt4Z6wGqshgD=5bktFhoXCWE4A@mail.gmail.com>
 <452af644-e871-20e3-60b2-f69a92dc406d@gmx.com>
 <CAODFU0oWBvRkpM3oirpfitGiTex8=EST021egQzUiBCMYrhVVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0oWBvRkpM3oirpfitGiTex8=EST021egQzUiBCMYrhVVg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 12, 2022 at 01:01:36AM +0100, Jan Ziak wrote:
> On Sat, Mar 12, 2022 at 12:39 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > On 2022/3/12 07:28, Jan Ziak wrote:
> > > On Sat, Mar 12, 2022 at 12:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > >> As stated before, autodefrag is not really that useful for database.
> > >
> > > Do you realize that you are claiming that btrfs autodefrag should not
> > > - by design - be effective in the case of high-fragmentation files?
> >
> > Unfortunately, that's exactly what I mean.
> >
> > We all know random writes would cause fragments, but autodefrag is not
> > like regular defrag ioctl, as it only scan newer extents.
> >
> > For example:
> >
> > Our autodefrag is required to defrag writes newer than gen 100, and our
> > inode has the following layout:
> >
> > |---Ext A---|--- Ext B---|---Ext C---|---Ext D---|---Ext E---|
> >      Gen 50       Gen 101     Gen 49      Gen 30      Gen 30
> >
> > Then autodefrag will only try to defrag extent B and extent C.
> >
> > Extent B meets the generation requirement, and is mergable with the next
> > extent C.
> >
> > But all the remaining extents A, D, E will not be defragged as their
> > generations don't meet the requirement.
> >
> > While for regular defrag ioctl, we don't have such generation
> > requirement, and is able to defrag all extents from A to E.
> > (But cause way more IO).
> >
> > Furthermore, autodefrag works by marking the target range dirty, and
> > wait for writeback (and hopefully get more writes near it, so it can get
> > even larger)
> >
> > But if the application, like the database, is calling fsync()
> > frequently, such re-dirtied range is going to writeback almost
> > immediately, without any further chance to get merged larger.
> 
> So, basically, what you are saying is that you are refusing to work
> together towards fixing/improving the auto-defragmentation algorithm.
> 
> Based on your decision in this matter, I am now forced either to find
> a replacement filesystem with features similar to btrfs or to
> implement a filesystem (where auto-defragmentation works correctly)
> myself.

The second of those options is the TL;DR of my previous email, and
you don't need to rewrite any part of btrfs except the autodefrag feature.

I can answer questions to get you started.

You will need to read up on:

	TREE_SEARCH_V2, the search ioctl.  This gives you fast access to
	new extent refs.  You'll need to decode them.  The code in
	btrfs-progs for printing tree items is very useful to see how
	this is done.

	INO_PATHS, the resolve-inode-to-path-name ioctl.  TREE_SEARCH_V2
	will give you inode numbers, but DEFRAG_RANGE needs an open fd.
	This ioctl is the bridge between them.

	DEFRAG_RANGE, the defrag ioctl.  This defrags a range of a file.

The simple daemon model is:

	- track the filesystem transid every 30 seconds, sleep until it changes

	- use the TREE_SEARCH_V2 ioctl to find new extent references since
	the previous transid.  See the 'btrfs sub find-new' implementation
	for details on extracting extent references and filtering by age.
	This has to be run on every subvol individually, but you can
	have a daemon for every subvol, or one process that runs this
	loops over all subvols.

	- examine extent references to see if they are good candidates
	for dedupe:  not too large or too small, no holes between, etc.
	This is a replica of the existing kernel algorithm.  You can
	improve on this immediately by running new searches for
	neighboring extents within optimal defrag range without the
	transid filter.

	- ignore bad extent candidates

	- use INO_PATHS to retrieve the filenames of the inode containing
	the extent.  You can improve on this by filtering filenames of
	files that are known to have extremely high update rates, or any
	other criteria that seem useful.

	- open the file using one of the names, and issue DEFRAG_RANGE
	to defragment the extents.

If you store the last transid persistently (say in a /var file), you
can run one iteration of the loop periodically during periods of low
sensitivity to IO latency.  It doesn't need to run continuously, you
can start and stop it at any time depending on need.

There are a few gotchas.  The main one is that there's an upper bound on
optimal extent size in btrfs, as well as a lower bound.  Extents that
are too large waste space because they cannot be deallocated until the
last reference to the last block is overwritten or deleted.  So you probably
want to stop defragmenting once the extents are 256K or so on a database
file, or it will waste a lot of space.  Use lower values for heavily
active files with random writes, higher values for infrequently
modified files.  Maximum extent size is 128K for a compressed extent,
128M for uncompressed.

> Since I failed to persuade you that there are serious errors/mistakes
> in the current btrfs-autodefrag implementation, this is my last email
> in this whole forum thread.

> Sincerely
> Jan
