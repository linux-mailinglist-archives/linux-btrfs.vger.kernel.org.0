Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217FA334523
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 18:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCJRaR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 10 Mar 2021 12:30:17 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:19336 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhCJR3q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 12:29:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 0AF683F60E;
        Wed, 10 Mar 2021 18:29:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P2VjYGoBUHBc; Wed, 10 Mar 2021 18:29:43 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E98BC3F23E;
        Wed, 10 Mar 2021 18:29:42 +0100 (CET)
Received: from [192.168.0.126] (port=49194)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1lK2eU-0009Nm-De; Wed, 10 Mar 2021 18:29:42 +0100
Date:   Wed, 10 Mar 2021 18:29:43 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Message-ID: <55bb7f3.9ce44d1.1781d2fedd6@tnonline.net>
In-Reply-To: <20210310155538.GA4408@tik.uni-stuttgart.de>
References: <20210310074620.GA2158@tik.uni-stuttgart.de> <20210310075957.GG22502@savella.carfax.org.uk> <20210310080940.GB2158@tik.uni-stuttgart.de> <5bded122-8adf-e5e7-dceb-37a3875f1a4b@cobb.uk.net> <20210310155538.GA4408@tik.uni-stuttgart.de>
Subject: Re: nfs subvolume access?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Ulli Horlacher <framstag@rus.uni-stuttgart.de> -- Sent: 2021-03-10 - 16:55 ----

> On Wed 2021-03-10 (09:35), Graham Cobb wrote:
> 
>> >>> root@tsmsrvj:~# find /data/fex | wc -l
>> >>> 489887
>> > 
>> >>    I can't remember if this is why, but I've had to put a distinct
>> >> fsid field in each separate subvolume being exported:
>> >>
>> >> /srv/nfs/home     -rw,async,fsid=0x1730,no_subtree_check,no_root_squash
>> > 
>> > I must export EACH subvolume?!
>> 
>> I have had similar problems. I *think* the current case is that modern
>> NFS, using NFS V4, can cope with the whole disk being accessible without
>> giving each subvolume its own FSID (which I have stopped doing).
> 
> I cannot use NFS4 (for several reasons). I must use NFS3
> 
> 
>> > The snapshots are generated automatically (via cron)!
>> > I cannot add them to /etc/exports
>> 
>> Well, you could write some scripts... but I don't think it is necessary.
>> I *think* it is only necessary if you want `find` to be able to cross
>> between subvolumes on the NFS mounted disks.
> 
> It is not only a find problem:
> 
> root@fex:/nfs/tsmsrvj/fex# ls -R
> :
> spool
> ls: ./spool: not listing already-listed directory
> 
> 
> And as I wrote: there is no such problem with Ubuntu 18.04!
> So, is it a btrfs or a nfs bug?
> 
>

Did you try the fsid on the export? (not separate exports for all subvols) Without it the NFS server tries to enumerate it from the filesystem itself, which can cause weird issues. It is good practice to always use fsid on all exports in any case. 

At least with NFS4 server on my Ubuntu NFS servers at work, there are no issues with subvols for clients the mount with vers=3

You may want to enable debug logging on your server. https://wiki.tnonline.net/w/Blog/NFS_Server_Logging

/Forza

