Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63A97DC3B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 01:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjJaAyg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 20:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaAyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 20:54:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037139C;
        Mon, 30 Oct 2023 17:54:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMxGuX001844;
        Tue, 31 Oct 2023 00:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Su6pXe7bktD4nPyuUmflLt4bPKRQbUGWilff2RoqTNQ=;
 b=d0m8u1iV++rqHbCRnxp/sf65e77aotY/PmVzthI2BrwQyA0IS7R42kRU7l7DAz43DzOW
 mi1cmiLqfkpzdEKidnfhPrdTx8DPVbI37+pXeu3Sv3jG7gcftfpt/6saJpDve9HFSH4w
 bulyeLhiFwMy2tHSUwro0BxxBvGyhqaC9gESh4BS2VFNlta3XIHF/r2yL/TbF93bM58L
 6HVhxPMvkxiuQtLTbjovbObwlYWIZc7rPG+f7TyyCK4/yy7r5ogxnEQiJkXA5uu70C2W
 xx4Llb6NoTrGciiTd/w1nvZ/zK0i5KuBjK9V5BVzbIhQ72c/4xxwL9xK1OCu8k7e1XIQ 9Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7bv0wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 00:54:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39V0MSlY009234;
        Tue, 31 Oct 2023 00:54:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x4vt26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 00:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ8Op7/KL1ZFujnwwmHfR5+c+D6WrZq8s8QWYTUeoVpDxGYrcauHbWAxyqfY3LPQz4HNWAp5Wx7JlnvopLsuNiQPUVzk9RilInUKEt/9pxiCArfb3PP1ghOqAvyqAgRAe4JxS0SWOxuoGnPo/hNNX14I+J5IPhCSZk0U2ejM6vZ0E/FB4BATBbypZaBrYUVp5PomQl8cu1A6nn2VxJX6fxCrSG1YncBVLTqI44u/JLaR4LV9Wh8pMn+Ie+9uWiaMPXbpqyjyqOC5C0vJIMlaiP2Vh7GOeE8y5rU8iW5bbgOpzz4HG+XY3KIuInMtj5SGMQuQf2jHW4ala3dm/Ts7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su6pXe7bktD4nPyuUmflLt4bPKRQbUGWilff2RoqTNQ=;
 b=TvTy0lbUu9HfRku6NJkAFQB0U1g6VE4KwJSoiNiG2qY25FItMnUxX1g13yVyGKZqzLRWYUS3cxUe1QB3jj43muSlU/HU5FcWq5bSCp6BFUT6sQhvNQ7IridGCAanqlUUKUBs4hYyGcGGTJURw9gmrjgWxZLMEBVT7tI9SERU0Qp23Fkm6YK7IMfejgj6ohgoNJqs5DjDfZ9jdxkR5iODLN5sGAWf3vvHXo35Xp7n1/FkiNV3zUpZKFfy+raB9X6QZAUjIPMu6aMplenFiTelzgvQ+IkDS/FmKc5o1UyOQC11nqc5GMpviC8gMk4MQJyE+6HF6pGn5iz+UN/JxGTr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su6pXe7bktD4nPyuUmflLt4bPKRQbUGWilff2RoqTNQ=;
 b=q9sGQBVuwDr+LsiaWnu9Liz0ILsB/BiKMIn+XWeBsklaiNs9NIbuocdrYPlsjl5MqTt8A+ftOZdHYCrNX6Nvq9zSjM1zXQDbnXYjgcN6sWepaG18s2xFW/Ia4U/DnPLxVkDeiSLzYBXzIqDvA/0Hb2pNEPMcVe5O9Vtk9+gUti0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4169.namprd10.prod.outlook.com (2603:10b6:5:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Tue, 31 Oct
 2023 00:54:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 00:54:25 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org, fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 3/5] btrfs/219: fix _cleanup() to successful release the loop-device
Date:   Tue, 31 Oct 2023 08:53:41 +0800
Message-ID: <77a360863a5d41d4e849fdb829145c6591d4e955.1698712764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698712764.git.anand.jain@oracle.com>
References: <cover.1698712764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: c81e65ef-a3b3-4e3b-30df-08dbd9abedb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0K21oL3tGR935RjCyz1fxzKbx3XDhakcCh3IMls9udrL6kBITGf8yKRQm35IbFJdJdOYF9mZlaOrZsVp7P6yTSlOeSHV7AxXrDEWZFFyF1k2gghnQ5hFoIZbbdnBgl+LLVoHieTt6wp3+PHIFVAsfK6TofIW2aTZRRui/eLB4LstGckmdKIAVmoLB1xc7dKAUFkcWdtGfobVceSi+UxtXJqtSNhvE3uidrkBY/q5x5aMm90jzUJ5vuJk2ZY4bOk/msOj+toB5PxJgmCoaENNGlpkLfYg+G61AIH2KINWfp95nLx92HYa6QUmrbSLxiJ+JD7IuRrcEB0A2YFAN5KEvfit6STEo1q4eFTyeJNVh7sUbpnI3HjULQi4bcV1WYxMEcep1W3fTE4+0ncZCu/GN9HanSn+6szxsIKutzxkvZ+Rdv8fnemNmBaV8oe6L3PIdFYKAJiKmzTWPZW7f9qAQX0Z0IJeLc79NpuINQ4otD0ZgPzRBUWTWqSZky01dinOjEUHeBb7hu2RBDpNoU1+g2fumqq+1lU4TCqtxgmy80C4kPUBUU70E+UYOQVGCQY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66946007)(44832011)(66476007)(66556008)(316002)(41300700001)(8676002)(4326008)(8936002)(478600001)(2906002)(5660300002)(6486002)(6666004)(6506007)(26005)(83380400001)(36756003)(6512007)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6dLAf9oFjlI1GNlctWxNltigkta1GBpU/HkePuquoRzoiqPpW+XKXtfg/NnX?=
 =?us-ascii?Q?eDG4t+5z1OBxY2K5Z3zt6vKuMA52Feh3cKEg1jzCoIyurac4oWB9i/BrZTc9?=
 =?us-ascii?Q?CEdP6pyddmJrjwR0jUFd4omHFhRKL29ff9Ubr8TE+gIOBysxtrnpSYQSSuJI?=
 =?us-ascii?Q?SpmX27jdUqTE1x6A3F1ZdbvmNcZLJzDc5v0SqJ1Zcz1mnk0u78kOsJRZfB5N?=
 =?us-ascii?Q?oHA5v5xbmFJ5GLuZVlD0PBYE7jTU3fOvI4/c8tww/unlZem0MnDkMq47dY3y?=
 =?us-ascii?Q?7ZwbdrzgpecUH+Z3yrl0DF30ks5sG/4iOfmU50sfZ75Zux1WmUlY0ficK8jX?=
 =?us-ascii?Q?avYMXw+EyKcoCUsqC2oQ8p9vKMHtmhuH3k1SdOYFfRwYsanlNS84Kmuu6lfp?=
 =?us-ascii?Q?0F+aADWQSed67BcAo8qKEc7OrsdpNNXbYjbJBQk7+rO7noo/igEDdaHBg1xk?=
 =?us-ascii?Q?8UEC0/hLREvV7h5moZzAYC2GiWSwpYablvHXD8WfKAl0ITXrY5AqSxLKjyp+?=
 =?us-ascii?Q?nZ/paU+oruZHndPeTQ6yd/wPMRI2qdRrYtY92fhU+n0UfYeLFKTowoPweo3o?=
 =?us-ascii?Q?IxgYKYqUXlCKDypgh1sCz13YRKmK0GmcXaKg7rQraIde0YVO5lcCaC+SSlTn?=
 =?us-ascii?Q?LlXWah2HlYlRipT3K9lJLbg20G200mHt12Z4opAc0u7QyVC+24DvUJhWSo6l?=
 =?us-ascii?Q?tqyuvM81mxDvb8HOi4uiTQ0/CDTlaxpILkb1Q7tdD4hvlvzVMRtDylLrAZwi?=
 =?us-ascii?Q?q2Yq0seqvF5P7Ghht+gQea/hBZyJngRYHqg2JYNWHzT4wwkBJ+h8nXwBgFYl?=
 =?us-ascii?Q?hsh0pE4T5+5MA9SMDo9Wwz7+pxWVwCneNSXVtHavuA3Juh7SlyddmeuR+Eqr?=
 =?us-ascii?Q?bW60Kb442pCJJZ9V5qrM4g+VpqMe5T7FxzuqcZ8n/5jKyF6qySdX9V6cYhPO?=
 =?us-ascii?Q?omJqhnvZ2T99ICwgWEOmhq+c0zqEfdx3t8SmCzdRZcaeJg+Fdlk49One24NR?=
 =?us-ascii?Q?rdjmUctDjKF2gA/CwCXNsAwR4ioilp77hYG5RPUG3GCIAlY70GUj7EfNoaW1?=
 =?us-ascii?Q?Po2nfZeD5xOilsQECDB/+UmU07bCK3SqbaYJBq2WdTbYC/b5uE2koDwoTQbJ?=
 =?us-ascii?Q?QHyXyxpJ5pIMFJi1EBHNzAMzQ9zfKFLUEfNBmFHTbwEKOGZcNwX9D3zWPAYw?=
 =?us-ascii?Q?5zBaKCPTIylrieb406HHGVlF/SlfO5VZ1WTJtnqM0dM+MfyHyOonJM+p9she?=
 =?us-ascii?Q?SMdYtZaqnjhH7ltzq04QAwonK5/ZoSKVD/yame7CdwjeNQqZGaCIea3MXASm?=
 =?us-ascii?Q?YlFeJcgGkdCJ+dZ6GZhshIwmH1TKKQw/O0DEOZnwkH6LTOOwH0Qvz7uaPMW2?=
 =?us-ascii?Q?uax7WaJFqjED8e/lFhtCf9/syoo9hNqAwKbM4eJ8RaVGQOPMJoq7jMDcKOUe?=
 =?us-ascii?Q?Yd5WcdEWsc1CvZ3XiupTw9Zyv+BqVL3l1gMMEBiBhsIsvm+dnoOpgVj0URXr?=
 =?us-ascii?Q?zPFiiGbYMrfre0pNBCCJKdMmVXXS5DOTRpUgkh+Zka4ESSrTi55fdej1mMgq?=
 =?us-ascii?Q?Dt9uV6w9byf1huywSVej+Zl51EPaBpR8W0vGTFJ8A66NgaBYU69NRCn7w6kb?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ymrTVYa/8GeOxOaJ5rj1dAyYj3tH43HyXr2kVIq4x4ENeRFHk0tY1L5iZkHlN60wgboi9Fnjctl4SSpMYPAGnHFwq0HdkaLjBr/IxllKWrlSUIs+tC2gqWT74bU9X+7JeEFncw+r11sr1a+mXBB22I5NTeC9iPDPD6WBB1WhP35s40mV4sOyqdecr/iW2KivdabHEv409QOd6mbAy5+Kxy8cBmTx3Yrm79b5Xi6ZzNxYfDOOyC8+9dbgrIkVWJr65fkwWqtsL2rhhCcMEwCatxgij6duL2jbYPIbKW8GHkOEfV1wUtMyOoiDpbYTNN8wERc7JCxjMLbh5wk2LWg4pS2Ur+4f4PrXDA+Qac5UsOgduXdKJuTTNiUDviI+tk9D+RuVCIGmCFoOh7feN49FTsQLL/aQqhXV3N3vY3pn0kE6tYeru4MSE2qRJzUkHTzr85sBXP0TvqoGFXi1qQEsLD2bqEd88KsLBPloi57sCzDibDnI3h5O9qzjclC5hd2tCF3QdhMnzKBV+EWfSDgaWOyS5bV6Mp9WqkekDQvXYd85l8KBuMEtmVFukf7CKl1gPVTh09afImfiIidhZAVNRN7cCxy5jyrEsOtYzbzodMPBypxfarWr/v+QZuQM0nKs6O7Vh/fJuUvblZc5NWFT/KJ+NwKCo5qdBvUK8kiE2mjrbDXtiqJE8os+YzTdVrgxpel5iX9MOBtkQ1/xCV/QTobQ69k5m44zrGWwbNMkipv+ygeAJzNkmpCzsc0LlGdRiYnjNZrPNDSzs7f34j5e92SRzJN1n0KjihaqN3+7YUY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81e65ef-a3b3-4e3b-30df-08dbd9abedb5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 00:54:25.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp0h2nsS5btyI6/nyf8ub9qO8G/OYZ4rLz/iO5dfMhghgdtPhJeKLNRdKEOB8Kh0FryZvrxjtgaTttWyDGWzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310006
X-Proofpoint-GUID: y-nR3mN-k_JZlf1vIJIq598mBROOtOsA
X-Proofpoint-ORIG-GUID: y-nR3mN-k_JZlf1vIJIq598mBROOtOsA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we fail with the message 'We were allowed to mount when we should
have failed,' it will fail to clean up the loop devices, making it
difficult to run further test cases or the same test case again.

So we need a 2nd loop device local variable to release it. Let's
reorganize the local variables to clean them up in the _cleanup() function.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

v4: rm -f, removed error/output redirection
    rm, -r removed for file image
    Check for the initialization of the local variable loop_dev[1-2]
     before calling  _destroy_loop_device().

v3: a split from the patch 5/6

 tests/btrfs/219 | 63 ++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index b747ce34fcc4..35824df2baaa 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -19,14 +19,19 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	if [ ! -z "$loop_mnt" ]; then
-		$UMOUNT_PROG $loop_mnt
-		rm -rf $loop_mnt
-	fi
-	[ ! -z "$loop_mnt1" ] && rm -rf $loop_mnt1
-	[ ! -z "$fs_img1" ] && rm -rf $fs_img1
-	[ ! -z "$fs_img2" ] && rm -rf $fs_img2
-	[ ! -z "$loop_dev" ] && _destroy_loop_device $loop_dev
+
+	# The variables are set before the test case can fail.
+	$UMOUNT_PROG ${loop_mnt1} &> /dev/null
+	$UMOUNT_PROG ${loop_mnt2} &> /dev/null
+	rm -rf $loop_mnt1
+	rm -rf $loop_mnt2
+
+	[ ! -z $loop_dev1 ] && _destroy_loop_device $loop_dev1
+	[ ! -z $loop_dev1 ] && _destroy_loop_device $loop_dev2
+
+	rm -f $fs_img1
+	rm -f $fs_img2
+
 	_btrfs_rescan_devices
 }
 
@@ -36,56 +41,60 @@ _cleanup()
 # real QA test starts here
 
 _supported_fs btrfs
+
+loop_mnt1=$TEST_DIR/$seq/mnt1
+loop_mnt2=$TEST_DIR/$seq/mnt2
+fs_img1=$TEST_DIR/$seq/img1
+fs_img2=$TEST_DIR/$seq/img2
+loop_dev1=""
+loop_dev2=""
+
 _require_test
 _require_loop
 _require_btrfs_forget_or_module_loadable
 _fixed_by_kernel_commit 5f58d783fd78 \
 	"btrfs: free device in btrfs_close_devices for a single device filesystem"
 
-loop_mnt=$TEST_DIR/$seq.mnt
-loop_mnt1=$TEST_DIR/$seq.mnt1
-fs_img1=$TEST_DIR/$seq.img1
-fs_img2=$TEST_DIR/$seq.img2
-
-mkdir $loop_mnt
-mkdir $loop_mnt1
+mkdir -p $loop_mnt1
+mkdir -p $loop_mnt2
 
 $XFS_IO_PROG -f -c "truncate 256m" $fs_img1 >>$seqres.full 2>&1
 
 _mkfs_dev $fs_img1 >>$seqres.full 2>&1
 cp $fs_img1 $fs_img2
 
+loop_dev1=`_create_loop_device $fs_img1`
+loop_dev2=`_create_loop_device $fs_img2`
+
 # Normal single device case, should pass just fine
-_mount -o loop $fs_img1 $loop_mnt > /dev/null  2>&1 || \
+_mount $loop_dev1 $loop_mnt1 > /dev/null  2>&1 || \
 	_fail "Couldn't do initial mount"
-$UMOUNT_PROG $loop_mnt
+$UMOUNT_PROG $loop_mnt1
 
 _btrfs_forget_or_module_reload
 
 # Now mount the new version again to get the higher generation cached, umount
 # and try to mount the old version.  Mount the new version again just for good
 # measure.
-loop_dev=`_create_loop_device $fs_img1`
-
-_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
-$UMOUNT_PROG $loop_mnt
+$UMOUNT_PROG $loop_mnt1
 
-_mount -o loop $fs_img2 $loop_mnt > /dev/null 2>&1 || \
+_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 || \
 	_fail "We couldn't mount the old generation"
-$UMOUNT_PROG $loop_mnt
+$UMOUNT_PROG $loop_mnt2
 
-_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
-$UMOUNT_PROG $loop_mnt
+$UMOUNT_PROG $loop_mnt1
 
 # Now we definitely can't mount them at the same time, because we're still tied
 # to the limitation of one fs_devices per fsid.
 _btrfs_forget_or_module_reload
 
-_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the third time"
-_mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
+_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
 	_fail "We were allowed to mount when we should have failed"
 
 _btrfs_rescan_devices
-- 
2.31.1

