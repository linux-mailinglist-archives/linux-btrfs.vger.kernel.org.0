Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2898C74B4AD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjGGPyC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGGPxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:53:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFFE1BF4
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:53:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FUvpn006675
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=X7WAfB1bH6Tqf05Gha7Qo3knwnkvWWywnQB6BF/4AeQ=;
 b=OFiqct4Rg4JOiMz4oxq5IPRWcYrMSqAE86RnEq39G5NQue3BoNVpo/N9g2ixHFvP02iM
 rHQ2dwwcj+mJRbi4uuodKPoDChQWtj4wqsk9MfGvd0+No29Fg8zHBjYVRO4ueoNdk1Hu
 HY6wLTigzt9EsNVtGoO1uXdopU38TVSPkK4zCiu22sV5muJevj9sL4NuMl8orr5PQISV
 s//469uBnC+2gvkjPzMQIIrGuIlQpNKCe8d39Zg+w9OK06S2axQQn4sb1XaFk6W6OYVm
 uYMXuh9WkcOFXMYnHqWopYUL6HMKgoq7xGH9fPAZpBqK7lQYl0TgIxmdccfJg4QOH6VY hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpmk505v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FgnL8013587
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8msq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCLHQNCmmxiP53uctwVUSTY25NR4gfMi8rZBW2i6J98gcJfxEwP/kNRpkatRelvgSxeRK9OJQzwqaOKi6mirqAwzkRvylAvWwXLgCABA1E/g7e+0t/ofzuT/OaJiwS2xUjSgAils/4TP+nQqtgfrvCJoWWO6aLHaRf13+C/8hIAPzUK5diNTlHZ6i1GaWCZs3FRhcoVfqZDH+GKeW8Z/qEQzME3eb4vQ7F5mq5MkBFJPW7PbBsdyKlxZk/d2SMwMhiYbYWwyYcsQAnkZiwR5Lt5NsRPR8uYGoFzJvPAMLSKsPXBcdV9ADkFSrwTOTNmLedWKxYq7R/pkIRzfROHC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7WAfB1bH6Tqf05Gha7Qo3knwnkvWWywnQB6BF/4AeQ=;
 b=UbQW5yeH+lbkiFw4M5i3HcUNHn1ZY+XCXX2EMK3Nuqi3Rk2x0nAPLV3s34MVSCAOGflgZQ3EvMmOZWrAswUKQmzsaTtzJucaFNBP8EmTvVsY8RVr9nA6Vu25HVQRgJThYpbvyURYMt4+S+2/DXrPhgqUhMob/eokMj7ebEHqe2N7CaGXRxGtdUTRd2WNlNqL6OUM8Yk1vIIsIknPTu/dRJsVRzguzDhgL8YoTvmYeb/d2K0IDhVoyNXgdQ22rg1u4/wBW/8+RuZNuiK4HfD+ydTY4AKKyJ1dsmjwmoAEooa1TuyRY7ndCbEapT6g8sF7O/zY1Is0/Al2VuRDKRwdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7WAfB1bH6Tqf05Gha7Qo3knwnkvWWywnQB6BF/4AeQ=;
 b=VN4EA+dvaT4qAjFn66vvWV0SEiQNOODULQ835RljWx5DFVkj9i5k693uTHxJBYwVqlqQtFSPqQoANw7UqcJXd101zlTelViJjeBc9/74KA2dy+UHome/4/Dlasr5s8ed7Rslbt82iPSH+F4PTiGAXSED7Jb3wcUejoqHO4rQFNw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:53:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:53:27 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/11] btrfs-progs: tune: check for missing device
Date:   Fri,  7 Jul 2023 23:52:35 +0800
Message-Id: <3b6a812b25429342811a22687245c9732a715a8f.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: c6dbeaf7-0e12-4c0e-f910-08db7f024dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIAgLWvcMrXhU2l0K5a3D0gVzzu7KrcnR/4s9FUGyVg+m2iSeXcqJm8mqDw+0ughp4YGte+ZtBWb5cJwHfhedaALWaokuUuRCsr7U75JzakInRybfUN+nUNJIXb7+KPffsqJs0enA0ozfyt/ReUEeGpdVhs1GqUkit0CbIvGQbHoplr4hyjwl5OUb4AxDjiLniFD4dr5LkQvCR1sBzrWsnAu+UNXFkFjAiZJAoVxYEq+C/CJ+kBL29699tlJzM0pCYkAOxb412f84GKYc5vBEix3WHRXAtnI29X46oWCB624y5MUOhdnVwHatTXh9NEeRcr9nCQA63ik+ArIk0wo+x+LlP8+UMi2JTcXGOHVe28XSm2eFeJdD8Ea67JnooG4NeG4NZwTMQh1ALnoOyzCD82SD+xXsiqhxYaDj4Pa18N9iN+xO3zDezFZfaepC7FG7EYlDe93WML4TVRkCKv/yje3LiR7SFQ/nzWx7c295NmWrYrYeeQkns06e0X5T44y3s4WXNZzfqarcfvImlI286vJI5Di7gu1ZMiLE7ty8TOtjt83my1Rf+G4ZGwwIpox
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(8936002)(83380400001)(2616005)(2906002)(4744005)(6916009)(66476007)(66556008)(66946007)(6666004)(6486002)(478600001)(8676002)(5660300002)(26005)(6512007)(186003)(44832011)(6506007)(41300700001)(38100700002)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lrXFQUT1kmzmB9/3EzHz5kJs4VBzNk5OxmvdN/9wYlI1jKZ0mIn2pWH515vP?=
 =?us-ascii?Q?aiTYkLkJ29RaSJoQt06oYxUXwUzV3DwttF8ukuWobCZbnEIe4mxpAOOtBJyU?=
 =?us-ascii?Q?KkkTYwOaCrm4MRQIDOF7+wOXdtHnEIvh52HNY5DuIqMR7vg/3Rf9WNL2sD+f?=
 =?us-ascii?Q?dZm67CT9B6lpZxpQBkBm6Q7W5gTYU/pi6KfF6D+j/UQraiMgdXFjb4R1tJg1?=
 =?us-ascii?Q?4apNEY/CaTN75OXJWZxoJmsykvZ6gTz0cpiObjpLQ5lclPIJMVsx3dOPMdD5?=
 =?us-ascii?Q?wWkWICLNzMe6zs9tTsoyGVv/lDmYxhKicObqfR10DvKOZX3SoLjDyHmH/VOY?=
 =?us-ascii?Q?hqczeA93CA9BR91DL+zlBBL4lageAiNZgY03OIHRCIOeY2sLTYjSqtyZxTt8?=
 =?us-ascii?Q?E4LCYaiLxIjqLro7+297vmU+TQB1pvmv0CsUfdLBYmVI26r8Wxhl893uStcu?=
 =?us-ascii?Q?FwD12jqV1B5xh2V4NtM7BGsnCX+zXqcMpOHN3CR27JPmmy/xpvqQgEZMLOSq?=
 =?us-ascii?Q?oWtLjwKuc/c18YbQpj5VndpPezy4ZtA16mZOvyMn8oKRmaf0acee4qfqyHIF?=
 =?us-ascii?Q?Oezwee3103rIaGLv5/EXVIFFVtEazFdySDWiVCm6JaTmnRReE9eQR8KO5T+d?=
 =?us-ascii?Q?lKgiNeM5ZwphH7PIQhXZmMXXHh9HX4vOSYI9j4dWJMWwsRqBIyf6Y0rlD/DY?=
 =?us-ascii?Q?i+b710XIwkHInmafAsMqPrfRx4xw2bu4aXSz5tFVFbD092cWhDQKOx84QeVb?=
 =?us-ascii?Q?P/pq0fPcKBvEHbHybb5Z9D2ILz05lktoZS7VWW18dPag/uhnSxrXtyvRTXEn?=
 =?us-ascii?Q?RIRU1K1dfLDRbJLIe7kgJnUKB9FvRbDdYmYgN7FPSpf9drpg2Xg/uLXIfyAS?=
 =?us-ascii?Q?fAh/Qy99KI7A7tsLqY3NtQfA+nJztp/7jZnk4F+MqhUmWhEOF8MdFJhxtW7Y?=
 =?us-ascii?Q?15DLCtHH+xeDDFw5ibmQfokpP+rvi0LYIxebta9aS68b/R4biZ5jNJ3R2S49?=
 =?us-ascii?Q?xvnUaW0l86asBnvl2Fb8+2yMgmHsOVj15HO/x5X1w+7QjfMRFFgotazsGxd7?=
 =?us-ascii?Q?+iKsXHJF66faItynbnmad54TgX5fOrT8neY0nd4MYzXk/78a2FctQTlMDVNC?=
 =?us-ascii?Q?J0/M7CWB3+Y0F/eVqciRlewHtxoaNdSUgXUdG2dmUXzyLsxlE9A2PtNQPvAX?=
 =?us-ascii?Q?hHcHfiI0URwHtInI5G+VDkPwIRZN8VKrtrgZqzTogmh3oOrnXloqIZtuQ0G0?=
 =?us-ascii?Q?wBm3O7lNQuyvJtigbgBeYqjKQ0v0HHPDtYdCMwjO5xtkQj9OdKCX7OcenTKB?=
 =?us-ascii?Q?/n5RQi/ak0jimbtkiEcUxN++IxqeyH7HSKee0KcR2Kvi5xaGTI7h3P4i35oI?=
 =?us-ascii?Q?vBehLDm8mEwNk6KZBFG0YTvEzfq5CiUAkjRJHMlHSeoFx+I2rojn/74eeqhY?=
 =?us-ascii?Q?naNhanVVd35Cz66fMwLujccvXZtOtvQYj3SlNYTZ9w4YGUoZXdnes0Tn9Xqh?=
 =?us-ascii?Q?RnhZw+A/atClMbgQODmQ805NU3o/7rNhQ0ergUU3yk6KiP5YKhSqqitgWOtm?=
 =?us-ascii?Q?mAV1JX3FSsAlUiANwwYikdyt66nPxcIS9UDUFX5L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HfoJ5LYFVnSP2E/Njl5xubwtCCPv58yVnk/+nG/RjBWTeh7TRe5PpE12ijAe1AFywaqDAykdZ3fjS7nGyhwvDba1f0TAf7gyVVpYmmrELcbuqGf7anjHpOj/OqkFzPHB/UB2Qg4P1a4qHTwsHIAScU+Q42aSVjYPBeQA+oqNByH0I5wX9AWE51SYUujq6+XeirCiklCOHlo6m/kZi1Mv1/uEMaaIeLq3bCdcPS4MfNp4Aq2QxKIewAS0YZG60dSrJMlJgtAW4XQbUQRM6tG0ZMaVdf9Mv8avHtO5lyuCoZLV6IIGX0HoiKNbPVlh6TVQxh/TeabcqQSbCb2spG4NKAAWjtfvu3as3Pv0f0q3Fi5MVUzH2lTsHGMNzHMCvtJTKIYVlVjD7klVeUsdst6v/FoP2urEsFaZKWKuME+gM/3Vm8HszDTCmZF+QxPAiv/YLJZPekMxIrhCpqt7OEpHU1bhH/jXK4wD69R7p1plZZl7T0NaRvMCeThXltZAmQO35j+AEjmj28ZamqrKttgNFqnB3Y8JvMS8TKuDJimJ9+Gnh6uUq7jQMBsgtpUuVlpfqR1YV1ZBEdDuYOWopdR1kyCIPzLwLtHujosi+1wgHF1Z/oRkNIRN808LdGhEbnV+FPDqQfRSUfo3gdxVzkx5TyvHZo0bvrTOj0+j5sfzzX3uhRRaUQJlI0qyH7XiC6D0CzdcPlH8efTFC7jVnpN5L7hoGV7Y/JswWswvbImTXtJ6nmAQpZsC9QVsEP79f+xc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dbeaf7-0e12-4c0e-f910-08db7f024dec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:53:27.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcj7nZ9UcA/MjZm9qrwi/3fqJ0D0ei7oKtBEj5Scfod1Tqm4zC2Wa2RoS5NG0iCl3xN1UXRsOK7uKdnU6N5v5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070147
X-Proofpoint-ORIG-GUID: kiVlbFTw1f28cTLD5HcnZE5TLvxaTnc6
X-Proofpoint-GUID: kiVlbFTw1f28cTLD5HcnZE5TLvxaTnc6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If btrfstune is executed on a filesystem that contains a missing device,
the command will now fail.

It is ok fail when any of the options supported by btrfstune are used.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tune/main.c b/tune/main.c
index 570e3908ef8a..dc72944a2b67 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -330,6 +330,13 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto free_out;
 	}
 
+	if (root->fs_info->fs_devices->missing) {
+		error("missing %d device(s), failing the command",
+		       root->fs_info->fs_devices->missing);
+		ret = 1;
+		goto free_out;
+	}
+
  	if (to_bg_tree) {
 		if (to_extent_tree) {
 			error("option --convert-to-block-group-tree conflicts with --convert-from-block-group-tree");
-- 
2.39.3

