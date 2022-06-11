Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544CF547219
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 06:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347527AbiFKEva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 00:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiFKEvZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 00:51:25 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD7A1109
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 21:51:23 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nzt5k-00088q-Dq by authid <merlin>; Fri, 10 Jun 2022 21:51:20 -0700
Date:   Fri, 10 Jun 2022 21:51:20 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220611045120.GN22722@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,FAKE_REPLY_C,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

so, my apologies to all for the thread of death that is hopefully going
to be over soon. I still want to help Josef fix the tools though,
hopefully we'll get that filesystem back to a mountable state.

That said, it's been over 2 months now, and I do need to get this
filesystem back up from backup, so I ended up buying new drives (5x
11TiB in raid5).

Given the pretty massive corruption that happened in ways that I still 
can't explain, I'll make sure to turn off all the drive write caches
but I think I'm not sure I want to trust bcache anymore even though
I had it in writethrough mode.

Here's the Email from March, questions still apply:

Kernel will be 5.16. Filesystem will be 24TB and contain mostly bigger
files (100MB to 10GB).

1) mdadm --create /dev/md7 --level=5 --consistency-policy=ppl --raid-devices=5 /dev/sd[abdef]1 --chunk=256 --bitmap=internal
2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach 
   gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
   [writethrough] writeback writearound none
3) cryptsetup luksFormat --align-payload=2048 -s 256 -c aes-xts-plain64  /dev/bcache64
4) cryptsetup luksOpen /dev/bcache64 dshelf1
5) mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1

Any other btrfs options I should set for format to improve reliability
first and performance second?
I'm told I should use space_cache=v2, is it default now with btrfs-progs 5.10.1-2 ?

As for bcache, I'm really thinking about droppping it, unless I'm told
it should be safe to use.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
