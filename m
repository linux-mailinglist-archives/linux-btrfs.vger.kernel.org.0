Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E90135E86
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 17:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbgAIQoG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 11:44:06 -0500
Received: from magic.merlins.org ([209.81.13.136]:52442 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgAIQoF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 11:44:05 -0500
X-Greylist: delayed 922 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 11:44:05 EST
Received: from svh-gw.merlins.org ([173.11.111.145]:60472 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1ipafo-0006HJ-0p; Thu, 09 Jan 2020 08:28:41 -0800
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1ipafn-0008NE-KJ; Thu, 09 Jan 2020 08:28:39 -0800
Date:   Thu, 9 Jan 2020 08:28:39 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     linux-btrfs@vger.kernel.org
Message-ID: <20200109162839.GA29989@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Checker-Version: SpamAssassin 3.4.2-mmrules_20121111 (2018-09-13) on
        magic.merlins.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=7.0 tests=GREYLIST_ISWHITE,SPF_SOFTFAIL,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2-mmrules_20121111
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: merlins.org]
        *  1.0 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this receipient and sender
Subject: 5.4.8: WARNING: errors detected during scrubbing, corrected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Howdy,

I have 6 btrfs pools on my laptop on 3 different SSDs.
After a few years, one of them is now very slow to scrub
and hands my laptop while it runs.
This started under 5.3.8, but upgrading to 5.4.8 didn't fix it.

Also, it output 'errors during scrubbing', but I see nothing in the kernel log:
btrfs scrub start -Bd /mnt/btrfs_pool2
scrub device /dev/mapper/pool2 (id 1) done
        scrub started at Thu Jan  9 01:46:45 2020 and finished after 01:29:49
        total bytes scrubbed: 1.27TiB with 0 errors
WARNING: errors detected during scrubbing, corrected

real    89m49.190s
user    0m0.000s
sys     13m26.548s


89mn is also longer than normal

balance works ok:
logger: Quick Metadata and Data Balance of /mnt/btrfs_pool2 (/dev/mapper/pool2)
Done, had to relocate 0 out of 837 chunks
Done, had to relocate 0 out of 837 chunks
Done, had to relocate 0 out of 837 chunks

I re-ran a bigger balance, and it ran fine too:
trfs balance start -musage=60 /mnt/btrfs_pool2; btrfs balance start -dusage=60 /mnt/btrfs_pool2


Jan  9 01:46:45 saruman kernel: [14530.056667] BTRFS info (device dm-3): balance: start -musage=0 -susage=0
Jan  9 01:46:45 saruman kernel: [14530.059623] BTRFS info (device dm-3): balance: ended with status: 0
Jan  9 01:46:45 saruman kernel: [14530.134043] BTRFS info (device dm-3): balance: start -dusage=0
Jan  9 01:46:45 saruman kernel: [14530.135525] BTRFS info (device dm-3): balance: ended with status: 0
Jan  9 01:46:45 saruman kernel: [14530.193798] BTRFS info (device dm-3): balance: start -dusage=20
Jan  9 01:46:45 saruman kernel: [14530.195642] BTRFS info (device dm-3): balance: ended with status: 0
Jan  9 01:46:45 saruman kernel: [14530.240290] BTRFS info (device dm-3): scrub: started on devid 1
Jan  9 01:58:21 saruman kernel: [15226.254196]       Tainted: G        W  OE     5.4.8-amd64-preempt-sysrq-20190816 #1
Jan  9 01:58:21 saruman kernel: [15226.254198] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  9 01:58:21 saruman kernel: [15226.254201] btrfs-transacti D    0 12403      2 0x80004000
Jan  9 01:58:21 saruman kernel: [15226.254204] Call Trace:
Jan  9 01:58:21 saruman kernel: [15226.254211]  ? __schedule+0x575/0x5d0
Jan  9 01:58:21 saruman kernel: [15226.254215]  ? __list_add+0x12/0x2b
Jan  9 01:58:21 saruman kernel: [15226.254218]  schedule+0x7b/0xac
Jan  9 01:58:21 saruman kernel: [15226.254222]  btrfs_scrub_pause+0x99/0xd3
Jan  9 01:58:21 saruman kernel: [15226.254226]  ? finish_wait+0x62/0x62
Jan  9 01:58:21 saruman kernel: [15226.254231]  btrfs_commit_transaction+0x307/0x82b
Jan  9 01:58:21 saruman kernel: [15226.254235]  ? start_transaction+0x37b/0x3ec
Jan  9 01:58:21 saruman kernel: [15226.254239]  ? schedule_timeout+0xf/0xea
Jan  9 01:58:21 saruman kernel: [15226.254243]  transaction_kthread+0xdd/0x151
Jan  9 01:58:21 saruman kernel: [15226.254247]  ? btrfs_cleanup_transaction+0x417/0x417
Jan  9 01:58:21 saruman kernel: [15226.254250]  kthread+0xf5/0xfa
Jan  9 01:58:21 saruman kernel: [15226.254253]  ? kthread_create_worker_on_cpu+0x65/0x65
Jan  9 01:58:21 saruman kernel: [15226.254256]  ret_from_fork+0x35/0x40
Jan  9 01:58:21 saruman kernel: [15226.254554] INFO: task cron:3869 blocked for more than 120 seconds.

from here, lots of hangs until eventually:
Jan  9 03:16:34 saruman kernel: [19919.454109] BTRFS info (device dm-3): scrub: finished on devid 1 with status: 0

I see no error about the scrub though.

saruman:/mnt/btrfs_pool2# btrfs fi show .
Label: 'btrfs_pool2'  uuid: c3ac7621-79da-4d4f-bd59-d12fe7ba3578
	Total devices 1 FS bytes used 785.58GiB
	devid    1 size 1.12TiB used 831.21GiB path /dev/mapper/pool2

saruman:/mnt/btrfs_pool2# btrfs fi df .
Data, single: total=817.08GiB, used=779.88GiB
System, DUP: total=64.00MiB, used=128.00KiB
Metadata, DUP: total=7.00GiB, used=5.70GiB
GlobalReserve, single: total=512.00MiB, used=64.00KiB

saruman:/mnt/btrfs_pool2# btrfs fi usage .
Overall:
    Device size:		   1.12TiB
    Device allocated:		 831.21GiB
    Device unallocated:		 315.79GiB
    Device missing:		     0.00B
    Used:			 791.28GiB
    Free (estimated):		 352.99GiB	(min: 195.10GiB)
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)

Data,single: Size:817.08GiB, Used:779.88GiB
   /dev/mapper/pool2	 817.08GiB

Metadata,DUP: Size:7.00GiB, Used:5.70GiB
   /dev/mapper/pool2	  14.00GiB

System,DUP: Size:64.00MiB, Used:128.00KiB
   /dev/mapper/pool2	 128.00MiB

Unallocated:
   /dev/mapper/pool2	 315.79GiB


I'm going to stop the scrub for now, but clearly that's not so good.

What should I try next?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
