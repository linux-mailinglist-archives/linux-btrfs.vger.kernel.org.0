Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3AB7D697B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjJYKuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 06:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYKun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 06:50:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDF9BB;
        Wed, 25 Oct 2023 03:50:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PAfJS2019987;
        Wed, 25 Oct 2023 10:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vUXWP03XJHTTJ1GIm3n/RjckZfSNqkFPGnEmezSxBWA=;
 b=pObOmYt251wL2plQELGkUnkzIWAIBalZxf7G30UMqV78TbrsOAWdHGLQ+DbH+IZ6MzVh
 KTrDQTxeu8Mf07/ykntiZaryHbDCmGttRnSmedZ5NBl8f7m9fkjt4dsQVhKs3PF99gPy
 peNQYl9DvEL/G7AxGEn7oE7nyPYx2rUJSlRG1zJVdF9lpHXzwwaQxDgBkJOhNA+Ncrjb
 71gCaxYV/DJ9wHOCNi9PvcXg4v57LcAAb+uLxpPnngwbbCdsWpa+xd8nO/SYUP6WaMqm
 p+ivXjjerT9tGlH9UPcyuw6649GlFcYmSKd3i4+8dna1nu2gpcRhcYAPAHwuSgEeXHP5 /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tff0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 10:50:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39P9A5xa001528;
        Wed, 25 Oct 2023 10:50:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53cymff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 10:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqexDQD4RHE2lxsYzbgl3kRZgzTafd2NhB+CVySWodc3HqfQdvCo4KxJj9bCwObYm5XhjM8laPoFa5I2Y3o14X3vK5jqhXoCzcetLtwRV4/BqEKjAhTrWyzsYvzCheOfKfB5pCmBWebbckiyBJXUrK4g8ByQUUsf4xXLMz1BXxI96oljB6lEJCKlQxq/z8fXjWB/jOsJDWlneXp+ahckh/7x41XlRvj75+EO+iQSBHhtoSRvSaOH8e/f0TwROY2ODWFz5Xbqj/7Fue6Jt7uqvOTHghYRmeDHJ7VQO//GGPfvvV2kEcVQkS+O3RoIPkPJPE+QY9yAOKSAlLran354WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUXWP03XJHTTJ1GIm3n/RjckZfSNqkFPGnEmezSxBWA=;
 b=imOsr/Ll3+vhdll+Zz3QjsalND1YOjTMsog7dTasHYciU9fE7iWh1suXhQj6U3wSaYPcDuFCn881kmviiKPvQvJPE1aHwMhUAFFpq8Cz002s+AaRZ2OfydjQKdCyr0u0PvHAAIdjnH2hSGr6p/MB+R0Rirg/t5aGW2supzubnFzkCMCokm/cJSVwUzh811YxZa6qtuyymLPzmxaLt78zTBvi3G1cui+r8n8Iqw+PxGIRzMJ7uYMB8eLFLZbQcwgXX0h78fG/iO4SNuDBhXsZWTkNWDOOuTRr8IjUVSsEo6yiOyaTyRmeiOOkyjy2BXnWz4HNWv8ixL0BHHR7KuXe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUXWP03XJHTTJ1GIm3n/RjckZfSNqkFPGnEmezSxBWA=;
 b=b0Qve8viDpHlYJuIzrRqrt76Jzz/LkJYYpMn3qOYxTuO7iwblcNEyCiT3hwOfvf8WuAva+kqZMz08bU7N6ZHpIcLxtUfJX7FAmvDzkw8AVgqLojx482qaU4S/U4UNmS2ubr5KgZGsf/tkHdXlLUkpaJ6CQ9+L7Fvjcmr+VjWye8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 10:50:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 10:50:33 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/219 cloned-device mount capability update
Date:   Wed, 25 Oct 2023 18:49:13 +0800
Message-ID: <39311089b30f9250ff7f7a0aabb70547616a4b3a.1698230869.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 551e5f25-6557-4862-5711-08dbd548367e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQC5JHDk2V6k16Vu+fy054k1UlfEK/SRYq+popaEQ0LORkHpM9c40BTt61zywZxObUyFR1v8/6Uw36XmjzUMGHTjI2Nmgy2Vn3T4MUE/YMc7WQx/r3xgTLbBZj7dtF1+blGvDEs3FxTk/hpL+4KZcmYM0QxV3a8LcgbsiwRvrxBAdhNFf9RNDBFvHmRTOxdgZs5hso75VnXrh7NiREHvplp+9oZv/T82kq593IWVD60N/SAstXtl6YvrZ9FUqJqh6XEdfPCGKtYhTuVofvBDcUTT6lCpWUTI/yh9OOodf/EFsnOscIGb/E5KgzuFo2plaMBuakpWuq5Pq7P5798ioUQvnQwYUaFJfVT3te7j3tvFvRzz4GR711pRdHfqj8SNcZD27YRnzQ3Ac9XmgqdBtmbnpfWCq8P6TXzJyD4znLCYDfsM09iZX1duEWjZhF8exLcNGfRgxk1EXYDcVILtQVIVzhSjxS2la7rbvwCrAZZrGvB6hTySIVhcjNFyNo1LYmhApK8Kr/aF7EWwQaSLp+hQVCOJqr6n8afljoadyA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2616005)(26005)(66476007)(83380400001)(316002)(66946007)(6916009)(6506007)(6512007)(6666004)(66556008)(6486002)(966005)(8936002)(478600001)(38100700002)(44832011)(8676002)(4326008)(41300700001)(2906002)(36756003)(86362001)(5660300002)(450100002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GG0+tpgjgQ8LGsgZCJoky8u9mWv5oo2ielzRniK7SqSzm40obB5Fk9mO6+HL?=
 =?us-ascii?Q?RTRYLfmXDRFGYRFqJGps5X9XsXG/qy5YNlp5Lzp5/UZTyeDFbMoyiKCME3+P?=
 =?us-ascii?Q?R6tSeiqBzeZ/RGHau01R6/phn5DFcrqJSLD2hnKwEXwTrekI9YFLm5cwyrI4?=
 =?us-ascii?Q?4jkOQF3C5mbtJM65zWUiaaajshtH2VlRfUoOwPern17o4YZ5fqxhnywyjni6?=
 =?us-ascii?Q?Ud46Op60GRUgIGmExoZ8mhlK5VfIc6MqCth1ogo13wsRLmVhdQOlTEuv03P6?=
 =?us-ascii?Q?3F8RNIDk6qKiVq73+h/ZjfkdcytnUZFM1ayKNCILzTz15UOrjMCjdGk0kd8z?=
 =?us-ascii?Q?U5dV/prS10cki8HzcIi014DFMTZiKZLlMS9oTe+KyKzATm0EYwnJ8VHbSXdt?=
 =?us-ascii?Q?aUeqc5ohXmgXqhceQCUO+MyvkLJ8jPX+W+IgHQwvM65D+a0iX/KZ4mnLzryM?=
 =?us-ascii?Q?aEhDDnp42AMlhWnrkhZo6O2gTTfcXea8DQaO/OhVUGrmBRk/AnA3J9CVNEAB?=
 =?us-ascii?Q?5NpuI3s5Ku6ge5p+IKXe3fAwnIs0Gn7rEumVgt7BNK+8tDWnkYmKIUP3gVus?=
 =?us-ascii?Q?hOGVuCHCTIFZlJjpuKr/D/Ks4LvXmVSX91Gw81KsP4FGT6Sxau2k+0G9EMoy?=
 =?us-ascii?Q?W0wofOfhb277w0cFFXHjR0HWKUxjDqGGUglAClmzIoEm/aJ8ET7WcOxSLfBd?=
 =?us-ascii?Q?aGkHLCYEy3pzfkOquB1DT6McVpVVeJGtdM4il7eKGgqovFFWxCAgZxsqRoXg?=
 =?us-ascii?Q?CNNV3qkpr/IlVwn73MXQMeMNU279kyQFH19G6PW4LCKKcF5Y/q285mEx5NM6?=
 =?us-ascii?Q?yjCCfkjBE5gsq/Fk4SzHjlRt1cOG5x8S46wR8wS/4qvuG5qUa6Q1nFSGj4UL?=
 =?us-ascii?Q?h+F0VNKt8tXXMuKlpBTUc+AX0q6u9ZgcHL9V79IfHtiKI27J2UF7H+79bdmc?=
 =?us-ascii?Q?J81AFNd7G0K0VCNzUfPDnlXqNAN8YgdEJzyLB7vcuGgulI4HXyjvE3cQdYMk?=
 =?us-ascii?Q?NCVfcmVSr8a5BxPnHtegBwZGTMx0Gj6hOGDpAvpnwfsyto18tcldCzLir0R/?=
 =?us-ascii?Q?HmZxCYjvvKBBjtbXe/+zuxoJWdZ/2DjuGI4p24aOUQQKvu71bsSDKWWhg8aO?=
 =?us-ascii?Q?eTiDsvx3w8Wngy40TaBN/s06JWD5+8Ogp/M+kxNN9koZz8y7S9+4iRudeEps?=
 =?us-ascii?Q?z+IB/Om6RMt7LmfO3e3rf2fuh+UKQNArT9oAzUekRJ4pPrF264DtlbFx4qFP?=
 =?us-ascii?Q?U8cZP1PUlwTQcZgcGVFCPjwqK0cYzTMtMMgjVK/VgSVFPJlCX/vHqiuY6IaT?=
 =?us-ascii?Q?9uH6PYuURXo6nurkSaCZbvmMI/Pb2mb49pgeyRBEZmtzKWumnJlQZ43ru8cO?=
 =?us-ascii?Q?K6/O+MgwFl8W5YO5TZEUbJUbevtyfy/Bm3Band8oUTtI16GzFdq79NA3tJpH?=
 =?us-ascii?Q?G5WFqG2qTeZpY/Lpsk3k0zpPNIbxY6TUKFnB+h6s1ORvAjUkbjqvDM4OQmHi?=
 =?us-ascii?Q?6Nx1w+EnwiFZ5k1KgPqSm+M8SeJwvYSF1zEyOvy+F+3xbWWtDpptx2EEgsIG?=
 =?us-ascii?Q?PHOI/55QzMF2a8eSwnmRbZWiX3KuLbFVMBp7Ki66?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ab5xMF4qUzzJD5acTOQV4QkqL+bS71bHr0iHXoMXPv/7imMHiqW0rY57bYadYxdy2weUCcVVnt/0Q9gyJ03ikOgXoDDgGmAvvAa6FyWoUHHuU4vVQkwjttUYIcqj0wMWFnllH22WdIb0HUCx5j2GfPgh4DQISRiwFnIy+t6vzpwGyySa1uJ9kmoi56u/96tQVKyRnKI9SSa10p2CE8zZCfAPtdFaw4GEIdUet7oCrpLVK65ZcTke73MtpSEvNAQtUyrrpYIurMvEZIIZ3eucmZMcWB6yH+wOtAMV6GvA5PFLi/U06zVIqwfVB9/SCcPM79AT0Q3lJrhFDwuxGGxVon/dZ0GRBg0pvlQDqhXhL4kv0I3S0t+5VdmIVGufxgz6i4LB5NT54WvZAdDN/7qzHGL7Zgrx/jk9rO2Ks01PJWpydJYsmS/Go/dkRQF6BPsFv5Mt50WC/ikiOiu3BtwGToAUQ8QBe22wOuvML5bMn0xjd4samlbN+cmsKFk8OaynUHxdV4B2LT6Uq0xZgFBRjXz8/Sg7dL3BMuaIUPAIKZWElwab3RrxP+xwgXmsStG3XG2f1PceYsBgbtpHe/3t8jCDRb8vRgth4mqJN8fO43Y/zK4a+DA5WF8jMFYhfKfJAr+fptVpsFx2GBF7Ixe11AqZrVlSV87yCHRpLvzTHJjb2AXHqsfTmnlA0ck0QQm7tOfyKV05+nkjXv7IiHzn2VebUUuuxAhntWdpHVt8KH/T+SDhlN1SXQjIR6UNOJgIWyqz7FwaC0fj+3Kgvh3nzg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551e5f25-6557-4862-5711-08dbd548367e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 10:50:33.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aivKDA3wqpZYcmxyIzeYLWSA6mPrH7fr6dp3jq1Jb6LTBmhfYYFYnHqkphnHCj5imn1BVj6HzQfIZ4un/1cbPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250093
X-Proofpoint-ORIG-GUID: g0H98TVB5yveTNJ4nL7bRLGqiacHEe7h
X-Proofpoint-GUID: g0H98TVB5yveTNJ4nL7bRLGqiacHEe7h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case originally checked for failed cloned device mounts, which
is no longer relevant after the commit a5b8a5f9f835 ("btrfs: support
cloned-device mount capability"). So removing the obsolete part.

For older kernels without this commit, the test case still serves its core
purpose.

Additionally, add this test case back to the auto group which reverts the
commit e2e7b549380a ("fstests: btrfs/219: remove it from auto group") since
the previously missing kernel commit 5f58d783fd78 ("btrfs: free device in
btrfs_close_devices for a single device filesystem") has already been
integrated.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310251645.5fe5495a-oliver.sang@intel.com
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/219 | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index b747ce34fcc4..44296c119b0a 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -12,7 +12,7 @@
 #
 
 . ./common/preamble
-_begin_fstest quick volume
+_begin_fstest auto quick volume
 
 # Override the default cleanup function.
 _cleanup()
@@ -79,15 +79,6 @@ _mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
 $UMOUNT_PROG $loop_mnt
 
-# Now we definitely can't mount them at the same time, because we're still tied
-# to the limitation of one fs_devices per fsid.
-_btrfs_forget_or_module_reload
-
-_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
-	_fail "Failed to mount the third time"
-_mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
-	_fail "We were allowed to mount when we should have failed"
-
 _btrfs_rescan_devices
 # success, all done
 echo "Silence is golden"
-- 
2.31.1

