Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D872E7366AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjFTIur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjFTIun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:50:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69EC2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:50:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JNj1Rx013037
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FeQePSOGg3ovPqiwKTV/XwsBl1/5fC7Pz0ZESx5FSr8=;
 b=RD8pnF97SQvlBqL0HenOrq7IfVyZY+Dqp4ALq4c2occ2JP+Nm8jut6hzbZMQNVh/4v6Q
 gTxE61CjoaxpsAIELn8ijF6LHNtf7TiPTo8xgDQXbce8luwgGJxlrrVapE/PShAq64lS
 q6OPk7xuXI7B3cKbGmq9Z0kII+BuWfa0gjHse8jmAIwASATMbXCRCIIHW9/BQdyKwFPy
 TKi9PnnCNHuiuWTPlgk7TiGE2sbxh3bfJOGtrqNEBLnhhIkfKsV3odxxb1ECU7TAwdqS
 qhrSnLvRmjY1gB71hU4xGOwVHRm1j4f2b5dqIMx8zb9KHa1pK4i58Aj4ebDLNH5s0TAL sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbm7vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8UXiM038712
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394a5hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJQhfrWkEuStSCmwo8551YsBYkoli+hFGIxSd4E3JdQnpkoenzHICs8NKP+3haUln5JTZJEzeeUcVHl0OAX5pZRfwanCY2vcRlFfaSXEZ2LUSQxTqQkbh7MZRruU/VFD9U7aqr7ir7t6uqYzunAX4mFk6rlT6BcW4vlAhvH/nD6N86yNYwRP2JjwxjtoNOwd/txia51cBCBiaxHyDeX2m2X2t1yoTcn4pMcZBEwr3kByLngGiCu0EKG7FZwFMJcj3aCOnIoNAb92NnWW/Ry1bofmd3XeWYI8ujQmCzgyhBJJhrbohjmFvRmAaYSTpc+RbSSqOZOuhz6kXIAd191Syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeQePSOGg3ovPqiwKTV/XwsBl1/5fC7Pz0ZESx5FSr8=;
 b=T96T5b4sL1iLG7Azt/40BTf+lNww4jsAVuBiLXlMERDCGBCC6Pu4wDoZWnt6SPUE+TOmZaz+Omd46ifNyQi40n9SlvSwWSXb46HnXQZ8avC0sgeAFhatiuzm9jbFfIBp5Ewuc1vEJS1Q88qyraRIpQ4HRr8vrpdeFejlqqUY6uDp2UkDK6VMrTmpKwZ+hosw6GCB+yCxDUHrdthZHPJyzK3JUgUv1VxEQLhNVlXAh8mwjggPFUJ+UM1YDFMSxnFGxslIXUcz+q/Yyr3dVNMa+81mYtcp29DsgNSCYtKS8ziJe6BswIcieUiD871VBlrpRVwpXNi/Q+8+8Aw7WahLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeQePSOGg3ovPqiwKTV/XwsBl1/5fC7Pz0ZESx5FSr8=;
 b=VyPgsJ0fPlrPTrvvPR/cu+N6ZBO9dzMCUmGTOgFdg1+rpDEUnOv3FBiMKLPA3F/wTynz3ulMm9iNIP3atAK9XrL6N++ddgvSgjpnWmMkLZFGX5S1aQoPyPGaCAjm3vYzuE0eb4qQCEI8EPWb2SiO/EZLH/kPVlcT2mpHIWYGYlY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 08:50:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:50:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/6] btrfs-progs: tests: add helper check_prereq_btrfsacl
Date:   Tue, 20 Jun 2023 16:49:57 +0800
Message-Id: <6ace53b5d32b7814cf4770bcb5bb1d2f4287d490.1687242517.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687242517.git.anand.jain@oracle.com>
References: <cover.1687242517.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b431c2-7d06-4e1a-d613-08db716b644e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPhq8NbCRDNtXkrzQaKoNorPZzMXDsI1TyEPrsZxv1Rwyk79O+gotmLMXDD7O+Swy+e0IoVoccSgQB1ae4kTaKSGSIe/5PI8g1V1Fv9CGixKbzcxX86AgVlOTTmwkUTjKqJrAUVPXJxUZQ7ezNBRMmzMv6eLiXMowjR4y9Tte1CjbCPy263Jc8Zjrbno5pDLm01K76yfAe5bwYhe90kK94SzF17JCWA97Z4vGi1kuv4M8Qnjdk3QXrBO65ygOrdAOq1D3XQEm5NW1Nq41DCxklWV0R3SSWkrcd5tJ016ZMiRsa7U7K6IkjT/VNg/RHo3OTN3rHpHf7erKIovoy/lR1KxDRjeqEEPTcTlO4JyHO8Zny6iGLqjtxnpXyUFOgVv9tYm7waDQbK0WqLe2/3L2NOng0z4rcoLRq7fgDlrLVqkgvpXGVgyBlxJj64xJyi127p3H0tiwVmy/B3LEOJnFhh0C/adliXgVj87snVr5dBoAX2eTVOwaPfUvn+Jp9dtokbKIpt/Pm/LNtBR+tX47gVpCwQwzulXolMrMZAsSvwXG53q8rC8cU/lXYWEDBQq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(186003)(6512007)(6506007)(26005)(36756003)(2616005)(86362001)(38100700002)(107886003)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1iQh6w55oNdrQLqn5JsLNZ05LCUWJKynFcForjaIgvcwuVRn8NafH6XRJoxl?=
 =?us-ascii?Q?OHP5RId6c0i3URX2/Xt7vzU/WI0L4Ex75TkSjm+BpVIrG8NNH6e55ma4KWWR?=
 =?us-ascii?Q?/VP9XOemj3/ZUh90orCp/SVS+rj1s/qy0tLB61RskOZuC88BHLru6BeCG9C2?=
 =?us-ascii?Q?cQyZ+JsVhyjxvGEFvarHIMAar5ZM5eitcBqhZx0FUXHunYaVrmFXbYYAFYs0?=
 =?us-ascii?Q?p4Oiq9pHzi5T8eRD+4l3K/Rmda5RmZ2thkAts6eqvBwo/jASvstqn3mAXb13?=
 =?us-ascii?Q?5C1MTxDDWA23JU7ksp6QnoX2AmI9QipKLyDShsQrc5d8ZteWXJvOSpcIFLE4?=
 =?us-ascii?Q?nzsbMIGRdYrpCzKsWO/WWpoTzbNAnkld0zJZVPHJWMJzG1DdIiZ8DIRmnZV5?=
 =?us-ascii?Q?1+gsBNHjiwPjKiboCJPq+WK80eDVZimaqCwdOfJac1wR3+NbeNvwHY9BgtQi?=
 =?us-ascii?Q?3gSlB9+Wgw8qQ7RVMLGB60wdHw+yQ4sQTs1mQfasW1Kw1szmiS3e5/XBDMFq?=
 =?us-ascii?Q?+n9IOjKlTcI6lukx7HeCpl70Jk52qZykk5nogsHdumuUc0OcfGFng+yvsaYm?=
 =?us-ascii?Q?JWhmQjjcPgQHpgnX58OtfNwthSy9dQUOiINKdWjmUxtM5b3zL300sZYAGFOz?=
 =?us-ascii?Q?8wRDJcrfywznxssIo+xo8ptYKKlhhte0QOaO6UOswiarKtgdWuAk88Z4kQVR?=
 =?us-ascii?Q?kQ04wlJ8vNc6UApTN0fOnoeYFibobuoZtbg+ns6rV/INVppbZoEHN06kTUxb?=
 =?us-ascii?Q?Q+cTCvaks21WYRVFtIDGdOj6fhPrJ8em/ROZ6EY4QzTsWGnhalyRZJjKXTSf?=
 =?us-ascii?Q?RB98NA2jgs/QyyIXN/0oSxd1tEwMwLN4V7PyAjJWEDGaThNnLpLkcI67Cuw5?=
 =?us-ascii?Q?XYN+1t/U+b/AEu2gmXevDQs8ukb+JsUMvW3eXfPgnCDV0sMQ9upOpqa0BUfA?=
 =?us-ascii?Q?1LVKHH6+PgvCXm9Sjt1quSdNZkLzbkSgQnSJFEuSuNXDYp3OKBzihCJUjkga?=
 =?us-ascii?Q?JcjAptgkXPJTk3qLFmsLzyrWljkd5u+bnE3tAbYZIKRpe6yp3O2V/Oy7C76D?=
 =?us-ascii?Q?VjJAoCGI5ZxorIqc6GL9/hj1BpVBPmfLucy86I7IuZYjcP5H5gSIUHQNLSIv?=
 =?us-ascii?Q?lAVXTTmO2nMGrMEWncCo0ckq/GwV8SO7Isl56PzwRCn6/ZAM1PFo02xhZWm9?=
 =?us-ascii?Q?ugLnRtyWw8AGzjYHB2pE2JhFeDbA6G8F4dDfy7gcF8vwA19sscIxbJGyqtmA?=
 =?us-ascii?Q?D+msxVt214LxUXjQYpmXzzsK2sfhjR8Zw0FwDy/Yd1bHeYX3g35n7O9djVg7?=
 =?us-ascii?Q?dxzkmWoY0qnofS1KdJlCDjqVH91q5qQ2484qJ2TokwgRFiRE+rcOc5+KGu9F?=
 =?us-ascii?Q?S+cq5jMErGref56qebJqzbOnpywm9B+2Q/XGXBw/BqNA+nh6TMoxa0xxMgA8?=
 =?us-ascii?Q?Zbby9dE52g3z7GpUKyA9hppFMMpwQ7BWlsOhE48ThtdplDZL3r1siQRrv9tS?=
 =?us-ascii?Q?BukKJOB6p1+EXO76H8Kgorlu58ILnOywx4mBpWoV+Tshyk3jhbGAHsBK1Fb6?=
 =?us-ascii?Q?UIvktwYO7t3pp+P8YO96M1g3Icja0mbV8zkIUSTI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KoW3UMJTxYdzyo9/O7tBVxv9iznAD6v2YSWwVSUEhjtg+AsutZXFhXpZ8sfHno5EkSTJiYfjj7+q9HhTCSGZZRL30ah7ZOe0wI0Y/LPvWscPD1+WrtztWrwb2Z+/zNWh4X5Kcu/+k8VbiOHU8PnH2XE9JBYqm6dj9JYUAGz7HIivkxcwmU8BZrxq5ysnEnw2b4cPQn9b3ZkYFaHHo0bVLMsb5hPcukOyKBPlFxVF8uEZFr6nhsh/0KF4a5r6ms+iu6dY4j4Kj8obqOgYXYYevzS1uEQPoaFgx572Y/oMe78gRpwPAJr46t8UvNUU1z/mHJRUnM2Hg2tzB2gw8tC7fVg2FCVFLtM3DuAbt8VCEI15H0XBUpaoAhM4QGbPOdv2YxNTmsSu14z9/WwFEYr55h4hP0+UUYuvyMPertInanaN2DbI8Ypcs5kW3LB+NKdLCY6EJhqasf2xvmw40H5HMOHSuFPtdCJ9yZblJPAQwMyV46z8K6Ulkwxf/Da+0ftDzbzNNLC1wHn9HHnvN7yWkOjT/94OH6MauA92Y8hpBmbkNIPQqGJR4q6FQZaI0UmrGpyL3p2HRSoaI1ZE0lKjYatN2uWpsqs9HIXt+pXrgMYs+rYFZZW3b7pM5w5wDXO5q2+VqKT09vFoXGERiVftLmywdiEUXOkb06c8V6BFMU9RJJygfZgPAh+xwG/bmoHw82e+Te28h/GJYOWjdnY6e6UsJtwB8p7y/JG/vJc6KeL9LIDG6jpol5OXy8RfWkQhf7ZbRPsAuKdk0sO2QLSTHQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b431c2-7d06-4e1a-d613-08db716b644e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:50:26.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQyaM2bPWhAIjdk0pCqAQtEq/vG5zPXljnTjGbkN8FnhX/GETS2Pr8fLUfOP9LXqNEkWjdnPEaPgact9xfkI6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200078
X-Proofpoint-ORIG-GUID: HCeG9mJ2tJfmjpR7pugP82XOGINAq8Mv
X-Proofpoint-GUID: HCeG9mJ2tJfmjpR7pugP82XOGINAq8Mv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some test cases are failing because acl is not compiled on the system.
Instead, they should be marked as 'not_run'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/common | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/common b/tests/common
index d985ef72a4f1..0c75d5d76c44 100644
--- a/tests/common
+++ b/tests/common
@@ -575,6 +575,19 @@ setup_root_helper()
 	SUDO_HELPER=root_helper
 }
 
+# Check if btrfs is compiled with CONFIG_BTRFS_FS_POSIX_ACL, requires TEST_DEV.
+check_prereq_btrfsacl()
+{
+	run_check_mkfs_test_dev
+	run_check_mount_test_dev
+
+	if grep "$TEST_MNT" /proc/self/mounts | grep -q noacl; then
+		run_check_umount_test_dev
+		_not_run "acl not compiled"
+	fi
+	run_check_umount_test_dev
+}
+
 prepare_test_dev()
 {
 	# num[K/M/G/T...]
-- 
2.31.1

