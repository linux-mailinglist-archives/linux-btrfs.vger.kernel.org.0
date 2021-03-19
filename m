Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D1341649
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 08:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhCSHKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 03:10:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58212 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhCSHKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 03:10:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J79t9X006503;
        Fri, 19 Mar 2021 07:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=WRsSkbH75V6lkO5fW/4jK+bgxp2N47jf1Z1ax8ElSBA=;
 b=vXg7tzUtms0VE86uR3wwr9NB+IYQuDsr+07SFzFNBy7HN7gH8x+KBzJHOK976uaOOPQU
 wNTZygz3KjFwX0JreHz9eVHse2saYXY/4PeIhY88SNe9vFJTL5kQOw3xm1phqkxDRmD2
 7gOgIru6dQMirZ0K9aeeaxCu5rNt7kEM5BpVoOJbM052z1zNq36PlTIUohyNWQtuXsX2
 63GlQCq5KZZqoYRgIvdU6RorulwQvbyqCNBjJOgrsgh6yJf+5ToTJ96iPi2mDbTKkq+M
 jyuEEH5VffjJ10ciTzx1BZ/KabqJJt3VCWvX4AKyYIO4dqOflJlBcwz8NKZZQQETLTxE Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1p1u0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 07:10:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J7ADfJ132295;
        Fri, 19 Mar 2021 07:10:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3797b3wg4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 07:10:16 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12J7ADTL015898;
        Fri, 19 Mar 2021 07:10:13 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Mar 2021 00:10:13 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v2] btrfs-progs: fix inspect-internal --help incomplete sentence
Date:   Fri, 19 Mar 2021 15:10:02 +0800
Message-Id: <0e95dbad99f21a00f5a3b7704196e5bde47bc8db.1616137734.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <d9905452906eea5e8ac5b569e92df3c48861d734.1616136002.git.anand.jain@oracle.com>
References: <d9905452906eea5e8ac5b569e92df3c48861d734.1616136002.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190047
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190047
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs inspect-internal --help show some incomplete sentenses. As shown
below,

  btrfs inspect-internal --help
  <snip>
      btrfs inspect-internal min-dev-size [options] <path>
          Get the minimum size the device can be shrunk to. The
      btrfs inspect-internal dump-tree [options] <device> [<device> ..]
  <snip>

This patch just fixes it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Drop the idea to fix the period at the end of the single line help
    statements. Because the fix wasn't sufficient, there are more, and
    it can be done separately.

 cmds/inspect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 15f19c8a3027..4e3e6382637a 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -389,9 +389,9 @@ static DEFINE_SIMPLE_COMMAND(inspect_rootid, "rootid");
 
 static const char* const cmd_inspect_min_dev_size_usage[] = {
 	"btrfs inspect-internal min-dev-size [options] <path>",
-	"Get the minimum size the device can be shrunk to. The",
-	"device id 1 is used by default.",
+	"Get the minimum size the device can be shrunk to",
 	"",
+	"The device id 1 is used by default.",
 	"--id DEVID   specify the device id to query",
 	NULL
 };
-- 
2.29.2

