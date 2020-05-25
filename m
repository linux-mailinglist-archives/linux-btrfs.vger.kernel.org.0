Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6A1E1521
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbgEYUQW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 16:16:22 -0400
Received: from magic.merlins.org ([209.81.13.136]:35636 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388994AbgEYUQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 16:16:22 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1jdJWH-0005Cn-0I by authid <merlin>; Mon, 25 May 2020 13:16:21 -0700
Date:   Mon, 25 May 2020 13:16:20 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <Damenly_Su@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: 5.5 kernel and btrfs-progs v5.6 create and cannot fix 'root
 204162 inode 14058737 errors 1000, some csum missing'
Message-ID: <20200525201620.GA19850@merlins.org>
References: <20200524213059.GI23519@merlins.org>
 <CAJCQCtTWkRijC51qny+gLqFO=z-Jek4mbKN0O6udLKzzeNe_vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtTWkRijC51qny+gLqFO=z-Jek4mbKN0O6udLKzzeNe_vw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 25, 2020 at 10:37:58AM -0600, Chris Murphy wrote:
> On Sun, May 24, 2020 at 3:31 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > My data is fine, it's double backed up and the filesystem is still mountable without issues.
> > But I had an error that broke btrfs send, and after fixing it with repair, I'm stuck with thses 'csum missing'
> 
> I'm not following the sequence of events. The send|receive failed? Did
> you try deleting the failed received snapshot?
 
btrfs send failed because there was an error on the source filesystem.
Then I found this in the logs
BTRFS error (device dm-0): did not find backref in send_root.  inode=14058737, offset=0, disk_byte=2694234112 found extent=2694234112

then I ran the btrfs check repair, with and without lowmem.
They fixed some things, but leave me 

> Is no-holes enabled on either file system?

Not intentionally. How do I check?

Either way, things happened, not exactly sure what, but I'm just trying
to find out if check --repair can/should do a better job, and if I can
give anything useful before wiping the filesystem and starting over.

As of right now, I have:
aruman:~# btrfs check /dev/mapper/cr
Opening filesystem to check...
Checking filesystem on /dev/mapper/cr
UUID: 4cb82363-e833-444e-b23e-1597a14a8aab
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
there is no free space entry for 24565465088-24565481472
there is no free space entry for 24565465088-24717033472
cache appears valid but isn't 23643291648
there is no free space entry for 45118177280-45118193664
there is no free space entry for 45118177280-46191869952
cache appears valid but isn't 45118128128
wanted offset 1659663106048, found 1659663089664
wanted offset 1659663106048, found 1659663089664
cache appears valid but isn't 1659663024128
[4/7] checking fs roots
root 356 inode 14058737 errors 1000, some csum missing
root 197362 inode 14058737 errors 1000, some csum missing
root 199551 inode 14058737 errors 1000, some csum missing
root 201742 inode 14058737 errors 1000, some csum missing
root 202370 inode 14058737 errors 1000, some csum missing
root 202683 inode 14058737 errors 1000, some csum missing
root 202999 inode 14058737 errors 1000, some csum missing
root 203332 inode 14058737 errors 1000, some csum missing
root 203669 inode 14058737 errors 1000, some csum missing
root 204006 inode 14058737 errors 1000, some csum missing
root 204010 inode 14058737 errors 1000, some csum missing
root 204024 inode 14058737 errors 1000, some csum missing
root 204037 inode 14058737 errors 1000, some csum missing
root 204049 inode 14058737 errors 1000, some csum missing
root 204063 inode 14058737 errors 1000, some csum missing
root 204077 inode 14058737 errors 1000, some csum missing
root 204091 inode 14058737 errors 1000, some csum missing
root 204105 inode 14058737 errors 1000, some csum missing
root 204119 inode 14058737 errors 1000, some csum missing
root 204133 inode 14058737 errors 1000, some csum missing
root 204146 inode 14058737 errors 1000, some csum missing
root 204147 inode 14058737 errors 1000, some csum missing
root 204159 inode 14058737 errors 1000, some csum missing
root 204160 inode 14058737 errors 1000, some csum missing
root 204161 inode 14058737 errors 1000, some csum missing
root 204162 inode 14058737 errors 1000, some csum missing
root 204163 inode 14058737 errors 1000, some csum missing
root 204164 inode 14058737 errors 1000, some csum missing
root 204165 inode 14058737 errors 1000, some csum missing
root 204166 inode 14058737 errors 1000, some csum missing
root 204167 inode 14058737 errors 1000, some csum missing
root 204168 inode 14058737 errors 1000, some csum missing
ERROR: errors found in fs roots
found 112391372800 bytes used, error(s) found
total csum bytes: 105763716
total tree bytes: 4036018176
total fs tree bytes: 3666313216
total extent tree bytes: 214728704
btree space waste bytes: 875571363
file data blocks allocated: 207903133696
 referenced 20

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
