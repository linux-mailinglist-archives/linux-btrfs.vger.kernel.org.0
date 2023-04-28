Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA26F14FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345954AbjD1KIg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjD1KIc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 06:08:32 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBFF129
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 03:08:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id A9DA93F601
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 12:08:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iWPBxp0DvQEk for <linux-btrfs@vger.kernel.org>;
        Fri, 28 Apr 2023 12:08:26 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D28F23F474
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 12:08:26 +0200 (CEST)
Received: from 90-224-97-87-no521.tbcn.telia.com ([90.224.97.87]:41157 helo=[192.168.1.27])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1psL1d-000PLv-HA
        for linux-btrfs@vger.kernel.org; Fri, 28 Apr 2023 12:08:26 +0200
Message-ID: <75de58ce-0c16-9fd0-dd64-a8d4a7214aa8@tnonline.net>
Date:   Fri, 28 Apr 2023 12:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     linux-btrfs@vger.kernel.org
Content-Language: sv-SE, en-GB
From:   Forza <forza@tnonline.net>
Subject: /sys/devices/virtual/bdi/btrfs-* entries
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

How do I find out to what Btrfs filesystem the entries in 
/sys/devices/virtual/bdi belong to?

The BDI interface is useful to control writeback cache of slow devices, 
such as USB sticks,etc.

https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-bdi


for example:

# ls -l /sys/devices/virtual/bdi
total 0
drwxr-xr-x 3 root root 0 Apr 28 04:08 254:0
drwxr-xr-x 3 root root 0 Apr 28 04:08 254:1
drwxr-xr-x 3 root root 0 Apr 28 04:08 254:2
drwxr-xr-x 3 root root 0 Apr 28 04:08 254:3
drwxr-xr-x 3 root root 0 Apr 28 04:08 254:4
drwxr-xr-x 3 root root 0 Apr 28 04:08 254:5
drwxr-xr-x 3 root root 0 Apr 28 04:08 254:6
drwxr-xr-x 3 root root 0 Apr 28 04:08 254:7
drwxr-xr-x 3 root root 0 Apr 28 04:08 259:0
drwxr-xr-x 3 root root 0 Apr 28 11:30 7:0
drwxr-xr-x 3 root root 0 Apr 28 11:30 7:1
drwxr-xr-x 3 root root 0 Apr 28 11:30 7:2
drwxr-xr-x 3 root root 0 Apr 28 11:30 7:3
drwxr-xr-x 3 root root 0 Apr 28 11:30 7:4
drwxr-xr-x 3 root root 0 Apr 28 11:30 7:5
drwxr-xr-x 3 root root 0 Apr 28 11:30 7:6
drwxr-xr-x 3 root root 0 Apr 28 11:30 7:7
drwxr-xr-x 3 root root 0 Apr 28 04:08 8:0
drwxr-xr-x 3 root root 0 Apr 28 04:08 8:16
drwxr-xr-x 3 root root 0 Apr 28 04:08 8:32
drwxr-xr-x 3 root root 0 Apr 28 04:08 8:48
drwxr-xr-x 3 root root 0 Apr 28 11:58 btrfs-1
drwxr-xr-x 3 root root 0 Apr 28 11:58 btrfs-3
drwxr-xr-x 3 root root 0 Apr 28 11:58 btrfs-5
drwxr-xr-x 3 root root 0 Apr 28 11:58 btrfs-7
drwxr-xr-x 3 root root 0 Apr 28 11:58 btrfs-8
drwxr-xr-x 3 root root 0 Apr 28 11:20 mtd-0

There are five btrfs-* entries, which I assume corresponds to my 
existing five filesystems.

# ls -l btrfs-1
total 0
-rw-r--r-- 1 root root 4096 Apr 28 11:58 max_bytes
-rw-r--r-- 1 root root 4096 Apr 28 11:58 max_ratio
-rw-r--r-- 1 root root 4096 Apr 28 11:58 max_ratio_fine
-rw-r--r-- 1 root root 4096 Apr 28 11:58 min_bytes
-rw-r--r-- 1 root root 4096 Apr 28 11:58 min_ratio
-rw-r--r-- 1 root root 4096 Apr 28 11:58 min_ratio_fine
drwxr-xr-x 2 root root    0 Apr 28 11:58 power
-rw-r--r-- 1 root root 4096 Apr 28 11:58 read_ahead_kb
-r--r--r-- 1 root root 4096 Apr 28 11:58 stable_pages_required
-rw-r--r-- 1 root root 4096 Apr 28 11:58 strict_limit
lrwxrwxrwx 1 root root    0 Apr 28 11:58 subsystem -> ../../../../class/bdi
-rw-r--r-- 1 root root 4096 Apr 28 11:58 uevent


# grep . btrfs-1/*
btrfs-1/max_bytes:4294967296
btrfs-1/max_ratio:100
btrfs-1/max_ratio_fine:1000000
btrfs-1/min_bytes:0
btrfs-1/min_ratio:0
btrfs-1/min_ratio_fine:0
btrfs-1/read_ahead_kb:4096
btrfs-1/stable_pages_required:0
btrfs-1/strict_limit:0
