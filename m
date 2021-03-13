Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501A8339C88
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Mar 2021 08:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhCMHWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Mar 2021 02:22:24 -0500
Received: from out20-62.mail.aliyun.com ([115.124.20.62]:37263 "EHLO
        out20-62.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMHVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Mar 2021 02:21:49 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0445291|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0172782-0.000331633-0.98239;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JkPkC-E_1615620105;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JkPkC-E_1615620105)
          by smtp.aliyun-inc.com(10.147.43.95);
          Sat, 13 Mar 2021 15:21:46 +0800
Date:   Sat, 13 Mar 2021 15:21:50 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Thomas <74cmonty@gmail.com>
Subject: Re: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719033, flush 0, corrupt 6, gen 0
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
References: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
Message-Id: <20210313152146.1D7D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

If there is some partition size change after filesystem created,
'btrfs filesystem resize max' will help.

See also
https://lore.kernel.org/linux-btrfs/42d37a6393db7ad5d83bc167459c8a5c@steev.me.uk/T/#t


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/03/12

> Hello,
> 
> I have observed this error messages in systemd journal:
> BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719033,
> flush 0, corrupt 6, gen 0
> 
> Here are the bottom lines of journalctl -xb:
> ?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=524288, want=497859712,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=524288, want=497859840,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=256, want=497859704,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
> /dev/sdb1 errs: wr 2702175, rd 2719033, flush 0, corrupt 6, gen 0
> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=256, want=497859720,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=524288, want=497859968,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
> /dev/sdb1 errs: wr 2702175, rd 2719034, flush 0, corrupt 6, gen 0
> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=256, want=497859728,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=256, want=497859712,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
> /dev/sdb1 errs: wr 2702175, rd 2719035, flush 0, corrupt 6, gen 0
> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=524288, want=497860096,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
> /dev/sdb1 errs: wr 2702175, rd 2719036, flush 0, corrupt 6, gen 0
> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=256, want=497859736,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
> ???????????????????????????????????? sdb1: rw=256, want=497859848,
> limit=496091703
> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
> /dev/sdb1 errs: wr 2702175, rd 2719037, flush 0, corrupt 6, gen 0
> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
> /dev/sdb1 errs: wr 2702175, rd 2719038, flush 0, corrupt 6, gen 0
> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
> /dev/sdb1 errs: wr 2702175, rd 2719039, flush 0, corrupt 6, gen 0
> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
> /dev/sdb1 errs: wr 2702175, rd 2719040, flush 0, corrupt 6, gen 0
> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
> /dev/sdb1 errs: wr 2702175, rd 2719041, flush 0, corrupt 6, gen 0
> 
> 
> I have configured a multidrive setup with 2 identical SSDs.
> 
> [root@pc1-desktop ~]# uname -a
> Linux pc1-desktop 5.10.22-2-lts #1 SMP Wed, 10 Mar 2021 10:30:57 +0000
> x86_64 GNU/Linux
> [root@pc1-desktop ~]# btrfs --version
> btrfs-progs v5.11
> [root@pc1-desktop ~]# btrfs fi show
> Label: 'archlinux'? uuid: 78462a70-55ad-4444-9d91-e71e42cce51c
> ??? Total devices 2 FS bytes used 178.93GiB
> ??? devid??? 1 size 236.55GiB used 233.50GiB path /dev/sda1
> ??? devid??? 2 size 238.47GiB used 233.50GiB path /dev/sdb1
> 
> Label: 'backup'? uuid: de094dc0-58b7-4931-b948-4b920495bf94
> ??? Total devices 1 FS bytes used 210.97GiB
> ??? devid??? 1 size 232.89GiB used 228.87GiB path /dev/sdd
> 
> [root@pc1-desktop ~]# btrfs fi df /
> Data, RAID1: total=229.47GiB, used=175.82GiB
> System, RAID1: total=32.00MiB, used=64.00KiB
> Metadata, RAID1: total=4.00GiB, used=3.11GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> Can you please advise how to fix these errors?
> 
> 
> Regards
> Thomas


