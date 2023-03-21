Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF216C29CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 06:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCUFYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCUFYU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 01:24:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A91196B6
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 22:24:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KM4RVU030338
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=mh49z2QPokhGd1yWWTxU5edcg18nH4OnQxXxMzeTJfs=;
 b=QxwoHlRhiUHSPCksriSRYTTStQaOEDUD3gX0NgjnTaJ/dsayQxdemkzMAjrwE8Q/PDuB
 uDI+LAPRRvnFehJlA25iTU/Rw9UFx4pnfrobu0I48agKY8tSVeeDMllT7Nm9BuMT3Qy3
 Nut5Q2TezBVvA9FkvaXqMAVz3UAlKaVK455uDe4OOA5eWNuhRNQHebSLC0yix0CV8mGi
 aMZNva+QLbJzr1FwLKXMwlNZYKggIAKOiDYWhx0abMr1ZOXhmy+NAF0RdfNG7dEg+Kot
 jeoyAHix7qnm7qhhFN1+lT5NwCTe6nQI3A8MCHr7NO6ShEShywzhj5kATDw4snhP1/dQ 5Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3wgda72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:24:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L5I3Qd026583
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:24:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r57pse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz1h7lQ6jiC/pd3iZFDsngf/zNEw5K7csaPJlnQHZdudY3uitQbuS8wUCVECNgLuvQ9mMVylCQgcgWNXqWAnx3NDQpRHG1sGYCFbWxkH9gzhk2AqlipFZs6yIyn8CFvFOMgdPrv2K4mfT4DyFYHiZScWpnEahty8LwlgiAm/Mxl/W9kTjX7GO8ZwYnDycXHJ5ahHzntvu46BMXvXrDUcXTyJlMLj+L3i8acNWmT1wVbyXFPpii7Cg9AsS6P7z31dvTki4izFDNNNo9rFoG3r1FTlUTWiLnjiJaiWLOO7LCdxc54Kjws4T4roQ6mvQ7sE8mEaGgNligik/pmK24UiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh49z2QPokhGd1yWWTxU5edcg18nH4OnQxXxMzeTJfs=;
 b=O4uPhLvzk0iV6HZflUMbL5vqHPkObSIwnpXgq1nL4mpx2AGWYQ0flCokFasuD25dpcvHX1j8r36KEm4b0xjXSVWr/INjoJ+j5abVmJK/TvmWSalMm3fiTA3J82H3NRMJAzcCXk1iboh28OX7QBKiuRYsoKucN/f9HD7gKqfurdF0WGJGQ8Hi5r1t8LK2BlS9uWDipl+HFoMimpnEvPFHdYrVFZ5TijTF/6fDYmqSwy0ckzft4dKfjmsdkgYikgPcDTzStqHySFGDmbIK85sMXLmOl5SONwTlesCti9zrAyxBcfAXZ063HIzzJ2Tq96fG35TyOjwnXF8cezeGrzuvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh49z2QPokhGd1yWWTxU5edcg18nH4OnQxXxMzeTJfs=;
 b=KFuCVLlnajeH9+QmtB5UQ0NC7nQor921QihWt5KDIw1VUVu5y1nQ5OSkCBtfrxfNL1wwDTJH0pefGc2iLY0d2smmEVbo8VDdnVQjIGdy3l1QFe0hxwBhqntk0ECggSUF9nupTTFggjzm8WwiwYKP2ZDe3iCYZ+6coPf2vlg62z4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:24:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:24:15 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [RFC PATCH] btrfs: remove struct scrub_stx for superblock scrubbing
Date:   Tue, 21 Mar 2023 13:23:54 +0800
Message-Id: <10d0f55b196d4dc949f0ac29f2f0af023eaa7523.1679376183.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9a990d-1bdc-42f1-f934-08db29cc82a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZLKfg3Hm5bI3G9BXfVRdajWKsY3aoF+uoKBOWOebBlGJ4rFCJ+iAh/xSU0wFmmK8QSyaETFSXihlzhHYubBeZROmZptq1rujr+ZnzXs/JMuRM/OW9HrNUO19/O+k4kZrk20bgVNZFgurQNItXzoeEW8vnANrvA3neWOTVhmm8GtgrX7ng9sfByQwQspoe7POQnQxepatQLvvzqXaHslk/Fx64KIHg9z5ppLnr8moy4QPWJeZta6ropvGgTmwu/v/b+DA0+9cutIbqtSpZtnCLcP1NddbWy5LcgZ9XyyzM7Ik7DI6efjEDKwj8sHNiglcgkMbF82j7L9dqcY3gVYQFu+tlVjh6Xok+z+uhe8YWnRZ8UWox2pgKoNiyLTmA402G2/8Y9qmIImHGYeQmoZRz4j2gFpdBhagA2GbFAo8mA9FgtbPlFio014A99Ucz83etVIJLHnOcXwJ4+a8tpWgbJGiLMU+1JxrPefCYXbi+HoaEHnvxD7hS0rJWUCLPEuCKJPJiJNAl5gudAq/BCrWhn/JIAo2jYKn+6ZF5JTJRfbKECWe/s9e2UDT3zUtRbPKDpPwMWSqdiLZuMRZUG6FTXqZc3HZAlBGmciDeKpqP2xB2pbDNqiji6D2hSfwzeidKGhEiS25Munh/XR/wdRtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199018)(44832011)(36756003)(8936002)(5660300002)(83380400001)(2616005)(2906002)(478600001)(6486002)(316002)(86362001)(38100700002)(41300700001)(26005)(6506007)(6512007)(66556008)(4326008)(6916009)(66946007)(66476007)(8676002)(107886003)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Q/0+S9KBlwYai3gVAZYfuLpQDF2115cMDF4a4huFSu3SqWg1matQ3MIkct8?=
 =?us-ascii?Q?KYOTx937dr0uc84J2vQ/aRTvog6bfQVgJvA/+zWMX8wI1mtpf8m/O5KaTxzM?=
 =?us-ascii?Q?0XANee/FeTFmGCl7iu6VASf/tL/+3AgJVqq0Otq4YO+7QV/LHezbmKRfwhJv?=
 =?us-ascii?Q?jeqkFWvkAiaJyROA1UaSRnZpEdNXS7BQ+uRG0BPprfwLxQTPZhMXzdufA7Tu?=
 =?us-ascii?Q?DX3X0sRtBfygMbO0t8ENRTvHU3E/5LgZgxn6JYLEY1IdRQl+pE6Ejx7lkxh8?=
 =?us-ascii?Q?2qFFCNjPVNMEDDnsr30YoyK6jQEl5w/fc2xDpFo9foYKIdqIXPs3PhyRytmw?=
 =?us-ascii?Q?+7y60i4I9Piyoj+NIbTbMnoxdE8RgCsEhdMFfNKrSIxL3o8PWJVZMx7VHpxC?=
 =?us-ascii?Q?PlRhImiWR7XK1B7z1bgTJZveXRF4CBKS2Bbw+1QsM+Iz8El+GQdM+2E0E7zi?=
 =?us-ascii?Q?uoS8tNsKgm7/ywmr1J7ahL7+ZiRNWcjOyZK7t4oIzbvHd0j4yEW+yb2h+zWh?=
 =?us-ascii?Q?OzZlvXr/lW9XggS9pyizJAkauxA/d1yd+vLWLvJKlORDdRGcy7Np/sCXMZ9p?=
 =?us-ascii?Q?nNNXFAYq5cS//QMgtH+RU4lN+129fnd639tVz1lncgp4ySxmkdFjBBB6q5sg?=
 =?us-ascii?Q?AB8mv5MgNnH8CzWlhsTCCJu+tFYXOwiT50zO+aVvqx64Irzb2U49RLiu9s02?=
 =?us-ascii?Q?F0JVZbHpSjT7Cwx5yJXspa33/KrvHnqtkb/pDkF/waRfOLEhtaWu1Tw2FHB1?=
 =?us-ascii?Q?Dy2Y0Oz0oq4f/ZbIgDBDATa5G6kwz4XAZ+VNxSKUHhdF78UbVZ9pyLrHwxgv?=
 =?us-ascii?Q?OAEdPV+A0lXgQ+aN2qPsi0x0PC7b47fZyYzrSwckw2RTJm6xpy/oW4e075AF?=
 =?us-ascii?Q?qe2IUkO+VDwYgJSdbIE0KWBrLn9C6Sk+5h3h99NzA5yP1Z8l0jBZdeyT3Ng4?=
 =?us-ascii?Q?jZqHY3Amuo8tPTZcB37g1xVfAq6WfTHHT1lwPaWmHf+0U2sk9nzl/LG3wfYE?=
 =?us-ascii?Q?dHWKgwiLcCUZBRQcrESDthvBQZ3n74SwuTEyY9n1M6D7GynmmCytvBWzDtHQ?=
 =?us-ascii?Q?KmO3XnoLof/EcI+3lhkau6Itun7K3XAdnh+/Bq+xmyxZ5iQhnXpHpDfVSGkA?=
 =?us-ascii?Q?yH85ni/XJRPXK2txDZf3j47SVpGVYRAgQDqt0rE62U2sLhY80ym8cPckshGp?=
 =?us-ascii?Q?nwD+f4l3kLwvS5NDcT2Ej4DMCxJlSFmzqsbAHoUWktm1np+riRI/dV11qXTH?=
 =?us-ascii?Q?GC/rrLPQyxY2JIh9W2Z7Y9D8vzZXUXk88I3UTJIVaHU1LjyTfBuv3FszH3mm?=
 =?us-ascii?Q?nx6zdNSxndO8t7XtvjmhQtpsV9IBEkGnVyOGWy54wQU5mYfyWetvCtxWhxex?=
 =?us-ascii?Q?GSaFwF0ro6JM9sSN6VwKB6mhj+c0Kvb5BdeoBnQrs6eLYD09DveWyHOUYhi5?=
 =?us-ascii?Q?3XrbyBwKPctKdgyU/oKO2G3ZOrN22le34uLOHLFyIDvF7P6M2FbiRQVB7Hn/?=
 =?us-ascii?Q?8R0wzr75MA1OW/H0sFrbPuASckjffC4VDqwmrAsZ692zEVW4wau5ltW/HMCW?=
 =?us-ascii?Q?G6iYiEOLy0yt7hzkxahQHozAJ2chNT00YAtdVqRU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oojBkgQ8vyY36yYaHORVv0GL/naRS2OALVGSGDAJK8rzon4B/mq/HpSUMetMJsp4JbQSKuI3IuA85MIE9e/qkJIcFXNOqPsU6HVFA5d9JWfi4ittJLFcnGle2N9G12j3LqCEzJyWUb5Irh9qAXJql1wHr/mjQG/Z9EQehtpn84hsn+fqC3VpOK2foki6GJuLTiE4NhXN8Z3vAMC1O1w2ekpLB50dYIOvT4qoW/wOk7vUe38kECz9A/kqWmG57uuIazus1o8n/dZxzL/GyY9tRkGP2MLH0ofgyl3IYNgzy3yuHLI4fTOhPosYDFKC3qgHHzDggrjeiXNdYtO6qAJBT3ntNbFt4ckz/enXllk+E1v+dr25MKF1JnnVmBtxjtk4YRpfcT8yVgRCx2FoLmwXO9MV9INNN3G+/0gV2/6zGVStV+BMzoQuM0kFNjhY/mNevHXxvsKg+Lg/CbbKBlw11UF8q5AGk2d35Jn9JJ1676t48HjJluGmqdSsbulMdMvYhw6bels6+VzOPmuqegHLRFWCN2lCz4dDcnYwNb/VmxtoUr7wJbA+Mw1MdkgQnmKMhX4L4J2W3VyHhhfRvdmQlqUcS5ALc/6RccJuUeJ0U0l/ZlMB7dezFuesSb5hAsAi8bPh+Vs01PtlHfOlBPUW2phh1r85B4Qh7sXY0s3RuxbLphc1kBPIxHZsuQTDhboMbQwUlrezeAaxVG3zDhslchO84x/soC1P78pT24D4xkMvh5dOAJ9gHIoT6tPX7IFiyl9+aPmmGyUMRlhmHSnFxw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9a990d-1bdc-42f1-f934-08db29cc82a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:24:14.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StqqjRgY749BiScYmBijkwmGeao9cRyD8KmdunvXlUtT7zpYDMgoRQfahUlG80IrlqImx0l0PlO1WowfkmbBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_03,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210042
X-Proofpoint-ORIG-GUID: jGrP5fu7_zudfuZy_-CVJE08h0Ug8eu1
X-Proofpoint-GUID: jGrP5fu7_zudfuZy_-CVJE08h0Ug8eu1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following the patchset that implements reader-friendly scrub code
made the struct scrub_stx is no longer required for scrubbing superblocks.

  btrfs: scrub: use a more reader friendly code to implement scrub_simple_mirror()

Therefore, scrub_ctx does not need to be passed as a parameter,
(unless there are other plans for it).

This patch cleans up the code and is built on top of the above patchset.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/scrub.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index beccf763ae64..bc87277559d3 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4909,12 +4909,12 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	return ret;
 }
 
-static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
-			   struct page *page, u64 physical, u64 generation)
+static int scrub_one_super(struct btrfs_device *dev, struct page *page,
+			   u64 physical, u64 generation)
 {
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct bio_vec bvec;
 	struct bio bio;
+	struct btrfs_fs_info *fs_info = dev->fs_info;
 	struct btrfs_super_block *sb = page_address(page);
 	int ret;
 
@@ -4945,15 +4945,14 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
 	return ret;
 }
 
-static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
-					   struct btrfs_device *scrub_dev)
+static noinline_for_stack int scrub_supers(struct btrfs_device *scrub_dev)
 {
 	int	i;
 	u64	bytenr;
 	u64	gen;
 	int	ret = 0;
 	struct page *page;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_fs_info *fs_info = scrub_dev->fs_info;
 
 	if (BTRFS_FS_ERROR(fs_info))
 		return -EROFS;
@@ -4976,7 +4975,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (!btrfs_check_super_location(scrub_dev, bytenr))
 			continue;
 
-		ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
+		ret = scrub_one_super(scrub_dev, page, bytenr, gen);
 		if (ret)
 			break;
 	}
@@ -5172,7 +5171,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		 * kick off writing super in log tree sync.
 		 */
 		mutex_lock(&fs_info->fs_devices->device_list_mutex);
-		ret = scrub_supers(sctx, dev);
+		ret = scrub_supers(dev);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
 		spin_lock(&sctx->stat_lock);
-- 
2.38.1

