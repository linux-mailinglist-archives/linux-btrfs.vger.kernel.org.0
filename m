Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB540527885
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiEOPlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 11:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiEOPl0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 11:41:26 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9CF9
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 08:41:25 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nqGN1-0000zN-Lb by authid <merlin>; Sun, 15 May 2022 08:41:23 -0700
Date:   Sun, 15 May 2022 08:41:23 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220515154122.GB8056@merlins.org>
References: <20220511160009.GN12542@merlins.org>
 <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
 <20220513144113.GA16501@merlins.org>
 <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
 <20220515025703.GA13006@merlins.org>
 <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
 <20220515144145.GB13006@merlins.org>
 <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
 <20220515153347.GA8056@merlins.org>
 <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 15, 2022 at 11:35:28AM -0400, Josef Bacik wrote:
> On Sun, May 15, 2022 at 11:33 AM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, May 15, 2022 at 11:24:34AM -0400, Josef Bacik wrote:
> > > Ok I pushed something new, but completely untested as I'm sitting at a
> > > park with the kids and my kdevops thing is broken on my laptop.  You
> > > should be able to do
> > >
> > > btrfs rescue init-csum-tree <device>
> > >
> > > and it'll rebuild the csum tree.  It'll give you a progress bar as
> > > well.  I expect the normal amount of back and forth before it actually
> > > works, but it should work faster for you.  Thanks,
> >
> > Thanks. Actually I'm past that, I'm doing
> > ./btrfs check --init-csum-tree /dev/mapper/dshelf1
> > that's the one that's been running for days.
> >
> > Are you saying init-csum-tree was moved to rescue which does run faster,
> > and after that I should run the last step, check --repair, that you
> > suggested?
> >
> 
> Yes, I've replaced the rescue --init-csum-tree with rescue
> init-csum-tree, which will repopulate the csum extents.
> 
> So you should cancel what you're doing, and then run
> 
> btrfs rescue init-csum-tree <device>
> btrfs check --repair <device>
> 
> and then you should be good to go.  Thanks,

Gotcha, so let's work through the new version, looks like a recursive loop 

FS_INFO IS 0x55555564fbc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55555564fbc0

Program received signal SIGSEGV, Segmentation fault.
0x000055555559f121 in rb_search (root=root@entry=0x55555564ca20 <inserted>, key=key@entry=0x7fffff7ff020,
    comp=comp@entry=0x55555559af95 <cache_tree_comp_range>, next_ret=next_ret@entry=0x7fffff7ff038)
    at common/rbtree-utils.c:54
54      {
(gdb) bt
#0  0x000055555559f121 in rb_search (root=root@entry=0x55555564ca20 <inserted>, key=key@entry=0x7fffff7ff020,
    comp=comp@entry=0x55555559af95 <cache_tree_comp_range>, next_ret=next_ret@entry=0x7fffff7ff038)
    at common/rbtree-utils.c:54
#1  0x000055555559b199 in search_cache_extent (tree=tree@entry=0x55555564ca20 <inserted>,
    start=start@entry=15645196861440) at common/extent-cache.c:179
#2  0x0000555555584d27 in set_extent_bits (tree=tree@entry=0x55555564ca20 <inserted>, start=15645196861440,
    end=15645196877823, bits=bits@entry=1) at kernel-shared/extent_io.c:380
#3  0x0000555555584f5a in set_extent_dirty (tree=tree@entry=0x55555564ca20 <inserted>, start=<optimized out>,
    end=<optimized out>) at kernel-shared/extent_io.c:486
#4  0x00005555555e1c0e in record_csums_eb (eb=eb@entry=0x55555595fde0, processed=processed@entry=0x7fffffffdbe8)
    at cmds/rescue-init-csum-tree.c:203
#5  0x00005555555e1cf2 in record_csums_eb (eb=eb@entry=0x55555595fde0, processed=processed@entry=0x7fffffffdbe8)
    at cmds/rescue-init-csum-tree.c:224
#6  0x00005555555e1cf2 in record_csums_eb (eb=eb@entry=0x55555595fde0, processed=processed@entry=0x7fffffffdbe8)
    at cmds/rescue-init-csum-tree.c:224
#7  0x00005555555e1cf2 in record_csums_eb (eb=eb@entry=0x55555595fde0, processed=processed@entry=0x7fffffffdbe8)
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
