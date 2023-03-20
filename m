Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E736C2084
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCTS4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 14:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCTS4G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 14:56:06 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BEB48E1D;
        Mon, 20 Mar 2023 11:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyuvGvGpMw8B3C+yDDUb6VNukjGykIkRRZ1cdpEK/nzStnShIg87kfRKnhpSqXX4tTSsaNbOolucdXws3wcLW4/YpVZD9XM4GZ/RNg55QI0r4DVNcMj6XP694nSVs59I6wRBFTIm38azNTz6CAx8wx1qFLJ4rX/EtcqYgN+cuTgwIZ/1Ikj17ImqfnqT/3Z3I/hQoqxi6BkuOupMftfL+Dm+GTFmpq9aI6RvTljUgIs2JtlmVivLrLtPFW536X/W0hXKnMznhJMfNmOsyHp+C/vY+2s9K6lHGB+43Tx215gJ9DMNgFZwArbbvQaz5+63Mksq08wiQY0S0JJSRwJN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8liiAhRP3jWHYEAcCPeXHcbpyXMgVmviKu3w+LZzZY=;
 b=Gm7ZFO414yMaYR/675xTqYnKnxi1UPXCxAOHCdVuAH+N9c1hTAL12Gb2k+y9h7DK9tgm75xTTrkn2gMINGPkCb5Sdo366weKB/dvkaltR/XdnG7bgnZXeKTXSVDEIlkJkjU8Xolq4KpnrC96W1o81wxxKGQH88N5IHcQwrJilXHMYL/QBSCPJj3RD6al/QvmMYM9S1C0Tsq77gAxWph+ydN9M4sC2E46DuTNwbWKpiO7bOUQAuWksLAid9v4MWdqBWZDTsA4G3673DFPZZ4I1sxXb944FyOdp9WxErfuxY9f1cdM9kAhr2NXLdsMaqLeyXxIYEDVm9I/0dw1TodLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8liiAhRP3jWHYEAcCPeXHcbpyXMgVmviKu3w+LZzZY=;
 b=FMVWDtIQmQWZWlCnoJCZnGTAwiufyfqF8ZglFtL6DCwvbbw86VKCOQB73SoI1/MCCIxDMvQ3Hf1/DMmn9VtoVA71GpYxu8I7VhibX0jxPl4vLh/Sb6I9lQfywMhGqhhrNYjdIlcsrv1msNya1Ts11wUvRRi1SYv6jiZiL1dbybPwhVId6vTNflkKK+EtAGHskNeXfih2zheOtwda1d1zLKWF6p9EbOEtlTjNtGvEJuJWg4vWbln1HDlA/64sUZiIjpunsfMGjZAuZnRnDNE7p3ZoRBCeI90pOD6h/474ycF3J5v8ZE5+p2c2lMWiN7/fJ6Dma4irQ5exH/V9LYJQJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 18:47:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:47:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND,PATCH v2 06/10] btrfs: convert to kobject_del_and_put()
Date:   Tue, 21 Mar 2023 02:47:25 +0800
Message-Id: <20230320184730.56475-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320184730.56475-1-frank.li@vivo.com>
References: <20230320184730.56475-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: f16e8fa7-0a1c-4bba-2fd3-08db29739e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 482W94rhSb0X7joIiJXbYqim+gfBWKgXdvmKin9iwFq9SQ1/Np/Ky8Uk3FUbDDEiDfHvsrztQYikZUMHkG/qUMvU5oOHn3IAkwLgn+hvE6JT6+kLe9vk72hNFPL8wP0q1YnEnvTHgDyZbW8ewzWARiYlSPwvLf+dirD5PDBs+lyd577hqNbB/hPUL/kyJ5auoOnG3qkEPPKJWsgRBLLnV2zxyq/AEhOgXq3yr9QXtPovnxPkRutOJZ5OfJl1M3LBYZ2HxDydIrCZTMamjQ+LNUs9PA+H/2FsbwivhkkE4yj1a7B19aC8EEzrC9HZvXcipUCXl8xyaI/UEQ3AACEkLSv2XCjwXCLVK+p9LeMRjGUcQTUz1YV8Hb4xQlph8gBZLL0PhJwazAKNv4VQ2D9HkCFb3lVVR9ZWz0/0WUPdnck3K7FcdcjtwOhUhvQ4SYuN+pamGhIzgXRlIaewWxu06PxA+rx00sJTadMbIE2P5H7aYt9084E/8fzo5t2JHUP/VL2x7IVl+d+A7GKhT6Fs7PyHxvOOucY6RGvThTKiiMyApQ6k5oMcR5XHPvnfKFP31bkDVy4wpnOLp93e2HIe0LkJLgoaPz4R9Fs6frHE6jkZ4sK4ldmCRPM56HC+zxRn++IquA0NUmUU0vtJsLX9jhMI+7zLEVx2J45OACL5VzLwl2vyVdSlF+1dxsS6BGsLUs1jn/Hso7+fwhwY1sHOAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(52116002)(316002)(4326008)(83380400001)(66946007)(478600001)(66556008)(110136005)(54906003)(8676002)(186003)(66476007)(6486002)(26005)(6506007)(6512007)(2616005)(6666004)(1076003)(38350700002)(38100700002)(5660300002)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zb5Dxul7p+45RAYzOWFmHF3Kr77PpK3tjoDiv80pjDXisrhZSEuhyOFekvMy?=
 =?us-ascii?Q?G2ALG7XmkibeCZMFx1E9RWjS8AJj/up2WbLdK/N6cFAewvGyNlFO9WKWBXbq?=
 =?us-ascii?Q?E5y5AHW1unhrZMIuVIS4l8zPqcUoKFJrrpgj/14Og1Qf/0n13qPqx25h47zZ?=
 =?us-ascii?Q?nZ2S4MHoiMpRLSfsMTi5xjJBLqMRL4tA0VxNDlQpuQA24+2UJ98wVrlWISaF?=
 =?us-ascii?Q?UkbJt+9BZN44r1HSmWOMr9+V7ONoSbBqeZzN7O1tIOpQH1QBslXP6Cnfx0fJ?=
 =?us-ascii?Q?lc0tTlGxYGICccoMVwJ+kUxJ0T1hHmo5SzD8QFY23mDwpqI6Cp7FXqsA9+fG?=
 =?us-ascii?Q?lUojkfA8NW2wDnSkU7qZibcmmezysyRG4uN3Y1UMdDf/7RzWhGHvFt1OvYeh?=
 =?us-ascii?Q?4Y8835tTFBL2P/HNTByulAtT1CSP6HiXF9BJJDP50EjSs4ngpk/E9tmBuDC/?=
 =?us-ascii?Q?oxcTQxBy3y2x38eumjmtKYVHdb7ylkXrvSoJ6NkP4T0eAcqADA6nHuTY8xDH?=
 =?us-ascii?Q?9t5z3qmQjgZmRFojjOFXf8x9nw3XCDniJwpijta84iqKHe6NqouXPuypEyGD?=
 =?us-ascii?Q?Rs3GzAzUiOZsF2ceGoiDLty8BCuLJtHK6akHAc4IuSXrEg26p2MejSyQrKWV?=
 =?us-ascii?Q?FKKc3FzCBEvjVMPEZ3kuvu7b5XbPR7zDc/I0LZLS2c6MrNk/wzBiriUu45Vx?=
 =?us-ascii?Q?+EzcVOXFvfzGWl3jC4NOxw+ACRW295vZenS7sRCeipfz2Ob9ugkIFwu4TWFb?=
 =?us-ascii?Q?FHN1stL2VKlE+OLRrjr45hLc2Fzgano+KM2oRGDYfv2WfzLzPt+c3r2p/KhK?=
 =?us-ascii?Q?vuiU5BYV0yJBSFHlCJfPcL5JfJeAKhyGUvihx/JxrVd/5f72o0M96H28AO+l?=
 =?us-ascii?Q?wfSfcaHn0i468MRNv0onNVN8t/pn1BDVk0eB6LoUlWnUrj9ZAofOtI3Bf5zW?=
 =?us-ascii?Q?bk7ABRv/K8RidKha7Xd10d0ljvtfJnvY6EZC5Ig+T7B0hDqF0SCnS3u+lnDn?=
 =?us-ascii?Q?RosQoWdXYCc7AIPoaq4rCAp76b08ZAWhSsBk2VNTjm2e++Q8/h7jlQRELDik?=
 =?us-ascii?Q?gxaHg91lS+E7mITpZH0thDzKeT3yd05DRR3NTNz1Zab7FvjdXheis4oKAfxm?=
 =?us-ascii?Q?aBoiFiV28vT680UCZZroOQnoevb2HLpoY8CJwsiAjVjvjiHmyQOcOUK+2aEF?=
 =?us-ascii?Q?YT4ZTSGpIwShUmaLsIilWnxza4RAe3NS45Cn0wEpVIrY+107DR4/IE7vbWhV?=
 =?us-ascii?Q?9YLV6u6mzVTKBtR+kiUCjhneZsrNmwCuIXF75gKyTnu2/3N5IBShhi+rXfZ0?=
 =?us-ascii?Q?N/p3umYSgtnVeLX5HhhkvZ2gxo7GbNwQKBJGwczZUUXUIKFbNxXq/00Ru1Pn?=
 =?us-ascii?Q?48qfOZN8KBdrDwMbp7W9surrCg4ipAZkCS8FAd8YKHUkCiDs2E93FauN/qLt?=
 =?us-ascii?Q?2x4lS8KiNfP42sVUfixuOfx3t084nZLrbkbVsA5+QiSFQqLhCYfBaLsSNdQI?=
 =?us-ascii?Q?sQF/vtggF9NdzZ6T3OaSWTioAEZMAXMZDACViyacmSAroTT7iSIgngybLue7?=
 =?us-ascii?Q?A8rgWjljoWW+y0peK74JjrGN5hYVWujW5BWbfpme?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16e8fa7-0a1c-4bba-2fd3-08db29739e4c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:47:55.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WZHAOW+dMoqYOmqtkVDJIfJ59lssRxff2cd8WwAqK2l8drSE3kQvAPh6meWdudc1W05Jx57BJ9epcCp9b53Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4121
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
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: David Sterba <dsterba@suse.com>
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

