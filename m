Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4154CB58
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354153AbiFOO3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 10:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348159AbiFOO3c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 10:29:32 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE4936300
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 07:29:30 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1o1U1R-0007LL-AQ by authid <merlin>; Wed, 15 Jun 2022 07:29:29 -0700
Date:   Wed, 15 Jun 2022 07:29:29 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220615142929.GP22722@merlins.org>
References: <20220608213845.GH22722@merlins.org>
 <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org>
 <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
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

On Mon, Jun 13, 2022 at 02:29:30PM -0400, Josef Bacik wrote:
> Alright so we have the missing csum things, which can be fixed with
> 
> btrfs rescue init-csum-tree <device>

Took a while, but it worked now, thanks.
 
(gdb) run rescue init-csum-tree /dev/mapper/dshelf1
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-csum-tree /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x555555652bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x555555652bc0
processed 21904289792 of 21907435520 possible data bytes, 99%doing close???
Init csum tree finished, you can run check now
> 
> After that you can mount the fs and run a scrub, because you have
> copies of metadata that are fucked, but copies that were ok, which is
> why I disabled the block error warnings since they were confusing me.
> Scrub should go along and fix all of that up.

gargamel:/mnt/mnt# btrfs scrub start -B .
running that now, I expect it will take a while.

> The next thing is to fix the fs errors, which I imagine will cause
> other problems like not being able to find directories and files and
> such.  Once we've gotten the csum tree and the scrub done we can
> tackle the remaining fs error problems which should be less terrifying
> to mess with.  Thanks,

would that be check --repair ?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
