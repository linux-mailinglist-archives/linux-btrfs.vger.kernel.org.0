Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5BC2DF508
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Dec 2020 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgLTKgT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Dec 2020 05:36:19 -0500
Received: from smtp02.belwue.de ([129.143.71.87]:38584 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgLTKgQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Dec 2020 05:36:16 -0500
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 02DBE498C
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Dec 2020 11:35:33 +0100 (MET)
Date:   Sun, 20 Dec 2020 11:35:32 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: how to extend a btrfs disk image?
Message-ID: <20201220103532.GA31610@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20201217123008.GA22831@tik.uni-stuttgart.de>
 <20201217191207.17243c40@natsu>
 <20201219225945.GA3591@tik.uni-stuttgart.de>
 <20201220142252.01cf4140@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220142252.01cf4140@natsu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun 2020-12-20 (14:22), Roman Mamedov wrote:

> > For now I have in /etc/rc.local:
> > 
> > cd /nfs/rusnas/fex
> > for d in spool_[1-9].btrfs; do
> >   echo -n "$d ==> "
> >   losetup -fP --show $d
> > done
> > sync
> > sleep 2 # without this sleep the mount will fail!
> 
> You could try replacing the sleep with "btrfs device scan", certainly more
> elegant (assuming it helps). Maybe even narrow it down to
> "btrfs device scan /dev/loop*", or even scan each added device.

Indeed better!


> > mount -v spool_1.btrfs /mnt/spool
> 
> Better mount one of the loop devices, not the file, lest mount will probably
> make one more, a dupe of one that your script has already added, and who knows
> what side effects this could have.

Ok, now I use:

ldev=$(losetup -l | awk '/spool_1.btrfs/{print $1;exit}')
mount -v $ldev /mnt/spool

This is all necessary because our Netapp storage system has an annoying 
16 TB file size limit. This was ok for the last century, but for today it
is an anachronism.


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20201220142252.01cf4140@natsu>
