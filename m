Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB8D393F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfJKGPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 02:15:48 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:50563 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfJKGPs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 02:15:48 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id D6D12AD51
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 08:15:44 +0200 (MEST)
Date:   Fri, 11 Oct 2019 08:15:44 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: rsync -ax and subvolumes
Message-ID: <20191011061544.GB3648@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20191010172011.GA3392@tik.uni-stuttgart.de>
 <CAMthOuMV7MgB4b87RsijYr9e0UsjMUDNk+QRXeauFdb3cZcTjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMthOuMV7MgB4b87RsijYr9e0UsjMUDNk+QRXeauFdb3cZcTjw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 2019-10-10 (20:47), Kai Krakow wrote:

> Actually, you could also just bind-mount into /mnt/btrfs, bind-mounts
> won't inherit other mounts but will still see pure subvolumes.

Next problem:

root@ptm1:~# sysinfo 
System:        Linux ptm1 4.4.180-94.100-default x86_64
Distribution:  SUSE Linux Enterprise Server 12 SP3

root@ptm1:~# mount | grep sda
/dev/sda2 on / type btrfs (rw,relatime,space_cache,subvolid=453,subvol=/@/.snapshots/128/snapshot)
/dev/sda2 on /.snapshots type btrfs (rw,relatime,space_cache,subvolid=270,subvol=/@/.snapshots)
/dev/sda2 on /opt type btrfs (rw,relatime,space_cache,subvolid=259,subvol=/@/opt)
/dev/sda2 on /var/log type btrfs (rw,relatime,space_cache,subvolid=264,subvol=/@/var/log)
/dev/sda2 on /srv type btrfs (rw,relatime,space_cache,subvolid=260,subvol=/@/srv)
/dev/sda2 on /var/tmp type btrfs (rw,relatime,space_cache,subvolid=267,subvol=/@/var/tmp)
/dev/sda2 on /var/spool type btrfs (rw,relatime,space_cache,subvolid=266,subvol=/@/var/spool)
/dev/sda2 on /usr/local type btrfs (rw,relatime,space_cache,subvolid=262,subvol=/@/usr/local)
/dev/sda2 on /var/opt type btrfs (rw,relatime,space_cache,subvolid=265,subvol=/@/var/opt)
/dev/sda2 on /home type btrfs (rw,relatime,space_cache,subvolid=258,subvol=/@/home)
/dev/sda2 on /var/lib/machines type btrfs (rw,relatime,space_cache,subvolid=1235,subvol=/@/var/lib/machines)
/dev/sda2 on /tmp type btrfs (rw,relatime,space_cache,subvolid=261,subvol=/@/tmp)
/dev/sda2 on /var/crash type btrfs (rw,relatime,space_cache,subvolid=263,subvol=/@/var/crash)

root@ptm1:~# mount -o bind / /mnt/tmp

root@ptm1:~# find /opt | wc -l
564

root@ptm1:~# find /mnt/tmp/opt | wc -l
1


I want to copy everything from /dev/sda2 with rsync, but not from other devices.

rsynv -avH  / /mnt/usb # copies also /proc /dev etc
rsynv -avHx / /mnt/usb # copies ONLY / but not /opt /var/log etc

And yes, it must be rsync, because I run this command often, for syncing.

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<CAMthOuMV7MgB4b87RsijYr9e0UsjMUDNk+QRXeauFdb3cZcTjw@mail.gmail.com>
