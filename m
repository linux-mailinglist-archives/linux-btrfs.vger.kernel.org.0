Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F96A168B6B
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 02:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgBVBGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 20:06:44 -0500
Received: from magic.merlins.org ([209.81.13.136]:40532 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgBVBGo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 20:06:44 -0500
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1j5JFd-00018G-Ji by authid <merlin>; Fri, 21 Feb 2020 17:06:37 -0800
Date:   Fri, 21 Feb 2020 17:06:37 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, dsterba@suse.cz,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: btrfs filled up dm-thin and df%: shows 8.4TB of data used when
 I'm only using 10% of that.
Message-ID: <20200222010637.GB31491@merlins.org>
References: <2656316.bop9uDDU3N@merkaba>
 <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org>
 <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org>
 <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
 <3e94351d-6f32-1036-ab24-0dc1b843c969@toxicpanda.com>
 <20200222000142.GA31491@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222000142.GA31491@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 04:01:42PM -0800, Marc MERLIN wrote:
> [68099.512978] BTRFS info (device dm-13): the free space cache file (5151004819456) is invalid, skip it
> [68100.575692] BTRFS info (device dm-13): the free space cache file (5160668495872) is invalid, skip it
> [68100.689222] BTRFS info (device dm-13): the free space cache file (5161742237696) is invalid, skip it
> 
> I knew that filling up a btrfs filesystem was bad, but filling it the
> normal way makes it slow down enough that you usually know and fix it.
> Filling it by having an underlying dm-thin deny writes, is much worse (I expected
> it wouldn't be pretty though, which is why I had a cronjob to catch this before it
> happened, but I missed it due to the df bug).

It took a while, but it finished eventually. Seems that unmount tries
to fix a lot of stuff, which took a long time and only stopped once LVM
returned an error, which forced readonly and finally allowed unmount to
succeed.
[68696.784521] BTRFS info (device dm-13): the free space cache file (9260214779904) is invalid, skip it 
[68766.967084] BTRFS: error (device dm-13) in btrfs_commit_transaction:2279: errno=-5 IO failure (Error while writing out transaction) 
[68767.005592] BTRFS info (device dm-13): forced readonly 
[68767.022448] BTRFS warning (device dm-13): Skipping commit of aborted transaction. 
[68767.045741] BTRFS: error (device dm-13) in cleanup_transaction:1830: errno=-5 IO failure 
[68767.070945] BTRFS info (device dm-13): delayed_refs has NO entry

I guess I'm probably the few (or first?) person using btrfs with dm-thin with over subscription
and running out of space due to another bug.
Would it make sense to add some filesystem tests to see how btrfs behaves when it gets IO denied
errors by the underlying LVM? (which obviously doesn't happen on regular drives)?

mount read only is a better idea, I'll do that for now:
gargamel:/mnt/btrfs_pool2/backup/ubuntu# df -h .
Filesystem                Size  Used Avail Use% Mounted on
/dev/mapper/vgds2-ubuntu   14T  8.5T  5.6T  61% /mnt/btrfs_pool2/backup/ubuntu

df is showing a value consistent with btrfs fi df, but of course, not the correct value
since I'm only using a 10th of that data. 

You asked for a check, it's running but may take a while:
gargamel:~# btrfs check /dev/mapper/vgds2-ubuntu
Checking filesystem on /dev/mapper/vgds2-ubuntu
UUID: 905c90db-8081-4071-9c79-57328b8ac0d5
checking extents
checking free space cache
checking fs roots
checking only csum items (without verifying data)

I'll paste the completion when it's done.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
