Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7F2798AB2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 18:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbjIHQc1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjIHQc1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 12:32:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35303199F
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 09:32:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388GKFfS006826;
        Fri, 8 Sep 2023 16:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=7djtZ/LmgU7zJOeuTHqVo099+NGeOpT44KBuM8DfdG0=;
 b=cWJEGHqL4w8bgHsATaUmYvYFsPBkowTun+0ctHTWyRQqQdt8WMQ5VUWr5QM/fVJvrFX+
 5f/6G/h5rqNe1XeRMNmSrhYK9ATuPJdIKRvZNl8q/BLFnK/CW+ryx86B5vohcrDEug+2
 Bv34LLI5YRwil0jFy5sAqI1wjV+elACjg1YrFq3lzKqO8eIooUyrLJDhQQxhvs2mZY9l
 ZP0GvwO+WOvwQEwxgPg8NDylGPSm0gNtDu4bxohXjxTrGoav0O6Qo8s1uEexZCZe39FU
 euUaUmbtUhdiVFHSG8hnIR5HnUVy+VjqmliiLuX1qbYZIixmpWazHyjHEjzWLATVbOgo iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t071m00xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 16:32:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388GNfmA039832;
        Fri, 8 Sep 2023 16:32:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug9c05v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 16:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laJpemlYr3ITrXcauxiNVBMsC9wKWLSt2EiOS45aGrk9T16rMdEx8hWnrfdzxN1N+eePiz28WZQokLBVhYz7JuFGLiabw5WJ+Wr4Ohpo9t+GYAfoPjNUvd8nJmy+O45hswtKZHIIF0ySOxRP7U5Hly4eZsqava6At1g2EvB4y48giBrc/GmEgH7/IF0EHzAmYCf0Uk2CfNLM8MkRFQs0Zvqp2Se2hWhp5OQZpbDVSZK9jO3tsk6D+PBmcsZX3Dc+5CeMuwDEq3uSOn9ImebDp11dG8vNw8uFeNfGE8BcvYc/62z9FrVztNLx5Z+9isLZpjozTQj1I+VTTRLRTUuXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7djtZ/LmgU7zJOeuTHqVo099+NGeOpT44KBuM8DfdG0=;
 b=DV0HhgREnwcbLtdVSV+sLQwRJMG0+2q+HFpT5RiJJm5fDSgD6yMUTHgcP32vs6qN1BNpULWY1FatcTkdvUVeYeCeCre5w6rbddwlJrfcfMoCLGIGoI7pDvqHTZ3T+zuX8VmhMFqaEybIOV+f6EYDZALexFACBNmutLI7q3S07Vmy45Vjco7afgU4Z6za51U1GJDxPXBLSkilWhM1fawTb1xORPRpDYJBgJvXrwioaWxo1jA/GFGbOeYv2PBJs/0XE86ByAHcVyDTcWvXc3A1YHoHM9aZO4xNDxV98JsTR7L+cpcJ3iUkCf+ZzErO0b2Lr0JDTEH2sTBm5Q4oKnFUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7djtZ/LmgU7zJOeuTHqVo099+NGeOpT44KBuM8DfdG0=;
 b=HXNnV1E/Rp8Ny3bmP2wAfBB63dLpYMOhfmzcqwDFajBFEFKRVwQ7hOvfDBgpw6VWabhT0uaS/Ucdguj3ucpqto6U8hNqDFFZO3aK/SxHYpzGk8M0AYkDBree9Dz1ldchGD8ImnLeMGc/u3ZFasE/KB+Hm1r3sAVYRTVf47Tkm+8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB7011.namprd10.prod.outlook.com (2603:10b6:510:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 16:32:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 16:32:06 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, gpiccoli@igalia.com,
        dsterba@suse.cz
Subject: [PATCH v2] btrfs: pseudo device-scan for single-device filesystems
Date:   Sat,  9 Sep 2023 00:31:55 +0800
Message-Id: <de8d71b1b08f2c6ce75e3c45ee801659ecd4dc43.1694164368.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 87397ed2-d3d8-47f1-fa86-08dbb089240d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AskccmtgkGTUZE4njjKuOGOxtZs/z0hYYGxyHekBMuuwvkfzsnpm0W7p7loXZBcMnEXyONcDGqse1Ps0GuD/zW5G4YxGsPVOe1HWytPENXVFO3nEI75TRmHiidusRnypjOzdUpevktRhMraX/oITpkrAfwoBEQt9yz6cmwt2cVxIREp6M3gOmRWf8GFRRnuyNth6KF3UpdK9mcO0hoM+kE1nveUxNTnekHhMTxtoIoKh6zXYRHaB3c2DSbDXvCvv2pX5ft7mLYuOcYV113XkVBtt8Nbeq8ASvX/8Wf/8CT52h+bVReu2s+rHBND3yF1UrP9fsEIV1JmopJW44yeikM1IMtzwmALV/7nk68ZSgZsx53AkgaqF4kqy0IcHUkvBHcJJe2w53iuoflpBYkIWW/ER5GsHkJonZTi1wupLH+frSTT6ZNNKfRc5OnYieKMn5LaCkjSqguvqOt4o7r+TVl1US5hb4BI3XVTZ4WxJKh499RLI4otaeTTBnnENzWFS4opO9N2GBLpJKUnI4vn+qD9Al29WeTviiR/mqSaK5CgUJHdcK4te7Z7Pe1kzHfw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(1800799009)(186009)(451199024)(6666004)(26005)(478600001)(66556008)(66946007)(66476007)(6506007)(6486002)(2616005)(83380400001)(38100700002)(6512007)(316002)(8936002)(41300700001)(6916009)(8676002)(2906002)(86362001)(44832011)(4326008)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RK+NIdXiB0KLXJgnSmmT8BGr+V5NiOTYfbS0dyS9ORAaxvGT57v8Du4vpoAB?=
 =?us-ascii?Q?vKa3WX+qKMIMLK0FI7DN1IfZBwkN9dJSJ2fvf+rUeht+eKcKajcr3Ppk8j4i?=
 =?us-ascii?Q?4/W5FITwHtMaYWVswrmJi66ZGR9r5K8S1CQngmZKiuRP2jp3dzdlf4P+jm6s?=
 =?us-ascii?Q?sQT55gAq+knuqrmS5X/OEmjl+hEkopQ3udxZu0Q0HLrVZ6Der8bmc+VYsggf?=
 =?us-ascii?Q?69UJYVUV8lL9OlaUJgiK2eMh4DrU9mRmp8/MOO3w1Yl9uVYaZ33+ws+vEDyx?=
 =?us-ascii?Q?sxnLN9+UQDXCzt9Bun+VXJGLe5kpbpEsKKAhV6iscVR/7t4frMPLGBhmjw42?=
 =?us-ascii?Q?by8Gc0UFSgmR5ZFGETshwVv3lUNmSRxHe3yDSx7ie4TUeoNYNLnd0qBz2iye?=
 =?us-ascii?Q?p4BWAT+7SZNmoaE//BXzMSremIzIVnh13jKdCmpM+t0GItk0WEbkigEVJs5U?=
 =?us-ascii?Q?ciAM0B2Fj3fe5Ir2WVlwHWSdjE1jHJZ8b9NPk5ZoP1MoXBLpobLev4sEZewD?=
 =?us-ascii?Q?QnHHu+eyB9fMRjpvVsm3SfV/RardJVPJUsSivxC8zsmYbC1kZ9JGRaNRDbjI?=
 =?us-ascii?Q?0Ke6KNSagaHm7eHriTRrhlioKG9DV0rYFBFhx4T/1pzvHlpJWKLvKqvY4/+S?=
 =?us-ascii?Q?UbClB+MnLZTyV2xNzPoXgjA+cmUFmwMvLCgUAhv3hs/dTQBIFVgWJcI8JOE/?=
 =?us-ascii?Q?onfwD7CYGnFsxrWMjjmjnSK9Q1pr/eV51GWV+Qd2lZR5bGbWrFBHuwvyGMGu?=
 =?us-ascii?Q?PFa+eNuN7WgmdEngiJoKttRoLrM9zLfLHLhU2JuyvWcrorLAnUwSFHpa2J3C?=
 =?us-ascii?Q?dUEJrGB7ooaZZKoYtXPMMdD5N61LRz26B268Hqn2HIiGAIi241Nm++XIjz+q?=
 =?us-ascii?Q?EFfA51WR4PkH1I6kASdACeDSUHU5a/m9HaaLYasEnF9azmRCKN1PJKRm+5VA?=
 =?us-ascii?Q?VUkgLZML/m8gyXjfLMGF2LUsK9mRdyHkF1b10HxvHxskFcysf9f5f2aD+0wc?=
 =?us-ascii?Q?ehNWt1M7iAf8+RO4kV0jDEnO+kofYBlvcDyyICgBS9sHW7gEZDpinBkHnHB1?=
 =?us-ascii?Q?PMVfeECYS63TCHNGqa5O/R/JcwYAJq+J9gpisw39MLzbH6tDyYXjLOJgEjv0?=
 =?us-ascii?Q?NZlr4yf4AuulcKfE8/yxc34psm6/MSpoGhsRw1qjEHYH6c37AImXjqPTEdAd?=
 =?us-ascii?Q?NZql6I9gu2if+ltZiYDLVtvlMXBv6OIZnS/UoAs2jBeaS0VRA6UCKqMp3hVL?=
 =?us-ascii?Q?PGS48APbyxhEunN/ko05TrmQMQ9bI3/dLGcdyFW0w/O93yZjBC05J3BJ2+ie?=
 =?us-ascii?Q?KX6JyqFhcnkczJB4aOfc3hKITW0gv8XQJ+Hwyhxt1B8tDl2WsMQX2aCi6xIt?=
 =?us-ascii?Q?poKlLA6F6XZ5ZLlggAqU7Mt6ruqlJZ2KFO7QipYi2dYGNp/JXiHcikvXw1du?=
 =?us-ascii?Q?8g0Bheb/gbGFWfHP7Gk6QKdTIVCxnDBfxxtNWYtzTDKHasA/ptw+DyvBzp3S?=
 =?us-ascii?Q?CrqQ6ppe3oGtdmHBlH6AEdJQZSDQI2p1vOSQ/rqLM40NZxy9lcdlXHeh0syB?=
 =?us-ascii?Q?hoO0wgFLXrvaTKMMAWk9Oxszw1upsskUH1dIz514wegWcytbH/8cnAfcLV6X?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +yXQV14ge8uGvBu2dQcWXveLZn/CTzXLkpUxwLovwos/gba9OIToRRCMzUMCAdQWbcp4gQ2N/B1oJzs5bCL9047bkISAbfa/waTCmy1qGZVt9SbfniwrI1QKBvO2tXmhD6ud++VWB/H8joxSHUTT2xUyWfhEcBIdBs2Y8p3OSC6EdWDwx+0hivnDxBT6ce8IQnhczZlGRmcg73jc8mmxrIWnk1kdXZY7J1thG/1xkRgLN8am0fJk1GrzeMUGjbDhZWTEsTbbaLgqSCs51LbAXiO/LNhaz0r6YRHe7V7DDEumx4RoMuYUai758/zthTaT5c4lqFpmfGPsKpW73EcyilSSpKFYtWXji9tMgi0i0wc78RVrqRaqykU6RVIa0+ETPnk8OXYu3RLzg4+OMl+csnYYEj632xOBz+nFQ/NzU65QoRNM9zjswmCHNE27cD1T1WyMhXFoBi04BAFBF/BMrGdFE3+FLW+seiEX+WZuSDlo3/hcMEvOGa8Zjnca8PTHYh1yrHiluI+VaZ/qct/J/uqAVimIb5DJSEZP15Tc9wy4PdlxGH5HH24VRB3ev7h4EqJ/ovAcLopGM7JffvSmxf4OKmixWp6eEdA+6JhyxuiMOsdtwX3ftUmtO93vXbP4LyOA0NC7GlGcZFK/fZ936POA/hWUzEU16V6x5qbKgloflgdNCmlI1dYsRlz12srucx1nEs5NdvEgBB0haqghiWR6V+dLWvsHPgYf2unOd9Y0pOmeqfElURwjVqphgCMp7r2F6tk28OF/q4gmzpRpzAchf38lDxgKaDD0HQ8ZS1dV9axHI7Ourdyny1WXlMfl
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87397ed2-d3d8-47f1-fa86-08dbb089240d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:32:06.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lem9+X82gP2SApsXzN9oxGHz6sMKWtySGNnouC2ol0/8NTA7eYt2VWJdjjhJDzCWArofAOi2nTOl9+pFLwVBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080152
X-Proofpoint-GUID: KDRjiqg4aJRnbWMotw4rT9hSIIGzt87j
X-Proofpoint-ORIG-GUID: KDRjiqg4aJRnbWMotw4rT9hSIIGzt87j
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After the commit 5f58d783fd78 ("btrfs: free device in btrfs_close_devices
for a single device filesystem") we unregister the device from the kernel
memory upon unmounting for a single device.

So, device registration that was performed before mounting if any is no
longer in the kernel memory.

However, in fact, note that device registration is unnecessary for a
single-device Btrfs filesystem unless it's a seed device.

So for commands like 'btrfs device scan' or 'btrfs device ready' with a
non-seed single-device Btrfs filesystem, they can return success just
after superblock verification and without the actual device scan.

The seed device must remain in the kernel memory to allow the sprout
device to mount without the need to specify the seed device explicitly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Needs fstests fix in the mailing list:
  [PATCH] fstests: btrfs/185 update for single device pseudo device-scan

V2:
. Commit log updated
. Handle 'device == NULL' separately.
. Convert 'pr_info()' to 'pr_debug()'.
. Btrfs/245 test_forget() was failing because it checked if the scan was
  successful by calling 'forget' and ensuring it returned success. As we
  aren't actually scanning, similarly do the same in forget aswell check
  if device present free it, and always return success.

 fs/btrfs/super.c   | 17 ++++++++++++-----
 fs/btrfs/volumes.c | 21 ++++++++++++++++++++-
 fs/btrfs/volumes.h |  3 ++-
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 32ff441d2c13..39be36096640 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -891,7 +891,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
 				error = -ENOMEM;
 				goto out;
 			}
-			device = btrfs_scan_one_device(device_name, flags);
+			device = btrfs_scan_one_device(device_name, flags, false);
 			kfree(device_name);
 			if (IS_ERR(device)) {
 				error = PTR_ERR(device);
@@ -1486,7 +1486,12 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		goto error_fs_info;
 	}
 
-	device = btrfs_scan_one_device(device_name, mode);
+	device = btrfs_scan_one_device(device_name, mode, true);
+	/*
+	 * As we passed 'true' in 3rd the argument, we need proper error code,
+	 * not null.
+	 */
+	ASSERT(device != NULL);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
 		error = PTR_ERR(device);
@@ -2199,7 +2204,8 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
+		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		/* Return success i.e. 0 for device == NULL */
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -2213,9 +2219,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
-		if (IS_ERR(device)) {
+		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		if (IS_ERR_OR_NULL(device)) {
 			mutex_unlock(&uuid_mutex);
+			/* Return success i.e. 0 for device == NULL */
 			ret = PTR_ERR(device);
 			break;
 		}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 63bd5f47c698..07e3f9c2bfa5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1218,7 +1218,8 @@ int btrfs_forget_devices(dev_t devt)
  * and we are not allowed to call set_blocksize during the scan. The superblock
  * is read via pagecache
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
+struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+					   bool mount_arg_dev)
 {
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
@@ -1263,10 +1264,28 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
 		goto error_bdev_put;
 	}
 
+	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
+	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
+		dev_t	devt;
+
+		ret = lookup_bdev(path, &devt);
+		if (ret) {
+			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
+			path, ret);
+		}
+		btrfs_free_stale_devices(devt, NULL);
+
+		pr_debug("BTRFS (%s) skip registering single non seed device\n",
+			 path);
+		device = NULL;
+		goto free_disk_super;
+	}
+
 	device = device_list_add(path, disk_super, &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
+free_disk_super:
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d2a04ede41dd..e4a3470814c5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -619,7 +619,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags);
+struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+					   bool mount_arg_dev);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
-- 
2.38.1

