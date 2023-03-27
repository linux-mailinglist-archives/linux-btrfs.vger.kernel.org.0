Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FC56CA091
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjC0Jyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjC0Jyl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 05:54:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC94C15
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 02:54:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R9nDR0011081
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=VQNqkb5yLbBMOdXK7+/jokwj+D1qW76d+kpT+ypIegI=;
 b=12C63Am9iO5qwRrXBgsU0xmm1Y8L8X22xFda+B1dkCr2KHucP5V4DnTsRTutw6SAMEsy
 Ytc4gcCqQOUH+UhHR0G9ivo8c7Nk194iXtZIKc56Am6dBk4uMZ2fmlUOgZMwzbVduIan
 gwlWhjZDiKf9bhv0V7zHsMJVNbi+M0L3AVtWYvQBQX6MIQqtdjcibEAg4MPB9krqsLgT
 BlRMW2L8m8VVVL7X/Q6TF8A1WGHtLixo6vuzTeMNzWjh5W9vt0MJt6yfOt4Kx3AZFLVo
 q7/b6qLJ222+yfvjsYetQRaOVE43eF5MC/T3L2XWnMGtY/QMzDUcqW2p/aR6hY0oGq8P BQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk8ug00hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R80wEr009240
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdb0txj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QerjDzRtRmIEwXWKMFFoXTaPJxXcKd52fMFtYbPprpCRtOZakJx3zDfwIt9vkQFO5FUzeRvgB6kjwnwOf6umYLY/gGk6j+/Gv9yzd5G+BAa0RD935AABBbheyHqs5nRJpKNUWq1e8LxdZwn/a3PIM5/pklgz/3VpDOs7IdhED157hGeKvu21NtSMnJehthRq6B8YNsLEtfrWL/ij4UwQC/Nv1rf3JZvf8EL+AyPQ+f4a4ibICxPdxU1eVj4QIyjupsaiKeKqXC4/v0wnwqyPdl7LLaUz4uG8dH5VC369ohxwhO1/fptO53WPr7qunKqZ5gjJwuBQE2+CyS5LxijM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQNqkb5yLbBMOdXK7+/jokwj+D1qW76d+kpT+ypIegI=;
 b=YXEWYkdWoOfzbVGkMmxisLZEQCOOWd/wLWI/kCvqLfa818jnZLdit8dtH5xXbAEqkbTD+V+ejmsxSGDzsSjCfwgTSFINcmW5u2MojY1xNbZd2UYQHuMLK762unBHTmcRjT5DrrKbBMB4hVlHqYKpTaew3JwknSsZdzqLGd4YIexz8GONkBtAKE1jGx4JPLL6hHCwZ20G3lUaJ690u7PzjrF50e7agUV7adCLZm4R6deRJWfdexC4jXL4mgbzaiah/LfyhB7VsTZgpbT0W81k9GBQfzi+m8vWJzLXrp0idksHVHzmc1MZaxjmeQ6oz3a+q1WWQ7+ygQHjGF/qo86jdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQNqkb5yLbBMOdXK7+/jokwj+D1qW76d+kpT+ypIegI=;
 b=oLcIiiQB46W+1RNHt6S+g9LW87qSELSR5KTlC0EzL0WbCSIcoWucl/YbBFXbMGm3vJ+2m296P0YSoRHphSdHiWY1IfUEU6RLGGCk1VjuYh3et5n6NBE1/ZcfRzFaiUWgtxstpIao+wJ8xZoOXV/T5zSjOPlb35Owb+Kk2bQcwJY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5981.namprd10.prod.outlook.com (2603:10b6:208:3cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 09:54:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 09:54:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4/4] btrfs: use test_and_clear_bit() in wait_dev_flush()
Date:   Mon, 27 Mar 2023 17:53:10 +0800
Message-Id: <7baf74b071f9d9002d2543cfc4f86bd3ddf7127f.1679910088.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679910087.git.anand.jain@oracle.com>
References: <cover.1679910087.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:403:a::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 245ea99b-9a7c-4158-5640-08db2ea944d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EH3AdrDRb1CVzsr2l5peAGe+5p4gpD+BTKf2nWorBaSBOae8allMUByAYZTwYzcHdVvhFSgIdX2ntS9cZkUcIoSO6CxVn2ggU197MQ4g4vjXJKy0wA5fx2pl6dGqap2TBahC6VH5mABccPEeQXPqJnJxd2xClBtXgpEj+FD07iYpp1iB6zjhaSEj8Obbs/su/ufapKgcYeI/DgLtOZ7bJQrpWVVeKIoGHVNq+0zjq+wtwydJiFBon+FGsEZ50bEyYICbo1GEFuOKf+6TzU170Y7vYPdlm7iFKsGbhvTFUwvn1LWsHM441gbPbvwnJmcs3EQxph05Zm9HPlBqSfVOnkT77bkNPkU72CO6DnnUhKaEY1dgLnLawhDEirt0iT/AG3HW2T1p+dn8cBM6ONWBLDWUY43nz/FmXLG7J0H2Ogqfu72NRP5gMYsTiQIbBVd3kSvPh5jhApv0sm/OSnJtYXeozkHPErqEwJgigcur0nmmr9Fqn69BDyF7AckelUBN4iSES7yQjIBjECZ6I6bkgS9CwvCA+GgvTn6I6JZ9oE4Vo6SrgCtf3S1sAS0b8OV4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(6486002)(478600001)(6506007)(6512007)(186003)(316002)(8936002)(6666004)(107886003)(41300700001)(5660300002)(4744005)(2616005)(44832011)(83380400001)(2906002)(4326008)(38100700002)(6916009)(66476007)(66556008)(8676002)(86362001)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rWvkGS2z/fjt+bO1Uxro1brdDi3dZTVk4LbtdF1f6byZbahZ/YXx64U9Ujpa?=
 =?us-ascii?Q?TCP1teVTFLDjWOBWVdPEPqsHQcD3eBbkjD4sw4y10IVPTf4iWy5MI8JTCsqK?=
 =?us-ascii?Q?z3ZaZejOzCWnSoTa76I265/CSHFCahh9FYKWzj/GovuT03eafaAiQKxL3HJY?=
 =?us-ascii?Q?JEuESxwVGncO4PgbnVapXxNUwOSCiuZkhRmDx7figy5krFXQ0k7mAExTgR+9?=
 =?us-ascii?Q?tX+wwDOwvSkwA0jxV7gFPJQNz7gEK1avjs3xAYroI2Kt/yCpcR2mXLb8TT9P?=
 =?us-ascii?Q?qTg9wOKgqHDMQlos13ynHILVM8GPt3KWSt4KhoZtT8HgqvmO+2aWtmz5RYJI?=
 =?us-ascii?Q?Gjpd13xTwIZ8kptt7EADbAAsVxI6sPK3SFjKKIwcTurZbfoCaTlklkCpuIQz?=
 =?us-ascii?Q?o3tTrTTeaBqT+fHFkK9aDdfLRVJUU0m9pNlBSPlabFMrlkybwmJHOQSwWWgQ?=
 =?us-ascii?Q?GhFSn75dcWaHgvtJ+6BCdpMaO+KdQxmsRtxRRTEEy28SWZoNdGGrTQfWK+8S?=
 =?us-ascii?Q?NdzMGyoc1qBrMwVRHUsBohGTTUPFS0Vlnnzxd8NJ2hdtGZOJkz+vtG6HvbOu?=
 =?us-ascii?Q?TkMsOSmmyB8McuQ2qPmP/4yo3FlGtOb7xY26VnI6cxFfBS/LusgTH+OVW2v2?=
 =?us-ascii?Q?USqys1MXvCTrj3FRmNy4pOwRcMbApeuNe9PHzwo5iwXFimTNm1c+V8G2QcT3?=
 =?us-ascii?Q?WZjEhkTeFVHOFJ64o+RMvi9e47jWOKGo1U+GmlOUfUNhrwFRjhd2deYmPJdo?=
 =?us-ascii?Q?hKnv8Hmtv/OUBLsnw4yV7Pn+3UeQCpLzDL0kTiaEJjpRaF8scUeOdDuOBSSk?=
 =?us-ascii?Q?5f/bpz/R+kK+MyD7vlzHSCq4JmSA28x4u3TZeRVRqHAEPL2QIuhWQl1jfOed?=
 =?us-ascii?Q?JndRzQfpbrC38vsg1XrG73u4KRayiyPVyvm0EnO39Ll9MNbxH0q0NyBAFZgd?=
 =?us-ascii?Q?OWwvPEsEU2+pyVMi5IMd94Pc4Ehk1j7H+Mit0Bl2JQzElGN+Scau40XA6Bl5?=
 =?us-ascii?Q?E/KW3juFbzEA2//64dltomtQiC7zd6+2hLFioJIZtU5Ue5g3CaGptrDWTKrm?=
 =?us-ascii?Q?TJWn+o8TegQmlIyrvBDyV87B0vRcv9nLTdVF0WzWWdCKUXzuPLUDRMbJdaj6?=
 =?us-ascii?Q?GF0m/Xp51MZEJGGcJmU+o2DBe8LHC0IBls/Kw4/FyB7QFyjM497HumrxLOPJ?=
 =?us-ascii?Q?oIqMJOz5lSIc3JORmA4ernH/2W+6+UX2SB8Jenz9uaY6z6/dj5E303eDvS7n?=
 =?us-ascii?Q?z2UrBPcKWtbKuHUu0EGEczBnRVsyhaG4msG+6N8TEoi8oxwDqkF/QajEY5M+?=
 =?us-ascii?Q?qbYF3ovLUzwTDcblMHBoWP/EMsaBFQa5/Wsl7QxbPpEThEG6RoQAWZ+Xs0/k?=
 =?us-ascii?Q?NxCI7lAD0JQxM/p0IDPCOw5EEcFPAsx7Il0K9MyiTFyAy6Pn9v8Re4hxir1G?=
 =?us-ascii?Q?6mX+IviKJxZyP8o5sOK1Y4LC1xYRZh4zrHmh/bHAFufOiP117lybk/eZu/rY?=
 =?us-ascii?Q?CCgH0TnugXTeaCOwIDyQKEAr64g2k8oR3HEh/lNLUIygosJZXqqPzKM86MNl?=
 =?us-ascii?Q?Nr02kI6NGxKCy1/w8druxdLFyrZQKQvDPFbtuw/SuOfN5mbMZhZzoGjAcptw?=
 =?us-ascii?Q?HRsg8aQ9k7zpiR28NhjlejA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jWW2WpJ1aXwbYAqdkt+jVwdpdaqHxGj7BIxAhReT2Ih0RVbrvD1GoyrX20l9b3xsiNr2KjkzFZeq3tAk3zZ8Qp/xsRVJP7jpiHAoIx5WcHRPXgCAAHBBiqKMjx8/d/gPePBzk03SQ9YCkfLNAkjgkKV5JAmNrP2vJMBE/NH7kfBEduklfwYMfFQCs4QOzFcf6uvehzWG3usFzUaxlragfJhmZqBNyr/qdg0OnlTTMjBHMjFsBQnXuJEBGIu54iCNi/jvgsiR6v06S5fW0t9v3mOB7cu1MffYJv9YZDwROfT+Zj+EsTOx/90maA3EQdd9i/Dad0taY/aNBNR0wtSmOGzhignHmLVN++Y+GfYAxYDXmn7VVUbtQMkRbj2G9eLS8g7nbEOn0V0JPqNU8SfmgK9JF4h7F9fBnCEAr4LqJnTOkOwXy7GU/E88h7iGZvCHlO/KpDmT8dR5Q3FZXL0Z57aI7xhvyUONnn2MjAAjVvFs/WOZz4v4KlNKZTi/oD+296hfRQB736CpacVS86WHbHweCK0PNFnJLY2QrEOtNSVx2CAJ+wPC5yO+gkhJ4j28SqxdmZu0A8wpojSWx+G6q54hOg1PwQusFLwnbO8XbHSpM5BDZXP5lyolvct/ys+M0RJLkQzbDAKui8UyePvsSizC34qCU0b5fEenOeFIU69xU8Cz7znMLXwQiWjUaM9IYkSVKWtu7Y+e3sh8d5uQ55++QmEhvwd78vVjCtZkncHq6GvNLfRJSGleo+sZDMoZEutJz/USs7gVlLXQArOi+w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245ea99b-9a7c-4158-5640-08db2ea944d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 09:54:34.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dy3gyCfTiWYXglY397u8YOYC1kWjDL8PPRZB3o+jd9T8eEJyFp9htllRyY9kQgWD52evdzJBT4gV5TecE7KSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270080
X-Proofpoint-ORIG-GUID: i2CNqcmufZZCQCUsUUX7hQxNXpyNDhlM
X-Proofpoint-GUID: i2CNqcmufZZCQCUsUUX7hQxNXpyNDhlM
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function wait_dev_flush() tests for the BTRFS_DEV_STATE_FLUSH_SENT
bit and then clears it separately. Instead, use test_and_clear_bit().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 040142f2e76c..1f9e2a2a8267 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4108,10 +4108,9 @@ static bool wait_dev_flush(struct btrfs_device *device)
 {
 	struct bio *bio = &device->flush_bio;
 
-	if (!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state))
+	if (!test_and_clear_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state))
 		return true;
 
-	clear_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
 	wait_for_completion_io(&device->flush_wait);
 
 	if (bio->bi_status) {
-- 
2.39.2

