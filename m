Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A755C519B87
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347124AbiEDJ04 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 05:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347123AbiEDJ0y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 05:26:54 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [45.83.234.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8934B20BF4
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 02:23:18 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id 41D9E81B3F
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 11:23:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651656196;
        bh=t+DpKzOwIFI4VTDeNXNgow3ZOpMzxpER4LFTOqPBmOA=;
        h=Date:From:To:Subject:Reply-To;
        b=Qj/ekqmst4KBYWkCgPF9xfSEUKw3LY2hB1dY2xPDoPD7c8yZFFaERG9BIKbr4u5Tn
         KmIXagiL5VMfp/mLgOYRzeIX1W1dLDQUo7U4Ts+q7JBTPww04GNm1vkpH7O+cZxGl8
         fTI9v01MXaGcm3JOWghQcmM8BE1m5Ofsv6hjeZdIC/3mH0/73VzM9pXhGrX7axooLN
         ZhoNgeGKwLvq6WTFgKSrXiVNmEYgiOO+JZzthfcB7ZneUT6b5FstbXY1BYfVttrCWw
         PzMHWDM5wEURE3mkqZzfsk05taXYtd3RQlr7O3juG97gKkB/moKnBFMc28qYczxRoo
         YsGWzmkyUBB8A==
Date:   Wed, 4 May 2022 11:23:15 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Debian Bullseye install btrfs raid1
Message-Id: <20220504112315.71b41977e071f43db945687c@lucassen.org>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello list,

Still new to btrfs, I try to set up a system that is capable of booting
even if one of the two disks is removed or broken. The BIOS supports this.

As the Debian installer is not capable of installing btrfs raid1, I
installed Bullseye using /dev/md0 for /boot (ext2) and a / btrfs on /dev/sda3.
This works of course. After install I added /dev/sdb3 to the / fs: OK.
Reboot: works. Proof/pudding/eating: I stopped the system, removed one of the
disks and started again. It boots, but it refuses to mount the / fs, either
without sda or sdb.

Question: is this newbie trying to set up an impossible config or have I
missed something crucial somewhere?

R.

Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... [    6.809309] Btrfs loaded, crc32c=crc32c-generic
Scanning for Btrfs filesystems
[    6.849966] random: fast init done
[    6.884290] BTRFS: device label data devid 1 transid 50 /dev/sda6 scanned by btrfs (171)
[    6.892822] BTRFS: device fsid 1739f989-05e0-48d8-b99a-67f91c18c892 devid 1 transid 23 /dev/sda5 scanned by btrfs (171)
[    6.903959] BTRFS: device fsid f9cf579f-d3d9-49b2-ab0d-ba258e9df3d8 devid 1 transid 3971 /dev/sda3 scanned by btrfs (171)
Begin: Waiting for suspend/resume device ... Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... [   27.015660] md/raid1:md0: active with 1 out of 2 mirrors
[   27.021181] md0: detected capacity change from 0 to 262078464
[   27.036555] md/raid1:md1: active with 1 out of 2 mirrors
[   27.042062] md1: detected capacity change from 0 to 4294901760
done.
done.
done.
Warning: fsck not present, so skipping root file system
[   27.235880] BTRFS info (device sda3): flagging fs with big metadata feature
[   27.242984] BTRFS info (device sda3): disk space caching is enabled
[   27.249314] BTRFS info (device sda3): has skinny extents
[   27.258259] BTRFS error (device sda3): devid 2 uuid 5b50e238-ae76-426f-bae3-deee5999adbc is missing
[   27.267448] BTRFS error (device sda3): failed to read the system array: -2
[   27.275696] BTRFS error (device sda3): open_ctree failed
mount: mounting /dev/sda3 on /root failed: Invalid argument
Failed to mount /dev/sda3 as root file system.


BusyBox v1.30.1 (Debian 1:1.30.1-6+b3) built-in shell (ash)
Enter 'help' for a list of built-in commands.

(initramfs)


-- 
richard lucassen
https://contact.xaq.nl/
