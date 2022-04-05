Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67544F544A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443719AbiDFErG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356222AbiDEVex (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 17:34:53 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E6BA306
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 13:37:38 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbpvl-0000pT-Ll by authid <merlin>; Tue, 05 Apr 2022 13:37:37 -0700
Date:   Tue, 5 Apr 2022 13:37:37 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405203737.GE28707@merlins.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
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
> going to chalk this up to it just fucking with me and ignore it for
> now.  I pushed some changes for the find root thing, can you re-run


Typo I fixed:
kernel-shared/disk-io.c: In function ‘verify_parent_transid’:
kernel-shared/disk-io.c:278:35: error: ‘struct btrfs_fs_info’ has no member named ‘suppress_check_block_errrs’; did you mean ‘suppress_check_block_errors’?
  278 |   if (eb->fs_info && eb->fs_info->suppress_check_block_errrs)
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                   suppress_check_block_errors

> ./btrfs-find-root -o 1 /dev/whatever
> 
> it should be less noisy and spit out one line at the end, "Found tree
> root at blah blah".  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# l btrfs-find-root
-rwxr-xr-x 1 root staff 3375608 Apr  5 13:29 btrfs-find-root*
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a 2>&1 |tee /tmp/out
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x56289ce172a0
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x56289ce172a0
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
(many deleted)
Ignoring transid failure
Superblock thinks the generation is 1602089
Superblock thinks the level is 1
Found tree root at 13577814573056 gen 1602089 level 1

Good news :)
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
