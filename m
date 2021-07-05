Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8583BB9D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 11:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhGEJJU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 05:09:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22476 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230121AbhGEJJU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Jul 2021 05:09:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16596goN032460
        for <linux-btrfs@vger.kernel.org>; Mon, 5 Jul 2021 09:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=AYwYLxCVcolz2lwvVGLbAlYeoiATipmXqOiz+IRkJvM=;
 b=T5Lwn+OcBtdQrGwd5wHYTzw8+RovU2NhWOUTvNZ5HIGhY+5cx/9rL6l7VzYygojpDObY
 xXoLQ5nU0CtXGwsmWZrfM+elJSsGb6lR3FNV6i5/V2FP702of7wVM5yj7chsKbOb7dOH
 xBflS9PO2Y6+G0esNLoK8oya5cSwIv5XHMIigrbziJmvYFW15m/InpZk8XMUpnGGiHE5
 qukdpk9//8CEC0NoxYQKWdWkY06QCY38d6CT7vK2Rc0sqZI+bFDGO4EJdIqEOTcprLoj
 kPKNSa928T5peKhWfjaWBoLGT6+XMWbiHw2yEqT/i/77sdofu+RXym5RSNY8oAF0xfbI OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jep1j6sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 09:06:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16596PaS126250
        for <linux-btrfs@vger.kernel.org>; Mon, 5 Jul 2021 09:06:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 39k1nsu46w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 09:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhfBDVep7C2X9T1YEjzZlxUyb08GgmaQhYdXcDHX6ct1FGXhAP8fmpVxUhQVsiELu/JK1CkDN8lfekB+yffCimNBzI58eLmHQTb6chFc4kaaEH3YGkSFUxDYFudY92eFQcf5qqIYhN0GJdvX/HI73BEjXHJjGIK522vuIrKLoelaEgVnAApc/WXnINgvJQa1QsetBa2Msv+3eaNHaCVqP3bW6KyNiGzlLPKDazMknNKsC4/EaIN9FD328ObJf+RFx9tomlgvM3T+Ejp0BJsJFGKOs4KbDa7t3R4rudJo0qFDabkalFxpm5+AmvH5GPNfrne6OzTGeQcW0L5OGrJvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYwYLxCVcolz2lwvVGLbAlYeoiATipmXqOiz+IRkJvM=;
 b=m+wf0V5yqLNZV82KCBOpHq6FHjJo96q/rgikPSZIEh7H73DuK7f9RMyo5x0k2JD9OdELA9b6kr3/n4C+oevh5J3YoXPuUckOmhfQAZoZJTJntTQn70NwLKVo1XeeiIslmNPaKDkjMR9W9dJeHlwfCh5VUCjpNqt5QCD0i0DlUgLwaZUQ3AvbRoskGIIaI/RAhe0FQGTYRIomcvv/e1xnfHWV4Yw7NoKF2hSEYrh3ziAmXAv9vHN5gUjWtf5w/obcI5mEpW9XS5D89eXl6wqf3HvtXa6dTX7OVkayq2+aNsDdOjdCocUObER6r64uBqw+GnsJS7+BCTd2pBf8HOmHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYwYLxCVcolz2lwvVGLbAlYeoiATipmXqOiz+IRkJvM=;
 b=ivCZ/JqNN/cidNpav+cuEF5puAVrNBLGI7L2QOeyZCVo23d6qX1VhUyXYNgHj4HyrBOS69Uv6QrdCnjNVEid8g5rtxKqPVj3Wj1Z3ASKb6NRV21LdEBJo3OGbomSuoyWplW0t0vRT/wZAa+WySdIM059YG2WepWYs/P4BNg0bro=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3968.namprd10.prod.outlook.com (2603:10b6:208:1ba::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Mon, 5 Jul
 2021 09:06:34 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 09:06:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: check-integrity.c: drop unnecessary function prototype
Date:   Mon,  5 Jul 2021 17:06:18 +0800
Message-Id: <4c86a5893d4d89f71e99f531b27728680f9c9e1b.1625475957.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0146.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 09:06:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a475d5a-81c7-432e-883e-08d93f942fcf
X-MS-TrafficTypeDiagnostic: MN2PR10MB3968:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3968AADD7EC6DBF8847A089FE51C9@MN2PR10MB3968.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iRd4O2W3xAk8EQYVRjTU+HY+Ofb0MhjK0xh+sNgqVMCzvQpa2fThDWtR69pNWKrDbLMIimVpDULkTdk9e8Ochx8keXancm9IgvsmIKYcyS2yL7AiFKaf0X721mXkRNLl/hpu6PNshAzPlvJFes8u6Lzw2bFOQeuhKOZSJQ2KaI85hJBb8SO6hhybtMevUkRgWAxj0mhrEEJQY47tMKfUNd8ebhN/FH8TIAO4IZRg0R9d/CgBgOaCHvAjSXu3QKw/D8sVkzICYw1AMqSQhfGbmB34bFX0/fqMn2sk634xlhH5eQgLiFa+sZbgAcYWEA/Bb2wuYMnLbuW1+1skY0IP/9bljnx6+BFx1fj9RuYfvY6v0yYGZANuIaR0AhydNxRsK+/MkgdHJ/sOJrhREX2KVA6gNQ4AKdqp6bqw1MQetDM7Slb+q3KHWnJ/AGt0FrdLtz2DAGyQQD1RL0kwkIGIixHvDL8uViyhB11c9SIrLNue3bIM/59ddO4zxRAmVeKuvR74iscj9JgHm5ruoo5nokf9bzp7zu/iOqzXgAHS8c1lue50HrB/6w9wv8Q2dbUayQq10/+SKEM7sKxvo+1hr68i9Qi5kWSIEJ/N+OjoXQw9BpWs5NgWe5VJ96r++5D9yyoNYSuNuy2iKp2DSlqAaQzAhGOu+lGP5XGgiH1Xlezm6AUlVpvPwgK2nPJGplt3pIT5m8gAMCtLi++2nbnxEsgvZ7uNs8MJUOZRV37EAjt2F7MYFfX/7H7pCu4bUic
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(136003)(366004)(26005)(6666004)(6486002)(478600001)(44832011)(316002)(5660300002)(8676002)(2616005)(66476007)(6916009)(2906002)(66946007)(8936002)(6512007)(956004)(86362001)(36756003)(38350700002)(38100700002)(66556008)(186003)(52116002)(83380400001)(16526019)(6506007)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6LLgpDkP1q3Z7acSLzCG+JcDm7cyDMYnEizyX91zqLtB53HwUZN2JwUtbYa?=
 =?us-ascii?Q?csyNnAZp8CenTRocAmzRYU7+Pi/7tCE0KCkN/hkZMXB8gi/VSJAMGsJEZuwh?=
 =?us-ascii?Q?vDvey/pd1u0jtIN/7sw1JV21N+mrCVqPcZA0Qppd6pb/BDt8UGWtID81r60l?=
 =?us-ascii?Q?HKmhtIYvBgjLxvF86hzzm373qa5oJ0qB4IWS9e3XbpZ0echNpEHopgjAB3+h?=
 =?us-ascii?Q?hZP0wFSjDoUjQ7uxn/yLQMO63ZMEI2RRkhejEcmJkbjTXWxeI/kUAiI3nfts?=
 =?us-ascii?Q?WZGjX1TJbW/JNDcxPKn219zXY/uj6tR0eoZJgVShIMaSVuq0I9hc0FbbFi7o?=
 =?us-ascii?Q?K3c9Ba93VzO4JTYK19Ngdl2At3ICxWOxXK1wXzzh0Uu3QqBQ1rNjnXA/C24M?=
 =?us-ascii?Q?J9Tb3lnPTwSKDuc9l0aPxYlj7gWvEPx0ngnP241DMdOD5GCZFOOoPmJx0lKv?=
 =?us-ascii?Q?fJFr/9oWLrnamgHhdzWHs7cXux44ysQw9KNMruDPZDY3uwvBh0/24vzhlMpM?=
 =?us-ascii?Q?DrhbZDCyEbrISUgixKcjgdxbqqWGg2r3lxI1pCYP0w6ERqtujW9jsU/z8sj5?=
 =?us-ascii?Q?RiJQz3qx/VP3i4t10BcTgqVGLnGwgpVw3cBvQ8JyR4eO9Q0ww0zY3BPg6fys?=
 =?us-ascii?Q?LdO4T76iGEeoqXLbvFoAjM1CKuEnavnXUeriJsW6JgB/QbCWCCeZ2Mxv+9WB?=
 =?us-ascii?Q?VF+/K5VMWZUoS9AzaNsST4yaI56uwsv4rRboxYCkROJJToC1eBGgo/RCnU2z?=
 =?us-ascii?Q?ktiUKmvA/jqHr2WBKqAEp1ST5dyLJcv7o44rrGrTFWZMAYPMwvo2Pfr6VBfv?=
 =?us-ascii?Q?+o1QG91/gMMfhoTHqZfUyY/QmbZv7ZputXuALQPT5GyGyW2Dfgx9GTUHH+/l?=
 =?us-ascii?Q?ZiGMxesZxPbgcXO58bmRNk5PHQSAWRzojjTpNbB0FqNj6vhVbml5Rbn+3IJi?=
 =?us-ascii?Q?JreqMQeIQDNsz9JZqD0KghB1gnKEFWsLFc5+k8ZwcL2O8fb86g+3r5eeoYdt?=
 =?us-ascii?Q?MCDpjEP6k9USpxlN4tGq7n0zctVpIFmOizSJhqHqagyf/+tA/Z7+gozsbIUV?=
 =?us-ascii?Q?B9ZNGCTOOUPYd08jeIFuiiAK2v3a3/rcofeWo3qKF7LYsBRLfBhK2kzxHz6w?=
 =?us-ascii?Q?NwKn+G9SYO2+c8PSzW5YOzN3i9PldTVKyKNjIciws9RoiIMpYid4mMnHeuwx?=
 =?us-ascii?Q?zwpvUB6k3W+7HCMUI7o1/mkppE6pNYaqDklRJ4xlOXJQTHdrbLsETBmZuz4T?=
 =?us-ascii?Q?XTVtiZs1PiiCLSRUxsHeDXNAS/xu395cv117t/o0GFbmlW6/aICvdhEhlHRL?=
 =?us-ascii?Q?HcLwUpX07iPlxml6fbS38q2s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a475d5a-81c7-432e-883e-08d93f942fcf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 09:06:34.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQUhoB1DzG4x6vOe87htb/mk7DPY/GxJyq1OzixnFbRwqEtvtpDJIMMJTWJaMQv+PwpF7gcquGJl9urkG2J33A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3968
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050048
X-Proofpoint-GUID: pPIEJRT2syna86mL7593DnnT3Yrj6sET
X-Proofpoint-ORIG-GUID: pPIEJRT2syna86mL7593DnnT3Yrj6sET
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The functions prototype deleted as below aren't necessary as those
functions are first defined before called. So they are removed here.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/check-integrity.c | 49 --------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 169508609324..9cd88dfc5f8a 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -243,47 +243,6 @@ struct btrfsic_state {
 	u32 datablock_size;
 };
 
-static void btrfsic_block_init(struct btrfsic_block *b);
-static struct btrfsic_block *btrfsic_block_alloc(void);
-static void btrfsic_block_free(struct btrfsic_block *b);
-static void btrfsic_block_link_init(struct btrfsic_block_link *n);
-static struct btrfsic_block_link *btrfsic_block_link_alloc(void);
-static void btrfsic_block_link_free(struct btrfsic_block_link *n);
-static void btrfsic_dev_state_init(struct btrfsic_dev_state *ds);
-static struct btrfsic_dev_state *btrfsic_dev_state_alloc(void);
-static void btrfsic_dev_state_free(struct btrfsic_dev_state *ds);
-static void btrfsic_block_hashtable_init(struct btrfsic_block_hashtable *h);
-static void btrfsic_block_hashtable_add(struct btrfsic_block *b,
-					struct btrfsic_block_hashtable *h);
-static void btrfsic_block_hashtable_remove(struct btrfsic_block *b);
-static struct btrfsic_block *btrfsic_block_hashtable_lookup(
-		struct block_device *bdev,
-		u64 dev_bytenr,
-		struct btrfsic_block_hashtable *h);
-static void btrfsic_block_link_hashtable_init(
-		struct btrfsic_block_link_hashtable *h);
-static void btrfsic_block_link_hashtable_add(
-		struct btrfsic_block_link *l,
-		struct btrfsic_block_link_hashtable *h);
-static void btrfsic_block_link_hashtable_remove(struct btrfsic_block_link *l);
-static struct btrfsic_block_link *btrfsic_block_link_hashtable_lookup(
-		struct block_device *bdev_ref_to,
-		u64 dev_bytenr_ref_to,
-		struct block_device *bdev_ref_from,
-		u64 dev_bytenr_ref_from,
-		struct btrfsic_block_link_hashtable *h);
-static void btrfsic_dev_state_hashtable_init(
-		struct btrfsic_dev_state_hashtable *h);
-static void btrfsic_dev_state_hashtable_add(
-		struct btrfsic_dev_state *ds,
-		struct btrfsic_dev_state_hashtable *h);
-static void btrfsic_dev_state_hashtable_remove(struct btrfsic_dev_state *ds);
-static struct btrfsic_dev_state *btrfsic_dev_state_hashtable_lookup(dev_t dev,
-		struct btrfsic_dev_state_hashtable *h);
-static struct btrfsic_stack_frame *btrfsic_stack_frame_alloc(void);
-static void btrfsic_stack_frame_free(struct btrfsic_stack_frame *sf);
-static int btrfsic_process_superblock(struct btrfsic_state *state,
-				      struct btrfs_fs_devices *fs_devices);
 static int btrfsic_process_metablock(struct btrfsic_state *state,
 				     struct btrfsic_block *block,
 				     struct btrfsic_block_data_ctx *block_ctx,
@@ -313,14 +272,6 @@ static int btrfsic_map_block(struct btrfsic_state *state, u64 bytenr, u32 len,
 static void btrfsic_release_block_ctx(struct btrfsic_block_data_ctx *block_ctx);
 static int btrfsic_read_block(struct btrfsic_state *state,
 			      struct btrfsic_block_data_ctx *block_ctx);
-static void btrfsic_dump_database(struct btrfsic_state *state);
-static int btrfsic_test_for_metadata(struct btrfsic_state *state,
-				     char **datav, unsigned int num_pages);
-static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
-					  u64 dev_bytenr, char **mapped_datav,
-					  unsigned int num_pages,
-					  struct bio *bio, int *bio_is_patched,
-					  int submit_bio_bh_rw);
 static int btrfsic_process_written_superblock(
 		struct btrfsic_state *state,
 		struct btrfsic_block *const block,
-- 
2.31.1

