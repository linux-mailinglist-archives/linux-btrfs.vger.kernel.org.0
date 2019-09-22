Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CEFBA01B
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2019 03:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfIVBUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Sep 2019 21:20:25 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:55988 "EHLO
        cdptpa-cmomta03.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726944AbfIVBUY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Sep 2019 21:20:24 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Sep 2019 21:20:23 EDT
Received: from static.bllue.org ([66.65.51.108])
        by cmsmtp with ESMTP
        id BqQ8ial4lYkhNBqQBiawOV; Sun, 22 Sep 2019 01:12:15 +0000
Received: from bllue.org (localhost.localdomain [127.0.0.1])
        by static.bllue.org (Postfix) with ESMTP id 418E8C6C3C
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2019 21:12:11 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 21 Sep 2019 21:12:11 -0400
From:   Kenneth Topp <toppk@bllue.org>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs filesystem not mountable after unclear shutdown
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <e9073c1dc608dc8d50ee8d131bc86887@bllue.org>
X-Sender: toppk@bllue.org
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on static.bllue.org
X-CMAE-Envelope: MS4wfFZ9sL4ulL6izxm/6j3bjf3yPqGswgolLXK9EFVemKr8AQ6IGvZHuzpEAPSf1wP/gZXW3ScazOGa+ESPHXtPNvmppCBiven8c7tEiNOTqnxMus/3+SfT
 0Bm4HZygKimV9N/aK7oMAyKPOqvgE4tlgR1zUOp7ye25LAHgIQwiOMZthFdn6ouub1pdXsZUzzwLKw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

after a couple unclean reboots, this filesystem became un-mountable.  
btrfs check didn't help either.  This should be a raid 1 metadata/raid 0 
data volume.  I've had this filesystem for several years, but I think it 
was after any major on disk options.

I tend to run a current kernel.   I got to 5.2.15 quickly after the 
btrfs bug report, and just was switching to 5.2.17 when things died.  I 
still have these disks as they are, but will wipe them out tomorrow and 
restore from backups unless someone has any further diagnostics they'd 
like me to run.

On a related subject, are there any tips for creating a new filesystem, 
I think I used to specify "-l 16K -n 16K" during mkfs.  I'll be 
switching to 4kn soon, and but currently using 512e, any notes regarding 
using 4kn disks?


here are some diagnostics:

[toppk@static ~]$ cat btrfs-failure.txt
# btrfs filesystem show /dev/mapper/cprt-47
Label: 'tm'  uuid: 2f8c681b-1973-4fe6-a6b6-0be182944528
         Total devices 2 FS bytes used 17.16TiB
         devid    1 size 9.09TiB used 8.65TiB path /dev/mapper/cprt-46
         devid    2 size 9.09TiB used 8.65TiB path /dev/mapper/cprt-47
# btrfs check /dev/mapper/cprt-46
Opening filesystem to check...
parent transid verify failed on 6751397658624 wanted 2012643 found 
2012295
parent transid verify failed on 6751397658624 wanted 2012643 found 
2012295
parent transid verify failed on 6751397658624 wanted 2012643 found 
2012295
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=7267733438464 item=33 parent 
level=2 child level=0
[root@static ~]# btrfs check -b /dev/mapper/cprt-46
Opening filesystem to check...
parent transid verify failed on 6751304908800 wanted 2012643 found 
2012294
parent transid verify failed on 6751305105408 wanted 2012643 found 
2012295
parent transid verify failed on 6751381258240 wanted 2012643 found 
2012295
parent transid verify failed on 6751397658624 wanted 2012643 found 
2012295
parent transid verify failed on 6751397658624 wanted 2012643 found 
2012295
parent transid verify failed on 6751397658624 wanted 2012643 found 
2012295
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=6751265570816 item=33 parent 
level=2 child level=0
ERROR: cannot open file system
[root@static ~]#   uname -a
Linux static.bllue.org 5.2.17-200.fc30.x86_64 #1 SMP Sat Sep 21 16:13:27 
EDT 2019 x86_64 x86_64 x86_64 GNU/Linux
[root@static ~]#   btrfs --version
btrfs-progs v5.2.1


Thanks,

Ken
