Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70C4C0EC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiBWJCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 04:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbiBWJCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 04:02:31 -0500
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66C735DED
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 01:02:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 03530405D9
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 10:02:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.909
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zeLUjV_ub1WT for <linux-btrfs@vger.kernel.org>;
        Wed, 23 Feb 2022 10:01:59 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 0BF06405CD
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 10:01:59 +0100 (CET)
Received: from [192.168.0.134] (port=32990)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nMnXB-000Ilb-PE
        for linux-btrfs@vger.kernel.org; Wed, 23 Feb 2022 10:01:58 +0100
Message-ID: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
Date:   Wed, 23 Feb 2022 10:01:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   Forza <forza@tnonline.net>
Subject: Crash/BUG on during device delete
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Subject:
Crash/BUG on during device delete
From:
Forza <forza@tnonline.net>
Date:
2/23/22, 09:59
To:
linux-btrfs@vger.kernel.org

Hi!

I am running a test system and experienced a hard lockup with the 
following message:

[53869.712800] BTRFS critical: panic in extent_io_tree_panic:689: 
locking error: extent tree was modified by another thread while locked 
(errno=-17 Object already exists)
[53869.712825] kernel BUG at fs/btrfs/extent_io.c:689!

Kernel: 5.15.16-0-lts #1-Alpine SMP
CPU: Xeon(R) E-2126G
MB: SuperMicro X11SCL-F, 64GB ECC RAM
Broadcom 9500-8i HBA SAS controller


I had 5 SSDs in a RAID1 filesystem and wanted to delete 3 of them.

# btrfs device delete /dev/sdf /dev/sdd /dev/sdd /mnt/nas_ssd

When about 6GB was left on the last device I got a kernel BUG message 
with stack trace. Unfortunately the message was not saved to syslog - 
anything trying to access the system disk froze, even though the "btrfs 
device delete" operation was not performed on the root filesystem. I 
managed to get some screenshots of the trace.

I performed a hard reset and the system booted normally. A scrub showed 
no errors and a new "btrfs device delete /dev/sde /mnt/nas_ssd/" 
finished without errors.

Attached images (wasn't able to send them to the list):
https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-23083359.png
https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg

I can do some further tests if needed. otherwise I need to deploy this 
system in about a week.

Thanks.


