Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5FC12FE28
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 21:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgACU7z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 15:59:55 -0500
Received: from naboo.endor.pl ([91.194.229.149]:42289 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgACU7y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 15:59:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 84F141A1877;
        Fri,  3 Jan 2020 21:59:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l0__-V-Y_GSR; Fri,  3 Jan 2020 21:59:49 +0100 (CET)
Received: from [192.168.1.16] (aahl46.neoplus.adsl.tpnet.pl [83.4.193.46])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 11FC51A1875;
        Fri,  3 Jan 2020 21:59:48 +0100 (CET)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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
 <7c82851a-21cf-2a66-8d1c-42d57ca0538f@dubiel.pl>
 <CAJCQCtSpFyfHAWVth5PuvjJtiHPfN52WzspOdsvLrJxMdbcirw@mail.gmail.com>
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <3e13e4ad-0143-2a92-503b-7bf2fae9a527@dubiel.pl>
Date:   Fri, 3 Jan 2020 21:59:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSpFyfHAWVth5PuvjJtiHPfN52WzspOdsvLrJxMdbcirw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



W dniu 03.01.2020 o 20:02, Chris Murphy pisze:
 > On Fri, Jan 3, 2020 at 7:39 AM Leszek Dubiel <leszek@dubiel.pl> wrote:
 >>
 >> ** number of files by given size
 >>
 >> root@wawel:/mnt/root/orion# cat disk_usage | perl -MData::Dumper -e
 >> '$Data::Dumper::Sortkeys = 1; while (<>) { chomp; my ($byt, $nam) =
 >> split /\t/, $_, -1; if (index("$las/", $nam) == 0) { $dir++; } else {
 >> $filtot++; for $p (1 .. 99) { if ($byt < 10 ** $p) { $fil{"num of files
 >> size <10^$p"}++; last; } } }; $las = $nam; }; print "\ndirectories:
 >> $dir\ntotal num of files: $filtot\n", "\nnumber of files grouped by
 >> size: \n", Dumper(\%fil) '
 >>
 >> directories: 1314246
 >> total num of files: 10123960
 >>
 >> number of files grouped by size:
 >> $VAR1 = {
 >>            'num of files size <10^1' => 3325886,
 >>            'num of files size <10^2' => 3709276,
 >>            'num of files size <10^3' => 789852,
 >>            'num of files size <10^4' => 1085927,
 >>            'num of files size <10^5' => 650571,
 >>            'num of files size <10^6' => 438717,
 >>            'num of files size <10^7' => 116757,
 >>            'num of files size <10^8' => 6638,
 >>            'num of files size <10^9' => 323
 >>            'num of files size <10^10' => 13,
 >
 > Is that really ~7.8 million files at or less than 1KiB?? (totalling
 > the first three)

Yes. This is Workflow Management system in my company (bathroom mirorr 
manufacturer).

System was made in 2004. Back then ReisierFs was great because it had 
"tail packing" and put small pieces of data together with metadata, so 
disks could read many pieces of data during one read request. Other 
systems were not any close to ReiserFs when it came to speed with lots 
of small files. That's why I'm testing BTFS for a few years now.


 > Compression may not do much with such small files, and also I'm not
 > sure which algorithm would do the best job. They all probably want a
 > lot more than 1KiB to become efficient.
 >
 > But nodesize 64KiB might be a big deal...worth testing.

Yes -- I will have to read about nodesize.
Thank you for hint.


Current data:

root@wawel:~# btrfs inspect dump-super /dev/sdb2
superblock: bytenr=65536, device=/dev/sdb2
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x0bd7280d [match]
bytenr            65536
flags            0x1
             ( WRITTEN )
magic            _BHRfS_M [match]
fsid            44803366-3981-4ebb-853b-6c991380c8a6
metadata_uuid        44803366-3981-4ebb-853b-6c991380c8a6
label
generation        553943
root            17155128295424
sys_array_size        129
chunk_root_generation    553648
root_level        1
chunk_root        10136287444992
chunk_root_level    1
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        23967879376896
bytes_used        5844982415360
sectorsize        4096
nodesize        16384 ---------------<<<
leafsize (deprecated)        16384
stripesize        4096
root_dir        6
num_devices        3
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x163
             ( MIXED_BACKREF |
               DEFAULT_SUBVOL |
               BIG_METADATA |
               EXTENDED_IREF |
               SKINNY_METADATA )
cache_generation    553943
uuid_tree_generation    594
dev_item.uuid        5f74e436-f8f9-43ba-95fc-44cdb2bc1838
dev_item.fsid        44803366-3981-4ebb-853b-6c991380c8a6 [match]
dev_item.type        0
dev_item.total_bytes    5992192409600
dev_item.bytes_used    2946381119488
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        3
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0





