Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46511ECD4A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFCKMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:12:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58200 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgFCKMc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 06:12:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053A85tH157567
        for <linux-btrfs@vger.kernel.org>; Wed, 3 Jun 2020 10:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=HNfDr3rliOdzRzZVWirTgOt/7UbvWdclvfTqpeIOVFg=;
 b=XIR01PdP6PvlE13sV7hcCpITC9Nr4aukiSIpf+39pWjSK22vLzEyTUEpHZCa7w1Lf6Ce
 eZm63VGVWmpnAV1nIRmSRjc9GIApRlL56Mz/FQS6sn+B8Dg+bXP/n86F64eoB0vull38
 82OYkUc9C7LixEUzyV/E6mvvfqqhuzhOvhqW3pzCwjmLOa61dXt+pzriz6feb8nMUy+u
 KQmY8RX83TIwghBkfVwWjpLW+i13Nuv5NHla7wkP1utvuB/sq/chB8/lNxKguEAjw0z1
 h7DM/BgrotyfZAFOLdPaYRydEsChKueMajkY5l0kEmzx/Vd6dCmFYXZuEg328SuVZTF2 rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31dkrunha1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 10:12:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053A9Jlr126747
        for <linux-btrfs@vger.kernel.org>; Wed, 3 Jun 2020 10:10:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31c1dys61m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 10:10:31 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053AAUwn024940
        for <linux-btrfs@vger.kernel.org>; Wed, 3 Jun 2020 10:10:30 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 03:10:29 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: minor block group cleanups
Date:   Wed,  3 Jun 2020 18:10:17 +0800
Message-Id: <20200603101020.143372-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=889
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=3 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=3 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=943 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Minor cleanup patches.
1/3 cleansup the return value of btrfs_return_cluster_to_free_space().
2/3 and 3/3 together cleanups block group reference count.

2/3 and 3/3 are related. However 1/3 is independent to the rest of the
patches in this set.

Anand Jain (3):
  btrfs: fix btrfs_return_cluster_to_free_space() return
  btrfs: rename btrfs_block_group::count
  btrfs: use helper btrfs_get_block_group

 fs/btrfs/block-group.c      |  8 ++++----
 fs/btrfs/block-group.h      |  2 +-
 fs/btrfs/free-space-cache.c | 17 +++++++----------
 fs/btrfs/free-space-cache.h |  2 +-
 4 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.25.1

