Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF88F139C6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 23:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgAMW2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 17:28:46 -0500
Received: from trent.utfs.org ([94.185.90.103]:33652 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgAMW2m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 17:28:42 -0500
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jan 2020 17:28:41 EST
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id C3A0C5F94F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 23:18:54 +0100 (CET)
Date:   Mon, 13 Jan 2020 14:18:54 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     linux-btrfs@vger.kernel.org
Subject: file system full on a single disk?
Message-ID: <alpine.DEB.2.21.99999.375.2001131400390.21037@trent.utfs.org>
User-Agent: Alpine 2.21.99999 (DEB 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I realize that this comes up every now and then but always for slightly 
more complicated setups, or so I thought:


============================================================
# df -h /
Filesystem             Size  Used Avail Use% Mounted on
/dev/mapper/luks-root  825G  389G     0 100% /

# btrfs filesystem show /
Label: 'root'  uuid: 75a6d93a-5a5c-48e0-a237-007b2e812477
        Total devices 1 FS bytes used 388.00GiB
        devid    1 size 824.40GiB used 395.02GiB path /dev/mapper/luks-root

# blockdev --getsize64 /dev/mapper/luks-root | awk '{print $1/1024^3, "GB"}'
824.398 GB

# btrfs filesystem df /
Data, single: total=388.01GiB, used=387.44GiB
System, single: total=4.00MiB, used=64.00KiB
Metadata, single: total=2.01GiB, used=1.57GiB
GlobalReserve, single: total=512.00MiB, used=80.00KiB
============================================================


This is on a Fedora 31 (5.4.8-200.fc31.x86_64) workstation. Where did the 
other 436 GB go? Or, why are only 395 GB allocated from the 824 GB device?

I'm running a --full-balance now and it's progressing, slowly. I've seen 
tricks on the interwebs to temporarily add a ramdisk, run another balance, 
remove the ramdisk again - but that seems hackish.

Isn't there a way to prevent this from happening? (Apart from better 
monitoring, so I can run the balance at an earlier stage next time).


Thanks,
Christian.


# btrfs filesystem usage -T /
Overall:
    Device size:                 824.40GiB
    Device allocated:            395.02GiB
    Device unallocated:          429.38GiB
    Device missing:                  0.00B
    Used:                        388.00GiB
    Free (estimated):            435.94GiB      (min: 435.94GiB)
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)

                         Data      Metadata System              
Id Path                  single    single   single   Unallocated
-- --------------------- --------- -------- -------- -----------
 1 /dev/mapper/luks-root 393.01GiB  2.01GiB  4.00MiB   429.38GiB
-- --------------------- --------- -------- -------- -----------
   Total                 393.01GiB  2.01GiB  4.00MiB   429.38GiB
   Used                  386.45GiB  1.55GiB 64.00KiB            


-- 
BOFH excuse #326:

We need a licensed electrician to replace the light bulbs in the computer room.
