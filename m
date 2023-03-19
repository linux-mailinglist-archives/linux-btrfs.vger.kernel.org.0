Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE1E6C0055
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Mar 2023 10:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCSJ1k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCSJ1i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 05:27:38 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE71A486;
        Sun, 19 Mar 2023 02:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFU6/YDk8f64KR5bRNEgQLBNzB0Be6KzFy0pPMfVuKHuYG7Yr4PQI4XNbZmt9HKxacqDISh5cenUYxKdvd48gaB/h/wgNMcUe/RG595R0aSJG6/xDkI769x54PMOBIhHeR5SdR3ffc2fmiKPmaCRNpzPeWu7rHZfyVAH/u/351iJeJKjGF6li/Jnxo7kCWhDatiIUdhcUMdkVJR5FxmKC1Xd2LgOGG6N5IxF+NO6Us0o1i+7IiEBXXo84Lxc0rHHZr9O5oXjhnTwG0Lv1O+85RPws6pU1fdhGkCu6EAyqSL/Inj6o0XGq7nM2PczQ4X3886W8kYCW64IIEHwLMG/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nOnmDtRPbiMQMNfSWmIFt/QJNRbD0naJYTvPN+8Lcw=;
 b=c3NM4u3iRoSKvROI94Qivjn+VJ++KljXybIGsqxo65qLXTv58kHJ6N+Q8EsraaBlWUr+4nfmatFL8k7hP+5FwM3cO5I3CMvzC8B7NIIL0hmOZluADbc3jJpsmfVlqyy0k2WtTi28D9AGBr/6PNVn0aPEViWlriiLTzikBviOOV6ugpj1fcuHQOv0yrZGPSyhHP7I7mYfbvKRF/7qL5kbRtLbq+GltkEEd0g0Mn5XoaJrZMFdOYALqStRpCy1pLZgi3BNSq1phNeHQxkiD0Mi5OG5qkOdpvO0eRLT83EEvAe5W/ULs/KnqToGIe1v4Nwu64CjG8z42ie2NzG6sGV8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nOnmDtRPbiMQMNfSWmIFt/QJNRbD0naJYTvPN+8Lcw=;
 b=Ci+0PerYXZMAlDwYJY+V601aS9l/tJet32AwYkjYdaTRxHvAG/pVOsv4UDuKexpUmaE2Qhu4HjzU1p+xCBQs6BzLLjOez4lqJWLZ/H1dP6M44q/3xheTDigpUBWilMOpa979lLEOqJMK9EYrsi+Bng7P12qkdRmn4xdBRFcMOo33KFRNZ7kg19nKswVW0kz8jmX5iCJzRzGtqVuH7IBPm6jqjbwp4BZJG5B7jB6BgaNRv4t3I2z7aflUSPQw2Sh2l6JXwruShaZm+nCGnKFmDz0CnwB3nqln0dAjPhezWo2sys5ggXt8dnQRS6o3a7g+/1cIUu7cyd+uXomKNjIWtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:27:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:27:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2, RESEND 06/10] btrfs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 17:26:37 +0800
Message-Id: <20230319092641.41917-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319092641.41917-1-frank.li@vivo.com>
References: <20230319092641.41917-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: c19e86a1-f45f-4962-193a-08db285c2315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4jyeVmflkFx7M8hKo7FfALrpoqTyKdmUF+zzHYObr3bKbEcdX9U27e6xvlpqkvFFOiuU7dxRkXddXqiweKSK68W2MEtr+7YxmtJq1S5blzPq4H0lpxclFq1SSsC7hmjFllyWhCqKihALpRhykDAGMBwLh3+iRRM7Fhs+OyuwOnLA9NPR56ink8hqlScXG5QZ6I1o9LojL6FOTJv8yYlHhijRQjeccIj3cpKScSWunJOsNjoRptEBRCjcX2OPPq3FDSZwyg4xcLQZLqRCeaMGskSXdRr9ccy4gTfNReTfyidoArSkbsLFeLjQcFBRqTcpV5dwTAB8HPoG6sXHgdIlER+I06DaQeZNQw57AgXZpxVZLpRsPmphfqP77V5rkLLkSc8O3VoZrnZHzkZkjUjzmpDPf+4nK10jdJDogf6h3dj9gHTQCp7r4H8MPtCfWS7IvKomwfQ/Efc7+bhRSjyBJZD4BlxhvB9ocialVLXRMQV6BtRiqxp9fiZUpnA7uccxyHAUrj6MYqv4OKccdlaQ/YyQclyGKJ6t+Vt/t/Y+LIllHZuwPnPouo/f+V0BPCQHfxKU3V45BVp1JHZvQYB5XKHfvrKQQWm7CoaBdqnMU1SLSvXD3TkbUYzUsOkzMAOQQtPuteW/3Az1p+hBsdoAk6TLp8sdujSoEXdkqIs6cfEHhDKBpnYaetGl/BnsR7jk2GJcP3cXY0DZYgm5xZi4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(52116002)(2616005)(478600001)(6486002)(83380400001)(6666004)(316002)(54906003)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(6506007)(6512007)(110136005)(1076003)(4326008)(5660300002)(41300700001)(8936002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dkulLSGUsHzzQIuVf4W8yMCzWyjdcGQqjOP5kN7jiE6JZwpEgZSgXLlT6Hsw?=
 =?us-ascii?Q?WOTA1PSPyYmFZn4haovr6K9Roo2/oWTVAVzx8P226UmkVHd75Xo7xtLCv1c4?=
 =?us-ascii?Q?urFL7r1ihIRRyNo6zE84Mos/eJr87u7QalVD/YmyPesU98IIb3vKUctgPUaR?=
 =?us-ascii?Q?sffXlHpTKmJT/uSwCagE+NGzymn3pTGLrzpbB4qd4/DMjFQEldEfqQ0eYDL5?=
 =?us-ascii?Q?an9hrDVV7ZxosuOhDpVE/Ywf/2lY8mSykKOSrxRi1SIKrhHL1jpAJiwJuVXe?=
 =?us-ascii?Q?BWjgqtmj7tuod/5/H01Se7J+PzrGfGdbvdtnIcvF3n/ISABetXye1/E/P3C/?=
 =?us-ascii?Q?SaVaBgG3kZtBB2gmLv/Qb8MjK7TUW4uge3IgTBp1T4pk4j9/eM188Mro/uP+?=
 =?us-ascii?Q?R8FCx/KP5Z7qCk9vwVdw2b31BoeD0+wPSYS/HO/xGQmc16lxkmb4IIomGZE+?=
 =?us-ascii?Q?wdY1y9xu3+Kb/gjyXR3k0SP1m1vkvqx2/EYEDn/YktCxUIPDYvMELN2H+w6A?=
 =?us-ascii?Q?+i33/8OoT7biGhwzZaE72qR/MFtUodT3sis/e/+T+8n0fhWQPFupX2s6tpa/?=
 =?us-ascii?Q?YFrhwJkm9hWpgstPtxC9z3yQZXbYdAuv+dmC/jGDSiOqrOhPX+S7InBurDee?=
 =?us-ascii?Q?4DgBwUfCTaH87Jdx6NTS+pRNhRyIhysc6DvpNJ5AEjJ9hDaUjtBLrz1kQxjS?=
 =?us-ascii?Q?0I8X91lGZxAcOHr1bqFmwWWDAdl/pfU2eptNKQXr+GcS8HLvVVT9R9bn27pZ?=
 =?us-ascii?Q?zcUaafZwuk8mYgcQrHSRcqZc4+57tFw1h0YzpGB91XNRUzcfVUs8UruVoUkE?=
 =?us-ascii?Q?SlIvD6dZMT3ODxhqOmqkPmHqEMq1XpwLrNpMWlu5rC7DCruu49dyhKJtKrSr?=
 =?us-ascii?Q?MBsMg8ekwZ8yfx716b7ehFOYDaM5SslmSjARQtocKXWJOE/GEipxH1BLQtwf?=
 =?us-ascii?Q?zHKJGmlhAysGOpxc/0+eVXvpj1rEt4C+1gDx6FokgBm0VU5ihx79I6uiyJdd?=
 =?us-ascii?Q?bXu2Ne5x4F9qVkDFDKsjcfspHln3e7WF7dNteNinA9gIluFIFtf+T3zAQpDI?=
 =?us-ascii?Q?MEh/nw80lAfswgn4/kSSPcloDVpX++4WfSUbXj5IVeGXrxk3WuSyplpuQIO9?=
 =?us-ascii?Q?7vMl+nmIMvbDxfKizXJXDJacdAzdUvSp+2jXdT45CkEf35cnm7TDKdMomjHV?=
 =?us-ascii?Q?ZiLt3GcFxYxt7XIz3FZiyextO9JnFXpFM2XUcuaqUVGOmqVoEFCXMeIMGHpx?=
 =?us-ascii?Q?JpaHk/mbT0gJcxcNyvZZ/pdJCjFkxH7MHuD4mu7KDDNnqo6nsJi5vyywewpk?=
 =?us-ascii?Q?YGeRCpnRkJGwpLuZJh45VecITkEwq5aDyAe4VDGHAY24gav/s9UoG6A+ujbt?=
 =?us-ascii?Q?jcB6qoFWs8LE1eBD3eETUUIYBkiuD50dYPAtzvbj3SIfNaRupGUhK5JoAonF?=
 =?us-ascii?Q?AWkS7dKb91yG6444JnTw9ndfde2/j2EmL/DyUHGWQ3AX8DlMqBHD4cCasHPj?=
 =?us-ascii?Q?1260Bg4lUc/IsIuq5Y9VWaL0TOqsmg7UfGXRnFc/dgUG/rM/fm87JA3uH68L?=
 =?us-ascii?Q?wWn75wMTGfCadHpeup9jpCy6r2X9CMNsRTGlsWnD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19e86a1-f45f-4962-193a-08db285c2315
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:27:19.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCZw1KQAiisQUKPQ/RqhshdyvfPklBqACU1TKHx178cQm7v0SmVFFBGaIYoUsQVtWP5NBZEUt+eQ88efQ3P2zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/block-group.c |  5 +----
 fs/btrfs/sysfs.c       | 38 ++++++++++++--------------------------
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5fc670c27f86..a2876235c6dc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1125,10 +1125,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	}
 	up_write(&block_group->space_info->groups_sem);
 	clear_incompat_bg_bits(fs_info, block_group->flags);
-	if (kobj) {
-		kobject_del(kobj);
-		kobject_put(kobj);
-	}
+	kobject_del_and_put(kobj);
 
 	if (block_group->cached == BTRFS_CACHE_STARTED)
 		btrfs_wait_block_group_cache_done(block_group);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 37fc58a7f27e..49b837561135 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1390,20 +1390,17 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
 {
 	if (fs_devs->devinfo_kobj) {
-		kobject_del(fs_devs->devinfo_kobj);
-		kobject_put(fs_devs->devinfo_kobj);
+		kobject_del_and_put(fs_devs->devinfo_kobj);
 		fs_devs->devinfo_kobj = NULL;
 	}
 
 	if (fs_devs->devices_kobj) {
-		kobject_del(fs_devs->devices_kobj);
-		kobject_put(fs_devs->devices_kobj);
+		kobject_del_and_put(fs_devs->devices_kobj);
 		fs_devs->devices_kobj = NULL;
 	}
 
 	if (fs_devs->fsid_kobj.state_initialized) {
-		kobject_del(&fs_devs->fsid_kobj);
-		kobject_put(&fs_devs->fsid_kobj);
+		kobject_del_and_put(&fs_devs->fsid_kobj);
 		wait_for_completion(&fs_devs->kobj_unregister);
 	}
 }
@@ -1445,19 +1442,16 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 
 	if (fs_info->space_info_kobj) {
 		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
-		kobject_del(fs_info->space_info_kobj);
-		kobject_put(fs_info->space_info_kobj);
+		kobject_del_and_put(fs_info->space_info_kobj);
 	}
 	if (fs_info->discard_kobj) {
 		sysfs_remove_files(fs_info->discard_kobj, discard_attrs);
-		kobject_del(fs_info->discard_kobj);
-		kobject_put(fs_info->discard_kobj);
+		kobject_del_and_put(fs_info->discard_kobj);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
 	if (fs_info->debug_kobj) {
 		sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
-		kobject_del(fs_info->debug_kobj);
-		kobject_put(fs_info->debug_kobj);
+		kobject_del_and_put(fs_info->debug_kobj);
 	}
 #endif
 	addrm_unknown_feature_attrs(fs_info, false);
@@ -1620,13 +1614,9 @@ void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info)
 
 		kobj = space_info->block_group_kobjs[i];
 		space_info->block_group_kobjs[i] = NULL;
-		if (kobj) {
-			kobject_del(kobj);
-			kobject_put(kobj);
-		}
+		kobject_del_and_put(kobj);
 	}
-	kobject_del(&space_info->kobj);
-	kobject_put(&space_info->kobj);
+	kobject_del_and_put(&space_info->kobj);
 }
 
 static const char *alloc_name(u64 flags)
@@ -1681,8 +1671,7 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device)
 		sysfs_remove_link(devices_kobj, bdev_kobj(device->bdev)->name);
 
 	if (device->devid_kobj.state_initialized) {
-		kobject_del(&device->devid_kobj);
-		kobject_put(&device->devid_kobj);
+		kobject_del_and_put(&device->devid_kobj);
 		wait_for_completion(&device->kobj_unregister);
 	}
 }
@@ -2255,8 +2244,7 @@ void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info)
 					     &fs_info->qgroup_tree, node)
 		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
 	if (fs_info->qgroups_kobj) {
-		kobject_del(fs_info->qgroups_kobj);
-		kobject_put(fs_info->qgroups_kobj);
+		kobject_del_and_put(fs_info->qgroups_kobj);
 		fs_info->qgroups_kobj = NULL;
 	}
 }
@@ -2304,10 +2292,8 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
 	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
 		return;
 
-	if (qgroup->kobj.state_initialized) {
-		kobject_del(&qgroup->kobj);
-		kobject_put(&qgroup->kobj);
-	}
+	if (qgroup->kobj.state_initialized)
+		kobject_del_and_put(&qgroup->kobj);
 }
 
 /*
-- 
2.35.1

