Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04672293BC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 14:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406234AbgJTMgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 08:36:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35406 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406096AbgJTMgE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 08:36:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KCSqrw012340;
        Tue, 20 Oct 2020 12:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=MZF75fa//BXPhu2Oid9pQxA+8Ol/Ev2uqC+Wd2AINFA=;
 b=psbbvrmgQYw18AmfHAJ6V6nSVGZL/4UiKW0JrRSmvNo8YgxwwpM5oZRWC7W9KAnA1hBJ
 7JDLGVsYttP3tfVhwZQ68ba/j6fiUN48kyaEoZRMrCBIcZxqNrRvWOkZYa0bEJP3yE0Z
 m7RYTbI1p3aWBB9MEzG9M/FruM5fxtVpLKKrayAL/+HGQoltPvqk2anbpE5CrmYK0OUJ
 /ugXtc3k+1PnktLPUCPXSBWP4Q4c/ZWUS64vODi96tU9aa7kH/MwQbOCtlBlU6MSI+4W
 P5sckjVh52hhMScPSO7ZjsDSfAEJq5ohE9o+BFUKb0RFztRD0pomrljyjcXQYMjNKyBy VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 349jrpjrfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 12:36:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KCVBA4183097;
        Tue, 20 Oct 2020 12:34:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 348ahw6jc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 12:34:01 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09KCY0YW000415;
        Tue, 20 Oct 2020 12:34:00 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 05:34:00 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com
Subject: [PATCH v3 0/2] add seed delete test case and fix btrfs/163
Date:   Tue, 20 Oct 2020 20:32:55 +0800
Message-Id: <cover.1603196609.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=1 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200086
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Anand Jain (2):
  btrfs: add a test case for btrfs seed device delete
  btrfs/163: replace sprout instead of seed

 tests/btrfs/163     | 25 ++++++++++----
 tests/btrfs/163.out |  5 ++-
 tests/btrfs/225     | 82 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/225.out | 15 +++++++++
 tests/btrfs/group   |  1 +
 5 files changed, 120 insertions(+), 8 deletions(-)
 create mode 100755 tests/btrfs/225
 create mode 100644 tests/btrfs/225.out

-- 
2.25.1

