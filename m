Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B4372E003
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbjFMKrf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbjFMKrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:47:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67F1AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:47:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65XkC020272
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=/XRSEgeEwneTV6grryAZRIkuKm+XwNCcZ7uPtWdBrF4=;
 b=ebdjIHFJHiPN/neZHhSf9PXZZhbWUTF3r8GRp5kclQfBvZwA66slg4J0Eruo9ebIzVef
 TJEhlNHw20qB8hQk3wLAttve4kAr/Gpo2ZzymXJF2BCN609Wt7J6uV+aDYJNZinKTHHd
 +BkjKXZjQEpjoxgUAlFPOpu3BU1rY6JBdedCYHdINvISOI4zFkaeXv6r2tjGeRsHSO3p
 n+UBEgXrs9/YqjAgr8mkjPgPO6VLE3jNrBidmPPSU61yd2selpECTVQ1T0yHLvGWP58q
 YJgqZIsfj8uWYWgxmsKwAfyxPQp39+CW4WydQFsnVbQRjYuV+ZFv/CbvWEqG0Q0XSFtF /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bn0v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D9Z8c2014099
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3r2mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyZiHThOnYCYbsSuIw9WM8+gAJuVWle5xTLsyR4TRfSA/10RpWYZmS3KuNTsjMDRRpqv40gxg/pROwNGHtmTn0eVoEkiC0oFRhIouRS3lC0CTZQsaSvAZjs7FMuuKZg4gXBGorM4FSvgrZrzSF6nQ9KqkkPXZuMR7j00oJLPtBy0RtdPbCxSyoQaP3nMKsU2YZy8kUZg5onVYhluAXHDDD2FkIojBRYVu0KHeSMz+HyA9jhwObhLF+7emgkKWBlOukHpXBIrU1H/A8nX19DxEGU7X3nxMqx8xAZBGw1u231ee8+EJVWrMINyGDh9XTeP8AjdUeRNsMYdVoLxpbfLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XRSEgeEwneTV6grryAZRIkuKm+XwNCcZ7uPtWdBrF4=;
 b=M957hOUm/MrDYM9PX82QFITUJbQqduwES/hcyL3sBOOZDLLjRS/yoDdWsVSUF9bh7N/xX+S+f2uRZebRjChHbP63/eF2t2Tg3DTMn8V/rauq4xuWRg6w8lOTLf8Plv0xF7ukGgkY5YElUoTn2d04v0PE6aZi/7AstWN7KfK0IARd7cjO8FC2k0mT94k/mQ5WFByVVWWyudQdMiMUU7dZO0XQu6+sLTHf1CL82epp4HtCcmIJEN8E+pjhB9AzhlahD6X4Ose88nFOQ96t3UHpL4OkXTIPG6zFo0gUkteFQZQrkm/EQbL0Tbx99RXtnw0xGcqpAgE8sQvueK53+6jUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XRSEgeEwneTV6grryAZRIkuKm+XwNCcZ7uPtWdBrF4=;
 b=fRi9yOAuPqfY9HgiaIrK28k1vxZFTLnxnv/g8R4oEein93P+4uhkzufOTbbzjq2DME2NsBtfvAXHlrG8wzoLSVPm0rHYHLGWca2ToHRKNyVEK4GmkmoRbgJaZtLwmVpafTgdWKIPw5kqktaNaIvevU3lpkoi9Ri08plOtQZb2M4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5012.namprd10.prod.outlook.com (2603:10b6:208:334::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 10:47:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:47:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs-progs: tune: consolidate return goto free-out
Date:   Tue, 13 Jun 2023 18:47:11 +0800
Message-Id: <f3c22ab821808bd716bacbff64c557f76bf98ada.1686484243.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484243.git.anand.jain@oracle.com>
References: <cover.1686484243.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4b465d-cc31-43e4-146a-08db6bfb9599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wfylZds8necLVqlxNscYleB9Wxab7OPBrE8LC7R2EBlKDwARbs+o0JnGl9dhjSYmb+vqvB01WHf2/zP/iCcrdP0+UfH7+HhC/u8XyqiY4OHv4l6euR6CQCwhPmnfOBMDJ6ET5vMp2kneKpF8FRB+yTNvzsp5mLOkEOfJz33U056jI2zIVw3DfPepX3r3BQsNVsX3Nz6BBAkoTMItF7qp3nKmwZCIWt6UjcM8YopKT0P4nH/ijpKaT9rBZAjebZMs1TaU7Wq8g58uc2X6zG+BH+Zd2UjlI9QjR8l+SIvRD0wyLZlgBK1nYFWIQdIuloia95xLppN25UeEuwbkBG9jKuK+VnA/2ZWKY2FaIqUbzQT3cGFewjb2XAB1ijYoHzCAGwZNQqXGuyqozTcGpVeFYtaLlCp2qGxX49h3mE0IW1QY7cIKy+yTs23am7G6JXaCnzHZfeKdLRfN0kZx9jozy2A2QP4Q2qzbieXLjDLwqq94mUtdzD0dc+E0hcMK3UmxCwhhe1ccjryP5FVSn9ix24YcQ959b7zH8+X2AACNPYEItTn3IFlubSNxLYM1oYL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(66946007)(66476007)(66556008)(478600001)(8676002)(5660300002)(8936002)(36756003)(6916009)(6666004)(316002)(41300700001)(6486002)(38100700002)(83380400001)(186003)(6506007)(86362001)(44832011)(2906002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GgibRk3vf1SCxP38mkJdIyh32BzilN+rrjuZMRV3wNgB+kV0JavYtlRxgMJq?=
 =?us-ascii?Q?Mum4tgavvXiq/EJntwc0jrMRy2wlbfDKx0ZkL9SthtBiKDwB+dfBhOY9txdy?=
 =?us-ascii?Q?ni4SobS51ktw0SlpFt0iqUEIbCROWgMMzQFyrGanqx6bvwXHjYxA0GxfgJou?=
 =?us-ascii?Q?SJEFpWd1kKyyfeuKX16iTc3U6OyWMTDtBSiIiPVLbw6BV7nRDi2gpHxhasPc?=
 =?us-ascii?Q?2KS909LYTyrUyB8Ouxm1rjpYMY7Y9F9Ecj9A5abtkV8cDWDfE36Zl0YiYyUp?=
 =?us-ascii?Q?tAQHiSzOAUA4x1C/FlhMPfNQ6pVT0Vx36Zj38Q9vKsjGi1PQ0534LmcF8Y5k?=
 =?us-ascii?Q?vy1IyzZJgJXfaZgVrPidusfFP6vme52kiLMybqqHq0ZkUwn7/5xkzVPbfZhQ?=
 =?us-ascii?Q?xKu4OZbF4qIxQu89EFgUNXt398PBd9Aenrq9CyFufPZcQemer3U/HifT66Ll?=
 =?us-ascii?Q?ZfKAVDhcPB2ahXmaPyFw2fqu2p4+SSdhZlhfwdUGUJnkAS1nlRhzYS+paS5P?=
 =?us-ascii?Q?wC4/6+FdsM+jnJXa3kOB268bfrV3ZFMI+ZosO9ENH3dKVZy4RPLgZCkBl8Ui?=
 =?us-ascii?Q?2uvLnddckHO9PyFe1eh6zsJr9wfgu8TDFuZ2nneUizIApBhQPo08X3ZoG6+m?=
 =?us-ascii?Q?WAF3Ntby4vVFCYYBB+VVhz/Xu2358GK62Jj+b1LIaRIK2VYwgDzLpF+7WRMv?=
 =?us-ascii?Q?DEnhBS1+AV0oKPsJxOawptlCnR3C2UzAtorQuXaTlpHbJv38v2BH2cWMRzt6?=
 =?us-ascii?Q?fqp1pOjkontCK9We7st7DQr9rWT8NcgrJceRcgw/O+VXa7vR56K/SXhtQKVc?=
 =?us-ascii?Q?DspmTGp/tjrz1YhvRcWip9fXxHBFLG1OduyT1vannAbvLqOT639NlLgy2vRo?=
 =?us-ascii?Q?bwiqt7wvsouYre3XFEElln7kjHQVsKYGg1doq/qzv2wTuJJPqwfbbxHpxz+E?=
 =?us-ascii?Q?leGuABZrKk4bDibqSDq8UhYcIJFCk/vGmksnBklaZ3xhlQ1ztqD4u0hhfo6h?=
 =?us-ascii?Q?rFJv5DKVAKqH1Em9Sv1WoioMzpmuOvEBytQzVzlR5RFGzgQWNl++BqumitSs?=
 =?us-ascii?Q?+iWRTw9xMhzjFZg2cIQNFihy4mUA+4hOQ5ZJFT/XtVnYnOWr4aHPp2FJlLQH?=
 =?us-ascii?Q?aik5EWPNwqg043m5EKTwSZt/sNYoemT0Aq3mIJo3YhRror7tsP813sfEe3CT?=
 =?us-ascii?Q?/UZ0W49drS4JyDMRXwJ7h5A9w7zmJ52iIP2xugFJM4EL6e40jfxkPQAqCPZt?=
 =?us-ascii?Q?G1dFxRmc1GBXJAkJPw72hIiF5Tc9bk2aKOp3t4CshYq2hFVFdi5PiloLEp1q?=
 =?us-ascii?Q?IkKfeJo8cbV4fztyUufNandaXDEXt2nYeW1O1V0+UV5vpxpq0lZtKcJtJdtD?=
 =?us-ascii?Q?fz6m7e157BkfzbXVOo9vKOVKITXFxXnHnXDIc4JMZEgM8Qsr8Dr1g2QFnGmX?=
 =?us-ascii?Q?vWc++RX4B5mEtxgRxV+v0w++lVwc3VGDMTD4sOn4rglbAWNjBeNa2vZdBNFx?=
 =?us-ascii?Q?mqjAnFsOiSLTVXFtksian1e2ImjWZo4rFbhstlQiFAX2xZymL/Y6EQMXiGXn?=
 =?us-ascii?Q?E0ahfU/Lg/+1WQDmlFqSoCHHr6bVuuC4kj+8xNa5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ms2Qm/SbC1X70dyaFrK/uZP7ag/T+ixA4maMC2cWenwXIQfSgE0LPJhT8CfcXgglm+nFKUDkmvucYoiBh8UcbVDJDRxMczyAnnHDIB6CroAt2hDp+DZs8mPYBu/QKCvhDTWHWG0WBqrOopS/NaM9QJ2+WoU+tHWLzJDJ0wFoNwELYAl5v29L1q6zPTOlzo+3izXkU+mOof+LlBTe5ty/wuc8NJXgESN+PzAv/JYp1GOJleo0scJNr5dg10di+CETPf2yTI3gIxVPmX1rxCQOLP4b7s3Ovl6xu5sT1MF9IWk8GYjeVrTtBMtD3TBRfgHj47wLGIahpjiXeSshh00HoeUIcx0Pjmc9CjUbm8Y06kXthIXRKBpZQQmPxtPwMTO3z9Br/5O9xfVfkYWR6J+3d8Yq2og1Uvfv3HN3+2Rh2IS6ZkyblGUQM3AiB75E43rpL+Sy+p6BG9dneR4uCMx0NrpX7WBX786omTpIRnBQiyyEmj8OR7vGgfYvrr81nAuiapQmmiXXQC2U6ZV5zS+N6FKgRzdgf7fdgWO8jViv5Vktn8La+h1VicFiC4qlocJCAA3F7LAfdIEV94cviEpodLmYzrtvCLybq5ivqyixO5kkxa3Lv6mPF8NlBJYw+rGokQkYRymeaDcgBUGZRytvt7XGUFukg2QdeVbCsgUeN2iEvUaSAem0q+zHZD2dj5eF/aOlTvVXzgArMVSl+tLpH33Pc9zk0kXmdREawQr0EI+z52Cfxfkiw9RnRsSNQNItL8v3fI24rn1KlrbORcukRw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4b465d-cc31-43e4-146a-08db6bfb9599
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:47:29.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/MidOgfzlhm9fCoEEolkBUHAxLlBT2GFss0EcDA5QMe87dex6IIjjerjLAXnPnOR2aOBsqqS13vbjrDBg1G0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130095
X-Proofpoint-ORIG-GUID: ZDZSlldbuIS4FPOxlxxq0cPVtD3HMqf6
X-Proofpoint-GUID: ZDZSlldbuIS4FPOxlxxq0cPVtD3HMqf6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The upcoming "--device" option requires memory to parse devices, which
should be freed before returning from the main() function. As a
preparation for adding the "--device" option to the "btrfstune" command,
provide a consolidated error return exit from the main function with a
"goto" labeled "free_out". The label "free_out" may not make sense
currently, but it will when the "--device" option is added.

There are several return statements within the main function, and
changing all of them in the main "--device" feature patch would deviate
from the actual for the feature changes. Hence, it made sense to create
a preparatory patch.

The return value for any failure remains the same as in the original code.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tune/main.c b/tune/main.c
index 0ca1e01282c9..0c8872dcdee5 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -145,7 +145,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	bool to_fst = false;
 	int csum_type = -1;
 	char *new_fsid_str = NULL;
-	int ret;
+	int ret = 1;
 	u64 super_flags = 0;
 	int fd = -1;
 
@@ -233,18 +233,18 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	set_argv0(argv);
 	device = argv[optind];
 	if (check_argc_exact(argc - optind, 1))
-		return 1;
+		goto free_out;
 
 	if (random_fsid && new_fsid_str) {
 		error("random fsid can't be used with specified fsid");
-		return 1;
+		goto free_out;
 	}
 	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
 	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
 	    !to_extent_tree && !to_fst) {
 		error("at least one option should be specified");
 		usage(&tune_cmd, 1);
-		return 1;
+		goto free_out;
 	}
 
 	if (new_fsid_str) {
@@ -253,18 +253,21 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		ret = uuid_parse(new_fsid_str, tmp);
 		if (ret < 0) {
 			error("could not parse UUID: %s", new_fsid_str);
-			return 1;
+			ret = 1;
+			goto free_out;
 		}
 		if (!test_uuid_unique(new_fsid_str)) {
 			error("fsid %s is not unique", new_fsid_str);
-			return 1;
+			ret = 1;
+			goto free_out;
 		}
 	}
 
 	fd = open(device, O_RDWR);
 	if (fd < 0) {
 		error("mount check: cannot open %s: %m", device);
-		return 1;
+		ret = 1;
+		goto free_out;
 	}
 
 	ret = check_mounted_where(fd, device, NULL, 0, NULL,
@@ -273,18 +276,21 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		errno = -ret;
 		error("could not check mount status of %s: %m", device);
 		close(fd);
-		return 1;
+		ret = 1;
+		goto free_out;
 	} else if (ret) {
 		error("%s is mounted", device);
 		close(fd);
-		return 1;
+		ret = 1;
+		goto free_out;
 	}
 
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 
 	if (!root) {
 		error("open ctree failed");
-		return 1;
+		ret = 1;
+		goto free_out;
 	}
 
  	if (to_bg_tree) {
@@ -431,5 +437,6 @@ out:
 	close_ctree(root);
 	btrfs_close_all_devices();
 
+free_out:
 	return ret;
 }
-- 
2.38.1

