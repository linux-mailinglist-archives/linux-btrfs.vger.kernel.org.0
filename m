Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9603DED912
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfKDGet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33090 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbfKDGeo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YhgS187318
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=Q4YcNQnGmI/6k+hyvCFobyzItgFI2TN/UNaX+A/6iVg=;
 b=I0YNzpenDS/Qcda/8XbqxB6eD0ZnHxNT1JBHVfUgDqNtvjcSCS5mlzgz0ISGRHfwN17y
 QPwZOoRpKJVuq83597lTy7uGwtiHxbfBMzs0C6f4OOgoJYDA+0aTBiEzseh0luXd0H2z
 bFeaZh/+Xyc2UukV+QIhfPTKpXVPHUG+72KDyshMJqFIzN6p8IDOGizPfm3EA5GNBYCM
 w2j20TN+gmRAz30d4Tqc+LX9OuzIZS/2G7mTBFE3GmidGo/3SPMn7csZYKCtDrXLj/Vj
 7ugTK2QYYDP15Cq5k4A0CIbdv/fftME7GF/o/ZqN9dHV1neWm/mNXvukJr5aCmzQtDzi +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rpn5qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YUnk187427
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w1kxkt92v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:33 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA46XRtF030859
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:27 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:27 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1.1 00/18] btrfs-progs: global verbose and quiet option
Date:   Mon,  4 Nov 2019 14:32:58 +0800
Message-Id: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040063
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v1.1:
 . Fix typo in HELPINFO_INSERT_QUIET.
 . Remove #include <stdbool.h> where its no more required.
   (was needed when %bconf.verbose was declared as bool).
 . Use pr_verbose(-1,..) instead of all conditions printf()
 . Use pr_verbose(1,..) instead of pr_verbose(true,..)

verbosity sample code as in v1.1

global init
-----------
        bconf.verbose = -1; //-1:default, 0:quiet, >1:verbose

at global options
-----------------
	case 'v':
		bconf.verbose < 0 ? bconf.verbose = 1 : bconf.verbose++;
		break;
	case 'q':
		bconf.verbose = 0;
		break;

sub-command init
----------------
For send/receive only (special cases, default verbosity is 1):

	if (bconf.verbose < 0)
		bconf.verbose = 1;
	else if (bconf.verbose > 0)
		bconf.verbose++;

Non-send/receive:
default verbosity is 0 (ref: cmds/rescue.c)
	if (bconf.verbose < 0)
		bconf.verbose = 0;

at sub-command options
----------------------
	case 'v':
		bconf.verbose++;
		break;
	case 'q':
		bconf.verbose = 0;
		break;


pr_verbose()
------------
/*
 * level -1: prints message unless bconf.verbose == 0;
 * level  0: quiet
 * level >0: prints message only if <= bconf.verbose
 */
void pr_verbose(int level, const char *fmt, ...)
{
        va_list args;

        if (level == 0 || bconf.verbose == 0)
                return;

        if (level > bconf.verbose)
                return;

        va_start(args, fmt);
        vfprintf(stdout, fmt, args);
        va_end(args);
}


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

 btrfs.c              | 20 +++++++++++--
 cmds/balance.c       | 26 +++++++++++------
 cmds/device.c        |  7 +++--
 cmds/filesystem.c    | 18 ++++++------
 cmds/inspect.c       | 45 +++++++++++++++---------------
 cmds/receive.c       | 79 +++++++++++++++++++++++++++++-----------------------
 cmds/rescue.c        | 22 +++++++++++----
 cmds/restore.c       | 57 ++++++++++++++++++-------------------
 cmds/send.c          | 33 ++++++++++++++--------
 cmds/subvolume.c     | 32 +++++++++++----------
 common/device-scan.c |  3 +-
 common/device-scan.h |  2 +-
 common/help.h        | 11 ++++++++
 common/messages.c    | 17 +++++++++++
 common/messages.h    |  3 ++
 common/utils.c       |  3 +-
 common/utils.h       |  3 ++
 disk-io.c            |  2 +-
 18 files changed, 239 insertions(+), 144 deletions(-)

-- 
1.8.3.1

