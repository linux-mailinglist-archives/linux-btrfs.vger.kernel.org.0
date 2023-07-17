Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED184755C89
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 09:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGQHQk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 03:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjGQHQj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 03:16:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D2610C8;
        Mon, 17 Jul 2023 00:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j82gjnQydwQx+N6B03HHoVqRuCbnUWwskBoF18/rqqmSihSR38Cix4GZy6T9LGn2OpjfdV+swzFF0aWCCb5lb6KVzLtMTQxpPdx+afoNnjTQ6LwgYUXF6p28+gEgA5iZJV9AdR2blRdG+IZhGSqNExJc90JMcz01Lu95KXTrY3t6+gTndjIpbImddf8y6q8pYQi0OL3EWM4WubGnJL7of/LVJytWbkAnoXi/qUPbGlaBhYtYi4UuK99QCQNb79E4hpfBppQDtjs1vSY6LqFS4vZYALAFVoTUFs9G0L+hT1gvjEyElvaT5avfbOvKtnNarVQkL+ZEaWBKhy3JcWLo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIQdGS+g69P6O6HdB/+MyOT9mv+5tkFZo/DoDB37kbs=;
 b=IC3ny5ogvHHUwB7syUvDTpAlqlnEL5MqNsztqQy9/XY5lqHtMl1TTFgJxgIzIRGpL7wadFmLnrlH4Skt00LzVGlCTKcnpLQehRSd5mQAv88Kvp4r06j6vmbPeAanOS7cCtGLplKpSgkS4yHzW48hPs5yuCnkiERrShyLuT3jzpN/EWJzh80OL0Xm2LausIgHzQcpKMJOVmGDhE6tbHY6zJLVpVyUZcbwwvK8AEMp+zH/wFgY4So3gcKKiyDWJ1Icb5cp8860tkZs4abC3EQR/mYZWvdvJrEqo8qsNc/whJec1uHDxCuuvjwCXDZxVragVa5H0idyO5e0TCQ2Pgj2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIQdGS+g69P6O6HdB/+MyOT9mv+5tkFZo/DoDB37kbs=;
 b=D22ltwzfZPqygCEEoU2WhYjDw7mzDtw0A8qIxrYvTVF9iznFIjKlaZEwilJUc/y9sxs0BnKEazIswwyLzupbzWxwAnZvy8xfSmirPbh99QqL/o94kYb/cFh+F4CLM7VEiHBJTQtCQ9lCZ1J6J0agv5vUsw9V1UNUpKSzZka19sQ265714nST062jhFfI3vjE12ZDnykZKkgt6bI3ND1/LulOQFci2isly7IKmGyC2c1xHcEu8IxToUG00MubH6b+E1EvlrcALvpekklPK7vBQ1ylQdLmKmDoaZYFABwW7bTKRnLKnWoUosEGKfzWU7sbHbFkPMgp+kXqD61rkPiyOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB4463.apcprd06.prod.outlook.com (2603:1096:400:8f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 07:16:33 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Mon, 17 Jul 2023
 07:16:33 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] btrfs: increase usage of folio_next_index() helper
Date:   Mon, 17 Jul 2023 15:16:22 +0800
Message-Id: <20230717071622.5992-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::14) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 21288537-acd1-4066-3a72-08db8695c000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHK6I0eScNfVH8OI1ycajfz7Sy0dgu7m2m4JlQW+y5F1ccVoPXKjwR7WOwR5NT7GbIkB/fO0hd483QKGZh/wPuraoClWhmBFbk4sTKXEmsn6LGzuwdwzU59wZ8+hv3Ti8qTUTj+ew5NIiYQp9YxCHRKY5fJmxKgf9blF/Nzn14fLbx+Y/+TKtt1g/DY66Eb2iUq3WSF/Z9BncyEdOAkTi/JMlqZByL15joasqE6C2wct10z1ij98sdAJrPqzFs84IWa6+63kQauCCHSdoreIDddq3ezMuPyIDslFtjAKb5I4wBTmzRyTt9iTihGtTTESP8K/C+dtjfYmr+3IAQQqoBjI8GXRvPn5+h8L3RR5wkn+VEJ+Qlk3tGHHLkRdaPgDP9vI3kNcN0/kgD9lCPs6hhZIBiKLP3gjUriFz6ccBRGvmWIzNy3cGzYU+hpsvMSx6RugQRGJ1AjgSqtVIdnAobZbMS1e3B9S2T3PjLT9c1ocs7tmNT5e7wsl76h12ehlrZ+eXZwniWXrnQodyJseX8QHzmcp1/hkvMKsjA0kB8H6N6vdsFFs+OEH2pKDb4PBDw2yKsoVtK1NG23sQ3YAXGOMJMmxmieTl5gy2AJOOTZJRW09OS1SoBdG4WgZcWLs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39850400004)(366004)(346002)(451199021)(6486002)(107886003)(52116002)(26005)(1076003)(6506007)(6512007)(36756003)(2616005)(83380400001)(86362001)(38350700002)(38100700002)(186003)(8936002)(8676002)(4744005)(2906002)(41300700001)(478600001)(5660300002)(4326008)(316002)(66556008)(66946007)(66476007)(110136005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i/6Dv/5AC0dhXKDR3c3abc1AIWxpfUn/PYR2fBCRe/JQfz507A1J223p2E/9?=
 =?us-ascii?Q?opQ0775vke0/QPZUswqJakK9DWG6k5LLUF3V25ZEfgooRJeyglWWPyk0P5s4?=
 =?us-ascii?Q?F4G4luaqva77apZW90PdPO5cvWMTe1dPmA0Zt7jVgnCAMiZNWOFJm/dnF/Op?=
 =?us-ascii?Q?qHIGnTNW6HsqQZxX3BObHZ3gztbHsv6SfPLfftl4DLXyZWGv9WY4ezqVgrCX?=
 =?us-ascii?Q?AnKAzt9kE33XhNa02av9GnCBFe1pjR6fII1iS61W7sZgTk2xjhrZh+MAE0iG?=
 =?us-ascii?Q?bEKBPNo2/wLV7G7fIQcph2zcNdmnaGAnuqcAm/Aezlp5reBP7FLf+jlZVjMt?=
 =?us-ascii?Q?4sgL3X2epmPwVTWPIjRv2dE1dwEKB1rqllS+fihU1+WUMNjrHEIpqLeavN00?=
 =?us-ascii?Q?Q+ftpZshWNJ7n5zA2BFAwoAl1gww6YGsNHS0gWWz7tsE9m4OhhZ7RifbpIf3?=
 =?us-ascii?Q?Bkbzn2g7x3qgTPT9EIEJoq4kipxOriAKpLNnXiVWjbUvhR2DX27yK3ONBiHe?=
 =?us-ascii?Q?DFT9nwH2lQ6Gh+ub9Lgh19Z0WJxgcI5JBG0QqPHqbjTVHAOi7hOY7+3rfK/4?=
 =?us-ascii?Q?cKAR4NhxRZap/vzjEvWO+mNzGtZ7ezNmxa+J9vBXaDAHZf5RaHobv6qnfRZq?=
 =?us-ascii?Q?ZlC1TB/ZK0eGV+gnNiOz+KV/I48VNNlqgST45Wjw3Xpvkb4tWhKJBMcm81ja?=
 =?us-ascii?Q?AfFxLf8O+ueyash+wO8v4ZIMcvStzZhkCjQgm/wHMtWz2wzQHUZf0Ae9YuFu?=
 =?us-ascii?Q?kkwFxoXdgt/dWQYoFf0rAUhWT6TCQU2yTEVwtQqa0DhK8DsrXIyQ14OkkzQS?=
 =?us-ascii?Q?yHxm+yvybxiLodTar29TFb7Y7C8sqeu81BDz6HGISx71pnkkaz6ZY0UQx6LA?=
 =?us-ascii?Q?0xj0Uzdx7jn5AKGd6exCcebyqPQJ8pDOZrr+FdYNwZNDOjsgvQqHxxFRs0n0?=
 =?us-ascii?Q?WQAsJza7D+dyA+2EWpl5auyCX/Xz+4GgOI+U26EkMRlU7TUWS8hl5WqD+FZO?=
 =?us-ascii?Q?FlqSDeU96UXKM7MF5dD5nPxp/kPxjUo+eTwzr0j/2G7jtgNaJZrBLkQ+9C0h?=
 =?us-ascii?Q?ISRx7zlDRaCpw/wdIiSpKB0y5FhpCbKyrWaGW5+dIkFuANyTG1K7vaaD8szv?=
 =?us-ascii?Q?3Ax8YeaCB0SCLsYqAq++LXOKvfgA7OXqTpE8hPh/gveGG/qYG5+HepZ1JesA?=
 =?us-ascii?Q?MvZnIjO9Iot8YtAHXWF5j+/0QHJq6BS83l4Wba2PG8Wocuc9ntyQWXpYPuHT?=
 =?us-ascii?Q?Dys7KGqIEUSLYumfIihMRc6/WBrpx9AKB++gUjn+1g9ovLCxi+coIx755f1p?=
 =?us-ascii?Q?Gx9ITC9nBQo3rd0C9hnKX1vA3setxNcvv95fvGLUFtPLIllADUaBthOeI9jg?=
 =?us-ascii?Q?W8P/feL4nynhrNRCXv+97HE8ej3bqAEZkeuHT8RrFo5dtQhwZ6tY9xP4zhsp?=
 =?us-ascii?Q?PZB9v0QVZbB/CA542Ak+aFZ7swMAkVyxZmQXjJw35XJFrAuxZblmmY+QvbfS?=
 =?us-ascii?Q?sk563cbSSgLWOFqdEjtHZ18RDHp4iynz8FnB7qi/qkZWbBNmwHseiibRBm/3?=
 =?us-ascii?Q?dQFEqaCYcNdRa+eTH6cABUY3qDIrlOZn13Rwr6Dg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21288537-acd1-4066-3a72-08db8695c000
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:16:33.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6jUoWFjpG5qAlIawFCIGVULDtxMm1cv3ttPn7OTFYZg5ZqaDsnANgyiUWWZ60FFPZbZ2chKsNfEl4eg3RiC3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
the existing helper folio_next_index().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 094004c11..d1c44e17d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2127,7 +2127,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			done_index = folio->index + folio_nr_pages(folio);
+			done_index = folio_next_index(folio);
 			/*
 			 * At this point we hold neither the i_pages lock nor
 			 * the page lock: the page may be truncated or
-- 
2.39.0

