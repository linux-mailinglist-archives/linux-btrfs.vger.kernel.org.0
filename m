Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92274B2000
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 09:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346299AbiBKITa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 03:19:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiBKIT3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 03:19:29 -0500
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D81E3F
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 00:19:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id E43E43F4FE;
        Fri, 11 Feb 2022 09:19:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.911
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2gMzboL5ZEGx; Fri, 11 Feb 2022 09:19:24 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id B109A3F46E;
        Fri, 11 Feb 2022 09:19:24 +0100 (CET)
Received: from [192.168.0.134] (port=43462)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nIR9K-000C2j-UP; Fri, 11 Feb 2022 09:19:24 +0100
Message-ID: <7449749b-079f-3d62-dc64-a429c6ef35cb@tnonline.net>
Date:   Fri, 11 Feb 2022 09:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: MySQL corruption on BTRFS
Content-Language: en-US
To:     Tymoteusz Dolega <tymoteuszdolega@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAHF2GV6U32gmqSjLe=XKgfcZAmLCiH26cJ2OnHGp5x=VAH4OHQ@mail.gmail.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <CAHF2GV6U32gmqSjLe=XKgfcZAmLCiH26cJ2OnHGp5x=VAH4OHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 2/8/22 09:07, Tymoteusz Dolega wrote:
> Hello,
> I maybe encountered a bug. I'm using NixOS, and after enabling MySQL with:
> 
> services.mysql = {
>        enable = true;
>        package = pkgs.mariadb;
>   };
> 
> it cannot even start, and fails with "code=killed, status=6/ABRT". The
> problem that MySQL reports in journal is about file corruption. I
> attached all logs at the bottom of this mail.
> I tried changing database location to different BTRFS SSD, cleanly
> formatted, and problem persists. After changing database location to
> EXT4 partition, everything works perfectly. I tried newer MySQL
> version (from nix-unstable), but still errors show up. Current version
> is 10.6.5-MariaDB. I tried deleting DB folder to force it to make it
> again. Scrub is clean, check (--readonly) is clean. I have only 1
> mount option: "noatime". "mount" reports:
> (rw,noatime,ssd,space_cache,subvolid=5,subvol=/).
> 
> uname -a
> Linux desktop-nixos 5.16.4 #1-NixOS SMP PREEMPT Sat Jan 29 09:59:25
> UTC 2022 x86_64 GNU/Linux
> 
> btrfs --version
> btrfs-progs v5.14.1
> 
> sudo btrfs fi show
> Label: 'nixos'  uuid: 67b6e734-cd1e-41e3-ab7a-63660e540014
>          Total devices 1 FS bytes used 95.05GiB
>          devid    1 size 249.00GiB used 98.03GiB path /dev/nvme0n1p5
> 
> Label: 'cruc'  uuid: cc51fa3c-57db-42b6-a890-ff5cd7b18f47
>          Total devices 1 FS bytes used 125.16MiB
>          devid    1 size 931.51GiB used 2.02GiB path /dev/sdb1
> 
> btrfs fi df /mnt/cruc
> Data, single: total=1.01GiB, used=124.84MiB
> System, single: total=4.00MiB, used=16.00KiB
> Metadata, single: total=1.01GiB, used=304.00KiB
> GlobalReserve, single: total=3.25MiB, used=0.00B
> 
> dmesg.log  - https://www.dropbox.com/s/ou52m2hdjzmjy6b/dmesg.log?dl=0
> but there is not much there besides you can see I cleanly formatted the drive
> mysql - https://www.dropbox.com/s/jjthkfu0anh8n2o/mysql.log?dl=0
> log with info about corruption
> (links hosted on dropbox, you can see them without logging in)
> I will be happy to answer any needed questions.


Do you use 'nodatacow' attribute on the mysql files? You can check this 
with 'lsattr /var/lib/mysql/'. If you did, and had a power loss, the 
file could be corrupted. However, a scrub could not detect this because 
nodatacow also means no csums.

Out of experience I have had issues with "innodb_fast_shutdown" on 
mariadb. With this enabled, mariadb would sometimes take too long to 
shut down and was killed during reboots, which in turn caused 
corruptions in InnoDB.

I have set the following innodb options and have not had any more 
issues. This has been tested on many crashes and forces shut downs.

innodb_fast_shutdown = 0
innodb_flush_method  = O_DSYNC
innodb-doublewrite   = 0 # Not needed on COW filesystems. Should be 
enabled on on 'nodatacow' files.


~ Forza
