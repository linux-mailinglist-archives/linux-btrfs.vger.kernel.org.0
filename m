Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8A70D9DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjEWKEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbjEWKEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:04:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943A12B
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:04:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EiPZ031394
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=g95br+fVOYIQI7UtH3/+IEwJNdttMe7Q2GN3EgiiyYg=;
 b=cmdPjzTJYi/Ujw1Gm9r9YcGJac4c+Yapinft5j3XtU1LK3uSurFVd8zflBsP9C1O7DdS
 JHWWUxfPO92BnWaewsqdBN/C2MEBpnnzABKk5IFhYAZpmxGPLa30k1VxJiownHwurRYc
 a3HCaubn7tNwhzoFQBqmtdO1j7fVVbay7ccwA+7yYmy1U8RWD13JJjgd3DNgeaDIp3O9
 aH5hFKmpDNDK47//ekt04pHpsEcnWZcjSwDIVqM2Hlq0sz4bPislopBgveMNnifn7b06
 YEwhrpVech6ZWieKseGTO0BpuuZXTLlZzUaXhy/XaboHbUVgQXmkdOcEwPWHtafyX+dX kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mms8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N9RCwL023798
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8u43hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXpkqvDQx/gVp98BJfjIb8QwHsawQp1G5eA/zmQm1R2kiDQdzGizPMQDG3zmK8euvmSGuX20T3mHlPv4Dzv2w10loJ8DMGcI3+23X4eb2o/CooI2dsvZi54arcuQXsCfLkZhCDFFm9Od2e02oyH3i+jPfEjMV02eyv7yxfPAz0K2GGTis/z5OvmMOhd6jcHmnzGV/BZQq0Ar7o+Kl3Miowpbbhb61G92CQCFxLohwdZ4mgKPkmM9w495EBHXHwjbs1hIqC5UUKcStsxh7DWfYHT3Xe6B84kPrW1SJY4JZxled7M3lhYS8vsBEbWgozO7bsbZBBjK094lIt6I8Zticg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g95br+fVOYIQI7UtH3/+IEwJNdttMe7Q2GN3EgiiyYg=;
 b=Gmd+T2EgqBoqG2gQus6BWltwAOHY/kpBZgNKocNJaSS6ry5lo8hBsGChgDHCJKqxTgvNN8YS54y/z88Yi023m6AN2HtUoyqGRZPEenz+P8R9DNgO0cyp8M8DFTJNf7qaT9s9d7H2eEV18seciYWxZ1giaLNd2SyO8aa6vKeYu5J3VQqfsKfShi+SsjgitAKpK2GkAqPLk/LHmTQFj81IVuhuea1lgMoK2AITDweyNqVrDbvd+0PPYJ4xBKDwJ99ExAht9uBWe47km7ry7PcsF71fCfrhzULDBAIYu+5pJfvGCt1kJeueOo0OxMGzvkHxZBjfpDxT1YMpagxFKukhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g95br+fVOYIQI7UtH3/+IEwJNdttMe7Q2GN3EgiiyYg=;
 b=fkG6fSVhFbOVy+DanYh3frQ5OMlwCJK2lcwoH9txDlaWjgX0SBzpofyv465TFa1BwMP3yziBjugAqF3ATQtYBoS3HQJxULuqn5ESzq1lixMNRJigtzXgPLcp0waKuHgVyZeJt03lXaMiYJpiCefilc8gvGdkp8XQ0ZoatNDsrWI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:04:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:04:05 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/9] btrfs: streamline fsid checks in alloc_fs_devices
Date:   Tue, 23 May 2023 18:03:16 +0800
Message-Id: <5113dde5d6f756818885c39bc8ec6f5b8e45ae54.1684826247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
References: <cover.1684826246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 614868b8-3269-4c26-266a-08db5b750ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kbHL0T45Zek5ymXxO2xKQzNrOCka1GYfVNjHgR5HMzVqo8OuhkrpN7UAJrnmUd1Oh7ToDXlUuV0BOAhwMyiOZCHqyMiGyTYdZQYB3KBufSzx3oDX8hpKvtIO2+jHwE1Z9EvtGEHzbNo7adTuIZ0D7RF+Cf8zdzR6IpSDuGWxvgP9n3CNlOnv2sk6u3DIyLU43VrP582HeUN39MjTOD5Ra813HKUO33PhS5ym8MXkyTfLhqCzKQk99eOy7zMX725+ZyWFY/HtbYVL7Hv8pXKBD6oknGl3a2XQybpzu2MS+goHjxUWzfNwkPU3cHV6oyn8/7ZduZ6Dt8Oa4PNWWUGMKnyup/DXmIUwxgZSQRMim6wkeyU0g15OHowt77053kT9/B6RDVMxrZiBELC735Ivtq/WmdbeZatQJA7qX/2Zhf/K1/V6BtR4mxzlE25Dtm29T9Z5YkRuxrOgfWjg12JPycytrlpg26b/Y6cWwmCdAlWiC+JXmUz+Zdaqe30c+NvQTsnXgPXy27Enc7qiWXO9KJod2bUFUA/i0cGUnseQngHIqKaBBlQgo5wD9OxrrwT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(8936002)(8676002)(5660300002)(186003)(26005)(6512007)(6506007)(41300700001)(44832011)(107886003)(83380400001)(38100700002)(478600001)(86362001)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(2616005)(6666004)(36756003)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ypefPKzeD5m8SYCMZxDRmwB97tkuUCBu6KeFc2LOXAolSRetNUU40sx/s2y?=
 =?us-ascii?Q?fxoj4HwdYeBuqrXEpqid+CDwN9Ulm3ylb4PNFtMxo6lqIF4md0ja011GWEmH?=
 =?us-ascii?Q?25hLL2UXZDCskk3GlUS0bLPuqd7YLXIe9Bglkzz7wtk0oBp3nyMa9yYHTZQO?=
 =?us-ascii?Q?OtY+vEWrY8wUnUOzTiUmIT923VFT0wocKodq4uU534r7C3eEa8i6p6HG1Xsk?=
 =?us-ascii?Q?gLYvPYnwVQIsi2gHfpKtVjDsvvtrQk0aT+F+vbZQApagfthxYYO5v23/6osN?=
 =?us-ascii?Q?sm6kJV87IU+n/bP9dANyemshvT0rOsOfkvJ5cKnUMzzypTtMVuEgOdskFt0K?=
 =?us-ascii?Q?hZXukyvK4DlfoobqERDrnI8rMtuJCmtp17X8xJ8v7IpAKGo6zy2HTqSF9Pre?=
 =?us-ascii?Q?12ZLsW981NJ6sHBG5Rg562dquurkh9trs0WeCqTXuaHRnGU7T18dtbrlBA5e?=
 =?us-ascii?Q?Qf53kgR0EioddAbbJHPH/FSZ1fUCwf5W5bucxwvOe2/3tUlxKsqli5tGKUPk?=
 =?us-ascii?Q?sAKMPTvU3KmOdo/aRSUM3tEUQ1eRVJs8V7fl0wGXAGp4er7W1Z/0rZMEGu0B?=
 =?us-ascii?Q?nbTupm2GOYh+7a8n3LBWaIoFIg98rjo4iN1Ci/S+HmM5JsCOHCU+zENI2JWt?=
 =?us-ascii?Q?SJ1Xxw6WBdwmrhr6cU6DSLk/Rwh6ERGUxHzQz+M6DGY/hg18KW/dyy0TnqTn?=
 =?us-ascii?Q?Yl86HPspd5cDTH98VP7kf8zLaY/QQl71zraZveZsPvJoMyEmfrMZ4lfFK9Vg?=
 =?us-ascii?Q?uk6MEW9MPd1Mzgye89B2wcPkvA62eiViXGABdVYzwA4UFn/mWIh24bIyEIfc?=
 =?us-ascii?Q?e5+xaRBavjCbDZInuYDv7ZG1n3FXKBGmhfzufrH7AejOMp4f2fpdLWpnO28B?=
 =?us-ascii?Q?Tds9TrMdIE1/ldIw5AdtI5pQHFi31Fbr2NpyT0+BEl1k5slwsz7jwch9xIy9?=
 =?us-ascii?Q?c2nWInosKzV46gza7IJxGD2diB2dMAGq4jJhcPN9G9u36myBWJP0+62iOT+t?=
 =?us-ascii?Q?hulqWgU6Bps8VvkCXTJF2O3OVW+TFA1mP3z5267o05BiZui7qq5Y3x78A65n?=
 =?us-ascii?Q?+cloNqPL8U5RGERgWUHbBtvb0mwdMxGTF9hr1DrLGwbo6TTC5/J1UqkCBN7C?=
 =?us-ascii?Q?5fonwW2MB82PdVOEOaxO6bPGJgJlWFsek/Y67wPE6IEOmoB6cOGfL4doW2ZC?=
 =?us-ascii?Q?zLgikp5Dz3HpakaizoRVNQB6AR/XyyEB+L8ggrOEdvO8O9VFhVTfYaI/EPuB?=
 =?us-ascii?Q?8pDi9UMcO/AfJRMr6TT96yRqhfo+322K5CsEga1C3qK7HaJFVXlrwXVIbiKH?=
 =?us-ascii?Q?KbwpH23Bi63j9Dym9M5pUbQvTDShfdNgxECZbNus03d/emCyTOSBloVbsRDp?=
 =?us-ascii?Q?1lPy4AnfYDsv2QmCtLnZsBj6wx4Gm2WvguRJekUfgs1yNB72kcMq2WJjyQLP?=
 =?us-ascii?Q?rx9RooMNtoao0kRdxxJg751zToEpAVnn0RNvBIOKYkGkPKqStduX8lduAztg?=
 =?us-ascii?Q?UJGz3zOsYMlVoCMz33cS/0HFsx69UpVLd1Cwt5j/Ka+zuF638eVALv0zW9cr?=
 =?us-ascii?Q?lJQPGlEYFNn4R1cRXjBau9vcwOO8GKfyQtzUTv4H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KptP55/OaKuext+6tI/WVYzfvhPxy/NjD4WT1yqiy0zn4zK3u/T2L3nEVAjlkrudoQ4Zx/QwJ0StDoZoWN80GC8XOfKYWOujJrgiwegkZjjUk/npwo3/YI8kD6f4KRBISP4louAIio85aEHJJrRd3MZMxgXfViux9T8OFMoev+vcQbdeDilzMe4qYoJTJZQuvijkrPXcW+/B3zaLoFlSCv3VlIu/b3NCgauzoEBdPGdpgTFnq0wUlGlHbeSLXe/CZCFELMk/MvJVhXCczaxvfsGbUXf662X+tXezvDxaPWaXf5Qc37nRiRFHIKlaHYE41EhJ/tzp9ICnnkJ6/aA6RofSUZrREvU7dnAVKcfOQFEdTV7MFA6wX2nBdR/fLttJ3KYEq5LgBULUdtJxh2UMfj8JgsAJhTXF5Hf7jJZkuarOdUXJusEhMAX/kVhCaDRU1D4gQOIhtw3s/SUgNSPLIfntIPNiXtzr8tNCW/2DjO4JSSZdFFK5ul2yAv9CR+FVIf2VSlNQVqWcI3RE1vdBHiAU8pW+B4g58CndtKkRmDhJ2geeLys+eEzUgoLfygiIKIktW6lzk3FkyzvQhGtujVxd1L4AM580CduZGUcabiEvgo+dFKcUK36csYQo6W63rTSBCBtk0gaEdCI8vtaZqOMsdDMxcAyO15lTWKmfbG7lGThEHdgvO78j4EdImGjPHg/RfRcf5Blmfq4rO0eIcIlhLavPb5IXprQFCIhQ/OVEnrR45wcvXZb/qFRWDqXD57lnM2JvYA1VRmobcGFcPg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614868b8-3269-4c26-266a-08db5b750ada
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:04:05.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IY3jmwiJzpEEJBGM+/M0cu3TQWIHSlKIafS8ssT+cuHkSbA72rhB9KOG4kdJ2G7JITxGR+GYsWqUEL5ZGeV/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-ORIG-GUID: vu0j-mta9hVYUR3kQf4LUD-SmymEwrJG
X-Proofpoint-GUID: vu0j-mta9hVYUR3kQf4LUD-SmymEwrJG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We currently have redundant checks for the non-null value of fsid
simplify it.

And, no one is using alloc_fs_devices() with a NULL metadata_uuid
while fsid is not NULL, add an assert() to verify this condition.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1a7620680f50..6f231e679667 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -370,6 +370,8 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 {
 	struct btrfs_fs_devices *fs_devs;
 
+	ASSERT(!(fsid == NULL && metadata_fsid != NULL));
+
 	fs_devs = kzalloc(sizeof(*fs_devs), GFP_KERNEL);
 	if (!fs_devs)
 		return ERR_PTR(-ENOMEM);
@@ -380,13 +382,12 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 	INIT_LIST_HEAD(&fs_devs->alloc_list);
 	INIT_LIST_HEAD(&fs_devs->fs_list);
 	INIT_LIST_HEAD(&fs_devs->seed_list);
-	if (fsid)
-		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
 
-	if (metadata_fsid)
-		memcpy(fs_devs->metadata_uuid, metadata_fsid, BTRFS_FSID_SIZE);
-	else if (fsid)
-		memcpy(fs_devs->metadata_uuid, fsid, BTRFS_FSID_SIZE);
+	if (fsid){
+		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
+		memcpy(fs_devs->metadata_uuid,
+		       metadata_fsid ? metadata_fsid : fsid, BTRFS_FSID_SIZE);
+	}
 
 	return fs_devs;
 }
-- 
2.39.2

