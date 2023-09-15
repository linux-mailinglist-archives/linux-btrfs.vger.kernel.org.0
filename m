Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE657A14B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 06:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjIOEO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 00:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIOEO2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 00:14:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A62708
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 21:14:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EL0Bct017151;
        Fri, 15 Sep 2023 04:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Me7vCOT5A6F+eHhtG6G62eVpbTWMZtbYb/J7+/VE9P4=;
 b=YLqF8NDrw1IuAvMCLiiXyVVW/UZw+rAOooGHgrZw2+lapyznP+bZIQMvnvK5LYzpdVXr
 dcTA8o7g9sPQksNesHaVQDbUJUClu70gxH2abf/0pcoW/3qR2KMmA0TK+VD5iySQQJ8T
 GN76Am7l1Uzu/Dnw5roXi9XF3CK72nk0/hNPQWdWc3ZlouNai6b6BQzw1z4JPcarKUah
 mB1lGLjrULNvL5C9MtRY0HfUVYxXt/qvIretsyh3fDyLn5u28vK6Cz0UVSSFyuWmowAu
 lO4oZJeDpxSFUsc1ec/p8ElgbWe8WjpgKyV7yWw/ODvmqo2dTMhRkqMdKWKcWmuluGyh 3A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7ppttj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:14:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38F3l4R7008846;
        Fri, 15 Sep 2023 04:14:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f59tqry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYfQ8gE0vNZsZChfKb9WtpY2RvJP40RxoSbYMjgNvWgcsixWRZLcJo6XXhCtHZEhps4OhT4s4/7pFAX0Pk+YU+qPKjcUNELgY3LB4vifs6b5T44G83jselQBgMU94tcJPhxHtf2MPl97OG5Qq8RscZGPGt09NNT7/GwPf48DXeMyoYkuy269SbHpb8hqkPL07YYCzAfa5ypuoBaN9E4Vs8Bp25m8OLLIY8CBiFbF+tEbJMhZlW+cTyUsSo+LifPPYTEqcVDJNIFtZHd1RS08wPqmprU/bZXc9ALzvtpDT//THMs1KBYwOhrb2LQkhPdTHGwxzWLUB8uBKWghFlzY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me7vCOT5A6F+eHhtG6G62eVpbTWMZtbYb/J7+/VE9P4=;
 b=QYO65/yv2PtGEk5wPNDElR4Zrrbg+LyGNqAM2qJwmBBDDpj/t8Z9Kdxjjzwu14PWUjMNFaAaYxXxq5S1UbeJIzpeyKxMy2nTSnM0DhNTW8ZMyisVe6H86N+AMfErm7vAqXipWQEPT3/P3knWaLm8R/8zp9GFdo2naEHnPX9MQjwZBjNkzMeOJsII0mbqoW//3x1UNum3R3icUbIMa4FAJzHHWm2ZWmUHoHO/1LzsDD5jXOUj1RmBKr6cjOIMcYYIiq2I3uBqz3ozekCPqU+LrCXi5xWq3zgJlsUJdP254filC1qsnxAJvFi6aB08prX/SkqakWn+bj2cQvglbBTqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me7vCOT5A6F+eHhtG6G62eVpbTWMZtbYb/J7+/VE9P4=;
 b=Q7afMTA6ArxneSlanhmQkpTkqip9vVW9ueeE9Ll3vALX3VHscvSOkv3wyqGmbNujUNk6tE+GVhYLQki42uNTUpRtXTF3LkUxwO770dnLG2vxLNB4QbAvF2K2j+mmHUYGWFE+qGbH+CnrxNLBS0of1IlfScQ/G4Otgabqfw9jAJc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6544.namprd10.prod.outlook.com (2603:10b6:806:2bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 04:14:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 04:14:03 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 4/4] btrfs-progs: test btrfstune -m|M ability to fix previous failures
Date:   Fri, 15 Sep 2023 12:08:59 +0800
Message-Id: <db8c6de3dfda46d9e3c0dbebc7f10a898f8be112.1694749532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1694749532.git.anand.jain@oracle.com>
References: <cover.1694749532.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4edc45-2e9c-4736-b665-08dbb5a231e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKFQ4S5vAOenKVsID+z4esnZSX8oA+a7HesPPPSkipms8ASFXkdlTMB1rDOS5lapOdqgZx/cJJa6IU9UL5te9IyuURb61qssFMSQmKmwaFVqV3dEeQUks8tryjrkzeMDKMLvNDRfoDfpSVEB/cNGjwBRVjGjrCizBC4KZ5S068aimYueGDpqU1arvu0fPPOlfxRly1GWCJYYlWE7GzJGXoBfn4G9VKk3GTxajv2L1dP1S0ongnc3TPYshv3JokO5FhN/JZVw+xXaJTRgYcBP6UO4G+I+slXYbClPeyVgxmXpbFXndbbiF3NYXPjHNv+Giq18TN+EDMgibKH3Luw9R/qaj1y7kCzxqyihetl4xyjApAW4qUFWsH5yBD4hHG0oTq/ypD7MZ/CkQVPzC3poVZt0XBQZcO37eMmx5oCmPpYTukDn9nqoCx+uScHmIb8NgEuM5G90trVnwz23aB+3kcP+ekMHj8lYM0/QiRhqXAiDYKRUxmgtrSWALMRausnLheAxjnsXJxdOPj5RQXPpuRLlKnSJ6/D9Cm+YydOWPrm2VvbCe6d+8Gzc90ztDT5x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(36756003)(86362001)(5660300002)(6486002)(44832011)(83380400001)(8676002)(8936002)(41300700001)(6506007)(2616005)(6666004)(4326008)(26005)(6512007)(66476007)(66946007)(478600001)(2906002)(38100700002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pixqPrBJVvdixEfmArmFQdZyNkXWfp5bHVIKEjBCer1s5/kNPKPX8qaahSi1?=
 =?us-ascii?Q?gGOPQ5/wl3O2OboBzusYq1pbVGnb5sWHhdXaYwEbyXf7NvM5VcCaZmSOE099?=
 =?us-ascii?Q?tzwcnUi9lhS0iKL9faQY8C3CAE9Sol/PLMiR3B0xsQIfSupaVqGBEscyWBX+?=
 =?us-ascii?Q?K0k6ZslbrenfPOIptF6YGMfUrga10sbdYOLHW5r2OIL+9K3BibMsMqNpxDPC?=
 =?us-ascii?Q?mVg6ZJ1zvED6064VRjOqeA2vTGf+BQl6Kh68vK3wBxXPguQ4W/v0k4drvSVM?=
 =?us-ascii?Q?yWi+xicXqswETqeF3jAWZCKL1QOYC6zfXHU6aD+7HzgumTRNq8BD5dlNwB0J?=
 =?us-ascii?Q?1cQo/j5pKOnWy5bxeLEfFioYWqj+e7YsoXgTR67tjO8ueZ/w6BChBVT4IUr3?=
 =?us-ascii?Q?FPsQIfhYSoOxgonBtWBkEQYbB51EQLDlGXetFOGBeGt58PJTmL1rBTW0MTRB?=
 =?us-ascii?Q?lonDlHUNK/9n6QunULcZGuR6bQmV9HBkNI6tUfM1qk16YndY+BIuhLrrAO0g?=
 =?us-ascii?Q?9Q5a2y2TQJAxHWagxPjrw06rlwZPTigwBYP4Tjf53iiQsm6YHdze+GwABF1f?=
 =?us-ascii?Q?2QyNhnR1ar4ZlteMMoNNpgqnR7GpvudFpPtJscwia0zn83S4wLG/EkHMpjP2?=
 =?us-ascii?Q?ZvhOBXtIq9s6KeAjc+7l+qH8XGCUF+iG+zrmykpUMQcNMEYwR/B4cKeozB8O?=
 =?us-ascii?Q?rK2vUjpkjRUZ4w2i09e6tCZYmzm+odkqnrcP5ZX/XtoF+AqXNeeO9DueKZSE?=
 =?us-ascii?Q?XQL8VKVTaZT4PAgo9u1aIasnaly36UjEmWoXx5VEwmBcVy8tTAoCbL8ZjD4H?=
 =?us-ascii?Q?1SJch4B73/DQidtjIjHsuHDn6jM7Ew572pg9dh+2oY4Dvq6PvesJW4fO0giN?=
 =?us-ascii?Q?M3x7+mHbLLqkiHQ+yGTz8uH7gg0/mYQMzuuPG+odno9pmq0eIy0b7zJcSQic?=
 =?us-ascii?Q?ZggwCA4pEgaUCI6BATVRqU2xhoSiB+V5yHu0LwaUH8tL8m8CQNoK8LSwE+Sh?=
 =?us-ascii?Q?Hu3+kMU89uxE740NQx3/s96p7cbpCmNgfTIIdU/BLGshMCsXgH3Rj+u8QF2J?=
 =?us-ascii?Q?5554X5izv6cRif+ZCfsuWkrdPLA6YOitpkqExkrCG3aqS5qyn/QxwyDPX5Ay?=
 =?us-ascii?Q?XjG1bal5xfglFi7hbSd6K48TwGnDaXEuNAbdFyQNGPO9PbyMflpEg7xT/lMC?=
 =?us-ascii?Q?act/LKUdYSFZeu0BwWBJ5ILMmBZV7Cxno8weeRF1jnsoIdFcSCVWudJOYQzN?=
 =?us-ascii?Q?2rkm3MHi/pOZ8qYVqFGTnTDD0iNgFHIGQnq8brPk4lgK2sXsQYIJr06ABKWs?=
 =?us-ascii?Q?2Rsyd3evx7MlI6uBbUUHzfGqzUyuKZSOQ0NIfKZcSQkmMDhbHdurXsyrtF3l?=
 =?us-ascii?Q?ObRmv/kbO+eYkW1p7riUDr8kDa+KpIfYLqQ4U8dKMwAdprNnZyVhQ90fXCNr?=
 =?us-ascii?Q?hO4EKBjZtrd7QfqbfBqmYLMyoCKdnk+MwkRpe3B9MaBoY84FIgGkeOScbg6G?=
 =?us-ascii?Q?CvTUyvdn3fdyZYnRQCzxITv0bSeB528P5U4LE/9oyeW2qNfJwH0lU+ZtH3Re?=
 =?us-ascii?Q?cHnk4Kgcm0SeabFCecfiPiJn0hR9puEetAHH/w6EoCUWCAq8qV4D3Xaeg7nV?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OXldwcPEiBZi88GJaWXMxyiR5P449AAtp1ESjWIuu/5vCvD7eWWFloKHftPTvsgzBZNIaH/oCU0MmxzFl9d4QrtPwUgpDHiYf12yMC1+aAfPM5+0an5jOSMSGIFrbpIZE+3rEHBXHrzSYl9QhanPWxH64PGilEvZKpUIJbnC4x7CTtReVfcqu36UjXMOnOLpQIKAVtgujeuAb9t3XYjChTanQ/Ml1Rr7Mutd74As+nzzywbszZJazO3RP9Gb0HcsM1T+q1U6BaUioUSrP09kgdaUJyzvQ+mFfisP/nWIFfXVTAVOCS8zybd3X0kTirIn2S/+z8bKzT8jtmT/j2euMH+D/g0A51NqBnLk6k2laej5lumJhzrHypKVFNIlDcfiB3u9QahirkA/dS9wF59/BOclFXu+xDrNF2CqoQOXaKNFzm/UyTGEktmYQLXotQX6ULnUfbOFkKEgaBUYYw7kRrSontrArmpjiRiadfjdyh9hE2nAbQASQmOFtWOWCFT7fPCMVlVYkMkkaNAj+pY6zOvgjVBP1tmkaiYPMW35Fi5ft2+g8yR1CAoQQ+8jNwBKe0CDoGU5jwcfgmquUduGNZjoc2GBaB2pZC4Va5G/4emSiU5RSEh31bDAh0zr/xWpsVzjMGG1/6wzi9JxBdIhoZvY9NzXs4ixMW02YaMSegKsMMZK7VM1pg+p+zK0u5OsdARlQbCZClX6zUEMPNEU4BGTQH5a+lPpF3H4PDAXc3HUfmxds+3gGicpKgAn0kuJYBQpR2bzwHPujq6cIsrn6oHrDumN6Bt8mfuW2Zg/nMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4edc45-2e9c-4736-b665-08dbb5a231e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 04:14:03.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zG/+/7Lm0nXmMR6TNvm1DSw9QFCG3NP4t5Uohg2cPUJ39s6DJZrMF0QyQP3MV+lwgDZ9SmSQj/EstFYJHRxF6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_03,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150037
X-Proofpoint-GUID: zVYGmzmclBn8ob_gYcHTK45EqfbhFk8y
X-Proofpoint-ORIG-GUID: zVYGmzmclBn8ob_gYcHTK45EqfbhFk8y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The misc-test/034-metadata_uuid test case, has four sets of disk images to
simulate failed writes during btrfstune -m|M operations. As of now, this
tests kernel only. Update the test case to verify btrfstune -m|M's
capacity to recover from the same scenarios.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 70 ++++++++++++++++------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 479c7da7a5b2..0b06f1266f57 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -195,13 +195,42 @@ check_multi_fsid_unchanged() {
 	check_flag_cleared "$1" "$2"
 }
 
-failure_recovery() {
+failure_recovery_progs() {
+	local image1
+	local image2
+	local loop1
+	local loop2
+	local devcount
+
+	image1=$(extract_image "$1")
+	image2=$(extract_image "$2")
+	loop1=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image1")
+	loop2=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image2")
+
+	run_check $SUDO_HELPER udevadm settle
+
+	# Scan to make sure btrfs detects both devices before trying to mount
+	#run_check "$TOP/btrfstune" -m --noscan --device="$loop1" "$loop2"
+	run_check "$TOP/btrfstune" -m "$loop2"
+
+	# perform any specific check
+	"$3" "$loop1" "$loop2"
+
+	# cleanup
+	run_check $SUDO_HELPER losetup -d "$loop1"
+	run_check $SUDO_HELPER losetup -d "$loop2"
+	rm -f -- "$image1" "$image2"
+}
+
+failure_recovery_kernel() {
 	local image1
 	local image2
 	local loop1
 	local loop2
 	local devcount
 
+	reload_btrfs
+
 	image1=$(extract_image "$1")
 	image2=$(extract_image "$2")
 	loop1=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image1")
@@ -226,47 +255,55 @@ failure_recovery() {
 	rm -f -- "$image1" "$image2"
 }
 
+failure_recovery() {
+	failure_recovery_progs $@
+	failure_recovery_kernel $@
+}
+
 reload_btrfs() {
 	run_check $SUDO_HELPER rmmod btrfs
 	run_check $SUDO_HELPER modprobe btrfs
 }
 
-# for full coverage we need btrfs to actually be a module
-modinfo btrfs > /dev/null 2>&1 || _not_run "btrfs must be a module"
-run_mayfail $SUDO_HELPER modprobe -r btrfs || _not_run "btrfs must be unloadable"
-run_mayfail $SUDO_HELPER modprobe btrfs || _not_run "loading btrfs module failed"
+test_progs() {
+	run_check_mkfs_test_dev
+	check_btrfstune
+
+	run_check_mkfs_test_dev
+	check_dump_super_output
 
-run_check_mkfs_test_dev
-check_btrfstune
+	run_check_mkfs_test_dev
+	check_image_restore
+}
+
+check_kernel_reloadable() {
+	# for full coverage we need btrfs to actually be a module
+	modinfo btrfs > /dev/null 2>&1 || _not_run "btrfs must be a module"
+	run_mayfail $SUDO_HELPER modprobe -r btrfs || _not_run "btrfs must be unloadable"
+	run_mayfail $SUDO_HELPER modprobe btrfs || _not_run "loading btrfs module failed"
+}
 
-run_check_mkfs_test_dev
-check_dump_super_output
+check_kernel_reloadable
 
-run_check_mkfs_test_dev
-check_image_restore
+test_progs
 
 # disk1 is an image which has no metadata uuid flags set and disk2 is part of
 # the same fs but has the in-progress flag set. Test that whicever is scanned
 # first will result in consistent filesystem.
 failure_recovery "./disk1.raw.xz" "./disk2.raw.xz" check_inprogress_flag
-reload_btrfs
 failure_recovery "./disk2.raw.xz" "./disk1.raw.xz" check_inprogress_flag
 
 # disk4 contains an image in with the in-progress flag set and disk 3 is part
 # of the same filesystem but has both METADATA_UUID incompat and a new
 # metadata uuid set. So disk 3 must always take precedence
-reload_btrfs
 failure_recovery "./disk3.raw.xz" "./disk4.raw.xz" check_completed
-reload_btrfs
 failure_recovery "./disk4.raw.xz" "./disk3.raw.xz" check_completed
 
 # disk5 contains an image which has undergone a successful fsid change more
 # than once, disk6 on the other hand is member of the same filesystem but
 # hasn't completed its last change. Thus it has both the FSID_CHANGING flag set
 # and METADATA_UUID flag set.
-reload_btrfs
 failure_recovery "./disk5.raw.xz" "./disk6.raw.xz" check_multi_fsid_change
-reload_btrfs
 failure_recovery "./disk6.raw.xz" "./disk5.raw.xz" check_multi_fsid_change
 
 # disk7 contains an image which has undergone a successful fsid change once to
@@ -275,5 +312,4 @@ failure_recovery "./disk6.raw.xz" "./disk5.raw.xz" check_multi_fsid_change
 # during the process change. So disk 7 looks as if it never underwent fsid change
 # and disk 8 has FSID_CHANGING_FLAG and METADATA_UUID but is stale.
 failure_recovery "./disk7.raw.xz" "./disk8.raw.xz" check_multi_fsid_unchanged
-reload_btrfs
 failure_recovery "./disk8.raw.xz" "./disk7.raw.xz" check_multi_fsid_unchanged
-- 
2.38.1

