Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495431F0A85
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 10:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgFGIe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 04:34:56 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:33027 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFGIe4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 04:34:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49fqSZ2PVdz2d;
        Sun,  7 Jun 2020 10:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591518894; bh=Pp85SGSnqMHhOxQNU4ukhF93RfpFTEIuNYBiXgM2avI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fg+p0mesYzfGyFHIUaYNKdOxImCQzg94R4Mw5a5pqZxIrn1Wotw4/1S5QE0NXR8NF
         3ptUn8L+zH4b4FHbzGe6nib7/diiIPXkqiXEGiLAm2K2OITALA6/iqTlGmTKbHipQ7
         1z6Mg0BUsYHOV1wVqYNbrZG7I0xHJ96Yoln6nioM7v5f1ISMBSAPOyMa7KPBKcVFOD
         +P4X0vuXhUQrhQiym2AN5GZOfY/NW/mGM8kFvHqcrfGGY2jiNurTnLUxfwcMEKDYRY
         yZsdh04+oV6vAz1+meBIlK90qav1vwvzywdBWrr9UOuIvW6/ayyi7BWbzFKkB6jsuX
         w7hfMxhlxXYQg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 7 Jun 2020 10:34:52 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: balance + ENOFS -> readonly filesystem
Message-ID: <20200607083452.GA9208@qmqm.qmqm.pl>
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 07, 2020 at 03:35:36PM +0800, Qu Wenruo wrote:
> On 2020/6/7 下午1:12, Michał Mirosław wrote:
> > Dear btrfs developers,
> > 
> > I just added a new disk to already almost full filesystem and tried to
> > enable raid1 for metadata (transcript below).
> May I ask for your per-disk usage?
> 
> There is a known bug (but rare to hit) that completely unbalance disk
> usage can lead to unexpected ENOSPC (-28) error at certain critical code
> and cause the transaction abort you're hitting.
> 
> If you have added a new disk to an almost full one, then I guess that
> would be the case...

# btrfs filesystem usage .
Overall:
    Device size:                   1.82TiB
    Device allocated:            932.51GiB
    Device unallocated:          930.49GiB
    Device missing:                  0.00B
    Used:                        927.28GiB
    Free (estimated):            933.86GiB      (min: 468.62GiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)

Data,single: Size:928.47GiB, Used:925.10GiB
   /dev/mapper/btrfs1         927.47GiB
   /dev/mapper/btrfs2           1.00GiB

Metadata,RAID1: Size:12.00MiB, Used:1.64MiB
   /dev/mapper/btrfs1          12.00MiB
   /dev/mapper/btrfs2          12.00MiB

Metadata,DUP: Size:2.00GiB, Used:1.09GiB
   /dev/mapper/btrfs1           4.00GiB

System,DUP: Size:8.00MiB, Used:144.00KiB
   /dev/mapper/btrfs1          16.00MiB

Unallocated:
   /dev/mapper/btrfs1           1.02MiB
   /dev/mapper/btrfs2         930.49GiB

> > The operation failed and
> > left the filesystem in readonly state. Is this expected?
> 
> Definitely not.
> 
> If your disk layout fits my assumption, then the following patchset is
> worth trying:
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=297005

I'll give it a try.

Best Regards,
Michał Mirosław
