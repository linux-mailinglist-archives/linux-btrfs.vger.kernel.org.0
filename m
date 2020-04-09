Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825321A3884
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgDIRA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 13:00:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36572 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgDIRA2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Apr 2020 13:00:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id b1so452123ljp.3
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Apr 2020 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exuvo-se.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=wot/7NqrKtx7v5xi91n4yzTco7S++qN8IF+F+Prj1eQ=;
        b=CqsbpM88ADtj3ClalA4/hycHGnsRSVxE/ax0TsxeEQWEiLlv+LXlHmaYvq9ieBFUI0
         geMIpQAlr5apkmrQGQ1a0bRhdYv0to7fBiActxOyF3CYs6bLhXIP0cCAu3wYeQlDxUuy
         4+DdCJVm8OUUyMYNao1oa81NY1bN5xGGnPxSxdcYDa6hoZ09JfM5RNjl1fJmx4uVGhPs
         NBzbjT63nf621qxP+UghdljXlXd3VNp5YD0cKPh6iyT9j8IHEJ3ZuTHO9dA+ED42nQPL
         UgSlLupdJUUu0NQ5rwx5talnpPGfxMK5MOINFLaUTn3aQLQHdT025p4rd1nH2Wa9RgI7
         x9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=wot/7NqrKtx7v5xi91n4yzTco7S++qN8IF+F+Prj1eQ=;
        b=iJlgfUbbPb4igiLl48vrFZktHFwgpXsp+nY4E0JPFBJEPDcGJf4PGJ1m9h0MtsMa8g
         z1+d6X9oUhhSb9z5Xd6rRc2ynjA3SvlofdiOjQCSgO3UeUpfGVlF4ehZo3rD9uy737Mk
         DSc/GHBBljZ1+KqcIAYs5k7v46uXn+s4n/7nX7CVt2XrJhbFqkrQHqb8TzdEnMgC4/UF
         yj6nD5vjOaB1DDY885wdO7iAKcJcP8YDxpPvUUihNUbqq4cbblFOTb/ugb7pfV5z6hwd
         cYGvgh6MbxNo4nD3GdxdEa6DZbpfpEAcysnO7EeWMq4zAePYuOIzk2ijmoH5e4ZdXH0V
         MV6A==
X-Gm-Message-State: AGi0PubM0S59u4M8fn6TkOCUHtJGMjWvApSenmzeXn7GTE9RasxheSsi
        GEN64wFpUDYs0I+Q/DdyX8QSwXxGd3c=
X-Google-Smtp-Source: APiQypKiWj0aw6I4W/q94WQABpVcdbIP6/jG5pT4AL46lui/YpJA8MeAwWg+kTpGb/0FxVtN1IrRDA==
X-Received: by 2002:a2e:9ac9:: with SMTP id p9mr464458ljj.222.1586451625286;
        Thu, 09 Apr 2020 10:00:25 -0700 (PDT)
Received: from [192.168.1.30] (c-fa9b205c.06-131-73766c1.bbcust.telenor.se. [92.32.155.250])
        by smtp.gmail.com with ESMTPSA id n23sm15621469lji.59.2020.04.09.10.00.24
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:00:24 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Anton Olsson <exuvo@exuvo.se>
Subject: Minor corrupt leaf
Message-ID: <c2adb5eb-e5c1-8377-174c-e2a6e3b4a706@exuvo.se>
Date:   Thu, 9 Apr 2020 19:00:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So i've had a directory for years (modifed date is 2016 and btrfs filesystem was created in 2015-06) that contained 2 unremovable files.
Like ls would list a file but not be able to show any info about it even as root.

Dir a
 broken file
 Dir b
  another broken file

in b :
#ls -l
ls: cannot access '9193E7A71E8820B8D4C0D786AA679FFF2356189D.dat': No such file or directory
total 0
-????????? ? ? ? ?                ? 9193E7A71E8820B8D4C0D786AA679FFF2356189D.dat

rm and every other command i tried just said No such file or directory even though ls could list its name so i just ignored the directory as it is non essential.

From what i remember dmesg never showed any errors last time i tried to remove those files. Last attempt was on 2020-03-06 but on old 2019-autum kernel due to broken wifi driver in newer kernels.
Now i recently updated the kernel to 5.6.0 (own compile based on arch default linux kernel with minor fix for the broken wifi driver). btrfs-progs is v5.4 .

Today i was listing files in my home directory and got a Input/Output error on dir a (which used to work fine, it was the files inside that were problematic) and another directory .gnome2 (no idea if this one contained broken files too, never checked before, but i think it did as the backup shows no files in there which it also does not for the other dir a).

Dmesg shows these lines each access attempt (always exactly the same):
[389277.482811] BTRFS critical (device dm-0): corrupt leaf: root=259 block=24071061798912 slot=167 ino=7742, invalid location key offset:has 9223372036854775808 expect 0
[389277.495923] BTRFS error (device dm-0): block=24071061798912 read time tree block corruption detected
[389277.518900] BTRFS critical (device dm-0): corrupt leaf: root=259 block=24071061798912 slot=167 ino=7742, invalid location key offset:has 9223372036854775808 expect 0
[389277.532118] BTRFS error (device dm-0): block=24071061798912 read time tree block corruption detected

Disk layout is 4 SATA disks of 3TB each with individual full disk luks encryption and then btrfs raid 5 (data) raid 1 (metadata).
I use 3 subvolumes, / and /storage and /home. Both problematic directories are in /home. I have backups for / and /home subvolumes on a separate 2TB ext4 drive. /storage has no backups as i don't have 8TB to spare.

I run a scrub each month and last results were:
UUID:             33a10d7b-819b-4a61-b35c-d47738ab698f
Scrub started:    Wed Apr  1 03:00:03 2020
Status:           finished
Duration:         70:13:46
Total to scrub:   7.73TiB
Rate:             33.37MiB/s
Error summary:    no errors found

No other file seems to have access problems (ran ncdu on / which accesses every file) or read errors (most files are read and checked by torrent program over time as it seeds).

btrfs device stats /
[/dev/mapper/cryptoroota].write_io_errs    0
[/dev/mapper/cryptoroota].read_io_errs     0
[/dev/mapper/cryptoroota].flush_io_errs    0
[/dev/mapper/cryptoroota].corruption_errs  304
[/dev/mapper/cryptoroota].generation_errs  0
[/dev/mapper/cryptorootb].write_io_errs    0
[/dev/mapper/cryptorootb].read_io_errs     0
[/dev/mapper/cryptorootb].flush_io_errs    0
[/dev/mapper/cryptorootb].corruption_errs  426
[/dev/mapper/cryptorootb].generation_errs  0
[/dev/mapper/cryptorootc].write_io_errs    0
[/dev/mapper/cryptorootc].read_io_errs     0
[/dev/mapper/cryptorootc].flush_io_errs    0
[/dev/mapper/cryptorootc].corruption_errs  425
[/dev/mapper/cryptorootc].generation_errs  0
[/dev/mapper/cryptorootd].write_io_errs    0
[/dev/mapper/cryptorootd].read_io_errs     0
[/dev/mapper/cryptorootd].flush_io_errs    0
[/dev/mapper/cryptorootd].corruption_errs  0
[/dev/mapper/cryptorootd].generation_errs  0

I did have some checksum errors a few years back so i think most errors are from that. Data was fine but the checksum was wrong. At least I can't see anything else recent in dmesg relating to btrfs.

Any clues to what might have caused this?
And secondly how do i get rid of that broken leaf? (Assuming only those 2 directories and their contents are affected)

btrfs-progs v5.4
Linux 5.6.0-arch1-1-custom #1 SMP PREEMPT Sat, 04 Apr 2020 23:33:26 +0000 x86_64 GNU/Linux
Kernel compiled with standard Archlinux settings + minor patch for wifi driver (continue even with communication errors)

-- 
Anton 'exuvo' Olsson
  +46732193727
  http://exuvo.se

