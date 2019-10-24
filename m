Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2A7E2A68
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 08:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406959AbfJXG2c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 02:28:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55614 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfJXG2c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 02:28:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O6O0ue178705
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=1h00HK0R7zpIbgF9OMtfC5F2JPbYUcSKeTsBnC+Oj7s=;
 b=b4u3arLqWLBQJKZkzR0bepcl2gDKSv5u2/6aO6pp1cpxyVlp+dB1GFVIJx/Dl6NUa/cd
 pSCU4EN51vEVhMKitA2BwA3aIeUrK0vPQ5rqziV669va8NEzo9EBOMVD4DryTtaa/jA2
 osz+it3xNB5D0DE/lHBjVbqTPZZLXtajORJ3+RhmmdOxjPojXDyJefK+BWqOOIqUluEp
 +1QLngtlLgoO5Pe2Sp71HlF/LpWW4HQHUaN6nDt+E5GrE5xHU5pPCjxKQ/hJu9rLWIqe
 NExm8fcdShUSGB3iAZ9vSJ37bJgTeA0B6OsHXPhj51svv66zfxTh1SJJRXYkX4vkC4OT 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vqswtsktq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O6Mxtl045207
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vtjkhrqkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:30 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O6ST7o022213
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:29 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Oct 2019 23:28:29 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 0/3] btrfs-progs: make quiet to overrule verbose
Date:   Thu, 24 Oct 2019 14:28:22 +0800
Message-Id: <20191024062825.13097-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=736
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=823 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240060
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When both the options (--quiet and --verbose) in btrfs send and receive
is specified, we need at least one of it to overrule the other, irrespective
of the chronological order of options.

This patch-set makes quiet overrule verbose.

I don't think this shall break any script as such, because these two options are
of kind of mutually exclusive. But just in case if I am missing something? So
marked it as RFC.

And again patch 3/3 makes quiet option really quiet in receive and removes the
output
 At snapshot <>
I don't expect scripts to specify quiet option and expect some logs.

Anand Jain (3):
  btrfs-progs: send: let option quiet overrule verbose
  btrfs-progs: receive: let option quiet overrule verbose
  btrfs-progs: receive: make quiet really quiet

 cmds/receive.c | 9 +++++++--
 cmds/send.c    | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.23.0

