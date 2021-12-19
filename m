Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF2147A0D8
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Dec 2021 15:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhLSORy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 19 Dec 2021 09:17:54 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:2608 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbhLSORy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Dec 2021 09:17:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id EFC483F96A;
        Sun, 19 Dec 2021 15:17:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5S9NQ81IfjvC; Sun, 19 Dec 2021 15:17:51 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0AF8F3F8E6;
        Sun, 19 Dec 2021 15:17:50 +0100 (CET)
Received: from [8.14.199.10] (port=50812 helo=[10.81.53.79])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1myx0X-0004b5-Po; Sun, 19 Dec 2021 15:17:50 +0100
Date:   Sun, 19 Dec 2021 15:17:46 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <57e198c.2779e098.17dd30e4224@tnonline.net>
In-Reply-To: <CAHzMYBQ5zMw=dUMRqn-_qYoAjYKadj6qio=5t3nudiOftTaqOQ@mail.gmail.com>
References: <CAHzMYBQ5zMw=dUMRqn-_qYoAjYKadj6qio=5t3nudiOftTaqOQ@mail.gmail.com>
Subject: Re: Balance metadata
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Jorge Bastos <jorge.mrbastos@gmail.com> -- Sent: 2021-12-19 - 14:59 ----

> Hello, I remember reading in the mailing list that we should avoid
> balancing metadata, I have a filesystem that acts exclusive as receive
> side for daily btrfs incremental snapshots from a couple of btrfs
> filesystems containing 3 Windows VMs, it's composed of 5 HDDs in raid5
> (raid1 metadata), the snapshots appear to be very metadata heavy, not
> much data is changed daily, I noticed that the script was starting to
> take much longer than in the beginning, it usually took a couple of
> hours or so but I've been using for many months and it kept taking
> longer and longer, especially in the last month, these are just some
> examples from the last few days:
> 
> 
> Script Starting Dec 06, 2021  02:30.01
> Script Finished Dec 06, 2021  06:13.50
> 
> Script Starting Dec 12, 2021  02:30.01
> Script Finished Dec 12, 2021  09:30.11
> 
> Script Starting Dec 16, 2021  02:30.01
> Script Finished Dec 16, 2021  10:59.36
> 
> I'd like to keep this script limited to the night hours, so I thought
> to try raid10 for metadata to see if it would help, and this was the
> result:
> 
> Script Starting Dec 18, 2021  02:30.01
> Script Finished Dec 18, 2021  03:52.21
> 
> Seeing this, I thought no way just raid10 would make such a big
> difference, so I rebalanced the metadata to raid1 and this was the
> result:
> 
> Script Starting Dec 19, 2021  02:30.01
> Script Finished Dec 19, 2021  03:50.09
> 
> So it looks to me like that, at least in some cases, a metadata
> balance can be beneficial, so I thought to share.
> 
> Regards,
> Jorge Bastos

You might benefit from a general data balance too because balancing is really a free space defragmentation.

Space_cache=v2 mount option can help because it is more performant with free space fragmentation.

Another option is to defragment the metadata and extent trees.
 
Example :
# btrfs fi defrag -v /media/backup/
WARNING: directory specified but recursive mode not requested: /media/backup WARNING: a directory passed to the defrag ioctl will not process the files recursively but will defragment the subvolume tree and the extent tree. If this is not intended, please use option -r .

You would have to do this for each subvolume. It can't be done for read-only snapshots though. 

