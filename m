Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0487389F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjFUPmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 11:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjFUPmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 11:42:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD0F10FF
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 08:42:02 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDApRK030131
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uGknFpRu3PgU1GfcWIEzGao3Rc673XVno/Osze7xuf8=;
 b=nCeb+F7McZCApKzTEdw6lJOlY8lxIld3ZvOroDXH4fbA5EuihYkto1KdDMtUpYNAiSWb
 PhL/cKt2G2YzhDNRgXrBi0sUoE1eq6WQ7S8QFJFaGEBWdqIUR6s28xPGT1PQ+opysVrx
 cH1ErGhU4FrZs8t2s+MeKUO/oAIwnu/+80IoFn2JMjs7bFSFQFIgTQFl2nQNf5Vt1uol
 qWcC4SMI36gStTMooQmVmVBeMy5hM+6sClyiZVVclrgFhv+px3SXrqdlQbOmFzhHh0Yz
 7st1kxMIq8L6C2yz0u563A74b48dQ+G4Mx2VCoIDaS577XaRvCrMvaBb3kYjnBma0zlt Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbqurs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LEnMmV038595
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939671ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2XEuTI8b1WDubVb2hduwx3NUNO3yAGxGJLdrPvFYZs/avcAGoazWBwcTFnIUOKUmB34Bsft1HVfjcBKIkrkxm+7Ee7sIDHGPnVtNYQ20mu0PzLnnZ1T1FdVRMhtzH1g4mC4jxLOqREtJ2OOQbXYQaQv/hi8RORHbda1R9y0nS/Kdx0l5JaC1m1Nm9joXDc+N/PXJAbpofGxabSUas6l0hB0A35Rf6Ukg4IGty/sSup5H17ygtKJ8rEmUR+4wMxlrA4duyaADpEeat3YNXwYs+I2qfxf7QzlNHG6hYNrEFk8jpIJPOXZHZRbkllq0ISn2QRrmop//cMzQJBcNiP4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGknFpRu3PgU1GfcWIEzGao3Rc673XVno/Osze7xuf8=;
 b=frWdmR3w6Ynoe/jLGbv0A2oo5P843i4Bwo+h53NpBl0HocOc0ChhdmR4xQyLHbrEMTninrWBijzfKO/MrcTvn832LutQDsNJfThT5RZh+EwzXU2lRXVnjeJ1Y/41TVkugEGjBLB+KW2/yu8t/33jQKhtdaeKupOrHsGYEhJehukIfIvOa6rBBCRk3v8FAn49V3QAbYuWlhS6Fr7ajvV9/r6xHk0tQeuoKs4d5mt+JdRchSz1nMzMOygcwYTfd9OK9ouhX4RUrQ7XHt8aR1MG4pfYWY0wXJnywlkg+LGW0zpzyKjt7zrJPF1U5Bw5iE/2YxyYrvYXfFrFDNPcI2frHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGknFpRu3PgU1GfcWIEzGao3Rc673XVno/Osze7xuf8=;
 b=UWWWe/rEaj9WSOvkiuy3chvysnAlLvT5YxLoktKzMgAxdx2Budzsx6yT6v2WlsbuGdLAQ7yAQq01DqbGeJV5ySRUE8yH0ptUST0XdxDRqskM0Dy4etahNj3H0BEz6eYAy0cr4gnSuIu90Qcf3J+rrWp2e/I7ArJUnp7GXuj4taw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5225.namprd10.prod.outlook.com (2603:10b6:610:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 21 Jun
 2023 15:41:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 15:41:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: dump-super: fix dump-super on aarch64
Date:   Wed, 21 Jun 2023 23:41:18 +0800
Message-Id: <cover.1687361649.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea070e5-bad5-4fa5-dc62-08db726dfa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wly/t10plde36/8LOTzYjwGH9hG5L/f6p5iAwLmKG/t1yLROnNsiMMenhh+Ybnv/KZqJI2gnnuvTvXXx1ZwXbKVRnXHcwgimrgdZjbSJWaKKM6uPmrTe4AxXMMDd8jqsp1+poBNXFpoovkrl/3f5CtDQ8C85A90VIorAT0fZmk4uSfDa5WmP/CGbfcWV/IP3VUyLoiLsnB9VWU6Dkcv6PopAxYi/KSG8MPyWv85eHcLkNLOhEKBCfuEelM/BIAB8P4spW0mIQG60ECZ3xOCb3XJ4zAvxqDhV3uBgFbiMiQTWBJ7pNrVOazbYGpDw/kCmHNkGGR+aDblLTOEacEVIPBN1+NP7+Tr7fqJw7wn68KKB8eRQKa/CAcouBPyN0rFQ9W9OJokezrgCmHBad9fEKY/ZPzgRT3oldx6p12XiDdA0yNhkoz9mdwvwopc+T5XZf8Q7Tnup49By469bQ3SV/Wiesrp61kWKZGwcMrPi0prcsSfO9nbRPEztfibT7oFz6G4M7SKmk9jWMxfNIVDoC4oayKUbtYUFUf+S5cxliNQ9kwRBAa/c7O2Io7A5339w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(478600001)(66556008)(66476007)(6916009)(66946007)(6666004)(36756003)(316002)(86362001)(83380400001)(6512007)(6506007)(26005)(186003)(2616005)(6486002)(38100700002)(8936002)(8676002)(41300700001)(2906002)(4744005)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7zkOuHHBRmz+qpDBqjjVal8GUxWK7Ejs/VoxW8AxF2HAMxuiVjgxPX6OYZpC?=
 =?us-ascii?Q?SzpCTLlx8h1GNQ4Sw/kSJxPJq5QAiqQ/8heZaNX9he37aKGiHlv/zndztnP8?=
 =?us-ascii?Q?lPg3msY0piuMiqhLBQqAa5EezizF+thyhOFY6Rs3CLyhoG2bLvp+AoRxSZ8p?=
 =?us-ascii?Q?xefGrfgq9u9P2kerMUeZJVX59gyIBvIHm0dvCBJSAv+mcTV/3oWOQtZzNjKk?=
 =?us-ascii?Q?tshhGkniMSxxMabIQFftTxJEebc4ELLFLJBpzbkSYR7Ab+LnD3O6e6ILnOxc?=
 =?us-ascii?Q?xS86+ApR0tHzOwwF9zVuJVIT6zQGNY+3QWV2k5m/3iBoOi8Ci67efFFuOgkr?=
 =?us-ascii?Q?LFAF8bxn4VSAPyM0p80AgrnhZWF8ioE7j0sWgxHHA9eSOh03T352g/gdd5Ok?=
 =?us-ascii?Q?uhaxHRbQ9ptw5FykzHatlYZzDYwwz17hW/pSlA88P5YjgYv5NDMUepEQ7VxU?=
 =?us-ascii?Q?stJRNerWJ72pjXCr6cFwLVyh2ctZZuEVcK13nfpF2N1NPWm3DaXGrK3qo5Ns?=
 =?us-ascii?Q?UY1m/7+O+OlrZwfSUpQ/9OsaY4nXhFVUKgdD0UDIYuziF+F2frGCclVr2pM8?=
 =?us-ascii?Q?GK7JLgFpkdrcuARc1FiAzJMeUuWHoiTpJYfzVItsSwm/4mSVVYPXUhNKsGyK?=
 =?us-ascii?Q?b/b8JNX4ol+WqkLhjaGTLmfCPfb993hn1DNimRtE4DHRhsSOwPi4/ZLs4DAC?=
 =?us-ascii?Q?MXEO6NdxaOyBYTOkk/U/4yjkzSS3XdREghr/kc4lfNIXOLBNrZ0bjnkxMtrP?=
 =?us-ascii?Q?Jld42HivjOfsiMyC/j8F5vcnNVMUKT2Vr/7MoVDtHSXnQYq2Pw4zPufuhVN2?=
 =?us-ascii?Q?XXrp32K9ut1Ikk+DrNf8kwwFcbFEX/dZqOOYXXad5PpJyROmj0ZuV2jVis5t?=
 =?us-ascii?Q?aW/Lul1YxvZjawPs2mtUiG88fVrlkZluy6nbF2QRI2Zl7Qt4fu4lo7XAv22f?=
 =?us-ascii?Q?96dD++OV5pivEVu02pfkdv7E5ztwxBlzFeBYumThzzJD7BBa8w/A2II5Mk0w?=
 =?us-ascii?Q?EPvpXHGmnfLG91xxCp1a0rodD5H1k3pPeSe1GC35Uqti1J98IuDvL9a0NWMD?=
 =?us-ascii?Q?FIDV+vKzyXuoqsApgOQJMQk3wwo1QvqoCQhbZcD8xILSWTtjnr1pmOvc5qvN?=
 =?us-ascii?Q?B55I9wSwQZPB8zQK1BSEdV9vfpK94YbOrp7+gi4X1mOEEPBWO9wDsYXHAo/Y?=
 =?us-ascii?Q?ui1vwfoUYTy9Da/0N+hZg2fHbZ0A/jf0S1ODJ1GGreBlON8HmpGK613HQdtQ?=
 =?us-ascii?Q?7tS6Z48M9nk448nJzLmG1HerfbD/pz3e5BkhmcZe+pIgoYA1Wrnjy/xLaNpj?=
 =?us-ascii?Q?Q6LGx/1pUEA44o8i0IhkufjVZ0UEkZ0DGmhZkqa5R8KtL9P3zngj13stAak6?=
 =?us-ascii?Q?f6x3l6iXmAcdz2FmPIzClaJ48hHuhZTUs3BwziXCrZuKRoMn3hYT0r4xxTWp?=
 =?us-ascii?Q?uVbnI49T+j/ZlpvDRLjyOkyVYbQCURy2RgYRO4aLfGRfLoRR+y2VLzbBkC31?=
 =?us-ascii?Q?n2Pbpt76rhzi47+G3iS7zS854JwqzvqFK7uCDWBERiFiALxS2oF/YvwyhImX?=
 =?us-ascii?Q?hwc4vITJ2GxzkHb+ou25jG+MGUOHyPAtGYBLLbQE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K/3o9KqLw6ByJBkA96xrWVR2DiXp+SLRXUtP2UdXHxmhezCATRo5Ug/GeCyNigRDtxGDwK6vCSTTBPjMlsfOB3fRYEJTdA9CjPSvmp0ARsSOjSx3ktDd++2NybntAPo0mdDcypMmXkIReapM1qG/++7UTx7OrCx2pQKlD4LmKIPM762SM1q66GrwO6VbrqHaimhINNHBwvAyFHUnqdcaW5/fs1tGYDDlsIWH9ZMKjyD6X/tLSs12m/R7XCbIfFSCRTCzm94iFHSKxykbeqtbvhg/bow6V4LF6RkW3yhTaL0c7Hf91vZixWdcHoE4nYgmLkjFre/bM/QuAK86Tf87fkU6Qcl6ra7xYlscdIk1DHZD18L8F8mwF2caln3d+z13KgiIQHd71mn1QUpz09j7RB2lFMS4f4CZamB9U4vyT+89uFJRNfbpGczKU1gRubl4wI7I5O2JofNO8w+JqbXh6aMBe3QmWSQjhoAA/o97I37V3Db/Y+2HDFgH0V4lvRqNfmfqdNq74DYyn8VahZzu9jSA6jz6Sbb5oLO3MDlmc9MHq6Rg1GogjaVeHhWOBuSHxtV/kmdN9Ei+rGQBJz1UGwzFmBPDJXIZwJUb4ORq+oyVCBEQCq+Q1Gmf4ZzrZh3FPktEnDUZ5/uhLtPKR5yga7DXP5JUIMvXVsWUKx9xxsuYW2aBXf7wrtRNgoy3pod1S2rkCqyOcsACiL5u4JosUHB1b5v5NiUrIhPo5S4S+yZG2Hf+kSoKCV0G3m2aJIYbuK/y4cJxIe8pEE2u1YZyww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea070e5-bad5-4fa5-dc62-08db726dfa9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:41:28.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r56wdNuOos85kGwSv75w81RY3JAllhggXH+uIMhHZFC/I+uEcEWRtNPmaSoquZ6GDe59Xd+7HgJuqrsKZuGxpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=965 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210132
X-Proofpoint-ORIG-GUID: ZusAcjlfm_qG4LHpyYOB_so_SYwHgIj-
X-Proofpoint-GUID: ZusAcjlfm_qG4LHpyYOB_so_SYwHgIj-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The command "btrfs inspect dump-super -a" is failing on aarch64 systems.
The following set of patches resolves the issue. Patch 1/2 is enhancing
the error log it helped debug the issue. Patch 2/2 fixes the underlying
issue.

Anand Jain (2):
  btrfs-progs: dump-super: improve error log
  btrfs-progs: dump-super: fix read beyond device size

 cmds/inspect-dump-super.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.31.1

