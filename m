Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89B137A195
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 10:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhEKITO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 04:19:14 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:59217 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhEKITN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 04:19:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04466169|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.101613-0.00204817-0.896339;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KBcHnF9_1620721085;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KBcHnF9_1620721085)
          by smtp.aliyun-inc.com(10.147.40.200);
          Tue, 11 May 2021 16:18:06 +0800
Date:   Tue, 11 May 2021 16:18:07 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Philipp Fent <fent@in.tum.de>
Subject: Re: Leaf corruption due to csum range
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de>
References: <93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de>
Message-Id: <20210511161806.B601.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hi,

the last 'write time tree block corruption detected' is marked as
memory ECC error.

 From:    chil L1n <devchill1n@gmail.com>
 To:      linux-btrfs@vger.kernel.org
 Date:    Sat, 6 Mar 2021 10:10:11 +0100
 Subject: btrfs error: write time tree block corruption detected

Is this a server with ECC memory?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/05/11

> I encountered a btrfs error on my system. I run Microsoft SQL Server in
> a docker container on a btrfs filesystem on an SSD. When bulk-loading
> some benchmark data, my system reproducibly enters in the following
> failing state:
> 
> [  366.665714] BTRFS critical (device sda): corrupt leaf:
> root=18446744073709551610 block=507544305664 slot=0, csum end range
> (308900515840) goes beyond the start range (308900384768) of the next
> csum item
> [  366.665723] BTRFS info (device sda): leaf 507544305664 gen 18292
> total ptrs 4 free space 3 owner 18446744073709551610
> [  366.665725]  item 0 key (18446744073709551606 128 308891275264)
> itemoff 7259 itemsize 9024
> [  366.665727]  item 1 key (18446744073709551606 128 308900384768)
> itemoff 7067 itemsize 192
> [  366.665728]  item 2 key (18446744073709551606 128 309036716032)
> itemoff 2587 itemsize 4480
> [  366.665730]  item 3 key (18446744073709551606 128 309041303552)
> itemoff 103 itemsize 2484
> [  366.665731] BTRFS error (device sda): block=507544305664 write time
> tree block corruption detected
> [  366.665821] BTRFS: error (device sda) in btrfs_sync_log:3136:
> errno=-5 IO failure
> [  366.665824] BTRFS info (device sda): forced readonly
> 
> Please note the erroring ranges:
> csum end:   308900515840
> Start next: 308900384768
> which is a difference of (1 << 17) == 0b100000000000000000 == 128KB
> To me, this looks suspiciously like an off-by-one error, but I'm not too
> versed in debugging btrfs.
> 
> I reproduced this several times on my machine using the attached
> scripts. The only obvious similarity between the crashes is this 128KB
> csum end / start next. Sometimes a get one corrupt leaf, sometimes many.
> I tried to reproduce it on another machine with an HDD, but didn't
> encounter this error there.
> Can you help me to debug this further?
> 
> # uname -a
> Linux desk 5.12.2-arch1-1 #1 SMP PREEMPT Fri, 07 May 2021 15:36:06 +0000
> x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5.11.1
> # btrfs fi show
> Label: none  uuid: 6733acf5-be40-4fe2-9d6f-819d39e49720
>         Total devices 1 FS bytes used 187.11GiB
>         devid    1 size 931.51GiB used 208.03GiB path /dev/sda
> # btrfs fi df /ssdSpace
> Data, single: total=207.00GiB, used=186.67GiB
> System, single: total=32.00MiB, used=48.00KiB
> Metadata, single: total=1.00GiB, used=450.08MiB
> GlobalReserve, single: total=215.41MiB, used=0.00B


