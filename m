Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D039757140
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 03:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGRBLF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 21:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGRBLE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 21:11:04 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF53EC0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 18:11:02 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4R4gr031Jyz9sWx
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 03:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vereda.tec.br;
        s=MBO0001; t=1689642656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/NHQjsax0mlT78616k3l5JcYOb91nyME5s+H+K/Ct4Y=;
        b=0s2i94nmHorA6x2XaI+6V3b5WhnXc85gImpCH05flMgzn2wVN+2rABchD7SPEL4QTBePXM
        ZsikqTste6piYR1cXhgOPVw6CPAodvrkTuyA+xxX9hBxHfpoyw30VCRyMrVaAWVR4ip2o9
        hhk4nkKr7gAMj0xDp802nJkonf2FlnDgRC2vPoINjasGv/PbS6rKF6t56F4VUjlYV92IAE
        Ar0AOg14x7lUKdLMz7MZaoce29QqxjEq+JhfHKOynL3Iwv0vgUJitaB0ijQ34LFEzWo7fE
        +LYW+K947JutVbGE4c0I971AjvR2Tb0f6YJYoZXj+qL+fTo5mfW4At5S0QWqxA==
Message-ID: <70a7d788-275c-e417-1154-1708879227a5@vereda.tec.br>
Date:   Mon, 17 Jul 2023 22:10:47 -0300
MIME-Version: 1.0
From:   Fernanda <fernanda@vereda.tec.br>
Subject: Properly restore from backup after checksum error
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone,

I have a volume in a raid0 data profile, which had a failing device (devid 1) this week. I already `btrfs replace`d the device soon after confirming the bad news on SMART. Now I have some corrupted data (estimate half dozen GiBs from dmesg filenames) which I can recover from backup (daily borgmatic routine). It seems that any attempt to read a corrupted file raises I/O Error, so I feel more or less convinced that the backup is clean.

Somehow, I still need to ask: Is it possible that the corrupted data got inside the backup?

And more practically: is there any way to use the checksum to validate the backed up data?

I am afraid that just doing `cp` from the backup to overwrite the files isn't the proper way to go. I don't want to be that person who destroyed a whole array because of a silly mistake. Could you please tell me if there is a better thing to do?

Thank you for your time and attention!

`uname -a`:
Linux <hostname> 6.1.0-10-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.37-1 (2023-07-03) x86_64 GNU/Linux

`btrfs --version`:
btrfs-progs v6.2

`dmesg | grep -c BTRFS` return 176 lines

`dmesg` is full of error/warning messages like below:
[  438.447987] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 0, rd 0, flush 0, corrupt 165, gen 0
[  438.447991] BTRFS error (device sda2): unable to fixup (regular) error at logical 39534268416 on dev /dev/sda2
[  438.447992] BTRFS warning (device sda2): checksum error at logical 39534071808 on dev /dev/sda2, physical 13914083328, root 259, inode 1755, offset 42807296, length 4096, links 1 (path: channels/AtilaIamarino/z/Aprendendo a aprender com videogames [zUkQwd7SWf8].webm)


`btrfs scrub start -Bd /srv/media`:
ERROR: there are uncorrectable errors

Scrub device /dev/sda2 (id 1) done
Scrub started:    Mon Jul 17 21:37:35 2023
Status:           finished
Duration:         1:12:23
Total to scrub:   590.04GiB
Rate:             134.67MiB/s
Error summary:    csum=11198
   Corrected:      0
   Uncorrectable:  11198
   Unverified:     0

Scrub device /dev/sdc2 (id 2) done
Scrub started:    Mon Jul 17 21:37:35 2023
Status:           finished
Duration:         1:48:54
Total to scrub:   590.04GiB
Rate:             89.51MiB/s
Error summary:    no errors found

Scrub device /dev/sdd2 (id 3) done
Scrub started:    Mon Jul 17 21:37:35 2023
Status:           finished
Duration:         1:53:42
Total to scrub:   590.04GiB
Rate:             85.73MiB/s
Error summary:    no errors found


`btrfs check -p --check-data-csum`:
Opening filesystem to check...
Checking filesystem on /dev/sde2
UUID: 8a005025-b8c4-43c1-99db-2f6d4ba69458
[1/7] checking root items                      (0:00:32 elapsed, 1115806 items checked)
[2/7] checking extents                         (0:03:35 elapsed, 198335 items checked)
[3/7] checking free space tree                 (0:00:00 elapsed, 593 items checked)
[4/7] checking fs roots                        (0:00:27 elapsed, 66349 items checked)
[5/7] checking csums against data              (1:53:53 elapsed, 548297 items checked)
ERROR: errors found in csum tree
[6/7] checking root refs                       (0:00:00 elapsed, 7 items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 1833303019520 bytes used, error(s) found
total csum bytes: 1787161828
total tree bytes: 3249307648
total fs tree bytes: 1089568768
total extent tree bytes: 88358912
btree space waste bytes: 444497614
file data blocks allocated: 1830053711872
  referenced 1866543820800


`btrfs fi show`:
Label: 'srv_pool'  uuid: 8a005025-b8c4-43c1-99db-2f6d4ba69458
	Total devices 3 FS bytes used 1.67TiB
	devid    1 size 921.51GiB used 590.04GiB path /dev/sde2
	devid    2 size 921.51GiB used 590.04GiB path /dev/sdc2
	devid    3 size 921.51GiB used 590.04GiB path /dev/sdd2


`btrfs fi df /srv/media`:
Data, RAID0: total=1.72TiB, used=1.66TiB
System, RAID1C3: total=40.00MiB, used=128.00KiB
Metadata, RAID1C3: total=4.00GiB, used=3.03GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

