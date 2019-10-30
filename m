Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5CBE986F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfJ3Irz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:47:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57870 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfJ3Iry (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:47:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8ctkZ027547;
        Wed, 30 Oct 2019 08:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=IyIy2KoFCWTvUXmffuYQqhhoaTpJTitdpkmTOQPeIx0=;
 b=BvEKJLBIczBcXM6Te8nphyLwLaQFLfNnRSIPo1qxMpJXpEzHtQrVcUFpnJPN/W8drO7J
 psn92FPKJ6Si8rUA8KFN/R9aHHLSIgJyMzAUFr4DdMTjpl+5FYNnt5L0P9nsWzBNfIFB
 aFqK8c2eislvCjaTmeBHljpGTN3VZaCm7SNtsiPrCmbaplG4u19u5Bp6iA3wpqcbsNHO
 ByfbLNgPSfbb5TsNOfi0Oz8s6i7+nmc7BAMUUyD1JrTu938BlVjgvbcmdWSZy02mhVtK
 82NYeL63t5/rYL3TOhhnuJ0bI2A2ZkGChxr3J/ayFul5efOsmK3pB4Y9gXMvskD7sckV Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vxwhfjeey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8bvZL113500;
        Wed, 30 Oct 2019 08:41:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vxwj9j9ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:26 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9U8fQlB008357;
        Wed, 30 Oct 2019 08:41:26 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:26 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 00/18] btrfs-progs: global verbose and quiet option
Date:   Wed, 30 Oct 2019 16:41:04 +0800
Message-Id: <20191030084122.29745-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

RFC->v1:
. Adds --quiet option to the global btrfs(8) command.
. Used global struct bconf.
. Refactored pr_verbose(), accepts level (int) as argument, so now the
sub-command can specify the verbose level at which the particular
verbose messages has to be printed.
. Added global help defines.

Kindly note the following:-

1.
 There are certain sub-commands which does not have any verbose output
 or quiet output. However if the global options were used with those
 sub-commands then the command shall not report any usage error. Or
 my question is should it error out.? For example:
  (with the patch) btrfs --verbose device ready /dev/sdb
 actually there isn't any verbose output but we won't error out.
 Similarly,
  (without the patch) btrfs send -vvvvv will not show usage error
  as well.
  So I believe this is fine. IMO.

2.
  There is slight difference in output when global options are used
  as compared to the output using the same sequence of options at the
  sub-command level. For example:

   btrfs send -v -q -v  is-equal-to  btrfs send
   But same sequence in the global option
   btrfs -v -q -v send is-not-equal-to btrfs send
   but is-equal-to btrfs -v send or btrfs send -v.
   (similarly applies to receive as well).

  which IMO is fair expectation as -v is ending last.


RFC:
This patch set brings --verbose option to the top level btrfs command,
such as 'btrfs --verbose'. With this we don't have to add or remember
verbose option at the sub-commands level.

As there are already verbose options to 11 sub-commands as listed
below [1][2]. So the top level --verbose option here takes care to transpire
verbose request from the top level to the sub-command level for 9 (not 11)
sub-commands as in [1] as of now.

This patch is RFC still for the following two reasons (comments appreciated).

1.
The sub-commands as in [2] uses multi-level compile time verbose option,
such as %g_verbose = 0 (quite), %g_verbose = 1 (default), %g_verbose > 1
(real-verbose). And verbose at default is also part the .out files in
fstests. So it needs further discussions on how to handle the multi-
level verbose option using the global verbose option, and so sub-
commands in [2] are untouched.

2.
These patch has been unit-tested individually.
These patches does not alter the verbose output.
But it fixes the indentation in the command's help output, which may be
used in fstests and btrfs-progs/tests and their verification is pending
still, which I am planning to do it before v1.

[1]
btrfs subvolume delete --help
        -v|--verbose           verbose output of operations
btrfs filesystem defragment --help
        -v                  be verbose
btrfs balance start --help
        -v|--verbose        be verbose
btrfs balance status --help
        -v|--verbose        be verbose
btrfs rescue chunk-recover --help
        -v      Verbose mode
btrfs rescue super-recover --help
        -v      Verbose mode
btrfs restore --help
        -v|--verbose         verbose
btrfs inspect-internal inode-resolve --help
        -v   verbose mode
btrfs inspect-internal logical-resolve --help
        -v          verbose mode

[2]
btrfs send --help
        -v|--verbose     enable verbose output to stderr, each occurrence of
btrfs receive --help
        -v               increase verbosity about performed action

Anand Jain (18):
  btrfs-progs: receive: fix option quiet
  btrfs-progs: balance status: fix usage show long verbose
  btrfs-progs: balance start: fix usage add long verbose
  btrfs-progs: add global verbose and quiet options and helper functions
  btrfs-progs: send: use global verbose and quiet options
  btrfs-progs: receive: use global verbose and quiet options
  btrfs-progs: subvolume delete: use global verbose option
  btrfs-progs: filesystem defragment: use global verbose option
  btrfs-progs: balance start: use global verbose option
  btrfs-progs: balance status: use global verbose option
  btrfs-progs: rescue chunk-recover: use global verbose option
  btrfs-progs: rescue super-recover: use global verbose option
  btrfs-progs: restore: use global verbose option
  btrfs-progs: inspect-internal inode-resolve: use global verbose
  btrfs-progs: inspect-internal logical-resolve: use global verbose
    option
  btrfs-progs: refactor btrfs_scan_devices() to accept verbose argument
  btrfs-progs: device scan: add verbose option
  btrfs-progs: device scan: add quiet option

 btrfs.c              | 20 +++++++++--
 cmds/balance.c       | 26 ++++++++++-----
 cmds/device.c        |  7 ++--
 cmds/filesystem.c    | 18 +++++-----
 cmds/inspect.c       | 45 +++++++++++++------------
 cmds/receive.c       | 79 ++++++++++++++++++++++++--------------------
 cmds/rescue.c        | 22 ++++++++----
 cmds/restore.c       | 55 +++++++++++++++---------------
 cmds/send.c          | 33 +++++++++++-------
 cmds/subvolume.c     | 32 +++++++++---------
 common/device-scan.c |  4 ++-
 common/device-scan.h |  2 +-
 common/help.h        | 11 ++++++
 common/messages.c    | 18 ++++++++++
 common/messages.h    |  5 +++
 common/utils.c       |  3 +-
 common/utils.h       |  3 ++
 disk-io.c            |  2 +-
 18 files changed, 242 insertions(+), 143 deletions(-)

-- 
2.23.0

