Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99D74F5451
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiDFErs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450126AbiDFCuN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 22:50:13 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A9511A383
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 16:51:30 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 1C9002AEB2F; Tue,  5 Apr 2022 19:51:30 -0400 (EDT)
Date:   Tue, 5 Apr 2022 19:51:29 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Marc MERLIN <marc@merlins.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <YkzWAZtf7rcY/d+7@hungrycats.org>
References: <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
 <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
 <20220405181108.GA28707@merlins.org>
 <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org>
 <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org>
 <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 05, 2022 at 04:24:16PM -0400, Josef Bacik wrote:
> On Tue, Apr 5, 2022 at 4:08 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, Apr 05, 2022 at 04:05:05PM -0400, Josef Bacik wrote:
> > > Well it's still the same, and this thing is 20mib into your fs so IDK
> > > how it would be screwing up now.  Can you do
> > >
> > > ./btrfs inspect-internal dump-tree -b 21069824
> > >
> > > and see what that spits out?  IDK why it would suddenly start
> > > complaining about your chunk root.  Thanks,
> >
> > Thanks for your patience and sticking with me
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -b 21069824 /dev/mapper/dshelf1a >/dev/null
> 
> Ok well that worked, which means it found the chunk tree fine, I'm

There's two copies of the chunk tree in dup metadata.  Maybe one of them
is bad?

It seems surprising to me if that's the case.  I didn't think the
userspace read code did anything like the current->pid % 2 dance,
and even if it did, I'd expect it to show up before now.

Other possibilites include irreproducible reads coming from the bcache
layer if that's still active (e.g. if it was on mdadm raid1, and the
raid1 mirrors were out of sync and didn't know it).  Hopefully not,
because it would make this...challenging.

> going to chalk this up to it just fucking with me and ignore it for
> now.  I pushed some changes for the find root thing, can you re-run
> 
> ./btrfs-find-root -o 1 /dev/whatever
> 
> it should be less noisy and spit out one line at the end, "Found tree
> root at blah blah".  Thanks,
> 
> Josef
