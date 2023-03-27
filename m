Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AD46CA0B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjC0J7d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 05:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjC0J7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 05:59:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728E019AC
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 02:59:31 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R9jujw006954
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8b+nUYo+zEQHSknTlK6dEZh9eHnLAbQ+tSgBnqZAMvw=;
 b=Wd64zwill2RaXVVvemReUDzhHFsz0xlVxISnvJOdiMY2r0dia0exSlsARFr8ITSme4Zx
 uj2DOnoH/l78A4r+RYmoRJ3urDLEFzoEkhqRY7QY8MjTv3P/Zm64BWxHlrrrXMPhl9wy
 wFulSWaLPwvaFAo5ZuK1EQGLK+r+huBU7RLtZHeP8xkQvwxGsMWkrk6X/RzZf238e8n2
 HzDPj3aGmf3PF845ioe9cisq4UdnLOkzTvHtbznkFrOotnZNdYTcPBqXbLCpvIVvbQeq
 4gEIbKaRn6rB+oKrMlY/FBh03srVfiBz3sL3+qJMf2FpKbxvuyi8zhez9zIwi4RDH2ap CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk8snr11g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:59:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R9HpSK027435
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4gu3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3TE/L14MY+epTtbFxi6/a52hduUqVjIvcEHrcnW2J9f/sNprDpl2NSIeGojCOByZCw0zoAj+BqJcaz2Kd3f680Em65dWxaanGOK2BL4IjCmAqKNvC8UkwvjrASudlvwVqMdX5EFInBneMspizerz2xbyNmts4MU3dSCGMz3Lyehne5gIIRgceTyg+E+2wOEP6rnQ0LVZYWzDg5zr1ZKZ/pkB5hotbRKa++IDlqtTUOPVGcWvtH/62S7fzBols/61qWHU3UrSqYA+ZMvQg1zmmOocSD0SOKQadATbJhp5amGAVy/4+btaXPBMqgutJAhHCNMaDRLdjfeTSfxdQNHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b+nUYo+zEQHSknTlK6dEZh9eHnLAbQ+tSgBnqZAMvw=;
 b=doCDGdsyZ4GnwT84venIhy0TK83cS1XWdZ5gbsmiiyFzkOWhA9NV0vDIUA8mm1pi50a19+h1FthKqJkCCzRPr6zGkOdZrF7g0PPWOyKqTsLqZxXiuhVVYPNRgXsJ7rNRVVkDRhTeDesz/ghFpkH4w4RMRavogO29E/6JtRRGXBMXB6D+BgakTbXa/ELLv9j3ldG83UrpRxW3UZTCx9pELNHOM7zFruMcDPNbgnILh/knMjG9DOd0k/f6AVNBZDzO4b3LEObg9KyvXp6y0ICu6hywG6faZrwgJlwSIF1seAWtgLHPKk/Z8FU/0P5hNlDdZ1WHDf/qKFz0MGEy6bfUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b+nUYo+zEQHSknTlK6dEZh9eHnLAbQ+tSgBnqZAMvw=;
 b=QL+r1yjYc9BM600h+Sz7HKSL7sfvISkft8EyYCMfAIDJINGloeIJzAklymTkjN0Qzdh7WsxQLpySrMsqprbVpaZ3MBSn/eepLmXnkjtvONzQ/zxE3zoV8fwwAJJX3/rM77NwssT4HNLAan5kJHKRIRLDOsafkvhDj9Vg5sQAgCc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5981.namprd10.prod.outlook.com (2603:10b6:208:3cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 09:54:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 09:54:27 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 3/4] Btrfs: change wait_dev_flush() return type to bool
Date:   Mon, 27 Mar 2023 17:53:09 +0800
Message-Id: <3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679910087.git.anand.jain@oracle.com>
References: <cover.1679910087.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0123.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b50bf8-24fc-4cbf-3e36-08db2ea940ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vB5zV5qpwOF4T13ywjQU3na8E4j/0OAIZz6oC+g9/6wUhaSOAbxQ3rfm5nrMXPDW9c12NpsJMW+kR6AA2OBG6z96hxmVaww74a3neVe8GIpd4F6RJOT1UisnGzPNJQGePC2w6i2OzbFp+kINbmdv+uIdhGUlxRKz/qJU5TTViuXhVEe8J0eQu8911B+LcOi2j/n4qWuJ+Xaamx1gpGahvr8oC51lDsCk2l1GpqRfWVXc8VuEg/+crZzQKNJipSy51Kfhq19tUnZDkyIP2dTF/9SnnbrrvB8i2s+GzBi8pniPovzbYEKtUJto81o70iRWzA3EfprpRCi5Py71VO19CPOPWaTEB21HGWPSM1D9AjkLTqWkKqhlAalBjtO3TWsfPYuKd97GNJPCKOw8t0R7Vc8+vQe8biEdNRPVnoAr2Gw1qNZnGubUUfsBFaUd/9dHPdPpqVeFrEQLEF3SKFLwPXAkjU7WzH9uBqqhha2ziJriUob8acqk2XQI6ceP1EPryqFsKhX/2tEHkcQ/uhigdyVkvy6j12hbo6cYT0TF0GE0soGgAnbW5QSgrnUkx/Kw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(6486002)(478600001)(6506007)(6512007)(186003)(316002)(8936002)(6666004)(107886003)(41300700001)(5660300002)(2616005)(44832011)(83380400001)(2906002)(4326008)(38100700002)(6916009)(66476007)(66556008)(8676002)(86362001)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iO0dWBKuxjE10ihRTz61k5RDoLM47J0ATyqqR34ecAn5PGXDoLL3dRoU/V9x?=
 =?us-ascii?Q?agMDubNZGGbI6BDQYUeVIZYqDNlwgHM3XbgcaaTW3qSSw3CP4TsuHbvtlbdl?=
 =?us-ascii?Q?2lyqeH1NsVnxQMRyexWTultjD4uNexMdJz+V+nUNqziGt07c4uwnuYVxEXWe?=
 =?us-ascii?Q?2V3mXryoLYUqDh5G1acRNWwWd8x+Dje8WBC2O7g5TP/xY+N62KfWIO0MPqpN?=
 =?us-ascii?Q?2L4HpAlwCBQgdtcK0SLilyUEC/qEdlm2ZlZbtMaLXMTNBysxxXM6pJ+Ug709?=
 =?us-ascii?Q?Yo1D80nxNvi+2M5rdzrquMt40r4lbXJAfikpexcimR70H8g3j+bj/6BqXXen?=
 =?us-ascii?Q?gV47xGvAM0XQekhm7XJhu+Rhde/5wKyCgeDlCJ3Qt/mWsW8UobVSmqSU4MjG?=
 =?us-ascii?Q?C096xhiecPaKW3Z0MgAwj4/74I4e5AbbE4Q9TXwJw1CByuXHNdVphx+irsTE?=
 =?us-ascii?Q?brvkHXAAYqdV/6fz7b+Z1CIxbCnnOrpkxhNbjsDDCTvE1qDtAb6H3I3BrrWI?=
 =?us-ascii?Q?v5GB8adMZg7N7vkFXF/ULdqlGsUeq1APAKk2/MMyc8yt3ylgRd/Xv+7qJL2+?=
 =?us-ascii?Q?P9chUvOhiewh1Pp+dngqaFE2SQfZboD2KcOcaxyOu9knJc+5wZaCVtUF7hkq?=
 =?us-ascii?Q?DEjhilaXUXh9tSBstumR6sGiYhJjePoC6L/7rjkENVK7FhPM5NofYZaM5772?=
 =?us-ascii?Q?+J7pu5/LpnkgftzJJ8Srjfh/uurMlS1uIf0k22nE2HjvYz3XfVgY5qk7v/9s?=
 =?us-ascii?Q?Ac6eMb2IQge9OoSQg07xTZCWvfiezm1JGORVcYMVWCZ5q5mSeorYBhFpNgUz?=
 =?us-ascii?Q?MH2CVh838G6Wk8yGsZrOBwh2Am30PnvNJ1LgDVOSW6B3TZB9HHVC64qTvJDX?=
 =?us-ascii?Q?/sYk9fFxDDKrUSD5O9ogLN4UEDK2HqgfUn38jB4yh2k7SUVXAclez/ruWhng?=
 =?us-ascii?Q?SsozZ9/TDmBJU2L2YwXKS8UPEu/jWWMEhkRdCVW5lV68JmzDxVPvaxUJ9wyH?=
 =?us-ascii?Q?N2hGf88sszrCkaoU0NrXCPJWZR661QU53TTDHkjB/9OItzzL1QTPHapEItFp?=
 =?us-ascii?Q?Wlduitc4uskpqT9Dm4b5Z6jAdT6bhlQPWrV+o9OJAtvi1gf6+EqS18NEm5Ob?=
 =?us-ascii?Q?EOQiJKOBrxkLghBktOsTRxPZQB/s3avUw6HAi/pPU8fF63GHy4n1/nuVVkUT?=
 =?us-ascii?Q?fD1Vx8sUc/ZhUOhq7UhuCX8AAqAmLdpBLMZycBgwAtnxSVAa+GR8zhp6KQY1?=
 =?us-ascii?Q?blakKQxYF99gXxEesPkjFM89coBkl6BMpOmY8V3bA04bK90tfWNxx4lZbw1t?=
 =?us-ascii?Q?YvR+6QJy2KoKMSDTnCGEPHKtfCB7voL9i+Bbwhe1uoOY6GZDLfRIlEgkerTG?=
 =?us-ascii?Q?TBktwh20c4MuBJN6AhlRx1XxygAwaRNVP37+akUgiryNO9AwVB/jrQy0dnoG?=
 =?us-ascii?Q?Bd1bjKrZtmboMW9HgnLnZv7OShy/xtCi9xE5GEKWvr4e6nrUcxnQ3Ua9G4Yo?=
 =?us-ascii?Q?//0++RgmGPs8YK0EuI2SsRtLfau7wEzYnTlhmo8d+3I8S5pjNtaNN/gBpx3J?=
 =?us-ascii?Q?irH4Z5rzFFpiy9pMNnzp7phLEizJ0t+/+Hkjlr1g6T8uyzjELbX+WL+eavfS?=
 =?us-ascii?Q?8/kZHzoglY9jB9VAgda0QRs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7z6w/EKnEouTa/qyuKLvsVG9mcsAtg6BpxQzM+lczAtm4hdBuVbHi+BZ+pKmczKSiUfjwE1EovdLB2M9Yh61ZjZRAiEpu5rQvcSkPL9MMFdJoKmQf2tcrFqPfxa0IqTnzcHqzqj7OB7jGLPQEX8umga+wcCtkfg0HbRK+zmcDv3Mmp4tY9M8OCMXsNsqDZVMA9cS8ES1dmitU+M/5d3vRngtuDJAmft7kBirt9Hci9IBQOsmYmE25xTayGxSn4r9thxolm5gM3PyJlS5ZE+a3DN0Wdz8IUjf7/sr+FSYvUnxQE9BKtxdd3M3Ux1xflo0nweBC3hKawmOqRMpMUASSX1jfPqSz7GBDm9BWHpdGJ67qmecI0zojZNLLeiDmrnOP5cERk4OrEVErYiJh0Ir2uNdcegcYNtTeKdKf5E/Ai79/x8kQk+ej0xxIV7G8n2tbPl9fX1gbY5LCvJpggTbuFvpc0vRl2ntXUnRYDJOGSLyqg7Td+Ndtaht/j6W5tB9rn7j8lAnAJjSue4YwwW619xyOBlTHBpoEOeUqNjQiMnw5Z/qfOxqDdjSU0ucgZkXXC1OgPOhMaK6YbTCEasmeXFCGAYdQMowwhkQlWH5fShay0wJKzTu/oFyDyVh9gqQoPz4welyfFlBpXLtQ6t/56zSBlpLAIvIdBMROG2dBaSZbJy7hIN+2Zsj+Vf4iNi7lu5t09er1iuWu4caQr1ZxKcV8RCHA4GpbcdPKwkuy6xSupp1qPMfvxFwnjAiD3hvkb+xBCFhvYTxDWcDpKK6Vg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b50bf8-24fc-4cbf-3e36-08db2ea940ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 09:54:27.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DS7Mc8zvO82AbQP0wXGIqo4J0g6WKcha7V2Pda+f1pMepkCpop3VoQvDID6uKKySodTI2+L0Uy/u30Y5qHjN0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270080
X-Proofpoint-GUID: jZ7k6GiA0VcwM2IXEjJi0Hx6oVZCAFHf
X-Proofpoint-ORIG-GUID: jZ7k6GiA0VcwM2IXEjJi0Hx6oVZCAFHf
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The flush error code is maintained in btrfs_device::last_flush_error, so
there is no point in returning it in wait_dev_flush() when it is not being
used. Instead, we can return a boolean value.

Note that even though btrfs_device::last_flush_error may not be used, we
will keep it for now.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 745be1f4ab6d..040142f2e76c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4102,13 +4102,14 @@ static void write_dev_flush(struct btrfs_device *device)
 
 /*
  * If the flush bio has been submitted by write_dev_flush, wait for it.
+ * Return false for any error, and true otherwise.
  */
-static blk_status_t wait_dev_flush(struct btrfs_device *device)
+static bool wait_dev_flush(struct btrfs_device *device)
 {
 	struct bio *bio = &device->flush_bio;
 
 	if (!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state))
-		return BLK_STS_OK;
+		return true;
 
 	clear_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
 	wait_for_completion_io(&device->flush_wait);
@@ -4116,9 +4117,10 @@ static blk_status_t wait_dev_flush(struct btrfs_device *device)
 	if (bio->bi_status) {
 		device->last_flush_error = bio->bi_status;
 		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_FLUSH_ERRS);
+		return false;
 	}
 
-	return bio->bi_status;
+	return true;
 }
 
 /*
-- 
2.39.2

