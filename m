Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD57AFC03
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjI0H0w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 03:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjI0H0p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 03:26:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD24510E
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 00:26:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so164975e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695799602; x=1696404402; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Hepuhsd2icqQ3qyXYoiwvvZ1YleoORcb7UzvxmfKrM=;
        b=OVP76n2T+oCVEjr2aIjBUK75e1Mt+ytUqPwnX4oXIl9rdv5Ec1gQ2Ra24Fn0ic7dh4
         ApGS4NL9a5mQ4zyN1kSu1SHuYDCIYj/2ftcBx8nny3NB8e5cfv3KaUQnFIva+PIWBmD4
         At4Qb3zLBEtHjSwksLN0t6eneTt7qH+VNGxHQGBJoq+OoUO8JdsP3BvjL6P0hkicd/ue
         lm1R270Hu6H9oUWKoArbv6tZoZbPfp7ZgDIFCG5b8oX8/K0Fxm0+qbvBHnCn3cgAB51c
         eyj8iUhvDwCnLiTNNZTAdHd1dLJpvUDnP5Bngef3wEQp5kJPjMLtUdUgRf53b5Odw0lQ
         qcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695799602; x=1696404402;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Hepuhsd2icqQ3qyXYoiwvvZ1YleoORcb7UzvxmfKrM=;
        b=L8KsrS2B3Cy9vJ1Fr1He0lgW9aMNwKW9wICVS9RfxtaBJID8FNHHH4PQgrDBVlhMZl
         CD6bXCOWfqxQabYtwT+8Teu9UVu2uMBhqoh7LXca6GwdhVD0CzNAT/ARB+g2+d1rRbUn
         btrNwugvAx6ZkWIoyUxoxrjNwVHFD+F8hFwS/iYvAr2Aa5aWURgONU1M+HmX1uwL1kjt
         d8AO7CVSvtKTqTjL5lTyS8WIDvycw1wNXz9MFIT/YK8bn7/VhsgCy5mjckcfY/9RvatS
         bbo5dbO/GOIc+Xd5/cTrsOu1QhVitZ//D/CWSs+5RxgtKPnlJesAtnNxUzdJM40dbhWE
         FPDg==
X-Gm-Message-State: AOJu0YxAQTBFytxuxb9lDp7FaZxFhciJCF8FDCaOxvF3LWBiuwomiend
        3yZBbS1tVvzZCOvJwOL/wAucCw==
X-Google-Smtp-Source: AGHT+IGw951N/YY334RvWpv8jvBox8Xcej+LdqT5ijELn7yUbnveqXMXokEj2abASTOJ+P6j512t6w==
X-Received: by 2002:a7b:c84b:0:b0:405:3ae6:2401 with SMTP id c11-20020a7bc84b000000b004053ae62401mr1200832wml.14.1695799601458;
        Wed, 27 Sep 2023 00:26:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t18-20020a1c7712000000b00405959469afsm6161726wmi.3.2023.09.27.00.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 00:26:40 -0700 (PDT)
Date:   Wed, 27 Sep 2023 10:26:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     boris@bur.io
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: qgroup: flush reservations during quota disable
Message-ID: <dfadfecc-e50b-425a-80f7-3ae1290db2d3@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Boris Burkov,

The patch 5e99a45f1f0f: "btrfs: qgroup: flush reservations during
quota disable" from Jun 28, 2023 (linux-next), leads to the following
Smatch static checker warning:

	fs/btrfs/qgroup.c:1437 btrfs_quota_disable()
	error: double unlocked '&fs_info->qgroup_ioctl_lock' (orig line 1366)

fs/btrfs/qgroup.c
    1332 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
    1333 {
    1334         struct btrfs_root *quota_root;
    1335         struct btrfs_trans_handle *trans = NULL;
    1336         int ret = 0;
    1337 
    1338         /*
    1339          * We need to have subvol_sem write locked to prevent races with
    1340          * snapshot creation.
    1341          */
    1342         lockdep_assert_held_write(&fs_info->subvol_sem);
    1343 
    1344         /*
    1345          * Lock the cleaner mutex to prevent races with concurrent relocation,
    1346          * because relocation may be building backrefs for blocks of the quota
    1347          * root while we are deleting the root. This is like dropping fs roots
    1348          * of deleted snapshots/subvolumes, we need the same protection.
    1349          *
    1350          * This also prevents races between concurrent tasks trying to disable
    1351          * quotas, because we will unlock and relock qgroup_ioctl_lock across
    1352          * BTRFS_FS_QUOTA_ENABLED changes.
    1353          */
    1354         mutex_lock(&fs_info->cleaner_mutex);
    1355 
    1356         mutex_lock(&fs_info->qgroup_ioctl_lock);
    1357         if (!fs_info->quota_root)
    1358                 goto out;
    1359 
    1360         /*
    1361          * Unlock the qgroup_ioctl_lock mutex before waiting for the rescan worker to
    1362          * complete. Otherwise we can deadlock because btrfs_remove_qgroup() needs
    1363          * to lock that mutex while holding a transaction handle and the rescan
    1364          * worker needs to commit a transaction.
    1365          */
    1366         mutex_unlock(&fs_info->qgroup_ioctl_lock);

We drop the lock.

    1367 
    1368         /*
    1369          * Request qgroup rescan worker to complete and wait for it. This wait
    1370          * must be done before transaction start for quota disable since it may
    1371          * deadlock with transaction by the qgroup rescan worker.
    1372          */
    1373         clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
    1374         btrfs_qgroup_wait_for_completion(fs_info, false);
    1375 
    1376         ret = flush_reservations(fs_info);
    1377         if (ret)
    1378                 goto out;

The patch introduces a new goto.

    1379 
    1380         /*
    1381          * 1 For the root item
    1382          *
    1383          * We should also reserve enough items for the quota tree deletion in
    1384          * btrfs_clean_quota_tree but this is not done.
    1385          *
    1386          * Also, we must always start a transaction without holding the mutex
    1387          * qgroup_ioctl_lock, see btrfs_quota_enable().
    1388          */
    1389         trans = btrfs_start_transaction(fs_info->tree_root, 1);
    1390 
    1391         mutex_lock(&fs_info->qgroup_ioctl_lock);
    1392         if (IS_ERR(trans)) {
    1393                 ret = PTR_ERR(trans);
    1394                 trans = NULL;
    1395                 set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
    1396                 goto out;
    1397         }
    1398 
    1399         if (!fs_info->quota_root)
    1400                 goto out;
    1401 
    1402         spin_lock(&fs_info->qgroup_lock);
    1403         quota_root = fs_info->quota_root;
    1404         fs_info->quota_root = NULL;
    1405         fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
    1406         fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
    1407         fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
    1408         spin_unlock(&fs_info->qgroup_lock);
    1409 
    1410         btrfs_free_qgroup_config(fs_info);
    1411 
    1412         ret = btrfs_clean_quota_tree(trans, quota_root);
    1413         if (ret) {
    1414                 btrfs_abort_transaction(trans, ret);
    1415                 goto out;
    1416         }
    1417 
    1418         ret = btrfs_del_root(trans, &quota_root->root_key);
    1419         if (ret) {
    1420                 btrfs_abort_transaction(trans, ret);
    1421                 goto out;
    1422         }
    1423 
    1424         spin_lock(&fs_info->trans_lock);
    1425         list_del(&quota_root->dirty_list);
    1426         spin_unlock(&fs_info->trans_lock);
    1427 
    1428         btrfs_tree_lock(quota_root->node);
    1429         btrfs_clear_buffer_dirty(trans, quota_root->node);
    1430         btrfs_tree_unlock(quota_root->node);
    1431         btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
    1432                               quota_root->node, 0, 1);
    1433 
    1434         btrfs_put_root(quota_root);
    1435 
    1436 out:
--> 1437         mutex_unlock(&fs_info->qgroup_ioctl_lock);

Double unlock.

    1438         if (ret && trans)
    1439                 btrfs_end_transaction(trans);
    1440         else if (trans)
    1441                 ret = btrfs_commit_transaction(trans);
    1442         mutex_unlock(&fs_info->cleaner_mutex);
    1443 
    1444         return ret;
    1445 }

regards,
dan carpenter
