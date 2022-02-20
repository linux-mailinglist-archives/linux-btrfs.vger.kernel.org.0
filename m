Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0352C4BCD8F
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Feb 2022 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiBTJll (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Feb 2022 04:41:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiBTJll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Feb 2022 04:41:41 -0500
Received: from out20-38.mail.aliyun.com (out20-38.mail.aliyun.com [115.124.20.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12B550450
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Feb 2022 01:41:19 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04500159|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.182539-0.00565583-0.811805;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Msiap.i_1645350076;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Msiap.i_1645350076)
          by smtp.aliyun-inc.com(10.147.42.135);
          Sun, 20 Feb 2022 17:41:16 +0800
Date:   Sun, 20 Feb 2022 17:41:17 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Forza <forza@tnonline.net>
Subject: Re: MySQL corruption on BTRFS
Cc:     Tymoteusz Dolega <tymoteuszdolega@gmail.com>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <7449749b-079f-3d62-dc64-a429c6ef35cb@tnonline.net>
References: <CAHF2GV6U32gmqSjLe=XKgfcZAmLCiH26cJ2OnHGp5x=VAH4OHQ@mail.gmail.com> <7449749b-079f-3d62-dc64-a429c6ef35cb@tnonline.net>
Message-Id: <20220220174116.6461.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2/8/22 09:07, Tymoteusz Dolega wrote:
> > Hello,
> > I maybe encountered a bug. I'm using NixOS, and after enabling MySQL with:
> >
> > services.mysql = {
> >        enable = true;
> >        package = pkgs.mariadb;
> >   };
> >
> > it cannot even start, and fails with "code=killed, status=6/ABRT". The
> > problem that MySQL reports in journal is about file corruption. I
> > attached all logs at the bottom of this mail.
> > I tried changing database location to different BTRFS SSD, cleanly
> > formatted, and problem persists. After changing database location to
> > EXT4 partition, everything works perfectly. I tried newer MySQL
> > version (from nix-unstable), but still errors show up. Current version
> > is 10.6.5-MariaDB. I tried deleting DB folder to force it to make it
> > again. Scrub is clean, check (--readonly) is clean. I have only 1
> > mount option: "noatime". "mount" reports:
> > (rw,noatime,ssd,space_cache,subvolid=5,subvol=/).
> >
> > uname -a
> > Linux desktop-nixos 5.16.4 #1-NixOS SMP PREEMPT Sat Jan 29 09:59:25
> > UTC 2022 x86_64 GNU/Linux
> >
> > btrfs --version
> > btrfs-progs v5.14.1
> >
> > sudo btrfs fi show
> > Label: 'nixos'  uuid: 67b6e734-cd1e-41e3-ab7a-63660e540014
> >          Total devices 1 FS bytes used 95.05GiB
> >          devid    1 size 249.00GiB used 98.03GiB path /dev/nvme0n1p5
> >
> > Label: 'cruc'  uuid: cc51fa3c-57db-42b6-a890-ff5cd7b18f47
> >          Total devices 1 FS bytes used 125.16MiB
> >          devid    1 size 931.51GiB used 2.02GiB path /dev/sdb1
> >
> > btrfs fi df /mnt/cruc
> > Data, single: total=1.01GiB, used=124.84MiB
> > System, single: total=4.00MiB, used=16.00KiB
> > Metadata, single: total=1.01GiB, used=304.00KiB
> > GlobalReserve, single: total=3.25MiB, used=0.00B
> >
> > dmesg.log  - https://www.dropbox.com/s/ou52m2hdjzmjy6b/dmesg.log?dl=0
> > but there is not much there besides you can see I cleanly formatted the drive
> > mysql - https://www.dropbox.com/s/jjthkfu0anh8n2o/mysql.log?dl=0
> > log with info about corruption
> > (links hosted on dropbox, you can see them without logging in)
> > I will be happy to answer any needed questions.
> 
> 
> Do you use 'nodatacow' attribute on the mysql files? You can check this with 'lsattr /var/lib/mysql/'. If you did, and had a power loss, the file could be corrupted. However, a scrub could not detect this because nodatacow also means no csums.
> 
> Out of experience I have had issues with "innodb_fast_shutdown" on mariadb. With this enabled, mariadb would sometimes take too long to shut down and was killed during reboots, which in turn caused corruptions in InnoDB.
> 
> I have set the following innodb options and have not had any more issues. This has been tested on many crashes and forces shut downs.
> 
> innodb_fast_shutdown = 0
> innodb_flush_method  = O_DSYNC
> innodb-doublewrite   = 0 # Not needed on COW filesystems. Should be enabled on on 'nodatacow' files.

Is innodb-doublewrite related to CoW feature or checksum feature?

For XFS with checksum but without CoW, ' innodb-doublewrite   = 0' is
recommanded too?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/02/20

