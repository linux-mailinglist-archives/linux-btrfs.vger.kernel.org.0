Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5849953D8DD
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jun 2022 02:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbiFEANz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jun 2022 20:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiFEANz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jun 2022 20:13:55 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129FB4D605
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Jun 2022 17:13:52 -0700 (PDT)
Received: from [76.132.34.178] (port=59186 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nxdBW-0000Un-3U by authid <merlins.org> with srv_auth_plain; Sat, 04 Jun 2022 17:13:49 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nxdtt-00EQcM-48; Sat, 04 Jun 2022 17:13:49 -0700
Date:   Sat, 4 Jun 2022 17:13:49 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220605001349.GJ1745079@merlins.org>
References: <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org>
 <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
 <20220603164252.GH1745079@merlins.org>
 <20220603170700.GX22722@merlins.org>
 <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
 <20220603183927.GZ22722@merlins.org>
 <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
 <20220604134823.GB22722@merlins.org>
 <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 76.132.34.178
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 04, 2022 at 07:10:16PM -0400, Josef Bacik wrote:
 
> Ok this looks like it worked?  Can you re-run tree-recover to see if
> it uses the right bytenr?  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x5568318c7bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5568318c7bc0
Checking root 2 bytenr 15645019668480
Checking root 4 bytenr 15645019078656
Checking root 5 bytenr 15645018161152
Checking root 7 bytenr 15645019488256
Checking root 9 bytenr 15645740367872
Checking root 161197 bytenr 15645018341376
Checking root 161199 bytenr 15645018652672
Checking root 161200 bytenr 15645018750976
Checking root 161889 bytenr 11160502124544
Checking root 162628 bytenr 15645018931200
Checking root 162632 bytenr 15645018210304
Checking root 163298 bytenr 15645019045888
Checking root 163302 bytenr 15645018685440
Checking root 163303 bytenr 15645019095040
Checking root 163316 bytenr 15645018996736
Checking root 163920 bytenr 15645019144192
Checking root 164620 bytenr 15645019275264
Checking root 164623 bytenr 15645019226112
Checking root 164624 bytenr 15645502210048
Checking root 164629 bytenr 15645485137920
Checking root 164631 bytenr 15645496983552
Checking root 164633 bytenr 15645526884352
Checking root 164823 bytenr 15645999005696
Tree recovery finished, you can run check now

But
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1           
(...)
nserting block group 15920969809920
inserting block group 15922043551744
inserting block group 15923117293568
inserting block group 15924191035392
inserting block group 15925264777216
inserting block group 15926338519040
inserting block group 15927412260864
inserting block group 15928486002688
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
file
Deleting [260, 108, 0] root 15645019553792 path top 15645019553792 top slot 0 leaf 15645019602944 slot 114

searching 164624 for bad extents

Found an extent we don't have a block group for in the file
file
corrupt node: root=164624 block=15645018324992 physical=15054972026880 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
Deleting [260, 108, 58146816] root 15645018226688 path top 15645018226688 top slot 0 leaf 15645018718208 slot 114

searching 164624 for bad extents

Found an extent we don't have a block group for in the file
corrupt node: root=164624 block=15645018324992 physical=15054972026880 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
Couldn't find any paths for this inode
corrupt node: root=164624 block=15645019553792 physical=15054973255680 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
ERROR: error searching for key?? -1

wtf
it failed?? -1
ERROR: failed to clear bad extents
doing close???
ERROR: attempt to start transaction over already running one
WARNING: reserved space leaked, flag=0x4 bytes_reserved=32768
extent buffer leak: start 15645018374144 len 16384
extent buffer leak: start 15645018374144 len 16384
WARNING: dirty eb leak (aborted trans): start 15645018374144 len 16384
extent buffer leak: start 15645019553792 len 16384
extent buffer leak: start 15645019553792 len 16384
WARNING: dirty eb leak (aborted trans): start 15645019553792 len 16384
Init extent tree failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
