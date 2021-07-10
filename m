Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DE83C3365
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jul 2021 09:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhGJHGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 03:06:02 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:36706 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhGJHF7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 03:05:59 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 148F261B7
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jul 2021 09:03:13 +0200 (MEST)
Date:   Sat, 10 Jul 2021 09:03:12 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210710070312.GG1548@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <CAMnT83vyufNCMDQQnyYi-k8dOft3_bc_2L-rgHOBzeWgKqPt2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMnT83vyufNCMDQQnyYi-k8dOft3_bc_2L-rgHOBzeWgKqPt2A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2021-07-09 (19:06), Lord Vader wrote:
> On Fri, 9 Jul 2021 at 01:18, Ulli Horlacher
> <framstag@rus.uni-stuttgart.de> wrote:
> 
> > I have waited some time and some Ubuntu updates, but the bug is still there:
> > > > When I try to access a btrfs filesystem via nfs, I get the error:
> > > > root@tsmsrvi:~# mount tsmsrvj:/data/fex /nfs/tsmsrvj/fex
> > > > root@tsmsrvi:~# time find /nfs/tsmsrvj/fex | wc -l
> > > > find: File system loop detected; '/nfs/tsmsrvj/fex/spool' is part of the same file system loop as '/nfs/tsmsrvj/fex'.
> 
> Can you try exporting NFS share with 'crossmnt' option?

root@tsmsrvj:/etc# exportfs -v
/data/fex       localhost.localdomain(rw,async,wdelay,crossmnt,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)

root@tsmsrvj:/etc# mount -v localhost:/data/fex /nfs/localhost/fex
mount.nfs: timeout set for Sat Jul 10 09:02:31 2021
mount.nfs: trying text-based options 'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'

root@tsmsrvj:/etc# du -s /nfs/localhost/fex
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
REF:<CAMnT83vyufNCMDQQnyYi-k8dOft3_bc_2L-rgHOBzeWgKqPt2A@mail.gmail.com>
