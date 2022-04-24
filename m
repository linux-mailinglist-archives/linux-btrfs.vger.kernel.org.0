Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6754650D52E
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 22:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiDXU57 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiDXU56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 16:57:58 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2255481
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 13:54:54 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nijFu-0008HJ-8Y by authid <merlin>; Sun, 24 Apr 2022 13:54:54 -0700
Date:   Sun, 24 Apr 2022 13:54:54 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220424205454.GB29107@merlins.org>
References: <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
 <CAEzrpqdHAS2E1iuoSFVX-A-T-vsMoCo6CoW0ebw42vkCjqpMPw@mail.gmail.com>
 <20220424162450.GY11868@merlins.org>
 <CAEzrpqe6gwpF9k=Gj4=aCzkj-kW5GrZNueNnfoL8ZAAnMvwbng@mail.gmail.com>
 <20220424184341.GA1523521@merlins.org>
 <CAEzrpqeUJwtkMAUaxEd-qARe1aEZBx-v1-G_WY7vPr5MNL+3TQ@mail.gmail.com>
 <20220424194444.GA12542@merlins.org>
 <CAEzrpqeY_BAMLdL7NQmtC7ROBkZLrx=FHr=JC4KHoPF6Kwn3Kg@mail.gmail.com>
 <20220424203133.GA29107@merlins.org>
 <CAEzrpqemyJ8PS5-eF3iSKugy6u3UAzkwwM=o+bHPOh2_7aPHFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqemyJ8PS5-eF3iSKugy6u3UAzkwwM=o+bHPOh2_7aPHFA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 04:32:23PM -0400, Josef Bacik wrote:
> On Sun, Apr 24, 2022 at 4:31 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, Apr 24, 2022 at 04:01:34PM -0400, Josef Bacik wrote:
> > > > (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> > > > Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> > > > [Thread debugging using libthread_db enabled]
> > > > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> > > > FS_INFO IS 0x55555564cbc0
> > > > JOSEF: root 9
> > >
> > > Huh ok, it's the UUID tree, weird.  I pushed, can you re-run
> > > tree-recover, you can stop it after it does root 9, I just want to see
> > > what bytenr it thinks the root node is at.  Thanks,
> >
> > (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> > Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> 
> Sorry, I need tree-recover, not init-extent-tree.  Thanks,

gdb) run rescue tree-recover /dev/mapper/dshelf1
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue
tree-recover /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library
"/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x55555564cbc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55555564cbc0
Checking root 2 bytenr 67387392
Checking root 4 bytenr 15645196861440
Checking root 5 bytenr 13577660252160
Checking root 7 bytenr 13577819963392
Checking root 9 bytenr 15645878108160
Checking root 11221 bytenr 13577562996736
Checking root 11222 bytenr 15645261905920
Checking root 11223 bytenr 13576862547968
Checking root 11224 bytenr 13577126182912
Checking root 159785 bytenr 6781490577408
Checking root 159787 bytenr 15645908385792
Checking root 160494 bytenr 6781491265536
Checking root 160496 bytenr 11822309965824
Checking root 161197 bytenr 6781492101120
Checking root 161199 bytenr 13576850833408
Checking root 162628 bytenr 15645764812800
Checking root 162632 bytenr 6781492756480
Checking root 162645 bytenr 5809981095936
Checking root 163298 bytenr 15645124263936
Checking root 163302 bytenr 6781495197696
Checking root 163303 bytenr 15645365993472
Checking root 163316 bytenr 6781496393728
Checking root 163318 bytenr 15645980491776
Checking root 163916 bytenr 11822437826560
Checking root 163920 bytenr 11971021275136
Checking root 163921 bytenr 11971073802240
Checking root 164620 bytenr 15645434036224
Checking root 164624 bytenr 15645502210048
Checking root 164633 bytenr 15645526884352
Checking root 165098 bytenr 11970667446272
Checking root 165100 bytenr 11970733621248
Checking root 165198 bytenr 12511656394752
Checking root 165200 bytenr 12511677972480
Checking root 165294 bytenr 13576901328896
Checking root 165298 bytenr 13577133326336
Checking root 165299 bytenr 13577191505920
Checking root 18446744073709551607 bytenr 13576823685120
Tree recovery finished, you can run check now
[Inferior 1 (process 6147) exited normally]
(gdb) 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
