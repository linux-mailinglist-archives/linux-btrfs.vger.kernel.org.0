Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28379691FF3
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 14:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBJNlp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 08:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjBJNlo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 08:41:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51312068C;
        Fri, 10 Feb 2023 05:41:43 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AAnUMk032302;
        Fri, 10 Feb 2023 13:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=rz4IGxuSB1fCMp2Idludmk2qJOhnvu2PHKVOopWPWHM=;
 b=Ahg75iNum/iHP+Q2yGYmGEuilt9GIIBJuGM+QRSDZqxMDos5/M8JKhh8+wA0igjWAKRe
 gMQiAdfi/pe1tR6oKap3uo5tpRYNrmzjMIljSWuh6OppcTwPPUxlpEejkYlCruslFrIu
 TMgNAJ7juWgYaZnu8fay0o0EJW2+v0OQUgkcD4/ToLeZfgmWHMOWjp9tNxeQkb2JONMs
 Z6BrTKGvGayGGA+p41I9Z8m5/IBKsqBUiArKNNM9qmcuruOkCSt4TQRCT9CcL0uaMvUv
 l/fy4LV5iab9AU7NLJzG0whibJusY6q+ulmJJzD2se4eje2wI4LzKwmGSwxy2OzGaA8t Ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdw71c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:41:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AB3lON015209;
        Fri, 10 Feb 2023 13:41:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbesywp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:41:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps6CXnw8+yrV0x0b7Inu7ZMZGJSWdWpWg95YlKc+vofOFCMEXOfY+4YNWH6KyDuwP0gTTq6OIaF4C69EHJTjGDC+slEkNEO4wd0Xb4VjklLv91v2gw/2R0w/ok4k6wVO/NHsc65nkArgY0yPx3t0eKHPZy+JRiytadnkt5NV0B9YVIHLUTUH+ESPHoxYIc0/b+ZPLue478QvBv7cgFUBt/7Jliy/WB8fsFoILITz5xGZJqpLEJwdS4PbKYt3n73XHCN0PEzGB2XBX580LzYUA2aZ1Bhie7eFeKPMPam4rOTdMbHIE1/TwGQZIn4E1TnAGmPXElWr7m0nzzg/yfSU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz4IGxuSB1fCMp2Idludmk2qJOhnvu2PHKVOopWPWHM=;
 b=MqOUej2gByRRyZdj5taokbxiaEt3ToGslNZ7DSdBrLAy8pzsdSwtPluaNp9pkdKRF8UJtundA9XkuJxcDiQ9mXqHVpDXUm25Qw9pPz3L9vPNtZoTD5ZbDuxHPdSdIwqNOCB6ZAjYjg5Mf7A2sh6pW5M5MfRa8hPR6N+atfJEj4jhq6nV0I6NlqhPYK9ZcBdXMV0ckbdFnosZIXNpGxjE7QCyBuGjf2tl+QGtVRSjnYTBUGWHnkBVnQy5Zf4556xs4LBTEg+RcIBsa49APvRnNa2e24oHpfVPh5DUE63py+vVp+oBZ5kzh/QT3X8cXCQoJ97ihUZG6khQBa1DkJPy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz4IGxuSB1fCMp2Idludmk2qJOhnvu2PHKVOopWPWHM=;
 b=pp3YnsiimUm0wC1Nlxt8QDrz8ZCfXyY3H2fbTV9lJSnm0eeR8U/4K9dIHN3xTN2ObQqC65V4nn4J/zUx3/3PeR+vkZ9dSb4v9I+MD3Kr+3W2aaBSEpmhbW7DC2PhRPokawtH+aWxp0VRNL/1O41p8Xks16F95GYIfIQ9etBrVao=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7188.namprd10.prod.outlook.com (2603:10b6:610:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 13:41:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 13:41:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] fstests: btrfs/198, add _fixed_by_kernel_commit
Date:   Fri, 10 Feb 2023 21:41:19 +0800
Message-Id: <e23553b551316ec371ddb08d851372a6a21c487d.1676034764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676034764.git.anand.jain@oracle.com>
References: <cover.1676034764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 8031fab3-8d7a-495a-13f5-08db0b6c885d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xQ+FhkhlNyDj43OBya9PZS8LKoG1w5d2xDUqmOR7eYeWwtIzexl9meL2Qzyz6kVyS2Brra4SKNlPOV6SUuGpOuFSN4XUzop1unbUcha5/Uyu6deWVNS1q2q5z+5k4DvD3rw2PUAdoRJqSjv0njK9SUQ6eS4VKqudDaOgOUzVzcZ94dv6aPPRobm0j4RjKrSV+xqHETPTyP/x1CcSQcEcVfWDBctzP9bKs2wT7Js6i+VVnBSfFfRyJcX86b7MvT7+JygbT50Lly3ggEq1S4g2mbMGbE2vNdaEH7S/r1g6DABcA649uV1k6gPA5yUUqBvsBx4do50jwL2OQuZpSCst4pNNO3TtACOl2y2uj6HwYQlOXL1gN5uODqC1nrMMtlJ4sT5azImnX3hn2xOytj2Y6niJvlkemepdZ+7mSjAtbOQLEAQnDt4XzAFwfg43FfovhD55M8/g0IX6lbUyXX8Rovqj7Rg/i/1qLcYX3cwC94eaJ1BB1cAH7uK17w6VL2m54WwK95XjpNk9pRM9LcbSXPsUm99aSeP7vnszmCLn9bEocCUGtUyQmXzYgBrCgyJvFYk0xALvp6XnmQoc8OD6LOlBEgLi259Wfqe8O0ME7it5r4baLKbUSmjM/WslRESVuZZ5fFkHK41s9aXr694JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(26005)(478600001)(186003)(6512007)(6666004)(44832011)(4744005)(6486002)(316002)(83380400001)(2616005)(6506007)(4326008)(6916009)(66946007)(66556008)(41300700001)(38100700002)(5660300002)(8936002)(8676002)(66476007)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jAzIzfDS1Yra3VAGdAr1iQKAUTJ1uFBN6mWmH59uNmatXGa/zhdhvbcS/0U?=
 =?us-ascii?Q?xQIMgvTNpxsG4Ext25ApVywqDdvg4MPDxEsWx76lwOgLya8hF18pV2bMK9kM?=
 =?us-ascii?Q?mfLpn9GanMSdSL4BfsHllMVMe4ayf1mIekONBgrbJyLE/oOLmzbfRKxWS/19?=
 =?us-ascii?Q?/RYCEHZgpj5OXAQ0NL5HKRpdVe4ey40wqtJvYyWQ9iTT2aucepHruNgm0BFt?=
 =?us-ascii?Q?pKDOpSk8kafRmPpx+3yhUgIAbum6tc8NJuIxzWdF9Fjbhx/L/RzBTLuMOu6b?=
 =?us-ascii?Q?QTLcxOq/MAhtRCBQyxFHEVexYvXanQ/xUTWrTexoVOIGXZ3TXkFUgc10vw/Y?=
 =?us-ascii?Q?cP5FcRqJJ1kSpamsxbQSwt6BpqCiCr36lUpROHY/inLivh1/N4LljQ5yvJ1h?=
 =?us-ascii?Q?7yuz3RRBzMeOwrOpfGwI6DB/ohYyOctxrZJ+dg/TvtQ2ys4rXtpo8qxkarJ3?=
 =?us-ascii?Q?ugU0P54jGvXLu6sx9AbSLkk6dnMDNwNkHeBf6tXTt3ZZESivlp3fLIAVlzm5?=
 =?us-ascii?Q?RyVI1ysqjq9JOZqTjjYrCqbr6/DFTFDHW4eH7As8YzQBAmCT9hJgY/e4wQjG?=
 =?us-ascii?Q?oSwpk11WmvSwGhIo2rVWqbdDhdakKNU6xygajz/PC/ktUCna+A9LZX3FaTuW?=
 =?us-ascii?Q?FSr6nueFTBWwSQmyMUChIJTs47eD64CQXjFVLJjTCW7eBUeMdumnttCb2G1u?=
 =?us-ascii?Q?qPI0N/z4CYGb0ZM7RuKTuMdIXl+Lhgv4CGt4xr2gUJoPs/457y990nzskuHW?=
 =?us-ascii?Q?37jsWjFOaB0ve6bwY6vpWNKUa+Epu0M3Jf7zjkMNae3qLOqGL0Jg1g7C+PAp?=
 =?us-ascii?Q?1xfwhpwHX85E8FHF3nRA3T8uMFwl8Fn6NiICBSU46dSiDfEA0nVuFd8V+BHc?=
 =?us-ascii?Q?MD86IZGKsAZFZulyhC88aBhojBrRbsPUsgNzRHlB9uPZSM0vWfohrtw3otlc?=
 =?us-ascii?Q?swk0qbJqbaCJrNsgzHwUBd/AF3vM5tXrsX3Dgup2R7ppJy63YFEYNRasnEp/?=
 =?us-ascii?Q?uOAHKiqKVZ0EHElShDSObkO56ndtXodSDEi7WdU/GZ/dACPleHBxUuNYJ2xc?=
 =?us-ascii?Q?IIIlj97BRQ7oou0viKbjST2ifeFJSi7BjJddTjj641+jXgrVpajYNRjcyc3V?=
 =?us-ascii?Q?O+E7tv+B9bsMpY7MBsmtulrMRemw5N0urDxQOgJRWXjXt2yv/nvwOtGPAH5i?=
 =?us-ascii?Q?kD13q0EZ468kVoUnBxp7Zny5rCm5j0dOJKJan/r74LzWMRGLjgTM6FLOJ1bJ?=
 =?us-ascii?Q?auwpwxCA4Es79hO/b4OMMPxQpOcIf7Bp8pMvGwlazn9nLAn4NTCQB8PLYVLj?=
 =?us-ascii?Q?CHv3rhkIDP+dbMZSHA4H8DDJHM7ws9icUkR29iW+DioYINMV0EVEbiogbMlC?=
 =?us-ascii?Q?rIoUgBjcj0psd/7yFBs32cNJCVN3IDnsd1kAGuYWdKCLwQ0c3Nse8U5MSFxl?=
 =?us-ascii?Q?k478VXnc8sQ5kmuVxHzjAmEtLn83oQWawFD0Y+7xsLjU4E0WehTak06r7kn4?=
 =?us-ascii?Q?x8JFfHcTSmVpCSKovwd8xhwxkvjbpp78jXr8MGKU+M/N7vgZRgAI6uY99i69?=
 =?us-ascii?Q?sLzHr3V9YZHYBcqntJgyOcngvxGQIa7CRcLBdA8sUOG1vsPd0AaxKauUGgUD?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nTrgkMEnbjB+922TkpCxLs4D7AOvXikmYDlEwiNH9cNxXR5/M9TXufGzmjrxzJOPS2k7wXzvJ7BHdiZhrDL7eI/JEHIPKuPW+hsnxPljud+1KWMD8mt8xMzT4TnFYjv2H5HZhCe5UqMiFa+B/Zf0fnUTmkOlK+DhathEQ4ku8mFphIe8i7q4bQQ6GoyZr7+G4Lvpc3QhrbvqaJB7EH4wwNHssU+bIzxbntfjsvI4bMobepYxk1+p+uLNc++5gFwS+Cue2dk1Yb8vBiqShNvPAYasasp3Qc67ZXIJMys56Up1+/bRd+R7c5VL9hOJ/aSrAgjPK0/fVX+bD1b8xUODKbXnC7KI4p3Nz3AbPfXG7MgBroUdekCqK6Ijaa1DvHhBrJLeKN+DPohRxFf1tZynXaEqYz0ev6GmVUCY+oaGV+Fwjdkhk1sH9Uh3d+gFc3sIPljfhDqGZxwm2wOtorl3UKIGniVjj8NwBVYURty0pfJX3lFNjxzZvWzVOso7BzM2bwgHsKG3Xkte2uICv0my9Dw5jjXM9Q7VEb3gvNb+sjO1IsnUP0gjkVdjHdrJMvWEqwXeZFCRTfM+MqIRtSaBTLFJjT7HmP16epnihwDMWW83lrgWuWqM3ksUNV8gyaGkMOLC4qE5PY7RRjt+B67whIiDRZbBDiod5Fs0nz7g+xjVLoFABYOYTfXOWpJGJqgto4+mtuzLbkHNZV629OffXTp6VBhbIVW9VdhZAjV/pGINBqcprzWZycI05mwtBV3svC5IJ5bB83WDTlKftL6lavE0zGmLrTX9znYOK5kEet4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8031fab3-8d7a-495a-13f5-08db0b6c885d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 13:41:37.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U97MqAqq/N22+R6uZNhbfl41GagPmVCVrfQEKjozan6wWVL9yDHXAmArd296g/LSAIrSHWIS7d/ERSodLPUoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_08,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100112
X-Proofpoint-ORIG-GUID: p_xpiCH0H38JA_kOQCOZ0ADSoYdZA_Ek
X-Proofpoint-GUID: p_xpiCH0H38JA_kOQCOZ0ADSoYdZA_Ek
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add _fixed_by_kernel_commit for the fix and update the test summary.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/198 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/198 b/tests/btrfs/198
index 2b68754ade52..7d23ffcee3c5 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -4,9 +4,7 @@
 #
 # FS QA Test 198
 #
-# Test stale and alien non-btrfs device in the fs devices list.
-#  Bug fixed in:
-#    btrfs: remove identified alien device in open_fs_devices
+# Test outdated and foreign non-btrfs devices in the device listing.
 #
 . ./common/preamble
 _begin_fstest auto quick volume
@@ -22,6 +20,8 @@ _require_scratch
 _require_scratch_dev_pool 4
 # Zoned btrfs only supports SINGLE profile
 _require_non_zoned_device ${SCRATCH_DEV}
+_fixed_by_kernel_commit 96c2e067ed3e3e \
+	"btrfs: skip devices without magic signature when mounting"
 
 workout()
 {
-- 
2.31.1

