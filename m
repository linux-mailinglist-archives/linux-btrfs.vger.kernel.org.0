Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9163F25DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 06:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhHTE2u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 00:28:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2798 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhHTE2u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 00:28:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K4CJ62007090;
        Fri, 20 Aug 2021 04:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=goKR7j4YGJz9hHu/zL8g8k3agM1ByRe+NZAU4qr7ED4=;
 b=MA1+owz2PAzSnyLuNuGjT2A6APvLTDP3qbN+HrvgmXA9TeM+Fi9rZ8VoL4qeleREhHYD
 4qN0aGRANpWQuzsYF9+TSEv0agS0pAAbx21N49C4Yi1HFQs0kxFVY19BJmQqUkccFgdt
 lzWV3Z392f8OA+8DU2Z5OZn7i46FsYlP0pYuJFzRHuUA4SWlDBnuMeSqjFl9TzMZnMoU
 4U6WkzCnJDZg3y/lgUifhDafxQtLNuM0fwM6XsVIAbzju1rn3snwpAUFPSIwDs3NuEmc
 h2XKwyrX0VewpqqhizYgaGnjn+3MaObIt1TX5kjjiiTUFVY+dkH1+nCvWgt3smxzCrk9 8A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=goKR7j4YGJz9hHu/zL8g8k3agM1ByRe+NZAU4qr7ED4=;
 b=uuUcOgJ63zECUJ9RxLJcNXGYCeTskd51xLcPl/L7WDkIdfY1UbTJLax0cv5h6pQUqHwD
 IenFqQ/fENQjz2EHJ6opUSbcyoREfIbM1vVQGoFuOzyhJo+yUKfF23Z/IIM0OZ3b4uYM
 dvzD/4xioSQ/r5E5YTw7fJPBNPq6s3znhi7IVSnGFKoG9kmmpZMmTILGesQvTS7nuirx
 WKaNYoEWu97vhGj4IjhbMqgrLgE8ATBxjZq2XzkXDZquv8sOqJPo/wndG0XfYt00KfPS
 OERIxVvFi0ZYCyo0Yai00SQaFsaCjtCJ9y6PS4HeZ+Z10IYptNpVuw3RjccSjA7irRHM Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmmwpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 04:28:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17K4B4xj185313;
        Fri, 20 Aug 2021 04:28:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by aserp3030.oracle.com with ESMTP id 3ae3vmu1g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 04:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRjVa7pWovL5swy4Il64+vsE/uTIzFv9SuVGn5Ph4Se8QRf2zlotu5A+bkfgLKAvTbtZyspxBIgI8cscCsUSD86ego58grd096cdOl5mXtkTNjGNfcT0QaGTAW5vgp1wLOc90SkOsGc9lyiHPo6FEXK1f1lQs5Lssuc2O/EWb7bRjd4e7RkO7H5ydERJHYGrdqzSPUR1zgJAvOdWDaBQHt7sDK+mhe5Mws2aYo1rW5CyJ8Mat4XDtG2Zh1HdYg/dOUgfTvwPyAGupYwMq8ffC2uVCERkjmUgK6Wgj/qC0WYmLZ8CXzbOiJTQhBOJu9udjrZMa8UDglq4TB3+8JkF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goKR7j4YGJz9hHu/zL8g8k3agM1ByRe+NZAU4qr7ED4=;
 b=jEIUpUCgi6FfvPqCLVqlslUD0FjR6d4kb9lrvRCkGNZugKSLDKoAIZeznTZhRYNwkp7zXu6D73lfqolPIsytUq3W6GvM+mkt4RinYzYNHA9iGp2vwhwsqjnBtBddKJmOkgoK5gEay8rG7tTB1uIlv5gOgIudBm98vGuOOWdC1HgblVrX8F/f429432D3W49q5H2mpxx7BYS/AxEkNF05YvOWm54Kt0wwP4H5JBf/960hbnpb5YPIM6RjQoQVW1MFQ90Mj/1Fq+FIZHNvylmyJJDXiMWpWHpM3QVpkYY0zW0M3EsW3M45Iqr3614+onClJVZ3nWkvZbWqxDvPc8/7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goKR7j4YGJz9hHu/zL8g8k3agM1ByRe+NZAU4qr7ED4=;
 b=PJMEdjY2fuaOSDefidAqGdPzqBBghBryY7c1zfJml9knLwCDCYF4xONxJUtFXMkFYS0QxX1K1RrlWagfSbUjjN7vW6mfOHCIYwHxiPyHU+Yfsxhb6Bq6uR2Odp89lcjfMGq3IR6md7Q76g72RXh20jk9TGbLhVByM5UumpE4ykw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5202.namprd10.prod.outlook.com (2603:10b6:208:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 20 Aug
 2021 04:28:07 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 04:28:07 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
Subject: [PATCH] btrfs: fix stale reference to __btrfs_alloc_chunk
Date:   Fri, 20 Aug 2021 12:27:52 +0800
Message-Id: <de039f41ff596a5ccd7e65f5754af6dec1f57969.1629431777.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818222837.GY5047@twin.jikos.cz>
References: <20210818222837.GY5047@twin.jikos.cz>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR03CA0120.apcprd03.prod.outlook.com (2603:1096:4:91::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend Transport; Fri, 20 Aug 2021 04:28:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f262529a-3699-4ba9-18b4-08d96392e8a0
X-MS-TrafficTypeDiagnostic: BLAPR10MB5202:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5202D429578372C0784C53AFE5C19@BLAPR10MB5202.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oH13LMNVGpkPTY/POT5GOs0ufG8wXXI6UazIwy8BV49nJFj1WFv8UDZTfJmbh3iY82KpvMjZPRvig20OtMCsbQsaHSY0AxGNQfJccYZnXRcE3o1g2vHa8n8EdfCcAAXomosNyN+OCMVjdzKusRn12kynmf/AoJZNctJbMN4/7CW1978N+Bthnzkn8rcsCtCSoQWAN3SeH1HAcvW2aMC10zX0MmkMXkfGuQsZmsnPdorw6sq6tD9PNmFFIXywbiDB0t4OWfRVMjE78ZWvpPjrt8TjZYlXAit7Hgjuh13CPKwPpi+jy3ivJMX8oqR9DRKZaycn7vQUWJ0XxpyjPQ4TtBhPRqhXtdazNg8i5pwdoBlcr+0Fr/vBygoxUsrLWjq12iD07iji9/ZjrrikO4ixFly9F8BnYOR0qcFsDLSc0Bd7vR3MxP/atZXo6mhYXDLEeDHFQjXaFGuxOrvYOEUutcdVkVjeg1prfd37RZ46Zl07fdOrYd+6Vemi9L9mrxOBWgl5Mp7KojKFC25/g2XDPFQ1T6MWNw2BX6lz+NmmiHFL2upX3cUEVtktXLUnxciL0S8F7wOo/OYu8VhHpvWSeDCdYUMmsvYLepQ39RBUgBWzJQ1OHMFo82C6AZLwu1QEpSur032pVL/BtMMgWpqnws4WJ5VQVYM3j/OrbYrcJjODg4pmVoAzQlbJuvBEsnXV/ZFrPGw2MayudiFfL1R/5bL9S2jAjPPr6leEGCM3kgcDvBN1h5IDH3sLWEaRlFDQgkiCd7zUVvQSY0bf5ymJWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(66556008)(6916009)(2616005)(316002)(5660300002)(6512007)(66476007)(956004)(66946007)(26005)(36756003)(52116002)(6486002)(966005)(478600001)(6506007)(8936002)(38350700002)(86362001)(83380400001)(38100700002)(6666004)(44832011)(2906002)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3a4+0ZpGbFP6vE3o0eBXPrvDQcwBIrmW8Mumoo/TaOjSBF2GOZ2qwA4IP/oU?=
 =?us-ascii?Q?7KzZy+vqFuVv3BXnWSA46a/vVtmDs55JRwwNsWzy8dAyoAirgoQHQzL0EVR0?=
 =?us-ascii?Q?XHFu0rWAk8duWM9lpdfGuIbukptIfFzMEHTdtOD9vveyyHrrXOKxUiLzlSpC?=
 =?us-ascii?Q?7p9BoLXJ1ZQQDyt3hFNyE4SWMiEsq94xEkwBQGtjGN5aXGwXIupl3V4ipp3O?=
 =?us-ascii?Q?+pJUvGl8XBEJOEGWOmwQh7xFp6Jz36fVUJmlxPK9V9QdgT3NOZA6iRVwevvg?=
 =?us-ascii?Q?4uOsxlrrm5RVtXsXtWUOz7CfWIlSrsqPSVb/I/RfZO6+uMh4DrQ4RyfO7AS7?=
 =?us-ascii?Q?rm0caOTX0G2MPbwVKgh2vAtnx4PhvSjrkrH+tqLwzpSXOLaiMHCn28CFqiVX?=
 =?us-ascii?Q?LeXO6JJAJnHnjZkDKVi995cD0mrdABHYdjs2CFRETONwlFDMdMYW5wXkB4CW?=
 =?us-ascii?Q?R909WrBYy1aoJ7fxwH1Rg5oRahpvfRT3fY5Iclf9FfXaGqaWUQfLOlzgQvld?=
 =?us-ascii?Q?bYxZHolbHyk8BoW+2iV4mThE0CjqGROg+L8+2tlFgQ5f/0Q2jMFV+w/9l/PI?=
 =?us-ascii?Q?o8DzOJFahnO10PJhjQrT2LWE9kHcQ4m8jfl1ChYbuZQedF+u9uIxA1gDDBdh?=
 =?us-ascii?Q?HvBU/kOIffPgt9hqENUhHVngRmRzJgxGJg0KGaU0qCEYOEcugOzM4dN0PeHa?=
 =?us-ascii?Q?vW0nD22c4bkMdY4WvSFyuFXS+GbcqbB3Kvro2qkLja2XXymSmQHsyLiKVgBR?=
 =?us-ascii?Q?TnOnMxyIvpP/vuMMgh0vMeeonkxERlfn/XTd6i4AqFgeKIBowVcUB+YBqsWI?=
 =?us-ascii?Q?M74bQCKJsGONrzSsnzXd+q0uW/a3ZrI1dWgfidvJahKJNDtMGYElZ/Mf5BLy?=
 =?us-ascii?Q?G89Gxht9mRTae6tpGQOwymyNMbhrd614VDrXqqPXYkhqgJfLtt5abN/aB6ND?=
 =?us-ascii?Q?E/q5ATybaBCTiz2eKqZGXLDxubu6AvbHgoULA5R6c0PNIq0Nm3PDGK34QuNt?=
 =?us-ascii?Q?Tn+wKzu6fod0pYE6Wh5HRfVaDXEJ5E031B61NV4aiBPJsMmLxlMTFz6nvuAY?=
 =?us-ascii?Q?5qA/KfGabl0epRlojRKGNlgP8ZM3IOB1TGdncG7B5rK346nCv5Y4CeKRhAxa?=
 =?us-ascii?Q?xS40yvcrjfN0HI21cim0JNKeje2LmHIq/MGJA3DLollP3cPzRPLhEUbqB2pC?=
 =?us-ascii?Q?KqbhHhXDgD+ZIymR+d0im3cTny3lNWYMRKxuDWkErYQoHcS6k9AFWZVsUkWH?=
 =?us-ascii?Q?sCVgpEvfgOVE8Iuisqbj7wBigOLiGUgreA3vL2jT0HrIxeUkVRTkqmYXcR6o?=
 =?us-ascii?Q?yjCDLu9ebUkZlL6Sf/+2qGwo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f262529a-3699-4ba9-18b4-08d96392e8a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 04:28:07.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPo+oMocwELhvJ2nMyqtC1PlS6jcUhdzTZ73T/XZY1GniaVGEHjnuIw4rDPBcFGbaLz3hfkd0yMx/01pGH2MdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5202
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200021
X-Proofpoint-ORIG-GUID: -x2htnsRbuhLpjDrVm4DKAinyDHINAje
X-Proofpoint-GUID: -x2htnsRbuhLpjDrVm4DKAinyDHINAje
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__btrfs_alloc_chunk() is renamed to btrfs_alloc_chunk() and then to
btrfs_create_chunk() in the commits 11c67b1a40b0 and ad6b24de1d50
respectively. And left the stale reference to __btrfs_alloc_chunk().
Fix them.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

David/Nikolay,

I commented about this earlier [1]

 [1]
 https://patchwork.kernel.org/project/linux-btrfs/patch/20210705091643.3404691-1-nborisov@suse.com/

I am fine if you want to rollup this patch to the patch (btrfs: rename
btrfs_alloc_chunk to btrfs_create_chunk) and add my RB, or add this patch
as a new one.

Thx.

 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/zoned.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f3a958a214ff..f915c1d6bb9b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4941,7 +4941,7 @@ static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
 }
 
 /*
- * Structure used internally for __btrfs_alloc_chunk() function.
+ * Structure used internally for btrfs_create_chunk() function.
  * Wraps needed parameters.
  */
 struct alloc_chunk_ctl {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 47af1ab3bf12..90d9df131fc1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -585,7 +585,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 	/*
 	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
-	 * __btrfs_alloc_chunk(). Since we want stripe_len == zone_size,
+	 * btrfs_create_chunk(). Since we want stripe_len == zone_size,
 	 * check the alignment here.
 	 */
 	if (!IS_ALIGNED(zone_size, BTRFS_STRIPE_LEN)) {
-- 
2.31.1

