Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE67366AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjFTIuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjFTIun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:50:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6F31716
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:50:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JNTcF4023159
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FAdPqIF1/18siqv3hxLoc0LS3+ds+XRagYcap9sD5AE=;
 b=cBME+/64wUtCd+Ei/gDcHPZi5mhzoyzC/uWBHCgAMphy9ACXU0LSFirxXN/G/w4/8kC/
 dvYtQA1tslzrOosKxLF8WSmcyEPx+g0+57iskJI9jO8KCzbY0NZSFVqP0F7HmvefR5bP
 ddb6t7+j+nXeaYDtYpTTwN0MAojbl0dDs6tEO4r8uvQ/EActnoQvO4qX7R3HWjFiMI0R
 n+XX6QZbzjO4wT65iOEq+kAyjr0LSuOqczrU7eC7UIgO0Qo+ozwUaT7AFeop4PVeySSP
 bhE48LqKQ/wkA0q1AOp06qvUCSJSAuWM/VOH3bFoAICp6363W4kkdckooVNw3pJ2yaPM IA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etm5nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8VSge007128
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w14ndre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k28H9VqKBqxZ8h2PXyjmONnV5fVhZX2VqWCgczv1CDcxdmLOH8KCZV0ic4hgrO9COaY5eb1HOZImRRYWorUBHDvvIyN4aFZyqdDjVMKUZg8+CBoVp8umQUnmNI6HVvcvRPtK+IUt+X9g7oI25wWn/lJ6g96jSsWv9O65y8QOwdrUPgQlqTbCnXqY8kiIO3GNbMbyx3V3q2qsZbBVJWnRdamJOcLs4EhXn07VT72/b2uKuMKuEye/gaz7R+JSH3vBHjIqFS0RMF2m9TNxY1dToEm7bMu9h3NwYSiVe6/be1mCXJ0lv9dS4EJQHC7ASmOr2EAJbI3SpSfL7r7cj9Zesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAdPqIF1/18siqv3hxLoc0LS3+ds+XRagYcap9sD5AE=;
 b=m0q8dSA6eCCNrAC0/phT9bIRRrHpn7r/icQSQoG8xJUwgVBWSA28gj1XpwxFbdFQJEvzdwxO0zB16PMsbJn6KWIgdc0Vb8C/pc8k75pKP5GQNRX6SrIcMgx569QLVeEuRl1PIngrWxpH+zmFOMWvpHQ7FlME6uakDPNVhnSzD/rXUfKR8SxAXVWK8qU85ubYmuZBAy/qVM1+dUVnWk90edmEA+huf3a5miBtXqoF4AYtHcAlEBAMXbphSQvoDY2UO4pznX9doGL+6cr+H1llkJi9kkQh6OSrEhW16CLqYF/sXdi/nfQbsaquAYVDmuSaJkW+sVd5jjeU8VUfRhR+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAdPqIF1/18siqv3hxLoc0LS3+ds+XRagYcap9sD5AE=;
 b=Sm/kq8+wQzD0MhZLUPpfSkkct/yEsIdTQT+DKAcjKj2JmEidaHHTlQAc1LyX1xMTDXl3u2Mu33U8yVU0D3PxtiH71i26YZpaEFMVVpy2Gbxlf51fZphhaSNni53UDAAbtwWRiyfrw899Mnx6zyvGNCW/zn3SxSWyDHI8vkg7AxU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 08:50:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:50:32 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/6] btrfs-progs: tests: misc/057-btrfstune-free-space-tree check for btrfs acl support
Date:   Tue, 20 Jun 2023 16:49:58 +0800
Message-Id: <4884e218dfb91cd1290d42ec030bd8c1af54bdcb.1687242517.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687242517.git.anand.jain@oracle.com>
References: <cover.1687242517.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: ba16408a-3728-427b-06e0-08db716b67ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l392nk8Hib8zdvRfrKbu6x6+Wz0PbZ6zezaGXpFNkvUHAZ91n4NkCR9DILH63ehBONKrgVpfQ7PexRZ5R95JEtylWro9EnV4WhIrtJMYL4EG6ez9YJSS2kCQzsm/3pnWyHQ1SohAaIqy//iYOdx+ssod/ZeXpxlOMKRA3xF/XBFW3g2BB0IBg5/rQ+zcX9mbPsfSLdVgjFfLRkHXS/9lxIrkZz90oAgOAjCGpZHF++5a9TQFxFnbVnRHZp9jf/jDFqU/egzZZg5PxUtxFDH7BHtWhkXXNVAUKs9WmFzyfPptQK+ks3qg1FwOAZylhVN5nSTuFHrDzJeBE+GNypw6o+vaHPf79y5gMIDeHJFul2QJYZdFc9gIKRTEkdPBH1SNGIW5zRFSQafJiNV7ydMC8lZew7ETXxwJrkXn5+SIi8pDdjxic+TrGWkyhxEl6n+YxDrPo8UeaKvy+ccKR9at48VipjZPqXMPTRwzxPiAwdQjvv3J6sItSRADzzk7hLHB2LE3Uk8wjT/a1fCZbSTcE7uDiur1Tr+K+Rgn208qcSb0VZ/51pKMQ4YdqQwjUSlv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(186003)(6512007)(6506007)(26005)(83380400001)(36756003)(2616005)(86362001)(38100700002)(107886003)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OuGfvucjSIZnn4EUjgNe9A4ji4Dc4mls1LPNt2uBHm/kxP4KHqCP6O2pOVMn?=
 =?us-ascii?Q?7d3kcSn6tWwhFbSHbnXubwfTSQyjKT2ULNLOasJbZ0YhWu1+nadHOC/n3FlQ?=
 =?us-ascii?Q?EGgO4ZtpgIpZSEf5VqX9zk/kNK3pTZXo6zoMWiWxfrvHblS0ApOWFzT4n/8O?=
 =?us-ascii?Q?HPl/ODlbP/vXQI13E8gcvKe52zK51S8e9pMJnuh0iJptIGE6Rgl6+EqoCJZs?=
 =?us-ascii?Q?VAf84SwaDf0sclDKQ89GHF98Eg3C6CNZGB93ks0rFGpk/qdEVLfB2GjiDc/Y?=
 =?us-ascii?Q?osc/x1uPztrrA38xAJJrcfIP5dKrSjUBnj5gNbpPErf1hzYYPPBpJ0SToYPy?=
 =?us-ascii?Q?+3YGD0Ti8b+Eh3gxtD4lnSpAfA3mFImTtjAd0gM9b3G6X/uXdkOIf+/2CACj?=
 =?us-ascii?Q?KrF1ic8cRrB29sSKLNEoFth3XcAABGM1m6ybCjp2BshIhm1sd7lbkmOBLt/A?=
 =?us-ascii?Q?T0kJZUfidS8vLRkPHpy2uxgIWLWJDU47CU2WULvTqLXRRu/FbbGULAFckfqi?=
 =?us-ascii?Q?9h+gAHUA5xlIu3wzLYQ/sxH6i3dFM3Kc6IdK7jrTPUXgHjpfIuavcZSVs/0O?=
 =?us-ascii?Q?U6tj4FA9CtOQjjdMmSd6fdAsGWuZ8x0wAaNj7zlqXj7Llw97fC+/OlKDsx3R?=
 =?us-ascii?Q?sc2wix7ATahu+Wv8NmeC3FGHgI5nhgy9ql7Qt7v+NPz4HdnSiQsswBgGAwxE?=
 =?us-ascii?Q?sIU4iuoS154wE5n74S5QwWgmEBsaYqb9UyY1QgWIwY8b5sV/yx3KJsjoUdYm?=
 =?us-ascii?Q?fgeRz76z1xi6xf3X4Wi/pUgr7r4pKgR2rkZ6O5lxJx9c2IfsOOhs2SFLFmgB?=
 =?us-ascii?Q?w8TY5NYc2s9mqVLk1az1bUfwiU2tFS2tN8g3GZiVa93yFlNvi25I1k2NVeGw?=
 =?us-ascii?Q?SuyIprnLkFeDeTPp3wDOI3QmuiuJBUfTvNjnul4uoAmDQOvQUws1+8l8b2/U?=
 =?us-ascii?Q?bdJwRGEsTrMDKiMRotfBiNnJFKj+/0eHqzc4HM7dA3JGtUmf6Z75nHnk5nV/?=
 =?us-ascii?Q?m0/tPO6CULHAPLePe8u/A+y5RZ2Ow6ZwMuqjQStDxzxvpeGh/iqzBjJ4X+08?=
 =?us-ascii?Q?6WhVPP9ztLEZHm3KqXnOLJW6jiuXIsJ3u6r4q0WZeizR3w2euEYH4b/CmmN7?=
 =?us-ascii?Q?4G4DgTULGK4sbA5VbQwrBg0Mj58yNbHXMXxehy+gKrKXqf1W9H55Tm2quwU3?=
 =?us-ascii?Q?wYLQj77JxcjRBA8LtvprRbGGazuTbSEem51CzSGrahn8ueh527M5M4Yly76P?=
 =?us-ascii?Q?LAGIdJ4o4Usxo/ovlxKalkh0Umn81dvzjsx9VFLhPWRnkf/SDqUcfUjmrf/c?=
 =?us-ascii?Q?9K8scdznSRy8WOp2Flfeh1hGVwHRnDOYCNfwUgNloGOBaWhOlYFYTRAvZ2JU?=
 =?us-ascii?Q?3IileRIFQ7KM7Y+3GtCEnbWb1BVWRXGShjwxm79R/TUC+cUJf1B3iFS+SEMG?=
 =?us-ascii?Q?GC9KwRT65YB1QWZCXXpnLZKLWx+hms0gUmEnEhBEXkOtHQqwQD5rLbkg06pQ?=
 =?us-ascii?Q?RuYFsqH9ulEZwpcWdUGFGp5RM9A58RIptKFjKxtjjlaW4g3qTJYZnUf16pye?=
 =?us-ascii?Q?wvRqrZd+bv0XWLKBmPZL5ZxmMBj0XePwjjQjj6ws?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1EGtSdtBRNGVyiotB2YINAOhAczLxyU/Hpt5CcI5trcp7D2UEBTfxhz2Z3ABxWzeK0BHTgacOtQjseoddCsvQZPAQNLzq107ng+gTU1CtktcGqnkEgR1qcPr/1/2u7+kcSTguf+vX3arQ9Kv9InNjLgbiOyPrN1FcFZChzbr6MyN6HkLLw3r2PttI0Q3wBoaS5IPIXQZcqXH35bMJq975NdMyHIjZL7kRQu1JdXLiXwhwR3RyX5j9f2k3KEqep9sGtlnGy95L57YehibjryAEv4u4P7YZb7LhiMwAc3hvSIVuYxQMrr/u+0+eCYwlfkTPn8RQvpXcE9ci4ib3KTPM+AcwDvoT5E6cYRnoP15IyW7PRYGJ9nXSfRdwC0fPVdqAm2uhk8YyaMX5CKJkLX3l2+7AYUk6nvxbAyXuv4eCI6mq5pNEOxBYe0aPxiTjB+33gRa2AOCaurwmGbN5JpKF26pntBpdd5GdPKcmIT2HeFrKkgJPdVvDF9HNHr3vdpQ/OuHKJ3eeq/+TffvPET3K4JbF26A2WayM1iq4GJcOq28L+eBzOyX3QNKfE1q61MEA9YQNpkRCyhvR+ftVS0jw/83Q7KgOJOl/5vVq5w4Pp9MrNNGaoaDR6fDIKbyl42rmNBFpV9UXRN+KXaE6hgQsUGBJiNx26hzXabE1sbqu8zhdLs3W30cS51xjDJWKzGJGgJAmpnK32rU0xT5eiKzg4lXE5C97vlESrASqMhWZXtiCXxmxt/wJ9F607M1xfNNbtaW/HMQQ32+Et5+kcBx4w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba16408a-3728-427b-06e0-08db716b67ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:50:32.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/eDdFiMTLZzeCQINzNvNN3knSKjGWlLWBEAIkhPvLEfh5BaFxoPGt19cCc1qzNBrQdWp9mxGCnbdpq9UXLhyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200078
X-Proofpoint-GUID: tWbMOGXl9_B0MVbBmefqNcdG76HtoT2k
X-Proofpoint-ORIG-GUID: tWbMOGXl9_B0MVbBmefqNcdG76HtoT2k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix failure due to no acl support in btrfs.

  $ make test
    ::
    [TEST/misc]   057-btrfstune-free-space-tree
    failed: setfacl -m u:root:x /Volumes/ws/btrfs-progs/tests/mnt/acls/acls.1
    test failed for case 057-btrfstune-free-space-tree
    make: *** [Makefile:493: test-misc] Error 1

Instead, use check_prereq_btrfsacl() to call _not_run().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/misc-tests/057-btrfstune-free-space-tree/test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
index 93ff4307fca9..d91fe2588c93 100755
--- a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
+++ b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
@@ -10,6 +10,7 @@ check_prereq btrfs
 
 setup_root_helper
 prepare_test_dev
+check_prereq_btrfsacl
 
 run_check_mkfs_test_dev -O ^free-space-tree
 run_check_mount_test_dev
-- 
2.31.1

