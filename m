Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49544394B6D
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 May 2021 11:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhE2Ju7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 May 2021 05:50:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34264 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2Ju6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 05:50:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9hpqu121213
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=ymRMkBABc03ki/sZTwKXE0VGchuwuXFx3jnspQ1PjIE=;
 b=ECeOuu8gPf+Tvv8VQs3BAbQCsFxhXS7fL8i1KCjtOURCxWaCmsCFHhU0vW7dGYwngTig
 xnkJL7ui5g8zesI7Yv14FuQxzgSn3Yi+Mp6cNquZARqU1oQAGdStH0sYuSudFJUhFY2Q
 FQEnKg9hLJhihByeFbD9L9Dsl+8jCW3A1aK1Pjx3NPJscaim0tOKqvdFZsEZjg7pvSx8
 m5ZA6LTYkhjIuljkHlVkKyk3gtuDg8TRreFdcjvSKnT5bosB4NJR/dhng3gXdCHItJfz
 GJMYg15pTUxadmgEHdorfL65gYz+5lgtjI/WDo2y+2xqbjb9wCcObK3rveYz+obWTBGV Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38ue8p8dbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9kR5G091194
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38ucxjfcaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:21 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14T9mFOe092675
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 38ucxjfcat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 May 2021 09:49:21 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14T9nKAs013629;
        Sat, 29 May 2021 09:49:20 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 May 2021 02:49:20 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/4] variables fixes in compression.c
Date:   Sat, 29 May 2021 17:48:32 +0800
Message-Id: <cover.1622252932.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _VBNUK1bABoXzLtXghgtNY2-V57SQQeT
X-Proofpoint-ORIG-GUID: _VBNUK1bABoXzLtXghgtNY2-V57SQQeT
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105290075
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch (btrfs: reduce compressed_bio member's types) reduced the
size to unsigned int as in [1]. Fix its cascading effects here.
And one stale comment in the patch 4/4.

[1]
-       unsigned long len;
+       unsigned int len;

-       int compress_type;
+       u8 compress_type;

-       unsigned long nr_pages;
+       unsigned int nr_pages;

-       unsigned long compressed_len;
+       unsigned int compressed_len;

-       int errors;
+       u8 errors;

As shown in [2], we set the max compressable block size to 128K. So
struct async_extent can reduce some of its members to unsigned int as
well.

[2]
static noinline int compress_file_range(struct async_chunk *async_chunk)
::
  617         total_compressed = min_t(unsigned long, total_compressed,
  618                         BTRFS_MAX_UNCOMPRESSED);

But changes touches too many places, and my first attempt to fix
is unsatisfactory to me, so I am just sending the changes limited to the
file compression.c.

Anand Jain (4):
  btrfs: optimize users of members of the struct compressed_bio
  btrfs: optimize variables size in btrfs_submit_compressed_read
  btrfs: optimize variables size in btrfs_submit_compressed_write
  btrfs: fix comment about max_out in btrfs_compress_pages

 fs/btrfs/compression.c | 21 +++++++++------------
 fs/btrfs/compression.h |  6 +++---
 2 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.30.2

