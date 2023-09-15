Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39AD7A1C88
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 12:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjIOKmI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjIOKmH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 06:42:07 -0400
Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [89.1.8.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBD6139
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 03:41:53 -0700 (PDT)
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id 0813C12434
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 12:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=netcologne.de;
        s=nc1116a; t=1694773917;
        bh=iAT7SYwfB0XBVkWWtjo9MwLH7njv2ZjswxfuTWqq7AU=;
        h=From:Date:Message-ID:Subject:To:From;
        b=WXjsivtBm21mj4hdbSVGt8Voj7gCAL4r6SYuekxd2hjM72v5uPgc39vvnzjTOTt9d
         4penHnh3jFc88kSgZgi3Jmpa8y/88ZiSXCmHOD2laWGAhW0lrsADd9bBznVJ/+8+3Z
         wve6zo6L2XrUQOuz22GdhCjCkqnBuiPsjwmTZK8dONPntF4Sw6lk+C9FCtbyk9Ad/n
         oH7tHPjxj13NyYIpw9jF+ko+EVspM43mJJWAv8wIiTdfteSqSCYwys6ieW/1THpnkC
         f/R50A5CLs0fe8pxVGrA6tLA0UPJjvlAZm1RU+beNBF8EyTi+Hunx4wsXrJR62omuc
         x+u919N9MKkTg==
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA id BC71C11DCA
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 12:31:56 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-57767b2058cso1237150a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 03:31:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw/Su0LFaDuTenDp+hdE7P7f5EXG4Svr5UnESWtT2NmofYsmq0G
        v8R6rcPzq1EdZmLm/cYby9hewNZ/8dxslO9G848=
X-Google-Smtp-Source: AGHT+IG3tb8tMe/4uh36w8vrzIBMTxaqEWzW/hZ3RQxkVISW3JJLxDT5PXktheSNKXDTx9oVsRyj44hRrRFHncIjFrQ=
X-Received: by 2002:a17:90a:9f82:b0:267:c0cb:e462 with SMTP id
 o2-20020a17090a9f8200b00267c0cbe462mr869816pjp.48.1694773915265; Fri, 15 Sep
 2023 03:31:55 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Malte Schumacher <s.schumacher@netcologne.de>
Date:   Fri, 15 Sep 2023 12:31:44 +0200
X-Gmail-Original-Message-ID: <CAA3ktqmgtdDGsubOiCZR+vS=5J3Wf2Hu8vi-t1z48zZB18mC0A@mail.gmail.com>
Message-ID: <CAA3ktqmgtdDGsubOiCZR+vS=5J3Wf2Hu8vi-t1z48zZB18mC0A@mail.gmail.com>
Subject: Massive filesystem errors - possible new HDD
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-NetCologne-Spam: L
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BC71C11DCA
X-Spamd-Bar: ----
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have some serious problems with my btrfs-filesystem. It started with
a smart error and "btrfs fi show" reporting the drive as missing about
once every two weeks. The error went away after a reboot.

Device: /dev/sda [SAT], unable to open ATA device
Device info: WDC  WUH722020ALE6L4, S/N:2LG7DJJK,
WWN:5-000cca-2b3c35da5, FW:PQGNW108, 20.0 TB

This is the latest hard disk I bought about four weeks ago.Half an
hour ago I got the error message again, switched the monitor input to
my file server and watched it boot. Booting  produced some serious
btrfs errors, but would finish. The filesystem is mounted and I can
create files on it, but dmesg shows massive errors. I have pasted a
selection of the errors after my message.

Is this - in your opinion - a logical error of the filesystem or
should I immediately exchange the new drive? Should I try to scrub my
data? I have a backup but it's rather recent, meaning it could include
corrupted files because I also bought a new NAS in addition to the new
drive for the fileserver since I urgently needed space on both. Note:
The former /dev/sda now is /dev/sdb after the reboot.

Thanks in advance and yours faithfully
Stefan Malte Schumacher

Errors from journalctl. Repeat probably from the point the drive was
not recognized any more.
Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
errs: wr 176296937, rd 88151246, flush 477, corrupt 0, gen 0
Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
errs: wr 176296938, rd 88151246, flush 477, corrupt 0, gen 0
Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
errs: wr 176296938, rd 88151247, flush 477, corrupt 0, gen 0
Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
errs: wr 176296938, rd 88151248, flush 477, corrupt 0, gen 0
Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
errs: wr 176296939, rd 88151248, flush 477, corrupt 0, gen 0
Sep 15 11:49:59 mars kernel: scrub_handle_errored_block: 16462
callbacks suppressed
Sep 15 11:49:59 mars kernel: BTRFS warning (device sdc): i/o error at
logical 104647456002048 on dev /dev/sda, physical 3193421500416, root
5, inode 7253233, offset 67033587712, length 4096, links 1 (path:
Film>
Sep 15 11:49:59 mars kernel: BTRFS warning (device sdc): i/o error at
logical 104647456100352 on dev /dev/sda, physical 3193421598720, root
5, inode 7253233, offset 67033686016, length 4096, links 1 (path:
Film>
Sep

dmesg after reboot:
[  128.675658] BTRFS warning (device sdc): super block error on device
/dev/sdb, physical 65536
[  128.675674] BTRFS error (device sdc): bdev /dev/sdb errs: wr
177062143, rd 88533832, flush 479, corrupt 1, gen 0
[  128.683734] BTRFS warning (device sdc): super block error on device
/dev/sdb, physical 67108864
[  128.684228] BTRFS error (device sdc): bdev /dev/sdb errs: wr
177062143, rd 88533832, flush 479, corrupt 2, gen 0
[  128.687400] BTRFS warning (device sdc): super block error on device
/dev/sdb, physical 274877906944
[  128.687956] BTRFS error (device sdc): bdev /dev/sdb errs: wr
177062143, rd 88533832, flush 479, corrupt 3, gen 0
[  128.688552] BTRFS info (device sdc): scrub: started on devid 8
[  128.688561] BTRFS info (device sdc): scrub: started on devid 9
[  128.688596] BTRFS info (device sdc): scrub: started on devid 10
[  128.709283] BTRFS info (device sdc): scrub: started on devid 11
[  128.709320] BTRFS info (device sdc): scrub: started on devid 12
[  128.720429] BTRFS warning (device sdc): super block error on device
/dev/sdc, physical 274877906944
[  128.721452] BTRFS error (device sdc): bdev /dev/sdc errs: wr 0, rd
0, flush 0, corrupt 1, gen 0
[  128.723426] BTRFS warning (device sdc): super block error on device
/dev/sdc, physical 67108864
[  128.724651] BTRFS error (device sdc): bdev /dev/sdc errs: wr 0, rd
0, flush 0, corrupt 2, gen 0
[  160.484366] BTRFS error (device sdc): space cache generation
(1395658) does not match inode (1395902)
[  209.258959] BTRFS warning (device sdc): failed to load free space
cache for block group 49783599267840, rebuilding it now
[  210.267125] BTRFS error (device sdc): space cache generation
(1395658) does not match inode (1395664)
[  210.272770] BTRFS warning (device sdc): failed to load free space
cache for block group 53557835333632, rebuilding it now
[  210.333332] BTRFS warning (device sdc): failed to load free space
cache for block group 53599711264768, rebuilding it now
[  210.682350] BTRFS warning (device sdc): failed to load free space
cache for block group 53763993763840, rebuilding it now
[  210.693379] BTRFS warning (device sdc): failed to load free space
cache for block group 53766141247488, rebuilding it now
[  211.035247] BTRFS warning (device sdc): failed to load free space
cache for block group 53904653942784, rebuilding it now
[  212.349634] BTRFS warning (device sdc): failed to load free space
cache for block group 54425418727424, rebuilding it now
[  212.760877] io_ctl_check_generation: 5 callbacks suppressed
[  212.760887] BTRFS error (device sdc): space cache generation
(1395658) does not match inode (1396097)
[  212.768138] BTRFS warning (device sdc): failed to load free space
cache for block group 54615471030272, rebuilding it now
