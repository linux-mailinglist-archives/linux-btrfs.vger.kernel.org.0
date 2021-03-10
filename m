Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9920333701
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 09:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCJIKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 03:10:06 -0500
Received: from smtp01.belwue.de ([129.143.71.86]:34704 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhCJIJl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 03:09:41 -0500
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 48AF466C1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:09:40 +0100 (MET)
Date:   Wed, 10 Mar 2021 09:09:40 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: nfs subvolume access?
Message-ID: <20210310080940.GB2158@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210310075957.GG22502@savella.carfax.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310075957.GG22502@savella.carfax.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed 2021-03-10 (07:59), Hugo Mills wrote:

> > On tsmsrvj I have in /etc/exports:
> > 
> > /data/fex       tsmsrvi(rw,async,no_subtree_check,no_root_squash)
> > 
> > This is a btrfs subvolume with snapshots:
> > 
> > root@tsmsrvj:~# btrfs subvolume list /data
> > ID 257 gen 35 top level 5 path fex
> > ID 270 gen 36 top level 257 path fex/spool
> > ID 271 gen 21 top level 270 path fex/spool/.snapshot/2021-03-07_1453.test
> > ID 272 gen 23 top level 270 path fex/spool/.snapshot/2021-03-07_1531.test
> > ID 273 gen 25 top level 270 path fex/spool/.snapshot/2021-03-07_1532.test
> > ID 274 gen 27 top level 270 path fex/spool/.snapshot/2021-03-07_1718.test
> > 
> > root@tsmsrvj:~# find /data/fex | wc -l
> > 489887

>    I can't remember if this is why, but I've had to put a distinct
> fsid field in each separate subvolume being exported:
> 
> /srv/nfs/home     -rw,async,fsid=0x1730,no_subtree_check,no_root_squash

I must export EACH subvolume?!
The snapshots are generated automatically (via cron)!
I cannot add them to /etc/exports


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20210310075957.GG22502@savella.carfax.org.uk>
