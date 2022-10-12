Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3985FC360
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 12:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJLKEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 06:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJLKEE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 06:04:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AAEB5171
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 03:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1DAB61468
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 10:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD43FC433D6;
        Wed, 12 Oct 2022 10:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665569042;
        bh=NhYnBeJSdGQomzSAhi6txKzdgkm8rkw5UnyMSL3dCDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gdt1XNwps+JVhqgPvyjma7IY3Fbkpm/1bwk8ECtAMOLRp2YTS2BJ+EBxUuCoLlrwE
         lYt46Pu7I+xzcQZORvR8LLwG5QEVsVRAA/81tXOCaSwczwj8NdlI8ceUXfT978610j
         umhAkbJk+rUk/cdsZLcvaoblQud4iQgV7sQq0XGbIIU7dBAAJCOJIyP4fzYrni4RIX
         wT7WGDd9bNxcfnA5H3vq3vyObPEXUhqb6/MrNfgM8DFDNXMLlD9EtR1XkHvZ5DKmfh
         6TxXXpQqdSHG+5NmCJ6Rwn4YT/Id8EzbHnjhZrlt537LbKcb6IGHAhxYnR57SjBPji
         9nvDRtJffudIw==
Date:   Wed, 12 Oct 2022 11:03:59 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Glenn Washburn <development@efficientek.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs send/receive not always sharing extents
Message-ID: <20221012100359.GB2290976@falcondesktop>
References: <20221008005704.795b44b0@crass-HP-ZBook-15-G2>
 <20221010094218.GA2141122@falcondesktop>
 <20221011154955.45aacef8@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011154955.45aacef8@crass-HP-ZBook-15-G2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 03:49:55PM -0500, Glenn Washburn wrote:
> On Mon, 10 Oct 2022 10:42:18 +0100
> Filipe Manana <fdmanana@kernel.org> wrote:
> 
> > On Sat, Oct 08, 2022 at 12:57:04AM -0500, Glenn Washburn wrote:
> > > I've got two reflinked files in a subvol that I'm sending/receiving to
> > > a different btrfs filesystem and they are not sharing extents on the
> > > receiving side. Other reflinked files in the same subvol are being
> > > reflinked on the receive side. The send side has a fairly old creation
> > > date if that matters. Attached is the receive log and a diff of
> > > filefrag's output for the files on the source volume to show that the
> > > two files (IMG_20200402_143055.dng and IMG_20200402_143055.dng.ref) are
> > > refinked on the source volume. This is a somewhat minimal example of
> > > what's happening on a big send that I'm doing that is failing because
> > > the receive side it too small to hold data when the reflinks are
> > > broken. Is this a bug? or what can I do to get send to see these files
> > > are reflinked?
> > 
> > send/receive only guarantees that the destination ends up with the same
> > data as the source.
> > 
> > It doesn't guarantee extents are always shared as in the source filesystem,
> > that the extent layout is the same, or holes are preserved for example.
> > 
> > There are two main reasons why extents don't often get cloned during
> > send/receive:
> > 
> > 1) The extent is shared more than 64 times in the source filesystem.
> >    We have this limitation because figuring out all inodes/roots that
> >    share an extent can be expensive, and therefore massively slowdown
> >    send operations.
> > 
> > 2) Even when an extent is shared less than 64 times in the source
> >    filesystem, we often don't clone the entirety of an extent and end up
> >    issuing write operations for the remaining part(s). This is due to
> >    algorithmic complexity as well, as identifying the best source for
> >    cloning an extent can be expensive and considerably slowdown send
> >    operations.
> 
> So my example falls into this category. I have a limited understanding
> of BTRFS internals, can backrefs be used here to decrease the
> algorithmic complexity and duration? Naively, it would seem that having
> a backref to inodes that use the extent would be enough to keep track
> of where clones should be put in the send stream.

We use backrefs to determine which inodes/roots share a given extent.
It's just that it doesn't scale well when an extent is shared many times,
especially if indirectly through snapshots/shared subtrees. And this is
common code used by several places besides send.

Admittedly, the way it's currently done is not optimal for the context of
send. And that's what I want to improve, so that it skips unnecessary work
for the send case and scale better.

> 
> > 
> > I have some work in progress and ideas to speedup send in some cases,
> > but I'm afraid we'll always have some limitations - in the best case
> > we can improve on them, but not eliminate them completely.
> > 
> > You can run a dedupe tool on the destination filesystem to get the
> > extents shared.
> 
> Thanks for the explanation. The problem with using a dedupe tool is
> (1) that potentially a lot of unnecessary writes are involved, and more
> importantly (2) the send will potentially cause more disk space to be
> used than is used by the source and thus potentially more than the
> target when the target is the same size as the source. Since we don't
> know beforehand if send will clone shared extents, the user must assume
> that it will clone none and receive on a filesystem with at least enough
> free space as the size of the total references data. This may not be an
> option for the user (me).
> 
> I believe this theoretically could be mitigated if there were a dedupe
> tool that would watch the filesystem for writes and do dedup as soon as
> a write happened. I don't think any of the current tools do though.
> Separately, perhaps there could be a tool that reads the send stream on
> the receive side and inserts extent clones.
> 
> The easiest way forward seems to me to add options for send to try harder to find
> extent clones (at the expense of time and resources).

I think this can be improved without sacrificing performance/scalability
and without the need of a special option/flag, maybe not to a perfect
level (get exactly the same amount of sharing as in the source filesystem),
but at least significantly better than what we have today. 

You are not the first one reporting that and it comes as a surprise to many
other users as well.

I'll work on those two improvements in the next weeks and see if I can have
them ready for a 6.2 kernel.

> 
> > 
> > > --- /dev/fd/63	2022-10-08 00:31:46.783138591 -0500
> > > +++ /dev/fd/62	2022-10-08 00:31:46.787138126 -0500
> > > @@ -1,5 +1,5 @@
> > >  Filesystem type is: 9123683e
> > > -File size of /media/test-btrfs/test/1.ro/IMG_20200402_143055.dng is 24674116 (6024 blocks of 4096 bytes)
> > > +File size of /media/test-btrfs/test/1.ro/IMG_20200402_143055.dng.ref is 24674116 (6024 blocks of 4096 bytes)
> > >   ext:     logical_offset:        physical_offset: length:   expected: flags:
> > >     0:        0..    6023: 1131665768..1131671791:   6024:             last,shared,eof
> > > -/media/test-btrfs/test/1.ro/IMG_20200402_143055.dng: 1 extent found
> > > +/media/test-btrfs/test/1.ro/IMG_20200402_143055.dng.ref: 1 extent found
> > 
> > 
