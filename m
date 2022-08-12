Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51748590F86
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbiHLKcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbiHLKcy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 06:32:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779A1123
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 03:32:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CAQ2ct027439;
        Fri, 12 Aug 2022 10:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=HT/rQeQNKMJKbFgUijM1BSWEJq0TwghLBl9rJvt10p4=;
 b=g+b5PUP2EJYxxmLqsfRlEcZv68mRDQgZr73gl46idv2K1iSedaypaOyBtbY/ObCVndhC
 0oy0SAF682S4grjSdxhf50a0AfhDTfl2zh+tKuJ1pB7QRrQ50nXOfms4rD4RcdCKDonz
 YZeuj6Jb7v+tiIODCMMtVt3aCHf3I5fgR85mpp5yi3oUap7joxYNFbBDQKUZZfKEi+rN
 8JlW9PzmjA74IC29Q6JHsbnbIPevzakFGatzCDTXDclEiVRg93gLrm6JrMMpqSHFqb2C
 m2qItpFQHVrAEGG3o4rUn+OL1NcgEG6DKWJypC1eanC7Bn02pb2h5ITz3kmAKB/wWOw/ bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq977h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 10:32:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C7uuH0004900;
        Fri, 12 Aug 2022 10:32:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqkhh7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 10:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl8lMvI31lXgQ0lMsVV1OLo5+g8DQdhlhidCyhH7lybdKCBz5LvGxhIFEuuNI4gVORieZsn0PoQyPt5vVTqqstm651MMRiVS/Ej7hYvaJlEinUYE+FrPaW31U8icc9QJI5oMy8YukEMiaCkNq22dDopmP7MgK4YNnJa9zn5tjL+nF2vJC8h8AOaZAMy2O+ywmL9ePonecVYP1nYYRTowuUp43s7NQp5xvb2oeeBf0MimWdOwJhkAkc2ibsmbsCW5imPbPKyI7wwtG/tSnQ3qp2WJa/BiPRLGnrIrb/xhv4Dmv3Im7JegyKKt93ZHM3vovaAI77xST+ecEE+XY27w7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT/rQeQNKMJKbFgUijM1BSWEJq0TwghLBl9rJvt10p4=;
 b=dxrk2xyXuV+dh2/PABB28sJOC94TEk60SyhihVmAQTOFA1v2ARj9f4I5va/xJonFrkZ5xhUTMLupJXf21T9RaFDTIq+7MabUQ4FBliMZMlspi5UDrZWHm/vfX3kDn2UoCYM94pnQ0gE5S/+XFvgqE24sMy5fFAuDPH6+3WT/qJ6O00uOo6dV7+Ky0TF69OM3I4dvxl9csi9V1U2pDf50NqZqsdQGPSGmtepEZbyLcolt7kktwt2T4/fVxJp918t5v9kIPwPH2OsTKeA57L92Q0s3DXrPQ9PzDgjUrN64xYn5t1iPfRnBcHL0p2CqqerDcpgzgChmoSQiHvLC7mUUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT/rQeQNKMJKbFgUijM1BSWEJq0TwghLBl9rJvt10p4=;
 b=ZXpiflZkbG7Qz7kxb6JGBN2gpWs85vEfQS8k9V+WXVSf3qFIdwBE3SV/lVRIjniGnhFRn2Zg1BSHI+bXZvLvkhe4KRQfXMkclY1zIN7wdIec+PiXL++36+fS7K3xNDylV8cC95AKD/fC9S57nI/aSO9W8v6kI/fURIGi+p41QIU=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by MN2PR10MB3598.namprd10.prod.outlook.com (2603:10b6:208:112::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 10:32:37 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1806:9736:d068:d5c7]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1806:9736:d068:d5c7%3]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 10:32:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Samuel Greiner <samuel@balkonien.org>
Subject: [PATCH 2/2] btrfs: add info when mount fails due to stale replace target
Date:   Fri, 12 Aug 2022 18:32:19 +0800
Message-Id: <6a99394d3248034a908f8f1e22df8917c193446d.1660299977.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1660299977.git.anand.jain@oracle.com>
References: <cover.1660299977.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72562189-cd18-467d-6bc1-08da7c4df9e7
X-MS-TrafficTypeDiagnostic: MN2PR10MB3598:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q49yGvc5Z9I96i9ZSjtLgXd4awcZDwtax59B6SXqMOMoifgu+WhSE/SqvCuS+K1l1LGZnnaTWcx7okFKuDwBnKGxTmpmk6zlKA3MNLLha9+maY1RGgeCYF5oQ/SYmfveR8flAokc3o8i0pcsJGdOOYso+9xFZjJg8jzjVM8kjGnuBChkvGOeboTMJANAs4CiH7O8cVi+YNf/nqolkgDkDOGIbgk7oqM2twssXN4eRmCv7PFj52f9O360P8/MnuoWWBuoPNyJ7lcW6oQ4/xxNEMAPfVQ623umyxwNIzirqQrI78o+1Fk2m1BHoSgxxPC3lTjiBT/6mdZXVNxUCLXwdrtVsNH3YLdi6w+L8fVYf/E+RXEZccD/SN9xpgIt1zQRbZKUkuJ0eG+en9gs+/LU0bOwJUR6RV3oXd108KOAa+vsbotQgWNKl1IqB65KpCtIakUk5cClPdvvrkVCmxHe1vGJSqe1bY38VgNuwjetqhYlNR4+BVXhD1hjOj+EeUuOCVhgmndc8IOYkN45KGa+LM6jPpGbQZjplFHTDgyjuXRPhSaYS3pL+Cbp9bCVHoA0/3gbJXS8PtfQelS4kVcoj1Dtjgf0kb55/Akb8cEariHoSTmALSpt9YBacbGDrIL1v+6k+Fu8kqVDUBwiiEOxhJN9ht/6nFwl9NqAcNf0kkJ/wWg6JoaGZjzTmmdeGagsBlmcHH89Jlf6zLhbCl266BPBWbNhe5CqNS2iBjzIwtiBP/QWeesaCRJ9Bf/0WqMNdgconk7/oXENToAvgruVNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(346002)(396003)(376002)(6506007)(41300700001)(26005)(6666004)(6512007)(6486002)(478600001)(966005)(38100700002)(186003)(86362001)(2616005)(83380400001)(5660300002)(44832011)(2906002)(66946007)(66556008)(316002)(8936002)(36756003)(6916009)(66476007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uISWjbOyyry+JwfOt61FhiqqsxwNbHX/xfq6F5+1fXI+AX3gQ+TsH5keM9U7?=
 =?us-ascii?Q?YP8VPLT9Z7424TEHJj/a247b+N5xwwsOI7eS7hHa6IkJ+bpXmF2B8aSbzPE5?=
 =?us-ascii?Q?+S46onzDWLqxKqInkhRNg2XOvgvfOsePz4FeClJHMRNK+1YVgx79Sqilo/6q?=
 =?us-ascii?Q?9OMLwx1LnJ3U03TYrBh4wHer+KetcWY6i+JnIUNJLwu/yCoa+slgPQBz5nr1?=
 =?us-ascii?Q?X3uMmSB2kxBNlVtEQ8BEBQxtDCHZBp/sOLt6m7O/aw91p7sv9XLX6SxWA4tC?=
 =?us-ascii?Q?xKCLf5e8MyJwlPNeqGXMmCbE0UuVRoIfp2gCkZup/F56xwROMbB86JWA4B1c?=
 =?us-ascii?Q?sgUqo/HyjOhA1ysLMCkKDhqXcYUzvYkRPCcWhrRR2c2I8HQxF8FTyMxiVM8X?=
 =?us-ascii?Q?uBWW0hm9CQoe4hnMmUIz30UHWDLDJ6pncM05zv2FuwlJnlWDdNgLhkt0qcvD?=
 =?us-ascii?Q?VCsKpmKKmJjT0WXzgB3j1p1rvUfcsZ/BKL2xMMioGJRJubTJulLTzRjO3IE/?=
 =?us-ascii?Q?ACywIS0qYofFJjDmyRukY/u66aymZc+sdtatQIi3VoAm2yf8sr6QV4yt4jTb?=
 =?us-ascii?Q?zyAogwKghJkNpbCJE8qLPUZMkoOLnuvz3H2glPli/1ankBy2uWMQFouUOA4t?=
 =?us-ascii?Q?8FUDGeNHqGNd32LZFQscKaT2QcHpJb9WoKZbkC8WQeebDsO5JOh7BgEZIr1t?=
 =?us-ascii?Q?ITHb5lrHjaOfQaZHDkpWZ0uk4WTPl0aLioG+ysxEJmB3mZxEZv4Xe7zbiTlg?=
 =?us-ascii?Q?Uh4vnc+NYn9T4zu3KDfv3Ge1o5C3hCJgizg9s8HukKZM3lbRj8Dftu7zdagV?=
 =?us-ascii?Q?8q+dz4cEqubDloUBD/IQ1/cgxldcO8CAqRygr292wKL3mAgO/zeoxpOCW5km?=
 =?us-ascii?Q?ngR+CwpFoyDUHKBUtTPh9bD0u5MX2myR1GMR0sErjHQBM6ZWuoJ4wcoNR77W?=
 =?us-ascii?Q?Qrv2pXWgLMQQwyPWmfoRLBh8vrttqxV5lfAF2vDq9qqCP/yS4C0o/BfaGHLA?=
 =?us-ascii?Q?6wiGlI9dTaJSFk6mMG641PyQMel6sYcd1zjBhk03VtWmqYvt0pv+gGKqUtrj?=
 =?us-ascii?Q?7Ti5M83600d1qJN2a+u9oNQM2HdNtxYAAoF7ydlYJQuvz9DKp3HQ8YGr7iFT?=
 =?us-ascii?Q?ZC8TwbPdq7dK8ltZhy+8FtMqeQF/RaqPWfpoomWm+Vybqe+lAgDNxMpECai0?=
 =?us-ascii?Q?yDnaMHu0Ctevls9nhsgZVgoEWy3MWNS1IiL+JEEe7sqgvwMXNlJyBeUKDsgt?=
 =?us-ascii?Q?RBEeKKTdrfyLbKTeFDiRGNVzNYRw8TqKNWLBfYNfX+tJYvlmyv4iYH2pNMvo?=
 =?us-ascii?Q?Dy9FNQ7rXM3mPVlQocSTkw5ypb7DY8/Bnk7watKk5GDhPq18tHVmHRobviES?=
 =?us-ascii?Q?nH3VzoCJFUAD9ppo1EqoG0DDLZ37VfLhNKWjbanTxTb0V3IGE+/Vk5jP7MqO?=
 =?us-ascii?Q?nwXgXqVJeND0ELr2gEZZUjT97740Znm9nkschR5R+6MtICrrrZc9lMvOAYcm?=
 =?us-ascii?Q?mYibjpSj0PMohPBjTVQt0JhwUKinVaxdrlAXHUkkmX+fy4Pd+0V4HAXYt/a4?=
 =?us-ascii?Q?CS+LVDUxZkT6vvpDWMrJ4UYUGxiBfwBoNVhBo7WL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NHkF1N3wknurZQY6YeZmlCHyFUF2dBhRBRlMhsbInMLt2OMHIteSuEsUA31rPJbEz4mwj2CEQSNOp0goFwpQDkTKAyJHAUCWmStMINSdM2IhIOpEWQ4NqtDVBcELjZq4mR1fibh9Ijvh6x6BTmfCU5m8CWcSialHnh3KkN5t+gdnQ5tYCsShzBE/SJ5Blq2ETqc+nlY29jOdV26Qhvq2vmNQ1Qr1Zp6319Jk5h6tRaUj3mTknYmY76xylTiIhIzSUow1oQdHuRzCVmbU/U6hd2dzFTb1bw9zmWGKxa+xGMMWf5Rgnvcv/D9jN3sXO2Uxy1jjnYlvIojEi/4RsP23bUI393ArHc1R5eNRguucYN/Age9lE0iw/WdTxZ/+PM7XewvLGy3XEFMlPw2yYXBqiqWPpPO6NgBt1u0vfb5RFT62nISybSk8bPmQjc2crDXBRUrO78ny+9irUBKFhqEPMgJN0TVCxqQu+mK0OJ4pKytJv+QOD1ZPVjAmnA5k4ZeMnTKSA2ko/LtsFycYuab/gVJjjeZq6cnxgCgQLQXgS2FYzeNcWGP4Nz4iYJLwbZFBx5oPWduOXwXeS/Jk4EsxprQtjTG0vyYcQk/mCGhpCPNv9cK4a7tpaZ2V5JDNXQrIF0EUzZ0qPsYYcyqUJvwk+VtTX95I7SY6Ea/TAKraBiFTzMIH2YaASDA5LEDJmcg0+4OzYc+3JsSqcmgORBbNyFP1HuvB/rCSLLQy1BJXYZxEPsCoOiBdRbgARyHTlMRD9JhcOu6v9VsUfCrOqPyXJotqy36i/TSHSWk/ia/6m00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72562189-cd18-467d-6bc1-08da7c4df9e7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 10:32:37.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26QlSlb9pstSuTd57QJWGR0LOIPMdLnHlPDEBLl4nOe+O7N+aj/c5o5UlHbPbzaG56iF6kfhoaBkglQmG1KDaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_08,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120029
X-Proofpoint-GUID: 5PEdWtjR8YH8DLfVKFUcHBiFVR-mCoqw
X-Proofpoint-ORIG-GUID: 5PEdWtjR8YH8DLfVKFUcHBiFVR-mCoqw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If the replace-target device re-appears after the suspended replace is
cancelled, it blocks the mount operation as it can't find the matching
replace-item in the metadata. As shown below,

   BTRFS error (device sda5): replace devid present without an active replace item

To overcome this situation, the user can run the command

   btrfs device scan --forget <device-path-to-devid=0>

and try the mount command again. And also, to avoid repeating the issue,
superblock on the devid=0 must be wiped.

   wipefs -a device-path-to-devid=0.

This patch adds some info when this situation occurs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reported-by: Samuel Greiner <samuel@balkonien.org>
Link: https://lore.kernel.org/linux-btrfs/b4f62b10-b295-26ea-71f9-9a5c9299d42c@balkonien.org/T/
---
 fs/btrfs/dev-replace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 9d46a702bc11..7202b76ce59f 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -166,6 +166,8 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		if (btrfs_find_device(fs_info->fs_devices, &args)) {
 			btrfs_err(fs_info,
 			"replace devid present without an active replace item");
+			btrfs_info(fs_info,
+	"mount after the command 'btrfs deivce scan --forget <devpath-of-id-0>'");
 			ret = -EUCLEAN;
 		} else {
 			dev_replace->srcdev = NULL;
-- 
2.33.1

