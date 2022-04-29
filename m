Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435BC51516E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 19:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379449AbiD2RTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379100AbiD2RTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 13:19:43 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5FE8878E
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 10:16:24 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58314 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nkUE7-0008VW-EG by authid <merlins.org> with srv_auth_plain; Fri, 29 Apr 2022 10:16:22 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nkUE7-00ARO1-6V; Fri, 29 Apr 2022 10:16:19 -0700
Date:   Fri, 29 Apr 2022 10:16:19 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220429171619.GG12542@merlins.org>
References: <20220428222705.GX29107@merlins.org>
 <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
 <20220429005624.GY29107@merlins.org>
 <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
 <20220429013409.GD12542@merlins.org>
 <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
 <20220429040335.GE12542@merlins.org>
 <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
 <20220429151653.GF12542@merlins.org>
 <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
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

On Fri, Apr 29, 2022 at 11:27:54AM -0400, Josef Bacik wrote:
> > processed 999424 of 109035520 possible bytesWTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths
> > inode ref info failed???
> > elem_cnt 1 elem_missed 0 ret 0
> > misc/add0/new/tv1/ST/testfile.avi
> > Failed to find [10467695652864, 168, 8675328]
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x555565529a60, parent_transid=parent_transid@entry=1619139)
> >     at kernel-shared/disk-io.c:2235
> > 2235            ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
> >
> > We're making progress, thanks. Is there a way to add a BUG_ON instead of
> > the subsequent SEGV?
> 
> Yup done.  Also it's because I'm looking for the key in "dumping
> paths" higher up.  This one is weird because we only got one output,
> so for this one you want
> 
> -d "76300,108,0" -r 160494

Not sure how you got those numbers, but sure. I think it worked, but it
doesn't give any output saying so
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "76300,108,0" -r 160494 /dev/mapper/dshelf1
FS_INFO IS 0x5563243d9600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5563243d9600

not sure it worked:
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
processed 1179648 of 109035520 possible bytes
Recording extents for root 160496
processed 49152 of 49479680 possible bytes
Recording extents for root 161197
processed 81920 of 109019136 possible bytesWTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
misc/add0/new/tv1/ST/testfile.avi
Failed to find [10467695652864, 168, 8675328]

Program received signal SIGSEGV, Segmentation fault.
0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x5555611a6d20, parent_transid=parent_transid@entry=1619156)
    at kernel-shared/disk-io.c:2235
2235            ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
