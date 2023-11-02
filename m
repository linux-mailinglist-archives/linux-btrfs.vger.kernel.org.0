Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA237DF132
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjKBLbB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjKBLa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:30:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF29018B;
        Thu,  2 Nov 2023 04:30:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A282pUn026561;
        Thu, 2 Nov 2023 11:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xm3Yg3HgXN8Q/LBtWNttPNnwTxOhUSRdhaM6snDu3tI=;
 b=dzgUm5etQC0tnUlKsL8e+gLVkqc3jzRGUIVN44H7xeeHnZd+wFKkSrFKzOU1SD8WOf/V
 q2sU/6y4Ejs2jxaM3szWgXrLtiY1yw65IOmRMrG+/TGMwAUEhydgikPR3KnmQsMTQOl8
 pol+SszSA9IHJ4x/i1rouEPbsjkni4ny0rKtCcKDbAP0T8128vXGhHDVw+rdhJPQYEKv
 gV/LNM1Md+kexoIoJpV8B368YVFtoygKxE+OzEyl9PRiq1/GGtC//9eD8z7Nh+/mNndw
 14XCSKJ70ivYeq5CcOpaKlCBUkvvgZMlGJ66FYMaXvfGjJi07nMJvc8kzjSRuwF3tpCS Ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuuhcfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:30:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A29n97U020158;
        Thu, 2 Nov 2023 11:30:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr8f5p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:30:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR1rG7yoQUbZ0kZ/0mebW0Xk3k+F19SUsCo3G9J43sLwgfjbEehZNCwcQVLvch12bgmRbRETpAUmJSpnNGNWf6phovtOrz7pptwDbRCHpdCyiRJQGPUK+vOmi90mR0nFDpGifcIMmK8wNBdJKC33HXjqecyv9JBYII2Z3spKBDLW+HdFAUx0bRudWXhby66BUQEnW8qLTxXyD2gNNJJCXSlgzJ1Sm8XvJuodX5D0UALJkRVHCLCfm2qAF/94F9NaPbx3PfXIK/+rl5vmLhM3yhem6JazrwsioCgtauqkDMLmx5PYXVl2LAHNe1N9up7DlobX9r5grhIxOSS1BDFMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm3Yg3HgXN8Q/LBtWNttPNnwTxOhUSRdhaM6snDu3tI=;
 b=gcx/KENHgL1YXi4M9M2Axy92beOggMyGN3jrdxe358Eks90KcBq5eLBjVZsaQhBqrfHCiW8ZiXZGQ9Ik+Gjp+uTtUZv6G4X0DjlEM925jJm++wrOQWDvBDd9fv87PeQ1Sfor5KnIGhQTGyeSay5l78FA05OU1iMBPEPM6a4gTpgDl+wH6Kw9AUIbmoUCietwEnbmppLXRKU5AClBFzdM43UZgvOQaIF/WxOvFTUR62/9pSjjnfSjU4kO57c2ocaT7x1XLDbgj9e9C2So3hGuLJ1HMuHt0wWtIJTq6wX5K8HW0qkdZpgyzcJYjpIhW5GNBJBlelEe/O6/h4zbFwOOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm3Yg3HgXN8Q/LBtWNttPNnwTxOhUSRdhaM6snDu3tI=;
 b=rPyCMnqIlUvK2p8/Wzv8JlFopxy3QVSmhs9DQ/VPeEakLBKIOGmeDPaFDLqsh00ry+MH98ckzV7I3XyctZtp7CtsUuMxNPcjsfXV/simyZE21L2KZ02SyQkP8DUXRMOUw3GhzN+xOWlVJdafkDukws9YCpzAtIeQXUefuLEOCO4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 11:30:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 11:30:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org, fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v4 0/5] btrfs/219 cloned-device mount capability update
Date:   Thu,  2 Nov 2023 19:28:17 +0800
Message-ID: <cover.1698712764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <CAL3q7H427WL6mF-kc8gcfi6bYNHkZH4vyvUzHZR_nsgxK3_+CQ@mail.gmail.com>
References: <CAL3q7H427WL6mF-kc8gcfi6bYNHkZH4vyvUzHZR_nsgxK3_+CQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: f029cfa8-3b4a-4549-a89e-08dbdb972aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwLouaZ8iB0aZFXZUx4NAmduCDSZEJzNn9lfDjnvNWB+GlzbV+tUYXwBlhtFUCvUjPumd7p8emhmJc81uZs6cVovd64E38EmiaSh9nZxdl9BZgttHl2WphKAvgW5cIqu/pvSEsJrMbCq1W2IyXaov4Vs863q+EeuWTofLPDPXSRQ8/zfwaM4J4DpuvHEd0b6khzC6qpc7vJTkZhdO7deO5AmED0BCH8pByoMW3giJDcvpGUrfc9AiPs0rmOwcpb+HyeE605z1gHLJ3hsgo0kyd3P2P/iC4q4DIwOuGEyLCQJ54CHhNDhXmYMPEHnsP39LsvfduusHzYI/nPYHTppzxvWxekewcscJ5OooqdAVeYqED0m2qTBdNCXIeoVk+1nvX32lMixbvXJBAb0Lm1fmyoJak/YK7zsRXMNATH7jiU5GIx+b1OuvVQ3h6mjgv6EVglj9Yb15++MffZnPGw02ccV6YJN+eKh7iqhGWOtq1iC2G64Z+qJoB1Czt6Wpd5irHEazsCoJRHRXEpC9DMG1Xb26LyT7Pb1EWxdbST4p2qouNAbsFpto8BWQfrqRa5D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(36756003)(86362001)(2616005)(15650500001)(478600001)(2906002)(316002)(41300700001)(44832011)(8676002)(4326008)(6666004)(6512007)(8936002)(6506007)(83380400001)(26005)(6486002)(5660300002)(66946007)(66476007)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rWOQNttPwHN2dOkjVBze4+tHCTwDq41kzJlCIBdQQ9ODwO16O4T2J23jBIFX?=
 =?us-ascii?Q?sfr1GfYvOF0+QFVQL40OUVTKHHiG4GfA1WlmSPYIkkWYHc28/SA6khYwtzUL?=
 =?us-ascii?Q?8g9y8TXYcuIiqZ/FFwOKXDA4W6XdG6L9BcN0iQoPm2NlP8nJaxLUimH+oGUv?=
 =?us-ascii?Q?wlpctwBiKckI313WYZY0UypC3UaKlnHVJDyzcCpdDzq53JlNX153aDElcRjO?=
 =?us-ascii?Q?yEORB+TNj6/ya9PJYeG9MOOpGk8ModhGsA2J1zIIUDzNlppSNE7rRcZw6iEj?=
 =?us-ascii?Q?Fmghtfx1Nee2Sk/Lm5a4WzoYA5iH/WlMRcbmp3fyq1YEx/tJXwN/5wlPPF+x?=
 =?us-ascii?Q?d8FEwIIH5/vGfN0PYXU9u71YPQwJoIk+hLDS9qVy+G5lVLcQq8Oo4aI+2PPI?=
 =?us-ascii?Q?EjnF+Ry46KZXvOyYNCuesw3xdGV/3B1RSiHPDxb9UEzvs6PDr5V845GdpcvP?=
 =?us-ascii?Q?HgbLtNbjRdvYkz+J3CXb4iCe6yjyX7+0tthQnznxEtvdEJj/nVXH78q15QxB?=
 =?us-ascii?Q?jKmmfYJHtn40AOiqwaFqmHFUsRYq/0hXu+065x4UCzmenuav160xyhbpyHAJ?=
 =?us-ascii?Q?er5GHm9uOafOXs6+XHrAyndVJ8pTzAx6/N7MvWHyIhd3fJJm9kvf36diuiwB?=
 =?us-ascii?Q?FIEQ2cNYJTC3Lc5p0HzvT0DXS7wFBQPGL9j7UVtJmYuW29qUKVWn2owN9aqg?=
 =?us-ascii?Q?mLr67EZtwwWZs2fGjP4+WUQQxztlx+CAuuBUO3vPl5aWXMjzmqj+4NhDsBqX?=
 =?us-ascii?Q?qhT1WQoEkZzdw+jeQ9GDI8HTQHU+Xtt4YxiwqwmTsgkw20cyElmIDMux/XqK?=
 =?us-ascii?Q?hZW+c4Cgt5atTPGGdLbrCWtT5j0WZGsrFjKLPZFC12UAGbC47UBe8u1YJfpx?=
 =?us-ascii?Q?0ES2GDT33V1KgjTzLWY2aXebqErfUC87IVPX/KzxOG2IZ9Et218irSf70cOm?=
 =?us-ascii?Q?i71z1QzZdjpPeKiWnY7mdCw9shVu7HrISFVh51lc3qiU99oi9VjWOki8UWO4?=
 =?us-ascii?Q?5xn4oQSlKl5Tz3QjPvYZTATpmPaaA9j5j6E64jJdJk0Qnfg2wBE1jRf5mJTc?=
 =?us-ascii?Q?QiOSG5ByS3UngjNFvXnfE7tlsQKTFrqeo87eFYK1yaz7W5uE5UkxqIcMZmZJ?=
 =?us-ascii?Q?spQA1G6o25AfaUod2Qjj5E1494yjW5K4eUb1l2JTJ9vDyBzK3ytrZzlsHaMl?=
 =?us-ascii?Q?9hDKZdDL56SwsQ2oaBdXsNLVwyvXt+ca54jdWMmJaZk2hn41yY5m9skaCMOg?=
 =?us-ascii?Q?mx89+qjARPwq9Bu5REpgGgoxukfc74DqVVIcSkSof2/bRCNOWSdNHKee5/J7?=
 =?us-ascii?Q?pCAgOmSqoBKcuAl2mk3Uv/OZM3N4RS7oiBv1xqv9zzdYJoUNO51pPvms7Jz+?=
 =?us-ascii?Q?VR4BIZIaJ6gSW+I1hb45TmMMi7IwOQeo7bGPDsiB6nekahfGqc01vpGpQabx?=
 =?us-ascii?Q?8scu16zMI5bxcq4zc4oRDJx0jgp6TEE7UZAX06Oj8OPeRFQtckpvhHD0MgiO?=
 =?us-ascii?Q?jzNyRJ8IqD1OlbMdPfcDNnIOxSnNdn6ZfDsfiDZwnFnNI6/LUOG8KsgaMOgv?=
 =?us-ascii?Q?qXBHnP07QExtY5mpzxiJsWEh1ktteWirUedPNP8E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T8TJ6Tu7HJvU+11wDUn8GRHHtZnXYL8vE8R5PCYB9R0f++/STixz5+Xe6RPvNoGYyDWcE/zAQH1yp5wLO9rbCHKkf14XkgE82AgqqXTI4SqkaIhytIzbqzgFxSwP9h/bqIbdmCU9WijlTOcqVZlUorftmVJJ8i6cJL+dOyag2o5DXAkYUuIL4z2DThk3en6mWhhqGVdko1HP3CXspqTfz6P8gurpRitpn8pyp8tRBqQ6Cvu9oiL9qQ7jf+xAzISZGV3YCC4STxNIs32fUTZvQBqp3DqSDzAGn5yks/0hKCCHLkIyPK+ygMhFry8LFSk37G3tKSPYNBwxfvhoMTq66rw3d9elLt+4W2BeRlreBVHSZDXSGnrAM6+P8hahn6bk7sp2toHP0rh1nKkJ3ZxWUT4aOIIOWlRahD91RbrSpbwOsW9HevOsXKEneTi0ZUXaGbtBC6uWLqgcJPwWPqXtlFY9lXByYP20Eiz7p1ClIAiUN1mFb76pESTwGmCHaPGR7tJIkFgH71YAI/AFRKRmPjkMICSlB3txQ9iytygNoaUiPW8xUuIvppLkBrmsl28JmAF2Bov2VNIPPkuJF8XWI2fAG1B82PY3x4UNcgS3//BWESo/SuwrzlQmbrjWC1JpC9OcgtMXBqGdyyoyMxXaDXIbes0v2qwfijyzzMYUtdoDS3pQxkGz9ggYTw2K9MLnE8nGOEcVQCfPFMNSNO01if3TUTir1cxImQzJAoC7Tl4AQ97jjzqZWypwcSvbsLOryGj/XFXXGHnSY5TtnJCV+MDD53yJzCkXyW3uPqDB1n/CGtYkegPth0sFdrn0r86L
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f029cfa8-3b4a-4549-a89e-08dbdb972aeb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:30:51.2490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erIjAu2xLw4bZ7lB8w++umOQSJpdKKG3bHLVJqXIbws6Rxf8Rs30cRZK1T3n8pvYx4HJ+r9I31n3L2rORieW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=977 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020092
X-Proofpoint-GUID: I9YcgoCBkXSkNgez9jkZ1AT4PA0PqWfb
X-Proofpoint-ORIG-GUID: I9YcgoCBkXSkNgez9jkZ1AT4PA0PqWfb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v4:
Removed a patch:
  [PATCH 2/6 v3] common/rc: _destroy_loop_device confirm arg1 is set
Fixed patch 4/6 in v3. (Ref to the patch 3/5 in v4).
Added received RB.

v3:
Split changes into smaller discrete patches.
Add a helper function to check if the temp-fsid is supported.
Check for the second failure only when the temp-fsid is not supported.

v2:
Patch 1/2 has been added, which performs the cleanup of the local
variables and the _clean_up() function. Patch 2/2 in v2 restores
the code where it tests clone-device that it does not mount if the
temp-fsid feature is not present in the kernel.

Fixes btrfs/219 bug when temp-fsid is supported in the kernel.

Anand Jain (5):
  common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
  common/btrfs: add helper _has_btrfs_sysfs_feature_attr
  btrfs/219: fix _cleanup() to successful release the loop-device
  btrfs/219: cloned-device mount capability update
  btrfs/219: add to the auto group

 common/btrfs    | 12 ++++++++
 common/rc       |  5 +++-
 tests/btrfs/219 | 74 ++++++++++++++++++++++++++++---------------------
 3 files changed, 59 insertions(+), 32 deletions(-)

-- 
2.31.1

