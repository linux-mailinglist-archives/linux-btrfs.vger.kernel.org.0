Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A441D9A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349694AbhI3MUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 08:20:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43012 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349223AbhI3MUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 08:20:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UCEQoI008978
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 12:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=xy8RgjHUr9o+XRbQj131QjQgFoTWuvJUCIXdD1WL3ug=;
 b=Kv8R02lwg03RhJvxzkr2TTTaTOTA7TlhKUqiiAEqhAgkMDUk9zsALUMJGa4121amAXaE
 s+cUvu/oioT4/+2VhJafC8fMSlXH3U1ZKBlKkS4bGg4PKyM9ubVssSXvEfWYFv46A55A
 /nVBHq8JxX75A08uwqJ5hOuipuyAsUgp+JpP5EFen3QRC7o+9xHuXhFPGuqmW2ekyv2V
 Va+CV8kx3TmwP0v+owBp/VxSxLwPRQGzCdy2RGj1zJgTt9LXcymmQio04EZpi0hXcL1U
 JgLI7TR7HhPNPh8hRc0Dp3JkQXGYud93UcHvs3HfOgctBBD+KvLVHU6HOViqzSDEhv20 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdb2dgrvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 12:19:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UCFAkN017003
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 12:19:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 3bd5wb0bkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 12:19:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvaOb8PBSfCfQF3FfE+y7V7clU9QPpg416zz1FIrnH0fF/EVcwG6V1n79iXZdTH6YdVGkZq14Oz2UEIWAjqSP7RbcWmKQi1RvVy8cdlPJEQwm+uyAnD85KwbsPBSFBPTkqJD8fZq7TKAleZFEo9i3Kf/9GoiteCh6uo72nn/AA8y/N5d74YenKRZ72Tp1Goknqf7jjDZ1J9pL/p3IVrPZmL60hYsGzbwo854X4FwOWAgEgczbS7nyHlC9rh3W5BTsDJBNVLvv+I3PlvuZKUNCTVK2XRpan3aqrY402soBxEsgcEaG1lDz3hKkm9NI3LeKzD2POVGDO8bJbBTtixDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xy8RgjHUr9o+XRbQj131QjQgFoTWuvJUCIXdD1WL3ug=;
 b=C9MyhVgyBITEkC2MuoikJGNJC+QrBCzvH4TJ2/IiXw4jghqOVvKi10nKi9ZiSjeduZGI0jJYcd17Epe6ZEgSA6vAuCGiTSYi4UbC9evck7Q15xB8JF8NnvVRPCcbwop0ErLcPl9fgrcEdq9oS6XAfHg+Fuh5VEU74LqmgVAM6ZJvNczcvvfNlSus5+F3nsuDAk4jL8wO3QqCkgyZncHpL48laNiCxcLjQ6mjpCcut4MEWvQdYcHXfjvpOd/3836RsUYn4kaO8ELCyjRy5UfUuWTUQEVkd03W63ypIBK7Spdxo2g99JZeNC78Bs8Sh2+oq/pj5hDHw4OP7ci7gNwgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy8RgjHUr9o+XRbQj131QjQgFoTWuvJUCIXdD1WL3ug=;
 b=XwplsalMfTjgbvYtNTogiiFVVhD8K3NawN6R8sjH8TZyJ4mTLpxDXXkdlRjhLv+il91avcAM0mVgA8bZ2wUxKOzgvvKpOHz99ysDNmPMO72TlkKoHHKikaULNDAY/uMJi2e1aJTxs8iIS73U29rEgrXlSYKwIw9uMtooVtAvvFo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 12:19:09 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 12:19:09 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix comments in cmd_filesystem_show
Date:   Thu, 30 Sep 2021 20:18:55 +0800
Message-Id: <4a67a664fc39059bbd566d4bce7eaf2471efd9ce.1632972069.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 12:19:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0aff382-0c99-4a97-7990-08d9840c8139
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:
X-Microsoft-Antispam-PRVS: <BLAPR10MB504188C446BF2EBB4030FF5AE5AA9@BLAPR10MB5041.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEsxt9N9JrDXkwVGN0DRz1TEXdQf5MnlmJAw81bO68JeqQWuiwGdiBlmuKzBS2TRpt+cdkuKcKaVZVEiQyASU5FV5i+zJ3u3bBhwMsrahEPeOZBV/BQBuPoNRoHtBYKEXtb3Xv1TvZeLJqQdqedKw1/UdAQEglHqI+5MuvCuTtTu4X+SlIK+78hfV5Y+QGelMFEyv4u9A5gfRuBuYyFo7/1Os+kE3V4Oung7bGic7fhQ4qh2IMlmPiB/eX8yt5SkPRtZxBpX2pFuN6kt0liOoWX5AYKj0Kduiqrr6CrpaX1RX0KKMm7JPQYlM8wp4LuWuKt930vsS8V5RlYFkmULdQ5yeGMe0WDpo2qU1Q/xT38aD1h/rJu50Na76WVeCq82UXbdBX/2s97ipmIKEAjzofiPyCy8GjYxHpckGmqgpxkMNFa6pVaGQzX0YusiKgX2emi3QLUmvbBiPDqGpaFf7gVemxweuN/VRMtRRNt6ug2nEcoGevMgjqqn7i90SxkOFw/r9u5SaCVFdwToaiCFOD84gR3jBuQSJBKWwBNcrNAzc7NOvir+6qZZsDiCJkTwhRrdh7cqYiInqKTxRizOHZIjp6VkY81u8paxgxj2GZhHV6EZOh9UfZslTl1QDexFPiZ83jUgV0ldRw6wbXHWNZaA8piE9BU1yY7aUSjwfMMiwcZNHK5SgaCK/P6i6+nz7OOWQ79hfy0Bq4cniSlUuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(8676002)(2906002)(36756003)(38100700002)(38350700002)(316002)(83380400001)(86362001)(5660300002)(956004)(2616005)(6506007)(44832011)(8936002)(6512007)(6486002)(26005)(186003)(66476007)(52116002)(66946007)(508600001)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I5txZLJtrkkpc4F3KqMMg8HfdA21DWk2ePZWh6sbPCJLodgJ7cmunmVj8iq+?=
 =?us-ascii?Q?EIit22yjkDnsbLVUQ9wwKk0RAHcOjRvv5xk6arL+hU6S53Po+XzsIu2TFe13?=
 =?us-ascii?Q?QyJSHlzq4kXbtJR2IJhSLSkMRwGVIMMyFcR6+hl4q82YCMuxO/K3zSCxXYCS?=
 =?us-ascii?Q?ED4ZKpipKdnPpLjMQe/bTJS0nF8jVJkjnQQMgyFJriqRQ7o2YssyLngMqHx8?=
 =?us-ascii?Q?01DJ3eYwxTE3J6RMVqA8/RQHrsnC0CH90VfgFJ3DL8uHIKu5xC/O5w5UoQPN?=
 =?us-ascii?Q?5jjpoxP1rQhcRGk62vWHMwvZf2mjk3SMdJssjqRxCsnE3axOitd7O2LYCz/8?=
 =?us-ascii?Q?wXfeQlzMqFxR3/Aet1IIOLJ3jhqhsGi104oqr/oUDj6M+1POF+bGxE8QnUuu?=
 =?us-ascii?Q?klwdcPfcI+rCQntcLyU+Xk1DRx8SI4EDR2E7FRbm0UIVvDBJ2imJazmaVzla?=
 =?us-ascii?Q?oRo1hT7oSoiuB+IyHZpoxscBF+iTulqvyp/AWXFcA0PGMblO3vBSZ+4n8U7o?=
 =?us-ascii?Q?Nn7/7CS8AR3U0UDE/DeXYVeVtXosa0mrbaqzA934iGx/GtW4SDwQnmnb0MYd?=
 =?us-ascii?Q?3U2BQjhk/5xGKkBpcXuAatWqcb4F/6PvBVugOcQCRp/dyROji2/693Nh1Ve+?=
 =?us-ascii?Q?+1J5+iVBEB2G95hv2cTwy+wv/Q/DChAMI7jznzxgIPvjiSa/LmO2jYl8q6sC?=
 =?us-ascii?Q?0NgMIxNEokuc1uC+9i+BQHDYPQ/bdex8Z0KbYD+M49lj2y0RjJ5VIfYSaKyK?=
 =?us-ascii?Q?MytVuUVZECYReLQTv6gtIn/MoYgFuLJ1/N/sI6DGgcOc07PN3BasHmAGvV5e?=
 =?us-ascii?Q?Sr/YxxAbZ+MduBFa7LIMlg80l3kkn3sHR3kFuFJpyOq8enZjMH8K31zAni7l?=
 =?us-ascii?Q?N+9GWQCj3CFJb/gSo6ZZL/El0nwHIVX5JHgXLgPU8uyb35rKv2jX2KblwYDu?=
 =?us-ascii?Q?H4OQsylL9KrDE/RgBiJ4+PnEBiDl9JJvJ6ArJT4Qs+f+WAaYJUQls8rvXL/T?=
 =?us-ascii?Q?xjvEouoNBDX4IAVeTdi+tzomF0d3GBGGCSOAc+Nsl8Rffr/++Fi67io/vTas?=
 =?us-ascii?Q?anaONUTqpavlTnLb5eZSVzXo0k/jq9pTv+Eb0OIiIltQLvMcMtyeRhkh/ptE?=
 =?us-ascii?Q?qwg/c0gnbUvvdhp77wsF38hYJ2KgNwCzY0bDFx1wv5ZH8WeRa7aw54G8OfaS?=
 =?us-ascii?Q?s1A2a2oUJKljuA0bIC52AOD7xi88u6AdhdjsYqZ661OfZGrfbQrBmevtdt6o?=
 =?us-ascii?Q?5YF1os0l8rlR0fjyoZs/s3EYgtYJUZuQdvddtnqjI9Mv+4+6IiAaCx1HRoPc?=
 =?us-ascii?Q?wbn4IsN9eegK344N9dYfWBKI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0aff382-0c99-4a97-7990-08d9840c8139
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 12:19:09.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PtWxlhqfvSenEqEiR8e1GZpDXWuJCIN1Hb6ZUB571Xg8Nil7CBW9aznnt38e4/n6e/mB+jQDJ6wlKOgl0lLNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5041
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300078
X-Proofpoint-GUID: yBhMKD70VfrGxFw2MzG9hnnEktVrlYpo
X-Proofpoint-ORIG-GUID: yBhMKD70VfrGxFw2MzG9hnnEktVrlYpo
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had to go back to find what BTRFS_ARG_REG is, add a comment for that.

And, search_umounted_fs_uuids() is also to find the seed device, so bring
the related comment above it.

No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/filesystem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f123d25320f..2a5ca8ddd4f9 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -753,6 +753,7 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
 devs_only:
 	if (type == BTRFS_ARG_REG) {
 		/*
+		 * Given input (search) is regular file.
 		 * We don't close the fs_info because it will free the device,
 		 * this is not a long-running process so it's fine
 		 */
@@ -769,16 +770,17 @@ devs_only:
 		return 1;
 	}
 
+	/*
+	 * The seed/sprout mappings are not detected yet, do mapping build for
+	 * all umounted fs. But first, copy all unmounted UUIDs only to
+	 * all_uuids.
+	 */
 	ret = search_umounted_fs_uuids(&all_uuids, search, &found);
 	if (ret < 0) {
 		error("searching target device returned error %d", ret);
 		return 1;
 	}
 
-	/*
-	 * The seed/sprout mapping are not detected yet,
-	 * do mapping build for all umounted fs
-	 */
 	ret = map_seed_devices(&all_uuids);
 	if (ret) {
 		error("mapping seed devices returned error %d", ret);
-- 
2.31.1

