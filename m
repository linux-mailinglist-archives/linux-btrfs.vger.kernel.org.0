Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404A6519DC3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 13:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348639AbiEDLUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 07:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348640AbiEDLUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 07:20:11 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [IPv6:2a10:3781:1891:64::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB819240AF
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 04:16:35 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id 9C70482E88
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 13:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651662993;
        bh=bFVV0KDcbLs2lgrlE0MCxb+dQoR7UzLvfo9LQm2twGs=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To;
        b=Ewy0W8HQWZ7cb1nPaT5qXxk4iVA3QPY4joD83VyMO7AAZatdKl5Gn7A1Zy0AGVqMv
         BjafwCHpCkzG1+wRhTdZu9PszRk4/I/nlijf2gk00B19aZq/xZ10mDnp74bH9rI0bB
         YgklXhgD2t/shUNXc9k/pC28yKUHnpPoOsn+DtTBMb805fkz1dOl0OQEwtqS9qbHNF
         Gd3HpL6tCANx+cu+UByPQBPn+0iQnXk/DTMHFw0wo8K2d9izjAkyeAZAZOBxw6lKMI
         sGJn2a/5Rpnubolmjbl5HA1yaE1d/lvP3jWsET2/KKlNBZ6pGzS1FbkcDS7I2074V8
         2o8TqpgDyqmNQ==
Date:   Wed, 4 May 2022 13:16:32 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Debian Bullseye install btrfs raid1
Message-Id: <20220504131632.00ffbd49c7ec5a7782f0e662@lucassen.org>
In-Reply-To: <20220504102608.u4oublhjagp5h5hm@bitfolk.com>
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
        <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
        <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
        <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
        <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
        <20220504102608.u4oublhjagp5h5hm@bitfolk.com>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 4 May 2022 10:26:08 +0000
Andy Smith <andy@strugglers.net> wrote:

> You can pause at the grub menu and edit the current boot selection
> to have the additional kernel command line parameter:
> 
>     rootflags=degraded
> 
> That has the same effect as "Mount -o degraded …" or putting
> "degraded" in the fstab options.

Yes, but apparently I fsck'd up the whole system, even with two disks.
I will first add a single disk / filesystem as rescue (never mind, this
is a test system):

[    5.622734]  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
[    5.634754]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    5.649152] sd 1:0:0:0: [sdb] Attached SCSI disk
[    5.652889] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.724026] random: fast init done
[    5.821439] md/raid1:md0: active with 2 out of 2 mirrors
[    5.827536] md0: detected capacity change from 0 to 262078464
[    5.828427] md/raid1:md1: active with 2 out of 2 mirrors
[    5.839332] md1: detected capacity change from 0 to 4294901760

[..]

Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... [    6.826141] Btrfs loaded, crc32c=crc32c-generic
Scanning for Btrfs filesystems
[    6.868147] random: fast init done
[    6.901066] BTRFS: device label data devid 1 transid 50 /dev/sda6 scanned by btrfs (171)
[    6.909951] BTRFS: device fsid 1739f989-05e0-48d8-b99a-67f91c18c892 devid 1 transid 23 /dev/sda5 scanned by btrfs (171)
[    6.921421] BTRFS: device fsid f9cf579f-d3d9-49b2-ab0d-ba258e9df3d8 devid 1 transid 3994 /dev/sda3 scanned by btrfs (171)
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
Begin: Running /scripts/local-block ... [   27.012381] md/raid1:md0: active with 1 out of 2 mirrors
[   27.017890] md0: detected capacity change from 0 to 262078464
[   27.033248] md/raid1:md1: active with 1 out of 2 mirrors
[   27.038793] md1: detected capacity change from 0 to 4294901760
done.
done.
done.
Warning: fsck not present, so skipping root file system
[   27.229282] BTRFS info (device sda3): flagging fs with big metadata feature
[   27.236375] BTRFS info (device sda3): allowing degraded mounts
[   27.242285] BTRFS info (device sda3): disk space caching is enabled
[   27.248579] BTRFS info (device sda3): has skinny extents
[   27.256813] BTRFS warning (device sda3): devid 2 uuid 5b50e238-ae76-426f-bae3-deee5999adbc is missing
[   27.266833] BTRFS warning (device sda3): devid 2 uuid 5b50e238-ae76-426f-bae3-deee5999adbc is missing
[   27.284235] BTRFS info (device sda3): enabling ssd optimizations
done.
Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ... mount: mounting /dev on /root/dev failed: No such file or directory
mount: mounting /dev on /root/dev failed: No such file or directory
done.
mount: mounting /run on /root/run failed: No such file or directory
run-init: can't execute '/sbin/init': No such file or directory
Target filesystem doesn't have requested /sbin/init.
run-init: can't execute '/sbin/init': No such file or directory
run-init: can't execute '/etc/init': No such file or directory
run-init: can't execute '/bin/init': No such file or directory
run-init: can't execute '/bin/sh': No such file or directory
run-init: can't execute '': No such file or directory
No init found. Try passing init= bootarg.


BusyBox v1.30.1 (Debian 1:1.30.1-6+b3) built-in shell (ash)
Enter 'help' for a list of built-in commands.

(initramfs)


-- 
richard lucassen
https://contact.xaq.nl/
