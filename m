Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE44F1EC8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 00:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347639AbiDDVzk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386775AbiDDVjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 17:39:22 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869174133C
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 14:30:40 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbUGl-0004Zx-TY by authid <merlin>; Mon, 04 Apr 2022 14:29:51 -0700
Date:   Mon, 4 Apr 2022 14:29:51 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220404212951.GG14158@merlins.org>
References: <20220404150858.GS1314726@merlins.org>
 <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
 <20220404174357.GT1314726@merlins.org>
 <CAEzrpqc7P7pxkdSw8eS-nCkn1h5ztQC7C=MewJdmT6Mr5OJX-A@mail.gmail.com>
 <20220404181055.GW1314726@merlins.org>
 <CAEzrpqfA94nYjV=o_4+XRitopVT-3j7iQMaXAr3FE3Rfm32gkA@mail.gmail.com>
 <20220404190403.GY1314726@merlins.org>
 <CAEzrpqeMPQvtoov=7Lv5Kx8-cgOmRFFYLbuh0QxZ6psQN3RDeA@mail.gmail.com>
 <20220404203333.GZ1314726@merlins.org>
 <CAEzrpqdmKwdZxzu7EBhp-PgZW+vqNaUm51SRrKAe64N3pN2rnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdmKwdZxzu7EBhp-PgZW+vqNaUm51SRrKAe64N3pN2rnw@mail.gmail.com>
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

On Mon, Apr 04, 2022 at 05:04:52PM -0400, Josef Bacik wrote:
> On Mon, Apr 4, 2022 at 4:33 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Mon, Apr 04, 2022 at 03:52:15PM -0400, Josef Bacik wrote:
> > > Can you build a recent btrfs-progs from git?  We chucked that error
> > > apparently and I can't figure out where it's complaining.  Thanks,
> >
> > Sure, here's git master
> >
> 
> Alright we've entered the "Josef throws code at the problem" portion
> of the event.
 
thanks :)

> git clone https://github.com/josefbacik/btrfs-progs.git
> git checkout for-marc
> <build>
> re-run fsck
> 
> I wonder if the tree root is fucked and that's why it's not finding
> the device tree.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# git remote -v
origin	https://github.com/josefbacik/btrfs-progs.git (fetch)
origin	https://github.com/josefbacik/btrfs-progs.git (push)
gargamel:/var/local/src/btrfs-progs-josefbacik# git branch
* for-marc
  master
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs --version
btrfs-progs v5.16.2 
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --init-extent-tree  /dev/mapper/dshelf1a
WARNING:

	Do not use --repair unless you are advised to do so by a developer
	or an experienced user, and then only after having accepted that no
	fsck can successfully repair all types of filesystem corruption. Eg.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
Couldn't find the last root for 4
Couldn't setup device tree
ERROR: cannot open file system

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
