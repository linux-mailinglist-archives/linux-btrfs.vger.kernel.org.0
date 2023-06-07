Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC6725B3A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbjFGKBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbjFGKBA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:01:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E602F19AA
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:00:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576Jp7I017112
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vNpbPoUwNyQ7QlidflUeNqzCM/+hMxid4pZUcx+RPrg=;
 b=35wyTJdR2L1uBm7N1SsJw7ZzBvdGv8H61Lhq8w1kpE1kXSVC4nQLIDL9bQ8xWiF4Yy6P
 L55SN9Ub0h4iVYXAe7pFbNKvkTaW4uipLpgvzCFWJtuzNpjwstXQr7YIWM16LMLXmWwp
 08KqqyDFlLzyX7U7uFCVYyrirYoSGZhpU8kVDK45WkpAzGZT+1Y4xhsD67RlrcYdFpty
 66+OqfAk8Wb0qpG7uVPY4YDLl6tV4Ukmp+yA4lgcO4hgHGsOnzV/0hpN800X1ElHHQlm
 6+/GGvfwq5pJKpH7fvibIJW9zJfxMM3hFRF4ThrciG/LxL3hqwwH8RQ6TBClUdyBscLE 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6phdjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579cKYZ002953
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6k1emc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duHjQ9tlMnujj6Rr5ZavQPDcg5oNWxHTraFVwMtQ7A0zKEBAdBWbdr5iT4LYnHRDfqjQVUtUtKfPvoOMqQdv7TrxaXamDNstCO8FQWkj4yP0EtiBCVi1yqthxRT82k0Q+mAn5NWmHiKNVmYkoBqNO52K3JEHd8wf+2qcJqEsM8PnMCcMQWXVBiJGh/FDy6zHSdSFzVAVucCoqxzxmu1NV9thvM8Y/T6vY5Z1wuqc6/wncTZPGwWhRzQxPCKPhBIPTK171xi7Jg7lYzzP3HEaomnWlBVP/6eSbAOSNx5Onjxn/IS6puCrAItacVrGqjCm6YweRMldQQjg37LewD/8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNpbPoUwNyQ7QlidflUeNqzCM/+hMxid4pZUcx+RPrg=;
 b=KB4jvv6Y6VGs+fTfcUAc8VR8DzCTeravEm6Jz8I3z7V9nW8ck5ux260I/jIKzJqTW/e8/PFd5QlWNC6A+wBSLvVrmOGHAoWVXZFDFBcToxVd3REVWUOGK2HknBWf5JJzw28zGAkg7hhCBLUHRSxlMwWIMHPHAajxj78j0QUq0HQnBVrPijk4EZ7xA5mwmwQluYEPaDJXfJu1lCWKkS0hf6Dss9AcFRgn3Zv5fVYOZYhrSe8OHxQEPi6pnsvDAlwQ9BGaT9KLrQ+qgr/+Z442OflVncGKTnkaZ0tqCTLvdHOQDTpWodrl07AmVQV36IVykLp69jcABTXFfMENJB+Kjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNpbPoUwNyQ7QlidflUeNqzCM/+hMxid4pZUcx+RPrg=;
 b=STIJaY0qiigRZhNzR1/WvoYUTlzVnwubr1q8Rpnyx+CQFYsSTW+zR6vrKgd9YEmkLbREApRXoHudozlbmp5ruBUAqPSPTkO6Rwsf+tguaNj8c61Cx8OqNxz/Qt3O0SVSFNyycmDRIwodqY8hCrf7tMCP8gNj6ihpuaRpH0iR+24=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:00:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:00:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 11/11] btrfs-progs: Documentation: update btrfstune --noscan option
Date:   Wed,  7 Jun 2023 17:59:16 +0800
Message-Id: <ed1bd8a87f632313c8781746b8621f1187419623.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2ed751-2211-454b-acf8-08db673e154a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOmAadAV7NR7M6s1NQM1Vupt48QVvIJlc0ztF+3ce0CrlTbTfoTTe+WiQ07H4pAoJNpHANm3zs9lj2Wz758IJAuolxMwb3NWgL8SsMBugXNOHc5Ekd3r9TTjX5l/Y8VGgUwhvP2BItHWrtGD6zZuwrY+X1J/gHvv+yHdfeSpZJnIxmDXcQI13mMqYO97/jpZE7lttj+pIYPyqwz6URb7GbMpBqN1Ua96wUmmusHC7lP4rQxpsV6oxJ9CZ6b7DlzDMzcJdvYAhp0NVJ5qApIMz86X9GdktJ2HBQq4WlYWDjk+0TZSxL6ZWZCs+C4xb8QlO5igvgwVgcr/z0dxe8pE2HKJ3fJ9EvP82OB4r5bZKqMkGFXfzFXjiDxnRkFDV7JnvH84ASW8p6KXiay1VWz/b2F08MX84VnLt3V9Vg5KOCBLTxn0bYxgZfo3Uxxe2O0Udcf0LKu+qAyYz/aPACl2zVUkt4zFPQWXoA4aA07R1qeQHZQuwu1BFxNrlUqf3LJ0Qpbr6/5Q0UlcsxIjyi2mHJCypHnj9K1QCsSeuHrp+SRX2m0SdOhMpi7SYqGW/tPC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(4744005)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(15650500001)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BRyZ/8YZ6Zwux2f0PwFhYQR3Pb3GTN9DPftS92c7nTvacGYoHbqyWvdCGUTi?=
 =?us-ascii?Q?S34zm9lP8iz2egiyOUH9d0ld3lL0ss4osaS1QZ1iHujaYGKNmhem5qJkdoTl?=
 =?us-ascii?Q?zldyg3GnGdOmqwyFfTrMY0/Sk1TZx+MMz9MlyeppoU9tpL1egXSz9Iv206kt?=
 =?us-ascii?Q?ccBaL/jICzVOZvdKkScRKmRubgYogWVFb/mkAl3e5aGdCrj7kclwnI5+1TFF?=
 =?us-ascii?Q?dBCBpDIIV2OHfXymEbai7cHemklO8US3l1FqN4uM7hqlI3bs7JJmrOx7q5/E?=
 =?us-ascii?Q?P/xdE8R3ma/nW1FcKg4qB128WoO2nR07JflMwEkZrrq0fipl7smRNf0pMTsK?=
 =?us-ascii?Q?E6BjC/CI0fHAcERP7cWDogoywdCiZh07gXbyix6TqZTP8dWIHHepq66fLwuV?=
 =?us-ascii?Q?f5+luJyvPO9Yn/JKi1BmGSzLEBlyyBa6fGeX075staGEPGzaFu8avR/zSowi?=
 =?us-ascii?Q?tbR4WSZbwGMPu2to0lHEI8DDMDX/6MW+/y68fGCIo2TQNXAldzCaoikgTknF?=
 =?us-ascii?Q?HYNNbHc52Wb1XGYTsucnEwHNQQwzgmnL3YclsXbpfy03Araqy6rGnciFV1NH?=
 =?us-ascii?Q?aDAu8WqX+eaAYtCQKHY8cgGai1R2TtdhjnMU27tZyd6WL56m+0KGxMI6NaZa?=
 =?us-ascii?Q?vIM4ko6XhVfFC1DnM1/xI5mE6ZG5clmwnhOhOPGdOE9F9wQE6M78U/sr/M3U?=
 =?us-ascii?Q?4EAhyvOT0Nz7w0W0y+TWtYfk4nbK+YFaqWPSRhlzyVVOPEuvKryvR8xWHc5D?=
 =?us-ascii?Q?1xrBt8Su5kr1CpkT55qyNv1D3qxzv2cH7d6cIyY/SpwauAU+iZ3BQ54J6uew?=
 =?us-ascii?Q?NiWfNlqjPfsrfCMf7LuerJO9W8dBw0EaOdA76e4GLK3bjFVoPuiv/lBh3Ien?=
 =?us-ascii?Q?uKlozp2iyLvZ+GlYDF+pej/S0L8oz8tUefWmHrRLU2zwTgkHTBaRSy0OCQhQ?=
 =?us-ascii?Q?/O5HzTmmnbnPD3KQcJ4r645Pbc1Y5tPmS25umAjpxeOC0AXChRQ+/bYjgJlJ?=
 =?us-ascii?Q?7pnQ5KPI3uGq7MqwUhc96Dqr/e6zkRQPW/4Q3bCsfbmHnLITlOPgbxxWC4bJ?=
 =?us-ascii?Q?1pkry2i2AFHOXBKN7Kk25IDRT+De0wnGvHYh085ZeGnFszyy6fkLEzfXE2ek?=
 =?us-ascii?Q?ST2WowdldYbPpMxFIhbKZj4bPgKzM5kXxKzbZc40uGuzIM3KjsRY9Jqtue1O?=
 =?us-ascii?Q?gJ3sjVdPidhc9m20X+gdba4UuNJk86HB6aCxL2hI1Pgdr75OAtPEXp04TfZh?=
 =?us-ascii?Q?VUg+P+/3qKM029HYj+lDwXZr4Rx1PIRC+/i9UU6gdzTAytGU4f795dQQMjXL?=
 =?us-ascii?Q?rbwwLgH+l8jdr7Z6BO/LxqFHh9/XoWkaxki5tOaEJ1l8MZO/Eivny7UBBk0Y?=
 =?us-ascii?Q?3W/fEQTTBtIPhttc07t4k/+LOhrWDyP55TBPoyGXl7BqqTsXFMS8bQBwDLGM?=
 =?us-ascii?Q?Ty+GAtLlDSeYMMdURj1qidvDAdQuy9l4dobsn9VdVdP1mS0GgGLKLoJUEuQN?=
 =?us-ascii?Q?3jgtNcYVN3A/9zmWil5wuTxQMDGDQ0yR5sNbvg86dNoknnON1Ty6uRyV/nXo?=
 =?us-ascii?Q?qMvqfpHcLUVMPuhF/5mwVCNE9f+OAduO9JNTwZu9ptcQ72bln5c9Yiad2eHW?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6IleMJkZlkHZvOK8qTt+JFxaLJXSABkDO2LgQB12jMXE4c63XCpEeWKgErwpQFwUseK9mSY+Gib1A/xRyd3R8YGz1V51CKPx8j1qaYIrL+Y32uvFvNDoD/d3RJywsXstXEBV+LghToMaqBpc5bWiDhgUIvxRgyoRNGngXZNdsXgJtYclTiykRpJxwNNgxBCvWpSWd5zza92XBz0Wd+KmpT6wqr/Rpa9MABCSdFZnPyNWupDvbv3BRGWieoLFNfcg2HX9P7X17+FVEZlTcQLSIJsPKPvTmcWTWl8yaO8PBV0jYJH7UybOdgRlPukRTRRNW7chiW3Sbvon4mkALowT8T0SMrDQDGAd3bIId//H61DvS4OTXUCACAX+lhb+CsSUDb0EtvwI6L89LvaTIi62J7zW3BlOTBJbK9rryjGkdh57lLqwVOUhZZ0k+vJ7gndJeu3bP5qF28amIHVZK2tdxXroTGHNNzo74q97wo36Q/gqx9z2CfDiMuMLq9jRbYQ8gU6L989zFTQF7N0nClw0pi9WARpV5FEqTeOsvLj4frpKkiQcdDWMiNT8k5eJb8+zhJFjxWbFD5caNM9lPMCfP7g+LjgoQf86XIiS8js5jBSXyecJKBVdqCFrhVytCCtfRnNQZioioLeUgwFuvqJDkb0CCCrLPlW32GDxRcMZL632BdZXIRPRfsUpS3PnWPAjFWqudUfeOGzZI5gPZ+/5nIA7v9Say64sezAFrBcZ2giCdjl6k/yEskTAt+M1E0exHrhIEJH6bjsK3+GltMlJWA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2ed751-2211-454b-acf8-08db673e154a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:00:54.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV+fCZH5c/k7awAnHRwxY8dcpp36EzCLGokBf0t50VA5poAugtVwy0n4XJxIQaoWQepkuQcuS/G78ClHtzykDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070081
X-Proofpoint-ORIG-GUID: pqeZq0626wRyVONtitFjGHFISAaZlm6N
X-Proofpoint-GUID: pqeZq0626wRyVONtitFjGHFISAaZlm6N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update the Documentation/btrsftune.rst to carry the new --noscan
option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/btrfstune.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
index fb643fb8d27a..4cc89de7359f 100644
--- a/Documentation/btrfstune.rst
+++ b/Documentation/btrfstune.rst
@@ -46,6 +46,10 @@ OPTIONS
         Allow dangerous changes, e.g. clear the seeding flag or change fsid.
         Make sure that you are aware of the dangers.
 
+--noscan
+        Do not automatically scan the system for other devices from the same
+        filesystem, only use the devices provided as the arguments.
+
 -m
         (since kernel: 5.0)
 
-- 
2.31.1

