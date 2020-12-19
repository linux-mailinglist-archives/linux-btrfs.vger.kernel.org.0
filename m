Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A798D2DF210
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Dec 2020 00:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgLSXA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Dec 2020 18:00:29 -0500
Received: from smtp02.belwue.de ([129.143.71.87]:63726 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgLSXA3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Dec 2020 18:00:29 -0500
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 997884070
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Dec 2020 23:59:45 +0100 (MET)
Date:   Sat, 19 Dec 2020 23:59:45 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: how to extend a btrfs disk image?
Message-ID: <20201219225945.GA3591@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20201217123008.GA22831@tik.uni-stuttgart.de>
 <20201217191207.17243c40@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217191207.17243c40@natsu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 2020-12-17 (19:12), Roman Mamedov wrote:

> > root@fextest:/nfs/rusnas/fex# touch disk2.btrfs
> > root@fextest:/nfs/rusnas/fex# truncate -s 16TB disk2.btrfs
> > root@fextest:/nfs/rusnas/fex# btrfs device add /nfs/rusnas/fex/disk2.btrfs /mnt/tmp
> > ERROR: /nfs/rusnas/fex/disk2.btrfs is not a block device
> 
> Since file is not a block device, here you have to do the same manually. See
> documentation for 'losetup'.

Ok, I was able to extend the btrfs filesystem via a loopback devive.

What is the suggested way to do this at boot time?

For now I have in /etc/rc.local:

cd /nfs/rusnas/fex
for d in spool_[1-9].btrfs; do
  echo -n "$d ==> "
  losetup -fP --show $d
done
sync
sleep 2 # without this sleep the mount will fail!
mount -v spool_1.btrfs /mnt/spool

This works, but is there a more elegant way?
Using /etc/fstab seems not to be possible?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20201217191207.17243c40@natsu>
