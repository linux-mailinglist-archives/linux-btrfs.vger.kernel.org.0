Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0377BD00
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjHNP3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjHNP3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF036130
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:28:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiYGd026725
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=noU3gUpIjvDCcrNTyeBXuf8gz0NNiffWUDleke60jxg=;
 b=QCN1eLOgLVh7/H6jtsLkRa0l3xnYbMQ4yOZPkT3gsSMYXx2E34PqSKxPYul2JcYAPV51
 vLHHXl+B+1kiwnnaN68+HL9AxjYBJBgVYa1XCbwMNIF2KZ5kkvqe/Feqk6BmnZrcOXGi
 iMmku/psBTF7eSzfXqdl564grB9ZVRB0qOmj1+vVXCcHqwxs+3xtPgt8FgTqN/Z2fwMv
 JWwJgYTUHyztfvdtvAeLFCFWm+PrZ+dVjNHXE4ZXcpHKbu061qz6YnPVkEiVyxXPGyvc
 HutXYD4RxjhKvqZD4PbeHWqGkx6ps4vZ2ejXQ39vA6T30dlpZLu94s9rIaQ0MDccBT34 Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwjves-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EF8FjA040235
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0pt07d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuKzUPr9wqsJUcR43Ott6946IA96rp8nOYXHUpmW0X6ez9an4188p3Li0XIf+tay3vTvo5v1wKKxn5bftFTqMVYNYnGbDgDhxyr09FGGoL1uTHBEGjM6lIOBZrbr5L3WYXIKGAiG5sRCXcEkjgCBXPd5u9l2H+Zrz2Y7gzbotMciI/+TazcULF7FovIfiTY5Lq7Xp2vxpuxYkr59Uo4A4YLetprojgKLZLpQz3CtU6IC3tNDUOxm3MWvh5W+g/3epcNmeLuAKIL95hqoJK1Z1GY5/yJBxFf0Wdt7jRcbbWe8ghpLv7dNymSOoFatWzNT1/cEiXP2YZd40MgfAj1A/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noU3gUpIjvDCcrNTyeBXuf8gz0NNiffWUDleke60jxg=;
 b=CRo//Yp+lQDK5rzxKuFXlnXrNBfeXwcW6W7T9k9Yoa/5lRHA8DqTTY0lJuf3rYxcaKagZ97xZpeU9seL3Xh5h7/5OLcnGBP9yfiZB2e6CF/RELziai5w9jsegEOMdLB5wzUU+lknJPPGRazLsc8tdLR0ZU6GWIvDAEDcEHUFclg9AnG8F2oTnYfHjiFisPRGX6ueuJYqBIgIZVapsntiHWWF75Rkbdt8MTb17X6eVDnIy74kRNtBn/EEBk/eXRnNo2RA6RjFxZAhvkiUT40a3T21W/Uxs0pkfQCSfh6arVcOrwquWVfiZ9V5xfm9psgx/Lne5LnfkGhsWMzGRfV7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noU3gUpIjvDCcrNTyeBXuf8gz0NNiffWUDleke60jxg=;
 b=HW8DdpaW+incXLt2Qff4VWPdCfCKgS30r9QPOhh9kzjVSikuFjIMCOFerPeTHr+7mVoWXNaDdDebPleuk8NC2SaW5m3s7fQVVCac5ttObMnjVv+CUKdwSQQr/QjTWPYavBmDAi0IhTIFOH4+zHDsWxTcOQdVFDbUjLA3ZvpJuhg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:28:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:28:55 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/16] btrfs-progs: rename set_metadata_uuid new_uuid to new_fsid
Date:   Mon, 14 Aug 2023 23:28:01 +0800
Message-Id: <449fc6c18f126fed0c1376ce00bbb293ea281601.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c42e183-c384-4fba-d884-08db9cdb2c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ejzf0JjkVcTmjlrlJj5ZRv+Qx4ZbBqWjAem7kDY0NeGXTQwicEYJZN9Jps+ckiVy9tGKjlmLIWQ3GLIelNfKqNDLuTzPUYsVdvAQZiQYItPZYu5rJYXxeVQZWGvgLiUyslT6YskArh0qxDsksRKAlgZWHi0XLpnAPQNuTa4eNLOPZxuHf2WKCvL0wRTvreYy71txQW8MJc6sm/LHUsHituzOq6D0OGi6gcLA7km/94Xpz9XtHyqmb6JB6WccIw7L7QWw7a1MFD4a+pXQaGb6qzjMaLDfRjpmsRcgVIQNHrhZyvmg1b61urru18ZLT50buI09PqIbUFMsBTvChB/zPc5i8G5ZJ9jAGFJF8iVXq+jWacY+pQJ8XnOKlSfpVVjP+7oN1FJsIn3cPNoi1lmC8xNRVlHrHNTXQ+vBveqOxdDp84582j4uuJ2g5yEJFI63Bdf7XiU2a10P3+32AiKeksHCQDvU252O3pTc9ZvfF8OS8HZzp44jNtb+RkmH1vrob8nO1N49CMu3Prkuh6GMuAmLJ9+2SUtacbwkrht49fvi7Gd16V0zIYv2zpmKrrl2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8r01YcfEACBFhNdT2TjjtF/+f7v3hyUCZh75BA/CdrTK5zhoFxtte186Ptd?=
 =?us-ascii?Q?rUUmIfwK9z5xKeQByzJaQnF7bNEmUIQuh9NEmQhyUm2ZM52B8/ngxEWtOF8V?=
 =?us-ascii?Q?LNF2q+hIf/WHXyRnpw4qFUvuwu4qOpbiXLwj8gtYfFVZmD+9WhNceyEIKAzQ?=
 =?us-ascii?Q?SPs4B05YlYb4lQkeeqkHoeXCS5W8z7brH04cvjBmQnwIjwnC307rlQ/8oDWQ?=
 =?us-ascii?Q?VGXTpY/CoA+nYjTNLrxNSo8hpPjyS5UiA8VYrbU/jmaPGV7PAJSXZvQ/2h6C?=
 =?us-ascii?Q?/FazTfWj3LoGFIZN7Csy1u7CuREt8l4N3c2giswEaYcvEJoTufEqVY//hKmL?=
 =?us-ascii?Q?1PX3jlsmylGwDH5ALPodMKQK5746J14CPqcpKwiDD+xaIXJHbr2P/iK6KDHS?=
 =?us-ascii?Q?pODi5C8HVY/oVS9b3gz9gVaItfMb28H3gQiWLOT5pK/EPmW9bD+sy1wbLHmt?=
 =?us-ascii?Q?aNgesjhkv5rae/vfWTo2Y4fbRNI3BvZ314uNiV9zGfmHSQhMq0HaGyGjK6gI?=
 =?us-ascii?Q?HuydWMEhgrP4pIKDEZ66qKUKJKKECzJshsRAgtUzjZG5iOgyQvNZxiPt9vh8?=
 =?us-ascii?Q?TRn9uqcxMxvdz4Rh2VVzLMYfEs+WiGvaZYafiXUkOedxqMtl8M/THM14EsMq?=
 =?us-ascii?Q?DPJf6HTWFmq3z0OKkijoCggQizhQxHr65b8n0pyTaEIDmPv0oqOMIyHY4i80?=
 =?us-ascii?Q?z3VzvpJ42ciQQwk3e3YThb48yazhqGQBQEKMzuD4HgGRQmR6klNAqGj1tC9h?=
 =?us-ascii?Q?8LhvitfINK06vlKA4YbUnkGiB6XjcSTOwKDcXe8lmv+hto2SbI0ZV7uOqA5F?=
 =?us-ascii?Q?kb8Ib7yPsweI/wLAUDrV8ihqSlLQO1HFOMecD2wWW6MzUwKcvJu2KKenaDHx?=
 =?us-ascii?Q?pLtVXL2DhwHJu8uToyE+iflbRoNS8xgjRhKWpnq90qhMc9SZ8x6BGSEBSK1A?=
 =?us-ascii?Q?jBWruwJgOWX4snCT4VYXJpQdtWxWesi+OVUge90sebRpNlUfvbo8oLoxtCiS?=
 =?us-ascii?Q?rPRZv3bzbqVvf2PInZwiROT//noI0ragdFkll38Zn2Awm2Rhqi4ruAtM/8pe?=
 =?us-ascii?Q?ohq/bzyzf21TTnnUJPkBuepY8oMcnOnI1C+kUwu3/7viZq4cA66FlgxPKEwq?=
 =?us-ascii?Q?IwyY1RHrfURnu36f4luc1YK5Cfyz6oq1nBG2PkYcW770wW1gIdwv/K/mxmMl?=
 =?us-ascii?Q?htIb3Ps/jP7sPDlgLtXeDfrE620QTMaifJdr3JpDeYKOwkBwLi+4xEhbG3VN?=
 =?us-ascii?Q?7fHHawW0/x/bttla34U5doRRrcXLXvsoDh7WbC4Jy4IrkAdMz/HkOlBO1lmc?=
 =?us-ascii?Q?NUiNJaQ9+R7gVYe/WxWAUGjO8yfwy3t+DaOKE5k0jvPNWgdM8zQb8pp9YcZn?=
 =?us-ascii?Q?59WHPHIhcUCn15umb7EkW2P7LDGmGEWEd+C0gTOmBMKqehcrVWUyIzrR1JK0?=
 =?us-ascii?Q?HeY9cL8Kt4xTGn1RdM3IrPoHzszsLRaPNHfwKSP+w+sp8Lv9oNvlPX1AMCx+?=
 =?us-ascii?Q?+KB3WjNtsoqDt5AWPyk01SeIYGqI2xF61yItaVT+/C08zJY02DsrvxG7XiJf?=
 =?us-ascii?Q?F8qdW+caQgFN6ZbOf/O6YOtKdvc3dD2loaeLwJncdvjJhYzRbKYuFqBdtV4h?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rKI+CnN/8buZHZlzZmnze47NZlVc7QISG1kt7XK9+QerbPbpf39Kz7ISojwwNbktlXvWATJAmpsnvnOQg55D+CrXWOptadGO2M/L0PqpuUpXAUJmTYUClsxbuBp0QkWnHPWPmXkDON6VLxk6t7nzkztnkgD+A9XceWzcNrszNVH0azwgsunfTpNmPSZN2UGUqcL79mTpOdmDkj2iR5+t6jDg2wUdtY/b1thysd2m09pYaHsnoTNle5tuMeb54cB0LoDsVTaG9jqHFYlEZuZED/2odY6MwNBb7AB7RMd0DPjRTNxp6oP3m208chmlrMrjxmOOPbbTN4FhQ9DnQhSfup/HQAJWIkCOIjtdgnDHileNSGVQoWXQXUFltGj/ywV/cE5wFVw/OIfHA2BepdBiBGMDM+RV2wG0g0qzQ+BWqzRRfFFNwjiTVCbo/lVm2dA9ze4LMu0g1ylqO0x7MwTRHE0TBrQbFJbcS5131N/l4guRrWkRSjpq3XTDaQNczUroJy4jMSCBgHzZK7AxyyNLoKFVTbaSe9gxo8AKF9NawCm+ltiKqIUv8ebfxx9fJNRYss1SNJQSmaG353Tk+H/K21fZWr/BqRa/iXUXMhfQVKMbAn5AGGwPPgMO8yb7jJK4d0d1kO0H9Shvb7B/aFf6angKauf2Yrl5lJn2ubeTU49D/deSTuNcXndQ35jcCVJG9CHrkVmwwcs+bVtUn9pAc0Ef7TBu2fI33TzPG9KmbCUgQSAxV47vDHbIwC8BNI2x0gqL5TyzwNOj6aCwvHMNMQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c42e183-c384-4fba-d884-08db9cdb2c01
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:28:55.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38GdxgxtnpE8pQnK0JQyKm/zFMruOBoTawdE3fS61oZP99ueAU57NWuk7A3vL/uN6lckGAuBrYrgjmqI7akIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140144
X-Proofpoint-ORIG-GUID: cQhORoUS4eJDRtdWOHkpb3TdrgOX_Pky
X-Proofpoint-GUID: cQhORoUS4eJDRtdWOHkpb3TdrgOX_Pky
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

%new_uuid is being used to say there is a new fsid. So why not just call it
%new_fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index 0e5760194b54..83299f990b50 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -29,7 +29,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 	struct btrfs_super_block *disk_super;
 	uuid_t fsid, unused1, unused2;
 	struct btrfs_trans_handle *trans;
-	bool new_uuid = true;
+	bool new_fsid = true;
 	u64 incompat_flags;
 	bool uuid_changed;
 	u64 super_flags;
@@ -55,7 +55,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 	else
 		uuid_generate(fsid);
 
-	new_uuid = (memcmp(fsid, disk_super->fsid, BTRFS_FSID_SIZE) != 0);
+	new_fsid = (memcmp(fsid, disk_super->fsid, BTRFS_FSID_SIZE) != 0);
 
 	/* Step 1 sets the in progress flag */
 	trans = btrfs_start_transaction(root, 1);
@@ -65,7 +65,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 	if (ret < 0)
 		return ret;
 
-	if (new_uuid && uuid_changed && memcmp(disk_super->metadata_uuid,
+	if (new_fsid && uuid_changed && memcmp(disk_super->metadata_uuid,
 					       fsid, BTRFS_FSID_SIZE) == 0) {
 		/*
 		 * Changing fsid to be the same as metadata uuid, so just
@@ -75,7 +75,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		incompat_flags &= ~BTRFS_FEATURE_INCOMPAT_METADATA_UUID;
 		btrfs_set_super_incompat_flags(disk_super, incompat_flags);
 		memset(disk_super->metadata_uuid, 0, BTRFS_FSID_SIZE);
-	} else if (new_uuid && uuid_changed && memcmp(disk_super->metadata_uuid,
+	} else if (new_fsid && uuid_changed && memcmp(disk_super->metadata_uuid,
 						      fsid, BTRFS_FSID_SIZE)) {
 		/*
 		 * Changing fsid on an already changed FS, in this case we
@@ -83,7 +83,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		 * has already the correct value
 		 */
 		memcpy(disk_super->fsid, &fsid, BTRFS_FSID_SIZE);
-	} else if (new_uuid && !uuid_changed) {
+	} else if (new_fsid && !uuid_changed) {
 		/*
 		 * First time changing the fsid, copy the fsid to metadata_uuid
 		 */
-- 
2.39.3

