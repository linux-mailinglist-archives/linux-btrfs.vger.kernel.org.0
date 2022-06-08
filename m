Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15639542D85
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiFHKZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 06:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbiFHKYa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 06:24:30 -0400
Received: from out20-62.mail.aliyun.com (out20-62.mail.aliyun.com [115.124.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D881567C6
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 03:15:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04437037|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0943867-0.00370034-0.901913;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.O0.cgON_1654683297;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O0.cgON_1654683297)
          by smtp.aliyun-inc.com;
          Wed, 08 Jun 2022 18:14:58 +0800
Date:   Wed, 08 Jun 2022 18:15:02 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: What mechanisms protect against split brain?
Cc:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <20220608104421.3759.409509F4@e16-tech.com>
References: <c31c664.705b352f.1810f98f3ee@tnonline.net> <20220608104421.3759.409509F4@e16-tech.com>
Message-Id: <20220608181502.4AB1.409509F4@e16-tech.com>
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

Hi, Forza, Qu Wenruo

I write a script to test RAID1 split brain base on Qu's work of raid5(*1)
*1: https://lore.kernel.org/linux-btrfs/53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com/T/#u

#!/bin/bash
set -uxe -o pipefail

mnt=/mnt/test
dev1=/dev/vdb1
dev2=/dev/vdb2

  dmesg -C
  mkdir -p $mnt

  mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
  mount $dev1 $mnt
  xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
  sync
  umount $mnt

  btrfs dev scan -u $dev2
  mount -o degraded $dev1 $mnt
  #xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
  mkdir -p $mnt/branch1; /bin/cp -R /usr/bin $mnt/branch1 #complex than xfs_io
  umount $mnt

  btrfs dev scan
  btrfs dev scan -u $dev1
  mount -o degraded $dev2 $mnt
  #xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
  mkdir -p $mnt/branch2; /bin/cp -R /usr/lib64 $mnt/branch2 #complex than xfs_io
  umount $mnt

  btrfs dev scan
  mount $dev1 $mnt # *1
  ls $mnt

  btrfs balance start --full-balance $mnt # *2
  #btrfs scrub start -B $mnt  # *3
  #btrfs scrub start $mnt; sleep 2; btrfs scrub status $mnt; btrfs scrub start -B $mnt; # *4

  umount $mnt

test result:
we may fail in # *1; # *2; # *3; #*4 with different frequency.

dmesg output:
1)
[ 1379.124079] BTRFS error (device vdb1): tree level mismatch detected, bytenr=31866880 level expected=1 has=0
[ 1379.127928] BTRFS error (device vdb1): tree level mismatch detected, bytenr=31866880 level expected=1 has=0
[ 1379.132109] BTRFS error (device vdb1: state C): failed to load root csum
[ 1379.137281] BTRFS error (device vdb1: state C): open_ctree failed

2)
[ 2950.467178] BTRFS error (device vdb1): tree first key mismatch detected, bytenr=32342016 parent_transid=9 key expected=(301555712,168,106496) has=(2552,96,5)
[ 2950.471283] BTRFS error (device vdb1): tree first key mismatch detected, bytenr=32342016 parent_transid=9 key expected=(301555712,168,106496) has=(2552,96,5)
[ 2950.479960] BTRFS info (device vdb1): balance: ended with status: -117

so RAID1 split brain case yet not supported by btrfs now.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/08

> Hi,
> 
> I tried some test about this case.
> 
> After the missing RAID1 device is re-introduced,
> 1, mount/read seem to work.
>    checksum based error detect help.
>    current pid based i/o patch select policy may help too.
>        preferred_mirror = first + (current->pid % num_stripes);
> 
> 2, 'btrfs scrub' failed to finish.
>     Any advice to return to clean state?
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/08
> 
> > Hi,
> > 
> > Recently there have been some discussions, both here on the mailing list and on #btrfs IRC, about the consequences of mounting one RAID1 mirror as degraded and then later re-introduce the missing device. But also on having degraded mount option in fstab and kernel command line.
> > 
> > So I wonder if Btrfs has some protective mechanisms against data loss/corruption if a drive is missing for a bit but later re-introduced. There is also the case of split brain where each mirror might be independently updated and then recombined.
> > 
> > Is there an official recommendation to have with regards to degraded mounts from kernel command line? I understand the use case as it allows the system to boot even if a device goes missing or dead after a reboot.
> > 
> > Thanks,
> > Forza
> 


