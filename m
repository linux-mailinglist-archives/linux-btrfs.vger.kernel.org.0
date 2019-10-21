Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB868DE8E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfJUKBf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJUKBe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xSio004816
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=HWIWuXMKUxgs67rNvJLodsKxOlS2br/+X7ozUik0w2E=;
 b=jSUyPwAOB3dBUtsU5efz39Mg5cEGM4iottALrVty40uIN4p+51SmKdp4YyOHtsxKAvlG
 9gWHFjNpJ/2habURkRyUf+EoQVITzTOgT8Sfza1LgImYiGptfgUikPO+vIuzgGEK0aH9
 Vt2ecOeJhQ1x376sPAQZZabm3uKO7kpNwE34SrOQSvFHXUMfnZSk6YafZ3pbz+dO+DMo
 kNzeXTMK4mLXYEjUPrQ+5Uoz6hNWc+pqpeW46OulzSQ0QBTQ2gB5SqnuzyYvCxoQXroP
 W3HNQzCQog8LUfgIizm0LykEDJS5C038vSYPac0lIbMRLote8zoclL0GmTsm+QTAdRU/ EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vqu4qedw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9wKxV088727
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vrbyycuhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:32 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LA1W7S028348
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:32 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:32 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 00/14] btrfs-progs: global-verbose option
Date:   Mon, 21 Oct 2019 18:01:08 +0800
Message-Id: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210096
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Anand Jain (14):
  btrfs-progs: add global verbose helper functions
  btrfs-progs: migrate subvolume delete to global verbose
  btrfs-progs: migrate filesystem defragment to global verbose
  btrfs-progs: migrate btrfs balance start to global verbose
  btrfs-progs: migrate balance status to global verbose
  btrfs-progs: fix help, show long option in balance start and status
  btrfs-progs: migrate rescue chunk-recover to global verbose
  btrfs-progs: migrate rescue super-recover to global verbose
  btrfs-progs: restore: delete unreachable code
  btrfs-progs: migrate restore to global verbose
  btrfs-progs: migrate inspect-internal inode-resolve to global verbose
  btrfs-progs: migrate inspect-internal logical-resolve to global
    verbose
  btrfs-progs: refactor btrfs_scan_devices() to accept verbose argument
  btrfs-progs: enable verbose for btrfs device scan

 btrfs.c              | 12 ++++++--
 cmds/balance.c       | 29 +++++++++---------
 cmds/device.c        |  2 +-
 cmds/filesystem.c    | 27 ++++++++---------
 cmds/inspect.c       | 36 +++++++++++-----------
 cmds/rescue.c        | 22 +++++++-------
 cmds/restore.c       | 86 +++++++++++++++++++++-------------------------------
 cmds/subvolume.c     | 35 +++++++++++----------
 common/device-scan.c |  4 ++-
 common/device-scan.h |  2 +-
 common/help.h        |  8 +++++
 common/messages.c    | 19 ++++++++++++
 common/messages.h    |  5 +++
 common/utils.c       |  2 +-
 disk-io.c            |  2 +-
 15 files changed, 155 insertions(+), 136 deletions(-)

-- 
1.8.3.1

