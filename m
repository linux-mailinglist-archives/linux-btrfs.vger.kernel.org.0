Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74193C50CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbhGLHfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 03:35:20 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:44916 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245590AbhGLH2P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 03:28:15 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id DF646A8D6
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 09:25:25 +0200 (MEST)
Date:   Mon, 12 Jul 2021 09:25:25 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210712072525.GI1548@tik.uni-stuttgart.de>
Mail-Followup-To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
 <20210710065612.GF1548@tik.uni-stuttgart.de>
 <CAJCQCtQn0=8KiB=2garN8k2NRd1PO3HBnrMNvmqssSfKT2-UXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQn0=8KiB=2garN8k2NRd1PO3HBnrMNvmqssSfKT2-UXQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 2021-07-10 (16:17), Chris Murphy wrote:
> On Sat, Jul 10, 2021 at 12:56 AM Ulli Horlacher
> <framstag@rus.uni-stuttgart.de> wrote:
> 
> > root@tsmsrvj:# snaprotate -v test 5 /data/fex/spool
> > $ btrfs subvolume snapshot -r /data/fex/spool /data/fex/spool/.snapshot/2021-07-10_0849.test
> > Create a readonly snapshot of '/data/fex/spool' in '/data/fex/spool/.snapshot/2021-07-10_0849.test'
> 
> I think this might be the source of the problem. Nested snapshots are
> not a good idea, it causes various kinds of confusion.

I do not have nested snapshots anywhere.
/data/fex/spool is not a snapshot.
/data/fex/spool/.snapshot/2021-07-10_0849.test is a simple snapshot of
the btrfs subvolume /data/fex/spool


> > We cannot move the snapshots to a different directory. Our workflow
> > depends on snaprotate:
> >
> > http://fex.belwue.de/linuxtools/snaprotate.html
> 
> OK does the problem happen if you have no nested snapshots (no nested
> subvolumes of any kind) in the NFS export path?
>
> If the problem doesn't happen, then either the tool you've chosen needs
> to be enhanced so it will create snapshots somewhere else, which Btrfs
> supports, or you need to find another tool that can.

Without snapshots there is no problem, but we need access to the snapshots
on the nfs clients for backup/recovery like Netapp offers it.
But Netapp is EXPENSIVE :-}

If we cannot handle it with btrfs, then we have to switch to ZFS.

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<CAJCQCtQn0=8KiB=2garN8k2NRd1PO3HBnrMNvmqssSfKT2-UXQ@mail.gmail.com>
