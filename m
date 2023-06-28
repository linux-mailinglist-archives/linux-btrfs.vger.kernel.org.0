Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9C74108F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjF1L4q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:56:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26326 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231770AbjF1L4e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:56:34 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTa0i022253
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=Z/w5Y5SvI5SPpwNkOFxVJ/2dcoWp1m88XWcXV63rX6c=;
 b=nfjjCaDGgnpi+eD8en1dsaoEpgAMfvQ2X6IfUZgSFkcoJMz/ajtktYbYZMZOG1Gtg133
 OhGaMJ0IW/IsyMm7TSPnzwOVXoo8WNm69xD9EAirj6ITsdagAMW6fuIC28LqiFVOoUXu
 przJC+4eWQrzwtmS9EzWhdSiznZQLvtGuRlAdCXO0qHJGZRCughlDptXo6svCPJh7dtA
 fc/BqbuSZBJlYJNmB8Afg9miRLMW0URr02CtU1n+nIclZNVhKmLrnQuCUadn3J+aZcwH
 zr9X6R6rmDrrDJmvE6C8HdE+xVWI5JGBJO8wkevScuwAYN9l4/hn+RNoJrBFL32EY9Rm AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtq9xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SAVTbK008742
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5wdyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcysLYgchd4crDauh4I04+ZwUApccj71uqXpmvEhF3lB63fXsV9GQxMvOPmvThbrF3PDUfz28uSdjwC9CUxAgg2F1K76CutRzd79kodM7gox3gGiej7ECFW/x2Y9QlRKqMU/ZL0KUNPy6wqpGCKTCiowNoHlPgzcH/hfW73/Kq3ueI6qjATP4n9u+QmBXXRzDbKWmcuh36gZkRe2cld0sdI5jClan7+0VoKVXSf41z5ZKHqalrLYLZOVSIy8j4/u/2yCEeSkkU2/+PvBy4rAaXJ0FGvk9FfKLV1aVPfOgSnR9ZOjc3BtOim9s9xAaEhkE7YDoSfDsvm7ePmn36xrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/w5Y5SvI5SPpwNkOFxVJ/2dcoWp1m88XWcXV63rX6c=;
 b=VJnzwJTOZ70gzpUOPzrme7T9QBo5c8TlvgHvRYbJb3gsA8JOI9LIdPE20UA5rQ+WKLA6cOktl+ymfpXowh7266TeosjZicTN/19NwYDxb7yyewLf7O4q4/4u75sINyGw2lR3HgcVaJX5TkFua9P4zljd12nje197XLp4WiF/J0JqvLVeGSWfsZDn+splhL3pGdMY6z0zeb439LAvye0lFmexBfr20wPmh/ZM8uUMeCUdF4aLWT2GpoEVl0dPRMlL4a4A9UNZdUBbBUk6nbLEodf7VT9Xa3yodklc8N4QB7/srnO7eWR9kMvcCCCJP7XnPkBCveSDKBoT26xU++o9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/w5Y5SvI5SPpwNkOFxVJ/2dcoWp1m88XWcXV63rX6c=;
 b=pOjSdCCh3iMzdeb6uB1KZ4mvq/D9Rgb+r66Hrj9TQv1DXLXQ1j4e9NbQt+g+H3nZEivCt1YEYyHGPdtljdBy9YgRlrp/RNgn+FFVskKkX08tq0Ic8ZBf/lJ8vfK8yNO5XUS6AGApDQHL/Sc/+ot+S65MC0Yh36yqOPGQ/pyz2Rg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:56:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:56:31 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/10] btrfs-progs: common: add --device option helpers
Date:   Wed, 28 Jun 2023 19:56:08 +0800
Message-Id: <b369f8c90aabf121c53533ff60004b14cb19ec7b.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de7c461-6370-4684-03ac-08db77ceb672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51SNcQt0QUV/ckhS4EWbgUnG/FjrbxC/kINJQhVlcAqMIwMDtAoSZ5Tx4hph/QSl2gxzQfTuXXLnq4s54eJjyoZzS51XVV/eEH2GknGmBavee6YGmRqpuztORsVgqV3pvtFqmK43N6UBQ2gvr4xig1sobvpV2owfmb4rugas16pVgtz5GMulOJKtmVqHM8LuQnmGVCAy1pmMMd32LGAKL+9gN9tCwH4yKvNXsfVRMB3lbaIlOgEDA6dZzCRsbhE3BZ/YbB3m+Wvs4U56XXJalCmFqGPjuiV2dOR+/atBp2wGITK63HeaTg+M4VJNlyVkjz7Io2cgv7oMRyrYZKsxVUKQY4srZYfrbzJtq2t8QqLBCjdCQKNvtQ4KsmogYSNjs5VzGo9wlMgj7tN8u7P+D4hYJZIupU6bBj/g20mH/43CQrqYx+m1Qe8S4CAZZadQZUOqxVW4j68DmgkjGpvYtCJGeNkiLcdX9GFkBg2AbnIjdhFi44CqXHAdfJPOf+ydFTDEK8ZEvt6Iku51M/Igd0VcUvoc0IQZb9f8GQSkJz6jMgkU89m8W0dvGik7NInq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(6512007)(26005)(2906002)(83380400001)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/JqEG5aPtanCmxvAcq4m9I1rD0l1Z9UnmUCeux6BApoGF2MnILX288Xw3r84?=
 =?us-ascii?Q?/3KlhBGzeMjjJIrUZfDUXV+DTIktaWQrW1qNG1FKN1UkpLyCpfAwyxttlV0a?=
 =?us-ascii?Q?yRZy/6gJcEHFSqZtTnF55vfz0ZcUuolUWDYeyRTBd8ohnPR5XL8Eiaku11CG?=
 =?us-ascii?Q?coeXl6FIlBd5N823DfU1z8DDnhFLDJbULhz4PDxMSeNibgRVMUl/2nmGJ9YU?=
 =?us-ascii?Q?Ds8a90h5Pwn2vR+brLLXEHShwroQ07NkTxWercJQCa8M1BQFfYog9cL6SlwZ?=
 =?us-ascii?Q?lm35u9Rfo2CTMpKkzEIv16NbWz5yU9nVc+16WpjZ6SOpZ6N2e8dHtlN1Ks9Y?=
 =?us-ascii?Q?cOTPhT0G7x8T5LpiZ3cXlUUcsUqq1gLniYtW+E1sPaVFkYIsO09HrBTnzn1x?=
 =?us-ascii?Q?+cbYoNCUMG6TezGvQqavME/Yj8IOrDBh679Tnpbh1MeXoEiyVUQ4+Vi/9Bul?=
 =?us-ascii?Q?OuORMi/o1b4PrDeFn/ngcx9itp4feMoi9AyPsGT1inG3zqc7BunxgK90yNVX?=
 =?us-ascii?Q?UbpYjTybyGORsziceSMZIcuujmh4x0+pd774Or2/Z9sRnC4aJo60+r2RW3if?=
 =?us-ascii?Q?M5H4s1I1m2QLBREWk7D2Dx+7TNZ/1st4M6bckxsgzxF7jwJ9VpnZFBkodCTK?=
 =?us-ascii?Q?TKhcaBs29uiEhN+3KHy+MfWWxB33goMoIAgfogNrpR/LEAVuVMiugLbDBEMb?=
 =?us-ascii?Q?TD46DiDkle2h+PrUvqZrlGRLKbG+ZO375aZT7d6Alrsi0YSg9IhV8Mxx58S4?=
 =?us-ascii?Q?JOnK3uQCFcxH88BRfI9x31tQPUbEotz0rlucUl0JyOiwc9VBlU+eUaOBuRuR?=
 =?us-ascii?Q?iVH95JPUJmUV/0xk1K+E/NKZ/+A8We1TnITmwFakT+fZe6C1TgYSEEvk4u7h?=
 =?us-ascii?Q?KhpGjs5QyMn0trcJTvsNaAN4i2+bl9jj4Kq9+No32iAcZL7Y5AV16jSSISnM?=
 =?us-ascii?Q?XW+5oXjZ0KK8sYhu95Jft1ziz6EBuPVQ4+QtrdpmAvdmz8uhMe1baSSQ5d8q?=
 =?us-ascii?Q?Z1V5rdn/u6j5/QLwk8EY5CkE4EgKDmvKOSeUlagBgCS/P5GSfid6MhGKAO47?=
 =?us-ascii?Q?h/RgMzLcuecrMxWK7SXfRApGOhhgbzE1CHI9229bMt2m0U+sh0x+SNyS6Da1?=
 =?us-ascii?Q?PYLAq7kVgDK8PVVM05wU7jAGS/ujzeQLUjbOddi7rJboYijE3+grgDTBgqFJ?=
 =?us-ascii?Q?56EU6lMrfBhcZJJm894xhp3bhFx1XDiLKBH1Zr0RkIuQukHZ0r2yuJtGeg5p?=
 =?us-ascii?Q?UEifUBpcQvLPcX7pfwY0TF6QVhelwLkMn21gF/p3nWUBFwmnZg9VfxN0weAb?=
 =?us-ascii?Q?Lboz7eOsTove2Hu8IsdrZRr5wBTZXGFz/XdcoUt8pNG5TbJPIwL9YV/nqOiw?=
 =?us-ascii?Q?qooMpaylrQ7nXGLXeE3rj3CGypnkE1bfqFaDvuRBJeT62ReHkanj0ZykzeXf?=
 =?us-ascii?Q?BTLtyfOhjbCiroqsI/XD8/6qRXGnLx7zaz0AJMsF3dJnJ8nQoDbO33dzRGLR?=
 =?us-ascii?Q?uGLP3ZUxkL5LjaAWRf8oQbUiRBrGzh8pTDYOKmVbqRqi5c2RAbbaWaWLG36J?=
 =?us-ascii?Q?6FrQPCedPXB85xGPcXgifJfOlKOQNUuihwGHJftB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G2ZVbr65hM3Ll1FpXNVTNklAyCjAICkKkqznvfD5ksx4TT6eYFIP6C3r6yhEJcbPcONcdxE2LoQnMTp39WmybxHQBbzzr7ZK8DO8Ja0E4kYEs5uTN3k1SZZs0wBIjUt4idRCoiO8HpC5m7t99WmyPVLI14fsL0uKDBIZcDvSTWRalj4TOQ8PlKBRIl/NTNjEAQASFYuZlUL76A4ZF+UKksEHknAU6apw2JoRdLh0tsLjbk44Xm4lBVsssQj73CxwpH0Fi4WP6qD086l4lPH/wLNJPpG6ft/eZcuFCYW8wiMwk6LM5Yd8CjVsJD1Znqndgz9uwiVDaakWK2gAt12oIwOsWvvTiyzVGPlZfheV4Ni8vMRIL88Seyk5iJ0vX5+Hf13vcCRb3VPpLrDKLyhvbO5ssmSem956BMYOXB68fsIG/cQlNNb+PMqSTlrUP7msUiweHGtK80sb9aWNRVRIExG/p/0VfL7iUQWNgDWCm8jMjcaMpdl8OcVRKjWADcrD4VokMZEmEuovQkSvBKMMZ8qyRgoePfbUZLXDef4TdTejdalURB/2YCla48uTo0tTe4VJ3eBWdFa4skmaPteuwMPViXWWEsQ3p6oNFW6q0LJjqQZfrQ1WLtnkE5HAw9nIhyUT4Vt2c5PTPy9wYhrWjmlpbSyiLmHBVxUwVs0VE5YztKLF6zUzG1A86SLoEzYYTnx18c2sYmdac5GUSL2RbVOKfoFybL5qBmrjGpNq2X5PTIUPoMJ4+KdH4V0NYUYK2TGO4x00eLULLIVVzUDQ1w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de7c461-6370-4684-03ac-08db77ceb672
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:56:31.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAbvTZOk+9E8GDbhLAGAmc4cRoasOlWRgiRywF2WqSFGdYqF610n3w/nP1SOEfYXtBOGjb0zF22aEKpS97TVxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280105
X-Proofpoint-GUID: VZAFPMqLMXlJzA-UCi2vujw2VDOLq3Pm
X-Proofpoint-ORIG-GUID: VZAFPMqLMXlJzA-UCi2vujw2VDOLq3Pm
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparatory patch adds two helper functions: array_append() and free_array(),
which facilitate reading the device list provided at the --device option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/device-scan.c | 32 ++++++++++++++++++++++++++++++++
 common/device-scan.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/common/device-scan.c b/common/device-scan.c
index 68b94ecd9d77..ba11c58d00d2 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -31,6 +31,7 @@
 #include <dirent.h>
 #include <limits.h>
 #include <stdbool.h>
+#include <ctype.h>
 #include <blkid/blkid.h>
 #include <uuid/uuid.h>
 #ifdef HAVE_LIBUDEV
@@ -540,3 +541,34 @@ int btrfs_scan_argv_devices(int dev_optind, int dev_argc, char **dev_argv)
 
 	return 0;
 }
+
+bool array_append(char **dest, char *src, int *cnt)
+{
+	char *this_tok = strtok(src, ",");
+	int ret_cnt = *cnt;
+
+	while(this_tok != NULL) {
+		ret_cnt++;
+		dest = realloc(dest, sizeof(char *) * ret_cnt);
+		if (!dest)
+			return false;
+
+		dest[ret_cnt - 1] = strdup(this_tok);
+		*cnt = ret_cnt;
+
+		this_tok = strtok(NULL, ",");
+	}
+
+	return true;
+}
+
+void free_array(char **prt, int cnt)
+{
+	if (!prt)
+		return;
+
+	for (int i = 0; i < cnt; i++)
+		free(prt[i]);
+
+	free(prt);
+}
diff --git a/common/device-scan.h b/common/device-scan.h
index 0d0f081134f2..d3b5f7d2753f 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -59,5 +59,7 @@ int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[],
 void free_seen_fsid(struct seen_fsid *seen_fsid_hash[]);
 int test_uuid_unique(const char *uuid_str);
 int btrfs_scan_argv_devices(int dev_optind, int argc, char **argv);
+bool array_append(char **dest, char *src, int *cnt);
+void free_array(char **prt, int cnt);
 
 #endif
-- 
2.31.1

