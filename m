Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12AB3D7467
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhG0LfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhG0LfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 07:35:05 -0400
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jul 2021 04:35:05 PDT
Received: from mail-out02.belwue.de (mail-out02.belwue.de [IPv6:2001:7c0:0:76::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D7C061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 04:35:05 -0700 (PDT)
Received: from mail-hub01.belwue.de (mail-hub01.belwue.de [IPv6:2001:7c0:0:76::41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail-out02.belwue.de (Postfix) with ESMTPS id 4GYvf72TlJz9yv7X
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 13:27:27 +0200 (CEST)
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by mail-hub01.belwue.de (Postfix) with SMTP id 4GYvf65Nzfz52B3x
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 13:27:26 +0200 (CEST)
Date:   Tue, 27 Jul 2021 13:27:26 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210727112726.GA30962@tik.uni-stuttgart.de>
Mail-Followup-To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210709065320.GC8249@tik.uni-stuttgart.de>
 <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
 <20210710065612.GF1548@tik.uni-stuttgart.de>
 <CAJCQCtQn0=8KiB=2garN8k2NRd1PO3HBnrMNvmqssSfKT2-UXQ@mail.gmail.com>
 <20210712072525.GI1548@tik.uni-stuttgart.de>
 <294e8449-383f-1c90-62be-fb618332862e@cobb.uk.net>
 <20210712161618.GA913@tik.uni-stuttgart.de>
 <8506b846-4c4d-6e8f-09ee-e0f2736aac4e@cobb.uk.net>
 <20210713073721.GA5047@tik.uni-stuttgart.de>
 <2b53b9dd-4353-a73e-59b3-c87b6419ebf4@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b53b9dd-4353-a73e-59b3-c87b6419ebf4@tnonline.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Rspamd-Queue-Id: 4GYvf65Nzfz52B3x
X-Rspamd-UID: 5ff9a9
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon 2021-07-19 (14:06), Forza wrote:

> > And the error messages are annoying!
> > 
> > root@tsmsrvj:/etc# exportfs -v
> > /data/fex       localhost.localdomain(rw,async,wdelay,crossmnt,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)
> > /data/snapshots localhost.localdomain(rw,async,wdelay,crossmnt,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)
> > 
> > root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/fex /nfs/localhost/fex
> > root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/snapshots /nfs/localhost/snapshots
> > root@tsmsrvj:/etc# mount | grep localhost
> > localhost:/data/fex on /nfs/localhost/fex type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)
> > localhost:/data/snapshots on /nfs/localhost/snapshots type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)
> > 
> 
> What kind of NFS server is this? 

Default Ubuntu kernel NFS-server.


> Isn't UDP mounts legacy and not normally used by default?

See above, I am using tcp!


> Can you switch to an nfs4 server and try again? I also still think you 
> should use fsid export option.

No change. The error is still there.



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<2b53b9dd-4353-a73e-59b3-c87b6419ebf4@tnonline.net>
