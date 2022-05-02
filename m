Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0ED517AF3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 01:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiEBXq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiEBXp3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 19:45:29 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87833895
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 16:41:42 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nlffb-0000dq-Ay by authid <merlin>; Mon, 02 May 2022 16:41:35 -0700
Date:   Mon, 2 May 2022 16:41:35 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220502234135.GC29107@merlins.org>
References: <20220501152231.GM12542@merlins.org>
 <CAEzrpqeiWrW6NbWLmUiWwE96sVNb+H0bEXmaij1K-HJQ38vL7w@mail.gmail.com>
 <20220502012528.GA29107@merlins.org>
 <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
 <20220502173459.GP12542@merlins.org>
 <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
 <20220502200848.GR12542@merlins.org>
 <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
 <20220502214916.GB29107@merlins.org>
 <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
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

On Mon, May 02, 2022 at 04:16:14PM -0700, Josef Bacik wrote:
> On Mon, May 2, 2022 at 2:49 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Mon, May 02, 2022 at 05:03:40PM -0400, Josef Bacik wrote:
> > > Ok I've fixed it to yell about what file has this weird extent so you
> > > can delete it and we can carry on.  Thanks,
> >
> > That worked.  How do I delete this one?
> >
> > doing roots
> > Recording extents for root 4
> > processed 1032192 of 1064960 possible bytes
> > Recording extents for root 5
> > processed 10960896 of 10977280 possible bytes
> > Recording extents for root 7
> > processed 16384 of 16545742848 possible bytes
> > Recording extents for root 9
> > processed 16384 of 16384 possible bytes
> > Recording extents for root 11221
> > processed 16384 of 255983616 possible bytes
> > Recording extents for root 11222
> > processed 49479680 of 49479680 possible bytes
> > Recording extents for root 11223
> > processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819130,108,0 on root 11223
> 
> btrfs-corrupt-block -d "1819130,108,0" -r 11223 <device>

Whoops, it was right there in the text, sorry

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819130,108,0" -r 11223 /dev/mapper/dshelf1
FS_INFO IS 0x564360382600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x564360382600


Didn't help?
doing roots
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
processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819131,108,0 on root 11223
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0026_2020.1_0602_1208.xz
cmds/rescue-init-extent-tree.c:654: process_eb: BUG_ON `1` triggered, value 1

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
