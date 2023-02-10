Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF019691FF4
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 14:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjBJNl6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 08:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjBJNl5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 08:41:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6975720D24;
        Fri, 10 Feb 2023 05:41:56 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AAna06009134;
        Fri, 10 Feb 2023 13:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=OraMvhDWyMjNVGA1b8ZAuZjhbfMHkjPgERczhgltzg8=;
 b=g58O2ODMe2GKmqh7Gld4AzEgScQRkHQM9txSeKM1qcAWIPkSskuK5t1tDTn7SQRdJIAG
 +3PxlpaMwd04+8MgtP54HHxep1w8h50U+IlrGex8xIK0lirAgJK2c6rh9kaaMFNhSKJV
 izUEQOUbYev6I8duS/im2BeBNdJGXiRNjMrDWhH0vMUulQwXDM/PurmsspGTBfvZwZ0J
 Wuvpe6tR1UT6oy5JygDwHAKdOtT2eJED6Ygh4Vkihf1h5IHrmXNm/Tt7JQ7YJjJhNWVB
 x5DIeX3jh7qt6TEDgmwKbH8tqqB3d8iEUwbYtYE06ZzPmAhoe9nIa7PP6rxzkSmGTVrq 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheyu5aey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:41:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ADffRN003037;
        Fri, 10 Feb 2023 13:41:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtas3fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5ggEVFYAA83DpzOnL8TyLaJuVelCNXbCdSc3BLBR69vuuImRs8uGcGZZelbL7pScJoNl4BBgHhUl0XEv8hhUqGm1R1NrW4mdTkBDSODx1y0d01jZe/xm60hZOaYCcsktKXxs9Jz+wXYIpMjtAa/TXLyOSUXCxayP7NRlYRk5nIaeBtoMdIxvm2V0fU/M9ihv3o65ZRX1L6t8KZvT9qIXX59y/p3Z3EP5STfKmrCVRBf9tVAkX0b+hHxIpzlvxjEwhfQzdWG1kKCJ2O+6aevunJifx+LgsL7Ru2DZc1VhotZcTa3dYPfiF4LTQ4JUSprP5UH3ddHwnKOgBBI135esQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OraMvhDWyMjNVGA1b8ZAuZjhbfMHkjPgERczhgltzg8=;
 b=H6kJJmxhaseeSEd1Flg31KqOBWzW2L4SZyJJ153Ll4NJGCQ9QCozEw6xX95YqrjiG6aihNeABNWoxwz89Yw7J2eM/xqdI6ZPUaGBkZumzPJHm2I9+4jeW5YedPfaXupNSJiUDKAb/LZ126Rv298GpEMceymGq7RsgtGX0xJDPZ0ebK657PYV8ul5/JYifS85cX0FHuuaWAVikZL0MZDt2q4mCH2oIBa2RhRNjTFsxYRf+aj13i5jY3wKPJDAjQ1LWHLXFH4fS8hLrssF0RfK+3krKCbp5r32jpQhMQSoiFa6bu/OyHpefUj9SZtasfrfoAXW+i8hNbIQxh4adF1Q7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OraMvhDWyMjNVGA1b8ZAuZjhbfMHkjPgERczhgltzg8=;
 b=fkLRfB9/JvcNKeLh1P5YygNob1cmlxMC9PoZIEXNny3ITTnE7W6cPnP4dhwLlE/7Y1y6yqa0rFv9hdF+GWTAVUIyf2/PExqhl5hiEfNcwMy36gQW0v2ceySKfHs0M/lS15YSZDUV5+MV0FxpjNLjVSJSX/OsyNfCzoBJB0YdaIA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7188.namprd10.prod.outlook.com (2603:10b6:610:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 13:41:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 13:41:43 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] fstests: btrfs/219, add _fixed_by_kernel_commit
Date:   Fri, 10 Feb 2023 21:41:20 +0800
Message-Id: <9c696ea007fbadac5aa4d18ecdd1702cbe6e7742.1676034764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676034764.git.anand.jain@oracle.com>
References: <cover.1676034764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 4612132c-01bc-43bd-abac-08db0b6c8ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fl0764njXRaisZK065sizcgLdrDPe8BLEhLUs894gjG/knoDOeZFbF0eeM3dDJswXgmO61eDbxQHvgPtY/dW7QhV0M5eHzdFteSJ70zQawIJsKurK1XF1ptigyBF3HtEht8S5mjXS6p2QMubXQVulnTdeofhpzHdne+/mVg2q3gouGstmw4t2+pXaU4uNi9OD9mcATg1Hi4gLm4FOIhiwHTHaMlqgSIT6z3QXXJE0C5RjXosIMGKocPxhKcynA6bc3BaE87B1wW1mwUVDUnVrLsNea5Jx0EJ5+BIPxBQhrdXhBdtUiSll0JAg3J4V0U1RPer1TfKnNQkgEwFwO6YOpSuWt65xZC7bEnNkaHMosJzaJDL6Z5xuCh2J/6kUOmSeYMTp7fepos1dHmcEAkCR5ijyEy0YcNw0IrVtbzsEsI2qfDL+BxWZ5IgUjRlVBGDHYT1gl/H145u3LhM4n7TXDGJt0JX3gmVwyrTnk/1KLr4VtoHv29x099OG9CbeGnI2a5vwL/VNU6ZqTLyFO2JwsBFDON3D2aN/LfpZI2cUwKJodICTWIKREtQHg9uk8f7BjtYebdKGtIO9afhChj1SV27CjspzxBnLX1laEHo9REiH0n28bs4OtGOQeyBn1CuKAxGm8KyXYhZcUMdtdVnTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(26005)(478600001)(186003)(6512007)(6666004)(44832011)(6486002)(316002)(83380400001)(2616005)(6506007)(4326008)(6916009)(66946007)(66556008)(41300700001)(38100700002)(5660300002)(8936002)(8676002)(66476007)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdhuYTwB4TWoHxvFDnV4sOUB/N4WWUdTkYvEJOTiz3q7H3gGK9JfafCwZHUp?=
 =?us-ascii?Q?VGM5NKMD5tfVLOvfy1CjTIdDDWOnhC7IA92zZGmNUzB6HfJ/dBZbnveUk8S+?=
 =?us-ascii?Q?E0x+/PlT85f1R/AUFSUmnffigdoL187YbJ+8q70oDHAHQb/1Br9bJweyCjD0?=
 =?us-ascii?Q?7ZNBfBoCXCKkoAnHApeoJ7y+DF0wsceizNRrHiZBc9aHeVRoal/VDoCrIElf?=
 =?us-ascii?Q?mFGuEWN/kt1vwX9KQEzTR9KB84+jodmcn2rVgLQrkzBtmiUSZeMJldMEHCEE?=
 =?us-ascii?Q?q8uBpmZiKGCvpIi0nK9EfevXXI9haRdxOktAg8rxaPSzXBdak+IIVrO1P5tG?=
 =?us-ascii?Q?CxxW+OC0O3kLNBtwp6ooQ7tUkoNy9uqho7aKCYIQ7Y5IaK2hju9sfJuLAnZ3?=
 =?us-ascii?Q?T1Yfuz62XQrj1rK/+yeQ83QMPPSU9SruaRJcshoEr3T3jTOfjaHn4k/NhoIz?=
 =?us-ascii?Q?2v9/LSEn1kHCsiprIbjbmORMfgjObtjnLa0cLuv4m7O/8HO55wGEEF14aXnh?=
 =?us-ascii?Q?Itk6Gh3+T6KGkAhMIBVTL2NjYTt+W46mknZ7ufVfNc/52SZfGbdgEMmDRvyC?=
 =?us-ascii?Q?Xr1g0f+XXEjBmjeC9kGsSf7s9EFj+xJdeJcoZIrkoXEXaKUARmijdOKAdzae?=
 =?us-ascii?Q?fW1cETxxEPQz5LbZk6feQXKR2vrRe4TGs1gPG9WEoPDnfgaSAAq76aozkOSP?=
 =?us-ascii?Q?IyX0ifLGQmiDbVyTtCWfp5JPGf4CpVkaLovSZe62nRjBbznQBAdevAAwAsWm?=
 =?us-ascii?Q?wGcArszexj+6XO8Y1lm69lbv6FONCg54Xilk3L+MD8eOWB2qVQV2O4Q5wk2x?=
 =?us-ascii?Q?85iurIlNyAd9Sa4zTzwFm82h5d+c6Nku0a/Hy+WgCbt5P9WRb3HaZnurfsfn?=
 =?us-ascii?Q?Y1SW/2iJ0OtmkFgx82iA8r1gk0hlw04pNBxvwMnOxh9CBSupJVw5YZigVegD?=
 =?us-ascii?Q?OI2SCxr4bnUf8PRXGIvXnFqJgu/erAorOILt3CGkHjOqDH2+ZwOY7pSsEa49?=
 =?us-ascii?Q?V3J7vPv8dhlfQ0xxjoBTSlT4XWu6fjGieKOSQcM7fdhOkjz6Ak0GDXm/essj?=
 =?us-ascii?Q?0NfciDN2m38f+/ZmcgiNymViN8MQBMdf65spRyA9Z59qlrCg5JwQ4vB+zrjy?=
 =?us-ascii?Q?DNJkwe+n7M4pZMMEkZt3Sq+OZX0msZ5JATyAZdACA50gOscc8Ol2d4mHEYs5?=
 =?us-ascii?Q?PMZMOQtA65KHPV/0OnfCaBcBx7cEN8AsIqYl+bimUptAyLwMsKFBNnbog3RX?=
 =?us-ascii?Q?E9aYPLE8+SoFcclrv6PBLpn7q56N+TRkO+X1GoP8UY6HxeHVJoRkkI4lK2GU?=
 =?us-ascii?Q?Sem0FLL7LDxxFg1372vZ8RNShOaAtTGn/6nouZ1oZMJVEA2Alu90eLQC06CG?=
 =?us-ascii?Q?hhlp4sAyoTpJDhQ3OpmjEzOY2MxC8XSdeUbQPnNcPEbFLftFOBtsxd2UAJnP?=
 =?us-ascii?Q?jUq1gZX1qL86AKAcwQcDJLpHQd3txIOAGoNhUBk1HmSf1OrI1QuU7ACUkfQl?=
 =?us-ascii?Q?0KWjWcy5mgeBQhZ4Z6kW+KSbYUldO1X/KJcdCbdhVJDvMZwj9/kd4P9ujjKc?=
 =?us-ascii?Q?bgNzfdHy4tFKN7UijqE+D6D7rXgtCEb5ihPiqHbI7odU2U87ypK0JPh7sbv6?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JV7CQxCIltH0DZWaeCToGdakPXgh9e9WH2LhVRQdnkAtFd/eIbVZ0BsPHRTOkusaM4z/cjB9ziNzlEVvwAa2Fd+HpsYZXDdRKi1OJ3g7qbmuOdCgP+/tZ2CcZUKJRI0JKgwXQ5YurDTS2zvh4CA210i2Sf5N6KqVUESZasXSVocEpDnI4OQEVVo5YW9iKv0YkvDwE9ujP65b3JM0qwBqLZmaibaHwSdB/WzSQVJ103i927MQ46QdfjmdWMx54hQVzuRROwR1VVsyYHCrGmsEo1pyOSBd9+D221bgS1Ol7UVQVYVEUFV/SThdmNzjvUxNCIhLkl1xoypN6VLwTVnexSRr0XnZAYQfdOCoys+wacDRWHI8lHcRj8qbVtbz2/Fjq8EnkYbA5HNJW+7JidRqpEor+e2jnMNohvoqiFSDychBmL3khQkKU6bdTFONCP6hfGRsWpJC+2985pwtqalboYfTgkh2/81iqpijl2P9bQLCPMj/GpK+ceRStbXHFeeayURtqfhnUSd8OswE6TRFTZXgfQYs6dAP/ATj1wzABX7+8dKIqiIR1mXMKoMi53A+hCFBS5W95E3R/cLxIeR8h50SVUTWP9G6dGRdKoHu5SmB2SlxgLSJpzjLeic3ozbtsfUCMzW7/kJbHv2Au0lqEiztxIPAR2Z++inRuHc00HZMz7vjj5VEVe3b2i6a/HFiNoOFKh8cSiMQWRzuZhLRrV3dFpeDRAXfcbjDNaCEHJXv6wN4DPhEd4CnXGYj7bZlsp2yo8Y9zuLXKf3lyi4BjkHXeMgxJpsUiaLhGCFCgVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4612132c-01bc-43bd-abac-08db0b6c8ba4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 13:41:43.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IhBxJwQjicjFV8Y0UyMUrmni6dZ5uA2fvi0wm5wI6uf1hZWgm6t5xQVjp0qEeYmY1ZIZQmEXNZSBLPOtmMJMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_08,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100112
X-Proofpoint-GUID: VyCfgV6vOyqk57UurTmVbGPji0ZzbtYL
X-Proofpoint-ORIG-GUID: VyCfgV6vOyqk57UurTmVbGPji0ZzbtYL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/219 is in the auto group so add the _fixed_by_kernel_commit
tag for the benifit of the older kernels. The required commit is not yet
in the mainline so there is no commit id yet.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/219 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 528175b8a4b9..79ba31549268 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -8,7 +8,7 @@
 # to make sure we do not allow stale devices, which can end up with some wonky
 # behavior for loop back devices.  This was changed with
 #
-#   btrfs: allow single disk devices to mount with older generations
+#	btrfs: free device in btrfs_close_devices for a single device filesystem
 #
 # But I've added a few other test cases so it's clear what we expect to happen
 # currently.
@@ -42,6 +42,8 @@ _supported_fs btrfs
 _require_test
 _require_loop
 _require_btrfs_forget_or_module_loadable
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: free device in btrfs_close_devices for a single device filesystem"
 
 loop_mnt=$TEST_DIR/$seq.mnt
 loop_mnt1=$TEST_DIR/$seq.mnt1
-- 
2.31.1

