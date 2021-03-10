Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68C33423E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 16:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhCJPzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 10:55:50 -0500
Received: from smtp02.belwue.de ([129.143.71.87]:33228 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232347AbhCJPzo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 10:55:44 -0500
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id AF7B08A35
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 16:55:38 +0100 (MET)
Date:   Wed, 10 Mar 2021 16:55:38 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: nfs subvolume access?
Message-ID: <20210310155538.GA4408@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210310075957.GG22502@savella.carfax.org.uk>
 <20210310080940.GB2158@tik.uni-stuttgart.de>
 <5bded122-8adf-e5e7-dceb-37a3875f1a4b@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bded122-8adf-e5e7-dceb-37a3875f1a4b@cobb.uk.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed 2021-03-10 (09:35), Graham Cobb wrote:

> >>> root@tsmsrvj:~# find /data/fex | wc -l
> >>> 489887
> > 
> >>    I can't remember if this is why, but I've had to put a distinct
> >> fsid field in each separate subvolume being exported:
> >>
> >> /srv/nfs/home     -rw,async,fsid=0x1730,no_subtree_check,no_root_squash
> > 
> > I must export EACH subvolume?!
> 
> I have had similar problems. I *think* the current case is that modern
> NFS, using NFS V4, can cope with the whole disk being accessible without
> giving each subvolume its own FSID (which I have stopped doing).

I cannot use NFS4 (for several reasons). I must use NFS3


> > The snapshots are generated automatically (via cron)!
> > I cannot add them to /etc/exports
> 
> Well, you could write some scripts... but I don't think it is necessary.
> I *think* it is only necessary if you want `find` to be able to cross
> between subvolumes on the NFS mounted disks.

It is not only a find problem:

root@fex:/nfs/tsmsrvj/fex# ls -R
:
spool
ls: ./spool: not listing already-listed directory


And as I wrote: there is no such problem with Ubuntu 18.04!
So, is it a btrfs or a nfs bug?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<5bded122-8adf-e5e7-dceb-37a3875f1a4b@cobb.uk.net>
