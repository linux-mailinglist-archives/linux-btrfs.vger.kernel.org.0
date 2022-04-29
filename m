Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD39E514F07
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377803AbiD2PUO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378250AbiD2PUN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 11:20:13 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B8260A95
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 08:16:54 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58312 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nkSMX-0007Jy-Vy by authid <merlins.org> with srv_auth_plain; Fri, 29 Apr 2022 08:16:53 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nkSMX-00AEkI-Pg; Fri, 29 Apr 2022 08:16:53 -0700
Date:   Fri, 29 Apr 2022 08:16:53 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220429151653.GF12542@merlins.org>
References: <20220428214241.GW29107@merlins.org>
 <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
 <20220428222705.GX29107@merlins.org>
 <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
 <20220429005624.GY29107@merlins.org>
 <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
 <20220429013409.GD12542@merlins.org>
 <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
 <20220429040335.GE12542@merlins.org>
 <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 08:41:00AM -0400, Josef Bacik wrote:
> Yayyyy progress, I just updated the debugging for the new problem
> bytenr so we can figure out who to delete, run init-extent-tree again
> please.  Thanks,

sure:
inserting block group 15837217947648
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
processed 1556480 of 0 possible bytes
processed 1474560 of 0 possible bytes
Recording extents for root 4
processed 1032192 of 1064960 possible bytes
Recording extents for root 5
processed 10960896 of 10977280 possible bytes
Recording extents for root 7
processed 16384 of 16545742848 possible bytes
Recording extents for root 9
processed 16384 of 16384 possible bytes
Recording extents for root 11221
processed 16384 of 255983616 possible bytes
Recording extents for root 11222
processed 49479680 of 49479680 possible bytes
Recording extents for root 11223
processed 1635319808 of 1635549184 possible bytes
Recording extents for root 11224
processed 75792384 of 75792384 possible bytes
Recording extents for root 159785
processed 108855296 of 108855296 possible bytes
Recording extents for root 159787
processed 49152 of 49479680 possible bytes
Recording extents for root 160494
processed 999424 of 109035520 possible bytesWTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
misc/add0/new/tv1/ST/testfile.avi
Failed to find [10467695652864, 168, 8675328]

Program received signal SIGSEGV, Segmentation fault.
0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x555565529a60, parent_transid=parent_transid@entry=1619139)
    at kernel-shared/disk-io.c:2235
2235            ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,

We're making progress, thanks. Is there a way to add a BUG_ON instead of
the subsequent SEGV?

I'm also not too sure, how to you convert  [10467695652864, 168, 8675328]
into something like
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "4088,108,0" -r 1 /dev/mapper/dshelf1

It seems like the straight numbers don't work:
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "10467695652864,168,8675328" -r 1 /dev/mapper/dshelf1
FS_INFO IS 0x55e92004b600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55e92004b600
Error searching to node -2

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
