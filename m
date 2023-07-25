Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD11760D93
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 10:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjGYIt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 04:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjGYItI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 04:49:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3B3269D
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 01:46:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7obYg017250
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=6F6HCPv/WWZaP02yMfWSEm4gKb58+gIy1yjYP+8NFGo=;
 b=25vJVUlj30+byU3oPDV0HjH7RdFeEJl68/zavL3r62uNMs7lJqJgl1o5p+w88Z29xxDC
 totxKuLQlzfGIclXyYpF9O+8fYckDRyauCQcbx/E32aFkznmQr86m7atqSdzYHGEbWu1
 uR2sLYigsiFA2P/EuxuxPNLOyAy8mcEDMX4Vrl3xJWSX7wj1+l+glG94uYiRW4TYpJA2
 7/8a0BWsZH93r8oWsV6Dd38ttCe+YzTMvD8ZfN2iF0THBWJfmKoaESzD9uqKanL0kF1U
 yEPyNYKKY978gXfOLMEdofSalm0fGTkpJ9cKGMQW2r/H8KOiTLQ9TIubZeTtgbR50o5U ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c4n2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:46:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36P8Ql95028975
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:46:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4qgae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:46:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol2C9kFYmBo3nUxwAi9uJa85M13jacaBd2ocvl7qTk0Nchr6pelGENVyhIj9nd2M4W+sTRCpTtQDi/kbYY9mQSZds7pyaKLNuo3WnJei77ZUxPMshUfPTg1rcICFRm2laxstscEp/EmApERyMUPJKAdePZiy0Xz+9fYdwsnA+JDzjYipNxqhN+RKqBEdu8atITQ7RAzkOiu4gvtVjZ3r6eG55+rRmkM6Q+TsZi+LKMCkZFwg2Z8GVx3u1ZwrfrY8tWsT5bIXdQdxS7H4wfkV7ugO+i4oWSqlRblCaRMCdvGCCSrQIOkce2mulRiFmeWrwhk/6QZCBzaEoBL5vOJ1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F6HCPv/WWZaP02yMfWSEm4gKb58+gIy1yjYP+8NFGo=;
 b=CK1Ju7JK60RVxb9CODFq4WFZalPfUW3xpUmRY5kqep4vmip2ntEbvLxdWzfW7rIZbBZpvAPmpMPl3tH5verbqf8WF/64IwDdfAxvRgdjDStP0Z9skWsJOrgexmDqH7K47d8MUwmE6N0g3gMTNvumMcjJI527b81wl+Gyq4yd1rIzaBPXl4QqxMFj8XH0xVw3re0MxHyG+gZxeqJfGOwyxTWLYfN9QLUFaUN3AtIA3mMOQ936wtTUpGtpJJlyHiYuvvtTkWaWxI+CXATt6mZzA6jEMn1A6wndCqM3q62WoS6yXh6arNrvrxudF1NbxGAhJ8by+DCSs0ZpXRlM5UJo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F6HCPv/WWZaP02yMfWSEm4gKb58+gIy1yjYP+8NFGo=;
 b=pJwBPL03tpmSjqpmm3Wp0E9wKCalyK3avzIFFVQNxvD7Ex3RrKchj57fbPACy/zOSGK7pKctXT2Lvl/j95Sjar2zzpX35Q9fbs/2sQiD0TYFJRCxJxG+Z/nvtJZKGG5nwl1EJcDCi8KzyHpXt6yuOiWp9bci9uL6cELmekcEy6A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 08:46:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 08:46:07 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: update more items to .gitignore
Date:   Tue, 25 Jul 2023 16:45:55 +0800
Message-Id: <fd419c2ceaa48c6cf2c14dc9841eed42217002d0.1690274546.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e918b3-59d4-4beb-98a4-08db8ceb96bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQu5gCV7mqiBlt94xRhVN/dU/qrH2DydzG1/Rgu99uAdFKxtsT86fnmtH9DjOdy9BEf4oqKs+qfVtYRCJTX3DfvtLtw94fVVxcLITZy9RxbAbK/P1z43SfOLt/FW2VZq3uYcxXas82PSqR7FkYl68ro8WtpEb4rDYLS0s3pGlzg9MXEMGB9RzC3HzeA4zZpleldi+XlcnwVD+A1vN2kjoJg10jnHc4tSwO3ExVSxovUpKfzyXPDnSAW6EV9cJ/jyoOoCMADVaOtMcSSw3AJ8SkzvASqJXcqINf4R3flHRgA5MQeMSz4rNiOAWhWYeUapBU3a6qFkVNEyX6v85W4hxCnuzfPCaKt16Updr89SVeSCLlcUprLIhLbRvPf3yuaPiY2SdEgdeGf+Srzj6l39/10oGj/zWocDmp3iUrHEzDm3sOl4yImKynYFwIdBnEBSre3K09AEN+5btZnVOPkCIjsPCT85NLfqQZPUPNxHkB4rEXtSQ7IMwewoxPKZqR12oDfo5sksBt0oqvIkesi7+bKR9Y40wjMCC7gWSbAVoC5OtSdINVrMbodF8VtzG7jBV3I8bXTlojOZwCwNCCw3JS48lyi4OhHDtdlQZ3o1kTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(186003)(26005)(6506007)(4744005)(2906002)(86362001)(6916009)(36756003)(8936002)(8676002)(478600001)(6486002)(6666004)(6512007)(38100700002)(41300700001)(5660300002)(66556008)(316002)(66476007)(44832011)(66946007)(2616005)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZAFUhebKjWIpIZhE8xq49zHSvAZvtC7e7qZRnA18RQ2dyT1weWCREjIdK6Fk?=
 =?us-ascii?Q?PSRnvdz5WSwjElTdQsOgnLH5iIE4aZRdNslUMUy9AFlrvuXtauIJ7fYw8Ugq?=
 =?us-ascii?Q?Vo1sfie9L3dmRyC8HBKfbnxB5tuUNubzPdJBvWITX7WaK7hRrDXlipVmIIYo?=
 =?us-ascii?Q?Zvoxsb8iPl+gJ6oavsxQJCioWW/4jjgdG4b6JlK76X3tyBEWqfyJe1sVxHIN?=
 =?us-ascii?Q?4DAcgJESf3HLJm/RvdiWhKYy7/Qsd1dUexDVD2cWaEFE2DjsoVRT43Q65Aws?=
 =?us-ascii?Q?cJTQj9xHqQXwBPusld4Hk53AMU50FK+Fk/r3OQ4IAiyo9XK+cSWIWjdHMmPh?=
 =?us-ascii?Q?UDAoglXeBZrRywojcPUwpi4g1bZtFEWl20EoTQzy8wgCs1Hyd0zZlJjREhgO?=
 =?us-ascii?Q?5q/dYQkxMyABB8PejBeYQ1PCbn/9gGakoUl10bGqTuN7kTemEI/Nfji3Qej0?=
 =?us-ascii?Q?szEwA32UcUZlFPAOM9SObPYky3Ys/go26kMQxFehPh7JNjuok+mXX3APBvC5?=
 =?us-ascii?Q?RVThr2lX71T1yVl3HuczxQfU4n96kO8IL5feVrr5u/Nc+nhTK8r4/fAL5bLx?=
 =?us-ascii?Q?w/ebxi+k436AVxCPRKopgsy4r+F9iz2n/4onVtw9lKancgpTPhhBEKMSw7Lu?=
 =?us-ascii?Q?UefndTlHKqm7w5KkDk8HkQUHlOtXTbWF16/SsUwIqDYegAvQ3AE18wXEuc7l?=
 =?us-ascii?Q?HQ2764QGrYQ24LTutEdViBdvq4DYQ3KnDtzpioA28VFsvUkgbqJ9uqdNE0YX?=
 =?us-ascii?Q?LhCSasHrwLbhRU/qt2+TjATFgE+OPdZXD3EilE71ek0/QZAyLMHARFcK+kSL?=
 =?us-ascii?Q?czdKN9JME0EsqF4ZR1JsJslgE1U/rA7zzZ8dEZFAQUG+Lzf8/9uTUWY3X9H6?=
 =?us-ascii?Q?CMmC3aOz7sy4CmVQu66pQZrA0w1VAFLxGZ1bTzrEFBWjNjqVS6wOA9JYTCsG?=
 =?us-ascii?Q?M9bBJ8V9/YtSDQWAMnheQaoB/giI/GRreMllzVW96eau6vx7MmQW96RiNSxN?=
 =?us-ascii?Q?/dXJmpnASzDq6dNw/PQGW4ltFWFeaF8zodWT5K/WREQyzDRdp/RLkr09XqJ7?=
 =?us-ascii?Q?lhjM67nLLwh89by44Ev/630h5nOYV5tOdRIMptZj3suORK6s9z2nu3u4kzti?=
 =?us-ascii?Q?FtkwWR4e6LCaPl/Gg2esPzE8PoJDw5zWYO804LPwC06t7rrMGI80DdxW0AEd?=
 =?us-ascii?Q?7kRC8pODsl3JRdvK9H+mmOyZv5juFJSY4c719Pq90MpqgK1GDEo0ww/nFvPe?=
 =?us-ascii?Q?B+K9N2suTOWo9ckTNF75FabwlO4WZjIgCExCqy+baS6brKtkrq1CzD94aXxh?=
 =?us-ascii?Q?mreBL6cGBHoH4BicYKa+AmERsEt/xChz1xSsTdPSD2zsFft+PQ3zAPpp5tZr?=
 =?us-ascii?Q?Dq/b4IWj8IDkuh3PJk7bItbr0Yh9NXIm3j6obZOCEfOztGO4BUjnhANUHMol?=
 =?us-ascii?Q?yHeHF3n48z4Azbhgdn5DafuiXX14VEGiXZnMUSTjFzYLNrthtGeyneOftKMf?=
 =?us-ascii?Q?E26CoaM/4jQqx9515L14Razu3Hp/3kM3Q1GT7cmcOz8HGzESw1BOrIs3VVFu?=
 =?us-ascii?Q?Jj7RXRqzclbVKZmngDX/eawVJTYb591kXRNmG8m4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BsZ/Esa/dn8tGytQvLztQ9BjJzLvBTOxJLmEQxMB9xBRDbnQ99Tj3APJ2Y/XBje2VsiRL0wjYob6TAaRWGF3HCfF+6F8BiXxATyDY5dIsCA8QNZ+LK3Y0geOs8pH6p6681E9Rx/8WZaHX2tMh3shtJjraSm6F0f5gGxeH61/huMQIRVPi3hCRuTy+Q72i/wUeuVEcy12Qt+mTSmCaMV+8OuqAhqRyUt4QLowVC+kYDtXSjkJLi8CBOnXB23iX1URI5s1LSImkidtFdCB7uHuzVf9W5bs96MD8yuUn0CgQJYXMFRTaZt+pUSJK6vnq+5rHwXo9vY/gGXejiM8feGZLPO0P8GW9HnXu4njdVUIvW6/qlEPvYctvgDVaYQHkqthPwHpqP9VXJ5Yms4lc2rGq5XaypQLPttVqkdaOtQuQepJK2KUQPDfJiNZiHs0N1PvAJt08Ow4Qk9YteEyhqAVTRoxBhjJ8wJIkocE2xtwwbmnvst6RShZzttbk9ICb7eS4ixcVoO7h8ZF8UxfBdCtlhyxaUoGQngZ1+T8IadsliC3zfkJ3Rdh2Tbjj7f5XGitaqeaiHE+T/C889Gcpyzrj3pkiZsnLj9bIvNiCtCgeF8eEgzDBz7XHCiq22RnzsljTbpjACEeAbngYqtOkg1mt22ALOn/DyDsR6dI8iYhfG/5c3TilZjErdiricrIu2OdpTeFmsYtWcXTSgSgPT6+7iQ/X73VhEwrzRmbOFKoDIJAKECQaaDby5L6o/BDdlXBsx1M2y/w/EAufvoC0HYupw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e918b3-59d4-4beb-98a4-08db8ceb96bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 08:46:07.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlEt6YRA+WJ/c5Hy1KUVEutr1d2t3lKMc8Sqpcccx4CZ4zoVdNAklid2rULyAFjTv9Fllw50pvaLgwSJKPYRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250077
X-Proofpoint-ORIG-GUID: 4JDV8NPQmrvLEOm6uAKLE4Lkcj-0g8Ts
X-Proofpoint-GUID: 4JDV8NPQmrvLEOm6uAKLE4Lkcj-0g8Ts
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We still have some files after cleanup that Git identifies. Add them to
the .gitignore to ignore them.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index 38290256545e..aa78b405394c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -38,6 +38,7 @@
 
 /libbtrfsutil/libbtrfsutil.pc
 
+/fsstress
 /fssum
 /testsuite-id
 /tests/*-tests-results.txt
@@ -57,6 +58,9 @@
 /include/config.h
 /include/config.h.in
 /include/config.h.in~
+/config/config.guess
+/config/config.sub
+/config/install-sh
 /config.log
 /config.status
 /configure
-- 
2.31.1

