Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852895FDD36
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 17:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJMPb6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 13 Oct 2022 11:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMPb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 11:31:57 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E3A89CD9
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 08:31:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 0B2F53F5ED;
        Thu, 13 Oct 2022 17:31:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TmWh4Xmit6YG; Thu, 13 Oct 2022 17:31:52 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 1C0793F3C3;
        Thu, 13 Oct 2022 17:31:51 +0200 (CEST)
Received: from [192.168.0.119] (port=48500)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1oj0Ba-000PXO-Jn; Thu, 13 Oct 2022 17:31:51 +0200
Date:   Thu, 13 Oct 2022 17:31:49 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Leszek Dubiel <leszek@dubiel.pl>, linux-btrfs@vger.kernel.org
Message-ID: <af72b31.b561b447.183d1f92292@tnonline.net>
In-Reply-To: <6c4676e3-45de-af5f-2064-67ebdb1d95a9@dubiel.pl>
References: <6c4676e3-45de-af5f-2064-67ebdb1d95a9@dubiel.pl>
Subject: Re: btrfs send -> receive -> snapshot read only but files missing
 => strange behaviour while btrfs delete on source system
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Leszek Dubiel <leszek@dubiel.pl> -- Sent: 2022-10-13 - 16:46 ----

> 
> Hello!
> 
> 
> Computer hostname "alfa".
> -------------------------
> 
> There is a subvolume that contains our system:
> 
>      /mnt/oursubvol
> 
> and I make regular snapshots of
> 
>      /mnt/snaps/001
>      /mnt/snaps/003
>      /mnt/snaps/004
> 
> 
> 
> 
> Computer hostname "beta"
> ------------------------
> 
> This is local backup serwer. It connect to alfa and transmits snapshots 
> to local disk:
> 
>      ssh alfa "btrfs send -p '/mnt/snaps/002' '/mnt/snaps/003" | btrfs 
> receive /mnt/betabackup/
> 
> so I have backups on serwer "beta":
> 
>      /mnt/betabacup/001
>      /mnt/betabacup/002
>      /mnt/betabacup/003
> 
> Beta had 3 HDDs -- 8Tb, 4Tb, 4TB.
> HDD 8Tb failed and I removed it from computer and put new one 6Tb.
> 
> Tried:
> 
>      btrfs replace   Hdd8Tb --> Hdd6Tb
> 
> but new drive must not be smaller than old one.
> 
> So I added 6Tb to the filesystem and started to remove 8Tb:
> 
>      btrfs device add  Hdd6Tb  /rootofbeta
>      btrfs device remove Hdd8Tb  /rootofbeta
> 
> Process is in progress.
> 
> 
> 
> 
> Computer hostname "gamma"
> -------------------------
> 
> This is remote server that transmits data from "beta" to location few km 
> from main company.
> 
> It works like this:
> 
>      ssh beta "btrfs send -p '/mnt/betabackup/003' '/mnt/betabackup/004" 
> | btrfs receive /mnt/gammabackup/
> 
> 
> This morning everytime it tried to import data I got erorrs:
> 
>      ERROR: unlink var/lib/samba/wins.dat failed: No such file or directory
> 
> 
> 
> I confirmed that file exists:
> 
>      beta:/mnt/betabackup/002/var/lib/samba/wins.dat
> 
> and file doesn't exist:
> 
>      gamma:/mnt/gamma/backup/002/var/lib/samba/wins.dat
> 
> Both subvolumes:
> 
> beta:/mnt/betabackup/002
>      gamma:/mnt/gamma/backup/002
> 
> are:
> 
>      1. readonly
>      2. are created with btrfs send/receive
>      3. and nobody, no process, while send/receive is in progress 
> changed files inside subvolumes
> 
> 
> 
> 
> 
> 
> My opinion is that, "/var/lib/samba/wins.dat" dissapeared due to "btrfs 
> device delete" process on server "beta".
> 
> 
> I can't reproduce that bug.
> 

Have you ever used "btrfs property set" to change a subvolume/snapshot from ro to rw or vice versa on either computer? This can cause issues like this, even after a while. 




> 
> 
> Standard Debian:
> 
> root@beta:~# uname -a
> Linux orion 5.10.0-18-amd64 #1 SMP Debian 5.10.140-1 (2022-09-02) x86_64 
> GNU/Linux
> 
> root@beta:~# cat /etc/issue
> Debian GNU/Linux 11 \n \l
> 
> 
> root@beta:~# dpkg -l | grep btrfs | cut -b 1-60
> 
> ii  btrfs-progs                        5.10.1-2
> ii  python3-btrfs                      12-2
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 


