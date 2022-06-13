Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08609549DCE
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 21:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiFMTe7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 15:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbiFMTet (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 15:34:49 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A838B606E8
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 10:56:52 -0700 (PDT)
Received: from rrcs-173-197-119-179.west.biz.rr.com ([173.197.119.179]:55299 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o0nae-0004r0-7d by authid <merlins.org> with srv_auth_plain; Mon, 13 Jun 2022 10:56:51 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o0oJ1-00CCaa-16; Mon, 13 Jun 2022 10:56:51 -0700
Date:   Mon, 13 Jun 2022 10:56:51 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220613175651.GM1664812@merlins.org>
References: <20220608213030.GG22722@merlins.org>
 <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org>
 <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 173.197.119.179
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 #####                                                    ###
#     #  #    #   ####    ####   ######   ####    ####    ###
#        #    #  #    #  #    #  #       #       #        ###
 #####   #    #  #       #       #####    ####    ####     #
      #  #    #  #       #       #            #       #
#     #  #    #  #    #  #    #  #       #    #  #    #   ###
 #####    ####    ####    ####   ######   ####    ####    ###

On Fri, Jun 10, 2022 at 03:55:09PM -0400, Josef Bacik wrote:
> btrfs rescue recover-chunks <device>

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
FS_INFO IS 0x56528f943bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x56528f943bc0
Walking all our trees and pinning down the currently accessible blocks
No missing chunks, we're all done
doing close???
Recover chunks succeeded, you can run check now

> btrfs rescue init-extent-tree <device>

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
FS_INFO IS 0x55fd039e2bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55fd039e2bc0
Walking all our trees and pinning down the currently accessible blocks
Clearing the extent root and re-init'ing the block groups
deleting space cache for 20971520
deleting space cache for 11106814787584
deleting space cache for 11108962271232
deleting space cache for 11110036013056
deleting space cache for 11111109754880
(...)
doing roots
(...)
processed 49152 of 49463296 possible bytes, 0%
Recording extents for root 164633
processed 16384 of 75694080 possible bytes, 0%
Recording extents for root 164823
processed 507904 of 63504384 possible bytes, 0%
Recording extents for root 18446744073709551607
processed 16384 of 16384 possible bytes, 100%
doing block accounting
doing close???
Init extent tree finished, you can run check now

> btrfs check --repair <device>

FS_INFO AFTER IS 0x5641f2a63bd0
[1/7] checking root items
checksum verify failed on 15645959372800 wanted 0x847c08bf found 0x17a9e2f1
checksum verify failed on 15645959389184 wanted 0x3cc757a7 found 0x3b4eff03
checksum verify failed on 15645681451008 wanted 0x7516a3d9 found 0x97f7437d
checksum verify failed on 15646003970048 wanted 0xf18cc579 found 0x1bc64584
checksum verify failed on 15645867720704 wanted 0x14cc427a found 0x9f516106
checksum verify failed on 15645529604096 wanted 0xd11e24d5 found 0x8d01bc00
checksum verify failed on 15645781344256 wanted 0xb81e3df4 found 0xb5c70846
checksum verify failed on 15645959356416 wanted 0x2fa8537e found 0x90ac1f4e
checksum verify failed on 15645692067840 wanted 0x7874ded3 found 0x1e94afcd
checksum verify failed on 15645529620480 wanted 0x9ba9c3df found 0x1813c193
checksum verify failed on 15645608165376 wanted 0x2af09d83 found 0xdc3aa13d
checksum verify failed on 15645815291904 wanted 0x27e465d0 found 0x3e898f04
checksum verify failed on 15645419667456 wanted 0xde0dab28 found 0x3ceddd16
checksum verify failed on 15645815357440 wanted 0xeff7f183 found 0x21b9d056
checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
Fixed 0 roots.
[2/7] checking extents
Chunk[256, 228, 20971520] stripe[1, 20971520] is not found in dev extent
Chunk[256, 228, 20971520] stripe[1, 29360128] is not found in dev extent
[3/7] checking free space cache
(...)
root 164629 inode 73099 errors 1000, some csum missing
root 164629 inode 73100 errors 1000, some csum missing
        unresolved ref dir 791 index 0 namelen 25 name file filetype 1 errors 6, no dir index, no inode ref
        unresolved ref dir 3676 index 0 namelen 62 name file2 filetype 1 errors 6, no dir index, no inode ref
ERROR: errors found in fs roots

Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
No device size related problem found
cache and super generation don't match, space cache will be invalidated
found 21916200960 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 8765440
total fs tree bytes: 6799360
total extent tree bytes: 573440
btree space waste bytes: 2514656
file data blocks allocated: 


gargamel:~# mount /dev/mapper/dshelf1 /mnt/mnt
gargamel:~#
[4289823.922324] BTRFS info (device dm-1): trying to use backup root at mount time
[4289823.922326] BTRFS info (device dm-1): disk space caching is enabled
[4289823.922327] BTRFS info (device dm-1): has skinny extents
[4289824.188614] BTRFS info (device dm-1): enabling ssd optimizations
[4289847.574926] BTRFS info (device dm-1): flagging fs with big metadata feature
[4289847.598104] BTRFS info (device dm-1): disk space caching is enabled
[4289847.651582] BTRFS info (device dm-1): has skinny extents
[4289847.699541] BTRFS info (device dm-1): enabling ssd optimizations
[4289847.730931] BTRFS info (device dm-1): checking UUID tree
[4289847.798826] BTRFS error (device dm-1): bad tree block level 19 on 15645959372800
[4289847.912586] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959372800 (dev /dev/mapper/dshelf1 sector 29403983072)
[4289847.956640] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959376896 (dev /dev/mapper/dshelf1 sector 29403983080)
[4289848.000894] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959380992 (dev /dev/mapper/dshelf1 sector 29403983088)
[4289848.045141] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959385088 (dev /dev/mapper/dshelf1 sector 29403983096)
[4289848.083771] BTRFS error (device dm-1): bad tree block level 39 on 15645959389184
[4289848.111468] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959389184 (dev /dev/mapper/dshelf1 sector 29403983104)
[4289848.155838] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959393280 (dev /dev/mapper/dshelf1 sector 29403983112)
[4289848.199940] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959397376 (dev /dev/mapper/dshelf1 sector 29403983120)
[4289848.244198] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959401472 (dev /dev/mapper/dshelf1 sector 29403983128)
[4289848.281912] BTRFS error (device dm-1): bad tree block level 85 on 15645681451008
[4289848.358339] BTRFS info (device dm-1): read error corrected: ino 0 off 15645681451008 (dev /dev/mapper/dshelf1 sector 29403440256)
[4289848.396605] BTRFS info (device dm-1): read error corrected: ino 0 off 15645681455104 (dev /dev/mapper/dshelf1 sector 29403440264)
[4289848.436740] BTRFS error (device dm-1): bad tree block level 22 on 15646003970048
[4289848.493665] BTRFS error (device dm-1): bad tree block level 127 on 15645867720704
[4289848.549485] BTRFS error (device dm-1): bad tree block level 165 on 15645529604096
[4289848.640033] BTRFS error (device dm-1): bad tree block level 32 on 15645781344256
[4289848.713594] BTRFS error (device dm-1): bad tree block level 16 on 15645959356416
[4289848.786591] BTRFS warning (device dm-1): checksum verify failed on 15645692067840 wanted 0x7874ded3 found 0x1e94afcd level 7
[4289848.837010] BTRFS error (device dm-1): bad tree block level 62 on 15645529620480
[4289848.905220] BTRFS error (device dm-1): bad tree block level 151 on 15645608165376
[4289848.941769] BTRFS error (device dm-1): bad tree block level 24 on 15645815291904
[4289848.991611] BTRFS error (device dm-1): bad tree block level 34 on 15645419667456
[4289849.061467] BTRFS error (device dm-1): bad tree block level 26 on 15645815357440
[4289849.109509] BTRFS error (device dm-1): bad tree block level 18 on 15645781196800

There is still some damage that maybe check/repair should fix, but it's
mountable, that's definitely a huge success!

Thanks Josef, that was a lot of work and determination :)

Let me know if there is more you'd like to look at, and/or try and get
the FS to a state where it's actually clean, but honestly as long as it
mounts, that's already a lot, obviously.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
