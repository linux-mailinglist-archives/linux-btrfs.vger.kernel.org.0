Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1629D53DE75
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jun 2022 23:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347936AbiFEVuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiFEVuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 17:50:39 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A524DF40
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 14:50:38 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nxy8r-0001FP-0z by authid <merlin>; Sun, 05 Jun 2022 14:50:37 -0700
Date:   Sun, 5 Jun 2022 14:50:36 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220605215036.GE22722@merlins.org>
References: <20220603183927.GZ22722@merlins.org>
 <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
 <20220604134823.GB22722@merlins.org>
 <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
 <20220605001349.GJ1745079@merlins.org>
 <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
 <20220605201112.GN1745079@merlins.org>
 <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
 <20220605212637.GO1745079@merlins.org>
 <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
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

On Sun, Jun 05, 2022 at 05:43:41PM -0400, Josef Bacik wrote:
> On Sun, Jun 5, 2022 at 5:26 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, Jun 05, 2022 at 04:58:15PM -0400, Josef Bacik wrote:
> > >
> > > Sigh try again please.  Thanks,
> >
> > Same
> 
> Sorry, this one should work.  Thanks,

FS_INFO IS 0x555555650bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x555555650bc0
Walking all our trees and pinning down the currently accessible blocks
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15054972026880 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
Clearing the extent root and re-init'ing the block groups
deleting space cache for 11106814787584
deleting space cache for 11108962271232
deleting space cache for 11110036013056
deleting space cache for 11111109754880
deleting space cache for 11112183496704
(...)
inserting block group 15929559744512
inserting block group 15930633486336
inserting block group 15931707228160
inserting block group 15932780969984
inserting block group 15933854711808
ERROR: Error reading data reloc tree -2

ERROR: failed to reinit the data reloc root
searching 1 for bad extents
processed 999424 of 0 possible bytes, 0%
searching 4 for bad extents
processed 163840 of 1064960 possible bytes, 15%
searching 5 for bad extents
processed 65536 of 10960896 possible bytes, 0%
searching 7 for bad extents
processed 16384 of 16570974208 possible bytes, 0%
searching 9 for bad extents
processed 16384 of 16384 possible bytes, 100%
searching 161197 for bad extents
processed 131072 of 108986368 possible bytes, 0%
searching 161199 for bad extents
processed 196608 of 49479680 possible bytes, 0%
searching 161200 for bad extents
processed 180224 of 254214144 possible bytes, 0%
searching 161889 for bad extents
processed 229376 of 49446912 possible bytes, 0%
searching 162628 for bad extents
processed 49152 of 49463296 possible bytes, 0%
searching 162632 for bad extents
processed 147456 of 94633984 possible bytes, 0%
searching 163298 for bad extents
processed 49152 of 49463296 possible bytes, 0%
searching 163302 for bad extents
processed 147456 of 94633984 possible bytes, 0%
searching 163303 for bad extents
processed 131072 of 76333056 possible bytes, 0%
searching 163316 for bad extents
processed 147456 of 108544000 possible bytes, 0%
searching 163920 for bad extents
processed 16384 of 108691456 possible bytes, 0%
searching 164620 for bad extents
processed 49152 of 49463296 possible bytes, 0%
searching 164623 for bad extents
processed 311296 of 63193088 possible bytes, 0%
searching 164624 for bad extents

Found an extent we don't have a block group for in the file
corrupt node: root=164624 root bytenr 15645018226688 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
Couldn't find any paths for this inode
corrupt node: root=164624 root bytenr 15645019652096 commit bytenr 15645018226688 block=15645019668480 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
ERROR: error searching for key?? -1 root 164624 node 15645019652096 commit 15645018226688

wtf
it failed?? -1
ERROR: failed to clear bad extents
doing close???
ERROR: attempt to start transaction over already running one
WARNING: reserved space leaked, flag=0x4 bytes_reserved=32768
extent buffer leak: start 15645019652096 len 16384
extent buffer leak: start 15645019652096 len 16384
WARNING: dirty eb leak (aborted trans): start 15645019652096 len 16384
extent buffer leak: start 15645019668480 len 16384
extent buffer leak: start 15645019668480 len 16384
WARNING: dirty eb leak (aborted trans): start 15645019668480 len 16384
Init extent tree failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
