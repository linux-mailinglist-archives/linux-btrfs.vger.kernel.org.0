Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97A13FD3ED
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbhIAGoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 02:44:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25082 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242283AbhIAGoS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 02:44:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1816CYed006754
        for <linux-btrfs@vger.kernel.org>; Wed, 1 Sep 2021 06:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=gEzVy6wxsZ80Cax9/a/oAUVa7W9hrnFrLtcdmqiXh6k=;
 b=iVvANqoZKheO/8jiNIChXqXTc/+o2lP5TMM0mTVkuaB8Z4zqyM9SbjGAiPzbFP02lDPm
 iWi199twYFCR01kJcKpszQHxgt+HfJrRRL+YTuBqCK/8JEzRB0wHwQj+aGJlWfejRTG3
 lgXSsTnULcAOMe6jlSAV63a5MLjuw4yIshTzpZlGfiJ6CfGnK2IdtduEyGTRmRWqOSD4
 T7DhaYZhaXOPWo3V4qqzcGni9/5rMlCZKYC9Rc9tib8nl3veAbAu6GRJLrVJKvRpS/YH
 Jz8k5W+c8bDinkFAsf8h7iEuM0P15rjccWdFOHyp9umHhYQt4A92qMnsCXI/xHgfNNS9 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2020-01-29;
 bh=gEzVy6wxsZ80Cax9/a/oAUVa7W9hrnFrLtcdmqiXh6k=;
 b=IblXa12OxC1uyBbyyy2q4eh1kffewwcEzcnldX2vur1Ya9zbG4PF2NiaE2RO6sWLXdew
 2vXCsVrHpNdioiB6FmyCahZ+sFJQQn0XgX0ktqrzz4V229lkCQsRaV1NCMgSmieeJOPB
 spU++VtWh6Kg3ayQus911N2itA46YPSdCv8EccyxA259ZSXfrdVNUuxJ5PJqOtL88Z1V
 /gwa4c9lKO3ltWUoFCX6Iwhd4r/GY0VCPDFcs7o3Vzx8UpYmevz3zrFt2sDIMJMN50Xw
 ClXf4H+VJuSjOzwjAy/KjIqJ0w+akg9aTeD35yGonqbqU2qfSwRACNFOLcmoyCEc+tVn 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asdn1unc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 06:43:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1816QOSu003005
        for <linux-btrfs@vger.kernel.org>; Wed, 1 Sep 2021 06:43:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 3arpf5vygt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 06:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiJKCNzDUSJ8m8W9HdCYXU8BMZ5VHrRt0X+eHXI6smCyLVeedQSNHQJklZRmsOAwWBXpqrPzH9oY+zELoQEtQjZNCf+V+bhpc338rk07qY3Bki4y44xwwTdV0JVsHLdZLqrdIw+mzb3TJE4yP9FFOe5E+1Sm7umvVdeI7UQtzhtAxT+MxjCbNJQqs6bUURzv1C8JCimPAgiNh8MwQvii9SKgGBQLLTTP8mjHi/G1UZrvAKNGPvsj1DH7xmbTJAiCShjcsuOZg7xXIhNF/JSObXgqga1PQsraQXoVuJRrcNUWVC5keeDafwCp9F8yOzrsVP2QGT/8YSd10Lk8b28kvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEzVy6wxsZ80Cax9/a/oAUVa7W9hrnFrLtcdmqiXh6k=;
 b=dGQ3sH8I2Ygy8TWqk/ioRCppKU4b1GvqMARskSxUSBqoAluumydK4dajKUTK/bdIp9PnxlxCRwsD8odWMORDqjh0/+YnG+B0qpoMi69pQcNTUCi/wMcDF9pZCtOrmVZHRrv7a/THc1uwG4ugE8RECYOTq9xAC3lll/lL92p4LNkmXOTHrqjPyVafOqfbgqpDwOqlqwd7LHsd2BZQLRX9XjU6ObUgYIzYVgjyyX0yfObl6DVR67L0xcETP2tJwpxghcYtu72lg5vM47s68Lgt0+oW+Z9fc2sG2HwJc2JAQ4bR7nH6xAwyrduaJfaoIM8+z6sXqXhPIXSfgND2MIUbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEzVy6wxsZ80Cax9/a/oAUVa7W9hrnFrLtcdmqiXh6k=;
 b=RSJKUCGKQw1hnLXoyq4z9LVUBlJkFmdYHS4qRi4dJ3Ct3pPMta04vHQboglTRrvWXM0KMFTyBcTcsX/S5cAciukWRxwp9XmTFlTAds6FFdd0cVPVGZd5ghVoBDMNvJViEJip+43QKE7asszbrygKQ97HZcUjvQxt5qLj6Ka5g9k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DM6PR10MB2795.namprd10.prod.outlook.com (2603:10b6:5:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 06:43:19 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 06:43:19 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: add comments for device counts in struct btrfs_fs_devices
Date:   Wed,  1 Sep 2021 14:43:02 +0800
Message-Id: <ff3ba4200470ccb75bb69c276511b0263246583c.1630478246.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630478246.git.anand.jain@oracle.com>
References: <cover.1630478246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To DM6PR10MB4123.namprd10.prod.outlook.com
 (2603:10b6:5:210::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0109.apcprd01.prod.exchangelabs.com (2603:1096:4:40::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 06:43:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0da7485-4b8a-432a-b39c-08d96d13c8c0
X-MS-TrafficTypeDiagnostic: DM6PR10MB2795:
X-Microsoft-Antispam-PRVS: <DM6PR10MB27957A974E386F63114CE473E5CD9@DM6PR10MB2795.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGI5dMADQlqIx5ziverGYMNMVup7JVUf69bxvazeUkI9V8jntej5x/KfP5dC3WpeyRvyqCnN+STQWe6aWC2RDynaicpA//8jk5cKkUenZuSNZj5O2z/d7d571xOCc6J/jRouKXlZviuVJ3X25P5gNVhJLp6UBxzFieHSpeEmATJUSaejqw6oIhXfDmesBziTrb/vMszqsJuXbCn7MHwnNRCjE1SCP3W9Emrmy4xQw16ZvmGhNvxe1R1hRftWyKkvjaP2u9FR7Cngu+dKhYTURsx1rclReY1u/of2L2vT1DUZpE86N10dHCdmQbmCdD2yWI8Wd5sTzvL4yU3V1iaNCnLz0dYMfz1uBM2woIvIhgkf9Hjnnp7t/c6aR/dDRUPJ7H13YtJHqdFgAy7WYSpEb2wj3gXuNWdaPTDud6j7chyJgnYP0y0FuFC38Ett+RVaNnhmuWCuCE7qZcPgldsqWqgSYGuSvImxgqioDCLMisu98gzn6dLvJnYnHpeA+AS/d41FDlciDq37k01IRHEL3t2p0Lwedwc/NEGCySE9n0DrIWiMlw0XxLICCLT93rzfzLC1Bb1bib3RcygVK5A/EsuPeP6Q2xe6YU/HX/y0W2X0PUhCs1WaPXY/k+B/BZRmnPiD3dQ3Fsw2oJPGv0i5YqfHtLO1WumBbQs3oM3DrNhf7oT9mlQt14676pYAt0C3gtMM4Hd/cRhq82Ez5D2VYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(66946007)(6512007)(26005)(186003)(316002)(86362001)(38100700002)(8676002)(66476007)(52116002)(6486002)(83380400001)(478600001)(38350700002)(36756003)(44832011)(2616005)(66556008)(8936002)(6666004)(6916009)(6506007)(5660300002)(956004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73O3PwJwiWy+IMjmhFZiaottCO5HqBRpUxGnO2qFD1EmuLpxUj0CWaSJFtHa?=
 =?us-ascii?Q?7GFvUDWCp8bYpw9vAEhk72NdNPtFyQy3rjk5kJJaREV/3l1Rhz0nRY8/4EaX?=
 =?us-ascii?Q?QKnEt55yXAVjF9R3mHIafKDiko7jQOIvMkpNlzneZ+L7DH+66mmmqJNjKFIP?=
 =?us-ascii?Q?FRK05Jon2QoZ/Avw+jo3RhEjmKFKTSNCbbxsoXrs/WnuwFlV+W8Pb0wiYoTk?=
 =?us-ascii?Q?lozguhCtuzsjbnYT+7nrCDQOh4l7cX4HOk1sznaQzFyIJNQWH8M45ArXCy4t?=
 =?us-ascii?Q?E7fffWfe+UBrG61mTnX4fWk1aUx7tHKagmMaocFi3eL9inpYOKinjkBZKeBt?=
 =?us-ascii?Q?MRjiYa3FTStg3rFXbadUl9RAddh2AeykKKbmravdsSrNLDUJB5/snKQIczFv?=
 =?us-ascii?Q?wGhl4CDKlgAC/jyL+43NylN+/jWZu/s+XfWhor+u7kLpDp6gi6GJsvTzhxTN?=
 =?us-ascii?Q?HwpiY6zvf9a66tRhOa/kbxqDGS2gwOsukzBbQqFaeuycAf0XKKlI4cR3FeYv?=
 =?us-ascii?Q?PCDuIVtjCGIQ8z8LXiYk97rigXP/mz7C49f3nA/icyETwaprDCOyYLs84Bce?=
 =?us-ascii?Q?sxszFAbgmssqDaJrFDV7mQGkbmZ3uGXNTIom4q/PxzbxdKWMBToOUt8j/0PL?=
 =?us-ascii?Q?C5j8Xt/uaPKhjlPmUS64GejVx1lbc1rSLzFBeuCMjXkq3y/U7huPM0/utB4f?=
 =?us-ascii?Q?yL+iUhYacW1D4gnWJ/COq1HLzeLoQGvDk+ELM9FZ8y2Rh070NJsIk80or+WN?=
 =?us-ascii?Q?qVIxZwh5P4dgjEjHW+gQvnmI7OMvd7hAzvlCFSvugzDTrqLK19yN0URxEAFu?=
 =?us-ascii?Q?koCIn+3E1BLg9tkJJjipzm8HLh8qq485k1Nbhr2ievbcnsl1HhTgS6vKdCav?=
 =?us-ascii?Q?Eoqy8O42m0tiTfrI50JkoqOzo/nPsJaiT6azyL/s4llkOzKt+KQg0rIX83t3?=
 =?us-ascii?Q?teHbpKlqiuCq5h2eyZ1vp5lN0gEPnTBrure9ueLAaYGsX1SK/UTDoQZnR8V9?=
 =?us-ascii?Q?Q8cCwKrklrCYFC8lK/vLOPazL/zUO1VS/8es6wEMeI51j2RUV3FJqK3ablmD?=
 =?us-ascii?Q?mm+2fMC06wiuhfmZdgpbGJwh4wAE+2f+fni6tq1+UWzDe/i2vTPJFW2ND91X?=
 =?us-ascii?Q?Ps6mtP/zem9giWR7/fIssg2ff16A0dNf3bnFVlPPeqjPVgPypDwD2dXEtNd3?=
 =?us-ascii?Q?B5/4iD/FWodk5Kqtm7SV1+Y0riE61MTUacp2q23SNJ8VjvUJoEyHHH9Saw3k?=
 =?us-ascii?Q?O7RPV3LFmQQ+iQxkRVkA3lkapgSksI6CvWmQIRPHKoqTRS1XAR/MRHSnNuck?=
 =?us-ascii?Q?qZ4wp8Bh3z4bRX8a9ZtwyqbX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0da7485-4b8a-432a-b39c-08d96d13c8c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 06:43:19.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqO5jPv2cjxd3r1Sg/Agpe8WV89AP1XtNTwXGar2h5SYrFPRpQWpeEGahP4BUcrQZwJ4CNwEynPdkA35FyqgOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010035
X-Proofpoint-ORIG-GUID: p4QPRYSMPLKkNpmqcbU2tCTKHoZgVlDe
X-Proofpoint-GUID: p4QPRYSMPLKkNpmqcbU2tCTKHoZgVlDe
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A bug was was checking a wrong device count before we delete the struct
btrfs_fs_devices in btrfs_rm_device(). To avoid future confusion and
easy reference add a comment about the various device counts that we have
in the struct btrfs_fs_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 150b4cd8f81f..32ff06d4cc17 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -236,11 +236,30 @@ struct btrfs_fs_devices {
 	bool fsid_change;
 	struct list_head fs_list;
 
+	/*
+	 * Number of devices under this fsid including missing and
+	 * replace-target device and excludes seed devices.
+	 */
 	u64 num_devices;
+
+	/*
+	 * The number of devices that successfully opened, including
+	 * replace-target, excludes seed devices.
+	 */
 	u64 open_devices;
+
+	/* The number of devices that are under the chunk allocation list. */
 	u64 rw_devices;
+
+	/* Count of missing devices under this fsid excluding seed device. */
 	u64 missing_devices;
 	u64 total_rw_bytes;
+
+	/*
+	 * Count of devices from btrfs_super_block::num_devices for this fsid,
+	 * which includes the seed device, excludes the transient replace-target
+	 * device.
+	 */
 	u64 total_devices;
 
 	/* Highest generation number of seen devices */
-- 
2.31.1

