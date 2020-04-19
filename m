Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5A1AFD4B
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Apr 2020 21:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDSTNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Apr 2020 15:13:09 -0400
Received: from magic.merlins.org ([209.81.13.136]:52952 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDSTNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Apr 2020 15:13:09 -0400
Received: from svh-gw.merlins.org ([173.11.111.145]:56478 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1jQFNI-0002wE-KS; Sun, 19 Apr 2020 12:13:04 -0700
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1jQFNI-0008NX-AX; Sun, 19 Apr 2020 12:13:04 -0700
Date:   Sun, 19 Apr 2020 12:13:04 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
Message-ID: <20200419191304.GR21716@merlins.org>
References: <20200321202307.GA15906@merlins.org>
 <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
 <20200325201455.GO29461@merlins.org>
 <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
 <20200326013007.GS15123@merlins.org>
 <0d2ea8e2-cbe8-ca64-d0d4-fa70b8cad8b1@oracle.com>
 <20200326042624.GT15123@merlins.org>
 <20200414003854.GA6639@merlins.org>
 <f85fccf5-eeb4-28ef-4dc4-500cf9221619@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f85fccf5-eeb4-28ef-4dc4-500cf9221619@oracle.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 06:43:39PM +0800, Anand Jain wrote:
> > BTRFS info (device sde1): forced readonly
> 
> Unfortunately that's the only thing we do as of now.
 
Of course, and that's fine, but I don't understand why after unmounting
the filesystem cleanly, the references aren't freed.
That part really seems like a bug to me.

> So the same device reappears as sdp. But btrfs does not close a failed
> device yet (patches are in the mailing list) the old path sde
> is still in the block layer and opened. I guess /proc/partitions
> doesn't show non working sde.
> 
Correct on all points

> > gargamel:~# mount | grep sde
> better to have grep-ed sdp also, here.

it was not mounted yet, I checked that.

> And /proc/self/mounts will be more accurate as it probes the fs module.

Noted.

> > [1887142.826176] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4531, flush 0, corrupt 0, gen 0
> > [1887453.610947] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdp1
> 
> Unmount wasn't successful above. Or it was remounted by automount? just
> guessing.

umount was successful and automount does not handle this device.
/dev/sde was not mounted for sure and /dev/sdp was unmountable 

> > gargamel:/usr/local/bin# btrfs device scan --forget
> > gargamel:/usr/local/bin# mount /dev/sdp1 /mnt/mnt
> > mount: /mnt/mnt: mount(2) system call failed: File exists.
> 
>  Can you please send a complete kernel logs.
 
They contain a lot of crap that wouldn't fit on the list, but I pasted
everything relevant.

>  sde disappears.
>  btrfs does not close the device.

it remounts the mountpoints read only, which is fine (they can't be
unmounted because they are in use).

>  block layer creates sdp when the disappeared device reappears.
>  unmount of sde was tried but it might not have completely successful we
> don't have sufficient logs to prove it.

umount looked complete on my side, there is nothing in the logs that
shows otherwise, but as you said, unmount does not log anything.

>  mount of sdp fails per log indicates that sde is still mounted.

correct.

> So thing(s) to fix is/are:
>  The root of the issue - When sde fails we need to close the device
>  so that block layer can reuse sde when it reappears (not sdp).
>  In btrfs as we have closed the failed device btrfs dev scan --forget
>  can work to cleanup the stale entries left behind during unmount.

ideally "btrfs dev scan --forget" should be automatic. It feels like
a weird command for an admin to know or have to use. Other filesystems
do not need it.

>  We can do something better here:
>  When two different device with same fsid uuid and devid and one of it
>  is mounted we have to fail the scan/mount of the newer device for
>  obvious reasons. That's when we get the log - 'duplicate device fsid'.
>  But here the case it bit skewed that both are same device with same
>  major number but different minor number (sde sdp). I need to figure
>  out a way so that we don't treat these two device paths as different
>  device. Probably should check the guid/wwid assigned by the block
>  layer which should be same for both of these devices, or in the
>  last resort check scsi inquiry_VPD page and get the serial number
>  but its going too much beyond what FS should do. Let me check with
>  block layer experts what they suggest.

defense in depth sounds great here, if any of those can work too, that'd
be great.

> Still unknown:
>  unmount is successful? And mount logs shows that device sde still exists in
> btrfs.
 
It failed while mountpoints were still it use, and after the correct
fuser -kvm /path
umount worked great and the device disappeared from /proc/mounts.
As you said, there are no kernel logs on unmount, so it's hard to say
more.
If you want me to apply a patch that puts more logging on unmount
(against 5.5 or 5.6), please let me know, but of course, it could be
weeks or months before I get that blip again.
I think this could be reproduced by simply having a drive mounted, and
unplugging it while the machine is live, and plugging it back in at
runtime. I could technically do it with my hardware, but it happens on a 
a database I don't really want to lose or corrupt.

> Sorry I was diverted into other stuffs when you reported last time, let me
> take a fresh look.

No worries, we've all been there :)
Also, it's not like I can get a refund on my support contract I don't have ;)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
