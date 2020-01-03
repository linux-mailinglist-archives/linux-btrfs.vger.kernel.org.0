Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFCAA12F945
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgACOjm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 09:39:42 -0500
Received: from naboo.endor.pl ([91.194.229.149]:55227 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbgACOjm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 09:39:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 326F61A17BA
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2020 15:39:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6dCu2teXi0tU for <linux-btrfs@vger.kernel.org>;
        Fri,  3 Jan 2020 15:39:40 +0100 (CET)
Received: from [192.168.1.16] (aahl46.neoplus.adsl.tpnet.pl [83.4.193.46])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 04C891A164B
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2020 15:39:39 +0100 (CET)
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
 <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org>
 <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl>
 <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
Message-ID: <7c82851a-21cf-2a66-8d1c-42d57ca0538f@dubiel.pl>
Date:   Fri, 3 Jan 2020 15:39:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I have made some measurements in case someone has the same profile on 
his server.




=============
=== BTRFS ===

This is the same server "wawel" that was discussed above on
slow "btrfs delete" and "btrfs balance".

I must admit that BTRFS is much faster these days than ReiserFs.
See ReiserFs below.



** 51 minutes to list 11 million files:

root@wawel:/mnt/root/orion# time find > list_of_files
real    51m14,611s
user    0m30,487s
sys     2m23,520s

root@wawel:/mnt/root/orion# wc -l list_of_files
11439162 list_of_files



** 86 min to check size of files

root@wawel:/mnt/root/orion# time du -abx > disk_usage
real    86m42,328s
user    0m47,225s
sys     7m13,320s

root@wawel:/mnt/root/orion# wc -l disk_usage
11438206 disk_usage



** 45 minutes to read half million files, 50GB of data

root@wawel:/mnt/root/orion# egrep 'root/Omega/Domains/Zakupy' disk_usage 
| wc -l
476499

root@wawel:/mnt/root/orion# egrep 'root/Omega/Domains/Zakupy$' disk_usage
49154713130    ./root/Omega/Domains/Zakupy

root@wawel:/mnt/root/orion# time find root/Omega/Domains/Zakupy/ -type f 
-print0 | xargs -0r wc > word_count
real    45m11,398s
user    32m22,395s
sys     0m22,657s



** 21 min to copy 50Gb

root@wawel:/mnt/root/orion# time cp -a root/Omega/Domains/Zakupy/ tempcopy
real    21m36,030s
user    0m9,553s
sys     2m47,038s


** remove is very fast

root@wawel:/mnt/root/orion# time rm -r tempcopy
real    0m39,952s
user    0m0,359s
sys     0m9,985s



** number of files by given size

root@wawel:/mnt/root/orion# cat disk_usage | perl -MData::Dumper -e 
'$Data::Dumper::Sortkeys = 1; while (<>) { chomp; my ($byt, $nam) = 
split /\t/, $_, -1; if (index("$las/", $nam) == 0) { $dir++; } else { 
$filtot++; for $p (1 .. 99) { if ($byt < 10 ** $p) { $fil{"num of files 
size <10^$p"}++; last; } } }; $las = $nam; }; print "\ndirectories: 
$dir\ntotal num of files: $filtot\n", "\nnumber of files grouped by 
size: \n", Dumper(\%fil) '

directories: 1314246
total num of files: 10123960

number of files grouped by size:
$VAR1 = {
           'num of files size <10^1' => 3325886,
           'num of files size <10^2' => 3709276,
           'num of files size <10^3' => 789852,
           'num of files size <10^4' => 1085927,
           'num of files size <10^5' => 650571,
           'num of files size <10^6' => 438717,
           'num of files size <10^7' => 116757,
           'num of files size <10^8' => 6638,
           'num of files size <10^9' => 323
           'num of files size <10^10' => 13,
         };



** disk speed

root@wawel:/mnt/root/orion# hdparm -t /dev/sda
/dev/sda:
  Timing buffered disk reads: 680 MB in  3.01 seconds = 226.14 MB/sec





================
=== REISERFS ===

ReiserFs is much slower:

root@gamma:/mnt/sdb1/orion2# time find > list_of_files
real    111m49,529s
user    0m28,665s
sys     1m3,576s

root@gamma:/mnt/sdb1/orion2# wc -l list_of_files
11329332 list_of_files

root@gamma:/mnt/sdb1/orion2# time du -abx > disk_usage
real    198m43,813s
user    0m53,501s
sys     3m38,447s

root@gamma:/mnt/sdb1/orion2# hdparm -t /dev/sdb
/dev/sdb:
  Timing buffered disk reads: 534 MB in  3.00 seconds = 177.77 MB/sec


