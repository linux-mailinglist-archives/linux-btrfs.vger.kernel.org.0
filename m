Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98A4271EE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 11:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIUJ30 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 21 Sep 2020 05:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIUJ30 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 05:29:26 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37A2C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 02:29:25 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 7B67415491A
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 11:29:22 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: external harddisk: bogus corrupt leaf error?
Date:   Mon, 21 Sep 2020 11:29:21 +0200
Message-ID: <1978673.BsW9qxMyvF@merkaba>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I have an external 500 GB harddisk with BTRFS. On mounting it the kernel 
(5.9-rc5, vanilla, self compiled) reports:

[282409.344208] BTRFS info (device sdc1): enabling auto defrag
[282409.344222] BTRFS info (device sdc1): use zstd compression, level 3
[282409.344225] BTRFS info (device sdc1): disk space caching is enabled
[282409.465837] BTRFS critical (device sdc1): corrupt leaf: root=1 
block=906756096 slot=204, invalid root item size, have 239 expect 439

Note: It has used LZO compression before, but I switched mount option to 
zstd meanwhile.

However, btrfs-progds 5.7 gives:

% btrfs check /dev/sdc1
Opening filesystem to check...
Checking filesystem on /dev/sdc1
UUID: […]
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 249031409664 bytes used, no error found
total csum bytes: 242738928
total tree bytes: 352387072
total fs tree bytes: 67747840
total extent tree bytes: 14565376
btree space waste bytes: 37691414
file data blocks allocated: 1067158315008
 referenced 247077785600


Is this kernel message in error? Or does 'btrfs check' not check for 
this error yet?

Here some more information:

% btrfs filesystem df /mnt/[…]
Data, single: total=444.67GiB, used=231.60GiB
System, DUP: total=64.00MiB, used=80.00KiB
System, single: total=4.00MiB, used=0.00B
Metadata, DUP: total=3.00GiB, used=335.98MiB
Metadata, single: total=8.00MiB, used=0.00B
GlobalReserve, single: total=271.09MiB, used=0.00B
WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
WARNING:   Metadata: single, dup
WARNING:   System: single, dup

Ah, there is something old I can clean up, it seems:


% merkaba:~> btrfs filesystem usage -T /mnt/amazon
Overall:
    Device size:                 465.76GiB
    Device allocated:            450.81GiB
    Device unallocated:           14.95GiB
    Device missing:                  0.00B
    Used:                        232.26GiB
    Free (estimated):            228.02GiB      (min: 220.55GiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              271.09MiB      (used: 0.00B)
    Multiple profiles:                 yes      (metadata, system)

             Data      Metadata Metadata  System  System               
Id Path      single    single   DUP       single  DUP       Unallocated
-- --------- --------- -------- --------- ------- --------- -----------
 1 /dev/sdc1 444.67GiB  8.00MiB   6.00GiB 4.00MiB 128.00MiB    14.95GiB
-- --------- --------- -------- --------- ------- --------- -----------
   Total     444.67GiB  8.00MiB   3.00GiB 4.00MiB  64.00MiB    14.95GiB
   Used      231.60GiB    0.00B 335.98MiB   0.00B  80.00KiB  

Will run a scrub next to see whether all data can be read.

Device stats are okay:

% btrfs device stats /mnt/amazon
[/dev/sdc1].write_io_errs    0
[/dev/sdc1].read_io_errs     0
[/dev/sdc1].flush_io_errs    0
[/dev/sdc1].corruption_errs  0
[/dev/sdc1].generation_errs  0

Device reports SMART status as: passed.

There are some "Error: ICRC, ABRT 24 sectors at LBA" like errors in 
SMART error log, but they are from a very early time about 290 to 310 
hours of disk power-on lifetime. I believe this may have been me 
disconnecting the device while it was still being written to or 
something, but I will run a long SMART test as well.

Best,
-- 
Martin


