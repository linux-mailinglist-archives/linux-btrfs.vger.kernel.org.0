Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA1D514043
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 03:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351529AbiD2Bh2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 21:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiD2Bh0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 21:37:26 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624CEBABB5
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 18:34:10 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58302 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nkFWL-0000n1-QI by authid <merlins.org> with srv_auth_plain; Thu, 28 Apr 2022 18:34:09 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nkFWL-008yRL-IW; Thu, 28 Apr 2022 18:34:09 -0700
Date:   Thu, 28 Apr 2022 18:34:09 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220429013409.GD12542@merlins.org>
References: <20220428202205.GT29107@merlins.org>
 <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
 <20220428205716.GU29107@merlins.org>
 <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
 <20220428214241.GW29107@merlins.org>
 <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
 <20220428222705.GX29107@merlins.org>
 <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
 <20220429005624.GY29107@merlins.org>
 <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 09:11:51PM -0400, Josef Bacik wrote:
> On Thu, Apr 28, 2022 at 8:56 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Thu, Apr 28, 2022 at 07:24:22PM -0400, Josef Bacik wrote:
> > > > inserting block group 15835070464000
> > > > inserting block group 15836144205824
> > > > inserting block group 15837217947648
> > > > inserting block group 15838291689472
> > > > inserting block group 15839365431296
> > > > inserting block group 15840439173120
> > > > inserting block group 15842586656768
> > > > processed 1556480 of 0 possible bytes
> > > > processed 49152 of 0 possible bytesadding a bytenr that overlaps our
> > > > thing, dumping paths for [4088, 108, 0]
> > >
> > > Oh huh, we must not have a free space object for this, in that case lets do
> > >
> > > ./btrfs-corrupt-block -d "4088,108,0" -r 2 /dev/whatever
> > >
> > > and then do the init.  Thanks,
> >
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "4088,108,0" -r 2 /dev/mapper/dshelf1
> > FS_INFO IS 0x558c0e536600
> > JOSEF: root 9
> > Couldn't find the last root for 8
> > FS_INFO AFTER IS 0x558c0e536600
> > Error searching to node -2
> >
> > not good news I assume?
> >
> 
> Just that I´m dumb and making silly mistakes, its -r 1, sorry about that,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "4088,108,0" -r 1 /dev/mapper/dshelf1
FS_INFO IS 0x557f68dd6600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x557f68dd6600

then init-extent-tree:
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
Ignoring transid failure
ERROR: root [11223 4061] level 0 does not match 2

ERROR: Error loading root
it failed?? -5
Init extent tree failed
[Inferior 1 (process 31788) exited with code 0373]

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
