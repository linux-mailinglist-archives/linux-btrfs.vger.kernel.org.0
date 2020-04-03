Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36CFC19CE80
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 04:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbgDCCLL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 22:11:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390227AbgDCCLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 22:11:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03328t9s077609;
        Fri, 3 Apr 2020 02:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=K3+urF8yw9R1V3IcIaLPlrwMvSxDn0ZIqa80r1gDrB8=;
 b=C8xYYBxmnbHTQ8AaXOx9m7twqcp8lYz4JlmuZ9fr6wo8i82o3ZDZqMSLwxQUPmggFVV0
 G842NMjEHIc4RiTsrs004U8UKtqRDt46PTGhD3UrGkoOz/EwvmEGVP8Z2gc2NWXjKoP6
 xhoZEkwlg/VLHpXgPKdNcYEk6hyW1a4n0OboH9mlgVbMAecPP3E4OL4JCkTq/8by6RyL
 3sxFdolmNL7qtHYwv7kDNQvJnQG/99fylkn9rP5ZP8PhWXxLGXdmplWb8BS05EMaGfsb
 r/8QRUtUUe7jpoaX70sAeUQvxrVEDm8ri/Q9YM1g0R6ko4MuHdBcVlmesCkGyD2iBcQW oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 303aqhy438-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:11:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03327HxB087643;
        Fri, 3 Apr 2020 02:11:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 304sjr8xcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:11:05 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0332B48F029691;
        Fri, 3 Apr 2020 02:11:04 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 19:11:04 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 2/4] btrfs-progs: fix TEST_TOP path drop extra forward slash
Date:   Fri,  3 Apr 2020 10:10:41 +0800
Message-Id: <1585879843-17731-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
References: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=756 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=807 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030014
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From
TEST_TOP="$TOP/tests/"
to
TEST_TOP="$TOP/tests"

Affected test cases are:
tests/clean-tests.sh
tests/cli-tests.sh
tests/convert-tests.sh
tests/fsck-tests.sh
tests/fuzz-tests.sh
tests/misc-tests.sh
tests/mkfs-tests.sh

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/clean-tests.sh   | 2 +-
 tests/cli-tests.sh     | 2 +-
 tests/convert-tests.sh | 2 +-
 tests/fsck-tests.sh    | 2 +-
 tests/fuzz-tests.sh    | 2 +-
 tests/misc-tests.sh    | 2 +-
 tests/mkfs-tests.sh    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/clean-tests.sh b/tests/clean-tests.sh
index eda16e329698..d8157ab54ee3 100755
--- a/tests/clean-tests.sh
+++ b/tests/clean-tests.sh
@@ -7,7 +7,7 @@ if [ -z "$TOP" ]; then
 	TOP=$(readlink -f "$SCRIPT_DIR/../")
 	if [ -f "$TOP/configure.ac" ]; then
 		# inside git
-		TEST_TOP="$TOP/tests/"
+		TEST_TOP="$TOP/tests"
 		INTERNAL_BIN="$TOP"
 	else
 		# external, defaults to system binaries
diff --git a/tests/cli-tests.sh b/tests/cli-tests.sh
index d302a93ea594..d8cd06724701 100755
--- a/tests/cli-tests.sh
+++ b/tests/cli-tests.sh
@@ -8,7 +8,7 @@ if [ -z "$TOP" ]; then
 	TOP=$(readlink -f "$SCRIPT_DIR/../")
 	if [ -f "$TOP/configure.ac" ]; then
 		# inside git
-		TEST_TOP="$TOP/tests/"
+		TEST_TOP="$TOP/tests"
 		INTERNAL_BIN="$TOP"
 	else
 		# external, defaults to system binaries
diff --git a/tests/convert-tests.sh b/tests/convert-tests.sh
index f6c940437eec..24b3ec0df144 100755
--- a/tests/convert-tests.sh
+++ b/tests/convert-tests.sh
@@ -9,7 +9,7 @@ if [ -z "$TOP" ]; then
 	TOP=$(readlink -f "$SCRIPT_DIR/../")
 	if [ -f "$TOP/configure.ac" ]; then
 		# inside git
-		TEST_TOP="$TOP/tests/"
+		TEST_TOP="$TOP/tests"
 		INTERNAL_BIN="$TOP"
 	else
 		# external, defaults to system binaries
diff --git a/tests/fsck-tests.sh b/tests/fsck-tests.sh
index 8fbc2b4bc40e..15e3d8d5995c 100755
--- a/tests/fsck-tests.sh
+++ b/tests/fsck-tests.sh
@@ -8,7 +8,7 @@ if [ -z "$TOP" ]; then
 	TOP=$(readlink -f "$SCRIPT_DIR/../")
 	if [ -f "$TOP/configure.ac" ]; then
 		# inside git
-		TEST_TOP="$TOP/tests/"
+		TEST_TOP="$TOP/tests"
 		INTERNAL_BIN="$TOP"
 	else
 		# external, defaults to system binaries
diff --git a/tests/fuzz-tests.sh b/tests/fuzz-tests.sh
index ae738710b8bc..0ba8f1e11f70 100755
--- a/tests/fuzz-tests.sh
+++ b/tests/fuzz-tests.sh
@@ -8,7 +8,7 @@ if [ -z "$TOP" ]; then
 	TOP=$(readlink -f "$SCRIPT_DIR/../")
 	if [ -f "$TOP/configure.ac" ]; then
 		# inside git
-		TEST_TOP="$TOP/tests/"
+		TEST_TOP="$TOP/tests"
 		INTERNAL_BIN="$TOP"
 	else
 		# external, defaults to system binaries
diff --git a/tests/misc-tests.sh b/tests/misc-tests.sh
index 3e7b9e9befe6..3b49ab012e78 100755
--- a/tests/misc-tests.sh
+++ b/tests/misc-tests.sh
@@ -8,7 +8,7 @@ if [ -z "$TOP" ]; then
 	TOP=$(readlink -f "$SCRIPT_DIR/../")
 	if [ -f "$TOP/configure.ac" ]; then
 		# inside git
-		TEST_TOP="$TOP/tests/"
+		TEST_TOP="$TOP/tests"
 		INTERNAL_BIN="$TOP"
 	else
 		# external, defaults to system binaries
diff --git a/tests/mkfs-tests.sh b/tests/mkfs-tests.sh
index e76a805b4f0b..150f094f2303 100755
--- a/tests/mkfs-tests.sh
+++ b/tests/mkfs-tests.sh
@@ -8,7 +8,7 @@ if [ -z "$TOP" ]; then
 	TOP=$(readlink -f "$SCRIPT_DIR/../")
 	if [ -f "$TOP/configure.ac" ]; then
 		# inside git
-		TEST_TOP="$TOP/tests/"
+		TEST_TOP="$TOP/tests"
 		INTERNAL_BIN="$TOP"
 	else
 		# external, defaults to system binaries
-- 
1.8.3.1

