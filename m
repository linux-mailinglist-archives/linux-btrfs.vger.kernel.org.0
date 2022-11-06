Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0561DFC4
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Nov 2022 01:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKFAQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Nov 2022 20:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKFAQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Nov 2022 20:16:29 -0400
Received: from out20-159.mail.aliyun.com (out20-159.mail.aliyun.com [115.124.20.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB7DF72
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Nov 2022 17:16:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05313938|-1;BR=01201311R811S73rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0262732-0.0134768-0.96025;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Q0Ko1q-_1667693783;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Q0Ko1q-_1667693783)
          by smtp.aliyun-inc.com;
          Sun, 06 Nov 2022 08:16:23 +0800
Date:   Sun, 06 Nov 2022 08:16:24 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: newer /bin/cp have worse btrfs fiemap performance.
In-Reply-To: <20221106073028.71F9.409509F4@e16-tech.com>
References: <20221106073028.71F9.409509F4@e16-tech.com>
Message-Id: <20221106081623.7A83.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a fix.

> Hi,
> 
> newer /bin/cp have worse btrfs fiemap performance.
> 
> btrfs version: misc-next 750de989d367(the lastest of 2022/11/05)
> /bin/cp versions(run them on the same server)
>     8.22 copy from centos/7.9

this
>     8.30 rocklinux/9.0
should be
	8.30 rocklinux/8

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/11/06

>     9.1 local build, https://kojipkgs.fedoraproject.org/packages/coreutils/9.1/8.eln121/
> 
> test case:
>     /bin/cp /mnt/test/file1 /dev/null
>     /mnt/test/file1 is created by https://lore.kernel.org/linux-btrfs/YuwUw2JLKtIa9X+S@localhost.localdomain/T/#T
>     and /mnt/test/file1 is 256M.
> 
>     file is not cached: 'echo 3 >/proc/sys/vm/drop_caches'
>     file is cached: run '/bin/cp /mnt/test/file1 /dev/null' again.
> 
> performance result(/bin/cp /mnt/test/file1 /dev/null):
> /bin/cp 9.1
>     file is not cached: 94.85(1:34.85)
>     file is cached: 1982.43(33:02.43)
> /bin/cp 8.30
>     file is not cached: 1.48(0:01.48)
>     file is cached:14.07(0:14.07)
> /bin/cp 8.22
>     file is not cached: 0.53(0:00.53)
>     file is cached: 0.10(0:00.10)
> 
> as a compare, we test it on xfs too.
> 1) /bin/cp 8.22/8.30/9.1 have almost same performance.
> 2) the case(the file is cached) is faster than the case(the file is not
> cached).
> 
> strace show that the logical of /bin/cp 8.30 and 9.1 are different.
> /bin/cp 8.30
>     lseek(3, 198737920, SEEK_SET)           = 198737920
>     write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     lseek(3, 198746112, SEEK_SET)           = 198746112
>     write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
> 
> /bin/cp 9.1
>     lseek(3, 880640, SEEK_DATA)             = 884736
>     lseek(3, 884736, SEEK_HOLE)             = 888832
>     lseek(3, 884736, SEEK_SET)              = 884736
>     write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     lseek(3, 888832, SEEK_DATA)             = 892928
>     lseek(3, 892928, SEEK_HOLE)             = 897024
>     lseek(3, 892928, SEEK_SET)              = 892928
>     write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
> 
> Do we need some job in btrfs to support /bin/cp 9.1 well,
> or /bin/cp 9.1 is just wrong?
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/11/06
> 


