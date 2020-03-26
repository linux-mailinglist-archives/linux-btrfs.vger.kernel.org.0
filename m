Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6ABD193749
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 05:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgCZE03 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 00:26:29 -0400
Received: from magic.merlins.org ([209.81.13.136]:41086 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgCZE03 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 00:26:29 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1jHK64-0003eN-C7 by authid <merlin>; Wed, 25 Mar 2020 21:26:24 -0700
Date:   Wed, 25 Mar 2020 21:26:24 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
Message-ID: <20200326042624.GT15123@merlins.org>
References: <20200321202307.GA15906@merlins.org>
 <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
 <20200325201455.GO29461@merlins.org>
 <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
 <20200326013007.GS15123@merlins.org>
 <0d2ea8e2-cbe8-ca64-d0d4-fa70b8cad8b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d2ea8e2-cbe8-ca64-d0d4-fa70b8cad8b1@oracle.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 11:33:23AM +0800, Anand Jain wrote:
>  We would log the below only if the old device sde is still in mounted
>  state.  Unfortunately we don't have the unmount event log yet (patches
>  are in the ML) so we don't know if unmount was successful.
> 
> [2560416.434529] BTRFS warning (device sde1): duplicate device fsid:devid
> for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdq1
> 
>  If the device is unmounted, the scan would have replaced the sde
>  to sdi, unless the sde (stale) generation is > generation in sdi
>  (lost commit). In which case the --forget is useful to remove the
>  state device entry (provided device is unmounted).
 
Well, the device did disappear, wouldn't that cause the in memory
version to be more recent than the disk version?

>  Its strange /proc/mounts doesn't list sde. Could you please send me
>  complete kernel logs. Lets try if there is any clue.
 
Sure https://pastebin.com/SWAfYxV8
 
>  I tried to reproduce.. but in my case the unmount was successful.
> 
> 
> $ mkfs.btrfs -fq /dev/sdc && mount /dev/sdc /btrfs
> $ devmgt show | grep sdc
> host2 sdc
> $ devmgt detach /dev/sdc
> ::
> detach /dev/sdc successful
> $ devmgt attach host2

That's probably too clean.
Can you 
1) write to device in a loop
2) pull power from SATA device (in this case it was an ssd)
3) plug device back in

> $ umount /dev/sdc
> 
> Unfortunately there is no log about the unmount :-(.

Maybe worth adding to help debug later?

I looked in my bash history, and it shows this:
37280  mount | grep sde
37281  umount /mnt/btrfs_space
37282  umount /var/local/space
37283  umount /var/cache/zoneminder
37284  fuser -vm /var/cache/zoneminder
37285  fuser -vkm /var/cache/zoneminder
37286  umount /var/cache/zoneminder
37287  umount /var/lib/mysql
37288  mount | grep sde1

First time, I got output to the mount command.
Second time I did not.

other commands I typed:
37289  mount /dev/sdq1 /mnt/btrfs_space
37296  btrfs device scan
37301  grep sde /etc/* 2>/dev/null
37303  mount /dev/sdq1 /mnt/btrfs_space
37308  grep -r /mnt/btrfs_space /etc 2>/dev/null
37311  btrfs device scan 
37312  l /sys/block/sde/
37313  btrfs check /dev/sdq1
37314  btrfs device scan 
37320  mount /dev/sdq1 /mnt/mnt
37323  btrfs device scan
37324  dmesg |tail -1
37326  lsblk -v
37327  lsblk 
37328  grep sde /proc/mounts 

Hope this helps.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
