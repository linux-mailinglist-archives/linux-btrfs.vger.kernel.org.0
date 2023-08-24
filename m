Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE8B78682A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 09:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjHXHOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 03:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbjHXHO1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 03:14:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F0FE4B
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 00:14:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NKwOhs027193
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 07:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=LdYX9weo6ruqGZ7qdNb0J3j69aXsh6ONnzRP0mGIcLw=;
 b=1xCKT67fxhkzvDaQRsj8JJs8+ywMHMEZCv43hDWvzoKnwrrOGD7zLokSgz30E0O0qQLI
 oIsi4tpAlnUmfAiNDeQAJu0YZcdDvQPAJSA1xXWcNLoSyWSS49jJ1xXVgQLZqQry+2vi
 94OGATB+uqTnaz0rwB2XloYa1JX7XyZZuFBrFph/Rv8dVXLCcKiQkPBrTlJBqvr7ADv3
 IE8d2itJgI3phNpsmVOTHEVa3PpkcDj9tuqO8p985lYf9GBM8hmFVf5nBsh3yXJrPIVy
 WMKvaKsTjO7TCkVydm1L3RXAmKlRwLXKfdQs3sQ5KoFpGA5Vwi2XCiu1XhqzxbwRuCnn 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yxke9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 07:14:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37O5GRYc033437
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 07:14:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yw3xkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 07:14:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6ojl+HLm5WwQ51r1X4wG5eyrq1zmVzomdJEJbcsQiIwSdzyqdGx/Vcr+ssCSX6Jy842V6pqZr+0QrqEe03vZNnXiSj+GsM3BGTxejKfTZOvhjoZR86gkuAI5OaTDmFoO4MI0tvkO1vRPIAg+CEHHJ8ZOxgIMOu0V3J30AKOmXOwnSKJcr1xHdj5ttC6S6XMuBRY3lJ7ay1fU/sBd88Y3xXYnBIl/OhoyVYoKCOW6dfpz687NwSWQfK78G57BkCZI8c4Wm8G5DAYo3nmTWihuidKKTMcKJx1kWU2e8GsBpeEBnmNO4WXhG2RptC+b2N7azE4GjoGVACcsNTnFwWzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdYX9weo6ruqGZ7qdNb0J3j69aXsh6ONnzRP0mGIcLw=;
 b=XWCBMCLVwgtouGKIZKIvSUBlxPRkoV5pm07C5uHGAhhPlwg+Lz5E1EyLJbFFy/nkpnSzF5A9jpV5yAPUJ3IGKGORBlVFhk9FRfzmcSdfcq9qg9SKX8F6uPFBtF5k5LT/d3gtJT3TcwKioQiDZfuHujJvL5yztJI/e4OEX/+pyCpY6Ef026osEiZA6CC4qNCVavPkE/SaUcpftOmoga9p2vadoiwGlj1MQHExzY4jNvp0EcDKx5iZyxHoGKSv++8szubhRsct4DbxzM04aiWOChDwtx8vevTmtol24j5XTSQDap8DnG9FNRP/SrfnOOdZ6UKyfUPZxbJBo5kGp52ksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdYX9weo6ruqGZ7qdNb0J3j69aXsh6ONnzRP0mGIcLw=;
 b=mnbUlcAiIn7LRHhYFqTsdL1f5Om9vfbmFYZ1y0SSaOmy35JLHvvyZKSbzGb95zDRVLgUmUHXwY+1s74Wtaj09vrPHo2cxpT5HyD+ZOMhWBqLOuu1r74jPn2zVlkGOw7TbETflykj4BqI+m7ufo8k2JsJ1OFGPyVvP5/dX1wq9lE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6104.namprd10.prod.outlook.com (2603:10b6:8:c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 07:14:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 07:14:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tests: misc-test prefix error messages
Date:   Thu, 24 Aug 2023 15:14:12 +0800
Message-Id: <baf62c9b8a2fb1410a80dbf023b14261e02692d2.1692861044.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 5103912d-7be4-4921-b0f5-08dba471bc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xe9VVsQG5XQon1Zr/7oZIMt6wF9K+cjIGj+8LGqKGkQgrE9OvVqXbPzync3p84TgcqtC//dbDexITuBsT5TDnhYtLdylVKCFOOEAGzhveIaTAGWWJJ+QvRnn+bQFtwO6G3QyUsiqQ8n05AL3iYzCRtMSMrKm6Q+5fzj2sb3Br0zGP4DMgGhU282up1Su0BlNzX+qJA/Ah4/U7i3NLdATY3H9uipqrzC+89lNCM1l1ksQoEIHdf00jsT9SQeNqKe7MvRQxP0iAeX80PVZWVtLHogVcnFQXpjNEnazQLyotts8YQbjatPFPmygpeZcdLIafs14i1g0EOfmH1gL0MQX7566U5GySAc4oXumTPnnvS+5FQdMOA+kRlHG2lK1u5ClPvdI5deulFEs5/BnSsKtdpntceUIPQcrkjZIPkkUWjc99LuHAe/VHr6apuKUHYnJnZwbEEGNcq5yc2m2Ob1ydRtbLGAlMFlYMSIDGo1k8tgABvucS3KoPwOZRoov6rojj+u0FeE+DA5MeODpmNl3tIk2GW6UV18z2ZH9i+RxsGY5gJlqpeHQ8TKCRGgzuPUK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(66946007)(66556008)(66476007)(316002)(6916009)(478600001)(26005)(44832011)(38100700002)(6666004)(41300700001)(86362001)(6486002)(2906002)(6506007)(6512007)(8676002)(8936002)(2616005)(5660300002)(83380400001)(15650500001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ROZ4HxZLqTGJp4vYzCZpUxjrn0GgMJueM3SlTRA9EC+NZkmn2CEWSzXD5Mw0?=
 =?us-ascii?Q?stge0D5yJPUP9ooZ4F9JYOOECknrhoQYc9y0sL9OU+lbtXtUy9u+GKM0ipgr?=
 =?us-ascii?Q?uL3ybEmKbsY6v9fCn/IUTT+C+bPRam0T0q1l0XyqocJGjTPc0jcFlEXRrITI?=
 =?us-ascii?Q?ZvcRBu7W6z+2fuq8IB373xcN9FRVjrdZcKPhk8Tw5TdKnyos7JF4sqNpYua7?=
 =?us-ascii?Q?CJl6RJCqefwYpU1AWq9yc9jvCcbqigvaL9+o5GMIiqCS+PaMQUhbf0O1MwOF?=
 =?us-ascii?Q?CixS6H7dwRhRrMKNlM6K4c+Dm6+wyxqppXFlcdUgmUJMUSoCof9I1Vb3XKjx?=
 =?us-ascii?Q?q833H1u4hKIu/RyHJI9BGtYWfhaNFWTVu0C+E0o2dlzlOUTyYJbCSfKcG6Kl?=
 =?us-ascii?Q?E0kitSmUNT9WEUBQH/PbariK1D7fzqKnTa+DuZLZ5dGYJmJaFeZ7ObrhfPFO?=
 =?us-ascii?Q?vO/FSgfFtE7KfQBpmfIp8Q0i2qA4iVn+oUbwSksTBG+ugDu6wnm0SC/FLzBN?=
 =?us-ascii?Q?A1k+nxtAdmHeW/fL1ptO0KOji2cmkh9XHahrEf5jkVGeP5F444+7E3zQfwf7?=
 =?us-ascii?Q?RzDThEU894vz1Oss1cVNs5DVlKYWROolx2rMFx4bwRz9BiD1S8QK8Nx5+F9v?=
 =?us-ascii?Q?oTatEgawUXbcO4579cB6NiwLGVZDDQwGvn08o7K2PfILH3+Qy0RmBd1+A8bk?=
 =?us-ascii?Q?B78U69OPRdKbbmBdd/ziQSvKipM2lEy+annre6NBXwwX0bgp3xkpyaGvKe4U?=
 =?us-ascii?Q?pNhorHR9K19d3fizWW/foooUfTVLOdm67vgmENmZVZHpnCARDWmYtEKm+u/o?=
 =?us-ascii?Q?mefD0KjkFkM+u87iiE7VFiVVHE+1zkLIuHPWgBJBygMuvbAeK6VX2hVJRxGm?=
 =?us-ascii?Q?COi1JmUeCvxUxczd2NEMskMGIWKtqQRUhFTgVQC2ogZe4qi2fnvTWtVhry3Q?=
 =?us-ascii?Q?KMHprBeFOc70VulJtLTmdVF6qqYuRX9RMoZNXW2q2Z1hb7bAMqxARPDXtJ9j?=
 =?us-ascii?Q?MZxHfi2H/W8GWcxDbfCeyTBJYZFbdWqOF0/Y6QhFmIjQBGTYOF6fHJsU8ufw?=
 =?us-ascii?Q?MA2k1ztSD2X3kGPQ9ufM25rTDCtNZYpRvyeNXvj30xajq8T+bAoVzkNiW28h?=
 =?us-ascii?Q?lyyZYGOw1wIFsnC+shjK4KWvIIBqtMz60yTUayq2zdH/ENKvKtOsRjTWI6sn?=
 =?us-ascii?Q?GHs0BKqt1XYonWynZzXcOZHRSKIVS6PZT/oUWGDlywZkYwjpKrRGAHFJuVFE?=
 =?us-ascii?Q?cSg+ZwGDy9T9lo2KnFx/LOVbOBzQPhJulzGRLz4OBJM6yGVOd0GrMwqDM/nf?=
 =?us-ascii?Q?7wPi9aiPCfAdvP5sZvvCKP8PzHNU9OUSCQAi0rWiiJPntFT2mHTBhVsp26LT?=
 =?us-ascii?Q?GmrWodY3RoynMIMep/IAE6Zr8E0P8MMrdIuc7RL9X86WySE/bHgU4N9hipD4?=
 =?us-ascii?Q?xiZ5yG+H14nflpaoGWSMcE8ki9zOZk3PbwRfVmro/okCwcI7g4JnBbtFbMKV?=
 =?us-ascii?Q?wwqZEcPq/XoxbuNTQngHwx4t6M0020QYris8HDjMY0fXTbfN3ehsbPK7Cs2X?=
 =?us-ascii?Q?oHMXf/U4ccm+UzGHWGvOCdbsRLQncohK/pIV73qV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3ColxgFoaCAyKCwy4YMotsL/LwXMQxdVJbm4iDTM8rF6OtgETx7UXfOKqeTpbrrIpuJAh9jwkPR+32b3IHNpVtj1maMheybaoRGR7NzY9ojqoUbWqTYYhUTPeakxiHhQ2gWEyr0EGY1WnbXjI30OkFBWYSgrJKfTZOhXuHG/44H5NYdo+0HOJCkCdJbCE8SC/FIwxFwmr/LimuQzk31k52X0ReNecBZ2amrgo111LUQxwnbZSHhxKofh5dThOpfDlCz+6qRdNYN4NMHV81drVFvbgvBF0BA4+bHllBTR/KlE805DUzCLWlFZfxbq5QyFZDvFEMi59SGjYXcSyhawOGZHAEVcf5aFHm4UupItRqhFfWykgCK9bvzDDspuSIRcTMxmy5POauuKwHfoDVMrRwcczPpkaK/ztE0jpSilao2M+tzb2IIIZSlhMuJAfA8gCSAPiCqvqr53ljqSLFKBTw6n12Hj2VdnaNn6XKVxGyBbnf1K40DqzHjjZg9Zw8R6IvwFt0PLKvfQM0G29zK2leQZZwz1rNjWEPey/1lx4Ao1CV4NB5GmBQGfU/G+oAstFEKu8EZcevIczQFoS1AGBYpelmhLdv2c+pmtziyIXSuDNp1R2PqUh1pIgYDl5v2yJfPfxs3VaByF90MPOEpcq1R/WaA//8UPQ7oh6wVlAG0Qmr5jxrjnQTnBKbsELj1ApY4ahsZoxn0TE9RH87i6hKpb00tKka5z1bTRSGZD58IiKb3yKhxXWp2AuVTcYB+xsnq8rgTmqWkzh4/sFUMtcw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5103912d-7be4-4921-b0f5-08dba471bc49
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 07:14:20.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uiPfqCn9pD42VeXWsy7OePlgs/ojour23KbE0zsnOQmTGxacbHjSEY0TslchWyW6XuZLYJ6VY1muNqrwqmz6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_03,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240058
X-Proofpoint-GUID: lxGkSmiDhN4P1XSXIfJQp10n-QdBWsNI
X-Proofpoint-ORIG-GUID: lxGkSmiDhN4P1XSXIfJQp10n-QdBWsNI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add appropriate prefix to the error messages for easier traceback.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 77a310d54f0f..88e468d96748 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -149,22 +149,22 @@ check_completed() {
 	# check that metadata uuid is indeed completed
 	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super \
 		"$1" | grep -q METADATA_UUID
-	[ $? -eq 0 ] || _fail "metadata_uuid not set on $1"
+	[ $? -eq 0 ] || _fail "check_completed: metadata_uuid not set on $1"
 
 	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super \
 		"$2" | grep -q METADATA_UUID
-	[ $? -eq 0 ] || _fail "metadata_uuid not set on $2"
+	[ $? -eq 0 ] || _fail "check_completed: metadata_uuid not set on $2"
 }
 
 check_flag_cleared() {
 	# Ensure METADATA_UUID is not set
 	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super \
 		"$1" | grep -q METADATA_UUID
-	[ $? -eq 1 ] || _fail "metadata_uuid not set on $1"
+	[ $? -eq 1 ] || _fail "check_flag_cleared: metadata_uuid not set on $1"
 
 	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super \
 		"$2" | grep -q METADATA_UUID
-	[ $? -eq 1 ] || _fail "metadata_uuid not set on $2"
+	[ $? -eq 1 ] || _fail "check_flag_cleared: metadata_uuid not set on $2"
 }
 
 check_multi_fsid_change() {
-- 
2.39.2

