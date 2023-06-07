Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B428725B2B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbjFGJ76 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjFGJ75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 05:59:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C41735
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 02:59:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576JoFO017995
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 09:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WFyx/0EHsESftCnzqqieQxeqFoLQOA8Ww0Ikjz2AQfQ=;
 b=hl2MNATNddzkVgbe3jZ9Jw3f5jn6OE2v9MMF+DCh1d8RfSm0l38tfMnBCSf+U9sim+t/
 9Hy6fXecvjFgfchYa3DnRro5KTzlcymrYSX33hQJHGt3xqOS+5MRxuao7yPN1zQrlFcj
 kfvCn9v88zEVq0V6OIG8QPWURkR9+sYr3qqu+LlnsTVP3fW7aMnHwbepxRg+ID2Y+IkO
 WA6KZbUXLNSwwIPebwGQG+RQm89ZGnxVRS74CAVSHgTnWe4LU+4a0hlvuAWgATqXnT4B
 WZ4wDGjS/4uqbhXT3H6EHm/l8Vk60mEhA/VCFlCwDGT13hatuhKT3U/bLObMccVCKb86 Iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u9c92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 09:59:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579amGe015682
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 09:59:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6kh6k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 09:59:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiQFZAdi68oclQKJLtXWvgi5db8pX9Ce+LYOAl0CAgt2g8cxknjNEqseR9cMBVz5MwJQW6VXPkUzUsa1ztt1lEWvs/5RbwplAc6HP4AiS3ceQkd17ClsCl35/NH5wDzEe/4g76c1eCnGRc03cGGKeCEWubBYddpuPp7QkLto6Bnzk/Wv1kwhOadOBPh/w9DaL2TcPZNJsuye1Ra+ljne8R3Ku5t3nvzN84C52BEtSKztvB8cgPUJIiTu3/6O0nQ8egMwF+kFYFSe9uWMj7xE7IqdhaYIhnBkA1NROQUDS6InpI4Si6r4oNO4LCJxYyC5w5AUzdfGSMMiKR22o0/0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFyx/0EHsESftCnzqqieQxeqFoLQOA8Ww0Ikjz2AQfQ=;
 b=EXEzQ+cpLBZ7ssHOX0ngoGRWY9LWBtnkZ5D8aC4l/S39MAwfkm/vzBgSP5pwKY/umSuZeNfgRIlzL2z0+phlH3gx5FayCaGlIkrvYQeXlUs91wShkzfrkiWZbwQ9udMsm2vqV22H7xxjzDwWLVN6oLwJz1s+M6uP4rCsSj2NIO+ifUYpZqUWJwTKXymOpX/nduEW21h4N1Oqe+2g7itRyJadyIptiYce0aN5uGedBz4dRssZGr8yjSvAfnwxyEpZdJaPeyopdtRdtO/IWItZl4CYwYPA+ubvQ2wQ7k+iTnQDcTwYkgxkC9mWZACI8qgvsjko8O7D0qsiHNjBNoFvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFyx/0EHsESftCnzqqieQxeqFoLQOA8Ww0Ikjz2AQfQ=;
 b=vGqg8h01GgRSB3mwTFnofqPGTeCYxct9B6FpE2qGCYPkrhUOb79gzaFyQFQDpzUmqPNHSLUaIanJU3KZ7HAlUmpJcN2H4SPoF8e6jV/s7/BBykd3GXk0xS2o1HrWb9op3G0dkZ1M9Ryt6HLesLXPXtgvNVelsPAr9zTFnqmLLOw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 09:59:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:59:52 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 02/11] btrfs-progs: check_mounted_where pack varibles type by size
Date:   Wed,  7 Jun 2023 17:59:07 +0800
Message-Id: <647a6dac9e1388b45b6f219927488cf47452b3e2.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 5055471d-67a7-44a3-8446-08db673defde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHUYujPPYaGVwnZa9OFKjk1vgR3aMPR/uVPf+rUJ6U7nBE6eDCESDRw4+uDvAjy7iaNqLRRYupV4+KRsUxdW3JUVByQ2rYmPaXI9tz09eZZw7kyaws9kKLMJDB+S+crkYgTtpRB3NPG8XBSQ8o0YSOjdGnIJXAo2ODANUZBektJVxjS7BgZZNjgqLahJN4uGn9D26djQPKI/Mame1dPBOA/cdIKN6vis7FG1nTfkCBvIG/JWVOcVJF8Q9PA3ZJbmYZzXR6f8gCIdRzTQtqExEDzCNEiA8+Oxcpj7+vtw7x3DpS6Rg+dSAcx5Ub2Dgc0+SXu9LBV/BEzPQvYa72ngDzxy6rUim06EcQyiB4EofvQ0j+QIiT5PdmKhHSxF++58sProgyWC3SbL+n37quxh94mpzQlCAxu51ZAzJIy1XDDOIi523+ctlFjnN9bmaN6rH0V33auy6EMUKMtYZYa3ECTqRuBEKEl6myjjlsbVIZZab9nIZg7rETeZKf+gtsf6f1IfLr764O/d+R/h48ZPTltYZvpVxk/UNgzOoeFxXv5/7nlSTtwwEcPKqVJxz41P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(4744005)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o+zbF0LQyInfS7urn1KMtT/eMmH7y9T8RAx0jKWbarz3kmX9XePKXnH/ODfq?=
 =?us-ascii?Q?Wx4fpgQknnjpScuiR6hBepuyT83Ok0Qi+S1iZryLl+/creJnc10HjvxnPD75?=
 =?us-ascii?Q?nIkVlrZLLp+O3j/TtSUfYwPONRcLKPSM0XmK+G6ZANEw4GDwtAB6WSSbWOm3?=
 =?us-ascii?Q?Ub4ApiBpwR6BvlvojeHXoSS1lLm56K8LnbkMoMVWgdEuCady1AD4YMIKiGSF?=
 =?us-ascii?Q?plxOmvjNjC54h8vqjYQHszsCdB9AVADrLBv+wMTNCiSVby3FWce1+/vRiX4W?=
 =?us-ascii?Q?fh2i01w1uXcqU4ROnoqa/VMSqDq46Qx/urHGI67NP631VtaDK/XZc/wATkxa?=
 =?us-ascii?Q?sROtzqcu01eGcquDpLBv5ra2koTB0Tp7ly2q9RjNRkmNWW+9iNEDIbgWGbaq?=
 =?us-ascii?Q?K0Uwss33BxSgCq3GTm3lv5ulfBfaKgxHJaEPtvFTEPK0CfmSbiu1v7VYhzJ4?=
 =?us-ascii?Q?lnnOgbWZ1lfBR4xzrt5ds79l7ONQ3GawZwVq8jCm25ZZOQFZ+Mug90eJ8xNc?=
 =?us-ascii?Q?SfUBJcLn639OiwLe111tYvL7R58VimWNYWyNaQoQZ/g/HDTaI9o80kWcpEff?=
 =?us-ascii?Q?jJr3G/LzpyD7Gz2425W7ab61OykkZbsRXCElB5M+vHVtrXc48emKUhDjOQFl?=
 =?us-ascii?Q?9AwGHeQUOUjq+Uy0nQOe9TN3i1SMcBQbjeR/6mjEjhdtJD2/C+CAM3SIY/IM?=
 =?us-ascii?Q?dD3iZIskCf+q2TCyCnbLu0Y5uOD2XEeXkcm1CrwlZJh0B2Mt7gpMa70y2b5c?=
 =?us-ascii?Q?L+nh79S2JeZ0IGMwT3asMTivH8Z/f8DeCZKP8XgaqBNpNG7oopmTpr4Sc/3Q?=
 =?us-ascii?Q?decjrRZX/SOwM/OqxcAIsKTImtJMp62/qQ0l0ZYs2U8jRZWBYcfJUVHcHDKn?=
 =?us-ascii?Q?kplNeuJTp3oGFhA2R1Gu6vjAonc45Z8Gp9Xk7OdjGc44VuUJwhRP1hSCETbi?=
 =?us-ascii?Q?yoM+YAHUHmbiUqFfWvkgW2RY0gtInS51T370KPbl16MErXh02VZ58dwVZzXj?=
 =?us-ascii?Q?QbxB5mZNiilLnWzSMOr47ydtoF7YKDxRpe8mJkfbvqnXL4J6TRoUCH44RGPL?=
 =?us-ascii?Q?DBeAONZgyBHhATdfjoyXlkveBuZYLrwCfD+/1kby51VsTCSp93ePhNFYEjOR?=
 =?us-ascii?Q?H24Tc9T+JwyG/To88zFi86rNSERTMPdDnxTs6WhH4rzaMkFzVlZDZxnb/zKF?=
 =?us-ascii?Q?+y6FDLEbGjoHLOEOY7sgQd2fpN3yeZhv+fkHR5sSnxUYl+PKOoGPCdPm1TXz?=
 =?us-ascii?Q?oTPQJIPQmn/sGiaN95R8cVfIpOzmj6P5yrxqI+SE8Q9LqgYan8zqdVE8mRI+?=
 =?us-ascii?Q?Byu48HGIRmiYk3/iJbut9hHmrs/HmPrlsSljM6Q7R84sofwZ0h5aPchzvxLe?=
 =?us-ascii?Q?Xc/6ZSWSDr5DgmQcT4ErCdPm2lPoBJBxqggZIWIm1Iah7IkFXvhSHNiTBoUl?=
 =?us-ascii?Q?teP1l9mO07o8N43FBNxlcPs43YWYWXBsf85BS6SzFvcNS8/X/fGuhhEqVuBG?=
 =?us-ascii?Q?J6D7IlVHx5lTIjvmBcHAnoTzyeIxZcWpSX9I/+PrB8hBp5u+ZwbvQzUpI1fK?=
 =?us-ascii?Q?oFNUuPA4cTRnbMlyhatn3OMTj6MJDkAV0hE3ROqldOimRdh7Vycv5fg1MV82?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d9sHfhSqsH5jWx500vUXCoZajN1xIbsSOpGAHea+j+CbX76+Du9OfCUAiGCF2dKmFY0qCpSBg6apO700XrpD/3ovCc24p+X8eifIGL1m8vL3Cv7YyI0y0zdhDZSRcWnYhftl8waMUXRk+C1PvFlFvXpBBgav3x+XsWqMGZl8bCqUxZPM1n/oUFksuxP9XAMQTmZ60hbO9gitCiSwH8nGYnfrogDEsg6xEE4ZgU7gREi2NZmfnfFIJaEI4t1oIilFLNcLKKefauiuiRWrJJiq4LmlNBpYV+hAFdC6YLOF4yJyz3BJmYdJEAJDZkeAi8pP+UTz8oHuo374EqYGvrCORzueT9f7ncdZB4bA/QldY4l8bpb9GlUkIngpwiqZJOMtlvuVPvFEN2fU6UuCZh7fROg9oskfdKatqjzym/7+0xYoNuKh5WlJmTCOzp4e+Ts3xm7PxEmtxP6FJuwD8ZdHjFMJYaH8cBIkZ//07rfMZbpI7Noz2jmaIhkZ3rwzPRDPcMj8JFXHZVn8ODGLIDh9wTbZO3ejc13vDk9LOldaDHeDyz/KfKP6UjthfP4zq4kSeLfAcg3oNHjHH5XV8BJManEvWa1Cy5mxo93VC6eMX+j9wyZlBzRRubrb34+aS2ixX8rPpN1JlKqDuDJEhyzdBN6oad6UKhjSqqz92mV5ab7Qu+XWMbWyAf5nmDpg1tSRdaFIyXKLlZrr83xJ+NkSBL979Dd4AIIaKoUgZRp6ESd7517CG0Dfe/99BJb4n7sO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5055471d-67a7-44a3-8446-08db673defde
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 09:59:52.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwE24VMnCx4XtVDAaKSiSuNA77u6+G8RGuLobWVVyggeT6BVA6TkXRJNu/9ZVmJmKP/rVO5FUJNxv4fn8Bw5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070081
X-Proofpoint-GUID: 3Lpp5grI2Osj8ld3LZPH52g0IblWxM0s
X-Proofpoint-ORIG-GUID: 3Lpp5grI2Osj8ld3LZPH52g0IblWxM0s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/open-utils.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index 01d747d8ac43..1e18fa905b51 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -55,16 +55,16 @@ static int blk_file_in_dev_list(struct btrfs_fs_devices* fs_devices,
 int check_mounted_where(int fd, const char *file, char *where, int size,
 			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags)
 {
-	int ret;
-	u64 total_devs = 1;
-	bool is_btrfs;
 	struct btrfs_fs_devices *fs_devices_mnt = NULL;
-	FILE *f;
 	struct mntent *mnt;
+	u64 total_devs = 1;
+	FILE *f;
+	int ret;
+	bool is_btrfs;
 
 	/* scan the initial device */
-	ret = btrfs_scan_one_device(fd, file, &fs_devices_mnt,
-		    &total_devs, BTRFS_SUPER_INFO_OFFSET, sbflags);
+	ret = btrfs_scan_one_device(fd, file, &fs_devices_mnt, &total_devs,
+				    BTRFS_SUPER_INFO_OFFSET, sbflags);
 	is_btrfs = (ret >= 0);
 
 	/* scan other devices */
-- 
2.31.1

