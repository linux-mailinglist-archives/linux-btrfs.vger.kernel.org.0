Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE9A4A9DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbfFRScG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 14:32:06 -0400
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:57104 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729922AbfFRScF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 14:32:05 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2019 14:32:04 EDT
Received: from [192.168.47.90] (lfbn-1-6101-50.w90-110.abo.wanadoo.fr [90.110.6.50])
        by box.speed47.net (Postfix) with ESMTPSA id 0C748ACC3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 20:26:32 +0200 (CEST)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1560882392;
        bh=VtqjOQ2vCbdnzy+AIcWK439YVxnOT12frechgbqzS20=;
        h=From:To:Date:Subject;
        b=XNcXfdTjNsxZPuz/kVZR9jqlhmKzJrq+y8a0EtCbmJUIxhvBJSi/neXLE7FUT7GDf
         z98jFQv3B68WiPOjfm5QDSoMXc7ScroBkhYhKxF3VxD2ZFf7G/Dpfsx/cZOlYhp3Xu
         /Y3wgyu6JZuCw/+HxWfyzmGBPF+DrXXo9Cy7RhQ8=
From:   =?UTF-8?B?U3TDqXBoYW5lIExlc2ltcGxl?= <stephane_btrfs@lesimple.fr>
To:     <linux-btrfs@vger.kernel.org>
Date:   Tue, 18 Jun 2019 20:26:32 +0200
Message-ID: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
User-Agent: AquaMail/1.20.0-1458 (build: 102100001)
Subject: Rebalancing raid1 after adding a device
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I've been a btrfs user for quite a number of years now, but it seems I need 
the wiseness of the btrfs gurus on this one!

I have a 5-hdd btrfs raid1 setup with 4x3T+1x10T drives.
A few days ago, I replaced one of the 3T by a new 10T, running btrfs 
replace and then resizing the FS to use all the available space of the new 
device.

The filesystem was 90% full before I expanded it so, as expected, most of 
the space on the new device wasn't actually allocatable in raid1, as very 
few available space was available on the 4 other devs.

Of course the solution is to run a balance, but as the filesystem is now 
quite big, I'd like to avoid running a full rebalance. This would be quite 
i/o intensive, would be running for several days, and putting and 
unecessary stress on the drives. This also seems excessive as in theory 
only some Tb would need to be moved: if I'm correct, only one of two block 
groups of a sufficient amount of chunks to be moved to the new device so 
that the sum of the amount of available space on the 4 preexisting devices 
would at least equal the available space on the new device, ~7Tb instead of 
moving ~22T.
I don't need to have a perfectly balanced FS, I just want all the space to 
be allocatable.

I tried using the -ddevid option but it only instructs btrfs to work on the 
block groups allocated on said device, as it happens, it tends to move data 
between the 4 preexisting devices and doesn't fix my problem. A full 
balance with -dlimit=100 did no better.

Is there a way to ask the block group allocator to prefer writing to a 
specific device during a balance? Something like -ddestdevid=N? This would 
just be a hint to the allocator and the usual constraints would always 
apply (and prevail over the hint when needed).

Or is there any obvious solution I'm completely missing?

Thanks,

Stéphane.





