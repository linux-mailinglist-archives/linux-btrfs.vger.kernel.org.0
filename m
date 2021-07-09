Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C672A3C200D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 09:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhGIHh2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 03:37:28 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:58564 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhGIHh2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 03:37:28 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 44432AED7
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 09:34:44 +0200 (MEST)
Date:   Fri, 9 Jul 2021 09:34:44 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210709073444.GA582@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <475ccf1.ca37f515.17a8a262a72@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475ccf1.ca37f515.17a8a262a72@tnonline.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2021-07-09 (09:23), Forza wrote:

> > In consequence many cronjobs and montoring tools will fail :-(
> > 
> >> You can eliminate the problems by exporting and mounting single
> >> subvolumes only 
> > 
> > This is not possible at our site, we use rotating snapshots created by a
> > cronjob.

> Have you tried using the fsid= export option in /etc/exports? 

I have testet it with localhost:

root@tsmsrvj:/# grep localhost /etc/exports 
/data/fex       localhost(rw,async,no_subtree_check,no_root_squash,fsid=20000001)

root@tsmsrvj:/# mount -v localhost:/data/fex /nfs/localhost/fex
mount.nfs: timeout set for Fri Jul  9 09:32:55 2021
mount.nfs: trying text-based options 'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'

root@tsmsrvj:/# mount | grep localhost
localhost:/data/fex on /nfs/localhost/fex type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)

root@tsmsrvj:/# du -s /nfs/localhost/fex
du: WARNING: Circular directory structure.
This almost certainly means that you have a corrupted file system.
NOTIFY YOUR SYSTEM MANAGER.
The following directory is part of the cycle:
  /nfs/localhost/fex/spool


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<475ccf1.ca37f515.17a8a262a72@tnonline.net>
