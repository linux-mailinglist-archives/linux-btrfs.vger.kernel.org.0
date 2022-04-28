Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB68513C98
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 22:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351767AbiD1UZX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiD1UZX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 16:25:23 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C861A94F9
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:22:06 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nkAeL-0006yd-Ex by authid <merlin>; Thu, 28 Apr 2022 13:22:05 -0700
Date:   Thu, 28 Apr 2022 13:22:05 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220428202205.GT29107@merlins.org>
References: <20220428001822.GZ12542@merlins.org>
 <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
 <20220428030002.GB12542@merlins.org>
 <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
 <20220428031131.GO29107@merlins.org>
 <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
 <20220428041245.GP29107@merlins.org>
 <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
 <20220428162746.GR29107@merlins.org>
 <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 04:13:31PM -0400, Josef Bacik wrote:
> On Thu, Apr 28, 2022 at 12:27 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Thu, Apr 28, 2022 at 11:30:35AM -0400, Josef Bacik wrote:
> > > Hell yes we're in the fs tree's now, in the home stretch hopefully.
> > > I've pushed new debugging, you may have another overlapping extent.
> > > I'm going to have to wire up a tool for that, but hopefully we can
> > > just target delete a few things and get you up and running.  Thanks,
> >
> > Delete Xilinx_Unified_2020.1_0602_1208/tps/lnx64/jre9.0.4/lib/modules ?
> 
> Cool, do
> 
> ./btrfs-corrupt-block -d "3700677820416,168,53248" -r 11223 <device>
> 
> Then you should be able to run the init-extent-tree and get past that
> part.  Thanks,

Sorry, I must be triggering every single unhandled path in the code :)

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "3700677820416,168,53248" -r 11223 /dev/mapper/dshelf1
FS_INFO IS 0x55fd6e82d600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55fd6e82d600
kernel-shared/ctree.c:365: update_ref_for_cow: BUG_ON `ret` triggered, value -5
./btrfs-corrupt-block(+0x1137d)[0x55fd6d53237d]
./btrfs-corrupt-block(__btrfs_cow_block+0x3a9)[0x55fd6d533a90]
./btrfs-corrupt-block(btrfs_cow_block+0x73)[0x55fd6d53414f]
./btrfs-corrupt-block(btrfs_search_slot+0x11a)[0x55fd6d536b51]
./btrfs-corrupt-block(main+0x141d)[0x55fd6d56f4a9]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f526bee17fd]
./btrfs-corrupt-block(_start+0x2a)[0x55fd6d52d8ba]
Aborted

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
