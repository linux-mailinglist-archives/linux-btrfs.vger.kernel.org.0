Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177A44F5448
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442983AbiDFEq7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452872AbiDEWca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 18:32:30 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6921BE82
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 14:26:55 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbqhT-0005dq-Fy by authid <merlin>; Tue, 05 Apr 2022 14:26:55 -0700
Date:   Tue, 5 Apr 2022 14:26:55 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405212655.GH28707@merlins.org>
References: <20220405195157.GA3307770@merlins.org>
 <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org>
 <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <20220405203737.GE28707@merlins.org>
 <CAEzrpqemQ2Uzi+ZJHtQtbF62=hZMTmuPT3HxwkYedUvAsXhdvQ@mail.gmail.com>
 <20220405211412.GF28707@merlins.org>
 <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
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

On Tue, Apr 05, 2022 at 05:19:57PM -0400, Josef Bacik wrote:
> Otra vez por favor,

(gdb) run -o 1 /dev/mapper/dshelf1a
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs-find-root -o 1 /dev/mapper/dshelf1a
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x5555555cf2a0
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x5555555cf2a0
Superblock thinks the generation is 1602089
Superblock thinks the level is 1

Program received signal SIGSEGV, Segmentation fault.
lookup_cache_extent (tree=tree@entry=0x5555555cf308, start=start@entry=505282560, size=size@entry=16384) at common/extent-cache.c:142
142		range.start = start;
(gdb) bt
#0  lookup_cache_extent (tree=tree@entry=0x5555555cf308, start=start@entry=505282560, size=size@entry=16384)
    at common/extent-cache.c:142
#1  0x0000555555579d1e in alloc_extent_buffer (fs_info=0x5555555cf2a0, bytenr=505282560, blocksize=16384)
    at kernel-shared/extent_io.c:737
#2  0x000055555556e44c in btrfs_find_create_tree_block (fs_info=<optimized out>, bytenr=<optimized out>)
    at kernel-shared/disk-io.c:230
#3  0x0000555555570208 in read_tree_block (fs_info=0x5555555cf2a0, bytenr=<optimized out>, parent_transid=1601370)
    at kernel-shared/disk-io.c:374
#4  0x00005555555a06df in try_read_block (slot=0, eb=0x5555721ef1a0) at btrfs-find-root.c:109
#5  count_bad_items (eb=0x5555721ef1a0) at btrfs-find-root.c:162
#6  0x00005555555a0724 in count_bad_items (eb=0x5555721ef1a0) at btrfs-find-root.c:164
#7  0x00005555555a0724 in count_bad_items (eb=0x5555721ef1a0) at btrfs-find-root.c:164
#8  0x00005555555a0724 in count_bad_items (eb=0x5555721ef1a0) at btrfs-find-root.c:164
#9  0x00005555555a0724 in count_bad_items (eb=0x5555721ef1a0) at btrfs-find-root.c:164
#10 0x00005555555a0724 in count_bad_items (eb=0x5555721ef1a0) at btrfs-find-root.c:164
#11 0x00005555555a0724 in count_bad_items (eb=0x5555721ef1a0) at btrfs-find-root.c:164

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
