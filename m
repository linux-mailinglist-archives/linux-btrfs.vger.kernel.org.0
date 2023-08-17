Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD077F9A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352291AbjHQOu3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352276AbjHQOt5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 10:49:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762C94
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 07:49:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCOP2k004124
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 14:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=A4VGkY8fgv+TsBu9P0WIevf/0LFrD+rlYP7yXQDUefc=;
 b=sCUOTVF8ENWAymcMm9rYIoTSGEPKdzAM7ZsWyptu37Y/vsLZZCODbtQKB+pFgBmzPB5z
 0PY++b8WNuCjZypV32dR6tZOOlvggTiYaIAzD5e9KhUBiNBjXz4QmdcVHqvyItVXDwdW
 5Tc1sQh4V+1texbYVFzR+TxYUkUCYMth73rUv0LiF7+bU+dANNjvsjLzX6hZmrF7Wy4B
 IwGeWmHPejo/XALPiqf2BO+mX+NeJ3lw6szxkWsj3onTYgv+/qqFAPDpxhSatfDFHP4t
 VZHIxR1CIlAQS1VN4WIs3FWCwH3uDdg0NUn7jBleKP/YIuGrIKzbyJIBn6atD/jb7rW7 yA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y31r52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 14:49:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HELjXD027320
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 14:49:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1uwym1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 14:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUjrVkzwxJ7YRB6d/bApPC0j0bh1g9IIr4eK5QoOP97Tc3Q8XVYP211p6vW4mIncyCH3WEBeHqWCsWvH0isPK6pv07xdT/7j7qWwIJsLpbU2ulHcFA4h82bdWQYvAONXmXRnO3F8rtHRXkp/bu3ctSqjRRk3eU6UljgQ9mD2xQ/MSVjB3xM99ZeMTw9fP9gdaVKcEPAgJOIe4pYDS/TFHv5VZHl8B0ceanJU+WgMfTbesZfFLPRjTqaUXgIvdMU9Q7osd95dA3o4UPJdwJkOmSRoKEu/eOqL6XWqBfjS8JPekTeqNZxeoB26Zdu+47issz6ts+fyMyL2HCje/2XYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4VGkY8fgv+TsBu9P0WIevf/0LFrD+rlYP7yXQDUefc=;
 b=SQs11C8p94ktB+hRA3fdp2104xrhk9Di/ECCZ5tRfhWSs0clX4xy7hoOUNWbXfr3V70WcQUG/ZqHVYP48FzZGybIrOeRKI6WaBbrzEyOrsolzs8bGfcRMHIdaZu5OXM+VryFWav31aLHml+VY5HmAxAoalcjnoJnGl28YCeC34RQ5QI067Z/Rt1NHabDmR2GX//JmohykqRi+3w2ggdeOJOh5YOSdzK7AnMmJXjuv2YAmo2PwY4+gts7qlfG2/TSpO5hV7kBFdRs5MwiRe52VfizRuGP1YEAeqIUEt0hRhrMZqpE5ID57cdC5WffKi4/t+tbytaJPw0jfxli3CcopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4VGkY8fgv+TsBu9P0WIevf/0LFrD+rlYP7yXQDUefc=;
 b=eNijOYQHkkJD8LePCs8WG2AgcjVfu+h9AEqzwoc6AvnaV5YPpf6NFhzir7JnnamtLcamLqSDskN739KQnyu8Ws48bOr3L4IPHtRRCaXX7+lhfm1obv+INXbjVnOcYN8lN6XKg2DS4hHiBwB9IPhJ0/lvTnPlSSVP19a+BugygAw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4217.namprd10.prod.outlook.com (2603:10b6:5:218::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 14:49:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Thu, 17 Aug 2023
 14:49:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: notrun kernel testing in test-misc/034-metadata-uuid
Date:   Thu, 17 Aug 2023 22:49:42 +0800
Message-Id: <887aa1351ab20205488614336fecdb02b71edf34.1692248086.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 640f7a4e-1195-465c-2b07-08db9f313595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2xuhy9H9VUldkVS2z9z8lXJXS4HaNgTPofE8xWoonh6Lf5QcvZ1qPttUkJPnPyiNfF7Q46i9462eCDNUrB9z9RWrke8nJiDxBBWRXndmaPQL8qBXMpLUiDKi8/EMW8vtvpHeU1MULxnJ0XLAYnp/Wfvn8SL6e7t+W52hMLIJ8Ule9rwOGgtjnlwGonUGcWToNu6f8rPVTe07GiRnkrPdP2xh9u060LJ6mPdjvrXd5Uaz8q8WhvomroDqmMUMrvkvZD98f0fJhw4TealbQcBkGjKJpP8YqjsBbD7NrpB0EOo/eiPVV8jscG0Cr/HQocEBI+fUTcXvV27WclVt5OrMvuOBh9rRDVEcCLRkd7gbjV0bcGqjHLd1udilJ9oSQjYFU7F6ATQyrHl0q+DVZUu1sE/1x0xe3K+7cI0YnggEN7NLgOpkRSySLPKkdCWl4zpluMWUXvPMOon/Xnd/LRC5x0GcogCleyxBNQ0Auqg8evCsso8zQWuPS7OiovAdP7fx3oocCGwSGAYUcekxxdTZvMi0tn5vCqoouKyaQg3Zho2QYeqXEXHQB/vzprmxYiQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(1800799009)(451199024)(186009)(83380400001)(5660300002)(38100700002)(66556008)(66476007)(66946007)(6916009)(316002)(478600001)(44832011)(2906002)(41300700001)(8936002)(8676002)(6512007)(6666004)(6506007)(6486002)(26005)(2616005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPufiTgy2lgcfVslCNuhoOgYHvfJAIFU047zwps1nv0Z5I4yy4CntO8pNrNP?=
 =?us-ascii?Q?Yc0yWd6KOOrdmSBpkjP01h9hs7XQi56CtjSi+BKxpjIPPRLV4TUhTu4c/5on?=
 =?us-ascii?Q?CTRJG5yZBZo1IdroE5zbN1/+UR20nwTdaBiubtsM9+yc5wYCBe4tnGTOc2At?=
 =?us-ascii?Q?VnpYRI5cNwJwJtFRIgzAEoLx+ygpHYRWmDaZwmlyZ8Heb0/v9wQXK4NHHFfM?=
 =?us-ascii?Q?4IlR4E7e68eOQkvBQ8QMTk8dclmMZNqT2QWROANNi4R8oI64R+R6lD0ER6KI?=
 =?us-ascii?Q?VBpCeh+VuJejvEuXf3Dw8cYvIyWOH9+wKOmJw9o93/rSV7FmQ7DQicMNqBsf?=
 =?us-ascii?Q?5QK5OXxADYpimeOLebGXlh3uv8dttyOnc6J7XfDYGP6V/OrM134gkOu/DRcd?=
 =?us-ascii?Q?A3pJblLDwUd+G6aIHwbUJvl21JmPQJqIPHfCBmfLB/TyZ0biGGxwdcbU9QPI?=
 =?us-ascii?Q?dcZdDEb4IVv0H1sA30AoHgKGA6gxFy9rv70LkB9OOuZe6KZarBe7BCZJaxiE?=
 =?us-ascii?Q?UNw/2Wv9FXCvOpylq0ZhnKQsY2lN23wNfXgRzQWqqG9+H0De28d2/YXV6zCv?=
 =?us-ascii?Q?DvNXzLl//huDQyPy/RNaTC4QKT7o0HXifBbmEeCfFovcWCmzUeLtoHbNKPcP?=
 =?us-ascii?Q?oivZKA4H3ESJkhTuQrfMANfCBCVS8cN4v6bCG6rG6NCMAVv+vrpSOakgBrG4?=
 =?us-ascii?Q?KX+YyImlGtCIHHO1nl6cXDBsA4q894wR7c632NGJ/AE53WIeEFlDU/fCLEm8?=
 =?us-ascii?Q?lwXd+TMOJIqTMw5rkvC027ZbJOc+c5Jx4htAVPKHkfvbYdupMVOQ1kw0SMhw?=
 =?us-ascii?Q?QwnEYmikYUmZqmlaJwx+xyEsNwfUFqa/xkT49PUvG8m7LR2DcvuRYZjJqrz1?=
 =?us-ascii?Q?xd7Voa0t4cYO7kYtYvCNCOb/JWRbPOYpyeUtK+bRi5NB766nj7RW5/J3bem8?=
 =?us-ascii?Q?WwGCMgVnOlDapMXYG83wzT+YZN54tcNwcd6vahqQf4BSHPXu/eWY+JkabUSf?=
 =?us-ascii?Q?ZazAxHqcOogdpBxrnLI2E2HQmRpgTAQgnFdBO9ddCVAQ+MAvK7vx5WVPi4aM?=
 =?us-ascii?Q?hBV5TTD9SIb7jkdiuOJJmmc5O5Gyu2ZQG0qXpqeKsrL5zbhwxU0RBvFdiMKH?=
 =?us-ascii?Q?mpyXx1V3BdYzPoGN1DJtywMTAiwyx+xaCweJJXxxgYTriNINW8V2cO55zogT?=
 =?us-ascii?Q?qbrPDhOPq65k8PiFL9MvqdKVTwl7UHy/ssRz+MXNgSd4yj1pS6ejQ3WGqZha?=
 =?us-ascii?Q?iPgRipBMcrenLZ//47f50iYfrgU+ynwDVO0ntEYsXGTtaLQOztFymJwpp3O2?=
 =?us-ascii?Q?6lKOgd9fshkNeluXg5Zpy7FjtYi05w+EDvcFUtZS+wh0cHvWdfj2WmUxxhXR?=
 =?us-ascii?Q?0ERl7rD8KlrA7nPxy6bBMhOkY5kDZUf2pV+viWg+z3Ay+QD+fZxQJxOt3uIh?=
 =?us-ascii?Q?Ovit0aKKeOFNgLpFFegf2JFuTq/eUOosMx5I72ygueS7cZ9Hucp2VQNNSUrM?=
 =?us-ascii?Q?RojNjTjY96s54+kcd5F5hTELSOmESs+sCPRhMyXcCwaFP7vAEzyQEiXftVuM?=
 =?us-ascii?Q?8US2vVjoEOBPvT6ZfoZ9+J6Xig+yM4C8E/su3b/BIJNLxQ623UzSEYMXCImo?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mardw8Dz7gR1/+tn8Myh4eiEFB9yD4QFAU+cSI3gGi69T4TvheGiIFEGPSwTPY5izK1VKuqV2/YuyGmZMKGq4TEoFOjgn+FpcVK4jVJFs6yjKvNHTJw9H/ILLOJuD9cA/x5UM6k6Ya5s4FCNgh6FEkMKhRNXC+c+iBhMGRPHdwdwU3fT6dZi/FnfSkPUwmG6CzTsEagSxjzMvgJoZGFFIraVtCJzQstr1/7lFiPDKvHnZWYTcgcOmzvMVBjIYxdlacKRuSWaPIbBX5mQT7GVecKvYDhQhjv8uUmMi3/xy5X5DC5NWpTwwo4zNWyOubkzngJaipJlGnrNcp7TQS3lwuZBg8ONWjaSGuUCuOe02dL15JmPrL1FzsmcUGxPs2knsw5Zat1gMJb515uGcDAhAYfXTAV5qKwhmsGg4p4Yvkc6v8j98ZKbpcszXCDzE75Nx087vOEoRLipJUEC8rQPlJLnq+e2u24ivae3OWZlhF2ebKhIW/+RF0V0k2CWTKQOYfBHKIiOibSw2+lIG/sw85KGKbBWiiZ2XSwDL+9cgREMqqKHXotj7A+oP80siYmvGpT3wM+tW0WeCxaETEOsuyu9L4+aBpEbO7Xv0v5v1AFSMWpVOwuiriGMwo2vc+qzgjsjM8AQ7Ft2z83CwPNQBP1zY9vkbaRGwhfrYE4Ul0DANOnO7E5YPzlqqdAiews0IWeQvnYfkta9irVi23M6l0LdoX7Pw2BLIbyMEowreIyfHmSMnfwPuoaLiE0DKFnOoT7qY2rywnqZmPXbVIRv2g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640f7a4e-1195-465c-2b07-08db9f313595
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:49:50.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO9lHqP6W39PZudhdc/1KGiYs3EucyN3nM7tbirWXDuWMUsa1YyKbO1WnhLPT0D3tppadhPj4LU3LuDCnNVgGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_09,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170132
X-Proofpoint-ORIG-GUID: W9cALqzCSe1Elmjq5kVqhZuRervyv_O8
X-Proofpoint-GUID: W9cALqzCSe1Elmjq5kVqhZuRervyv_O8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch [1] removes kernel support for repairing failures of the
'btrfstune -m|M' command. Instead, the btrfstune command has been enhanced
to help repairing failed FSID changes in the userspace.

  [1]
    [PATCH] btrfs: reject device with CHANGING_FSID_V2

The patch [2] has already updated `test-misc/034-metadata-uuid` to
accommodate testing of btrfs-progs.

  [2]
    [PATCH 16/16] btrfs-progs: test btrfstune -m|M ability to fix
 previous failures

Since after patch [1] btrfs kernel will no longer supports repair of
`btrfstune -m|M` failures, in the kernel, comment out the corresponding
test.

I'd rather have the code comments placed under notrun, as this would allow
the test case to still run with older versions of btrfs-progs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 0b06f1266f57..d0018ac8b01c 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -257,7 +257,7 @@ failure_recovery_kernel() {
 
 failure_recovery() {
 	failure_recovery_progs $@
-	failure_recovery_kernel $@
+#	failure_recovery_kernel $@
 }
 
 reload_btrfs() {
@@ -283,7 +283,7 @@ check_kernel_reloadable() {
 	run_mayfail $SUDO_HELPER modprobe btrfs || _not_run "loading btrfs module failed"
 }
 
-check_kernel_reloadable
+#check_kernel_reloadable
 
 test_progs
 
-- 
2.31.1

