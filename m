Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB4F74B4B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjGGPyI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGGPyG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:54:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982AEFB
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:54:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FmOxN031722
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=HJIjOH4vuS045OLeLpWkdThOKe84CYoagufVT81yXR4=;
 b=zUvO0TLcryqWzaqkwnCXaksFP7YOJho+Zf/FfwvsvftUPzXTpX0xHYZ7igKmR+W226YX
 +SzWdJCA+b/bXr/hT6FsZkaVAbrQDVLTnz44QPfuFd3b3zFl5VLC7E/7xtiYn2YQpRWS
 hUv4M9uM12dGIVheML/CZFrUp6dGcI1D70RMpdRzvLei5yYqqEshN22MsTK1EB8dxHsg
 WyJANKAO7ourKoXkt/hdks4cBbpXZW1etrLcl+hBBqEqt1qUmhquVnxtDbxPuN9cs4A4
 EaHfgOAfdcFf0wAUVYYMH4/J+x4EKEGovowP4z2CAQ2BUXCghd7JmZXf1XFee37LXvnv cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpb4xh72e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:54:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FKN5G007264
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:54:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakekdec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9WXuc60T4B4xzORlHfMv3FnbtdCl5uyVd45WJKqI55F741UslB4f524l+C/Ra1GiIk1kqZNVVTavU4pLiiV4iVlfMTil28By5TSU6m65u9Dyac3S32pzTMrZqgWQVN4KJW3GE7Crl2Z3rmGI9zEmVCTuqx1l9dO0lE6+KYLPerUk8LGa1djYsox2EJ8c9eWYOYqyeZvy2+tjYaPiNg2myPqw46vgNivWcSeZNXsehS1sZNfL37nHMmIfdYNwZor08pY0nLMR3+2aUi9dTRyFOiCijwBDRCJKAF2O5v/UjUugQ6CSIrYMZY8wI8W4Pav7vBO5Q97YHPtQiqnzSoL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJIjOH4vuS045OLeLpWkdThOKe84CYoagufVT81yXR4=;
 b=n8OQojVXJszLeeSorrL44x/3mugX3vPUc5Lj4UdgZiIyRC/xbmFti8ZYMhlDtWxDLTTAUCMvZY/pWvsYVckci4t5ew516+cpQ9QRLm/E75VIrd8vXfbIULOHHcR7BDPsYhewQSH9DkmT0iU5oZTMV+JCMFycQckGmAA1e0zmZfKnEVj3g8kJmqS3uqvEAjqOajQbuDMMa/ePRtzVr4Myxy/+YgdBBjwR9r78NQglANzfF/0YxHmrR09h08+DDyixBKCZSbr0pWy6B5P0lGV/52wUb+tiNil46xoib7ohgp1IGUBcTZIl0ql2HdgTJVvNaChsUpH3h0BbzdAC9uTqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJIjOH4vuS045OLeLpWkdThOKe84CYoagufVT81yXR4=;
 b=YcjFeidmUYtjmh+6znASO3n4VVMR71AfxzjbiRo25rY4ITJ0Fpkutwt+4OGy6RECfap+H1Rin6d0AVLwLba64GWtJCqQr2WuzPksOcnVN6L44FewEypHSNhLP/pfPsvjR2vZnXa3NlsyGb2GtBfAQIFjLBzSuqswJhL5ESSTskI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:54:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:54:01 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs-progs: add helper to reunite devices with same metadata_uuid
Date:   Fri,  7 Jul 2023 23:52:40 +0800
Message-Id: <c6bcdb95195fd91c8250a9d2240bc05d298615db.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: ce287f82-588e-457e-aa7a-08db7f0261e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPk1FLscp+qoatw0RkxjdhAIZoggyL4tHtfAN7+6k4RMmAgpQ9MXl4oEGNyn0cx6J/470mNKhB8E1yqD9lNEJnMea4P2RgUKlHeULN1JcCeNn0+6GBB72rrNHCKgkGgdOez7Y6cYtR7h1iRi9so00KfKg/4+l/5a8YEv6fAIKpSTbDZ30OuVkKlxebLGVLPMx3ZO2VpTkccERFTqK7Sw1jPX0tBNjlhQV5D8PyrcYxxL1cSPuzVXBCGgK9gltzL/5yiHrV9v6UGuf2tm9Xv2UYkqaz6TxfiODTCAeEkgYVdQUonLFK1+q39UWmwn8e52Ycd+4Z6Z7Jkq/vIjYJF8iFRerlQWG+2mtPF3Avpwbdl+hv4AVhdvrNNSHsx5FcDv3uWAAIldilfyL/NSKsxtMOEnCd07bzZ2Xn5uRYvYXmFUshGsHVDmcCe09KIXQQjYjlKEuS2vq+C4XqaftGk8pjCueVOt2YIaRrnkwijziinTJ1menE8xgB0YCaX6XmfP9mA9wq6SKTM+dHDMxvxG29qBiWz67Dw4KIL6w5ESgTXfoV+G3fQjpPxeUYBdfqQm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(8936002)(83380400001)(2616005)(2906002)(6916009)(66476007)(66556008)(66946007)(6666004)(6486002)(478600001)(8676002)(5660300002)(26005)(6512007)(186003)(44832011)(6506007)(41300700001)(38100700002)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6UvdWi+zbjKeudEBLmASIqgLbQF0VVmyi72NyKa/Z39AMo+xzvDIG0fQzh1b?=
 =?us-ascii?Q?641A/+7DrJgHtumSHncbMiyuq2xL34/LdZ32mJhJ7tgj0XbgFYgjB4gxZCR1?=
 =?us-ascii?Q?ukr6Tv6Rzp+5fL/jM+0aTwoJYhApqSaBXqKcErsMqj/ao2fdLq2ndL7umchr?=
 =?us-ascii?Q?jKxiaCT48KlHtfww4YNb/L/qT6PEfWDr6rICfaY3UQ0apSGh4oH7ovTUXrCF?=
 =?us-ascii?Q?1g62FXaq5IA2J/y44nlL6ZBc6KYpjIptfB9GAwzXdsZLvkYFtlXNcZgEUALF?=
 =?us-ascii?Q?380valdnet+lvNtQ2N6Hp2blPxKeuZzdqx6BV/uFqEEqsCdFU0GezPnBrXSV?=
 =?us-ascii?Q?N2Z8k5NvidzMRkUFj9xDHRlpDm/Asx0ug0PEuJz4OGlEhWPMc+5fzI42XR3w?=
 =?us-ascii?Q?DZx5l8bq3wBibnQ5mtk8FApkmHxagDC94OdxME5PLwdvso19E/dgiXDJ5n2z?=
 =?us-ascii?Q?PSPUD70ccvF2yus/aSo/0sJ9yvY4vJsa/Xih/P3Xb6+c9SiBfmOYhIuEmutz?=
 =?us-ascii?Q?iKlBaWcFLOS9kYKej4Wya0Pkmh5MU0Oox3x037UjEDSkQeEX5ClgiBXuQOso?=
 =?us-ascii?Q?88uPa09c5Tgg0pmx3bcw8Ysc/KEmH2zJdh1Ci34xjaZvcsJeXW+0kpcwtkil?=
 =?us-ascii?Q?q517dIfcw/sZ6I7LZaJUaUgZuY4c1F5qHcu3Ydl9Lg+KRZEUCTPYID5c4rLF?=
 =?us-ascii?Q?OnFYMjxwmMSmM3Nf7p08AFQmCJfPcRDdX498Od5vrhaM0ZmgZKafY1HwlejZ?=
 =?us-ascii?Q?5juHoxKMTF5jU1Zd18VafMbCxANFJKwgcLFCyXN4r/K04e3G0Ais1Tlm8e89?=
 =?us-ascii?Q?tY/oYF8Rs4yt1zf9bcy2ZxarxeLnYufOtUN2/35u9viR+9Am9a80eQLWxvle?=
 =?us-ascii?Q?I0KS3bt0ptsL1/0Jn3ATiLUiYHiIJeD6kcShei9TZ9/ImYbXUWkzc5FG5TdF?=
 =?us-ascii?Q?/F0qAwHzfcZmUsIVioIomMviacq1O63KtNNm0iolBjiSnnS11cYuiSh/rqP1?=
 =?us-ascii?Q?1Mk+V8qK1/o+zjvEeqO8EYDzTtJAtReF29ge60gk8xBavaWqlnWpICTfP49n?=
 =?us-ascii?Q?089d6rVcJi9YPxdg9uHqTmnDHnidfBQ/WMV4VS3/csQhF+/2WVOReQK3R73c?=
 =?us-ascii?Q?nMc9v8s9CRlw786FilSJfgDj/5bJhhkF2iT4mGs98dmm1NfIFQW/vXU4plVD?=
 =?us-ascii?Q?7RIVz5x9p41WCvDEED3xd+mZ6o10+XGzqSfQSs+nlz53lLVaUbUTrdX59JGh?=
 =?us-ascii?Q?JOHnIXB0LTUsi9fvlrNP21v07U8T4/VlDOsjcHmXsX6qaOeBDbs66Y9Al3e8?=
 =?us-ascii?Q?gxq8rnxtrHtR28qWhUmDOJ3Fmb+ANyQdIIKT5agQg2lOneHRoddhN0OSviIQ?=
 =?us-ascii?Q?W3enPSvt55gTzIK4RvmdvJ2dekm2RH7L2Zeaa3XJ2xegMRhgg3PCqJCVl0xQ?=
 =?us-ascii?Q?iLO//RavElze5covFOVg0kusEaOdY9d4CSgJhuEKyyWg2wgYVduDu2xuJpzV?=
 =?us-ascii?Q?MWOhkXndzhbRq58U0ekxtBoIZtZ71ucx41Yrrc28oNTo7jchyDrelQjSw9ot?=
 =?us-ascii?Q?z9+NtPEJAvp9raIJJ87nSTktw1nYkHrwJbDvqxSCZmIy4vBJELH4axk/a4Mr?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lI3dw/s60ybuIkR73KwHZMqwxhHTvYfoHCTEjvQOcqg9RK2axaVcXbJcmgjuKwJY3cCcoTGWwgn8D20CEq4ZcHs18PQ0gwG99Z/5F6A4WlmJ7HpVLaxaZMHVQxO0Ewmls06nYpPFIRzoK3xC1Ty7UZI+5ew2Pvjeb8yXTGUkyGlsE0YS2DxSO3hhtf5ZBtjE86hlqfFjNV6/bbm6Kr7rQH2OySHf1N2VaaKzzPcbBtRKHpo/3Pj6E+fNvuEz8UiNEUAJb/DXqoVYe59FPAWSJCcIix5kghiSEWW0ozhXUMeL2Z5M6fOjBHZxbkAeWCQd6nFdZcVgrDplVqJ+cuLt1y+QhM5ViZK9UkzGNFfuXpNOCKPZVfo4kAVBXGgz8V9CNp5uIdEb/Qy5ULZlc73IdoMMB6SUIbQVQxD8UZUes0jriiO4CfnsD16PeRmHPKamrfgQxFVKc5/T5wHCKcat0JmCzhbXhrYrL5q/bL9pX9XvSoimxF40OSEhuAdwtmW/eUTc8xyZfyJfNDZFPtmVyMW1xOt1WpGQAvjA25+9IHqEKrUH6IhL6Ya/GQpo/+dMJTEYQQB03LPyeLnMKwDkIFDTaqvoOUu+/0ZElqCnidzzVc/aO4rRa7wipot8l1c8e58ioX00MSH+9StjqbV7T92QO3xiziFYET692S3a38YKF2/r/n44buDvJTqKfufKzkVbzcXXTMXW7pRiE8/FLWFyogJs7w1aeEsns3Z2PptWHQyMMilIp5AyEwyhDKRo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce287f82-588e-457e-aa7a-08db7f0261e3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:54:01.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHX1vNqO2lX7YZ2Io2mf8ifE1jpWpWeeZI5hldtN63NfjW16bJQ0rCBqo7PqIMQ8dS6IQY53YI6xFXYNebTu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070147
X-Proofpoint-GUID: exu_iEcT7vH57yjGhx3exNCyC-D45YSt
X-Proofpoint-ORIG-GUID: exu_iEcT7vH57yjGhx3exNCyC-D45YSt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfstune -m|M option allows the user to change the fsid of the
filesystem. However, in a multi-device filesystem, if the fsid is not
successfully changed simultaneously on all devices, problems may arise.
In such cases, the user cannot use btrfstune again to resolve the
incomplete fsid change.

This patch provides helper function to find other devices having the
the same metadata_uuid and have them reunited with the given scanned
device so that btrfstune can fix the fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/device-scan.c    | 42 ++++++++++++++++++++++++
 common/device-scan.h    |  1 +
 kernel-shared/volumes.c | 73 +++++++++++++++++++++++++++++++++++++++++
 kernel-shared/volumes.h |  2 ++
 4 files changed, 118 insertions(+)

diff --git a/common/device-scan.c b/common/device-scan.c
index 00ce15244a09..512754c01adb 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -541,6 +541,48 @@ int btrfs_scan_argv_devices(int dev_optind, int dev_argc, char **dev_argv)
 	return 0;
 }
 
+int scan_reunite_fs_devices(char *path)
+{
+	int ret;
+	int fd;
+	u64 total_devs;
+	struct btrfs_fs_devices *fs_devices;
+
+	ret = check_arg_type(path);
+	if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
+		if (ret < 0) {
+			errno = -ret;
+			error("invalid argument %s: %m", path);
+		} else {
+			error("not a block device or regular file: %s", path);
+		}
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		error("cannot open %s: %m", path);
+		return -errno;
+	}
+	ret = btrfs_scan_one_device(fd, path, &fs_devices, &total_devs,
+				    BTRFS_SUPER_INFO_OFFSET, SBREAD_DEFAULT);
+	close(fd);
+	if (ret < 0) {
+		errno = -ret;
+		error("device scan of %s failed: %m", path);
+		return ret;
+	}
+
+	ret = 0;
+	/* Check for missing device */
+	if (fs_devices->num_devices != total_devs)
+		ret = reunite_fs_devices(fs_devices);
+
+	if (!ret)
+		fs_devices->sanitized = true;
+
+	return ret;
+}
+
 bool array_append(char **dest, char *src, int *cnt)
 {
 	char *this_tok = strtok(src, ",");
diff --git a/common/device-scan.h b/common/device-scan.h
index 7a6874298051..a1193e7f7020 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -61,5 +61,6 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[]);
 int test_uuid_unique(const char *uuid_str);
 bool array_append(char **dest, char *src, int *cnt);
 void free_array(char **prt, int cnt);
+int scan_reunite_fs_devices(char *path);
 
 #endif
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index ac9e711a994f..642f7084cf63 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2958,3 +2958,76 @@ int btrfs_fix_device_and_super_size(struct btrfs_fs_info *fs_info)
 	}
 	return ret;
 }
+
+static int find_unifiable(struct btrfs_fs_devices *fsinfo_fs_devices,
+			  struct btrfs_fs_devices **ret_fs_devices)
+{
+	u8 *orig_uuid = fsinfo_fs_devices->metadata_uuid;
+	u8 *orig_fsid = fsinfo_fs_devices->fsid;
+	struct btrfs_fs_devices *fs_devices = NULL;
+	int ret = 0;
+
+	list_for_each_entry(fs_devices, &fs_uuids, list) {
+		/* skip the same fs_info fsid */
+		if (!memcmp(fs_devices->fsid, orig_fsid, BTRFS_FSID_SIZE))
+			continue;
+
+		/* skip the metadata_uuid which isn't fs_info metadata_uuid */
+		if (memcmp(fs_devices->metadata_uuid, orig_uuid, BTRFS_FSID_SIZE))
+			continue;
+
+		ret++;
+		*ret_fs_devices = fs_devices;
+	}
+
+	return ret;
+}
+
+int reunite_fs_devices(struct btrfs_fs_devices *fs_devices)
+{
+	struct btrfs_fs_devices *other_fs_devices = NULL;
+	struct btrfs_device *tmp_device;
+	struct btrfs_device *device;
+	int other_fsid_cnt = 0;
+	int missing_devs;
+
+	missing_devs = fs_devices->total_devices - fs_devices->num_devices;
+	other_fsid_cnt = find_unifiable(fs_devices, &other_fs_devices);
+
+	if (other_fsid_cnt == 0) {
+		error("No missing device(s) found");
+		return -EINVAL;
+	} else if (other_fsid_cnt > 1) {
+		error("Found more than one fsid with the same metadata_uuid");
+		error("Try use --device and --noscan options");
+		return -EINVAL;
+	}
+
+	/* Missing count in the fs_info should match with the scanned devices */
+	if (missing_devs != other_fs_devices->num_devices) {
+		error("Missing device(s) found %d expected %d",
+		      other_fs_devices->num_devices, missing_devs);
+		return -EINVAL;
+	}
+
+	list_for_each_entry_safe(device, tmp_device, &other_fs_devices->devices,
+				 dev_list) {
+		/* We have found the missing device, bring it in */
+		list_move(&device->dev_list, &fs_devices->devices);
+		fs_devices->num_devices++;
+		missing_devs--;
+	}
+
+	if (!list_empty(&other_fs_devices->devices) || missing_devs != 0 ||
+	    fs_devices->total_devices != fs_devices->num_devices) {
+		error("Found more or fewer missing devices");
+		return -EINVAL;
+	}
+
+	if (other_fs_devices->changing_fsid)
+		fs_devices->changing_fsid = true;
+	if (other_fs_devices->active_metadata_uuid)
+		fs_devices->active_metadata_uuid = true;
+
+	return 0;
+}
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 13d08cc7eea5..9f755dfa9015 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -104,6 +104,7 @@ struct btrfs_fs_devices {
 
 	bool changing_fsid;
 	bool active_metadata_uuid;
+	bool sanitized;
 };
 
 struct btrfs_bio_stripe {
@@ -318,5 +319,6 @@ int btrfs_bg_type_to_nparity(u64 flags);
 int btrfs_bg_type_to_sub_stripes(u64 flags);
 u64 btrfs_bg_flags_for_device_num(int number);
 bool btrfs_bg_type_is_stripey(u64 flags);
+int reunite_fs_devices(struct btrfs_fs_devices *fs_devices);
 
 #endif
-- 
2.39.3

