Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0039DBF4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFGMK1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 08:10:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52494 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhFGMK0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 08:10:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157C06xX107386;
        Mon, 7 Jun 2021 12:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=piXlGSPIq7CMyK8037S2C2hB7fAiJBn+mYIhzd0c0Ww=;
 b=F0BUlMiuJDZ/XRQ0nvLGQE+h6/9Xxik0JU+1ww5myr7M6tNf95mpmCptvZjS/FLy9XY0
 pjUfTwAAxJ3UOyohAd1mE+9cWXz45sYGgo8yrfppFdaQEzO6R8F7Bux4KMvnsBP7Do2O
 WdMWuLvHDcCmv7K3eFdoxk5aPuD8wMliiYq4S+BS2PTqxsTik/ye+XvY5YZBQSPoJpgH
 ce+vUPRyUKzbd6K7VXhKTuMRpmxDhls+sAMppno4laWoymo9FlGcMvg3MmhfvEQK43Mr
 Zm4I/dfdeJc2o8ZFPkQV05MMgrXAzCjgGY1rFKTi7a6HRBusmQlA9ouvi/65x5d+aMyn nA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3914quha30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 12:08:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157BxlhV007470;
        Mon, 7 Jun 2021 12:08:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3906spjbx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 12:08:31 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 157C8TT4016777;
        Mon, 7 Jun 2021 12:08:29 GMT
Received: from fed2.sg.oracle.com (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 12:08:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, guan@eryu.me
Subject: [PATCH 0/2 v2] fstests: fix _scratch_mkfs_blocksized
Date:   Mon,  7 Jun 2021 20:08:18 +0800
Message-Id: <cover.1623059144.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d27e3a324f986b5b52d11df7c7bdcde6744fad4b.1622807821.git.anand.jain@oracle.com>
References: <d27e3a324f986b5b52d11df7c7bdcde6744fad4b.1622807821.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=882 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070092
X-Proofpoint-ORIG-GUID: KtB1E08nZt61Up8cZttSnwfHzVybS16F
X-Proofpoint-GUID: KtB1E08nZt61Up8cZttSnwfHzVybS16F
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=894 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070092
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes _scratch_mkfs_blocksized() to support btrfs. And the functions
indentation to use tab instead of space.

v2:
 Patch 1/2:
    Use grep -w
    Drop redundant $MKFS_OPTIONS

Anand Jain (2):
  btrfs: support other sectorsizes in _scratch_mkfs_blocksized
  _scratch_mkfs_blocksized: fix indentation

 common/rc | 59 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

-- 
2.27.0

