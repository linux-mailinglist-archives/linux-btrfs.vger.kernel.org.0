Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C715670D9D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbjEWKEr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbjEWKEq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:04:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7192A126
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:04:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EoMH011162
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=JkUW1mrjjsaaDG9SHG3r6zU7U9IcDMLgY25r+GEG/ko=;
 b=BSNJbxBhOTIHw1jNijuY0edBcqnBWyVRYQkysPANZnhXGJnFZdlnB1hKBsNtwO9uuq3c
 PurmnUuD7xC4Ic1m7lBgOhWVXiaAsf23usL+SNgqpd+b1QNYm12mSxy14P8M9pPaD4uu
 Yf5pZNvA6QSDO9NHvYrZt6kRRRAu6mUlnaenR2Ds8z2fannm/by0iORLFBwxXWUvmuHg
 cYlJmvAdUX7ZnREfe5nlE86cI9bi8vIJ4Tnik3gefBZLLi3PCRFxImrW6MEV0fxkKPJI
 dvqRA7dywytQscQe6SBQZYkbzi1OjzE4fTC0eXauSqcqsQTKq6aipz0OuKVEjDX/1ElE IQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp424r3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N8SYTH029085
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2am7gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huoMHFWjONW8Dk93PJos/GOJvdnlNAJ5s2mbX1nXqJVZaLsojMh0zYEPBgjaCtkIuyIA6JDz6JbCDbZ6dwkaXj3VFihMIKfbMHXJ7iwJhJOzzxxZxQdEStb0i6Kcr0Q+osk8CV2w4+5cNfFRqfC297KTV7qlE0K+udRylbQQIGnZ5TgieFDl4QWKQDWeWKni2SZwuXka9pw9oYGYa9rXG4IodVF+Vz8b9abKywVUhWup/fslqR0n4t6rsDtO7j0InI/sH+g5QIfA++pNpibI0MtZeM3+OelPrK7RREWgizx1Ks6DqZlgptJI8LciaGoCKAdCj7EEmZ/aW023DBDjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkUW1mrjjsaaDG9SHG3r6zU7U9IcDMLgY25r+GEG/ko=;
 b=mluoN02boJuGLW232y9tOVYHDiIl42DS9uWxGuJZj1G5zJZNJI1+yMyPqXSQvclR/u1+jMqqumNxkqpnH/fyvm0VX3xFluRUWLS3k5atS/mTtJAoW0/vX+4fDKy58LgvqyZLJlJPyU4TY/rV+nxFs+DawQWJih+kosa4xn/EOO2I1x5HWuCuF1oKOuKQfnXZOG+sLLc9EO0DiGtAnlyJwJH+YOJ/PZ1bkrwHOh16bYGcOcN23nLLq63b20gesbTc6La06vVGqHsnM2ZMHxm7lyMftQ14/gm4Ny+9uAybTDah0X+IAc+/24ra/JepX/1gqZzKBJWafiBQlsgFubXuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkUW1mrjjsaaDG9SHG3r6zU7U9IcDMLgY25r+GEG/ko=;
 b=y4ae/XvI42416SPzznxnGhicL79sdn+k7CFFH1Y753mSqjG37O+DojGliieQNnpxMW16hX3v/Z4l0R1Hoo9pCxDnrfv7KtO7CNJ3QO4a36NkMQTdiU9lchxbRKcA2fOwo7/EGTwv8LZH7+IenXxVk81ZiFI49b3tQyaLOBIgE7A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:04:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:04:39 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 6/9] btrfs: refactor with memcmp_fsid_fs_devices helper
Date:   Tue, 23 May 2023 18:03:20 +0800
Message-Id: <ba9638608b3c72b40e24fa2d87802449a0e0c64a.1684771526.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684771526.git.anand.jain@oracle.com>
References: <cover.1684771526.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e389e5-d42f-4d54-1148-08db5b751ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6VubQ2RaHhrCUzAvxowUksQuAs984hI5UwziUEEAAEHpujHBy9XmOPZ9HVlHJjGeJGExplwG2LHGDdc1N1kjGTEU24Qqrrx46pUVB16Hff2Bu8PyMGszYVT86+m9uiOjp32DWrs/yAEuruiZxXo7c3Jw5ZSWO7Eiw99XTfhCLdb3dQ8XF/xc1pajUwW/Ouf4cS1JJm7ceOfI5khWBBCkGoX1dscUxNEsnTDnNLvO1mhsSnMZu6+b2LlRiIfjw/yXfBFG1D+qG13AyHGapXNblbw3vaX4j+2OoVBxX3ea06mv4zs4YdGYHEjCYkKF8zJnGICGOW5KS91yPE1EYeJ5AjHnpctaNSurcCyTGR34pi8bLDpTTkaTayjTFZu5gvKcZ6DSsjbXLr6LTnw4ff3OBaVS4tgolXUP5HeXo0x/2IvhPkkudTjcy+t3GNTA8NeuAOG9hfszV4jED50uFkVs+Cvme22OVlxDV76Pjtv90TemazYMWNIgXvei8YtE1NW17N4N7jUtQUYpNyb9YEFSpfWd3U9Qs3K725XbHRfa31iQxQzCxoxP9jS4tgnNVp8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(8936002)(8676002)(5660300002)(186003)(26005)(6512007)(6506007)(41300700001)(44832011)(107886003)(83380400001)(38100700002)(478600001)(86362001)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(2616005)(6666004)(36756003)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?23c8gBS2KVdJykTToM1B63Ea11U4U0vvApaBMJ+lyCJb3kG9PKGVhtpID/LS?=
 =?us-ascii?Q?+Mr0/QsIdEHr6SOmafcsrpBGBCyf25ZeTKTnfY+OdexkqdtzZ8H5tt9ZLhLA?=
 =?us-ascii?Q?VnPDECvh25uU8OGjUOGIzFfc6GqfOByzkxgebgHDjRRWnX1D/XnPfVrBARFT?=
 =?us-ascii?Q?TPs/FEaNX2kHpAUOIzF3rTQdPzFXCbgqAB+bk1Oo1z/Q6QGyk5Dj3Bkoqy/U?=
 =?us-ascii?Q?dfkVIONhMIOhRbILlfv0jLiMydy224/rHXzEC2iwLx35gJVYsYSJCrMuVznG?=
 =?us-ascii?Q?hYdpAccuJKLzZGK50Hpg4zN3noVSUI0zksXcXNzrl02x1912meedA0VcOjP9?=
 =?us-ascii?Q?UqMGtEWk311SDqGraksdAr/YvoM9FOO9siNQsqHzKTeVUSwVjD2Lmra+T1qV?=
 =?us-ascii?Q?JnJzOFzpcdIMNL+jTKvzpG2d2CJu8sQ8DpiVoBlACV3ce5P2KzG0JqINbqMu?=
 =?us-ascii?Q?0YxmCYSFo7DBBH8ntXI3IsA6JY5rwDVVkwmGoQWsZdmiOFvCwoe82oJx0BHT?=
 =?us-ascii?Q?387c2SY16WWzhy4ICr8ISsD842b3xhF95QMu/xzS0mud2vltDU1Ygkjs7ZZ5?=
 =?us-ascii?Q?WDXPeysftdbPNtw8aZQtBiOvhmvKH6bl1btpiaC4oxyq4ZY7JWGDlbFbODYQ?=
 =?us-ascii?Q?HRFVooxhmBnQ+zFIl93pdgjRWfGksNI8KEBlRvl5fMfOgS7YKOCvwWoOalV1?=
 =?us-ascii?Q?mT2vqAFOlzDvGu3017uKFT4A6/pmxw0oehsD7qs9Dpm8Fdf01NK9xeSs1tx3?=
 =?us-ascii?Q?jT7QtpuhQcRFwVyZrhVHVuED9IwRN92PAPyRHlddCmAp2P+a1l3Zm7NqKKfh?=
 =?us-ascii?Q?xhvPimqawsy/f/TeBklZaxjpJCtID/l8kVxOYr/mRNdT0BWsRHssnoV0bI7N?=
 =?us-ascii?Q?ulhDG0C90i766yBN50MkBwnwVEIkGrLZFSq0J00ZmM2UQJ1ckxv0ESfrtaZ2?=
 =?us-ascii?Q?Bz+1xcvpNJsXhoQgJrr5NhtHUDF+WtMDVqo2WGkb4Qk0oahL/uD5JiN8ynQy?=
 =?us-ascii?Q?0ML3iPeCmVM7nWMRg0CUDuQLPxnnKtpRTihi3VYF4LbgJD8zmrUOZdK694M0?=
 =?us-ascii?Q?U50mAVBQmY8NyLlclR1EkmkEeyOAA37jSaaKLsU4yq/TaP8QZUp/GlVMQqQ2?=
 =?us-ascii?Q?JUCpGxgUPB6kFpJ4lHVYHFKBq1v1haRwcde9JjgGIMz9hYmHjdxib/x8fEx6?=
 =?us-ascii?Q?edXNK42kDi9nYm5j6QwUPM/SUdwv1fJF4jDkCx2YwODjuIpkHc/JKBdyC41A?=
 =?us-ascii?Q?3pexzW+i16QBB13sSeji8oLJRUns77Em0kdrh+BbLh4+KJ3dSvly8Z1ki9JP?=
 =?us-ascii?Q?yiwsrzXRxtwJZS1jalyHhGWkOj/7ahlo2998femdA40B7KrheZ4f0I7tcx96?=
 =?us-ascii?Q?tULMr3e0nw1ypDq7f3Wm5SjTlcC9c8l78QlNT0MaPNTVhl3dW1OqaLbmm/Cb?=
 =?us-ascii?Q?8ogWNrVqMtJuK77fjJl7IYKHOVp8tLxHomzTsqpjKAAmhm7hbXQ5UMWMx1tD?=
 =?us-ascii?Q?USK7gXKa6ZqTiDtoUNaAEbyj/nbeocv3vySIgKCap6DVIRQzG/EU48HxRGPT?=
 =?us-ascii?Q?UQvSsAchxqFu5qCtS2jMxc9Z51iWXZKH4WOxwsrs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AZWcOMlWKr0ff4m3KRK9t2DaxLx2moN7JHkBim5HZ9vih2+67iAg5Fqq33pUXbIFC5WqxpWPH3xpg1+B4Hd0Ku59rFmnIWLn+NRM7ZYT+Aforjo0aUFmEVEezsDHLWU/m8CLlrf3b61R9T16kIzX5KbuJey+CgaunTChX30lZOzoc6/KCl0s/hJ3gXXNHGt2bVdJ5JszKrXeQWe4jBmVQMYRDD3NDi4Q2aeC8YEB4P/Orwlp1enRRs+1DOkWWP6jOBpXmFgCi6tRGRTgg7b5zubRkOxOw0lVuAp00d9nWzmTvHOi42ZANf0FAe7MSU7Iqg0D4YNUjJAwXZ+sxMExRc5Ay89zRuBN3j3J4mOBdc950d0OFflotSnaLxodpm0yjM0yaWyrK8TEFhzi4asHRdVL4wtC/FbPEQVyD04UHBlV4ssPvO2Tz6hH1FHEbz+GsFI+fLZpPMV2mApTz9DfBxsggazGLLLaBRT755rLJbED4HydMmT4tAWtlytYiUzKDdo2qiahRAuAtAsowqzGm4kVEJIluXyEqXMZGs8SPThjrQQW2PY38Ipv96ToZOWJynO5t0YbY0cRV9eLTBV8RjEwBltVMPYrbFsHXfvGmNi3q7Ic1pvXTdCqJocbzu5W7+541aw7S6/rZPcoUknKZ6svz54ZWYobxrnyklW1909cCq+kiZsnTzZSYHR7fqjnV212x1HUKzYwf0WnIvObnHDxKCMEEfVAKWf+kqx4/fOfXR8rGfnAY7TEnN+UcFGxr4y7nBJGE1/jhLNIIIm/sg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e389e5-d42f-4d54-1148-08db5b751ecc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:04:39.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6l4/2eJKf3voZ9bNPwQP2zXbT/29MIJkt29hv8lmFN8RZDHVXDu4MBTc1uWrjZs5sZgEeXz5OZGwEqhx+Apyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230082
X-Proofpoint-ORIG-GUID: AH9oHUmFgeSYMRTi6fdLUK0e142xV0So
X-Proofpoint-GUID: AH9oHUmFgeSYMRTi6fdLUK0e142xV0So
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Refactor the functions find_fsid() and find_fsid_with_metadata_uuid(), as
they currently share a common set of code to compare the fsid and
metadata_uuid. Create a common helper function,
memcmp_fsid_fs_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 95b87e9a0a73..8738c8027421 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -427,6 +427,22 @@ void __exit btrfs_cleanup_fs_uuids(void)
 	}
 }
 
+static bool memcmp_fsid_fs_devices(struct btrfs_fs_devices *fs_devices,
+				   const u8 *fsid, const u8 *metadata_fsid)
+{
+	if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) != 0)
+		return false;
+
+	if (!metadata_fsid)
+		return true;
+
+	if (memcmp(metadata_fsid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE) !=
+		   0)
+		return false;
+
+	return true;
+}
+
 static noinline struct btrfs_fs_devices *find_fsid(
 		const u8 *fsid, const u8 *metadata_fsid)
 {
@@ -436,15 +452,8 @@ static noinline struct btrfs_fs_devices *find_fsid(
 
 	/* Handle non-split brain cases */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (metadata_fsid) {
-			if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) == 0
-			    && memcmp(metadata_fsid, fs_devices->metadata_uuid,
-				      BTRFS_FSID_SIZE) == 0)
-				return fs_devices;
-		} else {
-			if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) == 0)
-				return fs_devices;
-		}
+		if (memcmp_fsid_fs_devices(fs_devices, fsid, metadata_fsid))
+			return fs_devices;
 	}
 	return NULL;
 }
@@ -462,14 +471,15 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 	 * at all and the CHANGING_FSID_V2 flag set.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (fs_devices->fsid_change &&
-		    memcmp(disk_super->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) == 0 &&
-		    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0) {
+		if (!fs_devices->fsid_change)
+			continue;
+
+		if (memcmp_fsid_fs_devices(fs_devices,
+					   disk_super->metadata_uuid,
+					   fs_devices->fsid))
 			return fs_devices;
-		}
 	}
+
 	/*
 	 * Handle scanned device having completed its fsid change but
 	 * belonging to a fs_devices that was created by a device that
-- 
2.38.1

