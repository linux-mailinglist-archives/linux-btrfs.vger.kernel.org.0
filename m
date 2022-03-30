Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355EC4EC6C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbiC3Old (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 10:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiC3Old (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 10:41:33 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EDC5372F
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 07:39:47 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nZZU8-0006fa-AB by authid <merlin>; Wed, 30 Mar 2022 07:39:44 -0700
Date:   Wed, 30 Mar 2022 07:39:44 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Su Yue <Damenly_Su@gmx.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption: parent transid
 verify failed + open_ctree failed
Message-ID: <20220330143944.GE14158@merlins.org>
References: <20220329171818.GD1314726@merlins.org>
 <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
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

On Wed, Mar 30, 2022 at 08:38:19AM +0300, Andrei Borzenkov wrote:
> On 29.03.2022 20:18, Marc MERLIN wrote:
> > Howdy,
> > 
> > This is the followup I was hoping I'd never have to send.
> > 
> > kernel was 5.7 (long uptime, just upgraded to 5.16).
> > 
> > One raid5 drive failed, and as I was replacing it, another one went
> > offline, but not in a way that the md5 array was taken down.
> > I shut the the system down, replaced the bad drive, the 2nd drive that
> > went down wasn't really down, so I broght back the array with a drive
> > missing.
> 
> Sorry, which drive? You had one drive that failed and another drive that
> went offline. Which drive you replaced? Which drive is missing now? The
 
The drive that failed entirely is the one I removed since clearly I
couldn't bring the array back up with it.
The one that went offline during shutdown was working again after
reboot, so I brought the array back with one drive missing as shown
below (4 out of 5)

> third one? The one that failed? The one that went offline?

> > mdadm --assemble --run --force /dev/md7 /dev/sd[gijk]1
> > cryptsetup luksOpen /dev/bcache3 dshelf1a
> > btrfs device scan --all-devices
> > mount /dev/mapper/dshelf1a /mnt/btrfs_pool1/
> > 
> > BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > BTRFS error (device dm-17): failed to read chunk tree: -5
> > BTRFS error (device dm-17): open_ctree failed

But clearly the drive that went offline during shutdown, must have
caused some corruption, even if it all it did was just refuse all
writes.
That said, I was somehow hoping that btrfs could unwind the last writes
that failed/were incomplete and get back to a proper state. I'm still
saddened by how fragile btrfs seems compared to ext4 in those cases
(I've had similar issues happen with ext4 in the past, and was always
able to repair the filesystem even if I lost a few files in the process)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
