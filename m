Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776FF76DB8A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjHBXaS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjHBXaN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:30:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B8E2685
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:30:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiNQe003683
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=Vl5B1Onc+xHpBkwht5UqtV11tAOpa5zbI7H9INHhedk=;
 b=qSPwhl4i1hD7d/DS88HNaSYjurRZDdKqW1SQt+gETgh9A6/JNacrV1Vs22NH0xWlGxm8
 xiI1wdg8YZtMAm+ycEAbXgidEcsogM0YIUt2WasEDbtMdJjxzCbNV1seQEootuBbRdHV
 tw514rJENKRpE4by9ks3gaz6UneV9VBU8kIXFRSkgoWxE4yXlNDk0sWp7JhQwa2CUSE2
 6yMJf330yuzNgLP9rHmPodNieWib/SNpCAOczA+wdVWnInRQaQ2Y58ThVgcyrvs6Vcub
 6hC453Jn5u041C5j2nYTi0IDSX3vHfXa+SPHZDw+dpEfPMuzTZcAY6trMetDDzLGaD6+ wA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav0egh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372MJ45F003887
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7emefg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQJdml3r/eCei/+GHVPYMtjZaenpFbhAdtzGxnEDxIeaFXTvqJd8dToBW83mDM3AXe5DRuwOrOaiDJeQF1u3HR9b3fQz5jNW9tc8D+KLk0PWIajy43b46jA19R7yrRJOH9dWUQi7pKX0CL/SsBA/DUnqiU7EnVSlyEsYIEFOAEdh0pLXoraxyJ90mPgsmrEllXmH0pCvGqC6IUJxT2gYaOCBvpTjOjskxHzAveYdNZUUsGX7zut4AQczEeWJrNylALn0YIahe5hrUGbWWXt8vf4vBeJHTBrg7nOVvAbj0QvSV+VxMzmee8crqX6IlzBBeMf47vjNd22n91P8FWhWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl5B1Onc+xHpBkwht5UqtV11tAOpa5zbI7H9INHhedk=;
 b=aiWxlk0tzkN9j1qq3436bjsQKvmCa4gBeNzh592PEo3WNzNpDxmdDqSLPZkgQe6t8NaEYPpyBvD4bKOW6dGrV4hawFQrRr46TRNDgL6fcxI42CxdEh9bE0t6QRhcPBR5QWGGtq9RHeEolEBuvaDEto6IczoAQTya1vYm8Ifx6T7qmkYbcEwlwgzgMsseZvxun+UW7xkpNDWj2YUi6q2K2IJxms7BM3/iO/ceIHHP7dg3OeaEVvgdCpIUPy/XkqrN1aKFWrhbAhoiQEORXr7f4/xn9a++Mx37T91xxazm4mz8GxIxKAooX5TkE5NiK0zN+UgmcG00+NMvV7uZ7Z84hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl5B1Onc+xHpBkwht5UqtV11tAOpa5zbI7H9INHhedk=;
 b=F3H1pCwdKJrqPv+LihMmOogFm6239pAwuluG8zLTtqVW6K9jcZE35eqAaJaIvx7wpcmjIAhybQzovRQzC844UGJlXOqdQ7mMYAp6K7jp2Y9UxJckydfck+WgqnN+rPEAyWahN71Hfp1rXj1xB7SYdwcqRNI4eRRW59IWK3Q8Gqg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:30:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:30:08 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/10] btrfs-progs: tests: return metadata_uuid or fsid as per METADATA_UUID flag
Date:   Thu,  3 Aug 2023 07:29:38 +0800
Message-Id: <9a4daea1034aa907ed8f810066e29770b782ef82.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 2334d958-ecb8-477f-7acd-08db93b068bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r776mDomlAOERCCrUXi00dv+YInYLeu5VF2QAc0LOoVxM5NI50CgbCPJCwyRmJqXo60gYKPC8KgeK+KmAhRhGIYJ9e2sIw1UPow1/IGpcgvEQx3YONU+eemjx0GoG/BoCz7DlufY7hQJczVa8PW0HBdUJeKRkByeDZ5HGJt1OpYcxu8+0yrOvHDxK7scDp4RCb7cP6HHYRZbwb8+NenfM4djMWvtqKEMgU5JXfiMj4tyYNsrAo2cyQzEu/m53KVbPb1BLs/F/lmqcK6X0XIXmquuaBU3i1X8ZyLKeMnHmAmg5ViYQRKC9pD/C8U+bpFthzpkio1IY50nLdvdqSyzLgD+OdOcjtoFdXsLHQXfdQlyoqzlIjqTh6BBV0rpcXl89XNsIRSy7j9sq4/DMRHynrlVTXjMzm+Vg2xnIAA8C6c3w+TKD8ZxPH416vPnlVL0b+9gr21SjCUm0qvfA52JazfwsNYzpkqd3ovaV+uWI+o7Ky08yNFCPXp7/HqJK2dsHnlivYxiw1VUba52sm1bi7u0C39gVHMkx8dpsgnlqPdfHT7u8cmVXXY88jHExNhz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jIB2kQIn97eHGkNe1SX0YwXYay3aXnoVnDeTWVud0MBhKEssrDRhLsz4UkYq?=
 =?us-ascii?Q?QNxVT38YDFo7zSRoHcItYOpwcZQk3n0nAwLRWisW/p+1dFZTRUGvzwG+d7JA?=
 =?us-ascii?Q?o783U5NXvpDoQG4BRukRQeqFJzK3cqLOAcZvLQo2UBnngR2qqq3RqJBo1GGv?=
 =?us-ascii?Q?2G/+x4Q2yaPJQ2c4eI2t4E5gHyXtwyn96AkvsnknIK2mZu1qfBLseh2PPenj?=
 =?us-ascii?Q?KmNpR4AYdqZN/zF+xgS+L74wzPtvNA2ongdp0vWXw69nMjljfwH+6G7qv5HB?=
 =?us-ascii?Q?vUxUg0NLXTo4wwDwvbQfAzMB2q8orXKxW5KAWxfCCEmMqBVMzTX22EV4ILRY?=
 =?us-ascii?Q?KL4LgPgbEmaferaJmGmJnS7k2tH8UmjwO591mf2XsmRlTKb1LbzzYi4nSxuU?=
 =?us-ascii?Q?oDUGrmGTrfdZfbdOj28RZKacfPIfTm8vTs0iylWkCJmXvr4xp/hxsRtHt2aB?=
 =?us-ascii?Q?CbXoMCUkA3faguPxgqhplLNdvG6ZKF5iklvWq+SbOzEzgMGWhQeKAhxaUxmi?=
 =?us-ascii?Q?oCky8tmF4ucczcWskvdqrvL8/Dni3qvXmKS0Jq7D4TADATsY1WVbmWx1QukN?=
 =?us-ascii?Q?47ckpP2CcuJ9ahLf7gwlevoO7Z21y0XgQDCDsw2mkqdcKy0bb5LtU4pq3Ndk?=
 =?us-ascii?Q?2tkSMCHaCw/6KrepfLCnXWvXWxkBXbgAItA9CCWXwG3ReO+IL3pTFqRTQkF6?=
 =?us-ascii?Q?bZBPfE7+/MnkGzGREgPijcwoGcnkpLxyPp0slzAyZ6OAb4ViiYYbI2UR5pMS?=
 =?us-ascii?Q?ZBP+CeeZYFV7Pl6g7dDdSBao306oy/bL+szJeuF0TCqS7hGWNPgWkiQNMyya?=
 =?us-ascii?Q?nljiPpwnKkFy2W0KOnyeGBVcjni0uwQ34R0yyyZMZzULjomf+khMA+IslQge?=
 =?us-ascii?Q?dtXnWBe5ao2KBUwOn9dbeAaEgBaD+I5nGTlYKliYADBuOb9yC9gLstzAM1Sn?=
 =?us-ascii?Q?S1m/jGGDGl6dXqviFagEbWFUhXjcuP7/kc3dJ+nziwQBwSMnhRBEPR898KSx?=
 =?us-ascii?Q?jCM7T+nvjSmmibv/WYXRvYNWc1wyXtarom4FhhCIamkBLmhcZ/Bv1L7U8k1c?=
 =?us-ascii?Q?EckzOgMHRv4oJVlF3AnVVZA3GkRaRMtt/hw9P1Q2EDvyB5iVZ1WbhNM/kgQL?=
 =?us-ascii?Q?CSTpLa9ycikRQlHUZsrSUpn2qFRLtF0bvDp5G4ocjZWA+MUjKf6TxSbLpwor?=
 =?us-ascii?Q?+XGx01nSl+FjyFRNBcjspV/JdTZ7J06cRVsUPtpUq00Mo3VVGnOjhTDuwM3Z?=
 =?us-ascii?Q?YT65CxXaYF4oQISqIQzrPA854aiYclIHajTp5u72RHPayyLt/L9Q5JW8MkOT?=
 =?us-ascii?Q?5xo+qywN/n7HgyCA+3NMtkrYjUTl+Dz3vTYMUwocyxUmGGrBnRB0oqaaB2dA?=
 =?us-ascii?Q?VR7qGlIeccUzVHf5evlm2uDwone2Y1UhZwoyDKwS4v8PbU7fU8Sw/RlF9Uos?=
 =?us-ascii?Q?tVhk90it4gbGy5e2LUfKLUFBLBWPtjSgdAKNz6WH4gc79rBapdWv9+nlKFxh?=
 =?us-ascii?Q?O0Xgub3/l46cJLM5yiJkLUf4KYSoydmTbqhL86DbnBK9yniO7OXeE6oOnlwX?=
 =?us-ascii?Q?eUjW8d8LRezvdc1flP7TL0UYXsJLQ1ALZvP2ybqQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ImtxMtL+mtyYKwkUpTEXIaf29EZGIj67quJAqEyl1kPxRP6nBiIjRET5xhf+Yufeh5gIwHdt44ta8x0Gh/hK6si67L6im0MPpP83GA0ciLLG4RtfBr2zc6CT8b6eZub/YCJNZTPaIXEy6utGW5BaQgAXu8IsIhiGh0Z/g5nFRn8yZU6PXtm6apCJ5Un5Mq8Q7libu//8G7F8mBB/cbmOUY9+4zNQ/HlCh8qo2bg1hHjAZWeYjYBZDCOqkmU+svwEYdtyXC6DLgNu4KdnlEE/6gmlrlxMc5HA5j28767BFFIeBQq9xa195EvBqOoKFV3luAm3y0UmkNl5dZ8CJGy1lBEwGjM3emGrUdG2q7YzyL3/s+2xeyAsPvJmZD9LelcBRtUAZwmTw/xCy4Wh5WO/ozucUvwLPZeVPMYIMyRiwhnREZkM9najMqnVtSz5pt7yCURZWANHUcNxeDYi/uDDSlN9FRkrAAtTkzF0oCdxUCO1DOAk6nS8EzP6EJA+denOGZDFvcJ4yex5HATe81F81OiBQBAU1Ubo0FQGmJPOX7HD18AegWOiu06O2B0+vvE7ea3euCyP5vjb9Qck2019ccZeiU8XmFE9PeGWuyd3ADIk8O2LLeYpN4ORw2dhPpLkOQ14uWBZNZQLlgdsaWhy0RyTi+ueQIDPcsOU8TD3ouPRFpQ6rDFWXMhdMHyWA2KC+//GhewZUC+zRanm2N6fk7+z9pnW4ywxxF6axyEzciMiNYFDkFkbwIwgmgVpvchT72JE0B/JsSeoWO7Fg+EypA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2334d958-ecb8-477f-7acd-08db93b068bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:30:08.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrB6EgA0yN5Sg4vmXYjSKm3WDGMiyruF/K0jIzHZynHK+MQLCY9SYcP/9MqlYEyx4asYOhT3lGr7U16IQeFXYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020208
X-Proofpoint-ORIG-GUID: nv3R1NmbvnWmckkT1mES_t05JJJWLvhg
X-Proofpoint-GUID: nv3R1NmbvnWmckkT1mES_t05JJJWLvhg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
index 88e468d96748..ab1e24637d1a 100755
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
2.38.1

