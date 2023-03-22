Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE56C517A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCVRAW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjCVRAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 13:00:01 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB1F4FCEA;
        Wed, 22 Mar 2023 09:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQSRA68JJTxYODBuWWq5271Y9IMi4icgpv+sNiYhuNS5ZyC240Man4CrkNZPQSp5+yzn7A/Nz4B+PB1Yz+r7rpdZXCzlf8TRuOFKquu10JEPrlYNSgefrBo1m3QKZtGI8N+QZwhOnhsJxahwQGETwSG+0qFJobbxwtA3Vp2dV0Zx6GuZSZx7+I7mFa7StnHdTAZznQa5tbJPaWFMOBB76GsKMXLHpDtkynOBczOfteDGknb6Jc4sSTP2xlkmm7UW+AYJEbKA9X6fe3TDEW4hERXylPplhi5L3OjhOind1gzlEpNvOZWIUMjv9DXxVDTe4o6qDaeWK+17J09NNKZpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8liiAhRP3jWHYEAcCPeXHcbpyXMgVmviKu3w+LZzZY=;
 b=l+oV2OLceVBASoNi9DJvQZq+1HxoZeH8Ibl0dd3z6Mpjrc4I93SLTwHsjIdyPcI54t/djTVN5zFKV5DMgfLihYRBVE30A4OQ9KUqjL4SEw4hdMtGDF4gTQKJP+ei39o9l9gwqg7oxtMtwQRXahioNB5u7C//JXYokHOi8bJNJfBTzWU88GbMqW7t9B5lNVaKr7YEf5Oy2JvGQK01HFpp477TCUYN20bTvisMtt9AJJA0t5P+mmmTuuXYS1O9rF0Drj6X5ipBwfQAsWO/SOv4nyJ6HVXx71g27+VEFgd7/fs/2SBnroU1Q1HEShobCVp0RulvN4sNcLAMv/Z0+Zia0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8liiAhRP3jWHYEAcCPeXHcbpyXMgVmviKu3w+LZzZY=;
 b=mxau7oYtbMzTCsWfZ4ZLpQW5Z3Cg1KTcOM1TpgF1S+gyMLcu9QmaqBR/p1P5W8blIcvmN1KcQmjyyAkFLe/ys1zwY1oaCYuca/TwK6kuQAQpgEEz8KYn1o9Vhj6cj5NxSMmKT7OZtgfwqwfPpJ20hvP9I6F1Kkb6dM/NyWWD+Cazp2zwZdsGU2+SvHjcdWpw58oesuNJHHJfTRCIOp7P0r+fbyeTr4JZgWEuLtfiSLvic3vuKXmWR7C8n4OQL7bqaRe7YfYcsP2lsOf5JBIFJjFyDVJY82a3oh2VSd8CfoertlbZFd+vpIQMsDjocpo3AbPqXxooUXmzfPdKzDXvCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5238.apcprd06.prod.outlook.com (2603:1096:4:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:59:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:59:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] btrfs: convert to kobject_del_and_put()
Date:   Thu, 23 Mar 2023 00:59:01 +0800
Message-Id: <20230322165905.55389-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230322165905.55389-1-frank.li@vivo.com>
References: <20230322165905.55389-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c93a3d4-68ca-4dd6-8f01-08db2af6d925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEH2ltGWjIXrnrAZUjcyPCitKak/i13jR+Ws9zZVhuvbEl1QlVub+7p1qj0JuQnbgAXKfVWgSnWJP2w1YVCeXqDR22nYE5UM8EsyQgeOaNNe7sBtNeuYNn7dgEa9vVKsTN5folFlLheIGrjfSUzGMTvCIXNFqcNY8DXbF3uNYo6R8iFUaeGttzYGg7MTTq7vPCaUj2F8RL15EUJ6zIfpFxoz/1EZQDdcEM22Cz69r4tu/6hDrPD5iBhlvP+C9vj4tlIDcR6TzF1lVMIeEkdnjpkHYNGoxnhPgmtSpz3oTVVGmTsDuOw9HYJE7eck0kGdsdwvb2wP+h49JNxl/WUyyPprxYUXC0rA1FUvEO8E964t7ciEjiJjm+xtP2rkbAJ5lBCnl2D8jcP5+4batKive4ECMa/3S3D/QtOtmjssFl8qgYs5MFubXYO7TqOTKKuOVWq67XEJKr/POkLbMjjRbt6LDVtxpHgF4n0zUuINc3O9deWlqTIsp/9iQJ2Huy+lSQB50nzGCIaKSxL2U74TtANI2Qo8634hXxjLkF4i86jM0SNorKITEXXLO8YOU3nkbkz07Zdp5M0OQY0GTNl4ij5aEpzSkVuQMxhZfJB6HngqEtTHd9W8GSbyWkTHxj6aYw3Lm49tvqP47dYd+MBW4XgliqC1bU5Sf7eadN5RH6KT/9ruYmL7cSFoCWxCiq6jAEEqW+2sVGBpggXHxaKT3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(2616005)(6506007)(52116002)(478600001)(6486002)(6666004)(83380400001)(110136005)(316002)(66476007)(66946007)(66556008)(6512007)(26005)(186003)(8676002)(54906003)(4326008)(1076003)(8936002)(41300700001)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6eb+6MxFN1e8eMrNgOeaXwxkwRpDqZ1itx6fxW4C1fkQTHjsu1o1U+8ZaUn?=
 =?us-ascii?Q?wYuRVyakgNyKIfqOm5Vj7HaF5JLjvgVV4FtHeD5lN/gfSwnOnZbHyAJGqNRt?=
 =?us-ascii?Q?qsWqvLch4826E9U3xMxyGxuPCh+3kwbD+EurhwXxOXoIWx/+h+9x1bC6XYae?=
 =?us-ascii?Q?IGzvMruiqzWuVxkQx7wRATM0UQHHkeF2riFf8B6EuhVkcJjs2dSJ+TtW8tfQ?=
 =?us-ascii?Q?uERRMz36k279cDarheTnJDPLJeOoY3IzKuMo0F0Etn6wXfp+fosF4sDLn+Nd?=
 =?us-ascii?Q?vXZpBILMsLMZQpMnOVpwboF5qrw3hNnPaFmTb9XaPBrkJnFLgYVykOOkOljP?=
 =?us-ascii?Q?r5e6Swv285z4TXRPrYGZ7tr4+1lyf3hBIvOwAtK9+/H5UHq2Bfqp90yIo9cQ?=
 =?us-ascii?Q?Oq7gHeF03yPwLHyQMDTlb6BgjL/p+jZzMkRNJyQ1m5q9Z8o+6ubifevuaIYp?=
 =?us-ascii?Q?IxgIBji4t8jjNWSMLsnpGl+0xQUFSpsV+1z6iNF1Gz4Q6cDKAqLMHIlzMMPw?=
 =?us-ascii?Q?0Bt1ioETeRWe3PVPsEoGBwncdWd604o+ig9blgjNKCsyJ4Y8ngxAxlQCkaKL?=
 =?us-ascii?Q?ERUhSF5Sb3+iJyfOBISNiXES+FybcJd0yl9LDbHweKKUSK2xRhB75/uer+TN?=
 =?us-ascii?Q?nM0aF8MbzdkcQKaqO8+zpHleaqg8j6TvB+5M8cIY0FakbhSuMHWuc56/t0tr?=
 =?us-ascii?Q?O5qqfxhetOdiqtMV8KI++Px+C7tdiRpOkJJ5UchI8zMiLQVPvSafbPA5yjE1?=
 =?us-ascii?Q?QjwPcIqgFsrjdCYkE/AB2VJQjD7GEaNe03RC9RTNC2cKZffGax3XEsf/Ez4j?=
 =?us-ascii?Q?+B0Kesz25nGDt94kCRkEhD+0d5kndQxTclxdeB/zVfKC36xfQzvqa1fX2hwc?=
 =?us-ascii?Q?Zs5sufM4uWHBsz0LwklY7QWJeB2407ScvO5aSdoL0BxfxbapYEPv4qS06c7f?=
 =?us-ascii?Q?3MJCyfiSPAUidZbMyyAUcQGUukPhKOFmSoMPBizHvjE7RU0jIUb9dsoI4sdH?=
 =?us-ascii?Q?D7bKlQ6AGA3k75tOcB3aEaRquzhyrWUMHByHzXfm+JA1cB7XZHDmtI5ay5nv?=
 =?us-ascii?Q?xlBynXM+KW364rc1VpB8wv40wYl1xB1nMDSW6Sz3owSQLTB8xVGJ9nuP1MCk?=
 =?us-ascii?Q?PIYUehE6eiqZfSn2HURSlVkwofvxBR8mVpOquuuP8AjRlRqEj9/eIM1n59MC?=
 =?us-ascii?Q?kajGYYQXEUBQpSWRfizVJdrUJUYfCDSQ9GOyTB3STOKhSnmWP4xSorSOrHpm?=
 =?us-ascii?Q?RznYnATOEY7em50xZ+fiapd0YZEGKg87R3G3bCOsJTbknxuAabRrcjzkfrCs?=
 =?us-ascii?Q?YG+M8/orb2jsaddBDQvV+kWh9RJqsjbNUvbt3+fxTem755DWL3Otek3PQlPU?=
 =?us-ascii?Q?wMKGBLBcZ86LugHpNLI4HtVJcb4s7qs1zXqlxKd+kg+Lvt/dxeJrm7E/J02x?=
 =?us-ascii?Q?mPiuA/sMP2tENAiWA/H2VxrNvMYpzIzJM0/aJ10bBIFt5hHaAS3dJxfnx0Xz?=
 =?us-ascii?Q?KENxx7n1fbdj8ZDr792Px2Bsw/Yu8CsX00IpXrC09kR3g3QVUoTWc0vAVGgH?=
 =?us-ascii?Q?vyNuzpeN12XTcx483B9TC8JIeZH9vq5rsyigCOuo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c93a3d4-68ca-4dd6-8f01-08db2af6d925
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:59:49.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9LR7c8BQ7IG888oPxUMRAidFegL4EjLm83RedobsfV1SFw1NwTCfpDcKTYarqObmOmrpCkARJ6lIrMsIK8JIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5238
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

