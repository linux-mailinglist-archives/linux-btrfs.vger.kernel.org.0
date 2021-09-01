Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339FC3FE55D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 00:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbhIAWPG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 18:15:06 -0400
Received: from mail.virtall.com ([46.4.129.203]:51270 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236202AbhIAWPF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 18:15:05 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Sep 2021 18:15:05 EDT
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 0DDE98552698
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 22:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1630534035; bh=+F6kS1FB+/V/ZOUpAVXT8v0DJBtEM9sOyLN0WZAQFlc=;
        h=Date:From:To:Subject;
        b=sy1tOTm5tQlYS1eQxeCzt4DI1c7JMfv8botAY7UG0pwJUSpHESZnkE5vVGSHTx4GB
         xiWlbMBnnwi0w0PShVLIAmwOJGV7rHibzzDPDFI7O+jvSf2Pv8r3RGauQQA/RiYlgV
         UKw+HNYT02/buDuNBTOFfJGds8gQQLX1cWuzct/k4jY9E0U0vGR51eSZMfaBx5wkWa
         B46Crt87JcCzbztsbBCxu3HwifMJxkFpm7Zk1rdkoZTsKUTa4WMICtM5Sd724hw+eS
         esacshDasrfLaeEhNEErKo2HuhyvtE+tk+YJ0mZqklGLSCnRtvaMgY9+LoATiIw6Uk
         lyVRqxKveyRhg==
X-Fuglu-Suspect: e2b7efeb788345b795aeeead09ff376b
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_20
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 22:07:13 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 02 Sep 2021 00:07:11 +0200
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: how to replace a failed drive?
Message-ID: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
X-Sender: mangoo@wpkg.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm trying to follow 
https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices 
to replace a failed drive. But it seems to be written by a person who 
never attempted to replace a failed drive in btrfs filesystem, and who 
never used mdadm RAID (to see how good RAID experience should look 
like).

What I have:

- RAID-10 over 4 devices (/dev/sd[a-d]2)
- 1 disk (/dev/sdb2) crashed and was no longer seen by the operating 
system
- it was replaced using hot-swapping - new drive registered itself as 
/dev/sde
- I've partitioned /dev/sde, so that /dev/sde2 matches the size of other 
btrfs devices
- because I couldn't remove the faulty device (it wouldn't go below my 
current number of devices) I've added the new device to btrfs 
filesystem:

btrfs device add /dev/sde2 /data/lxd


Now, I wonder, how can I remove the disk which crashed?

# btrfs device delete /dev/sdb2 /data/lxd
ERROR: not a block device: /dev/sdb2


# btrfs device remove /dev/sdb2 /data/lxd
ERROR: not a block device: /dev/sdb2


# btrfs filesystem show /data/lxd
Label: 'lxd5'  uuid: 2b77b498-a644-430b-9dd9-2ad3d381448a
         Total devices 5 FS bytes used 2.84TiB
         devid    1 size 1.73TiB used 1.60TiB path /dev/sda2
         devid    3 size 1.73TiB used 1.60TiB path /dev/sdd2
         devid    4 size 1.73TiB used 1.60TiB path /dev/sdc2
         devid    6 size 1.73TiB used 0.00B path /dev/sde2
         *** Some devices missing


And, a gem:

# btrfs device delete missing /data/lxd
ERROR: error removing device 'missing': no missing devices found to 
remove


So according to "btrfs filesystem show /data/lxd" device is missing, but 
according to "btrfs device delete missing /data/lxd" - no device is 
missing. So confusing!


At this point, btrfs keeps producing massive amounts of logs - 
gigabytes, like:

[39894585.659909] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
60298373, rd 393827, flush 1565805, corrupt 0, gen 0
[39894585.660096] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
60298374, rd 393827, flush 1565805, corrupt 0, gen 0
[39894585.660288] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
60298375, rd 393827, flush 1565805, corrupt 0, gen 0
[39894585.660478] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
60298376, rd 393827, flush 1565805, corrupt 0, gen 0
[39894585.660667] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
60298377, rd 393827, flush 1565805, corrupt 0, gen 0
[39894585.660861] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
60298378, rd 393827, flush 1565805, corrupt 0, gen 0
[39894585.661105] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
60298379, rd 393827, flush 1565805, corrupt 0, gen 0
[39894585.661298] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
60298380, rd 393827, flush 1565805, corrupt 0, gen 0
[39894585.747082] BTRFS warning (device sda2): lost page write due to IO 
error on /dev/sdb2
[39894585.747214] BTRFS error (device sda2): error writing primary super 
block to device 5



This is REALLY, REALLY very bad RAID experience.

How to recover at this point?


Tomasz Chmielewski
