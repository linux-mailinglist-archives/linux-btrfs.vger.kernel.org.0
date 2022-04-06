Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBCC4F59FC
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiDFJbP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581929AbiDFJVl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 05:21:41 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706201E1F5D
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 20:34:05 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbwQm-0005QD-TD by authid <merlin>; Tue, 05 Apr 2022 20:34:04 -0700
Date:   Tue, 5 Apr 2022 20:34:04 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220406033404.GQ28707@merlins.org>
References: <20220405212655.GH28707@merlins.org>
 <CAEzrpqc0Ss+J6oTqNPfTgWOwyhPAF2uHnRELmc6AO6je6Ht88w@mail.gmail.com>
 <20220405214309.GI28707@merlins.org>
 <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
 <20220405225808.GJ28707@merlins.org>
 <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
 <20220406003521.GM28707@merlins.org>
 <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
 <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
 <20220406031255.GO28707@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406031255.GO28707@merlins.org>
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

On Tue, Apr 05, 2022 at 08:12:55PM -0700, Marc MERLIN wrote:
> On Tue, Apr 05, 2022 at 09:08:32PM -0400, Josef Bacik wrote:
> > Also keep in mind this isn't the final fix, this is the pre-repair so
> > hopefully fsck can put the rest of it back together.  Thanks,
> 
> Done, so now I can run 
> btrfs check --repair /dev/mapper/dshelf1a ?
 
Here is regular check:
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check /dev/mapper/dshelf1a
Opening filesystem to check...
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x564d665f1e50
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
Couldn't find the last root for 8
checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
parent transid verify failed on 15645261971456 wanted 1602297 found 1600989
checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
bad tree block 15645261971456, bad level, 127 > 8
ERROR: failed to read block groups: Input/output error
FS_INFO AFTER IS 0x564d665f1e50
Checking filesystem on /dev/mapper/dshelf1a
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
[1/7] checking root items
checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
parent transid verify failed on 15645261971456 wanted 1602297 found 1600989
checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
bad tree block 15645261971456, bad level, 127 > 8
ERROR: failed to repair root items: Input/output error
[2/7] checking extents
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 13577702703104 wanted 1602089 found 1602241
parent transid verify failed on 13577702703104 wanted 1602089 found 1602241
parent transid verify failed on 13577702703104 wanted 1602089 found 1602241
parent transid verify failed on 12511683117056 wanted 1602089 found 1602202
parent transid verify failed on 12511683117056 wanted 1602089 found 1602202
parent transid verify failed on 12511683117056 wanted 1602089 found 1602202
parent transid verify failed on 15645121789952 wanted 1602089 found 1602135
parent transid verify failed on 15645121789952 wanted 1602089 found 1600922
parent transid verify failed on 15645121789952 wanted 1602089 found 1602135
parent transid verify failed on 15645274947584 wanted 1602089 found 1602298
parent transid verify failed on 15645274947584 wanted 1602089 found 1602298
parent transid verify failed on 15645274947584 wanted 1602089 found 1602298
checksum verify failed on 13577870934016 wanted 0xfffb4d18 found 0xb0be1c94
parent transid verify failed on 11160884019200 wanted 1602089 found 1602180
parent transid verify failed on 11160884019200 wanted 1602089 found 1602180
parent transid verify failed on 11160884019200 wanted 1602089 found 1602180
parent transid verify failed on 15645280632832 wanted 1602089 found 1602298
parent transid verify failed on 15645280632832 wanted 1602089 found 1601000
parent transid verify failed on 15645280632832 wanted 1602089 found 1602298
parent transid verify failed on 15645397942272 wanted 1602089 found 1602141
parent transid verify failed on 15645397942272 wanted 1602089 found 1602141
parent transid verify failed on 15645397942272 wanted 1602089 found 1602141
parent transid verify failed on 15645399678976 wanted 1602089 found 1602243
checksum verify failed on 15645399678976 wanted 0xf1e9450d found 0xe8cf0418
checksum verify failed on 15645399678976 wanted 0xf1e9450d found 0xe8cf0418
bad tree block 15645399678976, bad level, 236 > 8
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
ERROR: invalid generation for root 5, have 1602297 expect (0, 1602090]
checksum verify failed on 15645248897024 wanted 0xce96f609 found 0x2d1b5ea6
parent transid verify failed on 15645248897024 wanted 1602297 found 1600937
checksum verify failed on 15645248897024 wanted 0xce96f609 found 0x2d1b5ea6
bad tree block 15645248897024, bad level, 66 > 8
The following tree block(s) is corrupted in tree 5:
	tree block bytenr: 15645248880640, level: 2, node key: (256, 1, 0)
root 5 root dir 256 not found
parent transid verify failed on 13577702703104 wanted 1602089 found 1602241
parent transid verify failed on 12511683117056 wanted 1602089 found 1602202
parent transid verify failed on 15645121789952 wanted 1602089 found 1602135
parent transid verify failed on 15645274947584 wanted 1602089 found 1602298
parent transid verify failed on 11160884019200 wanted 1602089 found 1602180
parent transid verify failed on 15645280632832 wanted 1602089 found 1602298
parent transid verify failed on 15645397942272 wanted 1602089 found 1602141
parent transid verify failed on 15645399678976 wanted 1602089 found 1602243
checksum verify failed on 15645399678976 wanted 0xf1e9450d found 0xe8cf0418
checksum verify failed on 15645399678976 wanted 0xf1e9450d found 0xe8cf0418
bad tree block 15645399678976, bad level, 236 > 8
ERROR: errors found in fs roots
found 0 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 0
total fs tree bytes: 0
total extent tree bytes: 0
btree space waste bytes: 0
file data blocks allocated: 0
 referenced 0
gargamel:/var/local/src/btrfs-progs-josefbacik#


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
