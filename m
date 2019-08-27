Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8E9DEE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 09:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfH0HlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 03:41:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34892 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfH0HlA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 03:41:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R7cfK0092570
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=2XXVx8p25PAOZEC4A1P28Gi0ZwddkE7USTmLoRuRa5k=;
 b=GLqUEtdN1MZQgc890UpRrStRtZwUheZXU4uMISTuW9rXQYyEeYLuK1pTB6iZZFc+1iSz
 mwNYOYPydsggeurV3fItRfnF/t22MCwtUpPvvU2s9tgN/bon/uuwx/Dca3PEHOGNa01h
 PT3e1fmK4io0o5ueeWPB3+nf1c28MJDX00nCSheIabEGGCebS7hs9JzMx4X8Rbr8PA3A
 XrXZW9K3RuOduczH6+nZolu3fO167/eAla9MQ4IW+X0O1aqFl83Bf7BovnEuNnmecBSV
 c4+Qnu4itNEz5+gEK9mHY8H5xfjzKbyGG8eDSpSUSKHCsVdSD2syc2/rVsn0oZrVle3/ 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2un03mg3v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:40:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R7cb9t118807
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:40:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2umhu8cv6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:40:59 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7R7evii019678
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:40:58 GMT
Received: from localhost.localdomain (/183.90.37.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 00:40:56 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] fix BUG_ON and retun real error in find_next_devid() and clone_fs_devices()
Date:   Tue, 27 Aug 2019 15:40:43 +0800
Message-Id: <20190827074045.5563-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=685
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=747 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270085
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes BUG_ON in find_next_devid() and fixes to return real error in
clone_fs_devices(). These two patches can be send to be independent.

Anand Jain (2):
  btrfs: fix BUG_ON with proper error handle in find_next_devid
  btrfs: fix error return on alloc fail in clone_fs_devices

 fs/btrfs/volumes.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.21.0 (Apple Git-120)

