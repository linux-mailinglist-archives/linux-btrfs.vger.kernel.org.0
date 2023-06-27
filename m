Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358E173F7D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 10:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjF0IyA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 04:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjF0Ix6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 04:53:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E28A4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 01:53:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R8Jbv2028000
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=Fx7IaBf8CR/fP1Wtxm/X6qMQSOmOwdOEDudKGXOs3NA=;
 b=znaZ2jnqYdprTeAaPTZKQTX5PW9k2/RYNeAf6GP56qXu0O0wbjWw1KmzmSeFjy3v1gxu
 qsMADyl2rhnWFjGW5kQVni/Z7K+hv2K+YZ8ysJiuIMlEO58cYgCsJKnIYb/IonkDKWQR
 l5Cyti6ogAU5Dma0rwiGoSotYcGT5h/71KU7TiQS/YRSyny03ahmKMBerpISFxAhMJmS
 ItcOoE1hFig03IPUsdwjjHhTdE0H8DtLg4tRMp2mdb7B9evC1ASFzWvLX2ETGG9dRyst
 DG+GeYcBL6y6Yux54QZZ7MjmSgqmeMPEt9YEamNHd+tdYJpD5+1KM2oIhxEFloNQc4FD Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhcmj3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35R88sfo011169
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx46twq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms4P3FkIGZaevBUlebdJWS9GEhVenJWRhEW8lfTEIhzmGpz9a9bilp5eb2nQh+UzanaZYBaZLehfV09zVDzTBkY2xWx8ef+VpYQQc8ctMbM0t9WtYwrMdJUWdUKfgX5ophys+ptwPaRk9urhSagMwZ7NtCXAkE7v+mt3xePVCfRXJvobVadsag5dvFeKAZI0J3SxnYmr4v+xP2soImxA89apAkFXUPufKWikfIUyTTRpE+LwGaoq+WkDFbsqmp0CyTfXji2vW5rNjLLuPAfTKDruVi8WCYsLK2rcyC6rYOgT4Fy4QchQt0NFNRP546zgzqdcxF4wjw44Xasq63m4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx7IaBf8CR/fP1Wtxm/X6qMQSOmOwdOEDudKGXOs3NA=;
 b=gt+XFwJTg4kf7AKd7b7GOd5dN1mMDQs4hmArn+KDRiN2gUzCRDOgXI61pcWqMwIClX+vDN/m5lc7HWRsgT9Nf/H4uzb2HVNX13lhPx3cxV2kSV6iWBdtlxn0kL1eOBKmPIDktslizZ/Yo93rcDoOrMHX5EZ0jIPnRsqsdLSpc3541rmDMdR6UNGdgKtFPMjua6+bYHouv+ggvTU/6X59BNxkqYdEro5ezpZVtqof1pZU16s8QFw1NnrzJaCUfhieCGfNY1OKbveKiVduyUg1K1Pta6Em4qvQKo0hVHtDaq3ht7Xo0Pd7EvyUA1R5k9dk6CQv8bC2HjRiJ93LcIHUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx7IaBf8CR/fP1Wtxm/X6qMQSOmOwdOEDudKGXOs3NA=;
 b=F33QK5CK58xKeaTtHr2dt/1N0WiP3BsMSMwUIRm3rdT9l64j4l0/cNaJHebIRGEOeMIRkoDSLCTEepUptEHAooRgiaM9tynr/fE2Sa6SuQMfEvvx3nbTrapiBbaHQXBq7tB8W1P8Sm+bnoPeZM837M74Xij7+LOHG/HAYY1YqaA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 08:53:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 08:53:42 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: dump_super: drop the label out and variable ret
Date:   Tue, 27 Jun 2023 16:53:14 +0800
Message-Id: <d59136fcbb28ead308886d5219ccb630530c4b37.1687854248.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687854248.git.anand.jain@oracle.com>
References: <cover.1687854248.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: f28afeac-6a85-422d-bbbb-08db76ec0217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGW6lylSawf6nzIMiciO/yKUDm2QPwsuOlWulCm1jZZ/XAUM45N9SWd0L08vGy+IEv+V12osX3siHxqQ9G3yoNb6B9v2hsnTvZEDVPlDNXfALgYvJ6dMZD8/K5QadN7CbYJg13OOVZXyPOOplLtELTY5Q/S7rr++ysajMZlh8Msv0qr+HjDBF9ddirRpFPbBfLMl90Sj6lKhaaeahT83SjkCmkCeR8jmVKXZmnqgUgnzooG5j/M+bX/J3P1cVh8GUV8PIVC8PQ4MmEmIKUbJiFqXslfDA6250fUmZtscmKO14BjzgYdVACj5ZrLLJZ4ALUPnppONibnB4OXFcEOIX+mNXumlD60Xwy2P+ouJ1ZdSBdb8E8mzS4w/vAXolsRycmiMw5dDPqT/vDQpi2fwqakWGZv2UzVms2pGEGaXvZyMJsJzJb9JTL7lhXSKH6xAGGCPEmaCRR4Q7Ln6BhmywRXbl38vVoGqWo4QttkhuC4dZer3W1em2C3D0QWLu6zHq/chNcGQ5aYpxxjuSYg7srNfS7B1hUNyd4q5LyupceDeqF/KNjhR+bfs/6nE8s9+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(6486002)(38100700002)(26005)(83380400001)(2616005)(6666004)(186003)(6506007)(6512007)(41300700001)(2906002)(86362001)(478600001)(316002)(66946007)(66476007)(6916009)(66556008)(44832011)(8936002)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N9zGBFDEjqIP0yLz6AifF54pUTUaYwEsSxtIoVwnIqNwKcw3rJwx/Y55CkIz?=
 =?us-ascii?Q?7yi6lZKCiP3B3CAlASiwKN31WagHqnZ34ScvQv55QqxeyVPGpc2QO3LsV2mE?=
 =?us-ascii?Q?2apkFryEJpciEfJ8jMaw63DcgCzzuoOGzZN6vAVQPYuYN0bT/WEau+t8BDvQ?=
 =?us-ascii?Q?oq/nkc8UZ5Cq6lhNMw3qUEqdkEATlR2nN7z0EDJHjpF8jXCLRdw97XLyVRMb?=
 =?us-ascii?Q?XGed8YRzolGNNeohjYHXYJfGgEDft6JlognCHXvmuVDN3OiJE8BZSkfNGz2b?=
 =?us-ascii?Q?JP+t+OhS74QrzrXlDzIkZpwnbmkGx6MD7EenyFw/RTr5b3tS0MwOab7Vqsv+?=
 =?us-ascii?Q?8BXisvc0OeL83XJjUxQtCK4h38Ro7HZxIysJnd60rcVJZbjIFXrZxHyUblkZ?=
 =?us-ascii?Q?ybqvmLoYdYVUgb3hmYkUxcRzF64J4zOemjZ3tfp8xXrTOg9jBynFSHEGO3dG?=
 =?us-ascii?Q?VmUPoGHVL9faSlzvcQto8Gl2c73Ef7L3GskNIignD9MMTOHTE5dqBuFy8jq6?=
 =?us-ascii?Q?xIpsgXvAX1/pKQ1hYI+GosmfhaWNNPLhjjr3NjPNV8htnO/aeGvvgNutDfI3?=
 =?us-ascii?Q?He9mw/RLJ7H+0wSABm+PmyYKNa9EuJzLrLB6TDsnF8sfOI2pBWbzKiI/I0pk?=
 =?us-ascii?Q?Zidd8robrjI1OzM2e7cCX//QCbRa3h5Fid6zcWo26R32lPc1RT2hOv3KRszQ?=
 =?us-ascii?Q?LXKoOEAJvbEYH2p7BPCBi+qV6V8kVncWxV92H7ppsdE1HPCRq/fzNXP3Bw+w?=
 =?us-ascii?Q?oJcu1z/1scRr9fDpjYcxwPTodnqVE/2YDeIArHYHzivKuImZXrXV8RuWhWR8?=
 =?us-ascii?Q?an2gHsU/DzsE5l1AvrAIidoJwwnAThbRNguE8qWu4XSbLbXT+Jm/PhtU16Gf?=
 =?us-ascii?Q?tzhTaICGoHFc1KtU/WYVeGmY+aroW/27IaBGaP+9NIWXT2r6WREQl+8CkCA4?=
 =?us-ascii?Q?DQ5y3nKhDk51xGlbGY47Z+Nre28f83lJBfevhAdiVrsv2Nu3qFcPguIH3Apz?=
 =?us-ascii?Q?4qAdukrpmR77XqSVmGkAcHQGMpwON0wImLULZ+vZQDr6L7+AcT1fZRVNL5LF?=
 =?us-ascii?Q?ugqrFeA+ALakCD09M/DM52lkmy5s+jLqYl4oxpHQJj9xEum1EURKL16ojv5E?=
 =?us-ascii?Q?ECzYufGRuRpK5am3+povGJHpmn+45LkjSh2epnpN/zFpJZCui8PEPlUtEW1P?=
 =?us-ascii?Q?k6Li4+qoGgcV0KQVvazkYMPZ4CjGZ20o/eSV7BTEa/FtIS8sYgBq8P59hPa5?=
 =?us-ascii?Q?uETN35fGZHe33tn62EdYyYoh98K63sHl6Bw3fGN3a8OB4I+17TPpMjnh3ddi?=
 =?us-ascii?Q?WooMXoP1T33YC3qH/8i4SP/qusQDC3XJha59eon+TIc8kfOLps37LGu5E3zB?=
 =?us-ascii?Q?px1zA26DE2y20rC94OB0sfomZ7Cc5qtIt/2SeOO2Hu6O3u+nFNuvMpWzb098?=
 =?us-ascii?Q?UTfWlcOMzvQCY3m4WU3m1TJkjDtmBsNowEaSfLiJ4mnI53Ae1ncPVndnCfTN?=
 =?us-ascii?Q?e5DBGOH7OwZyMbbmJ6GOUDh9dJKnIOzE0BdIZzM8NjELEaQ97NdoZaH7Xmt4?=
 =?us-ascii?Q?Vmbqj49OsfFPwLUxszhy3wgJ0V8K+vnDnGxaNeqd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JfbLFDN7UBMRgDRj90vLClz0YoEriJVIK8MLOFCBDsZiZ3lZB5Xo0NNUExHqSUo2jggMB3gjGNY3xGiWb+vpbnsTrJ/J1VuqfKEkXLG5aH1lsPkAvNJkySYnCLFCRqrL0uPm22oUwkqJ+8xKFDgwgYHxZQHo4Pbye4uBvcEku5fQRwIG8qwnEeDzgIWeiT6arMQmGtHsJtTDGjAHL3i+om9ry1W4m3pr7mZ/C3LojMeL6LNPQrIU964+tJCPS/oUZjF6jZ9XG1yKG3MrvhRL6Up0NV9824QhQ7jrt5U4Q4couU8sFUL3I9OscQaDcQRZE5/qQLul6ZvZK0IwCgbeteuS8rT6UtmAgFzAcvYZXdUIbPvGG+cy87HaUhXV8+yQRJYcJ+EWsD/Qffw6SV+fmtKvRxI/7S0XNeEoqPLRTdIeEQcdqApLSAbgdOSJ2u4K2ggrjKoz2vdJDfueVxHkXDfFgs9lRDFlAvkuCQgL/61dIEEhBZJEQuO0TeKl4GGXFmhXuVKjvf//isSBDJcj2n5O2oPw2RJ4S8ijUzLx8VdCpNiYa2dTJfaJx8T+VYsPe7YNTtMPBQ0gWlT09ZAjbd5XmZUwZ+TqP64/qyHgDn8Ei+vGmXIuTXUhrC2PpHeWvdahLTHEjjCKhuqoyzvu04q27PPWtQSft6xqNTkFUjOGRTOdHz/tuOMhpwG3OgN9I2h5iJrLJBPWWSNlOyaaIK1RDFQYj6zQL8tBA2afran55tYrI21/W0r2h+XCsKL3JgQQk1oYE3ehAYFdV/OW8w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28afeac-6a85-422d-bbbb-08db76ec0217
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:53:42.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ul7uKelJHu8MV19h9/+mrvtF28Ywb6u9sZgwUcL9gs6ZzRHgkcHY2i3C15VlPUbT+5jDB1JdwhbLLEqHfedjwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270084
X-Proofpoint-GUID: OeirntYT-bt2blc2DmjKKn8T186hfvDd
X-Proofpoint-ORIG-GUID: OeirntYT-bt2blc2DmjKKn8T186hfvDd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In cmd_inspect_dump_super(), at the label 'out', nothing much happens
other than returning ret.

At the goto statement to the label, in the for loop, we perform close(fd).
However, moving the close(fd) to 'out' as well is not a good idea because
close(fd) doesn't make sense outside the for loop.

Instead, simply return 1 instead of ret=1 and then returning it. Drop both
the 'out' label and ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect-dump-super.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 4529b2308d7e..f32c67fd5c4d 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -84,7 +84,6 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 	char *filename;
 	int fd = -1;
 	int i;
-	int ret = 0;
 	u64 arg;
 	u64 sb_bytenr = btrfs_sb_offset(0);
 
@@ -156,8 +155,7 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 		fd = open(filename, O_RDONLY);
 		if (fd < 0) {
 			error("cannot open %s: %m", filename);
-			ret = 1;
-			goto out;
+			return 1;
 		}
 
 		if (all) {
@@ -168,8 +166,7 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 				if (load_and_dump_sb(filename, fd,
 						sb_bytenr, full, force)) {
 					close(fd);
-					ret = 1;
-					goto out;
+					return 1;
 				}
 
 				putchar('\n');
@@ -177,15 +174,13 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 		} else {
 			if (load_and_dump_sb(filename, fd, sb_bytenr, full, force)) {
 				close(fd);
-				ret = 1;
-				goto out;
+				return 1;
 			}
 			putchar('\n');
 		}
 		close(fd);
 	}
 
-out:
-	return ret;
+	return 0;
 }
 DEFINE_SIMPLE_COMMAND(inspect_dump_super, "dump-super");
-- 
2.39.3

