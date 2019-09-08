Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6377ACB49
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Sep 2019 09:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfIHHK0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Sep 2019 03:10:26 -0400
Received: from know-smtprelay-omd-6.server.virginmedia.net ([81.104.62.38]:46764
        "EHLO know-smtprelay-omd-6.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfIHHK0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Sep 2019 03:10:26 -0400
Received: from phoenix.exfire ([86.12.75.74])
        by cmsmtp with ESMTP
        id 6rL6iki0UzHXx6rL6ix9Mm; Sun, 08 Sep 2019 08:10:24 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: 
X-Spam: 0
X-Authority: v=2.3 cv=B9mXLtlM c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=IkcTkHD0fZMA:10 a=J70Eh1EUuV4A:10
 a=q29sNnpIa07UuD27jfUA:9 a=QEXdDO2ut3YA:10
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by phoenix.exfire (8.15.2/8.15.2) with ESMTP id x8879Tmq014067
        for <linux-btrfs@vger.kernel.org>; Sun, 8 Sep 2019 08:09:29 +0100
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
From:   Pete <pete@petezilla.co.uk>
Subject: Balance conversion to metadata RAID1, data RAID1 leaves some metadata
 as DUP
Message-ID: <eda2fb2a-c657-5e4a-8d08-1bf57b57dd3b@petezilla.co.uk>
Date:   Sun, 8 Sep 2019 08:09:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD6m3ZrPo0zwlYa3moaiQk05D03a8AZiZ+FK/9bTKRnAHxi1vTFz+A/bX6zfIRLM+b/4XePHqcDgJzgQNAUvomurNz1d20WfIF1Gs75PXc6/cyhDyc/v
 1L47dTwP4tgS8okqFLUFfjfd3Bp6dnuJvN1L8yOK8ETNrk0cltY3ugHKLShsW6cQamTXWoepVI337g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recently recovered created a fresh filesystem on one disk and
recovered from backups with data as SINGLE and metadata as DUP.  I added
a second disk yesterday and ran a balance with -dconvert=raid1
-mconvert=raid1.  I did reboot during the process for a couple of
reasons, putting the sides on the PC case, putting it back under the
desk and I updated the kernel from 5.3.9 to 5.2.13 at some point during
this process. Balance resumed as one would expect.  Balance has now
completed:

root@phoenix:~# btrfs balance status /home_data
No balance found on '/home_data'

However, some metadata remains as DUP which does not seem right:

root@phoenix:~# btrfs fi usage  /home_data/
Overall:
    Device size:                  10.92TiB
    Device allocated:              4.69TiB
    Device unallocated:            6.23TiB
    Device missing:                  0.00B
    Used:                          4.61TiB
    Free (estimated):              3.15TiB      (min: 3.15TiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID1: Size:2.34TiB, Used:2.30TiB
   /dev/mapper/data_disk_ESFH      2.34TiB
   /dev/mapper/data_disk_EVPC      2.34TiB

Metadata,RAID1: Size:7.00GiB, Used:4.48GiB
   /dev/mapper/data_disk_ESFH      7.00GiB
   /dev/mapper/data_disk_EVPC      7.00GiB

Metadata,DUP: Size:1.00GiB, Used:257.22MiB
   /dev/mapper/data_disk_ESFH      2.00GiB

System,RAID1: Size:32.00MiB, Used:368.00KiB
   /dev/mapper/data_disk_ESFH     32.00MiB
   /dev/mapper/data_disk_EVPC     32.00MiB

Unallocated:
   /dev/mapper/data_disk_ESFH      3.11TiB
   /dev/mapper/data_disk_EVPC      3.11TiB
root@phoenix:~#

root@phoenix:~# btrfs --version
btrfs-progs v5.1


I presume running another balance will fix this, but surely all metadata
should have been converted?  Is there a way to only balance the DUP
metadata?
