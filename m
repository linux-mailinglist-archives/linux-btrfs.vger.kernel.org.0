Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AA35FDC99
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJMOqb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 10:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJMOq3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 10:46:29 -0400
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB406EC522
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 07:46:27 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id C249BA2306C
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 16:46:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cm_2weAcgo4l for <linux-btrfs@vger.kernel.org>;
        Thu, 13 Oct 2022 16:46:23 +0200 (CEST)
Received: from [192.168.18.35] (unknown [157.25.148.26])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 897B6A23075
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 16:46:23 +0200 (CEST)
Message-ID: <6c4676e3-45de-af5f-2064-67ebdb1d95a9@dubiel.pl>
Date:   Thu, 13 Oct 2022 16:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: pl-PL
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: btrfs send -> receive -> snapshot read only but files missing =>
 strange behaviour while btrfs delete on source system
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hello!


Computer hostname "alfa".
-------------------------

There is a subvolume that contains our system:

     /mnt/oursubvol

and I make regular snapshots of

     /mnt/snaps/001
     /mnt/snaps/003
     /mnt/snaps/004




Computer hostname "beta"
------------------------

This is local backup serwer. It connect to alfa and transmits snapshots 
to local disk:

     ssh alfa "btrfs send -p '/mnt/snaps/002' '/mnt/snaps/003" | btrfs 
receive /mnt/betabackup/

so I have backups on serwer "beta":

     /mnt/betabacup/001
     /mnt/betabacup/002
     /mnt/betabacup/003

Beta had 3 HDDs -- 8Tb, 4Tb, 4TB.
HDD 8Tb failed and I removed it from computer and put new one 6Tb.

Tried:

     btrfs replace   Hdd8Tb --> Hdd6Tb

but new drive must not be smaller than old one.

So I added 6Tb to the filesystem and started to remove 8Tb:

     btrfs device add  Hdd6Tb  /rootofbeta
     btrfs device remove Hdd8Tb  /rootofbeta

Process is in progress.




Computer hostname "gamma"
-------------------------

This is remote server that transmits data from "beta" to location few km 
from main company.

It works like this:

     ssh beta "btrfs send -p '/mnt/betabackup/003' '/mnt/betabackup/004" 
| btrfs receive /mnt/gammabackup/


This morning everytime it tried to import data I got erorrs:

     ERROR: unlink var/lib/samba/wins.dat failed: No such file or directory



I confirmed that file exists:

     beta:/mnt/betabackup/002/var/lib/samba/wins.dat

and file doesn't exist:

     gamma:/mnt/gamma/backup/002/var/lib/samba/wins.dat

Both subvolumes:

beta:/mnt/betabackup/002
     gamma:/mnt/gamma/backup/002

are:

     1. readonly
     2. are created with btrfs send/receive
     3. and nobody, no process, while send/receive is in progress 
changed files inside subvolumes






My opinion is that, "/var/lib/samba/wins.dat" dissapeared due to "btrfs 
device delete" process on server "beta".


I can't reproduce that bug.



Standard Debian:

root@beta:~# uname -a
Linux orion 5.10.0-18-amd64 #1 SMP Debian 5.10.140-1 (2022-09-02) x86_64 
GNU/Linux

root@beta:~# cat /etc/issue
Debian GNU/Linux 11 \n \l


root@beta:~# dpkg -l | grep btrfs | cut -b 1-60

ii  btrfs-progs                        5.10.1-2
ii  python3-btrfs                      12-2




















