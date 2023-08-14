Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA66277BD01
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjHNP3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjHNP3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938C310D5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:28:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiWhX026705
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=AdOOm9UiiaLOenln27ZT2SdfvWpBYnduEm78splCn8I=;
 b=L18h1gMhiaaxGeMXl/BXVI8enCfq3aTKN4HQHTZd9dPVAdKwX76dtzKeK3wLncLCxjpi
 Rqs/5V18eVcJ/n138WFCg3mM9gw+oSdsWXKJETfMJw662yqIoHI/ipCdlP1bFabrjehn
 9wVqAhgg9DgEs7F10I24OIl2yBs4LXrtg9bOUN+viZva7C7XLl8Q6Vcwy1v3LYynEQex
 91KSJEeLnr94mNAloUdxsSL6mQkQsKlukobrwZSJLqNYJZCy/K0DQdFrf3dN7OOpGIW8
 LDKjS2Hc8lDOopY8UF4KZhPuY6zGfDqj1ej7/jBJ0HymB9p2vkxvIPLlOkGkVKKQd7H/ ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwjve9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEqq22005488
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2c1s15-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH28O6HSKG/v7g99ET9ed4nLjljUQIxKABNnPxq0ZLPJ2L6xEfTHZwHqYDeiQrECzsQrDaWKbetVgECIrbPOCeBka7xCsElYtt18AsQJazwuyKungTxPL+FVh2iBqxciKO4eVLByZty5EOZOB4KzXIlQTM/0271EVHbnJ19ZEyK507Kv6/NSALOnkB8tBtwzaq9JFHzgAJMqyDWC0PZ6JTuyi9XhCd5J6/WZkuglLfje8pzuFSncYhCtwu7G9GHnMUl5Aow66UJeP4vW4btK3avJc5UVsFxf3wTgvxqAhg4XCr2bacnp80t+OuWv8dME/XOj/iIX9HDPejALXmnAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdOOm9UiiaLOenln27ZT2SdfvWpBYnduEm78splCn8I=;
 b=KbaBwD79/c8Cp5MXHabWYlimFZQy7gmh5AsRfZoVTAnHHRZFKtigc34JVWBDVDzaRUchVB7dC3XR1ZpTOwUtNenhySoy1AlvWBs16mgkTr4RxOJ3e3AZRWUwIlPSn7vMVBIgH2EvncFfCxqdx342/ZcwCG66gd9KpwMniXlisYAFQ7XA7ZpyDBvpfiiZ5j4Ry+o1cXmLvoCr38bH3klEDTKSUlJwyTnQmuc6Ry8gChKeZGGEqmdSUKUIs02zxBcqBk3hj9VsrSHQA89wQ8Pt4k50WpnfnkPDuQQxRn05NbwcBad5cSUxVi4x3M/FSJxD1aAWH/ifvVivBH96VeP2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdOOm9UiiaLOenln27ZT2SdfvWpBYnduEm78splCn8I=;
 b=qUtuJ/KIA/Iar+maD1T9viLsvzig7MU1z7Lo609m+4lN+O7AZBqg86Jnw5LVXITWXj6zEvU/imyk1qrSb7ZMAtXN4o4lNB1ZWMu80GGLAgaIF6ytAa+kpYDObQwnU9VsQL78U+Uu7hDD36BCvEHe7KgMsaNF1rn4lPosmctiBW4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:28:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:28:41 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/16] btrfs-progs: rename set_metadata_uuid arg to new_fsid_str
Date:   Mon, 14 Aug 2023 23:27:59 +0800
Message-Id: <d2c57612c11b014188d0aded6c06f8d30a0f8b41.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e82edc-c24c-498b-178a-08db9cdb23dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gixJAnFU6to5Dx+ZTalSyybZbC+H7NXYC7mzkzLrgxqSs+S+0d5mX5IO8MXGB55QxmgS61xXN0h+ZbFiKh7nzNSm5PqB9gPi6ocd0TE3H/XRxdIft7QzXYubPQw7cI1zFxHRIwH6rel0lXEJvqAnbEh8xpzoTzLgZN+4soOL2lug5JlJFmiOEq06PKifjwqFIHGsyhTyz7WwaLrU6mpwdn9pvAPzJrPB5iRtx6jPLB0T99u9iErXjO2mR+C6Zb9t0976ticxPYyIv7QvVK+IkKxxq44hCHeLCAs7SOC0G5kOw2Hf+h61TKvYw+r50FzzlpQstbI/feTKxDuOT9G7BEMlGvhe4j+TIFRAbKZbdblo7TDUpdDzQEQuKnTLZY7ui6Kj/r5RSy+9GLvTKdRPNgkPPmAW4JY2bMzWTLui3zdLenL7qDugMIYBNKtxdVVJh4qBh8F0u/0PkCh2sKWZVPGn354u66U9UeNiImHStitpGF3GTCDk9U7tTuFpwLDwTUeJ6PJSQ3XtB3MAeqSaekf63dC8ufYdSIUeNulQyucnw9tfm3NlfjLrkO1Dhm0b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tiSz/YSq5KrtLPFDoCHf6Tn4W6kM9VwT2Z7k0nW/n/xZwSQslvMKj+VbEghJ?=
 =?us-ascii?Q?cz/Y1uAHlxPI3XvNZwKUvzHHb85rjs2rU+yCeUNEioA9kDaswy02nttWBv6m?=
 =?us-ascii?Q?J8dFCZK74NOiqG3V4hnMXwKNGuMBi1vCZ5R25IxFkBIlfFCGCudF7Kw4LOCh?=
 =?us-ascii?Q?IvxCcsorSF2UYkd/mlq7dhptrdbf/qVsYOZHjB+uIzJ38NcYdVYCCMzwfH3z?=
 =?us-ascii?Q?+8FgdjxgqMFeYEozZrBhae1PFMTnfB/WrTOjV1DLwD9zP16HQ7fGYmY4+nmX?=
 =?us-ascii?Q?oPsUkY51WE6RR0JZWWV7pmIbrl/s9dC8IuwDi6OoBhcgUYYE+v+B6CtRfJgJ?=
 =?us-ascii?Q?iMQtmI1wPL2ewdxL2Tk5Ed4Oge9p278rB0GknY6LhQi7uN9/Nlgzd/QYbP7Y?=
 =?us-ascii?Q?ys90kI8s+gySxbsXJ7kJ+GbO8Il0eyqRfTTMm8SbmlYMZkIkmc+fX+sQ+2FN?=
 =?us-ascii?Q?sDRevyz3l/Y51UAzgr/FRtgsAzQyv8Ib3n3UmtlqzdX/6LFhksdaiuQimv4m?=
 =?us-ascii?Q?ar0TEAUJ2UTC23Fg1R4iFevaw8Fj59hv2NMaWNzE7bIw49ZALIt1MWtXC/qn?=
 =?us-ascii?Q?0glziVitpCa0a5K1S3qXI4zfl0+d7Q3BzoMLK6RFeE64h2DuO0PVpjQNeu4G?=
 =?us-ascii?Q?LRXS6No1Hxg8XCvEoCRRrPVUYaI3g7bBdEj9TAl//kwz4OH/Fzo5rWM9uuvG?=
 =?us-ascii?Q?kz+fJ7Td2QtECib/PRuOm5DPRCiDguYT9X8Kq0FfMvs2rW9pyPjenZOILZ/U?=
 =?us-ascii?Q?/U8a93Dw71EbVaUDSflceEtQj4z3OtdejtqUydMpOvaIH5o3LdSITtm8T7oz?=
 =?us-ascii?Q?2uVhkjgZpCTUIqaN+4ii5G6raGrQNd83Ply11t+FB4VniJgKFTv5COTIFRyZ?=
 =?us-ascii?Q?XdQB00s3/hiBcVmMl/S/aD8Fd5NmtAjRbMLngKlUIuTQQ/PXsx8QTK6tLDmn?=
 =?us-ascii?Q?58rLnTUa6USGCBOJjGzNMp2jD/lWBAnMYfeQEObeHTh8Y9pgQ3GIos+jKys/?=
 =?us-ascii?Q?bsU+HAu/Zyn/OVXHzauVm7stdX85UEl7wpG6ze80lvImIafIdQXuHvilxQpD?=
 =?us-ascii?Q?T6Zy87tQ4AxiDrbshxa1PL3CpjctmkHnqIk7DNvkXG0JgIAUgKIdr+ScUdt6?=
 =?us-ascii?Q?l6VE0sjaC86BgHCTwKngx2IEI27WcLQ7IG514b+RpTi6nCUz1hBT6EqJt7nv?=
 =?us-ascii?Q?H+FVNc8JmfvMu2jk8FBSu899j1hG02EohlvV73GLmb3ohwU9dgxXMzvJDHn3?=
 =?us-ascii?Q?JtJ4OXaeOY2h5RJPjaKIocpWI/4unZznpvKN03eqJbcVIotCT8t93ioTkThj?=
 =?us-ascii?Q?qAJ4uip3HNIzPB1IxGEE9mdKz+ssKXTQ/RmgCmIq9LeAX6txgZgfLk/d8z9d?=
 =?us-ascii?Q?vnk4tMvIljDyiaWGzJy74XRMKIdJDCy+b4t4KPF8iu8V2Z3HVcs13ip34v+G?=
 =?us-ascii?Q?u/IC5t2kP/9mxLbnZBV6/8k8kv9iqubhLinrTmifxJr0RCKgSWB8bJ0lNffj?=
 =?us-ascii?Q?pW2JTbO1ga8cnrbiElo3G4maQo5xrAEvcEAf6ZtfYLU2YSiaSTDFeau669Mi?=
 =?us-ascii?Q?4hlz5vcYPUIhXTB0pcwqxNQsE9Ab8Xo/c1N3oD9MKq1EuG++8/ZPC5GJnGqz?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AAqWszih8NoxpN2x33Dl0x+C/8FjK2ZlySQI0RaKI5PrxT/GsKhDzVMQmEB8ZYIq/0mpQ9LvErk56FT3MsKhzNmvimZRdhCtlcNJGVZTXRXS7km33LixLVitc6eLHOyI5j3//8S2iK3l7ygrh6avC3AHeGAzBKuxSi6mmf77saV6RRwNXpEVGuVDS+eGuocxQME1832ubnKZdQODSkzOespX1Gg3FAW3OZ75be+O1hHH+nrbALQTG8CLnZiUs4zP25sWpEDuET2Pksry6ecO481sUhPh7obAHKNwH3DeCYqCTkXg6J3/9RYcLtk6JuVpYGIDyMjg+IUKdwmPpA6cTSdXJhmHL8cz+mf7AYY19LEXl9GIDPT5Gdb8ZOzt4OSdg6PhbbimXiyopzzk+1Wm1/z3un0I8w7e5E+noDzWiFcwTYB1/nF0kwywuZ7x+qXp4tlxl8KnYrAIOLlt8/pWlyzPCaMJsrLMiHad3eukfOY2O36mzcSb/5te3PwZSJu5B8L/l+ELC41OPa3ENyVmeFe4ID5hCZcKiQmXjJKnVzFmVcbhkiDehtub97DsnUXIoY+YpZCuIDh7kefE2Rn6ZU0WPibxr+cb/KyhXjGS0xRqaoFjwtxT5DLjmvVv1gPmO1sFuPGgU/vhJYYPY9KuIcOkrLw14TzIHR44zlQxjhCw3OyaBjPTVV4akZdXBBvCwwkiJ7EC9Hq543IFaafG6mCW1a1jY8jklBuON9bAmMceqqz3qYTxiaWyhdrnCOEmIb7R4S7QM3YcF7ZiVkzc5A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e82edc-c24c-498b-178a-08db9cdb23dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:28:41.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPOPdOO0JgLLX63ihlmuBJ+b8nzsWh28bg10jU2XpEo8EgGwU/32ef+aCtj/lfEuqtKM6P+9GxmVF1pkdQgR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-ORIG-GUID: gM1D0F3W87LRBL1irsK96tvKSP-LJuUM
X-Proofpoint-GUID: gM1D0F3W87LRBL1irsK96tvKSP-LJuUM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to use check_unfinished_fsid_change() to support the
ability to reunite devices after a failed 'btrfstune -m|M' command,
%uuid_string arg is actually carries new fsid to be used. So just name
it to %new_fsid_str.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index 295308f299aa..f356de8b57ce 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -24,7 +24,7 @@
 #include "common/messages.h"
 #include "tune/tune.h"
 
-int set_metadata_uuid(struct btrfs_root *root, const char *uuid_string)
+int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 {
 	struct btrfs_super_block *disk_super;
 	uuid_t new_fsid, unused1, unused2;
@@ -50,8 +50,8 @@ int set_metadata_uuid(struct btrfs_root *root, const char *uuid_string)
 		return 1;
 	}
 
-	if (uuid_string)
-		uuid_parse(uuid_string, new_fsid);
+	if (new_fsid_string)
+		uuid_parse(new_fsid_string, new_fsid);
 	else
 		uuid_generate(new_fsid);
 
-- 
2.39.3

