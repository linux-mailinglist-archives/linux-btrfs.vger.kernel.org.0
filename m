Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F7E276E4E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 12:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgIXKLq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 06:11:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44446 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKLq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 06:11:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OA9NAg068162;
        Thu, 24 Sep 2020 10:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=FMFSQjT1EBj+B4hA2UlDXKsYfxTimQO/jk0Y3zMGZvE=;
 b=u4gfN4gu1qv2Wpkbso9o9t2gEFm3Z7ZLnRmtlZSJvS67yhLMcCNY2+4TR0ndZ9llkcKW
 9QPvQmEGEiMwROTNC2Zi6ECQwEr4ROB6VG/2x0zaviW0lKV03inCRbBHW+5kArQhd9pQ
 nTj0FvYMWJO09Z3+VaXyA2sLJTtJmCK4WDoqm5/fdOcgzN/A756MSFLzaGjLx5oIxruW
 tyRvCsU9NDwIoCfj/00AMJgGzgvpoH7fVRMUHse4H6aOzZRQFjR0SdDSnUNpj09KcYY1
 udv2n0REOTw6N53dWYEf0IrB4ejvxFYvcI67kpEMQX8I0sgOqdu3VbE36NlRK4g3PjAu Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33q5rgnmu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 10:11:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OAASQB094209;
        Thu, 24 Sep 2020 10:11:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33nujqqr7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 10:11:39 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OABcUH011253;
        Thu, 24 Sep 2020 10:11:39 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 03:11:37 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com, wqu@suse.com, dsterba@suse.com,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/2] fix verify_one_dev_extent and btrfs_find_device
Date:   Thu, 24 Sep 2020 18:11:22 +0800
Message-Id: <cover.1600940809.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=1 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240077
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_find_device()'s last arg %seed is unused, which the commit
343694eee8d8 (btrfs: switch seed device to list api) ignored purposely
or missed.

But there isn't any regression due to that. And this series makes
it official that btrfs_find_device() doesn't need the last arg.

To achieve that patch 1/2 critically reviews the need for the check
disk_total_bytes == 0 in the function verify_one_dev_extent() and finds
that, the condition is never met and so deletes the same. Which also
drops one of the parents of btrfs_find_device() with the last arg false.

So only device_list_add() is using btrfs_find_device() with the last arg as
false, which the patch 2/2 finds is not required as well. So
this patch drops the last arg in btrfs_find_device() altogether.

Anand Jain (2):
  btrfs: drop never met condition of disk_total_bytes == 0
  btrfs: fix btrfs_find_device unused arg seed

 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/ioctl.c       |  4 ++--
 fs/btrfs/scrub.c       |  4 ++--
 fs/btrfs/volumes.c     | 37 ++++++++++---------------------------
 fs/btrfs/volumes.h     |  2 +-
 5 files changed, 17 insertions(+), 34 deletions(-)

-- 
2.25.1

