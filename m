Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2579623BB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 07:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiKJGWP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 01:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKJGWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 01:22:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B06C2DAB5
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 22:22:12 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA6Cg10011348
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2022-7-12;
 bh=njfkjX7nNqmpRkfucxZbo2rblbNeg8XO5Y8UcwNBDCY=;
 b=zFzvj5DsOELfcVpO0yGHCTg0Ee2/8YYNixrr/m+w+7qWuwmS5gqLkkc1sByP1rZqq9x4
 aoemAcUZ1TvCNNCZajR7aAvIIJHhxvhy4al/GV3pBeS06hOxim6UGZX1Uh5pvTSU8jTr
 YTbgJxa4hXyebf8N49HeDKBKhvDtVxVGJY8Mft6bJ1w4Okqc4Ffre45YWvrtdapYDgvC
 5YkJSGunJrFr2AbQagz8pVSJWQQ08GUqHLNS7af7I51+CLsGOkBXkOWxC9CNT84tnPOb
 hWJOaLZ2u3MvkwvNlSgBQhGPyvirNoOjfvqQ0ySgfrSnjbO9TyHpoQBqb45mxlZdWsDE NQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krutr80mc-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:22:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA5u6va036326
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:06:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcyrbn0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:06:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFeDbQZz/wcvtLqH4MGxemZmxTVhHypCn7weyTiQ8eFYvS4tyolhpgkjKwNf169tNQMy6CvEDUobR3s1UPNgbVs3dXX3uUoGKtOiRcyPwaxCRq03334exfVedsKgg4TDrJSQVC+P75atlzXvY3WYh3GTnR2vTw425WctyyKdbIx4XWQJyks6QvYLDhUaAJEv1JyCZ6heCR4LHtfmA7pdm7OxLZr9JpEbqzIGnHqss0KzTXMNIDx5jTeeRfHhwhhqBmJC6iNVmcA4pq4sgpSlqAHda0BLriEX1s8adFi1FQt3mYHzoptsNVYvvV0vfZoxD1qjUiIIwbLlyg/znMtCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njfkjX7nNqmpRkfucxZbo2rblbNeg8XO5Y8UcwNBDCY=;
 b=UuEcg+fAGeXGzx9IW3VTdA2P5DMOB61nBRvW0Is3U3EV/hn7qyEv49TSD42hdM1kpSIrTeY8YvNcFWcqXAnuVjA/Z17XL/rOg54PVI9VvLZC8HnJcNMt2hSqH01mI76hth9TnKlYTCqOm2zkXHtSwLxkMj573p9PkNR/T1ABoZDho8L3uqcU6HUJhCEFbalb6XL3ocSYmygvTJpSTJbyJhJe/891p7OOZ/SX+pUBg0rid50eyDtQkOQYL8CqV8CcZPzWWvkIsnzdE9rfWVuog3lZ6IR8xbCpkixRqZx8Qw0hbK6gCy3IlIDhpCPyLGU7MXTVYS0O5jtCHdB1lYzu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njfkjX7nNqmpRkfucxZbo2rblbNeg8XO5Y8UcwNBDCY=;
 b=aUOPeY+AZ6J7iAjsLCRxFAXw8vsxwP7+OezLNbeHKfJz7mVL2gBI3idO8fJX4Zxi9BB+vZ1W6nzGdESYVCXTgbUYvd4rGg6dVUg3tBAZOfMtIvwxs56xJNsaiJFcOVJS6XtY4vfpq974Od5sjXFQNIOjLenFnUYT5bq/8po685I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5333.namprd10.prod.outlook.com (2603:10b6:408:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 06:06:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%7]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 06:06:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: drop path before copying rootrefs to userspace
Date:   Thu, 10 Nov 2022 11:36:30 +0530
Message-Id: <77cf63bc66bdccb723c8a6837feb54827cc15432.1668056532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1668056532.git.anand.jain@oracle.com>
References: <cover.1668056532.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e3f22f-e3eb-40b2-c00d-08dac2e1c6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1rpv0uXfEffmt5wNH93KtbhIbaYSx5XbekXybQPet3U04aeoUVNyHXpn/uJ8tq/EwC4YebWaiP9duQEXUV5KGViCxTCxhXq718WSykwKpTfshoqNrK7M5PRW4J+gaCLwERnBxHHDw7mFIoe36Z+hJ0q1+5p1aPBEbgYCe1Lymlua4zioUm/v0rptVplLsGmqyWtukkhIpS2AytVm0DGfQvUulVqDTLAqxZGAy54p6glwRFXhtqOhUzci4fbDc4nd9KgL/NkzibDr5j/TSK1w72heKjgI2REruNs98Pk/ibMHvvI2FjlDKVnRFIWgLIl2wcmrYi7OQvTLA4u79ytARIT3F/pVSLz3RCcIZ4qAwXZsxuiZeHuL4q2YHFAf+NMskSYULikSf5YDBnw8BuD8uY+yhppas3mnZsRkAjjy9ZGrJQAuHaunTYiwyHZEF+pYEv1vqAkngt0VGjA84JhHDbSo1drqcr7EFSymMNtoocjbKJHpZVAqWqW6AfJ5ZCfj0cKpUIluN2oa56TT9NFWNxVrYm1R5jdSigcnpz8BYi03PtpEhsptwULh4EHZHtwdrBukWKSP2RYGubX66a8tEch1kFyNelyFs/5a2FXsQ2yspGcQ+7C6yMZNJsiDKIh3ve3/4Op61cJILd7jbwBhIvyyjbIJ8dT4fbX77LXx2ndc/K6TlLmB1Lq1VYN7JvRguh5UGIQ9sw2C+sSAKZQjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(83380400001)(6666004)(6486002)(44832011)(36756003)(6506007)(4744005)(478600001)(38100700002)(2906002)(86362001)(26005)(2616005)(186003)(6512007)(66556008)(8676002)(66946007)(6916009)(41300700001)(66476007)(8936002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UoaBKZLvoUaZBoyoe06BNUJjvoTFgeZStIrgsIr6ArqGWQejRQ9323dAC98v?=
 =?us-ascii?Q?hs7hiPYOIoQQqngNXHoU4mxX1fzg3ZP4UbWXhM5xZgeTsI9Wt54jmDOb7XMU?=
 =?us-ascii?Q?NqlitbrVn9/Q9LU2E/nnZUfGi35uUK5ZoynfUIyFdnadG/tLp8wDtImBMN3U?=
 =?us-ascii?Q?mgVkqOoiczZWW1tXgby045OY4DvemQxDv+OEn153h98gmVkB+YtJn5psHLuR?=
 =?us-ascii?Q?RoI5s+WHAh+1qtjodMChJq6yMbZ4fCezNg3Bd93lkOkV+2HEjoG+Hkyk5DiM?=
 =?us-ascii?Q?mvwcBx4s+zzFYv2WRNTSIoKW4gW5z86f4TduslzWn8t2Vd8jQWUHgiV8DqDz?=
 =?us-ascii?Q?3jVK0tMtHo2jvTnafq3grjZRNiz3hbKeBjG4o/QBuYUixOstbfaEQto+jqSx?=
 =?us-ascii?Q?s8SkBnyY369uo9tdyfDpIm7CHu484nihqf060OygGRLxvgwHN95L/4cHdQRt?=
 =?us-ascii?Q?ScFfcP4bPSQ5GxKFfiRCjlgR4JbgDFC6wz55pH8HfChfE8QqAIb5H4uUMZm8?=
 =?us-ascii?Q?x+yaJ6CzrH4n9AqhvwyYS8EYBGIbVt3K9ePAkryT71i5ERLtD/1Sgx8V86DI?=
 =?us-ascii?Q?Vg3yh5cq9veDHW8utdizPmvyx16TN6DsERwgWObkYp8iHCUydNOdPF+1svhx?=
 =?us-ascii?Q?B6uoXK1DmVUq5fRQqarz2tePbRMNvfP586RDh2FEwmfQg8tGbdSRhQrZ8lEL?=
 =?us-ascii?Q?T3RuczUbgqEqjC+dIdvnwyNf6ED9v2bbXoVTQYBe8V2B+3KAUv4tDKG66EjK?=
 =?us-ascii?Q?KjFPhgYeLDsIAsmntdNNA7B4mR/mNksaAFEbjkUKyvFBQPkwtAncAIJjdXgM?=
 =?us-ascii?Q?8CLeIsT140DG/vTLYvVaovDnFElz+wVjM4OyilTDcWh3eOSVcTqQpbLrtDph?=
 =?us-ascii?Q?8+6Bf95EwyQUXEfXZq8Sgr2FPMb4Qaul2nFuXuYlO+HmUsZJv5EPvsjiOroC?=
 =?us-ascii?Q?Wd2dQQePYFRuP9ORKRvsqHYQrAwPPofhpJtb9jHhprwswVqOmVguLF/vkWuD?=
 =?us-ascii?Q?5RZmEN2nboJNykq/SjO/FyvplOfZeJa0ZiaPPVmNzbWLTrB6x8KGyCuPpp1U?=
 =?us-ascii?Q?np7Y0VUqC0xvwuXi/RULFLKQ193IStsFLVq6y6BU18baEjxzafxNTEMP2Axn?=
 =?us-ascii?Q?2OFDtv6vxLaI1MkWdlTbTUmHRL5nXXmARyAqv264DLmNUqNk/QCKBHvNVaG5?=
 =?us-ascii?Q?rxNfhe8KHn5nvVxsgM/Z7Mfy983uYkPDBcUyyhyT5Rl5J9HpNsg1ZTYdDE+z?=
 =?us-ascii?Q?sBv/5u9BRo1FQl7JlmraTuHlXMBcjdiNH4okZvdn8LlVvwzL6/nfWnU7/JUQ?=
 =?us-ascii?Q?6SzQDHJbE7zC4N6sasbUKlHM+z8RsARr1w1lX6vU8ficxpOKIaEhHu96wlSB?=
 =?us-ascii?Q?6nxUkNLdYHkOF0wP5cPbbj/WL7bXylZ3k4aLhBRKl6NdjSlWWXPaupdZBJpy?=
 =?us-ascii?Q?CySbgpjqKCYXY4mMf1TjIMugRnuGgtmH5gBCm316lJlhV4F9ywbUsgVjoDRh?=
 =?us-ascii?Q?J62lMIVBY5eS6wHXoONNtIV7YNWoDW5wF4P4vvMwaGkASnY+gTZTs9yFU3s4?=
 =?us-ascii?Q?B78HF4N/TQXJHNEYoC/Ejia8IT9mX1Rar+WkwJ1RNhQUAP3mQfLef3oSvYP/?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e3f22f-e3eb-40b2-c00d-08dac2e1c6cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:06:58.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMs/F+TDGnfnZoOLH5o0GulceRazI0Muwihd0TtRjze3slYsOkhCGycXhiTEfHoRNqgWq4d0R2rHlv/P623gRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100044
X-Proofpoint-ORIG-GUID: RdGWxBZnC3ehFV5N7ZzuXTeO4bxK3qO6
X-Proofpoint-GUID: RdGWxBZnC3ehFV5N7ZzuXTeO4bxK3qO6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_ioctl_get_subvol_rootref() frees the search path after the userspace
copy from the temp buffer %rootrefs, which can lead to a lock splat warning.

Fix this by freeing the path before we copy it to userspace.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 707b2321c8db..ec310868591c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2303,6 +2303,7 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 	}
 
 out:
+	btrfs_free_path(path);
 	if (!ret || ret == -EOVERFLOW) {
 		rootrefs->num_items = found;
 		/* update min_treeid for next search */
@@ -2314,7 +2315,6 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 	}
 
 	kfree(rootrefs);
-	btrfs_free_path(path);
 
 	return ret;
 }
-- 
2.31.1

