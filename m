Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5746C0019
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Mar 2023 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCSImX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 04:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCSImH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 04:42:07 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE116894;
        Sun, 19 Mar 2023 01:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+SNo2E1oNZK8iYYa5B9+wl+xgvajvjRZCZsIY/kzrtn51LR0KrTleLusEYJGNsZ39XmvigsMk2Vly4CpkkRRC8TMNPuYjPULVxC5FnkHfWyqT5rGhWXK6K522DUVtBOzZyLjHFGE3pRP3zHIdi3hwcuRhr5n28rJn16O+NswkMEczR8KVz6HQFYOuKpc4KBlyUygkapGqNxN3y4yDkfpBwWgmDKF3899kcTn8BXAPso+gU/H4aaVqyvFCDeifVAFUj1xPtSby4B0DaU5tAVsNpxdUnkLe31BMTTF6cucq4dwYuBKgAxy+k+zseepruzdfuSLcifwaGi+MW5bfePQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlT6wa0rq/oWNEWGEA+Yww5+xB3nakyoVLcNIuupIpM=;
 b=Yq90sQr2OrmbHO5QUMkFYidWe3tGQpq+hGBc5oDThpZg4PG8nDds86D3CF2CnTV2cRXEo8SWsGtO9TBa4Q8YrUiiLpHxAtXZN2a1cGlfxa8vp3FK+Z1QXOfHCs7Xb8L76v4wQZ6X/ZHhOCK4tk9THOlnRoNdt+tA39Iufad/DwnqC1FU+C3jlKxDoIxzoYqRR4LVUTdb2XXo54rYsIs/hqNzUa8peOd5UwVH0jjKB0hhNs9o/vXu+aWTS//BNrnBeAPUXCEZx/Cjhh3B68CBYmnvyrTBgqStyNfTlBmdUsJLw/tV0SEuNy5gxybW+T/EY20EPejSPcQFISZeX+2sRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlT6wa0rq/oWNEWGEA+Yww5+xB3nakyoVLcNIuupIpM=;
 b=mwSeA/NzBYqEBNN9EoAno5dXR8eCmTO6RNesOTJpmeFb0vmtI8+r7oYWgJFvFWS6b3sdEDKsKNQFTOZkI4r7L7bQV2YcJwgyuDoz5xMMPYII41X4zZA7dZiZmjzTn2Z4kKqy3Phf58kjowTYym+M6tRVMKMIVCAn3ghjIjGK0lenHb50JWeAtz/2apAZ21t+XKElLWvuzGkNKY4PymBpV0+nv9mb7P/aV9nVglgAq6j2YpANjuQufSDshXG4IeAbZKDonzsfr913s/5z9+J7IYvvBsXPVgyDLa3O3v2j3papbhHQ5cFnqpBbLoWLcRJZgmBA9a9kQ8Tp0mGyh52A3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:42:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:42:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] btrfs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 16:41:29 +0800
Message-Id: <20230319084134.11804-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319084134.11804-1-frank.li@vivo.com>
References: <20230319084134.11804-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b5616b-6d5b-4d42-0e4b-08db2855cf7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uskNL7xN3SMolybc+tqT3uuPFJIDM8Zroca6sJfrgTHXh0yIA9feRCdBzlTsdtp1TXIBDg6ACMhvjmie7YglG+zMgy7lPFUx3wG/4SN4i2jeKhxXWYD1/4a+vJVYcKUKENABLS4U1e/zvyu6xOMl/qdfxus2GwOsxA6c89+/APZRV99FCPXudaTms1OZUG6p7xrPEq6AgAHo77xUpgbYueca/oxoC+Tq+dS9prureuG232qH7wHhYyfJMzRPHFjqwQ+XauMDoLc9SpmYC6M9Dp1OAk0byBaFZw/fVHQ4JCkfgB8WW4Pxm+pI8ETFyw1R36W4p7SKVsaEKZUAdTVgGNgya9zY2wd4mRDMrkORvZB+ic70mlcTb5thN1GA1V2xFjz96dZHHSvwUqpvUV7fjAUu0/9ufsgznKjPk8bupCS8lrnU9T13sq3MsuHSvYJmQicTDc2DGrO/uleiZXtaVl8tx7AOflZV/1CBxeuU0LzyEFYh66mt47vLfwIVDNmWftUkubj7uxaSZkO4LOEPvpA6pca4iWzI99HWeeOSIj+3jRwl1fjmSbo/WC9Q3HyfDWw52KB4sFBaasOYtmVTgPZZ0HnzhlY2dwuw1w+VPxHuNOnflAfRKRMSw07VFNP/ppOEKRy+s3c3bpcQvWhzRNBJLkcnzuP/0tdKaZHliaboJeifRgwcPMWgEF2Ctp1bgr8fHeQ9u0+gpqaQzHK5ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(110136005)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GfJ3l0NVdqliGwu/0Xwdg4PAJEV0WSM/6ypqs3hyDB4StYenY6oZ41NAYlsI?=
 =?us-ascii?Q?09F+Io3nuqpqXU29lz+ONrZfg9ivZ0wSObtbQdCMwOcKu3pLHe17itS0EqWe?=
 =?us-ascii?Q?5MdW7HDlw/D0FhxyBlxjhaef7T+XNrmpvIQr8c1QJALoprLwjazuPg/zPhwY?=
 =?us-ascii?Q?uKKOd+wN/5LA5sviMXR96EsGUHhI7KFWTzsejOQZqbarJZNvMR9jVAn4QsuU?=
 =?us-ascii?Q?XRcRx17KQxVcQcDdJ05/M/+RyUc8uVU+gnYtc78YkEhHKlyfZyer1kLpw5Mv?=
 =?us-ascii?Q?/tKWD47Hn9W/tyDWQP1mCK4u1kQiQ20NIyZDu16D/QsjQ4LrFh5+lpM+sS4y?=
 =?us-ascii?Q?ugCLUH8waltx4KhNuebBqBcoYIzGMnpDokWgyDbW3/6hhuzHzrOpaPVnMzfI?=
 =?us-ascii?Q?mRRbpzfRLNnxNKoSPoUb/lFkY1jJCvNncCOcgWvPgdN7N18eXUgqJLWuH3YR?=
 =?us-ascii?Q?Cev1B5pfkeURSgAjBTQRaKdHZ6p6t3KVCqfWNHDdeklQYVrNznH18d8S3DlP?=
 =?us-ascii?Q?VYipHlQBGr3xynjeGCC0U0112Qm33NVuxyUwxGmXKi5lmHevvIxshBlMgnR4?=
 =?us-ascii?Q?bPF5+fm6WubcZYmx44VVt7MmihDi3t9S/LhHkQJjgPQAITdpKp+15LI+k2xQ?=
 =?us-ascii?Q?iWhnzV0hC09hVNJ+/ilSzJ3ULeVSR2OYd3UisFqqe43O1ijKOqYsp/pBQw0p?=
 =?us-ascii?Q?5FdyhYUnObd+s4SR3OsHvFOkXL3LJe6AVoEWI31udo/GebYP+eKhpBc09rUE?=
 =?us-ascii?Q?Lpb7WjbuvH4KGKX1eaeK4KkKai8yoKNFnKEwhkCvhnLGFX26Bce81bQ4UxXx?=
 =?us-ascii?Q?92i9Jt9OYMgGOB2QqBUE2Nr143dt/SO/EPDQHDV173g9EroBacD4Efxd8dIY?=
 =?us-ascii?Q?BWIHwbTGlmqRzI4OIcOJixjw+k6QLMards3VKbTsl+9tqtiDWXQ4Dez0HI0o?=
 =?us-ascii?Q?qQ+4lIlzDWFp2rqf60sQl6FtbSV3fKzXid50XMnZqXLmvxDRBnNpxQQzKZ4K?=
 =?us-ascii?Q?U6dXfugmMb7vY0yosWS61cB7ewZm7BcR6F4Jnd3w8UFYXfa/xavVFL9EmLzp?=
 =?us-ascii?Q?Z31ZDOpo13Vi3mej/STo7IKGwIOGd74AFqbBUW4npvynVpSF+2/aQdMd88YN?=
 =?us-ascii?Q?yIWgMSF26TZDQjfioVbbabDCTz9nD6+PsVXf5HeEohYCszOgP1tlsYom01Ze?=
 =?us-ascii?Q?9/W5iLzM6EUT9CF8MB6obMkyUyfQDyrghQHw4qDEKN2ft3neSvfVOnhtnYx5?=
 =?us-ascii?Q?BCCEGFHquNSIi33TJzMVgGhUxtfEBAVsJR8wgQyDoqzfZL9K/+RrfMT+OKeP?=
 =?us-ascii?Q?bvdGos39JVkKAFJdo1t9C+lfkYQ0tmgbKnewYwqrkMiSXmmVMbxwiORceBGi?=
 =?us-ascii?Q?eKTbu2k++gc/r8gS1z5NK2Ow8ZYFtKrZYBD5X6uK4fKnmmFOF4Ds62pMwdBW?=
 =?us-ascii?Q?4xMMBjbnojVTgb3tDD85gV8j3pZr8amPx+n5DDFxQRwcmK8F2qUBBvdTz0wL?=
 =?us-ascii?Q?sjtpOqPFbw7joc3Y+1cqvnfiUHQG2iShMqQq6IRN6RGdBZO0nGDuEg3Ip8Gw?=
 =?us-ascii?Q?goimBqCNtYAzNPs5XDRYrkz+/QK18C0IOS7VkE7o?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b5616b-6d5b-4d42-0e4b-08db2855cf7a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:42:02.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NktjqHvctGJtGvM49pqk/GpstnrA32IHm+TNnoxKI7q1Eisw9AV/BFz3gdbFjaf9xUOCA/0li/5d8p7BxDE5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use kobject_del_and_put() to simplify code.

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

