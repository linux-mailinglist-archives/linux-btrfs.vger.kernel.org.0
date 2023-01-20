Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4991567561D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 14:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjATNrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 08:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATNrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 08:47:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A6B4E526
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 05:47:40 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KBuPpJ029295;
        Fri, 20 Jan 2023 13:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wYtKLqOMuPs4Kq8rQxvDtqiKroU3isofGzB8wk2r7Fc=;
 b=cm6obU2FiYPA3zO4d+wDPtwhgYD0fktX+aavN2mTs28lewUNbQS9SoWqLO5fGkewrgez
 OigHbFP+NJ8HO9Z+cctJ9dZhi3S2qYsxipaaPNsJDDhann0wrTE63oVwUpCG7qgK1jP5
 fYVoEoY3HGzavTy1iaGoAN2SVdECDgHenNp/xz7bdsGG2B7Ch8Epdr/gYUjDE5O6krau
 Qdbr/xrEjIWZeltWBVHK++dMPRF63xKwC4knixOxDo/Uox/MlPFos4CZwFgxa/wqPkoi
 Zfqeo0mDQYWL6UeoT6/XXI8ElMiw6knfCXCd0jmyhJzhEVFdL2I+t12+RPoCnajeq2UO Tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tvn2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 13:47:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KDF4Vn007678;
        Fri, 20 Jan 2023 13:47:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6rgeg242-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 13:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLpO23HE0S7183ue6NGSaTT6cZx+6y3rO7MALWCVlPEpzp5IomOncvYmJNNTEjRgR+WSJndmjlw92e74qlzhMmCrx1tTKK21N1zARODc8cfgRbTE8KZTO3Rdxp51GjufLR1dSEy/zlN4wWDW1KyKyciw9LaBgrZR8LeXXAQWSZbvZFcCcpNh3iJxUDoTbgDOPKoFnKw98E8py4Qui0vlod1wySnaCgS8AgaWqnSJAT3f+73lgNyCcJ/iToFabL98zGkSN+7g6wDG6B5SG38xH6IaCBoN092PIWchAioFSlbTpEnFr9haRCT+ikB7oFu06eXE9XVbP0JjMnyHB4k8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYtKLqOMuPs4Kq8rQxvDtqiKroU3isofGzB8wk2r7Fc=;
 b=EtMBqHZcHnr3Rww1O+4GhF69R5iko9g7Iw3XiQNuhNf8v3EA1c/F1i5Ld5XzvXtBvcFxgxyDU/zOJ3WYcrkxFlPCLlkM4yXnmwcZ5wSSjKTD2STL/ja7yVssGeSFVqUDGkTaL44nttUNE50KRKUx+eD5mHFs1qcfN0zWNI8EXmQVzgLYEO4PqCiqeFwiaZ0iVkx/PiTvu9NwEdB0CgoWAKFghZR5bhEDwLLOlhDz1bC5/min5AAlPm67TTFbjfDrD8WsjnLy8rCTccBmxAM587/pruYz2jr6PnEgf357/h7d139BBJynRop8J/ohcfHY5Q/UOSxA0vw5U+q5hC+iaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYtKLqOMuPs4Kq8rQxvDtqiKroU3isofGzB8wk2r7Fc=;
 b=Qyt9Jh9bL3qHxAvHG2nv0J9Yg/omu5RKRz80TmbK4ELFM0xB6iqczYK59E05ytMl+BCnJFA4NN/ieOn3vef1iOu1/PmVNPhEZLCkTz8/Ua6Xhe8dczzSsny2ZxUFd6YQoznf2HVSJngOzP0v7kZvXb3EKhfGRBOL/WQqFTkOp7s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4680.namprd10.prod.outlook.com (2603:10b6:510:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.8; Fri, 20 Jan
 2023 13:47:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 13:47:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Daan De Meyer <daandemeyer@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs: free device in btrfs_close_devices for a single device filesystem
Date:   Fri, 20 Jan 2023 21:47:16 +0800
Message-Id: <faf1de6f88707dbf0406ab85e094e72107b30637.1674221591.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4680:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f546e0-2f9a-401d-7732-08dafaece24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DpZrSm/raRLlQwar3xeeZcShIq82cq6ojBWHzeM4tthipHgNYDhjh+XqvOLzMi/+vXBatBKgyGyyzKWHX/68UjP263PBCdyDwxAzrHI4p0tQXc7o2PqbXdmFO/LxbMJY0ERxr3phXOZjHd5fAzg2D6OLaYtubUT+prdagRU3bBnfyQMZ/1Hii+pmgKytVZAdE5750vQJRj4Mf/TefIwrZ+WRZPTfnxSx/CKIZl0DtCscK/8ywFSbFKCK18scr+aRPZ08hIzVy+yhRtqGbQtHJ0EWc5guCULGUyK/AaVwI0yLyS8Jffz6A8bvH/gdwFEiwutJ3JF+q5VJMa0yNRssmxfkZAOtkVrW4jNQxoYVEWHi378g9WoKbNAMhBJLVZj4NejZX66zdmeId/rA788Yn6bzJd+pjZv4tZ6T2Y0vYCaNkoCB//vB20nkcYrZE9fnBa8NQ9vIfhR8ucZuLJpjCAXIDIhu/bdvyEYofIqthg94Cf1sJFXpDQcnh6mPnJdo2wHeqYl/k5SFr3x1c8ZKj4SnXbxnRug3iwIwteZewjaFEdk5NErcEI+xqYZNA8cXUFu92HrriRiIhJK5gf4IVY3RejxHZ6tCz0GyLQElOROf/d4OQ4MLujH4FA9ehsgE2PuK6flRtEwyVrCLytNbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(5660300002)(44832011)(8936002)(4326008)(66476007)(66556008)(8676002)(6916009)(66946007)(38100700002)(6666004)(6506007)(2906002)(6512007)(186003)(26005)(54906003)(316002)(6486002)(36756003)(478600001)(2616005)(83380400001)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+mYASl6JdtdiCmSilwd2s6mILqBYZhvKco7LgYn8ksS1pfwqUaiwfit3H82u?=
 =?us-ascii?Q?LfoXK1Mt5UHsWpYCwaTJ1UePQ2LH9VZkQggp1KuHhqIXQJrvBmNZXDWblM+v?=
 =?us-ascii?Q?LzCao5WAAvnWkPZdqyO2HNOg4+XY2ksA3PQrl4qZDonQgJOxcFHqHlZKABp5?=
 =?us-ascii?Q?vI3WrmI0CsmG2rzH3wZA6dgcvtB9ABEti5vafFasACX2bmaJu9FwiBDFJVUf?=
 =?us-ascii?Q?/uW5KDjq+YM5wX2ah0DhYM5GbEHf4osPPHu6/mGAl/C3xx9zduPk3j1Sp3qO?=
 =?us-ascii?Q?QDvos7aclvRPkTKOnd9T74VmDltI3MAJvu4O9AE7CXO1CArsZp2yjd3vCmgR?=
 =?us-ascii?Q?Xqax8i0+8fK0H1aAz4CC5vjDhfj170aYKlXCrVSTtU1xFPY8sRLE3xuQqCQp?=
 =?us-ascii?Q?H2KEIwL79yWNztdrjlBXya61YzckLOTWoySKeyxsIcYxplARiHH436wgop66?=
 =?us-ascii?Q?cBaEr/3Bkz0g8CZhJorVuuqLYNRZWoCuSc7YGT1xwba04h2g1G1vSEkS6tS0?=
 =?us-ascii?Q?cAx+PMAr3PDPC8n7VjlWPmRqqXBV8XQQPuohPh4WiBKjj2PAIwklyOsARDaa?=
 =?us-ascii?Q?SFtWfdezuukNoha7rDuiwboDZ1RtyIsNEX6zQ4UZnWYeynsu/qSgRBIDq32W?=
 =?us-ascii?Q?HJEmO5KYKwkmrc0ifuhna0lJJheFmZmNEEtZ77duBUCE2HYAYjVDkFK/Dtij?=
 =?us-ascii?Q?asnu28iZBbzi3w2nnwVk0MTdFZq1tYSCHothajIZ0iMD9Z9iDci6JszhV1aY?=
 =?us-ascii?Q?IYyXRS16STpeYRAkMthGcM5Uj5pMB47lgTYIuwX/iQzdTATE8UpNRUJrAZHt?=
 =?us-ascii?Q?rRAuVfY6JFG3GKm9+tvf5TNnx8qefxVROgnBk7DGqtSuPAF6x9n3sNQszsFW?=
 =?us-ascii?Q?yeuNbtBaouSRK0HkDaohQLdsHy0doQbsR6UXu/t96qF4zW2ahTkdJAAsvG6K?=
 =?us-ascii?Q?0zaTaRpe5K01u0xhYAgbe1Xeq3fbXw5pF2uATepxCcb2e1+eUbyyhsjq2byG?=
 =?us-ascii?Q?Z5XgiSQ8+X/xOyraKs/narpwmONqR4yck0JdgNAAepyBQsw8Iw/zLqp96T19?=
 =?us-ascii?Q?8Hh13UJh5QGvUU54UzkzdFmGEL4to4S8Ix0xhFcB+Xh7nVtlc+y6N4G9UCVX?=
 =?us-ascii?Q?sbFEQlfWra5OJHFQSOYRq9bj564A/Ce6yo1SvTboZL28VS1E9pqZ1k56CwHs?=
 =?us-ascii?Q?anaqHccL49dfhiz5BCwMAMfrjPo9Sz7UqAGe3nsOaZLtEQGqsie0QbS274GH?=
 =?us-ascii?Q?4j5zZSG1C82kzbE/xQB+N3B8bgM7Zz/ewhXnzUVSZihd4GkWPxqjnBb4frcM?=
 =?us-ascii?Q?jaaNGzTrb5A0v2JixsAWB76L9B24daVbtd4KjiSRKi9eqNTtVoWR/WK2iA+n?=
 =?us-ascii?Q?AjprhBa7nXR1n3frtdvL2K2onUSDIakEdnlzhMtuonoHW5ZLQH9vZXYHkgAF?=
 =?us-ascii?Q?T3HYtHXcStudFV8gVrW/0cME35UmGJE0FnpAJsslQZrGwH0hqfkJND5xps2T?=
 =?us-ascii?Q?lVzI6AP8Cq77UMFH36rvlHid15XXsLNbCPOrHMDPQGgL4/V9ZSHjsq5z0SX7?=
 =?us-ascii?Q?2WKeHVZ55bYNNAthC6hNcgH93Hh4GOo1rwhEKop8ehgwOHhYCbKur3M4LHEx?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F00yHmzEeQqiAjgROzdlox19ZGoNpgU88y3KT9thlwunbgTTbfNAw1r6yBwSZ0wAODEJm/+RLKupYJoZaoGCs3rNm7+VIeq4V0XzeP0qlglBGUmkomEKtnq6qctfId51qOgGoIYCFw8ugAyrugfg55AubLoHeZ4mWC77eOWkkoEkKoXm/g9AaUgL60U+JWr4HhygUUlTTusdiNBTn9MT3ajOHLUW49hpX1cOFUxlBFJdZz/MPam8uq2sQaPpSK+qtUE3U76bvNLpwDW9i2VMEscnFq610QB+Z0cy2X46Sz1pWxnsOgbnvpxYPNv6OGKUNqAxC7Ut59OjUsypg3JWLlnMd/h8G+P6T8CtEX2Da+TuQ+aNsQdGGRzVqTjjJfN2yWbOvWp7U9Bs1LmwyM/5zwgVv1rYwp9Xh+7gyACmu1SBnu6C0tFDaCghMg//D63KNBf7SSlaHIPbpIxTBL741FS04JAnYGL/9UWb/3SbvKc8Hwnwa1BijfsBrnP4CbmSlum8XNRQ5pVozApN9nhxDF4CHYvw9N3FaMg/hQ5gZZNVDLhycEgKF6mZTlhlHeu/0mPD55X3W5C/s5Yl1k8/bQE4rTTD/fdDHzShupkxp/soz57+rjZ+0VX6tQq5hSF/SBf2aVJn2UrK2OrCWzhZWpOa0s8hA3DQQL2UNFKH3z7pGtEfPEj+tF7BVASW5xcw6zbLqc+kf9Yf8xnf7WmLWcSDQmqI/T4J/qGzaOnm1nMcCO6Gi3ujXQZekGdn1Q3HARm7EDxfohOPDt+5kxmvyQgvUnarwAFNbQQm8DW/iDPdsoUHZldojclf289hGGwJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f546e0-2f9a-401d-7732-08dafaece24c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 13:47:34.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guC+zU2m4NTiscGuWhDC+lPLPhV8uS9ETpE3vqqJi67D7htBXgSGzLtmlBMRTvdBbIWshpRiFVK8hhibf8IOlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_08,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200130
X-Proofpoint-GUID: 3ttqNo_ilbKybTbO4fFJ3Z4u5ln3TA15
X-Proofpoint-ORIG-GUID: 3ttqNo_ilbKybTbO4fFJ3Z4u5ln3TA15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this check to make sure we don't accidentally add older devices
that may have disappeared and re-appeared with an older generation from
being added to an fs_devices (such as a replace source device). This
makes sense, we don't want stale disks in our file system. However for
single disks this doesn't really make sense. I've seen this in testing,
but I was provided a reproducer from a project that builds btrfs images
on loopback devices. The loopback device gets cached with the new
generation, and then if it is re-used to generate a new file system we'll
fail to mount it because the new fs is "older" than what we have in cache.

Fix this by freeing the cache when closing the device for a single device
filesystem. This will ensure that the mount command passed device path is
scanned successfully during the next mount.

Reported-by: Daan De Meyer <daandemeyer@fb.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Retained the original bug description as in the patch [1].
This patch is a revised fix for the fstests test case btrfs/219

   [1] btrfs: allow single disk devices to mount with older generations

 fs/btrfs/volumes.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bcfef75b97da..d024967418f6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -403,6 +403,7 @@ void btrfs_free_device(struct btrfs_device *device)
 static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device;
+
 	WARN_ON(fs_devices->opened);
 	while (!list_empty(&fs_devices->devices)) {
 		device = list_entry(fs_devices->devices.next,
@@ -1181,9 +1182,22 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 
 	mutex_lock(&uuid_mutex);
 	close_fs_devices(fs_devices);
-	if (!fs_devices->opened)
+	if (!fs_devices->opened) {
 		list_splice_init(&fs_devices->seed_list, &list);
 
+		/*
+		 * If the struct btrfs_fs_devices is not assembled with any
+		 * other device, it can be re-initialized during the next mount
+		 * without the needing device-scan step. Therefore, it can be
+		 * fully freed.
+		 */
+		if (fs_devices->num_devices == 1) {
+			list_del(&fs_devices->fs_list);
+			free_fs_devices(fs_devices);
+		}
+	}
+
+
 	list_for_each_entry_safe(fs_devices, tmp, &list, seed_list) {
 		close_fs_devices(fs_devices);
 		list_del(&fs_devices->seed_list);
-- 
2.38.1

