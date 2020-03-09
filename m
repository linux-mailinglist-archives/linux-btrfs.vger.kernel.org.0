Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6880717DED5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 12:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCILkn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 07:40:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36606 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgCILkn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 07:40:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029BcJY9141166;
        Mon, 9 Mar 2020 11:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=sQAFBuRTyqFk5eNVszurAkCB2lUpQ38rrXO5YBY7Zgg=;
 b=FQJfaayZyc3Uz8OnHfLhobInFjNoM2edaZqPeIrkvAmfBrhajcPA57eMUuNTQVYX8o1d
 3DDz4QCVBI7Sa4yU1qceoasIsBjxksdV/GluK85Vl13TrrewiV8yP76ZpD8e5yR5g7Ak
 sa1NDO5iBcxO3g4N1278NQhBPNHeKjIh6FL/aVxl61mRYw0fC/euZCOcz9MbXqbpD5Mb
 uT9PcGCVounL4WR4wxPXfkb/J0wNRUhipCIZtVpt6nX6Z3W9125WRAZx+8upBA3xkj5o
 4EuHpIDSB5fhYheRFdjOWGcrlFv46bKgngALJPy0qdNtAIDBMFe0FOKF+g3q95CbfSwF 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ym31u6gs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 11:40:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029Bb63H100198;
        Mon, 9 Mar 2020 11:40:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ymn3fry82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 11:40:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 029Beejn021633;
        Mon, 9 Mar 2020 11:40:41 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Mar 2020 04:40:40 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] fstests: cleanup and fix btrfs/177
Date:   Mon,  9 Mar 2020 19:40:34 +0800
Message-Id: <20200309114036.5266-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9554 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=13 malwarescore=0
 mlxlogscore=885 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9554 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=13
 phishscore=0 mlxlogscore=949 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090082
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 1/2 adds notrun for the scratch device below 3G size.
Patch 2/2 fixes the test case failure on the system with nodesize=64K and
chunk type single.

Anand Jain (2):
  fstests: btrfs/177 check for minsize of the scratch device
  fstests: btrfs/177 fix for nodesize 64K and type single

 tests/btrfs/177     | 39 ++++++++++++++++++++++++++++-----------
 tests/btrfs/177.out |  6 ++----
 2 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.18.1

