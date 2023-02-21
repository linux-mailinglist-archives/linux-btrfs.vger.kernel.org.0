Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420AC69E31C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjBUPJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 10:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjBUPJk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 10:09:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09348A5D2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 07:09:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDwnLY009806
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 15:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2022-7-12;
 bh=Mv+f3263lYdOTbq9Eb0xI4UMWW3l48hsSxqhrfmfQws=;
 b=x6a/UIyBvdeGWeY7keoHMlONkoYmp/bUOKKIppTp8Ftrl/w8tUwqnSn4kjgXx1zpREeg
 ZlK95OpVJnT/k2GY2KkOnunt/iDxL25lPvYy3tPcuOJhsGYcWELM+jYaEHJa81QOmOlE
 aOPJ+NMvvcVqNnVCpDYOnAfCLbv5qrte5JH61SZuMlrtFTeFh7JMeIBwflZ5hdTpW4BJ
 qIRc23tSZZfEZkqSoo8/vAZiaF8cLYsvQmDiSsFjqb/Lj9d8DOHkmVBnKIL7+0uaHUOH
 E2HmoyTVgU6HI1Mqzkz4Ggq4Oo455h1XpPMjjqHQDuF/2uVHxOkT6Bxe9/TCZtaHOTw3 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja5bwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 15:09:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LDqemr027317
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 15:09:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn45f6d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 15:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llFDi6h1n0GSLQANqW2jL1QrExLvVC34SwraHvlx2/XoVnoUArVam8Hb1YKKkEwixgXBXNxFDNp5NH6H1TsphqwmsvKdmUfRLlLXlQKtE/rWNa1LMv0ZqLt5GXuxyezyjNIqGYzJBS8LJ2Vk5GmHuorHVAETkxeKGKfrUEB5OfhD90yfXl2dk9/zHNc9at6PGoVtat/QBYEdav1CcjM00ec0G7H+Gh6Dj4tRfEOgo7OEN8Bx+xLntClq98gN6QktBXTueuzCC86Uzk6jiNQi4XxeS0OL1T1IehM5QIQSr/+rnHpJziInALMvaMeNx43B0e4K2nm8sV8dSCgxFv/VCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv+f3263lYdOTbq9Eb0xI4UMWW3l48hsSxqhrfmfQws=;
 b=c5rwJJeQ5KPzoFpdFC/FBr6Vw2CsDQWfBrUEkc+QuwXUdlm/QxUuvSWABGWBJzaBIlJh1ThWTPJowCVmRVCmBNbuk+ELn+qnbkIo/LlOWmXRKrXP9VgmF9DnNHWexlyfxxkHTGYx5Ls5NE6QjjrMsGtvpGZwAJfbBZtqnvaeckLnZgP34kvkZsrJh8+B8kWgUTEZrec1B0LHekdc6UcSG50QvdL2aWRDYoQ87dxiJeYf81wfOBh+7J6tj5jwsXqauL+a45p7eNsCUm2Qtpx1S4cey/GWLi4obLpesU/uqDQz0RwYJYxX6AjRk/J1mxXYxuoGwybGRmb8xy9Y2JV+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv+f3263lYdOTbq9Eb0xI4UMWW3l48hsSxqhrfmfQws=;
 b=rdnLd/xs97W/0BjR/rgCVr5zwxZoZUOzD+C0EWdmy0nAIgBbvUZxNUmrmBhnqhbAF1606vcm9yxAkDqOmDSA7QlDR8/Ova2qigAR8Kn/qtfJiuHIJsaP+PY9mZPqZKY0XIrdSRqRuDrZ903EcWVBqjJKNeOJKR4rruE94jSiTuo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18; Tue, 21 Feb
 2023 15:09:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.015; Tue, 21 Feb 2023
 15:09:36 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: make btrfs_bin_search a macro
Date:   Tue, 21 Feb 2023 23:09:30 +0800
Message-Id: <8b986d23bf05684ae37102993b406e4e582dec39.1676991868.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <520705d35cbfb6c21d1e89481f8a4d0343daa138.1676986303.git.anand.jain@oracle.com>
References: <520705d35cbfb6c21d1e89481f8a4d0343daa138.1676986303.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 488086ae-cb2b-4757-2f66-08db141da527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWs8PqTMshL+raPYCsXbVaomWLWRyCfb0QCBLLB9Z9g5wcrKXLG4q4ukI/SMASIP18yCtfkxx8w1zyCmWIUybn7Oglzf3cJu0xVAe7xj6Mk7fxY24NZu84wUtvGfCawsT7ZR6Ydwx2ZcgpXS3W+tFpvubW16mY9sxzT4eMINLFUY+URoGL1JtPDH1nmVg1LB8TU9eNu3w54R+MKbLdphlsBlBrywKIZzV05+jBkmEh/F9m6rHsg4imhd3W5oUpq3gVW3YUALCywvYevslHkGvhvhE0BTldqdr2bZTzW4de1rXA7Q30lBn1mEH0Tbw94Np4D73Mt58KiUB6T2l88JHPZeoIPkIweSbSPeunozoJsyqr1XTIptqFXztAE2k0xb40UfMDd0syi3c2ZSFm3vYjRAGZoi0Tn4Bx6sWQaspp9FwjPmmh4KQTN0BLpuNhHA1BtZKQb0RwLdAlTsZJ14KK/FCn7r4/ozrH0CbfIBq5SVYQ1dv51vJvUWWMf2/8YYX24mdR0B6BCkSfTNvZLzv4HZlLridA/7aiNTMRRN5gnWe5aPGd+3r/uzF4NJ8NQwILk9aimbv9+UZ+XNjIq9wSKxE5+vN39AvtYRuksYfeQ3pEFe+AK1bevcm42cPz/u4YsAPRcvz4fHpmDDUsybvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199018)(478600001)(41300700001)(66946007)(66556008)(66476007)(8676002)(6916009)(8936002)(36756003)(2906002)(38100700002)(5660300002)(86362001)(44832011)(83380400001)(316002)(2616005)(6666004)(6512007)(6506007)(26005)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BCU1kGaXOlejwLxb5XSTEUdeTFQQREAzPpDoibSpi7I6Jp22JKhYbRiYGO4X?=
 =?us-ascii?Q?vjlabFDYzybuqGhyfMqVQtuYZSSh7rr/7/WHF/83FmXUVd1Gev4PSBRdnnD3?=
 =?us-ascii?Q?FgXQjtle79Mytz7YKv8G5iDFi8m2tcgwK7CArPWA9pz1LA2EDpXThnLLDVQW?=
 =?us-ascii?Q?vIFkS4UfnynuTLtsePFSF8Wc236yBTgCu0bGsX0BG7xSJRph9LA2lszwk++D?=
 =?us-ascii?Q?33b8SbOEC0aXUhDtMRqrJT+9/ew84VqZKwDn7MD30cCv8HDjQfZiOHb5AY6h?=
 =?us-ascii?Q?ZV8VvZcqVXQaQH38eZKKoqK9fPQf+8sekgAB52wU3WoV/6okk+ciuenoMzCU?=
 =?us-ascii?Q?GJoSjwPFt8g5cs/OgpIOD+R+WxUZcapoR2gnbm48WLlJmS1If9EK460nlTGX?=
 =?us-ascii?Q?aRYyC0iruFdXP9Sp/33W4u/RJ/dq76/rstGJR6SgXHgwFPhKR3z51PHsKtMI?=
 =?us-ascii?Q?gAU4qP70cYIEdUC52Lftwu6oPnRTtV54IJnHF60Kw6BnCzQsN8bolrtXVO8d?=
 =?us-ascii?Q?YDI81IcPihXaAj3SPPShX8lW9wc0E1aAMd8qC5tM/p/RtVvUCA4bSoAs+sxl?=
 =?us-ascii?Q?dgMG8C39NNv/T10Xn/t7R8qLmljNeDLQO/gwvHdYgP4zzzuxeuFC1qL4RjG9?=
 =?us-ascii?Q?VXKsdILghXERNGN+1THAoWWiovhB2uVhTeIrHudWEfI19gzfql8KOqz9Z9SD?=
 =?us-ascii?Q?TirlHRMREQ9JnpSduGOdMTYmLHBw3DpN90jFfzzmUpUKAcpqHLRGrK9UN0Nn?=
 =?us-ascii?Q?EGcqeWDUL1tGn9a0QGeeAFF9ijJCDuzjrURwvxfotBt/bVcdKCXfGyahFGWn?=
 =?us-ascii?Q?CgwTC8TTM9S4hnNIqFbUnPZv5jiFGvXCVA2e3USmd2kg5FQh20B/jLopyqms?=
 =?us-ascii?Q?icrGhz1ipIb94AD/FoxoNkKlpo9xvJjsxYhVnK6rI0ergakOxiuBmwr0UXqx?=
 =?us-ascii?Q?5wqzgEAiKOfrp8KOby3LRRFHX7Z5+ZASCyjoHET66pc+RfQkaN3d/5X3n/i/?=
 =?us-ascii?Q?RAY0fiTXLlvc/REjYtDeTx9Nu5MNpMtgPYny/Q6i6VJH9shM+zH9JWCnOr+9?=
 =?us-ascii?Q?7ps3HW9tBBqyIHsW1CAKeoUgQC9ZTkM29M7MlMeHVVSiUnikVLhfRg8e1bau?=
 =?us-ascii?Q?OP92rFZt8eHIvSjep3F/ucSIYS2Hshenv7KZT+vxMBtCTvWRYhMdCR3u8Erv?=
 =?us-ascii?Q?1ZtWNZ9QBmyHCOLFT3WLvMV7MWqSAlRbN7Qn9xliJCln0Jn+Da/vQ+cM/K1W?=
 =?us-ascii?Q?CyPwAt66DSLZd1UAJDezyhaL8ABizpYl+VlN4lhMWzKULWWRXYrDmPrA/vvy?=
 =?us-ascii?Q?yFPxWRRyW4RWYw5xPgWBWrPjyuvlSP/UGuAc2oJLl2p5irXBveojgN4VAWpJ?=
 =?us-ascii?Q?qYcFm7cX1EeoudQzCk0+ULLq2+7fMOBs+Gm5NFCV9VaKpWsU3LfAThLpsGYR?=
 =?us-ascii?Q?KK8eed8jbGb62Ppv4gUwvYWi5UvIDtIORWb/Fso4h/KlbgKZCXEz5ENR/YAF?=
 =?us-ascii?Q?L3Q+Wd6DhuPxvzmMBsbNJSjXL3jzhqiwTxB6z4SZZUaiMRfHV9DtaXXBMtNc?=
 =?us-ascii?Q?UOYGBC1KObDXx9FD2nlO0XGK6thf7OInAVHEiO6B?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZFBSXBs33m7cuxoT8iOI7yO1KPyj2LSqKu/5W+jD2d77oo7+YmEvb+CwsLdI/1qtqQKqXpYKMLI9wt00jo+hF/0Ed/oLFCmyWkmDCZ4wdl/LJ0jr9vQkL0tbr/ZgS9Jmx8HhYPoTQu8UKuDpXcXINooMG8sLt2aIRpj+zSk7tQgvRy4MCde71iyb327eMb3NLH9aPBxFjAQRYPoksXMV8Wbk3wmDhlDCvrLMOe7HJ46qEpxT3dA1l/qwSKKUOzOPTp/DGVwVpRxSfK43USzWmVfeqk1zKxeLHJ4B1RbGiWOaUn7Eckms75wbZGTEZ/gXMYeuHD55T/ooFaiFC1RTQZHQ6w/b39Idm+qWUytC0fVxCH6Rt/9PrHPdMrroFlo33/Qd8BNfilaIAfZigg8nJRhjRhIcLjCgbu4nXx/NpL94VZpKToSGjJC2XNFhEV1jDEJVFoEO++sRjgTlqA1HHmLNp1MtseJcDpX/SyYD6CqUAMBFCeaUildJE1azadazeb/MywPY1oLLeNg875ZG2qNaXRlsaqquhwz9u09qbkFveNBDgqCWiUnd/hoObVpMHfj+wVN8HaqtcoOmVYD43Ya2O4aE+HFG95aw8YDqrMX0noSFzhO1oF4cGJNRDaC1aZFmGebx2kardqPWIMUfrxuL3+5+KTjb7GTDGDnCNSekrzHLEYVRhKczHDd37ve9sd5BKFVCd5r9RhW/H53CScJHY0ZX03wskTyccKPV31Xl2zDq8ZWRXDEqjeBnhaYOKVkiEHvxbM5zJp0n53SyJQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488086ae-cb2b-4757-2f66-08db141da527
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 15:09:36.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7ySCVsrpJpQuRYBHK5v52V/74PSosV3jCn5sOzPKKTXs9DolHKT+RhkbBbWa338GuQ25zxc3a97bSOY2ZMZnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210125
X-Proofpoint-ORIG-GUID: HUmXiqm84vkKXv23WWUoXJCSJRb05T63
X-Proofpoint-GUID: HUmXiqm84vkKXv23WWUoXJCSJRb05T63
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_bin_search() is an inline function that wraps
btrfs_generic_bin_search() and sets the second argument to 0.

The inline compiler directive is not always guaranteed to work,
unless the __always_inline directive is used.

Further, this function is small and can be a #define macro as well.
Make btrfs_bin_search() a macro.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: remove extra ; for define

 fs/btrfs/ctree.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 97897107fab5..1e1b8f4992a3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -515,15 +515,9 @@ int btrfs_generic_bin_search(struct extent_buffer *eb, int first_slot,
  * Simple binary search on an extent buffer. Works for both leaves and nodes, and
  * always searches over the whole range of keys (slot 0 to slot 'nritems - 1').
  */
-static inline int btrfs_bin_search(struct extent_buffer *eb,
-				   const struct btrfs_key *key,
-				   int *slot)
-{
-	return btrfs_generic_bin_search(eb, 0, key, slot);
-}
+#define btrfs_bin_search(eb, key, slot) \
+		btrfs_generic_bin_search(eb, 0, key, slot)
 
-int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int *slot);
 int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 int btrfs_previous_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid,
-- 
2.38.1

