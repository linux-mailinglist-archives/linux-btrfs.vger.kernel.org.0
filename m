Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1292760CE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjGYIZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 04:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjGYIZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 04:25:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED258E66
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 01:25:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7p13P001009
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=xiyXID3pMRS0zzPU2HVLSZoz7tYUrMLZRLHbkEN5Gok=;
 b=z6DYBsPRdE8U7AtZ8pvjjn+RFNfoVE+12yy4oDj4AujhO0b+UVCYW208Kyun1I7AZ2fg
 HD9zViTJulhePOtypVYbULu5+HBgfMvZHZGvfigd2hrMJMZ5yPaGGVpaaGIOfbH28L1O
 vxKbjVC1kRosj4rpVYTWdWV0qMRlY2EZrF+SL8YI3yZBA5bIZgc4XDNJedvomGF2amgM
 5pmopgXP8JzP6ItNLn/S+CX7bj0QqN63YshpgUI4XbElAttKRF3JKe4AFs/RjLWpUuSH
 ubAq0C/YCp/huJvsJohLGkE65uyg3TC/aDprmln1AAYDr21UGU0VbhMMpBYAXDMWjqCy 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05hdvh9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36P8FZHP000345
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4xv8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef0GR1bNTkn822mX2/kv20y43aQAIGZ8gwJq5gDgLyYOVYqcY9YzEx0Vzb4q75IbFU78UvQ/BC51pa+wuPblcsYRT6C5OCHy7ZYuKeXsvHgl/xS5Cm0Yrn/P2/JqAgMVbDCN5mE8nuZhXY81zwMj0o+SzNOgvJrA2nR0uiTkw3/qZIoEBxbZkVq/bTGP8KxyX++alcytbE8OZZaKf5lm+N/6lwXqNXtm/+sIOGJci+yRFTiVpDzkni/b1EdknBnzjlux0iE7THKRMaErm+H/hIOknvznXwPBH7oAgXze25qPXFBcODd+s/l9z9JB0QWrLxKvKK/73kQ8CRH9wWijPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiyXID3pMRS0zzPU2HVLSZoz7tYUrMLZRLHbkEN5Gok=;
 b=F6SHiwzkCq0hndNv6P8/ijsnDWPx4BgDlkC9DJSEjMwkhdHjgYThnxDAzazWgLG9PDQ/OXWyATl/tkEt5heMNW7MlJVZshOscpVNJJ91LpACAt2KtHJOVGF8t9877fhB5CHiD9uRqfwQFq6KG2mK8+b4GXLI4vIP9CakSMbCijzOBgQVGD1YNqxAkYiSpFt4Slo4F0wuxXwDxi3x4hcuv8itO6hVSMd4azcp6gjQY+m2/obzTnNozqCMrTTWUv/LxqwGTzYkFyLruvIvjhSPWgEP4vBasx9HcC4VKJBZf8KOJmX3DTfwHwln7Z+uhNMVGtaTvUxKlEvM8Xsi/8nSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiyXID3pMRS0zzPU2HVLSZoz7tYUrMLZRLHbkEN5Gok=;
 b=bUZZwVzP3Q7l3hXIIkAnZoQPjkX3LngtZXrj2Tx6mKv2JIxZDq5M/lkJRH3qqaNqjGssaRfLGuPRPND7adbBNPSTNoxvt8nQ5HcNFkNnUcQqJsW0AZbeyQIGU4oeyfEacVXR3fQL7YIhgNjt36OX6emHOwMQAx0oBgxMuOJKYSg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 08:25:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 08:25:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests: return metadata_uuid or fsid as per METADATA_UUID flag
Date:   Tue, 25 Jul 2023 16:24:14 +0800
Message-Id: <30c59990140b572b0336effd2ae1902c7e07ffa8.1689841911.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1689841911.git.anand.jain@oracle.com>
References: <cover.1689841911.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bae2ded-506c-4e36-eec1-08db8ce8b4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WrZ9qvVnijVV1pWUY/2/JZAK7Dijrx7ZBgiPGi30pVSNh/Vq+xDQQiIdnq66q03DtuChzIZjepL99lU6TkU60isjXx3uqCqiAO0rlFZwEy/K15Q9YjWQAiIhmCMYfySDglK2g3XBggqKvMWve/R7ab7zO6ykC9zwRYWYHi5a8ql63uS1S4ZD1ASWDSvADzYZkDx2Y/SZy8BjZ74n3NH3J5oe+9T95QiCT/xrURZ56Z/Z6+sX5kC8l3ZWXwtYlxxDACNpR7LBZeTCeloe0ZUp7LE6dD0crJtx2ZOaJ1DE1/AFObhEbHXcRjNItKVSP9qdhiSrxB4oW3Aso739EhisEa6sIIWMp01gqsNPqQ106DuMgeaDl8TkPAmSi+89Pbyfte5ZBsKGTsKkYZWD50KHI5lu2urtmAmV4XPHjk/Yu0/puR5CwTUiL0uKqpw8qcU/UbrmPYh8hzs1xc67qHPEDcI7aPN/Lzm0yq6zl5BoFIUTKl/qNRGB8YVrMAQ72NOAJCEnouBdgUNOkAy3lwPkryYX6ReBoSm+8IXnFsk73+NMt9zoUK3NDjQK7/bH/u1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(5660300002)(8676002)(44832011)(8936002)(316002)(41300700001)(2906002)(478600001)(6512007)(6486002)(6666004)(26005)(6506007)(186003)(2616005)(66556008)(66476007)(66946007)(6916009)(38100700002)(83380400001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WqBpdOV9Ylet71CCCtlE6SItBDaSFw81+e/O5J4BUrsqChVrUDiVkqdTLSZT?=
 =?us-ascii?Q?9hzg4jMUmQdUlv8stRuzmbC1yj1c1YvhJBqDNBluQncHHCMLyQJn+696aBSr?=
 =?us-ascii?Q?BZBssDimBqAKvLB4iE4r07KINrHSd1DuJEFZvarZvx3RocJy+9Q0/o71+p5F?=
 =?us-ascii?Q?eg1R6VVvfwcDkMq/YIG1KYBT76rFHeyJpSMtRw/R8yfqE2wyOecLw3lRNfY5?=
 =?us-ascii?Q?qeYqwVfXYd2fZNRnQq24odzhh2lwQbYjepeU/8GwPU+oZtSDrPVJwhjeyjmT?=
 =?us-ascii?Q?6aS8Y7iKbSpevHXvP+sVatSdAJ4zbHcrbzROQqkBlG7iiq9DstuNObYgvso3?=
 =?us-ascii?Q?X5zhTmIW07linwcGeQUEjWHtDPSxnowgcfEgkbjv7ng8wJzTD6ldC4OviEEg?=
 =?us-ascii?Q?d7zW5yenNrnk+k8Q0txi+HeBv4lUaqLPeCUTqwVd0Nw5ArTR9zZrWLpb/ePe?=
 =?us-ascii?Q?ENVXrtXGQtmUD7mdxwN1GA32KMjSn+qbBdqLQ//KhgA95WK2buPQMecUFhaJ?=
 =?us-ascii?Q?3rphNV/HQI35ySeh0HMQm7Y3EDdOBatCpoBSSBdtFLNyE1Qv/NIk8QlEd/ZY?=
 =?us-ascii?Q?cxvQywWdaeb0cg+M2zzeRYCKbEU0L/MiA1uvZNh1uf9C3It+Fe+7keaHrYeD?=
 =?us-ascii?Q?WhGIzCzCGz4JHQEELdeh1doC/RCZXIkldJwL4of9laR201snLxQ/I/TKrzjL?=
 =?us-ascii?Q?eKlO8sInkNap+LpYFeQIQlaUeCpv/J48WWhtTIbEE5ycH22tgcWs70k/DyOd?=
 =?us-ascii?Q?9IVq9s4nQQFWAcHY9GpJnqO60vLNpB3N5L6r8yswZINmv1ABDPWj/xiV9zly?=
 =?us-ascii?Q?Gx07fYWpCAKrA75Sej7lEPJsqdOApZA7MUTYucvDUBZmgLwM0YXHK+b3ZmUe?=
 =?us-ascii?Q?QmXUtj7DFrDJ4EGU82OuglgvOAys+MaY7psULo6Zj7u1Bo+CcJsD2ZAdJHWL?=
 =?us-ascii?Q?CjgPLTRporRram4fFzeFb2fsQKiG/4HgbgM8C35SvTuXomkodE0HWAD+NWZb?=
 =?us-ascii?Q?ea4he40fu7bmjtMyQ35gdesyx1nW8yBJwsh4F/RW1vH/02c/IrypUVHKDQJV?=
 =?us-ascii?Q?88Dd8/lWVZLqBKlGKO2vERFS8tHnMHog9y5mGKSRufDRNf6vV5DmZzWAwAH3?=
 =?us-ascii?Q?Xo3uAVsf0tNz4DBkzsPJ/3AGbYKpQVec+NyB+cP4RJtcR18kNMSYNp5RHDjU?=
 =?us-ascii?Q?sUeXZOZJEkeLL6I5Q1k8sP8uGz6nLgvr5BssfolIZ4ljxd9MX1qr5yCgMpGm?=
 =?us-ascii?Q?g85Aa2vdxMcJSK1nhB7QprF8qZi27V96tuxFSsfVDobSwUgQyRk8rUrjE+55?=
 =?us-ascii?Q?f2KDFi3v+z7T/LSGpjjeDiLENbRVR5bVobp7jH0m3FNtjUUviMSz19R1uX9F?=
 =?us-ascii?Q?O7xz3OIjfRpNQwVpu+pEXIGJC1JZcX5me0QURozhSas9egCGcZy4tb9HCfCR?=
 =?us-ascii?Q?APpjlKoVseOu7nRO1DrY1zfMkO8eJoYufMnPwkHXBXQID7GH3CE7PHEky+NI?=
 =?us-ascii?Q?AOpVRvdNurPVRRLZlC/djYK3hn2fH814/pgHKD8HJ9Ncr0CVTeAvP+O/gyXe?=
 =?us-ascii?Q?tYW9CvUY6ZDZ2x8CMmc2Uo72Ov5UVCBEon4buDQY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mbfb39HHDuvy0DHBrm6tgK42zX0NEVJpiDY8zjh/kAN/9R3Me65ONQ4qFVWgeLL3bBdHnmLRax2rz/QPfq/5KsIyPClICrP2N8pzZsbbkMGtfc3QBD7EOKR5kqk/FDmZ8alO7hxM7+ZLSthk2yh4okwb6ILUluVmooxX9VIiWAebaGQc0c9RuhzCabwwjBZ0720Bho4zjdTgvXE3zwcM+N3juXNK7D4YIkKFlP03j2xzHA12+R0vEMlj53XZtwFnAaCWowmoBt7u2pSv1XaxGPj7c0bp/4k8BR9hUgP0TfZjdyI236IyRJD+BURT+DnvPnTUc3LWzAwBWRSoVEP88yBdHHPtMB6O5K+pA8BgKaaVb4dPhWffFnnEy3f4bJcCTeaGQy4W8Icy/zu2S8p58dxnImFS4DTrwqzSaW59JHf5RkQ9Ws1TfiuTNPhfSt4vvKcqv+cX3K4eiF1aEcuCa7dWNpDQlUwsMbHxTFC7jrZ5ZEINdaoQE1kyyXJuia1jCGL+ko5vh/7kOM31pO032hGUquRtXhW1Nv/evglx9g15HHzOslsJ0N+iF+VTya76odQ0getMVMMnfpNskoYhWWf6nYbR5hD2uz62+KfpBq/fi02C9XtS5lYrQu/fyvegK2irNQFfGQJCTXBlvXB1yDamlm+XSjNO9Lxkb767/i1ixMpNJJwm0qlMaSEQJWxcv4vfVDc0jgo7tWXK9XrUsn3vas3VLQv6vKvcbx0Ary9aLT7GhFnYeZezgdSBQDu7kJ4RqxSaZvEmMLqNeuPRRA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bae2ded-506c-4e36-eec1-08db8ce8b4b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 08:25:29.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oImmZhqTs4hHKE8tgZWsRD7s8aKObtBIbC+8aqgPqxK5Rstch4OyCgn9orSaRA5UkHT8fU6KdNKrkcBloPZ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250073
X-Proofpoint-ORIG-GUID: giYwqyOK06eOcU3J0kw7j2yxN-deLXSP
X-Proofpoint-GUID: giYwqyOK06eOcU3J0kw7j2yxN-deLXSP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit
  btrfs-progs: dump-super print actual metadata_uuid value

fixed the value of the super_block::metadata_uuid to be printed as it
is, without tweaking it depending on the METADATA_UUID flag.

Apply similar counter tweak in the common helper functions used to read
the metadata_uuid so that test-cases still be successful.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 24 +++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 77a310d54f0f..dba31db90368 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -15,6 +15,19 @@ if [ ! -f /sys/fs/btrfs/features/metadata_uuid ] ; then
 	_not_run "METADATA_UUID feature not supported"
 fi
 
+has_metadata_uuid_flag() {
+	local dev="$1"
+
+	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal \
+		dump-super "$dev" | egrep -q METADATA_UUID
+
+	if [ $? -eq 0 ]; then
+		echo true
+	else
+		echo false
+	fi
+}
+
 read_fsid() {
 	local dev="$1"
 
@@ -24,9 +37,14 @@ read_fsid() {
 
 read_metadata_uuid() {
 	local dev="$1"
-
-	echo $(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal \
-		dump-super "$dev" | awk '/metadata_uuid/ {print $2}')
+	local flag=$(has_metadata_uuid_flag $dev)
+
+	if [ "$flag" == "true" ]; then
+		echo $(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal \
+			dump-super "$dev" | awk '/metadata_uuid/ {print $2}')
+	else
+		read_fsid $dev
+	fi
 }
 
 check_btrfstune() {
-- 
2.39.3

