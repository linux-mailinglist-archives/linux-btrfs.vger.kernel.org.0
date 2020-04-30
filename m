Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE31BF9DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgD3Nq4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgD3Nq4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 09:46:56 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA915C035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 06:46:55 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1jU9Wf-0000TT-0H; Thu, 30 Apr 2020 14:46:53 +0100
Date:   Thu, 30 Apr 2020 14:46:52 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Nouts <nouts@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read
 block groups
Message-ID: <20200430134652.GA1623@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Nouts <nouts@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 11:41:11AM +0000, Nouts wrote:
> Hello again,
> I'm not familiar with mailing list. Should I expect an answer sooner or later ?

   Your original mail didn't get through to the list, as far as I can
see. I'd guess the attachment was too large, and the mail server
swallowed it.

   Hugo.

> As I need to get back on track as soon as possible, I would like to know if it's too complicated to get an answer quickly from you.
> I don't want to be rude, I just want to know if I should wait long enough for an answer that might save my day and my data. Or I'm doomed and I should have wipe my drive already ?
> 
> I'll take any answer :)
> Thank you
> 
> Nouts
> 
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Tuesday, April 28, 2020 11:26 AM, Nouts <nouts@protonmail.com> wrote:
> 
> > Hello,
> >
> > I am having issue with a RAID1 btrfs pool "failed to read block groups". I was advised to send information to this mailing list, as someone might be interested in debug logs and might also help solve my issue.
> >
> > I have a 3 drive RAID1 pool (2x3TB + 1x6TB), mounted as /home.
> >
> > My system became really slow while doing nothing, and after a reboot my /home pool can't mount.This is the error I got :
> >
> > [ 4645.402880] BTRFS info (device sdb): disk space caching is enabled
> > [ 4645.405687] BTRFS info (device sdb): has skinny extents
> > [ 4645.451484] BTRFS error (device sdb): failed to read block groups: -117
> > [ 4645.472062] BTRFS error (device sdb): open_ctree failed
> > mount: wrong fs type, bad option, bad superblock on /dev/sdb,missing codepage or helper program, or other error
> > In some cases useful info is found in syslog - trydmesg | tail or so.
> >
> > I attached you the smartctl result from the day before and the last scrub report I got from a month ago. From my understanding, it was ok.
> > I use hardlink (on the same partition/pool) and I deleted some data just the day before. I suspect my daily scrub routine triggered something that night and next day /home was gone.
> >
> > I can't scrub anymore as it's not mounted. Mounting with usebackuproot or degraded or ro produce the same error.
> > I tried "btrfs check /dev/sda" :
> > checking extents
> > leaf parent key incorrect 5909107507200
> > bad block 5909107507200
> > Errors found in extent allocation tree or chunk allocation
> > Checking filesystem on /dev/sda
> > UUID: 3720251f-ef92-4e21-bad0-eae1c97cff03
> >
> > Then "btrfs rescue super-recover /dev/sda" :
> > All supers are valid, no need to recover
> >
> > Then "btrfs rescue zero-log /dev/sda", which produced a weird stacktrace...
> > Unable to find block group for 0
> > extent-tree.c:289: find_search_start: Assertion '1' failed.
> > btrfs[0x43e418]
> > btrfs(btrfs_reserve_extent+0x5c9)[0x4425df]
> > btrfs(btrfs_alloc_free_block+0x63[0x44297c]
> > btrfs(__btrfs_cow_block+0xfc[0x436636]
> > btrfs(btrfs_cow_block+0x8b)[0x436bd8]
> > btrfs[0x43ad82]
> > btrfs(btrfs_commit_transaction+0xb8)[0x43c5dc]
> > btrfs[0x42c0d4]btrfs(main+0x12f)[0x40a341]/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf1)[0x7f1462d712e1]
> > btrfs(_start+0x2a)[0x40a37a]
> > Clearing log on /dev/sda, previous log_root 0, level 0
> >
> > Finally I tried "btrfs rescue chunk-recover /dev/sda", which run on all 3 drives at the same time during 8+ hours...
> > It asks to rebuild some metadata tree, which I accepted (I did not saved the full output sorry) and it ended with the same stacktrace as above.
> >
> > The only command left is "btrfs check --repair" but I afraid it might do more bad than good.
> >
> > I'm running Debian 9 (still, because of some dependencies). My kernel is already backported : 4.19.0-0.bpo.6-amd64 #1 SMP Debian 4.19.67-2+deb10u2~bpo9+1 (2019-11-12) x86_64 GNU/Linux
> > btrfs version : v4.7.3
> > I originally posted on reddit : https://www.reddit.com/r/btrfs/comments/g99v4v/nas_raid1_not_mounting_failed_to_read_block_groups/
> >
> > Let me know if you need more information.
> >
> > Nouts
> 
> 

-- 
Hugo Mills             | To an Englishman, 100 miles is a long way; to an
hugo@... carfax.org.uk | American, 100 years is a long time.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                        Earle Hitchner
