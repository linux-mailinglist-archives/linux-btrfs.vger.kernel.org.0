Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48054715B42
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjE3KPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 06:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjE3KPn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 06:15:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF822102
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 03:15:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U9xY63016559
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 10:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uzzWKbGKgkPfjdmGLIDQXcSESiVksGkxcYhkaYH3c5k=;
 b=nCq2sg+ckj4LCKwwJsxC0nqHQczMkFhiKJdJKiPK/aTs9PJmOULJKZaXQaUqoSOBWdrC
 Y5QeQqotHH+MUFkhaqhChlrSO/r2GMcFH7PrkFeax52G6e/rIHgUPlqJ8b65Y3JdBlM0
 dfjvrpb64tff9QVbtjZlQjdyREvLSD1pxIuLd7hk+jdt7MzmFbajxce1Dt86Uf8IJpcG
 UdA8WL5rIDeUQLEJWoaTR6/XVfNFTXUtHjKCZYHx6xyGIqd/oxQPn/16US0m5ob8qSXM
 VG6C9wjS7ycadGL9kOlIs3rdrL2ofHo4Rk9E560M/ak1BdiV3BSxa5xzaT435I/votFe ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh2awq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 10:15:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34U8a2nq000381
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 10:15:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8q838v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 10:15:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgZzIsP7ugcYZbTGdJBYNDLB6/cZ/R4r1KHbu+mBrKeHukoJlztFI042Ke4OxiXaEBzzZzhTAw5ukZ7ubnI3QlDcUmXJf9lc5E/6xbP3BcQTNwD5qPDTJUceaF1HXHfWdqPwMv+IDgRvsbO5jAHrNqj9ex+rft7WoqMFDrxXTj7R44BEMUYIKJ1unLRjhtQ44lVIno2zAovV/+Oekd9h0dy5fxJq4opkt5CSq7z+3gPGhNRZHa/iCiMh/ZNKWC1u1jmMbsH6FJ5qGcWMM0YTTKdJAQCIdA335j7ocosXVVz0rpOOXvGvFJQWE6buJ9f6F5IMb2A0j5dQFmv193DdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzzWKbGKgkPfjdmGLIDQXcSESiVksGkxcYhkaYH3c5k=;
 b=RQsMF8NqfA6Ma60WWdfrBN3chEy3b4HR+otC04haONRNnr+yBd+BqdgdTGw9xrIfgl2kliHwIbBjLNyBRdamQtweYkgujegMaNaXKqmvLZ/R5rJXEv6p49VUWLpsod4+Wgs0nBblbGFzXrG+dgrQYR6zoC76VU6RbSmHT55Bf2/iKAYKkQBOQ+YPXstORzRIXSZ9RmPR8rQ0KRg0Kq8q6+sp8O/T208/Ac0ewRLDOTQHXSRPNg24KlR+3UU2udwbMHwpzMngH4LUAWGt/DL1YXNq2jhZwIZAhwJzV+dKcMQNhTfhr+c8fjPAmpEFf/hGrJLZi3NAyb/UCzJZtDh1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzzWKbGKgkPfjdmGLIDQXcSESiVksGkxcYhkaYH3c5k=;
 b=yp2VTh6ncTxkTp4phYiUwfrbbhpE/bmntiOuCC79cAVxz8xEYGyBwGbH1XAQDPMKIDwEt/Ytbj20eE/R4ka8gKmlPkhVsLQlbDsvW5tqJfoExt+uotGBmK802yWuH3UyYOgnckDH3Qqk7KojrN5KEC8lDyI0jGocpPP8yQw536E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7842.namprd10.prod.outlook.com (2603:10b6:408:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 10:15:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 10:15:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: add CHANGING_FSID_V2 to print-tree
Date:   Tue, 30 May 2023 18:15:11 +0800
Message-Id: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e72a83c-02fa-48f6-5d04-08db60f6c95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWPn8P71uVL+ekeq1uMg12xunQ+a43eyOo51xa1X0Ye3+uvsh1M1D11X4X0tgBTylN3rKrfHq73GYFjubd+kNr590MFUbUm1UZJc43Wntizqz1S9VH1hYpMIEdDGqxLjMVr2jL2l1bT1/+h31hpAt0XuvY7jyxLkIHzFr5BQYgzxXUxQrzJXeHnr+18m/216ooDqQyD+Ci+LTQPlFKiYxkVW4snIHWT1mLYDEkiurfKtappWETltuKYeZcrtr5ZZatSU879byk1OmQUtQXEl9KV5SVoFFv4M8d/RskSQoNaGpBFtx/6xTeLp+240DgccVDCYiHIr793vJSLKFC+AA+EajhxB7AyjHOD4ySP4rNe0bJ0aQmfEmxHDfYv/DYftPW4QtcQLaM9Yzz4U/e8ineWCmgtPIRjAbPDa2VQVC4ad28DCZj4IJd31FPSmDTa0eyAIhsb3/NYevWHjrKOLnkJvRGIJu/MwiDxpy9XfgSdT5fbaNgYrLQzv0gEduPxhepYSPJ9JqFbkgbk7nnNpt/DVnXsC4cY8KitkXRcaKTMRYcfYsNWF3DUOunHQrdpU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(4744005)(36756003)(2906002)(86362001)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(41300700001)(2616005)(186003)(6506007)(6512007)(26005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJ0BHoteFf77nTQwBpiBPs99jD1A85tIms4tlraX/yNIHcQObfc28HKkVHkc?=
 =?us-ascii?Q?GXZAo8wdGHKFiyy3bo5bQ8QdNo1BXECZ95bOQKnt2vd4fcJ2A8te5H7qn3yQ?=
 =?us-ascii?Q?IVD6XmRlKnpd1/1hxzXAS4KsWmeibnisZoY17vuhxjxKhpnPpkUR7bwq/ab7?=
 =?us-ascii?Q?5lk96uPHxrMerL0FBGhhCp6yUazfqiuKyXIuWLjxWNcmLz43U4c4vH++EdYO?=
 =?us-ascii?Q?+kkFG6EAk9VNAioj3jrTtlnj+vBwVy1ssHBRN9S2YFOvWG1m9k4BqIxDErkl?=
 =?us-ascii?Q?UVtpFFWIDeWnuoQunGI9+gA6ucl3D4ylXQTdYH+WrZ9Qdvb20IWV07ChK60i?=
 =?us-ascii?Q?hMYusboyFxravqQMzKlShdwuyyMWqzju5T1xtWCc33Ur5i3F/2CiuCciFSfM?=
 =?us-ascii?Q?sRCvqIW+cnihOZVOc3vsYN9hrGqqk2yHgRPrlEP9hWb9lGkjmQcFYNi2O9X5?=
 =?us-ascii?Q?x642P0wG9nr3zBPTMyjVr8P7x5J3VoIyJ9D+D27Xgdz0Lg157N+qIc3YLME1?=
 =?us-ascii?Q?YUINv9A1m5/ma4AWx5c6womveYnVMjRscbQIMrU+VnYyBCpyy6eaFo4F0/u3?=
 =?us-ascii?Q?8SX4lWVpfBubnu0iefVDpP8PuX1LHMj7WqpiW34EAVIyP1dzZAUunOMrM7GO?=
 =?us-ascii?Q?7Ne1g+SIk5Yii+Tba01gO2heeCQiex/iRP+K9Hufpk3uIn0vnB062lg4TWtu?=
 =?us-ascii?Q?ygBDvByt/fi6XvtzPIkuEAB5ynzT4nywHoMCAdzqBgLUlupMCwcM/+51blNi?=
 =?us-ascii?Q?cczoqoB3p2C+UmWWr7yDyfx9SNIIaH/F72AhMjoHUDHqGJhin3GWevoJF93o?=
 =?us-ascii?Q?tDjM6xUxub9mUvn762GmxlujB2rmdfPDNeSu4FSU+99GF94Iut4b9DYBOlMX?=
 =?us-ascii?Q?nHMIIqAe9MzLHbX80EWmCoF7yNMFSG3WvbCawMsE6wsuUmaH5gAms4JKx5QC?=
 =?us-ascii?Q?w8GgG86JzBF7kVSLGKTYaaJZm5xbARX5KbN4snejIZRw+na8W44C+Ug/OzvX?=
 =?us-ascii?Q?3c28tjHyaw0B0Rj8zOqOhYDB9uJ9bo7mLimwU0U+7wvBIcxE55Nk+5cBOjzz?=
 =?us-ascii?Q?visB1KOnuNyuvH6FsoQ3evrjnIK0xcvhz88WCHb0N27dGDGPl23zpDT0GYht?=
 =?us-ascii?Q?NI34JU5u7OfrDaXPyGkpxmSzRwzHHHcZEGSIn6pt4WJWXDB7zk5jqoecRQza?=
 =?us-ascii?Q?Fh+LPR4uEGOPkiY46zXndF0ZT03cJsZ/LQXjDNxmeAzJ4UlO/+15Ng1yR1hK?=
 =?us-ascii?Q?BkvtRONwOXoAjSFyAxovICqFPdar7I+J6o4wm13n0AEwZLCByWWxCcSa6nv2?=
 =?us-ascii?Q?pvU/wGLiswuqXT5Yn/9SYUvHLkpdSwmTQ+2ds94e+vglNlhE+mXCUc7k1MqC?=
 =?us-ascii?Q?P0Gc5YaQDulzemOJbIAZJDpjsaKGZhRStuuKF8VxSYIH+xAWv6hRhgLjvp8s?=
 =?us-ascii?Q?r2l7/GJt9UCvw1tY+l3Yg2mmlw9o6jdfW0n0079fOSK+DgGcY3thShMLb9zQ?=
 =?us-ascii?Q?OmsB+aUc9PD1Z5ExWCozYDGMVtvXNA3eoy63tUI4hoORNGcE/YgUZd6vCRLf?=
 =?us-ascii?Q?2CgEf34TC4xwmQQevW25j7rAE3dpDb5wHTQrbnOR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eXlRvuHW28zDAaVPLsUJPWYWNR3zQ8gpyntcPkHs77Hw8DSUF4E7ppJCtPw6bO3T0x1SWFQRkGoa93/OzGel2CWdh8v4REUtvKLmk7JV1HwiBkqU3kErX+844y3H115Z6GEgKQPLUCAKxbXst5iZ/qDR1jTsSF1+xk9a66pJdUiyH+YVloyY+9m5BDAcK+kADwfx9PlLwkn9D5qSZ0rxGolKPuEbRNWPSQdMXWoqaRxoz7tbrEinUl2BL/bSpCsu1yFVbrRQAztDzzc0nLRFU0vbRuQ3vks2NIK5C6vYwAFDKZ2xPDc8GA3bBp67aMZbaawTdvz3OL87ORmVTdPn3Bx8uEoYWXL1IbtP15EnOpoCe9PZKdZOnakYblXRTEgiweAq42zZpqJS6skNcYvF4teK8lcx6fgSZd1DhtvVqYixd96KXK6Tq6bnRe0tuqwE2onKcchtlqHJIvwOIgNjj3Dp+ZIDnHTYTEk6SGBcARhBqe80L+Db6b2zW1kyrlEjhzpKQE0B8zO3tk8ePzhciqvoConh+goRDmcYWC4kQDfKB7pCUGS15Oj0bOA5zm6RpUuBhmI8JBtOp3yResAYTEHxXAIxbQBmQisGlWh1KNxFaXTrokvD6jrG/rizzDO+0Z6EpNUHVLCQZOG8is7yjM8vcaVW5ay9C5nuyggcQm+eHxOX4/Ld0ORHTyRzTNp8+G/2n9p8kTy0iAAadn/lRM6OQ5/chghZKQiWrAZ8Bct+nlx6IjOJsTw4PATVlL16vetkiNwW7FaD6lE2I0KPGg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e72a83c-02fa-48f6-5d04-08db60f6c95c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 10:15:26.2490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5FzzJw5KB8EaTcLcq/7l6qkSSndil7cQLSNZu1EoS4BWYZvaHFEH8wnzfVsKtKgm5DUg6hL65eHo/ExtjD+tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_06,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300085
X-Proofpoint-GUID: tVQ_5NQz-4ermSB58dDj_mtF08Bcc4PP
X-Proofpoint-ORIG-GUID: tVQ_5NQz-4ermSB58dDj_mtF08Bcc4PP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
print-tree.c, as it is currently missing in the dump-super output, which
was too confusing.

Before:
flags			0x1000000001
			( WRITTEN )

After:
flags			0x1000000001
			( WRITTEN |
			  CHANGING_FSID_V2 )

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/print-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index aaaf58ae2e0f..623f192aaefc 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1721,6 +1721,7 @@ static struct readable_flag_entry super_flags_array[] = {
 	DEF_HEADER_FLAG_ENTRY(WRITTEN),
 	DEF_HEADER_FLAG_ENTRY(RELOC),
 	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
+	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
 	DEF_SUPER_FLAG_ENTRY(SEEDING),
 	DEF_SUPER_FLAG_ENTRY(METADUMP),
 	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
-- 
2.31.1

