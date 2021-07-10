Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9733C333C
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jul 2021 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGJGiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 02:38:22 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:36402 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhGJGiV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 02:38:21 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 4E02E602C
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jul 2021 08:35:35 +0200 (MEST)
Date:   Sat, 10 Jul 2021 08:35:35 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210710063535.GE1548@tik.uni-stuttgart.de>
Mail-Followup-To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <475ccf1.ca37f515.17a8a262a72@tnonline.net>
 <20210709073444.GA582@tik.uni-stuttgart.de>
 <CAJCQCtR=Xar+0pD9ivhk-kfrWxTxbJpVYu3z8A617GKshf2AsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtR=Xar+0pD9ivhk-kfrWxTxbJpVYu3z8A617GKshf2AsA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2021-07-09 (10:30), Chris Murphy wrote:
> On Fri, Jul 9, 2021 at 1:34 AM Ulli Horlacher
> <framstag@rus.uni-stuttgart.de> wrote:
> 
> >
> > root@tsmsrvj:/# du -s /nfs/localhost/fex
> > du: WARNING: Circular directory structure.
> > This almost certainly means that you have a corrupted file system.
> > NOTIFY YOUR SYSTEM MANAGER.
> > The following directory is part of the cycle:
> >   /nfs/localhost/fex/spool
> 
> What do you get for:
> 
> btrfs subvolume list -to /nfs/localhost/fex

root@tsmsrvj:~# btrfs subvolume list -to /nfs/localhost/fex
ERROR: not a btrfs filesystem: /nfs/localhost/fex
ERROR: can't access '/nfs/localhost/fex'


root@tsmsrvj:~# mount | grep localhost
localhost:/data/fex on /nfs/localhost/fex type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<CAJCQCtR=Xar+0pD9ivhk-kfrWxTxbJpVYu3z8A617GKshf2AsA@mail.gmail.com>
