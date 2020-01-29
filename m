Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C6D14D264
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 22:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgA2VUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 16:20:05 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:48095 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726171AbgA2VUE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 16:20:04 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 0E8B5A912B;
        Wed, 29 Jan 2020 22:20:03 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Martin Raiber <martin@urbackup.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
Date:   Wed, 29 Jan 2020 22:20:02 +0100
Message-ID: <2049829.BAvHWrS4Fr@merkaba>
In-Reply-To: <0102016ff2e7e3ad-6b776470-32f1-4b3d-9063-d3c96921df89-000000@eu-west-1.amazonses.com>
References: <112911984.cFFYNXyRg4@merkaba> <0102016ff2e7e3ad-6b776470-32f1-4b3d-9063-d3c96921df89-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Martin Raiber - 29.01.20, 21:04:41 CET:
> On 29.01.2020 20:33 Martin Steigerwald wrote:
> > I thought this would not happen anymore, but see yourself:
> > 
> > % LANG=en df -hT /daten
> > Filesystem             Type   Size  Used Avail Use% Mounted on
> > /dev/mapper/sata-daten btrfs  400G  310G     0 100% /daten
> > 
> > I removed some larger files but to no avail.
> 
> I have the same issue since 5.4. This patch should fix it:
> https://lore.kernel.org/linux-btrfs/f1f1a2ab-ed09-d841-6a93-a44a8fb231
> 2f@gmx.com/T/ Confirm by writing to the file system. It shouldn't say
> that it is out of space (only df report says zero).
> 
> As far as I know, it is unfortunately not fixed in any released kernel
> yet.

Indeed remaining metadata space in the one 1 GiB big metadata chunk is 
less than global reserve:

> > However, also according to btrfs fi usage it is perfectly good:
> > 
> > % btrfs fi usage -T /daten
> > 
> > Overall:
> >     Device size:                 400.00GiB
> >     Device allocated:            311.04GiB
> >     Device unallocated:           88.96GiB
> >     Device missing:                  0.00B
> >     Used:                        309.50GiB
> >     Free (estimated):             90.16GiB      (min: 90.16GiB)
> >     Data ratio:                       1.00
> >     Metadata ratio:                   1.00
> >     Global reserve:              364.03MiB      (used: 0.00B)
> >     
> >                           Data      Metadata  System
> > 
> > Id Path                   single    single    single   Unallocated
> > -- ---------------------- --------- --------- -------- -----------
> > 
> >  1 /dev/mapper/sata-daten 310.00GiB   1.01GiB 32.00MiB    88.96GiB
> > 
> > -- ---------------------- --------- --------- -------- -----------
> > 
> >    Total                  310.00GiB   1.01GiB 32.00MiB    88.96GiB
> >    Used                   308.80GiB 714.67MiB 64.00KiB

Hmmm, Dolphin file manager said out of space, but it may be cause it 
meanwhile checks for enough available space *before* initiating the copy 
or move operation.

Consequently using "mv" worked to move the files to that filesystem.

Thank you for that hint.

So if its just a cosmetic issue then I can wait for the patch to land in 
linux-stable. Or does it still need testing?

Best,
-- 
Martin


