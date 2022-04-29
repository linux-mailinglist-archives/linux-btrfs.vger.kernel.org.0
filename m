Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1939E51542C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380050AbiD2TCB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 15:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355618AbiD2TCA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 15:02:00 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6086D4C99
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:58:40 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nkVp9-00045e-US by authid <merlin>; Fri, 29 Apr 2022 11:58:39 -0700
Date:   Fri, 29 Apr 2022 11:58:39 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220429185839.GZ29107@merlins.org>
References: <20220429005624.GY29107@merlins.org>
 <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
 <20220429013409.GD12542@merlins.org>
 <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
 <20220429040335.GE12542@merlins.org>
 <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
 <20220429151653.GF12542@merlins.org>
 <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
 <20220429171619.GG12542@merlins.org>
 <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 01:52:13PM -0400, Josef Bacik wrote:
> It did, now we're on a different root, you can do
> 
> btrfs-corrupt-block -d "76300,108,0" -r 161197 <device>

So, it looks like this is going to be long manual process, I went through iterations and 
keep getting new roots. When I clear one, it goes to the next.
Any way to automate this?

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "76300,108,0" -r 161197 /dev/mapper/dshelf1
FS_INFO IS 0x55be3db38600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55be3db38600

Still breaking on the same file, 
(...)
Recording extents for root 162632 <-------------------------------------------------------------------------
processed 1523712 of 109314048 possible bytesWTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
misc/add0/new/tv1/ST/testfile.avi
Failed to find [10467695652864, 168, 8675328]

Program received signal SIGSEGV, Segmentation fault.
0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x555562149b30, parent_transid=parent_transid@entry=1619175)
    at kernel-shared/disk-io.c:2235
2235            ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "76300,108,0" -r 162632 /dev/mapper/dshelf1
FS_INFO IS 0x55a45a034600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55a45a034600


And then same thing again next round:
processed 49152 of 49479680 possible bytes
Recording extents for root 163302 <---------------------------------------------------------------------------
processed 32768 of 109314048 possible bytesWTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
misc/add0/new/tv1/ST/testfile.avi
Failed to find [10467695652864, 168, 8675328]

Program received signal SIGSEGV, Segmentation fault.
0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x55555fbab9e0, parent_transid=parent_transid@entry=1619197)
    at kernel-shared/disk-io.c:2235
2235            ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "76300,108,0" -r 163303 /dev/mapper/dshelf1
FS_INFO IS 0x564c9f705600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x564c9f705600

processed 81920 of 75792384 possible bytes
Recording extents for root 163316 <---------------------------------------------------------------------------
WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
misc/add0/new/tv1/ST/testfile.avi
Failed to find [10467695652864, 168, 8675328]

Program received signal SIGSEGV, Segmentation fault.
0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x5555608f4060, parent_transid=parent_transid@entry=1619222)
    at kernel-shared/disk-io.c:2235
2235            ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
