Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9760E54565B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiFIVPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 17:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiFIVPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 17:15:14 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF0BC03
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 14:15:12 -0700 (PDT)
Received: from [76.132.34.178] (port=59246 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nzOmO-0007nD-P0 by authid <merlins.org> with srv_auth_plain; Thu, 09 Jun 2022 14:15:11 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nzPUl-005W5M-Pj; Thu, 09 Jun 2022 14:15:11 -0700
Date:   Thu, 9 Jun 2022 14:15:11 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220609211511.GW1745079@merlins.org>
References: <20220608004241.GC22722@merlins.org>
 <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
 <20220608021245.GD22722@merlins.org>
 <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
 <20220608213030.GG22722@merlins.org>
 <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org>
 <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 76.132.34.178
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 09, 2022 at 04:46:28PM -0400, Josef Bacik wrote:
> Sorry this took me longer than normal to work out what happened and
> how to fix it properly.
 
It takes the time it takes, I'm sure nothing there is obvious

> You can pull and re-run btrfs check --repair <device> and it should
> fix the device thing that's missing.  We can tackle the other fs
> errors next, but I want to see if we can at least get you mounting the
> fs.  Thanks,

Done:
WARNING: reserved space leaked, transid=2606858 flag=0x2 bytes_reserved=49152
root 164629 inode 73099 errors 1000, some csum missing
WARNING: reserved space leaked, transid=2606859 flag=0x2 bytes_reserved=49152
root 164629 inode 73100 errors 1000, some csum missing
        unresolved ref dir 791 index 0 namelen 25 name Banlieue 13 Ultimatum.avi filetype 1 errors 6, no dir index, no inode ref
        unresolved ref dir 3676 index 0 namelen 62 name foo filetype 1 errors 6, no dir index, no inode ref
ERROR: errors found in fs roots
WARNING: reserved space leaked, flag=0x2 bytes_reserved=49152
extent buffer leak: start 15645018226688 len 16384

Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
cache and super generation don't match, space cache will be invalidated
Fixed the nlink of inode 5644
reset nbytes for ino 54987 root 161199
reset nbytes for ino 54997 root 161199
reset nbytes for ino 55002 root 161199
reset isize for dir 55138 root 161199
reset nbytes for ino 55458 root 161199
reset nbytes for ino 55467 root 161199
reset nbytes for ino 55474 root 161199
reset nbytes for ino 55525 root 161199
reset nbytes for ino 54987 root 161889
reset nbytes for ino 54997 root 161889
reset nbytes for ino 55002 root 161889
reset isize for dir 55138 root 161889
reset nbytes for ino 55458 root 161889
reset nbytes for ino 55467 root 161889
reset nbytes for ino 55474 root 161889
reset nbytes for ino 55525 root 161889
Fixed the nlink of inode 95666
Fixed the nlink of inode 95666
Fixed the nlink of inode 95666
reset isize for dir 4549 root 164624
reset isize for dir 25810 root 164624
reset isize for dir 25812 root 164624
reset nbytes for ino 26004 root 164624
reset isize for dir 31346 root 164624
reset nbytes for ino 72418 root 164624
reset isize for dir 72587 root 164624
reset isize for dir 72592 root 164624
reset isize for dir 72639 root 164624
reset isize for dir 72640 root 164624
reset isize for dir 72672 root 164624
reset nbytes for ino 73001 root 164624
reset nbytes for ino 73006 root 164624
reset nbytes for ino 73045 root 164624
reset nbytes for ino 73066 root 164624
reset nbytes for ino 73082 root 164624
reset nbytes for ino 73086 root 164624
reset nbytes for ino 73099 root 164624
reset nbytes for ino 73100 root 164624
reset isize for dir 3747 root 164629
reset isize for dir 3752 root 164629
reset isize for dir 3965 root 164629
reset isize for dir 4549 root 164629
reset nbytes for ino 40537 root 164629
reset nbytes for ino 72418 root 164629
reset isize for dir 72587 root 164629
reset isize for dir 72592 root 164629
reset isize for dir 72639 root 164629
reset isize for dir 72640 root 164629
reset isize for dir 72672 root 164629
reset nbytes for ino 73001 root 164629
reset nbytes for ino 73006 root 164629
reset nbytes for ino 73045 root 164629
reset nbytes for ino 73066 root 164629
reset nbytes for ino 73082 root 164629
reset nbytes for ino 73086 root 164629
reset nbytes for ino 73099 root 164629
reset nbytes for ino 73100 root 164629
found 21916315648 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 8880128
total fs tree bytes: 6799360
total extent tree bytes: 606208
btree space waste bytes: 2518033
file data blocks allocated: 36729012224
 referenced 36727418880
gargamel:/var/local/src/btrfs-progs-josefbacik# mount -o ro,recovery /dev/mapper/dshelf1 /mnt/mnt
mount: /mnt/mnt: wrong fs type, bad option, bad superblock on /dev/mapper/dshelf1, missing codepage or helper program, or other error

[3956372.768821] BTRFS info (device dm-1): disk space caching is enabled
[3956372.789085] BTRFS info (device dm-1): has skinny extents
[3956372.863763] BTRFS error (device dm-1): dev extent physical offset 709781094400 on devid 1 doesn't have corresponding chunk
[3956372.899452] BTRFS error (device dm-1): failed to verify dev extents against chunks: -117
[3956372.926355] BTRFS error (device dm-1): open_ctree failed
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
