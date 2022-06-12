Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686EE547B31
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jun 2022 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiFLRbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jun 2022 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiFLRbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jun 2022 13:31:37 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A345DA65
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 10:31:36 -0700 (PDT)
Received: from [172.58.16.183] (port=26001 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o0QiV-0006wB-Qc by authid <merlins.org> with srv_auth_plain; Sun, 12 Jun 2022 10:31:27 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o0RQq-00AUlS-AE; Sun, 12 Jun 2022 10:31:24 -0700
Date:   Sun, 12 Jun 2022 10:31:24 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Andrea Gelmini <andrea.gelmini@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220612173124.GJ1664812@merlins.org>
References: <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
 <20220611145259.GF1664812@merlins.org>
 <20220611225416.25c8a8d6@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611225416.25c8a8d6@nvm>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 172.58.16.183
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 11, 2022 at 10:54:16PM +0500, Roman Mamedov wrote:
> On Sat, 11 Jun 2022 07:52:59 -0700
> Marc MERLIN <marc@merlins.org> wrote:
> 
> > 1) mdadm --create /dev/md7 --level=5 --consistency-policy=ppl
> > --raid-devices=5 /dev/sd[abdef]1 --chunk=256 --bitmap=internal
> 
> One more thing I wanted to mention, did you have PPL on your previous array?
> Or it was not implemented yet back then? I know it is supposed to protect
> against the write hole, which could have caused your previous FS corruption.
 
Looks like I had internal bitmap instead
gargamel:~# mdadm --query --detail  /dev/md7
/dev/md7:
           Version : 1.2
     Creation Time : Sun Feb 11 20:38:30 2018
        Raid Level : raid5
        Array Size : 23441561600 (22355.62 GiB 24004.16 GB)
     Used Dev Size : 5860390400 (5588.90 GiB 6001.04 GB)
      Raid Devices : 5
     Total Devices : 5
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Fri Jun 10 12:09:08 2022
             State : clean 
    Active Devices : 5
   Working Devices : 5
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

I'll switch PPL instead, thanks for that. Actually I need to migrate
my other raid5 arrays to that too. It looks like it can be done at runtime.

> Yes, but in MergerFS each file is stored entirely within a single disk,
> there's no striping. So only files which happened to be on the failed disk are
> lost and need to be restored from backups. For this it helps to keep track of
> what was where, with something like "find /mnt/ > `date`.lst" in crontab.

Right, I figured. It's not bad, but I do want no data loss if I lose a
drive, so I'll take raid5.
I realize that filesystem aware raid5, like the raid5 in btrfs which I'm
not sure I can really trust, still? , could lay out the files to be one per disk
without striping.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
