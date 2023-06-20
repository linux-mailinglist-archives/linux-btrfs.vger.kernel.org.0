Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142AA7366AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjFTIux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjFTIuo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:50:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D121712
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:50:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JNw97l013644
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=BCi4eK/pyp1UXZt6guPSOQxTNA5Fi1myfwyMb9cLQrQ=;
 b=eCWPLPSq7T5gT1Q168btdPnpHQerYO344gVVYQSBc/KxgFjS7jkuD0wnkNEDHy7BhSe1
 4xQIX+jRVB82is6mjgYV2LzfXupW0KJtWtUMP2+oYEUxIob0I87rEUgnTGWrumn/7nsG
 NLtQTj8DoWsoiLhIp8DLScT35S/kFbH7fZK/RzMAHWMrVMZhjMkaoinIkVDHgFlctPKO
 IrboE6wJP4XHs2V49xYmJZtzmOVnXvJdZlOONeMkCqvEw2XzINPqBiwBlYvg5j6DfXva
 Ok8W/KuO0K4xzl7b8R8+9qtacqG2S9+yJbb1lki+Dth1/WNcl5hcqyMYuum26jHzGqHV tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa44vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8aPoe008308
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394jtkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWORPog+FpSPgpLVhmo21BCTOBGKS5zVAc/Gk3KNfG6j2M72p/SELHATBOOrNNc31e8cN7m1SF66nI34Mm1hNwpz3xmwd0gq4OXThFdiy+AMZWS/fu1BAwBhkkMHuUyzJ1sAzZf51Zsl0gNN/guLauRrcWmDAxrPKGwqKlA4+vHzN5QwaSPSyujGogh7ncVuYyuzP3ioWtC27U5kjlslQPrHdni0NdzdvzFXjEL4aA9FS6dH+/1EaJ4hvTjN9P8oqNhwc5Ad5UFh5Np61COf2XuH80wMi/tfzoNRPVnvxY82o3A48duCMFTz8C3NfURwlvH/vG9jB/yehwwj0dYD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCi4eK/pyp1UXZt6guPSOQxTNA5Fi1myfwyMb9cLQrQ=;
 b=n0Osj2drH3k2iBwxKdWTr3801kR1k4pGfBxSckXdShA6zLPz7Bqrxb0P7T8uu4zEEFLHV13FyBljupp9/ZxwT1ApUAVoj6wfVouW4jzzbub/OryYy55zGByAHsyb+rsuoF0uLNNMqloqKkVxRVeEEYYdqFSElM5GjO8civbSgVcIrlNip4EQApHaeQrNvmjNqVQhv5dAgvAO3Um2mDcaLUDYuYKt/HCHuKBmzVwoP+wnS7H74OAskVcNDeRXQDKvrDX38atzHk1wmbZOUCvL+fdnZ5hannSF1+8J/+fCb/yBxVGP9FU9LHr1WrFI7dRqG8GpjfI/bSKxLmixaG+a8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCi4eK/pyp1UXZt6guPSOQxTNA5Fi1myfwyMb9cLQrQ=;
 b=J+6DFFvlw5bA4YgbEY8B4alm8TzEsX8o6RE5ucYKT+8/5+5w+nHbEsFrczQKC8Q58IiT10W3J2EOMG5Vk7KDPYGmXfAQmsuacdshfBhIi24K7b0k8Z5/LoDjKkDNj+7hUTjKLsrU4xMziYAjipMFV3C38fM4q36BKwU6V8dWGi0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 08:50:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:50:38 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 3/6] btrfs-progs: tests: convert/001-ext2-basic check for btrfs acl support
Date:   Tue, 20 Jun 2023 16:49:59 +0800
Message-Id: <559be305914d643f7de7470dbe9c369d32df82ce.1687242517.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687242517.git.anand.jain@oracle.com>
References: <cover.1687242517.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a7cb16-bc86-4bd1-a43c-08db716b6b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seLXwKq1j/1iwDExx+ieKYazD8LC9W95jybM5+1v7ej0/wyN9Ty5NNRMKFGDcnOxvqfWkA2YYZcjs4+lPZuG/3PLDvtrspmO1UjHDyG/fXSIwvNfBYjLbGRimdnYHYTdFjGuNO5Cyiko6wOUhFPmyrzvxe6i6/DuoXX0kNRMUAcq3Ii5QAOi0lFk94yClgmHBW2w/HmFUSQnctl1aqx+lQBfK0qZ49DJhzx4h0VY+Nq1y7/M+lEdqXzm4uDkug8LRs4C+QRuMKkz1WWkdWr5SIPf0zr6a4POCtQwj+btt2mJDdMjlTWRuPQzkmcOZJBOtta4EHJmk0wT6WgpzUXhyqSblv9y9yrWSK7c4ZUVxR+hCBRNOIOGuGxfG1YbHsnpY8pIEcOji4D17oSVTS4tKSPrhARtf/AsV6RGJ8zyeoT1Vvwks1eH+37UHzx/wLpy1wNlfNrRmd0vnCDy8JtupQhhUjlYwP4NpKucTytHUKJElo9//yb0sxrd/fiXhu7zfCN+NOJguixdB9L0K0FeOW94GT4fl1GeB33rebZvdeULzBjDAb5XdUfz6iyDuuqQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(186003)(6512007)(6506007)(26005)(83380400001)(36756003)(2616005)(86362001)(38100700002)(107886003)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GWwFO0lEYMrPjR2z85gSIT90uhyMpQ33yGyWLQx3Gxumg9CSRAyPN7x/xfgk?=
 =?us-ascii?Q?yypSDO1c1zlp7+S5IS5xbYwD5+wSV0D5kUTwUb08wmUg2y57LSOt0rLCq5Wq?=
 =?us-ascii?Q?VTbTuEkK/ZNIn/ZUVAedCbuCnQJFRRw2P8Q3hd4SHp30duMqVi6k4cc51/Pz?=
 =?us-ascii?Q?+D8rydAXqGWsqJuxYFnEImQA1GMQFHMXsABZxGc3as1GJ84x9T2v3BcdHRHJ?=
 =?us-ascii?Q?Jal2yTee+qpE4vNg01AnAICrK70mVTd4kQi87+4CqCLAmi/J90mjaJlExakn?=
 =?us-ascii?Q?xXdeNtC30HqkF8uXu6OHrDp95/mIFVM8TezZfwB1KEg2irjOf47bHZw/rcqs?=
 =?us-ascii?Q?jBsmYgFzLDYHTki9zlekR6ZuPmhW1bQQgYwPWuJqiMEgrzBu6cGpFLF8yEhN?=
 =?us-ascii?Q?eQxfRDnWxwZAvp35Qr8L4I8I76vpasnztQ/o5lyl2Fj41l+gvU6kMmbGLIJb?=
 =?us-ascii?Q?MLaOq3AH/Tzu64RliySxe/BpVzDbvhzL39FivuD84vi6Qh5S6tNUS3oeB+WM?=
 =?us-ascii?Q?VeTyyI4Kr15ZZfAQaKmeK9vmAQf+VLaPUqA9+eMlnVei2KK1fp0CxEn4k+Wb?=
 =?us-ascii?Q?3B6c1LTXV1V2MOy+VxMz5wENkTrk5HoUqU7wEoPBAHFzOUGH2Q4k1rR9BrCq?=
 =?us-ascii?Q?jx/nvzlcj2rn3Uzoi9Nd+dKyvZaZV8w4+aS15G+30+NDFZifw6DcAfmuwlre?=
 =?us-ascii?Q?8ANiW96EC8GcdIF16mGptcbu6+XRoGTU5mAp1hPbFd06BPP4zHb6/Ll9v6z4?=
 =?us-ascii?Q?CH0PJhM+XYvgHinV4t5HpmxsNdrvx9VmPW4oBpvCgYw3R10bOrqlMwzbIazd?=
 =?us-ascii?Q?+YCvoM6MP2SFkZuzG066m2PVDR6w3SRBSTV2JdEk1C45Si0CttqcBCTmqvyJ?=
 =?us-ascii?Q?i95KJPbj5Y9EMXKtUPRV0UUS2EI+lCvqrZfpBu3oCj+8pebztmO1/Kxypxjn?=
 =?us-ascii?Q?xYqFrFZY0CkuKx/6Kt/ZWMckc69U/A2TKPP+e8Oui21+gVls+AWq8tRHWLlJ?=
 =?us-ascii?Q?Ol/iCXw6qDGSABckJR8Ehfzwwyq7QmikeDKAqqsxvPUVwDeN5gRTlZIKX81I?=
 =?us-ascii?Q?9zLn0+C9gipOULEcXD9kqmQ9O73AOu7ME0LQHqkSz4jYY5QjQtgqueSW2pVl?=
 =?us-ascii?Q?4L0Wp7u9aBAhCQsZ9MnR/ka67rZq08btJ5Dm6OavfpFfZDbDCqPFujsul0D7?=
 =?us-ascii?Q?cNW2bog8GzS4EpPgN+yaBfPHhUsEqwjthdBAfNkl6NiyCWoX+WIhqsU7Pdj+?=
 =?us-ascii?Q?HQJXtz/Pl8AuP03ujCcdgzUejcXEEPa9GrhgyuJwhEMHmLnMAnsERJqZAbvk?=
 =?us-ascii?Q?YCcy9ooaLrDveXA98BwMHtiomEvqA4Jkr6G7SAwN8HWr5KRF1Vo/N6vw8KGP?=
 =?us-ascii?Q?xYV92Ow2BOvbGaTldSe/avD4gbldtggK3d87przzBaemgODhKo5fNCKLu5rv?=
 =?us-ascii?Q?oTHwGV9HBX5BtDCCfohVx0Kt2oXO8oMR3L/66gOaWLMqDMiT0/iGQxcEB6fJ?=
 =?us-ascii?Q?0HukmNUO8DkiX9Rkj2RNhzXgejuCn9RmqwZ/qQuM9DLtFprp2PsqI1VIVYUS?=
 =?us-ascii?Q?JU0us+gL1GU3d9LM9BNDzF7ld/0z0a7PYbhBoJBx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yAkU5goL9i+LsFh6XPaoCGl+btMYyx0fZ42o649tOYYm44DQDYNEYnXKIIV4s+BL+oTJaLZ7KCoOXBymZmdPQVQ7w7p9zAXpUjwMDr0NWAihlvoNUIGVjNyYUIRvzeWF+wDvSiFAT2rNVvMEY4Rydd119oq8l2OXJT1Oir8cM0WYcc2Ef7PVmGahYwENG8SlcZtkH43QUf1JB0i9w87cD4kMk6jPfr44Jy+r9VfkA7YmJyWvbw33ontfuIYBWdj6xbRR2+6TlyW+jNRC8qrEb8P8brUOHtubk7lsqfqgGEsb73hZpw8sBnr8pPIu3Dmea/AnZ3uf15k/d+1UVEB5CpEgA1b7wF0+Gx/MgF/cdjclkjX8Cs5y2yl1UZZME6A3HHLVZtAPMpRQqsM9Mya5J4Xqc6Ojx9cXEIt/hWvHjd3iirWyoGWqInHYxAlvYMiAU5gAD24xaLgr9i9Ugdn0tevjEOHodTsmZ26px2TbFOMpbzsnNs6aT3daICdElBOYIRIbtj7oparl6gebFVmP4a3JKFratmKL9Y2Y6ZSQ2h+IWolKjdTHOJgLww1y1VayaptV7kklCEVlmZFV3SpKcgX0Hofn0jOfsHCqtwC9vmkJr0u77YbQp9S8XNxOBimX7d2VcDdT78lyBq3t6cyBMwxBzRbCKByYm3YgHsnNqW3k1575Z5GaM/rws366BgiLGPyIQ0KnqYcT8+Xlqcd4Tl637fJ/klSOgtN9b/po3mkeqJKvVQ9Rb9VFhKvB/3rWYjS4PDXtQXXyvfotAsV0tA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a7cb16-bc86-4bd1-a43c-08db716b6b9b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:50:38.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5Uia811XhYGtoUvg0DHQLQGkG+OQEv4h4mDc2q0dh7yFj4gWwJv9yYncOuBO9dHZgqBAyuTmZoGLSqGw24FwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200078
X-Proofpoint-GUID: kX3BcZY86ny7cTBH8ZmOhAgSqGCumL5V
X-Proofpoint-ORIG-GUID: kX3BcZY86ny7cTBH8ZmOhAgSqGCumL5V
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
    [TEST/conv]   001-ext2-basic
    [TEST/conv]     ext2 4k nodesize, btrfs defaults
  failed: setfacl -m u:root:x /Volumes/ws/btrfs-progs/tests/mnt/acls/acls.1
  test failed for case 001-ext2-basic
  make: *** [Makefile:477: test-convert] Error 1

Instead, use check_prereq_btrfsacl() to call _not_run().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/convert-tests/001-ext2-basic/test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/convert-tests/001-ext2-basic/test.sh b/tests/convert-tests/001-ext2-basic/test.sh
index 4e8aaecb2f55..4666a83a24b3 100755
--- a/tests/convert-tests/001-ext2-basic/test.sh
+++ b/tests/convert-tests/001-ext2-basic/test.sh
@@ -8,6 +8,7 @@ check_global_prereq mke2fs
 
 setup_root_helper
 prepare_test_dev
+check_prereq_btrfsacl
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-- 
2.31.1

