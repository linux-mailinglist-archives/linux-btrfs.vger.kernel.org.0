Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389EA65A61E
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Dec 2022 19:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiLaSsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 13:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaSsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 13:48:23 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2031.outbound.protection.outlook.com [40.92.59.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610006349
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 10:48:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0RvW136OkdOPzn8YHafOrv2nO5EA2NRPvY1PTZEutkQ0reGLCr6mcZMAD/z4BVQZZNo/AqR6/qR41uCQJwfhFF/GeK/sI3udgVptnobai1OkDQE6LIXsuzzPxxrugWWmHlonixiO2aNylGJmezEVS//NqZJ+advkUizGYsG7a5XJJVDQcAlp2eykyPjgWDCAj2ZPn7xX3nfZKWqFyq20NGIVnWT5hIo21WCYF0SiHmcYXPh2Pdx1N7GgK6MP+vgWFK5LMtVGh4ettdKJuveaiAtXbep4nMhA9PaidcfC/2QYfPxbUpTpKj+IAEiZkg+wmb3xrZ7O0szuVMPCfvuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAD6o06JvHumX636p/APQvcqNMPQlwsWssSXZaiD9Lc=;
 b=d5W5BLtMjXqRc5n9kfCsFTS6TSPBQ1/meb1yuFakbi6dBOSTyqwrDSzv4WpnfSMyEjcO6/CcarHJIiAhhKp5prO7hFdfvXXUmpiTW2qF4wumHPMUYRr8+w8wrAZ4lxXdf4kN6jIVLCXPNEapmLCSGYrGzn2TDvzSKeztoipXdvdF4VrlL2dfo+qeLEkdGdY8U55wz2f0AYdYmxD6+nZl7oGMJfSDOXOXD0UZQRgeW+VdIfORWHUW2FMvVIzR2nbTOVtShIn08hS5bAUo1/zhNaaUBJ7tA6fUNjdhdNyOdq5RKOqRmDygBnTCeHhxOOtZettuM+ZWHPagDnlNa+Br/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAD6o06JvHumX636p/APQvcqNMPQlwsWssSXZaiD9Lc=;
 b=oojN8zG5TQnyWmz6P5Z5icWzaIARC+hG0OScMKOgsDtXSfYe36PyGl215opvquKdn2QoG7mcAoAPbI12Cx3bQxby/gZDgYdPdDB4g0MyDpBi/Xzrx9dPUaXnnA1Kowev1gy/a4MPt5I55CMh6saM0hK9IyKe2abI4CBHHJXx0ammRlEaTg3wRy9RTiLeNG5H0fOF3ljN2MkLXkEiqYgMyMrHxGXxvXyE4xstqVMXtPh9JamhuZ5opr1YRK+RB2zZwYUGliwwXMd8BVBiImOubeMapMIKPVHyFFwZpOsdoSC67QerRbynhPQcTZHFPyI2N0LNG63qCrX6JcG/WMzP3Q==
Received: from PAXP193MB2089.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:226::18)
 by GV1P193MB2277.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:28::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Sat, 31 Dec
 2022 18:48:18 +0000
Received: from PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 ([fe80::9da1:872b:caa3:1379]) by PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 ([fe80::9da1:872b:caa3:1379%5]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 18:48:18 +0000
From:   Siddhartha Menon <siddharthamenon@outlook.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        Siddhartha Menon <siddharthamenon@outlook.com>
Subject: [PATCH 1/2] Check return value of unpin_exten_cache
Date:   Sat, 31 Dec 2022 18:47:48 +0000
Message-ID: <PAXP193MB2089D68F6B6E11464FB202FFA7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231184749.28896-1-siddharthamenon@outlook.com>
References: <20221231184749.28896-1-siddharthamenon@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [UNNSwXfa2PZUQbs35L1bYov3qNBS70/k]
X-ClientProxiedBy: LNXP265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::23) To PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:226::18)
X-Microsoft-Original-Message-ID: <20221231184749.28896-2-siddharthamenon@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB2089:EE_|GV1P193MB2277:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdb427b-ef17-49f5-dbf3-08daeb5f94fd
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKyQOi1MZNPcWvWmpE5rgqxSoF3mMVwdqAAVgKaz80A2JBSV/vm10yF5cFyTga2JhXd7IGL8LMQHUIZfBS0+vDNxgUmsBBNt8AO4V5gYfeYQ7gSo8GBakzINVmmUp0GIELMloT5Ak3cjRdqYmBwPgOnCP+93A6liI8LWCMVmlis+RFBfAjnLaR5ImtofVUinsBDLuAW77selQ+XRhMk0CpFKmiWN1ajGGKX//H6g6NXAbw+rsRvILnPjzPj7Xjc15hjsxcNg3hSTenaEzZjROSRaeeMhnQKQxufX53GaPwE+Scu0qPFcWMf1gjS1dxW+12cI0qHw+nnVdmybCdJ9PVb0GINw/kZnuTUettp/OVkO+QQln05RwsFvJP6DhlDNuNd9fDoxUgBtCmkcKcKOUdlpuECszdfL/i1V8IHtjKIwNkYCr/UaWVotv8k+v3OvKTow8jjkO0qG9e4wbC5Mm9US6ntZXBWLH5lqst+Tx85f58Cn8yaHoP4bOT4o7LqEKsH3q48LArGtLu9HDZipexuKhLGVI7IwjCywjjLA9mUo2G8svVDy2emCoxeomG1rF/GsMdp48pxaZrbs7O6m2QUbpp2lUv+4uZmomRWNgMclaELBnRAbDPHzdVeIT+M2oTEwM040SAJwTsZmDkhCEhaAKUKf9ofw6ToykccWbwNpeQ4Nd8tkqm1rS1Zdn6BpIkc0eqPl0OXTfDzdHphyyLgTPPqt14HIf8A=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7dSZsbjn6g6Df8bQo85rJgXbxKG0FPPZrkG2GL8TgpMzK9YkFw8TXw9LHAeKqn4S546cGGrLOIjCVg9cKkkKdO6EUeIFSy1vJv5aH93r+cu1uVKA/RmUEhxttR33VAjD++yFgmws5OhpeJc9dxKUDsumaDaT5wCmt2hI1h+Us3F8eZC0WLTMv44Q7tbNmfKeQXxul23DYkVtTOyk4uGnIju/5zGoUIDx/rAtfzxiV1wT9oT69/4rNjoJQZCvAJR5BDcHuGwcvifC2kR/d744PqfrYd35vSWPLl8R68N/oTUjFLDZwi/SWU4Y/vwa50wzCRDo8mH7VAb+fFf6ZW1UgQjXx2IJk6tbwouOy+b7DjRnn/SoZm5BQ6goSV5D8j6lT6kjW1quhTKD5gqIJkNmwLjVynyEgRQ62OD43ByYul4fSoqZi8IX4Gn0WEYAnZ0CAM5YqUq0JPIM3xgudpODG+M6exGw0PVpf4rT1wLGIo4xIZvEFR0QwsGAbjsZRD683In+fiN+xgrQcuzVHk3TO7wpBnuBzu5jXFo02d6ZOBVuNoz3OGMdxWNvIR2lNwV+dpIg5cvCXU/Bksz/IjFegVSCjjuFhPt+Yiyunk76FlRGtlOwnfsZjPfw3VEidYsuC/+Kvq/UiZaS94y2DDWs4Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Gm40JscfWXJAt5c224l0UQS2XU8udBEuUqWdx/+uxsdC5dkIVEz8aODjQyj?=
 =?us-ascii?Q?exc/3FLIggYnY1XKfMRdotyLqDFWdioiNnmGF64Iem5NV+568wcVp+X3JD9Q?=
 =?us-ascii?Q?P/ewD4Dm+eTZxHf6yGF00bT6A4UKTbzLe2veD5DAtTJVI34a5qW47NJaNuT6?=
 =?us-ascii?Q?P7ZRJJR1lWop9RW3EwqrDB3g1LekMHMsnNYobUquAO/u/QX0srKNZmxGyUMO?=
 =?us-ascii?Q?oPVKqXu3jfvEtISGKRMfiXaE/vTVFyztnQLdvL0JTtWELtpzDQnSku1J9cbE?=
 =?us-ascii?Q?DsdflX6cbdYtH3QOVvHtvT1POUEQXV/PMTixQifpmChrfQZE3B2X7M+GHUQ5?=
 =?us-ascii?Q?o7mz1YtKuPYe0c7Kio8XnjJXQ3IpQ1DKABW/VsaX78qraVwYFjkB5CFhTZFP?=
 =?us-ascii?Q?RfPBXteLZsgpakrrENYc1vGK2G8IxYrzrO1fMo7hiSg0oeJubxxOp+d6iEzx?=
 =?us-ascii?Q?wW5Doj5bBu5zpTtOI27YFMe6qG1HmsFd1e0ioQIK4d6t7InBVQfuWiE389Mn?=
 =?us-ascii?Q?bLCJ1OeHa6AJjhgYT78mFL/gLGW3dqGTqZKyZyWWxmhn6by3kIjH6nch+i6Q?=
 =?us-ascii?Q?lvimb8jMLdIxLFaFrgIN6ueK5pbJyriu7O9cQSuXYQQY7FmsNLngBQmVyoIB?=
 =?us-ascii?Q?EPIRnFuU39hwwW6TzhAnwEQOJBDARm9wW0ZDu28YNWbuommcKIsixuikNU4b?=
 =?us-ascii?Q?M0kjqIqGmK8SrbhF/PkvMSR8HDuuZ7Gc+dj1Yb9ggZhLPfgovbJY80bJ9tx+?=
 =?us-ascii?Q?0hHlrGuPcogOZZ7VyQrd7uzJrPxF97s0jUna2eikKe1BKKFgV8V76r2FUwWW?=
 =?us-ascii?Q?g8CyWW/GJj9gcCTqNdaYgt08QZDrCY/3lrhJH+sGl7T29TNJQInquJ44xlXO?=
 =?us-ascii?Q?9jeIjVnCRKjVMEmg96mLT6N1NqTmhnLQYnXudw0ZVFx7lfBJVU+Uoghp9jSS?=
 =?us-ascii?Q?oDkAcesnOvMDJi0m0nFKJPPg6sb8gg+ndpfApm4a/DC+8zwh3rEzJNp8+b4A?=
 =?us-ascii?Q?7EKKoDi+tKizYAsvPX5HqalkY3SL1ZI4EKEG4w93OP0h2hlWI+HlPvBkaxx7?=
 =?us-ascii?Q?vm8ALhelpGZ3mWa1BGSEoPIFsYTTu5oXBSA/31gXFc16SkohOBWy1A8M1iLj?=
 =?us-ascii?Q?MelmoGN6LWw5iLS6zrxmLZs5SC9P58O7PnFzG4e3dM0gbn+I3uD6Of1oHC5w?=
 =?us-ascii?Q?BJBGkLluCUFKMsM7V1mrcEXkVyDTta6avIfLyp1RVS3qatec7V16cmFqFMvK?=
 =?us-ascii?Q?2hSN2khuOS9GVlZ2m9ohtb76EhaZDXXt+CcHNP3TtU2z89kUq+U7g2CKvx18?=
 =?us-ascii?Q?X8A=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb427b-ef17-49f5-dbf3-08daeb5f94fd
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 18:48:18.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2277
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Siddhartha Menon <siddharthamenon@outlook.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8bcad9940154..cb95d47e4d02 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3331,7 +3331,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 						ordered_extent->disk_num_bytes);
 		}
 	}
-	unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
+	ret = unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
 			   ordered_extent->num_bytes, trans->transid);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.39.0

