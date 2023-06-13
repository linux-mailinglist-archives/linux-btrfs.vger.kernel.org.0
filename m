Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5572DF61
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbjFMK14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbjFMK11 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:27:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C996173F
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:27:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65XTi028790;
        Tue, 13 Jun 2023 10:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tQoUgU10NfXxtTmRfy17b1vMg23I/Iuw1Sazxxo3rPk=;
 b=02GxCLbIAZvfsXIVNwyHm5cS+EVBFZEbpRzIb3YXPg3wJvc8AlMVCds812ubr7F9uVsN
 Cb0W6mBfYDtnhyfq2EBFFqv4/BFI7+6MwgiAFDoqn1wlDussY8bpazUDSVHW2bE8GLge
 aEXN68RkJOZ4trsiom1pSALYcATitwY8M0QCRg6AOrVxOCMCz7eARzor7cdx2xe7x9FV
 b55rwXdPSMQ19fwZUD1QAGvu+XwA2iw8y7iKwlpsAhtNtqosA/1biqL2mWcMmkg+A01L
 1GZlPcAxiH4lHlqJevQPyfT/evEVCIRQo2aS+NZByTmYsJRsyFzxMckERQ2VPbfiBp1M rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdmua6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 10:27:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DA5f32008927;
        Tue, 13 Jun 2023 10:27:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm47v2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 10:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmDaLtzJfnSFCmIo2AtM6t6V3oGoWTW+GQLpXHtHGbs6DroPhyUgZf36w1IYZOzrloyuiFiucV4MnrTRMIpNV8k+0Rluax8ytvsw6kuFEPy4R+yJjiCD/RHWx4MMdmdLEAxqCH6oFHEvTr5rNzT/KVoLd3/DuI0vhYxI9b+eOKtUmA9btnTS3scGVV0K6fcac5Kb5UmO1GwS6uGfdi2TbjlOece0SupzIybSeAh7lXMNP16+nbALFPiplN2geEXktqX5n7JzkIW6HyoMZ+cky9IBGsJ30eHXljShIsRu2pgUp6oO6GljSU1IIpd59WPJYTib8vcnCjXjHr3hZfrWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQoUgU10NfXxtTmRfy17b1vMg23I/Iuw1Sazxxo3rPk=;
 b=bPmlMSNC9MxDIQnRNJnfHc1uNsP9EMx3RXXPXUbY5p6oCDD6uHTV9/WA9CwfWWjYOB3B9L/IndfBpnotCIP2jR28+NbCLJ73WiKJuRg5uDHnQOlVrphbZqkVc6mr6nObJuva2AADbTpod2MHVOUmi+CAFB5HS8yaiSybFs9yD42/zsx88x7Db0eaV1DTKZARyKNa8whDjQ0sJFh5a+fu3EbsAnJvzLje3Bt0Nt9lBy8UjyEMHjzr9A5fDPV6J3BZgtby3QkKx87sKI4ppPh5rU+IO0EedKkP7n7Rv/NLTOqG/LeuM7miVr88JZgwhhv6dykCvSqdnln7frZJXrxvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQoUgU10NfXxtTmRfy17b1vMg23I/Iuw1Sazxxo3rPk=;
 b=Exrdzd55QZB7+ZErYP1mq7bZ40oDRv37RGMs3vq8pR1HiaIxZgvEvFBikSzPfYa4d+SAtFgFTLBV3SAQS99cbngxeVDhDA18+krzLoC7LYeQCRAyLSn4z9y+8NT31X1PH/ifFNafLnz0aUy2bPbZrnxtg7V3EsHLzkECjKENavo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5716.namprd10.prod.outlook.com (2603:10b6:303:1a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 10:27:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:27:12 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 1/6] btrfs-progs: check_mounted_where: declare is_btrfs as bool
Date:   Tue, 13 Jun 2023 18:26:52 +0800
Message-Id: <0979640321150fc458dad36bef002a070c804469.1686484067.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484067.git.anand.jain@oracle.com>
References: <cover.1686484067.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 704083b0-1d59-4615-aa12-08db6bf8c057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vj16ZHPkarEylK8xViexLop3O+rkoepbBcMLWRaZeY8IUg83X9bmKfZe1dAVR5QSgvKxBYVGzUvt7OO9qMPQP5bvryt/oZAHFi2RYkcA0yZIVNJDakZ9eigbKiLvDhf8NQCAla5kiq6csQu7evHmXwUpM+hDUusNoOXqmTWgD1cQIWKBDkTLOVnVCDxDB5jOCKhH72DsE8LIxS20sxo7G2jU5Vokvr8n8gZVgjDsUXzd6W1DlZBgphNHsXThQWXpQee6Tlmebzgcc7LBH0FiD4b8iVUxD5Qj5jUEvyQucljlECRIwempuy2HUGj6lnCYN5oc1ECM+OThBXtWIG4I0CVN73C5mrFI0oW1GBlLr+OT99velB7BlQTKddLTBDBAc+okT9h9KJpVbwoEMaBpYGQ70tbVZmQWCzwQFDKfoLXi7xE5dfFDfjkDZKZmXXG9zjQMI776t6Zic7xXyWOzrEaxgD/c5sdfORl/eCtM18JIsUSdk8aqsEM7e+X462EMJCTHlrjOatGg/rhpW/qVI4Uc1FTigQ9Q4WtH84xPLQtKITd1iyUgtTN45/xNHks7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(186003)(8936002)(478600001)(6486002)(6666004)(5660300002)(316002)(41300700001)(26005)(66556008)(44832011)(8676002)(6506007)(66476007)(6916009)(66946007)(4326008)(6512007)(2616005)(83380400001)(2906002)(4744005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jnu7AuDFqQEuQ+6TBBpP0RW4SC1dF3JPXQOqEie98XqtXew3ZL1yfE9VGwKt?=
 =?us-ascii?Q?RLTVp4QFVwBYVpatkX5DrOTVKkejyCYQiuq/0c0qjCUIl8kJafBhj18nv4fO?=
 =?us-ascii?Q?5ieciPDi3uVsctsc7IROKolKBBT1rDVDDrUFdgqLt/1e/UrQ8wL5KkrMKWMx?=
 =?us-ascii?Q?wDW3IY4Bzfi+MAV7WduXtT13skU8bTHE9EKtlJhYbcRJt4NPZwPNmnSiJKDx?=
 =?us-ascii?Q?SvaeC6SduuSGMnemef+Ir6yudDOTpTwIHo6uYrUO+Elx3HmJhv0XwvTnD6JE?=
 =?us-ascii?Q?HgO4UID+gXQvJECIfxLGSfPHgY7oeiEUMy5Pm0tBaHiuU1nbGFBhu8wTXyO2?=
 =?us-ascii?Q?8oEUa7N5NOcj6CfXrP/EoIS1gWBgu6RoASO7xPydxTgu4ICxwsIfh+/PX6Xj?=
 =?us-ascii?Q?GBmEj5ODCtoQ45bz5h22Ok38o6Dqz7eDZE5uhAEeAjpuZGrqwp2pRscywqqS?=
 =?us-ascii?Q?J6DyPLwDgvANoI9QSmy2LBZLEA997c310kJh1ox8Mw7L1EMjQjp+kySMMPDN?=
 =?us-ascii?Q?uouLTVJlqoLxOw0R6LFTyGkii7vV9uM9hVSG8Juh1MVUPSQ/zHUxJAboCr+v?=
 =?us-ascii?Q?PgyIB83BPF8N+vIFXQcCDXLZ3j1Q+1Sx6U8Uh2kkKUnVhQjEER95bau+S6g5?=
 =?us-ascii?Q?lxzljgqjJq6V3Q6kC29ZixdWoZt20FeJrImOQxdfm2s6JbEX4x0b6veLUi9I?=
 =?us-ascii?Q?Lev19xG3VwSdEhm1HbehpvNtEnGKon5nn6KqIoyt1fg538wbcOTI42qMVUBi?=
 =?us-ascii?Q?2ZqTN8DU6vGv1V7ThcjNvs/Z93vB2mYQXvZHvodvmQvMBMwaqcraNe55Msco?=
 =?us-ascii?Q?PFZOnRW18Wx8Zbf6ux7LvF14lQm0srY8w3A7PkXtvSuH+pO/uaBssfOIgded?=
 =?us-ascii?Q?tyju4P3Q1hulYxkyQKG9i9AbDx3WJt4y65HypD6ksp3TQTXPu4Li08ZnRgF8?=
 =?us-ascii?Q?qwMFyHDBu3nLLcL7u0J1st4z5LgeY1xT93q5nJSeoF10CX7FslYEZAvljerz?=
 =?us-ascii?Q?F9jsBpAIKoxbdMrxKYeFVJwuSbyl/5UJUNjbVWFTzip2d1sMaKr7ZHH9K/Gy?=
 =?us-ascii?Q?vugWf65Am423epCDFyquzJACdseKEUVspawPs63uHBIZietH3ZIM2jurKj9l?=
 =?us-ascii?Q?NTgvy0VXeXLve7YdFxmgqhUdaIp9JxSvuWTfraW9aQts1LDKKF+Qj9a9wBAH?=
 =?us-ascii?Q?QTTgZcI0tI32VsUG1U+5BoIud6caboQ05HzVDE8Sdj377c+87AnrcBulgSdE?=
 =?us-ascii?Q?t03GWUcd53wLkpNJ4pt1ofxNoBMaO5moePESZicvrynGqDR000dzpMgvmklL?=
 =?us-ascii?Q?IWdUjohI1bks/tvccKmzMKwDZd39IwemsRnv1VOXCIuf73FZJTkmEhDWjWXk?=
 =?us-ascii?Q?B/DDFVTFW15XdwqNWnD7MrKhvkQg/0GJ0HW/H8zIO7daoCqnn5nBoLmIFisG?=
 =?us-ascii?Q?RFUGywFsvztsP/kx/XP3YF36DohzuzpxHwZcyUYw3SwXSiz2u02h9oYix/rh?=
 =?us-ascii?Q?1vIPyp+uAhHnmJfhVkmVaZgfZ3TWe82AcLIXPnIgR+O+l7dZM7jI+XtAJ/cA?=
 =?us-ascii?Q?+qERluTG96aYFCsl/NPlvlzMfhEFd95v8f/5WhnT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jy4zv0ef3eKuhBU3055HF+lyGs5+xm0FgU7qe0tS5CS2cHmabAgr7eEmTJGJIDSOuECKLjL9q9P4UZnNZl4dHsKR1gIw0C3C2GIqtxoeBmVgBvfm4tKBp+om0FotU2lowSCqsLgD30hzS0MZhQaEdgILFAHBveJxRg24T5xSRDT2AryVkQEqBQWPuMn42oWgBURx4qDSEe6KzroM+2ksRZhubczY2PRlBGq6Hl0wPgJdVkOI2Uv4f4Gvhz5DXdnIuLX4BKQgznL7Sd1VGRW8mCMZSGoGeRAx0maAB1QAUm//A4LyP+L6fsDsshU/6Ieh/2wr4lILBuJXRRCG2tc05GRm4lzJsb7udb3I5VmZcYaBtDRoWWRDbO38isJS2ZtM4sQYX3ppymJbCzbRbllKpLTZSX2o+Iogam3oCuXa6fuAQC73LlgnmSCjXn7zuzORr+RVTQzeviQPd7OCxRxe4am3Keskj9ug46GDUJA9EHLD1nF16F+sDKGWR31fRiZLecWOUl6t3AEr9+6U1InG9yNty67gTokYGuLGp081O1viBwAtl/XEIx7dcKV8B/z39fty8tHbbKEtMiKNKo3GGi3oFNiaO2A7IHRaq5b8EeF3ZOnsI8fEXKtyLqB4jFduzRnDToVQWS36GMxN8vg9koyOsmrZXJkqTDxh8hIsWvd9uZTtjaOsxYcsFYG8bc2Z1Pp1N2So1CU1j8VEPXINq//f7mo9JIqkFRvJX7c/Uxx9U0vDvaWA7KZI1kjUev6rR56k7cygHlCI3TkS5yBTIhp9OhUZnf5s5PKQ8hylfK0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704083b0-1d59-4615-aa12-08db6bf8c057
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:27:12.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTl1nZmIku7Y1SN99loZtzKamIXA2Ow2FKFcEwVQ6oCu7IAYiwprJPdgYsQVo43w8NPBXJg2G2qUKblSUWkQ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130092
X-Proofpoint-ORIG-GUID: eEepnQ1J-5-OODpr7b5_Mww9ImyVf07v
X-Proofpoint-GUID: eEepnQ1J-5-OODpr7b5_Mww9ImyVf07v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable 'is_btrfs' is declared as an integer but could be a boolean
instead.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 common/open-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index d4fdb2b01c7f..01d747d8ac43 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -57,7 +57,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 {
 	int ret;
 	u64 total_devs = 1;
-	int is_btrfs;
+	bool is_btrfs;
 	struct btrfs_fs_devices *fs_devices_mnt = NULL;
 	FILE *f;
 	struct mntent *mnt;
-- 
2.38.1

