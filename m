Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C397DBB8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 15:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjJ3OPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjJ3OPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 10:15:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97D2CC;
        Mon, 30 Oct 2023 07:15:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDF1Oj029628;
        Mon, 30 Oct 2023 14:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=N2As19RofGLWvKq42bc/BSFkvMBJ0OUd62z+1ocTT9k=;
 b=2xAt3FtHRlTTrQsyZmqAtJ1tP1jPE04zETKGsFv4pCFVPHIq3Sql/0tyMprzpAjBUM5f
 xTjR6ZPNqTJHln9bbwfkcqZ+TxkLNPt8pTTT2AS2jfersAyF55/2dql1IEnyiarh0NhM
 KqfH/XMEnPtuWUGczyERRTES0yD1WrEcyCtxlMyn0k+Zo1UTK/iM0E3NV60TPd2bCU8s
 jcmbONrWUJ0rlUAXYIYf2ILXxR3vvYMzGMsQlkIet6yUbN6tGJnR1ia6RZAfS4Xn+L1H
 qG1G7XQMAw85bLFzRK+PnfzOlAc21YjR5VowA/vJHpPd25u5tiAnwajcqUxLREjbn8bc Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqdtvxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE45iU022481;
        Mon, 30 Oct 2023 14:15:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr4aut2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMNzLaMewIvYT7FVBPYs5yhWB0CAzk2OanrkWprtJBA/2W1QMYUkkzzcqJgi6+536tTth8EQOt6Y/hUCNRMPt+M/QxDChQoCtSKR8sAQAQS3uFcXdjCJc7V2U4SLH4FmDrFkgIRU9QPRisDsBcfr3oju3Tk6b9aQKPA39z9K1bMzucES2C0j/9xhkrG7NQhqIP9m5SOfKNUbKbzs8Upy1uOFwkGLFvfultbCpPZuIk9teapKkyeIb0vaS6J8uRKPu5yX7zVjjW3puqf3Kfaf1uExQNKsshcACz9r2Oh5Ok0zqk+mBfSPjI0X0M12DQKY7yg3Hm7kyWXwySHCyIZFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2As19RofGLWvKq42bc/BSFkvMBJ0OUd62z+1ocTT9k=;
 b=CTqWBICx+m0COniVpVFp/eKhF1HHo8nN+JBWIUKCkbXsOV9+MDddBkF2WD8XQNAx87IzKWuCeiKFD3qwS5toVtjH5B4y3l+kUEqRHyEFxGyJerJmSNgUMxRfeqqdHCaYAzMBtYsRkAbMz0EY+YnJn6VsU3JrzoXXIH27jYm+u4udo5JTuBeMlsvowI5c6XU3Xbu/i4kxtXpLup/hMS6T0pvTKFkuf+Bx/bby4lEqbHBTbM6687lTtvMz6Bzx8Pq4N4CKULVN6vYKspH+9E65FhIPiShkZRuugnYN1ph6odnHfq3wyIHTdxIBuBgWPBLLCwmTAikJ2ahEwzEM+cL+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2As19RofGLWvKq42bc/BSFkvMBJ0OUd62z+1ocTT9k=;
 b=Y4viucTc+YoHLLLsrfolXcrMAr1Udm1fQUXc/CFmlkmlvFgmFXvZWrjYDaJXYSGw4Mf6CuGdQG+yYLrwpYa/Z5kTLtExsBj54NLYAlo6SEVQi0Ux/PcrRfHXCbmjD2nsnfbONRYFts0xrNdXVWMZpgrL+XXykfBMn9DB29KNh8o=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 14:15:34 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 14:15:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 4/6 v3] btrfs/219: fix _cleanup() to successful release the loop-device
Date:   Mon, 30 Oct 2023 22:15:06 +0800
Message-Id: <3559a441f8dfb450881001b7f4cbf780d7fa178e.1698674332.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1698674332.git.anand.jain@oracle.com>
References: <cover.1698674332.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: cd89bf91-1c2c-49f1-1cbb-08dbd952ae84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+lZIgEtVeDcbpEQc1luj6GOToLCWD6NOvw+BEmr4BsZZtM24D6o/CevwJlmGAZms4ScM6iJezH3tkPGnqv7QT11eCgngWf+0F3krAlijyRaz1cfltr8SXpiXnk9zzz6o8riNMSItBjHji7QJTZvxcEJec5xCrLEYGAIOikUm0y4Jl0swxQBHT/ORta3jOPUGa9nuVcv/ZnNStZv46zUg8dOnP0zR710wEj9/lkZfp8hQl/vCJimtXAoAOWRc9yTAYm34hnxNOp1xNv4pVFIhYfwIKZ8wpYsW7hlV6OdXBN2fz0rKWELWd/yXL5D0dpjVdpSYANcrOLyyaFS2StT+7NWrQ5LkEZAP8V0a7RzyMn6kanMckbs7QWIOLQcVz/VM6S3eCG+heyLlub5l0+QeHE021VI7ugV+1oZDq2VrUXnBN/8lAEKjhtC4iQ0RvIl6GP5oXIzyDEISBMWqlbj2opZ2iU+efNXu5qhA5T3Ffx5bsrAqjxPACSh9ZuQZrTvqfbBRU96gIlUpKD8LJJUvtvDQT/8WGzc/C5MCyQNsR5XjjD5+V0DdaWrHEZ5T945
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(2906002)(83380400001)(5660300002)(2616005)(86362001)(6512007)(41300700001)(44832011)(66556008)(66476007)(316002)(6916009)(66946007)(6666004)(6486002)(6506007)(8676002)(26005)(478600001)(4326008)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nk1b6ebbPi9B6I6Oqfo+jwagoC1Y21uF2vSxSIHZDFVIIO7jGje9v4QePTOt?=
 =?us-ascii?Q?uIu+riegRdqNorOXr9vgoUM9OYyywjpCTPO15xZD5iZAtB1WVP92g48z0zDJ?=
 =?us-ascii?Q?56CGwmPfq0gqqF61KU9/ROPbLg2kqBstRWrwkJC+MBtfE4bUV2dYB2YZmD9E?=
 =?us-ascii?Q?nceuNO+lyi4NCJcoXDzNbwrDs4k12jsP1AQraRjz8uriweXT/7FFLH/1QUHd?=
 =?us-ascii?Q?X/MTVlSF7uiScvbKDV9mfAKVdwxFjkrCUAf/E/r22UbP8HoRKF5zPK/LwcYq?=
 =?us-ascii?Q?0el0/XvkZOgCZV1N+RkTmpzbTMZsHNk8vT1VNSWgY6WbZBtxsESuHNtvrnkw?=
 =?us-ascii?Q?6v5fNr7D8euy/afapwX3zsvLzeLue9w05ScoO76cj/IQzAXvz0w1YPX0YKk8?=
 =?us-ascii?Q?13nISLwTF1mcKMq7NecgjU1jRENITpILwN+7aG6s0CgyOsKMdYmAungRqDUA?=
 =?us-ascii?Q?jx3x9y3aTg2jNmeBujnoCOobOkt1AnI04wrGvTbcNu11TKcnr8nNM9L0tnqP?=
 =?us-ascii?Q?d2wdAX40qcVilhUsrz/DxG11w/NabWj5mNQzjhxAtcF/3W2pZwIp9ID9VKqP?=
 =?us-ascii?Q?mK154ba+cGQumSUNaqvL3kDNUDXbqBfa8vowZ88Qt+04ZLV87S7OM5nzvyP5?=
 =?us-ascii?Q?Fuik6YbFMLdk5wQwWyCqrg2K406W9ECzXO/jOh0cLciEH6flTDddsHSDhIAP?=
 =?us-ascii?Q?mX9CbJrmwdcwl1gVF+gK/9fLN7hIvafCrl+Bv7I1qokknPAtLsT17VO++Ha1?=
 =?us-ascii?Q?SVQKvEJGw2JP6LFAqWltBknQifZxVFzfgTeocKjIzlApZNFLXOlLEbHgxTB7?=
 =?us-ascii?Q?9CpIHrKdemvB/2YtL5Hxs5dT9HTHJRE+I1IgnHc0CR2awj6vA0i8HpOjU2R4?=
 =?us-ascii?Q?ZDIaHV8dQj+6xTBhQiYz2ljaeCz5Fmz2su3INqDsjVldvig1Hi/huubOaj85?=
 =?us-ascii?Q?l79zk8XPvjbE3z/BHiKu7eAw7Lq0onK+b19tX6dTI74A65Jxv8dYCGQkKQAv?=
 =?us-ascii?Q?ybBm29qmieTCypTqYvsvAPWp8gptfrkvO+x3nmcZbOf5xyoj+Arc/+zuq3fn?=
 =?us-ascii?Q?i61VWxvUS2mlVI7HosNh6QcOMtn5YQQWSHldLV6jZh1Lr9KojmUyiMktd1wu?=
 =?us-ascii?Q?f+K1EcMZBXBEgeUFS+PDZTrvC1XgMzWihChoIpIKNyS/dNQAMcdYhq0UNe0Q?=
 =?us-ascii?Q?/4NsDX2F8IIFhQDebaHzHb1zszmgjXtOt6aGMsLLrH8tyOhCO6MuHpL/vZCE?=
 =?us-ascii?Q?5TXnKGlPeWiIg6Xtlhw/oSwkts1Fme6G15hMSr6B4H5oo8FlHSdINSPAWWBj?=
 =?us-ascii?Q?BhklV8xJGJ+iid9KPd2f+rzK64q9TRB7rUCofdjYhUHcSq7eq2DiT1WFuDyo?=
 =?us-ascii?Q?sXSNAdgU3ExO5jNDaI2J8S29H/KsY3G35bZfr8nZ8gwg17Re1FwSdLCZUmk6?=
 =?us-ascii?Q?wkUrm8BDcGLWNYPOv31PY8QRTlVOby/pDBliavhQdjMpYjpaugZyxqLyenp0?=
 =?us-ascii?Q?e7SIbzexCywmFY1ny4Kl5a1WdMmwwAS2I+vw9B8vCaxfadSUFmBFWU9tOzp6?=
 =?us-ascii?Q?9Qt1rEUe76nQCxLFnyhxav4oAMdVRgmvVm3xZ36e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MrozQKKvpFWxI1b2aqkAW5gTKS+YheyH5MJrN6ICB0YuI/q/HReHtDFcXyq0lcq+c+qh3p2PSWjad16t+bCCOjXACaSNa7nGdtPu+mpZiX0EnPSZEIrF9+yiQCaiRbbXpyAvd9s/KiDf0km9iXuUhpdppW+3oZjxFVQS/Ef4LaoB0v3+lu6CsAdoZLORBfp006ROBFo1zCQwNHmjEac76j8qrNY6hQde4IH7oAYbciC2fXdza42gtoJydRO4lqzvZS/oD9fmsgPt2PglQ/kq5gjApJ/DYWehL/L3tjrvWjla09r7/12kG+kxNhDViQV6urxxuyphrmuGkefR2NSjghaJVuiuaM7im6gbkQ47SL3En4F9PsgKk/uoNdqVAj1iaMqEE1+sLLSvgVG4PY9dln6tsSSAEVO9a7R593jPbZl1KtjTeRNA9nte2WUYUntc+nC0YNeoph90DaJZCjsiNzw5wm7zfjwJr9NOJVafcV0P963dw5EnIiJqGjRnyYvUmyMCtKEdbYmnUwDUkxqm/q/FQFrEgaYr20x9Z2jc+i7frcOxH5/SfZFWYV0mE+DLv8G2Kwh14PhKEMM3eTlk6VB5ou7iKUfs+/f7M7i3aNJdAa7Em8WT27csQ/J6xdTrTn9LNa3kIOHe7NvEo2CiXa2nLXoUX1F+6OdCmxao63RoJDBAduwH3QpAJjiDU/XpwVzHUe46W4CXjd9GEW13hVsmSOxXJNiLo0B4g4lY/SjkJiCrQ/raWXusFGYpjnIStAL8zk1GXrqX4BHUPy0lEZ3JwAscFnELzPxuJ1oAecU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd89bf91-1c2c-49f1-1cbb-08dbd952ae84
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:15:34.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15eNsztpwfr1Mzq76zx5cBECoXrms8gzqAdQq0K/q/F14iFX8QY57y8+kEQc6NocqZ/S5KY/w+aues71dgxMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300108
X-Proofpoint-ORIG-GUID: PWHIr5bViEBrnl4MYNskLL_mkTN5obzl
X-Proofpoint-GUID: PWHIr5bViEBrnl4MYNskLL_mkTN5obzl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

Before temp-fsid support, the last mount would fail, so there is no need
to free the last 2nd loop device, and there is no local variable to
release it. However, with temp-fsid, the mount shall be successful, so we
need a 2nd loop device local variable to release it. Let's reorganize the
local variables to clean them up in the _cleanup() function.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

v3: a split from the patch 5/6

 tests/btrfs/219 | 63 ++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index b747ce34fcc4..44a4c79dc05d 100755
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
+	rm -rf $loop_mnt1 &> /dev/null
+	rm -rf $loop_mnt2 &> /dev/null
+
+	_destroy_loop_device $loop_dev1 &> /dev/null
+	_destroy_loop_device $loop_dev2 &> /dev/null
+
+	rm -rf $fs_img1 &> /dev/null
+	rm -rf $fs_img2 &> /dev/null
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
2.39.3

