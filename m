Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2246B697798
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 08:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjBOHvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 02:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjBOHvi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 02:51:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A8D6E99;
        Tue, 14 Feb 2023 23:51:36 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EL3siH023399;
        Wed, 15 Feb 2023 07:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=cyESsQqacnIRn81wOveekyQajhiC2FgdFVbr/h/5c+o=;
 b=k4n1djWLHzBMtvSXI87/JLTlelwB4LmuB4xxrGqAI3Blhm0jd51TA5QKpG21YFQPpLWF
 OHMSVHWaO2TjAtJHn4Fx332vS9bzjaUpkp07G8ZCYt2N1HzwIxOsOLo2XGQm4ieUdrRh
 zI8/NQpQIIGyl7Dgfx5C8YatujrA6mR4zbzet7g20ivaxnXs6IIiSMUFzmXpIj4n1C92
 fkw8A3cPuT8PKOfNJym48hTUIY4kTMFp9jiK1uBTB6mDn8tAAy1M/BfNxkEVVMHuHrUc
 tS3qwQHv2XZnbiG6MLrX85ZY6PYRXdpuQRDBdHv2P/icorpvlHVJUO7FJYJ+D2EBMz+F 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32cfhfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 07:51:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31F67fLv013543;
        Wed, 15 Feb 2023 07:51:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f6f72n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 07:51:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQVARo20QBcx+THXxk5hrWlZrv0uRNdEIfZuQsSMt0pw0s2E8jkDoAgv6SR8EgIDyAqINFU6TK0C8idA0Rn6zjq1BcRuAcdYo/A3krclTX7kNlMGULeHGOp5GcqcmrzcmluYqJgZ8URnPGnYM9HYT1pxaOM31TsGePUpS9o7PvkETM8MihPnE8AChIgclmifO8zYfvze0tbhNpzLz/gXbFpPkbwiCplzGhzbGzzdX5a+Vcf7d153Hrp47i0SYqqkT7BL2FCIcwHJ87SnfGGr+ZKsSk28noBlmCTnk4vFIOnb9aOFbrFgae7cJTPJ/0X2+PVHLJ18KeuCcl9delWuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyESsQqacnIRn81wOveekyQajhiC2FgdFVbr/h/5c+o=;
 b=YDyKpj1YOJ7NxmrgSbFOT7+0uxHYKPt5oI+Uecu7ZoZ29AlpHLAJAtTvgHw537FInl4RYKYnFQUUvYV3oPF0oAkzb3L6tyNx6PFLopmlmrykVpDNLefVttGwd1eako5k58WostmtgSHuasTpAIFClxw93Z+rZxhcfyJXdTn/sIMIolPStCfqSF66KNdlu6CBw3FdOs0YOV86EdSiiZ08rAQO5LptEpphsQJQicqIPthTvqxCjjw3a/5XDS4bj5JXIpn+34zAVIPIWAXLGW0Ecxj5CdMAuRLPJgpdQJnSe4A5tfDQ7AjnDtC2CIejCCM0Oj0UZCOxXbaEa+UYHlEfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyESsQqacnIRn81wOveekyQajhiC2FgdFVbr/h/5c+o=;
 b=hbYGkc6u8z/bgqVhHDOXQweAQb2p+Cle2bkJtQOwn4Ih60bd2QPSjzThNHJmbVPesX5AwDy79Zh0InxyxUvf3oNDgHg7G9ZhIS20gvdZ9T8coZFSJUh3WpBH6sKiTrD1KxEr93j8GxMPTKSWTb1QYHXzuLqWPLxpuk6DAGDlueY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4995.namprd10.prod.outlook.com (2603:10b6:208:333::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 07:51:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6111.012; Wed, 15 Feb 2023
 07:51:31 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v3] fstests: btrfs/185, 198 and 219 add _fixed_by_kernel_commit
Date:   Wed, 15 Feb 2023 15:51:22 +0800
Message-Id: <b0375c439b0f4d4da5de569d19bcb53bc2a0c66a.1676446803.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676034764.git.anand.jain@oracle.com>
References: <cover.1676034764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ce5abb-1af5-4c14-55ed-08db0f29736e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifhNgnbNUy5kGq6+JVEUGHsdDy0jSLE1oKC6GJVRBXFo/C/CHcFGCTxiSAotqTjlMUBKF0uo2lu5Aw3Bkeb0/0AdmKXglFI+8KBz5PcP9SG8ybQzPKY/pp8qzRrGDt31tl5EqsaaCfreC1lNXaRauemM+1k4R8o/Q1ln10KHe/Yh29pJ7AOBtCbTdgiTcg4zGeSDHWEOCkAF0xHih4xnHShOjljvDl7MdZ/KLgAnpia/fWWPfaKaRyIEZyr1cJ3xYJaakkT/A9SIsgVrSg5x9YDT+ufyPkOhAISdcpCEXZNvON7WPmCQ0SkaalrT6yj0D3QTpIe9buq5tPXJZSuyD/kQGJTPWVOM5JhPXd9AtiHBgYOA5FEH7uhMysQMpNlRsNkfYVzBveBmnscXxEjEALJe8+Ugbi94W9EDJaPxJMRclx7+t/ORbN9J3DR968fRT1Y20PVFxjSOWZanwuvlDfFTg5k6P9HTBJuAGBPqkTY/Cxr7We94usfzwf1LN/LihaG3g0k1ViICcZ9p9QRXRORD1cgW6OK4rgkocnDEILfdcRL3ma5EHL11APc03etmmtknUWTsfPEM+7sZtTGv068AW2PDz7Dj++8T/isYqdy9/it24CXIrT7C8m8pvvgfpX0UitVIEiG0rfn5UZMefQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199018)(8936002)(41300700001)(5660300002)(44832011)(86362001)(316002)(36756003)(478600001)(6486002)(38100700002)(83380400001)(26005)(6506007)(6666004)(6512007)(186003)(6916009)(4326008)(2906002)(8676002)(66476007)(66556008)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZQaDYuvnIJjPGpsJ8gOmB/mszrefDbziBYTKUYtO7qwrp5uwafF5w1S+X8B?=
 =?us-ascii?Q?ZzVkZg+rb4dycVxNBNGm3uKJlg/UfgzaNY2/T9J4zKOZlSKInWES/yAsM+hR?=
 =?us-ascii?Q?WKQqip/y1mhh3g9lNERmct7MV7SIqPcG2t1cDCmJ6MKXGimWBkpuFRaGQ3tG?=
 =?us-ascii?Q?gDg/PyvkWS0yhbHY2SSm8K1CoDpYwqzKZjcHDWvGzMgpMGnNrDjx/wnhC0UA?=
 =?us-ascii?Q?OdVNnPtWPOh3NyVj8b9IFw8qA3Cyq60N9phzX6nU2rMDEM9ZCqPM7rTuD5wn?=
 =?us-ascii?Q?hM1tRvAM2eAMainZJXb7//+Awv+Hx82cVskAFgIfP5k/zS7A9K0DoNpAUrpv?=
 =?us-ascii?Q?kIdrAbScwg2u4BFxb93Wru6HKRLEiqFfPCV2b4+Tq9jV/8WxrB7Q/t6Io5x/?=
 =?us-ascii?Q?bBFBQ3qEfdoZ3PP1ZKKkTrAFwSQFU22bHBo6e9DdHxtlTDhKXTbrkZf0BZqw?=
 =?us-ascii?Q?RG3+m4K+AxayssloshkWmGwb3JA8+3nVEkPBfDA4hMJpDjnrfS0L5UgR7cv7?=
 =?us-ascii?Q?BEsEySvH8UusZ8nEtBKvBzicX016J2/3YsZGsok9JpLoCLBa2ck743f38RCl?=
 =?us-ascii?Q?sJnd0v4v/rYamdIYLLj23AYS+nL/dxASIT7LbGymhlpb5nGBZRS3BESFwy14?=
 =?us-ascii?Q?R5aPV3j2RS1EYOLlMXRMxoAUXdZXSMmx8EM4SADtogNoZkOcNFX15yYjn9ia?=
 =?us-ascii?Q?sFwZ2y0d4qyLwwJFZnAWvfPkZaokzIsCpC+gCV9ColP0XEp+QCachQpq/VWf?=
 =?us-ascii?Q?ne8NnxAIQHlISeXNT7yNLMVhBW1VboAv1pf8HLkato1a2tmbD+iwACaLTSlm?=
 =?us-ascii?Q?FLcVpmqCtqj6rtvcS2hey6nwFnRTQbTPtBtfAr8sdTcOCblcl3pcrdCu9UrT?=
 =?us-ascii?Q?ABt0T04xLROySTkaubwyegoqhDtjk0QyKtkui1AIVcQYK+asbijoJXekhxsI?=
 =?us-ascii?Q?azQA5bov4jejsHtmpfMgXLRJ88IV7KXbwu//rd+omMwPA3jgl5xxYPd5L2ax?=
 =?us-ascii?Q?IiGpLKG33l6GjCh0ULB4gSHpt6tW4DLW92xV833XD+fVL08T9lAVvxtt11nl?=
 =?us-ascii?Q?scVcpPQgHNr+RfSGZmBmuTozfmwce6irgQUkFuCLhwFnSM1bkieKpAVyJtbF?=
 =?us-ascii?Q?hveF/jn/1+oU8CIzx/SKwYWOWCS9ZzUrx+np1ZgdKMHssIP782/7TMBRFgoG?=
 =?us-ascii?Q?7IUan85xqQDmPHrDwZCuW7Z+4PsPVvj4Stueii7y/Wxz8DothOBvX9uMbLu2?=
 =?us-ascii?Q?ht2gGjBUMxoRoweYIqrzN/oO5LKdEguMve8qFJK/iRkAYSpXbsJY+msCHdma?=
 =?us-ascii?Q?3BQKQF3PhLuj1FzCXNt6kt6Qkj3DppQkkOQCiP6Hbsp+tqdsK46zwWRfLri0?=
 =?us-ascii?Q?gi5Tep2mNLO3EdDWfWuiAkBb7jBeZAUfd52YLoi5Ugl7R5EcfeLGRkoBwoqD?=
 =?us-ascii?Q?Y5zBl5ouETNZZiN7peQcwOu5+x0RCDE8sPS7R1J1xQbezhWSBgDQTRsB+mrk?=
 =?us-ascii?Q?k7yVNbp3Xf/Jt/72Cq6RfLybFQMRVdzSsQXadpoERYssPmKDDm5sch0iefV6?=
 =?us-ascii?Q?JMMbufa4vhVnl+m1LUBMatojCr49KiTUD1QgTCT4Jeluaya2nLRNvCLCWHMh?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZXKdTTXFAy2nV/4DsYRLgdEVD0po6QCJ/iaEGfBVC6q+He5HeuNu1XC598MQLms3hvcKcycYzDHXIW28e7nCt4mJgYePDYU8j+aDBO5i9ndIR8Is6lglFTYhGa0/l1Xl2IKOI/iz38wsdV9RbGdwTtkMDUykxLBEyhRDHQUG4BWTOq+jUpz8aH3eiC10YlTMYsSOXSs/ucwwmvQT35iFlWdzaPwqecxtntXIGdcXZvkrRkpczcIP1JcDLA9g4VR+0cFyEHmdxfWamRDo4FUvbv/se6obSWu/np0azrn/qZjBLDcLjMJAwcjVsN6L04/YcD1FJI+sr0xOjAtsjYlOOjZhM8snCw7E//r+oVA5/onZuvqz6VIgpFygPj3pUsp1JXeMM7OJYq1kZHpffSvRv/PDxfRVhm1o8XEFt++zyGt9owlJX+v3pdd687YfsUXXDL20+BtO3owRTO/gZV+aRY0klA+47iGTqb+AmlWlfUVN7Nxk0OweIeINOcR3LiBA5RCaYCkCxB8044Uufhb9EzsZ8MRRzBHiwON75XQvd1SaI8Zh0YWm4d3Wtyc93sWNgcBz9+QfUBxsUrHg+JErTc+MtDc90D53n4H7gGfFjY1h1RyqXdbg1zfdUyUBR2Sk9LoS7o8Cto0ns42ZzlU9cUO548Tq5y4dnW9l85xJo27cKpzYNXTec4iOmOCFUkSKD3rMmlpZV0evkZ+HDgLAa9KAx07pop0gBA0l8r+OV4+BNWjaVPSESAA7q6Q/qSMPJulRH1y436Gjw9jWlflAyEwmgqoJw83QnzetBJi2Kys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ce5abb-1af5-4c14-55ed-08db0f29736e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 07:51:31.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4Xfv1ZbE9Fx+AWY1yZ9uw3EiIIO1MyADxO+N4KITIo9Lz4u13Wo7PDiMN1LquJAKMxQCQ67L3NmXkFti3bJow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_04,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150071
X-Proofpoint-GUID: KJOFjzt-SZd-nGZFLiZD_6Mx2EG8vEwG
X-Proofpoint-ORIG-GUID: KJOFjzt-SZd-nGZFLiZD_6Mx2EG8vEwG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recently, these test cases were added to the auto group. To ensure we have
some clues if they fail in older kernels, add "_fixed_by_kernel_commit"
for the fix and update the test summary.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Combine these patches together.
	fstests: btrfs/198, add _fixed_by_kernel_commit
	fstests: btrfs/219, add _fixed_by_kernel_commit
	fstests: btrfs/185, add _fixed_by_kernel_commit
    
v2: btrfs/219: _fixed_by_kernel_commit: Substitute the placeholder with
    the commit id.

 tests/btrfs/185 | 2 ++
 tests/btrfs/198 | 6 +++---
 tests/btrfs/219 | 9 ++++-----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/185 b/tests/btrfs/185
index efb10ac72b79..ba0200617e69 100755
--- a/tests/btrfs/185
+++ b/tests/btrfs/185
@@ -27,6 +27,8 @@ _cleanup()
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
+_fixed_by_kernel_commit a9261d4125c9 \
+	"btrfs: harden agaist duplicate fsid on scanned devices"
 
 device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
 device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index 2b68754ade52..7d23ffcee3c5 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -4,9 +4,7 @@
 #
 # FS QA Test 198
 #
-# Test stale and alien non-btrfs device in the fs devices list.
-#  Bug fixed in:
-#    btrfs: remove identified alien device in open_fs_devices
+# Test outdated and foreign non-btrfs devices in the device listing.
 #
 . ./common/preamble
 _begin_fstest auto quick volume
@@ -22,6 +20,8 @@ _require_scratch
 _require_scratch_dev_pool 4
 # Zoned btrfs only supports SINGLE profile
 _require_non_zoned_device ${SCRATCH_DEV}
+_fixed_by_kernel_commit 96c2e067ed3e3e \
+	"btrfs: skip devices without magic signature when mounting"
 
 workout()
 {
diff --git a/tests/btrfs/219 b/tests/btrfs/219
index d69e6ac918ae..b747ce34fcc4 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -6,11 +6,8 @@
 #
 # Test a variety of stale device usecases.  We cache the device and generation
 # to make sure we do not allow stale devices, which can end up with some wonky
-# behavior for loop back devices.  This was changed with
-#
-#   btrfs: allow single disk devices to mount with older generations
-#
-# But I've added a few other test cases so it's clear what we expect to happen
+# behavior for loop back devices.
+# And, added a few other test cases so it's clear what we expect to happen
 # currently.
 #
 
@@ -42,6 +39,8 @@ _supported_fs btrfs
 _require_test
 _require_loop
 _require_btrfs_forget_or_module_loadable
+_fixed_by_kernel_commit 5f58d783fd78 \
+	"btrfs: free device in btrfs_close_devices for a single device filesystem"
 
 loop_mnt=$TEST_DIR/$seq.mnt
 loop_mnt1=$TEST_DIR/$seq.mnt1
-- 
2.38.1

