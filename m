Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F35475D2
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiFKOxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 10:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiFKOxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 10:53:12 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9176DF0F
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jun 2022 07:53:08 -0700 (PDT)
Received: from [172.58.35.216] (port=61451 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o01le-0003VR-00 by authid <merlins.org> with srv_auth_plain; Sat, 11 Jun 2022 07:53:01 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o02Tz-008xWk-1c; Sat, 11 Jun 2022 07:52:59 -0700
Date:   Sat, 11 Jun 2022 07:52:59 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Andrea Gelmini <andrea.gelmini@gmail.com>,
        Roman Mamedov <rm@romanrm.net>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220611145259.GF1664812@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611143033.56ffa6af@nvm>
 <20220611143033.56ffa6af@nvm>
 <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 172.58.35.216
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 11, 2022 at 09:27:57AM +0200, Andrea Gelmini wrote:
> Il giorno sab 11 giu 2022 alle ore 09:16 Marc MERLIN
> <marc@merlins.org> ha scritto:
> > As for bcache, I'm really thinking about droppping it, unless I'm told
> > it should be safe to use.
> 
> https://lwn.net/Articles/895266/

Mmmh, bcachefs, I was not aware of this new one. Not sure if I want to
add yet another layer, esepcially if it's new.

On Sat, Jun 11, 2022 at 02:30:33PM +0500, Roman Mamedov wrote:
> > 2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach 
> >    gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
> >    [writethrough] writeback writearound none
> 
> Maybe try LVM Cache this time?
 
Hard to know either way, trading one layer for another, and LVM has
always seemed heavier

> > 3) cryptsetup luksFormat --align-payload=2048 -s 256 -c aes-xts-plain64  /dev/bcache64
> > 4) cryptsetup luksOpen /dev/bcache64 dshelf1
> 
> What's the threat scenario for LUKS on the array?

In case my computer gets stolen, and indeed being able to recycle old
drives without having to worry, is a nice bonus.

> > 5) mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1
> 
> Personally I have switched from Btrfs on MD to individual disks and MergerFS.
 
That gives you no redundancy if a drive disk, correct?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
