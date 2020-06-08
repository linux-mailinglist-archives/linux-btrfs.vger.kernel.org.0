Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4E1F12F7
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgFHGlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:41:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:41:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586cB6V086928;
        Mon, 8 Jun 2020 06:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=eAE9iXwBHcO4/syfkVOlwww1dVwKAFV5fDPT9Sg48yI=;
 b=uBuf4Q+N9mmIBNQ5k4+qVnM+zWdnKDURVPMwxYiYFRjbUXZ5BmBV7Rjdy2uwcBqa0tfo
 xcjcgdycYJIiEoUL6x8xIiBX0Oh5tpmRBySpIPHx5Ceyr+xJ4EpYLpRj+2GFs8OaXBh1
 Mbhzo8/CEBItsfSebIuvfefaBaYR1llcKl0OCgQEQQSdd1wSkPynRHFr1Dg/kwFaP5gL
 9ON1JEMdjSvP7CgX8dzyFhERxsBO/UcK3WYL66hJtPFxGayaZIN+fXJy+QXC2FnaTxuh
 qp2pxb2TsnOrBLFYubHxIOuwj+cdMotxt1scH8boDyWbzojvNFw6WDNWEOAihRURKq2H sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31g2jqw566-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:41:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586XbAZ156347;
        Mon, 8 Jun 2020 06:39:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31gn2usf2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:39:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0586d0FM013681;
        Mon, 8 Jun 2020 06:39:00 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:39:00 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 0/8 PART2] btrfs-progs: add quiet option
Date:   Mon,  8 Jun 2020 14:38:43 +0800
Message-Id: <20200608063851.8874-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The part-1 patchset [1] 'btrfs-progs: global verbose and quiet option'
[1]
https://patchwork.kernel.org/project/linux-btrfs/list/?series=207709

provided a global structure to communicate the verbose and quiet options
down to the individual sub-commands where the actual printf happens.
So each of the sub-command could enable the verbose or quiet option as
needed.
But some of the sub-commands already had the verbose and quiet options
locally at the sub-command level. So the aim of part-1 of this series
was to merge the local verbose and quiet option with the global verbose
and quiet, which it did successfully.

In this series, part-2, adds the global quiet option to the found
chatty sub-commands. So each of the sub-commands outputs were 
individually checked and brought those logs under the global quiet
option. As this process is nondeterministic (unless like in part-1 where
sub-commands with -v or -q were checked) so there might have few logs
left behind and those can be fixed as moved along.

The whole series can be fetched from [2], which is based on latest devel
branch, last commit: c1d6d654a3f9 (btrfs-progs: docs: update balance).

[2]
https://github.com/asj/btrfs-progs.git verbose

Anand Jain (8):
  btrfs-progs: quota rescan: add quiet option
  btrfs-progs: subvolume create: add quiet option
  btrfs-progs: subvolume delete: add quiet option
  btrfs-progs: balance start: add quiet option
  btrfs-progs: balance resume: add quiet option
  btrfs-progs: subvolume snapshot: add quiet option
  btrfs-progs: scrub start|resume: use global quiet option
  btrfs-progs: scrub cancel: add quiet option

 cmds/balance.c   | 17 +++++++++++------
 cmds/quota.c     |  4 +++-
 cmds/scrub.c     | 25 +++++++++++++++----------
 cmds/subvolume.c | 24 +++++++++++++++---------
 4 files changed, 44 insertions(+), 26 deletions(-)

-- 
2.25.1

