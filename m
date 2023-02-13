Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A66941B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 10:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjBMJpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 04:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjBMJpX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 04:45:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECAAF774;
        Mon, 13 Feb 2023 01:45:22 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8NrVL010141;
        Mon, 13 Feb 2023 09:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=VKWaOWAKA8DwRZvBpTFx4sG1Bsbjsv27yyOCmDtII6k=;
 b=08tBwFMefPdADjvknKi8uiMlS+LtaIUpFOyx7E59jaTCLmvFt+D9MxPqhvjRmeaXYUB4
 hrngTPHea3ynhamVXLiyeGvkTOfzr+XUKTRspRJIvYgsAbjRFM8O8DkqnO8l5bVRit7a
 9J0xRinJtbqi9GRU3UFzW4ymXF+V8huUYxqE0gDSwn9OILMHWA1Bx0i4hLpTB/F7mfmm
 JiizNDHvwe4NqtMRsUZe/WgWUJ2BUUMKTqVXjl5pT0UDu5HQgYt8g5yaCuPKyFsb6f0H
 /wFxd7rhwLPcRHFD/6PFq2v0CByJ6M6CbdMXudmPb8F29ver9n94N3XmjsJPq1E0wEmx nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtabcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 09:45:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31D8osSZ028784;
        Mon, 13 Feb 2023 09:45:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3kd79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 09:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEZoVn8U1dXHwG8jP+8f3KMc6tqkuFYEpS0A9cxnC5B3II1dQUsz01CJbtCBYV9WSIyoXnUweXzVICJzekBJxl4rOsbmZpG89RDkxjEdqT2uIvmecMv73o/LiYYDMk0GYbFxUa/JIqWx9xZ7OKKQRmwJJmB+C39EIG2SeArmtwutOwRVrCYY6oRlimg1jeubMO6Xjw/Z+9BtacQmpzQKzJELcfGMgcznW3WkZY0Q7n6E8yGl4cKPjFgrJHv3ZOSsh57eu22MuMYxJf8GmVaZ8C+qYnYfTyyDdgq2KoErC5PcYGjf/eMbirznSVTkKOfF8r5jsmyOBiBXZGxCXxg4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKWaOWAKA8DwRZvBpTFx4sG1Bsbjsv27yyOCmDtII6k=;
 b=RKfi+qd0NF0cjXL4OyrlfqqtLpg2rDz7Rgvf+1JlaRvMSr97otSk4Xmjo1Rp/vf16Ts8Y3AHOg+q2P2vL40q9PYc8Q3jWrrDIciIkk5cLirR42fUZl8DhlXhTB0U1BSPykVMhogjRcl7BfsQnzSmvJxsqKhV12qcOrryDn6is7btYxDAUJIS/32mhrxhqs3sxXdimr3seiVCP7bma3QYnvDUmmK+YlcGXhu795cHtX/FLOcqE09wVpED9CkRmgMiAFufz7WABu82MmDIksDKY9KwjgFVUKBqYmOw76aJIoeu4IffD7+MjTKh4hEWTbsVb9g3fXGmJLwih0n9RVfOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKWaOWAKA8DwRZvBpTFx4sG1Bsbjsv27yyOCmDtII6k=;
 b=g9+1LiB/ShUrwcBCYFux3UezyQBLqWsmjYeVSOO6dUAtzwsXJ19OO1irYn1ZdXdHZ3tChKKeTk29gA/K9v1qVfORpfklmLnPPpiQqLKp4TWDkJihFte+NWZKfUWRsaVYKVEH7WVfDWs1yIOo71+kCiz9/zU7EPb7FficKFMSf34=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5993.namprd10.prod.outlook.com (2603:10b6:208:3ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.8; Mon, 13 Feb
 2023 09:45:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 09:45:18 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/249, add _wants_kernel_commit
Date:   Mon, 13 Feb 2023 17:45:09 +0800
Message-Id: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 212a37cc-0fc4-4acc-095c-08db0da703c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXURIe/MH0IS6WhMv5Ola7yhsy1Xie3Ii3uhLlx/jsLj67m1aWEFSc1yv5+GNktrYBsAn/NGfZrJkMfo0OwcOR0XmDKjfc8EFLsHa9aKb4fKccWMrlAS8TniUzSheE6V5Oe+onZskVtYExZZQ0vKMDGAin4y9xfIgrrMxuQV75Z/vz3I46rKejg7ZBVl8/66qJFEfoEnKPeNWjA5DUWTvdqLHiaKMrymEDu/xl3KlndZATIZKvWOGGXf7Pkr4ZxrhM2xMRiiPq6WToE5IUodDCkTgAOrGo+kiLiC0KHuFBt0CCW0ZgosgP3VTpfa8dRaOy13kFzQyEQSwI1XUaEwrF7ggGcrLfLH8xoz4EI1nAvYASndxjmnGNXjaKFhDx2oEZNu2f7/C6jFP09KcvrsuBw7ckfleY2/BiwXhArkd37bW+ynr+RSROmLnCQ/yy8ObVbmH3+0NXB4QZbscpTcfx+agPnUlnwgbEtROBDuJdK/pa9gAeiYvO31J25k2yDNp3P2/peExIOPFkVQfrmoe/jr/EV8g+iR9yruQCmskF8tlBdPpsNjw5Guu/zLvA1HoVPV59Nd977IbsYo9w8MGtMxcR3YxXuJjN+ElOOXbm/tJOD0mcMITICgABwA+QyNcDQ5zZzSKGiqRjTLBFAmeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199018)(66556008)(4326008)(6916009)(26005)(8676002)(186003)(83380400001)(6486002)(6666004)(6512007)(2906002)(6506007)(450100002)(86362001)(66946007)(66476007)(36756003)(2616005)(478600001)(316002)(41300700001)(5660300002)(8936002)(38100700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vss/1QUQG2OOmNuE0FJELKTJmf8T+tOtnVFoRoTnXg5osdbFeKqJxFIpOUi/?=
 =?us-ascii?Q?+ft6th+3VDp3wLNN2BA/H1fOL9QQcRvsSZKIlbLDgbF0kMxjphYLMHUb73dH?=
 =?us-ascii?Q?/WdivAVWO6tu5bdZZeC4cUkL3GjkMaKYRErQLdGuwtU7pyEXMtjw81UfSVCV?=
 =?us-ascii?Q?60Q0r1kvfraQwX4uEzA9yBMPe728RMzNR4C0zwGis/6VP58vP/4Zppyeb1Tr?=
 =?us-ascii?Q?L+DBPTIeR5LQHnRqEV7hTHTDN09NLD/dUIXBU2na5pBAORxT2UySOK915828?=
 =?us-ascii?Q?QvYYBw/+xzghxYrZkdSDBzWOgDPtJi7ZKu40Nr0dKdAdNME6eqIqN0nId8AG?=
 =?us-ascii?Q?sX/xljZdd4Nvq0aNZ5WBgvrTsuIrnkZTn3TcmM/dcjKyzf1izBcTmMw7o/cT?=
 =?us-ascii?Q?cl84wMC2Z5R+SxvoL11Rqwo79P1N2/MULwy6iDKYhhKBsiZYz1RLCqoR9A51?=
 =?us-ascii?Q?oelSKoh44rMThs+lP5yF7Xn2aNQ7zlI6IpCc8q9IXpU1YMy8euTQwDXUsCKa?=
 =?us-ascii?Q?1E5jKMjbmSm7kx25nGtO25wDtEs1yT/JFH+m4kzTU21aMgtSRcbl5Zfrz4XO?=
 =?us-ascii?Q?6oa8zQsLnHV7crvQxwkly/ov/HucIJH8EZX6QETkNb5tMMDe6EHV35WwVM++?=
 =?us-ascii?Q?tNT9osIzlvy4+z6FOmvByqWXuAN0zr7d8C4cpUx4nIvOhT4UJwMLI6zFzACe?=
 =?us-ascii?Q?j6jabqZPe9lE6SEFs0n5gFJn6coyBAxvTBIp0Swoz6UpBuOd/TvwprbxUQE6?=
 =?us-ascii?Q?6ziBCiXAXZlsjVhEblPYVnbXVhdYpKnDtvdBM9KWOV671IW5sVZ8fvKsjcMG?=
 =?us-ascii?Q?a4upygjNAPqTyKUxjs44AAxlBJfqQj5nO3VYC5AxUKLe2BDn8GyXibxMBdB/?=
 =?us-ascii?Q?xeHCW8u+pU/Hub+aE6t6Cu4ldw/TsH6/5/bPbwYdRK3bOgHLn8H7m/4ZzReQ?=
 =?us-ascii?Q?tKHtBeBHalkCjQpr960qUr4XOGmyXcj2n1U4FUvFijCLOujrUH6xfpOOClMB?=
 =?us-ascii?Q?GchtU6f6XOvZr6D2ZfOBnHwF3Nhyv227sfZrO/ShdV+BPQTGbOjXNQGVgajL?=
 =?us-ascii?Q?ti7wTycBGsmJcWgHz5GSbQDcBGaqYxkrFFudC8vY/3srmb7ZJ0AvpJ1Upbn5?=
 =?us-ascii?Q?E/n3C+br0i7D9bBuIUOX4qs6O+/vSEed/luSfV+L1K8RatYvT+UCIZnFYHBC?=
 =?us-ascii?Q?DybvmYGf3+ZjlfhlfqHu7/JsIGJwHalQuEpReyPxpZ/GQCHiExHen4tL+dW6?=
 =?us-ascii?Q?JNUmgOmdBvbYpWH/ZHqglBFdMO1ZXXJQ0EQQJSqJhc/+hKlMBWo9SMoDROAD?=
 =?us-ascii?Q?r9bFXf5gaAcwnbuhJnuw+uPJk+H5xwbdN1P/tzM5klN21hhVmo9W+rylz1fu?=
 =?us-ascii?Q?f4Bc2wKQ3d0dlTm68LHgadw1irIpuSVNCVxEv1CeDF1KmLwyQfB++lSme2iO?=
 =?us-ascii?Q?7ChrHNw60kCD9VmjHHDi5wLJb6kO/TD5QI8yySeu3glop1GNSkQMSXKQXnww?=
 =?us-ascii?Q?FUTTsea318KKMvyNDEkMDXgnjN1kG837kN+n3QUfUZtxVTl+JqK44aXBMY/u?=
 =?us-ascii?Q?pn4UNhrdun/NyESHcGUZi9ByriyY6pvisEBX9QTvFzy2WVLw7igzITVxamDN?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uxIjnBrCxthrAbu2Z9hkXI+4nI5QxRv60l8bQFYE/NHYs5+jhXGI1WQfETwAkXTpsMBi3CwvuYS1wIj7ncgJ0BG50/CX66Q4TELqaR1zrQSpvWNKMdXKYWmkpkl8QCmME/64Kov5+/W53DABFVV/EYZRpl9brGX2y9q0DRa7ZhUo6MAchzfmAVA5nC/T6e46ITXhiFKg8Ij2h/uiFxmdOxq99qvvc3oXGZGjMmSVQE4121ERLvP/SQyZ0jeWjnUdvBqoxisMfQjB18Tj8yhzrb7bbr/18yrsgmIPZfKqwVj7FltjzPyqaHwpmVglSdovn736N0bgB03CnBbL8GXo1i3YvC4XbzGRpenJdvL4macnnsoC84NT6IcK48XibKc5Dj/QvyB6W0NtoZUD1CnjXSvNczaZHtZqrV0Jbs8orTG8zMT25YcDgetrfOqdFpKieMgzMbIjbH3VIPWuvH4iUO/cC18rSfo+6u9mo+Odq3sNwTANAYqXOpr3WZ0oEhnzrtOVjtiw0m7FH6OyKnJY6+tg84ejPDYe2KIREzVGQmmbqQXCacogyseVlSdQdGjHLvhMk/lraw2quJjf49dZhhO76K+GKCQ9RtL6Qrs2J0fzMqqaMAyK94uEhs1vcn5QHi/xfDH2mUy7zErjipjfyPR43+65fMiyEhlzVX9OdWdx1Y1rIK4dGAG8XNEbRwQ0IGbQiIM9+VQyq2c4dWk2lhSZ0RiYWcHZv4F8rmvGyGj4Aki1n+LqlKFQXarFofe7fCLpe8hhb9LnjdNWR4nDtQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212a37cc-0fc4-4acc-095c-08db0da703c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:45:17.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxToiixNiju+mDJVhky0jbzqj8sqKxgtYakHyuRKbMfwVwaif7EwM6LYkAGrq3EN9A4QnmW3By19mM2e+88tuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_04,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130087
X-Proofpoint-GUID: hF07sSx_2t1Lkze96KP5MD5I6CvXLcE_
X-Proofpoint-ORIG-GUID: hF07sSx_2t1Lkze96KP5MD5I6CvXLcE_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the _wants_kernel_commit tag for the benifit of testing on the older
kernels.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/249 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/249 b/tests/btrfs/249
index 7cc4996e387b..1b79e52dbe05 100755
--- a/tests/btrfs/249
+++ b/tests/btrfs/249
@@ -13,7 +13,7 @@
 #  Dump 'btrfs filesystem usage', check it didn't fail
 #
 # Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
-#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
+#   btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device
 #   btrfs-progs: read fsid from the sysfs in device_is_seed
 
 . ./common/preamble
@@ -29,6 +29,8 @@ _supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_command "$WIPEFS_PROG" wipefs
 _require_btrfs_forget_or_module_loadable
+_wants_kernel_commit a26d60dedf9a \
+	"btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
 
 _scratch_dev_pool_get 2
 # use the scratch devices as seed devices
-- 
2.31.1

