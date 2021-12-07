Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E6946B0B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 03:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhLGCiz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 21:38:55 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:25838 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231468AbhLGCiy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 21:38:54 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 21:38:54 EST
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 02B45461533
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 02:29:18 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 56C1D461636
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 02:29:17 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.105.57.109 (trex/6.4.3);
        Tue, 07 Dec 2021 02:29:17 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Daffy-Whistle: 7d7fe05837cae9e4_1638844157697_1701059240
X-MC-Loop-Signature: 1638844157697:4037311529
X-MC-Ingress-Time: 1638844157697
Received: from p57b045ec.dip0.t-ipconnect.de ([87.176.69.236]:49572 helo=heisenberg.scientia.net)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1muQEC-0003qB-Dr
        for linux-btrfs@vger.kernel.org; Tue, 07 Dec 2021 02:29:15 +0000
Message-ID: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
Subject: ENOSPC while df shows 826.93GiB free
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Tue, 07 Dec 2021 03:29:09 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

At the university I'm running a Tier-2 site for the large hadron
collider, with some total storage of 4 PB.

For a bit more than half of that I use btrfs, with HDDs combined to
some hardware raid, provided as 16TiB devices (on which the btrfs
sits).

It runs Debian bullseye, which has 5.10.70. Oh and I've used -R free-
space-tree.
I don't use snapshots on these filesystems.


On one of the filesystems I've ran now into ENOSPC.

# btrfs filesystem usage /srv/dcache/pools/2
Overall:
    Device size:		  16.00TiB
    Device allocated:		  16.00TiB
    Device unallocated:		   1.00MiB
    Device missing:		     0.00B
    Used:			  15.19TiB
    Free (estimated):		 826.93GiB	(min: 826.93GiB)
    Free (statfs, df):		 826.93GiB
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,single: Size:15.97TiB, Used:15.16TiB (94.94%)
   /dev/sdf	  15.97TiB

Metadata,DUP: Size:17.01GiB, Used:16.51GiB (97.06%)
   /dev/sdf	  34.01GiB

System,DUP: Size:8.00MiB, Used:2.12MiB (26.56%)
   /dev/sdf	  16.00MiB

Unallocated:
   /dev/sdf	   1.00MiB


yet:
# /srv/dcache/pools/2/foo
-bash: /srv/dcache/pools/2/foo: No such file or directory


balancing also fails, e.g.:
# btrfs balance start -dusage=50 /srv/dcache/pools/2
ERROR: error during balancing '/srv/dcache/pools/2': No space left on device
There may be more info in syslog - try dmesg | tail
# btrfs balance start -dusage=40 /srv/dcache/pools/2
Done, had to relocate 0 out of 16370 chunks
# btrfs balance start  /srv/dcache/pools/2
WARNING:

	Full balance without filters requested. This operation is very
	intense and takes potentially very long. It is recommended to
	use the balance filters to narrow down the scope of balance.
	Use 'btrfs balance start --full-balance' option to skip this
	warning. The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting balance without any filters.
ERROR: error during balancing '/srv/dcache/pools/2': No space left on device
There may be more info in syslog - try dmesg | tail
# btrfs balance start -dusage=0 /srv/dcache/pools/2
Done, had to relocate 0 out of 16370 chunks




fsck showed no errors.



Any ideas what's going on and how to recover?


Thanks,
Chris.
