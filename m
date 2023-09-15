Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD4F7A16DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjIOHFn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 03:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjIOHFm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 03:05:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F7010C3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 00:05:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-403012f276dso19585735e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 00:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694761535; x=1695366335; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38xP7zq7DLHNFZXMCV47BY9kWbrWCeDPUZCaYKscoDk=;
        b=XtFWMi9uZKspddQlbVQkufDreNkCJY51HTWf08lVy/rd+wNIhhy3BqXgF9SzWulmzl
         tk0pq9bHtA0oyvaa6betxOAmHtyHxQWzQTc8bNPFQQM99qEUpSuCF/tKf5Fg5RG+j7Ic
         P+FAaowXeWfAgNwlhYrnc8NxvYJvn92dgOQa2D8zs2x4ukCFePx5yaSdIOiCwSH8pRZF
         RsEHw9P9qgyoUGIiG4vvoXjE8c5zsTZO+39Nhb/AH+Qs5u5AXmrv5KvnyVCRtk6KadeE
         GYsoUTG1r6HMzJSixC3YIcdohELS4RpzprEWey1d55ASaXmFM/FCaxIi+9Ao8Ts/rKMm
         vLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761535; x=1695366335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38xP7zq7DLHNFZXMCV47BY9kWbrWCeDPUZCaYKscoDk=;
        b=wQF514u+l90y9fkEsMPaSnNM6K3lvAG/6SRhtKpYCjbX5u9sacFJGxQPmg2kPnOfxx
         d+VXV/MnJiJbZXzyJ09CQKzk8MzV9SR01kwFjK1OafVYMRTv4dvMTnxb8rOTc1VXO/Ia
         tPZEeeHMiref4YJnlXNBi3lgvSKc+n3sWS4yQj9VesO/0P1AWCvrUivUMBC/WyMVYxmM
         w6uHbxMmJ5i/RdXdglc8Z4g9G/acoAe7wp5gi8EPos7eqbtyJ+9o65Zz0S5hCK5gqUrq
         bUKSW/pORFGavbDKWeet2T3QBU5lVafFtgC4Lb3UZd8K3VDDPWLHQSVmWwWf7AOkqqBI
         GYSA==
X-Gm-Message-State: AOJu0Yzj1CLGlSoH2GlvKgfBltsiqmieCMMrHdOpkFVE7WCDhcP+/UAV
        Ekfk+/asO1YX+3vRH31pkPXiXg==
X-Google-Smtp-Source: AGHT+IFqij6n5ApDcNF+zFoZrwluPHT0OK3OViHqkWbv0+GuPW0vlRvFbP2t3UN7e7TyuldWuAcq8Q==
X-Received: by 2002:a7b:cbc8:0:b0:404:757e:c5ba with SMTP id n8-20020a7bcbc8000000b00404757ec5bamr815716wmi.26.1694761535393;
        Fri, 15 Sep 2023 00:05:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y14-20020a7bcd8e000000b004030e8ff964sm6731108wmj.34.2023.09.15.00.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:05:35 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:05:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     anand.jain@oracle.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: scan but don't register device on single device
 filesystem
Message-ID: <32e15558-0a3f-418a-b3ae-8cfbddbff7af@moroto.mountain>
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

Hello Anand Jain,

The patch d41f57d15a90: "btrfs: scan but don't register device on
single device filesystem" from Sep 9, 2023 (linux-next), leads to the
following Smatch static checker warning:

	fs/btrfs/volumes.c:1420 btrfs_scan_one_device()
	error: uninitialized symbol 'devt'.

fs/btrfs/volumes.c
    1411         if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
    1412             !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
    1413                 dev_t        devt;
    1414 
    1415                 ret = lookup_bdev(path, &devt);
    1416                 if (ret) {
    1417                         btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
    1418                         path, ret);

Should this goto?

    1419                 }
--> 1420                 btrfs_free_stale_devices(devt, NULL);
                                                  ^^^^
Uninitialized if lookup_bdev() fails.

    1421 
    1422                 pr_debug("BTRFS (%s) skip registering single non seed device\n",
    1423                          path);
    1424                 device = NULL;
    1425                 goto free_disk_super;
    1426         }
    1427 
    1428         device = device_list_add(path, disk_super, &new_device_added);
    1429         if (!IS_ERR(device) && new_device_added)
    1430                 btrfs_free_stale_devices(device->devt, device);
    1431 
    1432 free_disk_super:
    1433         btrfs_release_disk_super(disk_super);
    1434 
    1435 error_bdev_put:
    1436         blkdev_put(bdev, NULL);
    1437 
    1438         return device;
    1439 }

regards,
dan carpenter
