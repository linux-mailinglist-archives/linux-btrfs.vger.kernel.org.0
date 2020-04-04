Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E219E488
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 12:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgDDKcT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 06:32:19 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:34685 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbgDDKcT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Apr 2020 06:32:19 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id Kg63jDxJE6Q7RKg63jI6VM; Sat, 04 Apr 2020 12:32:16 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585996336; bh=ylwoHzlX+CBoiLOl5561Dt0xmE3eZ8MVGZjeaL2ygqg=;
        h=From;
        b=CS5mSy7Ynm4MQ4LTpoWPKPY1MWRrBXkacsfezqczO0qc155RBVGclxhXXLaOYHsIE
         0mSTusCwEMvfrtmI29tIXnzpheqiAVdK9oOJEtyOSMqGR/2LNV7BekRBr3h5b0PIsT
         L2k9tLTyxORIQTSOWAYWjlwg5/KXWHR4ucTBbWxCqR/Vy5wX0tc1SCpgESzDIsq2NB
         +n5TIFo9YZNim2SsmcePBrGbSMrAIV16+WhX7WeNOZouV/V5/KOjXSNBmrAmJufUev
         Xe77VNsm7LElp266SFXgyi6tVldo6ma2U8Se/WPrFAAnpKURf8ORvWukALFtfhoz3I
         7mckn3bCgD+kQ==
X-CNFS-Analysis: v=2.3 cv=LelCFQXi c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=QQ43WuYAYlusJQpJd6cA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>
Subject: [PATCH v3] btrfs-progs: add warning for mixed profiles filesystem
Date:   Sat,  4 Apr 2020 12:32:07 +0200
Message-Id: <20200404103212.40986-1-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPSDX67fsdy9QFomiqD3SNPtTGSZ/x1zjl1FCYcXFQqYcHgBYBPvCFgnB+LAO/PnVqIQn5+7dWYL0v2MpW9flJxgYApXZOQ3f5j46GTgIW+9hfRIZrqj
 lWPfAfY7ZGjCsfcoL3qHxejnp+/zhi5rCX6j+U0QU97t1b6f0CZ7h0OXRf/uyK/LFeIvqYBm301sABrffvchO56rmqGSdX/TkQuGwiNKbWnZ9pZ4Nq8xAWAl
 18/pVyilpc0GEsHk2TgyhWUYIEOQhe1ck+jkRCmCjMMmWtNAEiNC21jjv/l53ffwRXJYz8jm0IBX/+qGHkre4g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi all,

the aim of this patch set is to issue a warning when a mixed profiles
filesystem is detected. This happens when the filesystems contains
(i.e.) raid1c3 and single chunk for data.

BTRFS has the capability to support a filesystem with mixed profiles.
However this could lead to an unexpected behavior when a new chunk is
allocated (i.e. the chunk profile is not what is wanted). Moreover
if the user is not aware of this, he could assume a redundancy which
doesn't exist (for example because there is some 'single' chunk when
it is expected the filesystem to be full raid1).
A possible cause of a mixed profiles filesystem is an interrupted
balance operation or a not fully balance due to very specific filter.

The check is added to the following btrfs commands:
- btrfs balance pause
- btrfs balance cancel
- btrfs device add
- btrfs device del

The warning is shorter than the before one. Below an example and
it is printed after the normal output of the command.

   WARNING: Multiple profiles detected.  See 'man btrfs(5)'.
   WARNING: data -> [raid1c3, single], metadata -> [raid1, single]

The command "btrfs fi us" doesn't show the warning above, instead
it was added a further line in the "Overall" section. The output now
is this:

$ sudo ./btrfs fi us /tmp/t/
[sudo] password for ghigo: 
Overall:
    Device size:		  30.00GiB
    Device allocated:		   4.78GiB
    Device unallocated:		  25.22GiB
    Device missing:		     0.00B
    Used:			   1.95GiB
    Free (estimated):		  13.87GiB	(min: 9.67GiB)
    Data ratio:			      2.00
    Metadata ratio:		      1.50
    Global reserve:		   3.25MiB	(used: 0.00B)
    Multiple profile:		       YES

Data,single: Size:1.00GiB, Used:974.04MiB (95.12%)
   /dev/loop0	   1.00GiB

Data,RAID1C3: Size:1.00GiB, Used:178.59MiB (17.44%)
   /dev/loop0	   1.00GiB
   /dev/loop1	   1.00GiB
   /dev/loop2	   1.00GiB

Metadata,single: Size:256.00MiB, Used:76.22MiB (29.77%)
   /dev/loop1	 256.00MiB

Metadata,RAID1: Size:256.00MiB, Used:206.92MiB (80.83%)
   /dev/loop1	 256.00MiB
   /dev/loop2	 256.00MiB

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/loop2	  32.00MiB

Unallocated:
   /dev/loop0	   8.00GiB
   /dev/loop1	   8.50GiB
   /dev/loop2	   8.72GiB


In this case there are two kind of chunks for data (raid1c3 and single)
and metadata (raid1, single).

As the previous patch set, the warning is added also to the command
'btrfs fi df' and 'btrfs dev us' as separate patch. If even in this
review nobody likes it, we can simply drop this patch.

Suggestion about which commands should (not) have this check are 
welcome.

v1 
- first issue
v2 
- add some needed missing pieces about raid1c[34]
- add the check to more btrfs commands
v3
- add a section in btrfs(5) 'FILESYSTEM WITH MULTIPLE PROFILES'
- 'btrfs fi us': changed the worning in a info in the 'overall' section

Patch #1 contains the code for the check.
Patch #3 adds the check to the command 'btrfs dev {add,del}' and 'btrfs
bal {pause, stop}'
Patch #3 adds the check to the command 'btrfs fi us'
Patch #5 add the check to the command 'btrfs fi df' and 'btrfs dev us'
Patch #5 add the info in btrfs(5) man page

Comments are welcome

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5





