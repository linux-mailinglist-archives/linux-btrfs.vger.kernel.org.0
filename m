Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8789512ACC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 15:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLZOFg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 09:05:36 -0500
Received: from naboo.endor.pl ([91.194.229.149]:47112 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfLZOFf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 09:05:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id B5C191A10BA;
        Thu, 26 Dec 2019 15:05:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AA2CQqA-Rp3R; Thu, 26 Dec 2019 15:05:20 +0100 (CET)
Received: from [192.168.1.16] (aaee101.neoplus.adsl.tpnet.pl [83.4.108.101])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 5618E1A1047;
        Thu, 26 Dec 2019 15:05:20 +0100 (CET)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Remi Gauvin <remi@georgianit.com>, linux-btrfs@vger.kernel.org
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
Date:   Thu, 26 Dec 2019 15:05:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Did you check dmesg to see if you're getting a whole pile of I/O errors
> on the failing disk?  It might be necessary to remove it (physically)
> and finish replacing it with a degraded array.   (I would not jump to
> trying that, however, as there are additional risks if your metadata is
> Raid6 as well, and you have any write hole corruption.)

I didn't use Raid6, but Raid0.


Yes I have chcecked dmesg in first place (see original mail).

Btrfs no error logged.

root@wawel:~# btrfs dev stat /
[/dev/sda2].write_io_errs    0
[/dev/sda2].read_io_errs     0
[/dev/sda2].flush_io_errs    0
[/dev/sda2].corruption_errs  0
[/dev/sda2].generation_errs  0
[/dev/sdb2].write_io_errs    0
[/dev/sdb2].read_io_errs     0
[/dev/sdb2].flush_io_errs    0
[/dev/sdb2].corruption_errs  0
[/dev/sdb2].generation_errs  0
[/dev/sdc2].write_io_errs    0
[/dev/sdc2].read_io_errs     0
[/dev/sdc2].flush_io_errs    0
[/dev/sdc2].corruption_errs  0
[/dev/sdc2].generation_errs  0



But currently it looks like this:



Dec 22 17:44:37 wawel kernel: [  179.075180] BTRFS warning (device 
sda2): block group 5414977536000 has wrong amount of free space
Dec 22 17:44:37 wawel kernel: [  179.075185] BTRFS warning (device 
sda2): failed to load free space cache for block group 5414977536000, 
rebuilding it now
Dec 22 18:59:17 wawel kernel: [ 4659.089590] BTRFS info (device sda2): 
relocating block group 8562114822144 flags metadata|raid1
Dec 22 19:01:44 wawel kernel: [ 4805.180779] BTRFS info (device sda2): 
relocating block group 8562114822144 flags metadata|raid1
Dec 22 19:02:14 wawel kernel: [ 4835.167239] BTRFS info (device sda2): 
found 12211 extents
Dec 22 19:02:14 wawel kernel: [ 4835.641938] BTRFS info (device sda2): 
relocating block group 8555672371200 flags data
Dec 22 19:02:24 wawel kernel: [ 4845.378907] BTRFS info (device sda2): 
found 10 extents
Dec 22 19:02:26 wawel kernel: [ 4847.909681] BTRFS info (device sda2): 
found 10 extents
Dec 22 19:02:27 wawel kernel: [ 4848.442186] BTRFS info (device sda2): 
relocating block group 8552451145728 flags data
Dec 22 19:02:27 wawel kernel: [ 4848.639837] BTRFS warning (device 
sda2): block group 6255717384192 has wrong amount of free space
Dec 22 19:02:27 wawel kernel: [ 4848.639841] BTRFS warning (device 
sda2): failed to load free space cache for block group 6255717384192, 
rebuilding it now
Dec 22 19:02:37 wawel kernel: [ 4858.473525] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:03:03 wawel kernel: [ 4884.425697] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:03:16 wawel kernel: [ 4898.034082] BTRFS info (device sda2): 
relocating block group 8549229920256 flags data
Dec 22 19:03:40 wawel kernel: [ 4921.855827] BTRFS info (device sda2): 
found 12 extents
Dec 22 19:03:49 wawel kernel: [ 4931.023551] BTRFS info (device sda2): 
found 12 extents
Dec 22 19:03:50 wawel kernel: [ 4931.603340] BTRFS info (device sda2): 
relocating block group 8546008694784 flags data
Dec 22 19:04:05 wawel kernel: [ 4946.520618] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:04:14 wawel kernel: [ 4955.158390] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:04:15 wawel kernel: [ 4956.492239] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:04:16 wawel kernel: [ 4957.213730] BTRFS info (device sda2): 
relocating block group 8542787469312 flags data
Dec 22 19:04:32 wawel kernel: [ 4973.410098] BTRFS info (device sda2): 
found 12 extents
Dec 22 19:04:35 wawel kernel: [ 4976.628967] BTRFS info (device sda2): 
found 12 extents
Dec 22 19:04:35 wawel kernel: [ 4977.062360] BTRFS info (device sda2): 
relocating block group 8539566243840 flags data
Dec 22 19:04:46 wawel kernel: [ 4987.604348] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:04:49 wawel kernel: [ 4991.071047] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:04:50 wawel kernel: [ 4991.867354] BTRFS info (device sda2): 
relocating block group 8536345018368 flags data
Dec 22 19:05:02 wawel kernel: [ 5003.539073] BTRFS info (device sda2): 
found 10 extents
Dec 22 19:05:06 wawel kernel: [ 5007.309308] BTRFS info (device sda2): 
found 10 extents
Dec 22 19:05:06 wawel kernel: [ 5007.938822] BTRFS info (device sda2): 
relocating block group 8533123792896 flags data
Dec 22 19:05:19 wawel kernel: [ 5020.576346] BTRFS info (device sda2): 
found 11 extents
Dec 22 19:05:32 wawel kernel: [ 5033.787681] BTRFS info (device sda2): 
found 11 extents
Dec 22 19:05:45 wawel kernel: [ 5046.894372] BTRFS info (device sda2): 
relocating block group 8529902567424 flags data
Dec 22 19:06:08 wawel kernel: [ 5069.249286] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:06:18 wawel kernel: [ 5079.974289] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:06:19 wawel kernel: [ 5080.609198] BTRFS info (device sda2): 
relocating block group 8526681341952 flags data
Dec 22 19:06:30 wawel kernel: [ 5091.408195] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:06:34 wawel kernel: [ 5095.494893] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:06:34 wawel kernel: [ 5095.974846] BTRFS info (device sda2): 
relocating block group 8523460116480 flags data
Dec 22 19:06:48 wawel kernel: [ 5109.948486] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:06:50 wawel kernel: [ 5111.872561] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:06:51 wawel kernel: [ 5112.262733] BTRFS info (device sda2): 
relocating block group 8520238891008 flags data
Dec 22 19:07:01 wawel kernel: [ 5122.295835] BTRFS info (device sda2): 
found 11 extents
Dec 22 19:07:03 wawel kernel: [ 5124.152445] BTRFS info (device sda2): 
found 11 extents
Dec 22 19:07:03 wawel kernel: [ 5124.603091] BTRFS info (device sda2): 
relocating block group 8517017665536 flags data
Dec 22 19:07:14 wawel kernel: [ 5135.149621] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:07:15 wawel kernel: [ 5136.612473] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:07:15 wawel kernel: [ 5137.042461] BTRFS info (device sda2): 
relocating block group 8513796440064 flags data
Dec 22 19:07:26 wawel kernel: [ 5147.805243] BTRFS info (device sda2): 
found 11 extents
Dec 22 19:07:30 wawel kernel: [ 5151.553394] BTRFS info (device sda2): 
found 11 extents
Dec 22 19:07:30 wawel kernel: [ 5152.056795] BTRFS info (device sda2): 
relocating block group 8510575214592 flags data
Dec 22 19:07:41 wawel kernel: [ 5162.747546] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:07:44 wawel kernel: [ 5165.848208] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:07:45 wawel kernel: [ 5166.412946] BTRFS info (device sda2): 
relocating block group 8507353989120 flags data
Dec 22 19:07:55 wawel kernel: [ 5176.370942] BTRFS info (device sda2): 
found 12 extents
Dec 22 19:07:56 wawel kernel: [ 5177.729094] BTRFS info (device sda2): 
found 12 extents
Dec 22 19:07:57 wawel kernel: [ 5178.312743] BTRFS info (device sda2): 
relocating block group 8504132763648 flags data
Dec 22 19:08:03 wawel kernel: [ 5184.392945] BTRFS info (device sda2): 
found 4 extents
Dec 22 19:08:04 wawel kernel: [ 5185.610488] BTRFS info (device sda2): 
found 4 extents
Dec 22 19:08:04 wawel kernel: [ 5186.076337] BTRFS info (device sda2): 
relocating block group 8500911538176 flags data
Dec 22 19:08:15 wawel kernel: [ 5196.915114] BTRFS info (device sda2): 
found 14 extents
Dec 22 19:08:38 wawel kernel: [ 5219.384163] BTRFS info (device sda2): 
found 14 extents
Dec 22 19:08:53 wawel kernel: [ 5234.746250] BTRFS info (device sda2): 
relocating block group 8497690312704 flags data
Dec 22 19:09:10 wawel kernel: [ 5252.065078] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:09:20 wawel kernel: [ 5261.174092] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:09:20 wawel kernel: [ 5262.064000] BTRFS info (device sda2): 
relocating block group 8494469087232 flags data
Dec 22 19:09:31 wawel kernel: [ 5272.940366] BTRFS info (device sda2): 
found 9 extents
Dec 22 19:09:35 wawel kernel: [ 5276.735998] BTRFS info (device sda2): 
found 9 extents
Dec 22 19:09:36 wawel kernel: [ 5277.343659] BTRFS info (device sda2): 
relocating block group 8491247861760 flags data
Dec 22 19:09:47 wawel kernel: [ 5288.587703] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:09:51 wawel kernel: [ 5292.187071] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:09:51 wawel kernel: [ 5292.617360] BTRFS info (device sda2): 
relocating block group 8489100378112 flags data
Dec 22 19:09:55 wawel kernel: [ 5296.165794] BTRFS info (device sda2): 
found 2 extents
Dec 22 19:09:57 wawel kernel: [ 5298.717969] BTRFS info (device sda2): 
found 2 extents
Dec 22 19:09:58 wawel kernel: [ 5300.067976] BTRFS info (device sda2): 
relocating block group 8485879152640 flags data
Dec 22 19:10:03 wawel kernel: [ 5304.928496] BTRFS info (device sda2): 
found 3 extents



Dec 22 19:20:11 wawel kernel: [ 5912.116874] ata1.00: exception Emask 
0x0 SAct 0x1f80 SErr 0x0 action 0x0
Dec 22 19:20:11 wawel kernel: [ 5912.116878] ata1.00: irq_stat 0x40000008
Dec 22 19:20:11 wawel kernel: [ 5912.116880] ata1.00: failed command: 
READ FPDMA QUEUED
Dec 22 19:20:11 wawel kernel: [ 5912.116882] ata1.00: cmd 
60/00:38:00:00:98/0a:00:45:01:00/40 tag 7 ncq dma 1310720 in
Dec 22 19:20:11 wawel kernel: [ 5912.116882]          res 
43/40:18:e8:05:98/00:04:45:01:00/40 Emask 0x409 (media error) <F>
Dec 22 19:20:11 wawel kernel: [ 5912.116885] ata1.00: status: { DRDY 
SENSE ERR }
Dec 22 19:20:11 wawel kernel: [ 5912.116886] ata1.00: error: { UNC }
Dec 22 19:20:11 wawel kernel: [ 5912.153695] ata1.00: configured for 
UDMA/133
Dec 22 19:20:11 wawel kernel: [ 5912.153707] sd 0:0:0:0: [sda] tag#7 
FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Dec 22 19:20:11 wawel kernel: [ 5912.153709] sd 0:0:0:0: [sda] tag#7 
Sense Key : Medium Error [current]
Dec 22 19:20:11 wawel kernel: [ 5912.153710] sd 0:0:0:0: [sda] tag#7 
Add. Sense: Unrecovered read error - auto reallocate failed
Dec 22 19:20:11 wawel kernel: [ 5912.153711] sd 0:0:0:0: [sda] tag#7 
CDB: Read(16) 88 00 00 00 00 01 45 98 00 00 00 00 0a 00 00 00
Dec 22 19:20:11 wawel kernel: [ 5912.153712] print_req_error: I/O error, 
dev sda, sector 5462556672
Dec 22 19:20:11 wawel kernel: [ 5912.153724] ata1: EH complete
Dec 22 19:21:28 wawel kernel: [ 5989.527853] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:21:29 wawel kernel: [ 5990.861317] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:21:30 wawel kernel: [ 5991.492017] BTRFS info (device sda2): 
relocating block group 8392463613952 flags data
Dec 22 19:21:40 wawel kernel: [ 6001.782573] BTRFS info (device sda2): 
found 10 extents
Dec 22 19:22:01 wawel kernel: [ 6022.162622] BTRFS info (device sda2): 
found 10 extents
Dec 22 19:22:17 wawel kernel: [ 6039.036941] BTRFS info (device sda2): 
relocating block group 8389242388480 flags data
Dec 22 19:22:33 wawel kernel: [ 6054.947905] BTRFS info (device sda2): 
found 9 extents
Dec 22 19:22:40 wawel kernel: [ 6061.630503] BTRFS info (device sda2): 
found 9 extents
Dec 22 19:22:41 wawel kernel: [ 6062.758008] BTRFS info (device sda2): 
relocating block group 8386021163008 flags data
Dec 22 19:22:53 wawel kernel: [ 6074.648119] BTRFS info (device sda2): 
found 8 extents
Dec 22 19:22:55 wawel kernel: [ 6076.264156] BTRFS info (device sda2): 
found 8 extents




Dec 22 23:31:24 wawel kernel: [20985.918518] BTRFS info (device sda2): 
found 17 extents
Dec 22 23:31:25 wawel kernel: [20986.705143] BTRFS info (device sda2): 
relocating block group 7150144323584 flags data
Dec 22 23:31:36 wawel kernel: [20997.997520] BTRFS info (device sda2): 
found 11 extents
Dec 22 23:31:56 wawel kernel: [21017.914604] BTRFS info (device sda2): 
found 11 extents
Dec 22 23:32:05 wawel kernel: [21027.095442] BTRFS info (device sda2): 
relocating block group 7146923098112 flags data
Dec 22 23:32:42 wawel kernel: [21064.078043] BTRFS info (device sda2): 
found 11 extents
Dec 22 23:32:52 wawel kernel: [21073.534844] BTRFS info (device sda2): 
found 11 extents
Dec 22 23:32:53 wawel kernel: [21074.527201] BTRFS info (device sda2): 
relocating block group 7141554388992 flags data
Dec 22 23:33:05 wawel kernel: [21086.947393] BTRFS info (device sda2): 
found 14 extents
Dec 22 23:33:14 wawel kernel: [21095.872547] BTRFS info (device sda2): 
found 14 extents
Dec 22 23:33:16 wawel kernel: [21097.161827] BTRFS info (device sda2): 
relocating block group 7138333163520 flags data
Dec 22 23:33:27 wawel kernel: [21108.868346] BTRFS info (device sda2): 
found 14 extents
Dec 22 23:33:35 wawel kernel: [21116.664273] BTRFS info (device sda2): 
found 14 extents
Dec 22 23:33:36 wawel kernel: [21117.233358] BTRFS info (device sda2): 
relocating block group 8559967338496 flags metadata|raid1
Dec 22 23:47:19 wawel kernel: [21940.204817] BTRFS info (device sda2): 
found 59958 extents
Dec 22 23:47:19 wawel kernel: [21940.935869] BTRFS info (device sda2): 
relocating block group 8558893596672 flags metadata|raid1
Dec 22 23:57:18 wawel kernel: [22539.150585] BTRFS info (device sda2): 
found 63167 extents
Dec 22 23:57:18 wawel kernel: [22540.041179] BTRFS info (device sda2): 
relocating block group 7128669487104 flags data
Dec 22 23:57:31 wawel kernel: [22552.964707] BTRFS info (device sda2): 
found 13 extents
Dec 22 23:57:49 wawel kernel: [22570.932560] BTRFS info (device sda2): 
found 13 extents
Dec 22 23:57:50 wawel kernel: [22571.760150] BTRFS info (device sda2): 
relocating block group 7125448261632 flags data
Dec 22 23:58:02 wawel kernel: [22583.650959] BTRFS info (device sda2): 
found 11 extents
Dec 22 23:58:10 wawel kernel: [22592.036311] BTRFS info (device sda2): 
found 11 extents
Dec 22 23:58:11 wawel kernel: [22592.520003] BTRFS info (device sda2): 
relocating block group 7122227036160 flags data
Dec 22 23:58:22 wawel kernel: [22603.590833] BTRFS info (device sda2): 
found 16 extents
Dec 22 23:58:35 wawel kernel: [22616.179240] BTRFS info (device sda2): 
found 16 extents
Dec 22 23:58:35 wawel kernel: [22616.810120] BTRFS info (device sda2): 
relocating block group 7119005810688 flags data
Dec 22 23:58:54 wawel kernel: [22635.938434] BTRFS info (device sda2): 
found 17 extents
Dec 22 23:59:30 wawel kernel: [22671.668073] BTRFS info (device sda2): 
found 17 extents
Dec 22 23:59:33 wawel kernel: [22675.053253] BTRFS info (device sda2): 
found 6 extents
Dec 22 23:59:34 wawel kernel: [22675.806876] BTRFS info (device sda2): 
relocating block group 7115784585216 flags data
Dec 22 23:59:47 wawel kernel: [22689.015207] BTRFS info (device sda2): 
found 15 extents
Dec 23 00:00:04 wawel kernel: [22705.897111] BTRFS info (device sda2): 
found 15 extents
Dec 23 00:00:11 wawel kernel: [22712.320353] BTRFS info (device sda2): 
relocating block group 7112563359744 flags data
Dec 23 00:01:19 wawel kernel: [22780.810851] BTRFS info (device sda2): 
found 25 extents
Dec 23 00:02:23 wawel kernel: [22844.836838] BTRFS info (device sda2): 
found 25 extents
Dec 23 00:02:24 wawel kernel: [22845.996013] BTRFS info (device sda2): 
relocating block group 7109342134272 flags data
Dec 23 00:02:36 wawel kernel: [22857.961127] BTRFS info (device sda2): 
found 14 extents
Dec 23 00:02:43 wawel kernel: [22864.547374] BTRFS info (device sda2): 
found 14 extents
Dec 23 00:02:44 wawel kernel: [22865.258107] BTRFS info (device sda2): 
relocating block group 7106120908800 flags data
Dec 23 00:02:55 wawel kernel: [22876.860762] BTRFS info (device sda2): 
found 14 extents
Dec 23 00:03:02 wawel kernel: [22883.804570] BTRFS info (device sda2): 
found 14 extents
Dec 23 00:03:03 wawel kernel: [22884.363060] BTRFS info (device sda2): 
relocating block group 7102899683328 flags data
Dec 23 00:03:14 wawel kernel: [22895.383964] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:03:38 wawel kernel: [22919.988908] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:03:53 wawel kernel: [22935.003150] BTRFS info (device sda2): 
relocating block group 7081424846848 flags data
Dec 23 00:04:37 wawel kernel: [22978.751114] BTRFS info (device sda2): 
found 9 extents
Dec 23 00:04:56 wawel kernel: [22997.228499] BTRFS info (device sda2): 
found 9 extents
Dec 23 00:04:57 wawel kernel: [22998.219232] BTRFS info (device sda2): 
relocating block group 7078203621376 flags data



Dec 23 00:08:20 wawel kernel: [23201.188424] INFO: task btrfs:2546 
blocked for more than 120 seconds.
Dec 23 00:08:20 wawel kernel: [23201.188437]       Not tainted 
4.19.0-6-amd64 #1 Debian 4.19.67-2+deb10u2
Dec 23 00:08:20 wawel kernel: [23201.188442] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 23 00:08:20 wawel kernel: [23201.188449] btrfs           D    0 
2546   2539 0x00000000
Dec 23 00:08:20 wawel kernel: [23201.188454] Call Trace:
Dec 23 00:08:20 wawel kernel: [23201.188468]  ? __schedule+0x2a2/0x870
Dec 23 00:08:20 wawel kernel: [23201.188476]  schedule+0x28/0x80
Dec 23 00:08:20 wawel kernel: [23201.188480] 
schedule_preempt_disabled+0xa/0x10
Dec 23 00:08:20 wawel kernel: [23201.188486] __mutex_lock.isra.8+0x2b5/0x4a0
Dec 23 00:08:20 wawel kernel: [23201.188550] 
btrfs_relocate_block_group.cold.48+0x48/0x1ae [btrfs]
Dec 23 00:08:20 wawel kernel: [23201.188609] 
btrfs_relocate_chunk+0x31/0xa0 [btrfs]
Dec 23 00:08:20 wawel kernel: [23201.188666] 
btrfs_shrink_device+0x1e1/0x550 [btrfs]
Dec 23 00:08:20 wawel kernel: [23201.188722]  ? 
btrfs_find_device_missing_or_by_path+0x110/0x130 [btrfs]
Dec 23 00:08:20 wawel kernel: [23201.188775] btrfs_rm_device+0x165/0x590 
[btrfs]
Dec 23 00:08:20 wawel kernel: [23201.188782]  ? 
__kmalloc_track_caller+0x16c/0x210
Dec 23 00:08:20 wawel kernel: [23201.188788]  ? 
__check_object_size+0x15d/0x189
Dec 23 00:08:20 wawel kernel: [23201.188841] btrfs_ioctl+0x2a8e/0x2d90 
[btrfs]
Dec 23 00:08:20 wawel kernel: [23201.188848]  ? 
__check_object_size+0x15d/0x189
Dec 23 00:08:20 wawel kernel: [23201.188855]  ? _copy_to_user+0x26/0x30
Dec 23 00:08:20 wawel kernel: [23201.188861]  ? cp_new_stat+0x150/0x180
Dec 23 00:08:20 wawel kernel: [23201.188868]  ? do_vfs_ioctl+0xa4/0x630
Dec 23 00:08:20 wawel kernel: [23201.188873] do_vfs_ioctl+0xa4/0x630
Dec 23 00:08:20 wawel kernel: [23201.188879]  ? __do_sys_newstat+0x48/0x70
Dec 23 00:08:20 wawel kernel: [23201.188885]  ksys_ioctl+0x60/0x90
Dec 23 00:08:20 wawel kernel: [23201.188891] __x64_sys_ioctl+0x16/0x20
Dec 23 00:08:20 wawel kernel: [23201.188898] do_syscall_64+0x53/0x110
Dec 23 00:08:20 wawel kernel: [23201.188905] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec 23 00:08:20 wawel kernel: [23201.188910] RIP: 0033:0x7f3d307fd427
Dec 23 00:08:20 wawel kernel: [23201.188919] Code: Bad RIP value.
Dec 23 00:08:20 wawel kernel: [23201.188922] RSP: 002b:00007ffc69d36b48 
EFLAGS: 00000206 ORIG_RAX: 0000000000000010
Dec 23 00:08:20 wawel kernel: [23201.188927] RAX: ffffffffffffffda RBX: 
0000000000000000 RCX: 00007f3d307fd427
Dec 23 00:08:20 wawel kernel: [23201.188929] RDX: 00007ffc69d37b68 RSI: 
000000005000943a RDI: 0000000000000003
Dec 23 00:08:20 wawel kernel: [23201.188931] RBP: 0000000000000001 R08: 
0000000000000008 R09: 0000000000000078
Dec 23 00:08:20 wawel kernel: [23201.188933] R10: fffffffffffffa4a R11: 
0000000000000206 R12: 00007ffc69d38ce8
Dec 23 00:08:20 wawel kernel: [23201.188935] R13: 0000000000000000 R14: 
0000000000000003 R15: 0000000000000003
Dec 23 00:10:20 wawel kernel: [23322.019744] INFO: task btrfs:2546 
blocked for more than 120 seconds.
Dec 23 00:10:20 wawel kernel: [23322.019757]       Not tainted 
4.19.0-6-amd64 #1 Debian 4.19.67-2+deb10u2
Dec 23 00:10:20 wawel kernel: [23322.019762] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 23 00:10:20 wawel kernel: [23322.019768] btrfs           D    0 
2546   2539 0x00000000
Dec 23 00:10:20 wawel kernel: [23322.019774] Call Trace:
Dec 23 00:10:20 wawel kernel: [23322.019788]  ? __schedule+0x2a2/0x870
Dec 23 00:10:20 wawel kernel: [23322.019795]  schedule+0x28/0x80
Dec 23 00:10:20 wawel kernel: [23322.019800] 
schedule_preempt_disabled+0xa/0x10
Dec 23 00:10:20 wawel kernel: [23322.019805] __mutex_lock.isra.8+0x2b5/0x4a0
Dec 23 00:10:20 wawel kernel: [23322.019864] 
btrfs_relocate_block_group.cold.48+0x48/0x1ae [btrfs]
Dec 23 00:10:20 wawel kernel: [23322.019923] 
btrfs_relocate_chunk+0x31/0xa0 [btrfs]
Dec 23 00:10:20 wawel kernel: [23322.019979] 
btrfs_shrink_device+0x1e1/0x550 [btrfs]
Dec 23 00:10:20 wawel kernel: [23322.020035]  ? 
btrfs_find_device_missing_or_by_path+0x110/0x130 [btrfs]
Dec 23 00:10:20 wawel kernel: [23322.020088] btrfs_rm_device+0x165/0x590 
[btrfs]
Dec 23 00:10:20 wawel kernel: [23322.020095]  ? 
__kmalloc_track_caller+0x16c/0x210
Dec 23 00:10:20 wawel kernel: [23322.020101]  ? 
__check_object_size+0x15d/0x189
Dec 23 00:10:20 wawel kernel: [23322.020152] btrfs_ioctl+0x2a8e/0x2d90 
[btrfs]
Dec 23 00:10:20 wawel kernel: [23322.020159]  ? 
__check_object_size+0x15d/0x189
Dec 23 00:10:20 wawel kernel: [23322.020166]  ? _copy_to_user+0x26/0x30
Dec 23 00:10:20 wawel kernel: [23322.020171]  ? cp_new_stat+0x150/0x180
Dec 23 00:10:20 wawel kernel: [23322.020179]  ? do_vfs_ioctl+0xa4/0x630
Dec 23 00:10:20 wawel kernel: [23322.020183] do_vfs_ioctl+0xa4/0x630
Dec 23 00:10:20 wawel kernel: [23322.020189]  ? __do_sys_newstat+0x48/0x70
Dec 23 00:10:20 wawel kernel: [23322.020195]  ksys_ioctl+0x60/0x90
Dec 23 00:10:20 wawel kernel: [23322.020201] __x64_sys_ioctl+0x16/0x20
Dec 23 00:10:20 wawel kernel: [23322.020207] do_syscall_64+0x53/0x110
Dec 23 00:10:20 wawel kernel: [23322.020214] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec 23 00:10:20 wawel kernel: [23322.020219] RIP: 0033:0x7f3d307fd427
Dec 23 00:10:20 wawel kernel: [23322.020228] Code: Bad RIP value.
Dec 23 00:10:20 wawel kernel: [23322.020231] RSP: 002b:00007ffc69d36b48 
EFLAGS: 00000206 ORIG_RAX: 0000000000000010
Dec 23 00:10:20 wawel kernel: [23322.020235] RAX: ffffffffffffffda RBX: 
0000000000000000 RCX: 00007f3d307fd427
Dec 23 00:10:20 wawel kernel: [23322.020238] RDX: 00007ffc69d37b68 RSI: 
000000005000943a RDI: 0000000000000003
Dec 23 00:10:20 wawel kernel: [23322.020240] RBP: 0000000000000001 R08: 
0000000000000008 R09: 0000000000000078
Dec 23 00:10:20 wawel kernel: [23322.020242] R10: fffffffffffffa4a R11: 
0000000000000206 R12: 00007ffc69d38ce8
Dec 23 00:10:20 wawel kernel: [23322.020244] R13: 0000000000000000 R14: 
0000000000000003 R15: 0000000000000003
Dec 23 00:12:21 wawel kernel: [23442.851059] INFO: task btrfs:2546 
blocked for more than 120 seconds.
Dec 23 00:12:21 wawel kernel: [23442.851076]       Not tainted 
4.19.0-6-amd64 #1 Debian 4.19.67-2+deb10u2
Dec 23 00:12:21 wawel kernel: [23442.851086] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 23 00:12:21 wawel kernel: [23442.851097] btrfs           D    0 
2546   2539 0x00000000
Dec 23 00:12:21 wawel kernel: [23442.851105] Call Trace:
Dec 23 00:12:21 wawel kernel: [23442.851122]  ? __schedule+0x2a2/0x870
Dec 23 00:12:21 wawel kernel: [23442.851131]  schedule+0x28/0x80
Dec 23 00:12:21 wawel kernel: [23442.851138] 
schedule_preempt_disabled+0xa/0x10
Dec 23 00:12:21 wawel kernel: [23442.851145] __mutex_lock.isra.8+0x2b5/0x4a0
Dec 23 00:12:21 wawel kernel: [23442.851228] 
btrfs_relocate_block_group.cold.48+0x48/0x1ae [btrfs]
Dec 23 00:12:21 wawel kernel: [23442.851310] 
btrfs_relocate_chunk+0x31/0xa0 [btrfs]
Dec 23 00:12:21 wawel kernel: [23442.851391] 
btrfs_shrink_device+0x1e1/0x550 [btrfs]
Dec 23 00:12:21 wawel kernel: [23442.851469]  ? 
btrfs_find_device_missing_or_by_path+0x110/0x130 [btrfs]
Dec 23 00:12:21 wawel kernel: [23442.851544] btrfs_rm_device+0x165/0x590 
[btrfs]
Dec 23 00:12:21 wawel kernel: [23442.851554]  ? 
__kmalloc_track_caller+0x16c/0x210
Dec 23 00:12:21 wawel kernel: [23442.851562]  ? 
__check_object_size+0x15d/0x189
Dec 23 00:12:21 wawel kernel: [23442.851637] btrfs_ioctl+0x2a8e/0x2d90 
[btrfs]
Dec 23 00:12:21 wawel kernel: [23442.851646]  ? 
__check_object_size+0x15d/0x189
Dec 23 00:12:21 wawel kernel: [23442.851655]  ? _copy_to_user+0x26/0x30
Dec 23 00:12:21 wawel kernel: [23442.851662]  ? cp_new_stat+0x150/0x180
Dec 23 00:12:21 wawel kernel: [23442.851672]  ? do_vfs_ioctl+0xa4/0x630
Dec 23 00:12:21 wawel kernel: [23442.851678] do_vfs_ioctl+0xa4/0x630
Dec 23 00:12:21 wawel kernel: [23442.851685]  ? __do_sys_newstat+0x48/0x70
Dec 23 00:12:21 wawel kernel: [23442.851694]  ksys_ioctl+0x60/0x90
Dec 23 00:12:21 wawel kernel: [23442.851702] __x64_sys_ioctl+0x16/0x20
Dec 23 00:12:21 wawel kernel: [23442.851710] do_syscall_64+0x53/0x110
Dec 23 00:12:21 wawel kernel: [23442.851719] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec 23 00:12:21 wawel kernel: [23442.851725] RIP: 0033:0x7f3d307fd427
Dec 23 00:12:21 wawel kernel: [23442.851736] Code: Bad RIP value.
Dec 23 00:12:21 wawel kernel: [23442.851739] RSP: 002b:00007ffc69d36b48 
EFLAGS: 00000206 ORIG_RAX: 0000000000000010
Dec 23 00:12:21 wawel kernel: [23442.851746] RAX: ffffffffffffffda RBX: 
0000000000000000 RCX: 00007f3d307fd427
Dec 23 00:12:21 wawel kernel: [23442.851749] RDX: 00007ffc69d37b68 RSI: 
000000005000943a RDI: 0000000000000003
Dec 23 00:12:21 wawel kernel: [23442.851752] RBP: 0000000000000001 R08: 
0000000000000008 R09: 0000000000000078
Dec 23 00:12:21 wawel kernel: [23442.851756] R10: fffffffffffffa4a R11: 
0000000000000206 R12: 00007ffc69d38ce8
Dec 23 00:12:21 wawel kernel: [23442.851759] R13: 0000000000000000 R14: 
0000000000000003 R15: 0000000000000003
Dec 23 00:14:22 wawel kernel: [23563.682406] INFO: task btrfs:2546 
blocked for more than 120 seconds.
Dec 23 00:14:22 wawel kernel: [23563.682424]       Not tainted 
4.19.0-6-amd64 #1 Debian 4.19.67-2+deb10u2
Dec 23 00:14:22 wawel kernel: [23563.682434] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 23 00:14:22 wawel kernel: [23563.682446] btrfs           D    0 
2546   2539 0x00000000
Dec 23 00:14:22 wawel kernel: [23563.682453] Call Trace:
Dec 23 00:14:22 wawel kernel: [23563.682470]  ? __schedule+0x2a2/0x870
Dec 23 00:14:22 wawel kernel: [23563.682480]  schedule+0x28/0x80
Dec 23 00:14:22 wawel kernel: [23563.682486] 
schedule_preempt_disabled+0xa/0x10
Dec 23 00:14:22 wawel kernel: [23563.682493] __mutex_lock.isra.8+0x2b5/0x4a0
Dec 23 00:14:22 wawel kernel: [23563.682577] 
btrfs_relocate_block_group.cold.48+0x48/0x1ae [btrfs]
Dec 23 00:14:22 wawel kernel: [23563.682658] 
btrfs_relocate_chunk+0x31/0xa0 [btrfs]
Dec 23 00:14:22 wawel kernel: [23563.682737] 
btrfs_shrink_device+0x1e1/0x550 [btrfs]
Dec 23 00:14:22 wawel kernel: [23563.682817]  ? 
btrfs_find_device_missing_or_by_path+0x110/0x130 [btrfs]
Dec 23 00:14:22 wawel kernel: [23563.682892] btrfs_rm_device+0x165/0x590 
[btrfs]
Dec 23 00:14:22 wawel kernel: [23563.682902]  ? 
__kmalloc_track_caller+0x16c/0x210
Dec 23 00:14:22 wawel kernel: [23563.682910]  ? 
__check_object_size+0x15d/0x189
Dec 23 00:14:22 wawel kernel: [23563.682984] btrfs_ioctl+0x2a8e/0x2d90 
[btrfs]
Dec 23 00:14:22 wawel kernel: [23563.682993]  ? 
__check_object_size+0x15d/0x189
Dec 23 00:14:22 wawel kernel: [23563.683002]  ? _copy_to_user+0x26/0x30
Dec 23 00:14:22 wawel kernel: [23563.683009]  ? cp_new_stat+0x150/0x180
Dec 23 00:14:22 wawel kernel: [23563.683018]  ? do_vfs_ioctl+0xa4/0x630
Dec 23 00:14:22 wawel kernel: [23563.683024] do_vfs_ioctl+0xa4/0x630
Dec 23 00:14:22 wawel kernel: [23563.683032]  ? __do_sys_newstat+0x48/0x70
Dec 23 00:14:22 wawel kernel: [23563.683040]  ksys_ioctl+0x60/0x90
Dec 23 00:14:22 wawel kernel: [23563.683048] __x64_sys_ioctl+0x16/0x20
Dec 23 00:14:22 wawel kernel: [23563.683056] do_syscall_64+0x53/0x110
Dec 23 00:14:22 wawel kernel: [23563.683065] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec 23 00:14:22 wawel kernel: [23563.683071] RIP: 0033:0x7f3d307fd427
Dec 23 00:14:22 wawel kernel: [23563.683081] Code: Bad RIP value.
Dec 23 00:14:22 wawel kernel: [23563.683085] RSP: 002b:00007ffc69d36b48 
EFLAGS: 00000206 ORIG_RAX: 0000000000000010
Dec 23 00:14:22 wawel kernel: [23563.683092] RAX: ffffffffffffffda RBX: 
0000000000000000 RCX: 00007f3d307fd427
Dec 23 00:14:22 wawel kernel: [23563.683096] RDX: 00007ffc69d37b68 RSI: 
000000005000943a RDI: 0000000000000003
Dec 23 00:14:22 wawel kernel: [23563.683099] RBP: 0000000000000001 R08: 
0000000000000008 R09: 0000000000000078
Dec 23 00:14:22 wawel kernel: [23563.683102] R10: fffffffffffffa4a R11: 
0000000000000206 R12: 00007ffc69d38ce8
Dec 23 00:14:22 wawel kernel: [23563.683104] R13: 0000000000000000 R14: 
0000000000000003 R15: 0000000000000003
Dec 23 00:14:55 wawel kernel: [23596.566285] BTRFS info (device sda2): 
found 16 extents
Dec 23 00:15:21 wawel kernel: [23622.371794] BTRFS info (device sda2): 
found 16 extents
Dec 23 00:15:21 wawel kernel: [23622.805017] BTRFS info (device sda2): 
relocating block group 7073908654080 flags data
Dec 23 00:15:32 wawel kernel: [23633.535788] BTRFS info (device sda2): 
found 18 extents
Dec 23 00:15:56 wawel kernel: [23657.552946] BTRFS info (device sda2): 
found 18 extents
Dec 23 00:15:57 wawel kernel: [23658.309332] BTRFS info (device sda2): 
relocating block group 7070687428608 flags data
Dec 23 00:16:11 wawel kernel: [23672.185586] BTRFS info (device sda2): 
found 16 extents
Dec 23 00:16:18 wawel kernel: [23679.466177] BTRFS info (device sda2): 
found 16 extents
Dec 23 00:16:18 wawel kernel: [23679.780450] BTRFS info (device sda2): 
relocating block group 7067466203136 flags data
Dec 23 00:16:29 wawel kernel: [23691.026282] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:16:32 wawel kernel: [23693.545940] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:16:32 wawel kernel: [23693.977786] BTRFS info (device sda2): 
relocating block group 7064244977664 flags data
Dec 23 00:16:43 wawel kernel: [23704.182394] BTRFS info (device sda2): 
found 13 extents
Dec 23 00:16:50 wawel kernel: [23711.975492] BTRFS info (device sda2): 
found 13 extents
Dec 23 00:16:51 wawel kernel: [23712.408224] BTRFS info (device sda2): 
relocating block group 7061023752192 flags data
Dec 23 00:17:01 wawel kernel: [23722.754585] BTRFS info (device sda2): 
found 11 extents
Dec 23 00:17:09 wawel kernel: [23730.262877] BTRFS info (device sda2): 
found 11 extents
Dec 23 00:17:11 wawel kernel: [23732.302305] BTRFS info (device sda2): 
found 11 extents
Dec 23 00:17:11 wawel kernel: [23732.722001] BTRFS info (device sda2): 
relocating block group 7057802526720 flags data
Dec 23 00:17:26 wawel kernel: [23747.679932] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:17:30 wawel kernel: [23751.451465] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:17:30 wawel kernel: [23751.876404] BTRFS info (device sda2): 
relocating block group 7054581301248 flags data
Dec 23 00:17:41 wawel kernel: [23762.977551] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:17:42 wawel kernel: [23763.883422] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:17:43 wawel kernel: [23764.275202] BTRFS info (device sda2): 
relocating block group 7051360075776 flags data
Dec 23 00:17:52 wawel kernel: [23773.479034] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:17:53 wawel kernel: [23774.431145] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:17:53 wawel kernel: [23774.905979] BTRFS info (device sda2): 
relocating block group 7048138850304 flags data
Dec 23 00:18:21 wawel kernel: [23802.511276] BTRFS info (device sda2): 
found 18 extents
Dec 23 00:18:47 wawel kernel: [23828.664441] BTRFS info (device sda2): 
found 18 extents
Dec 23 00:18:51 wawel kernel: [23832.165407] BTRFS info (device sda2): 
found 9 extents
Dec 23 00:18:51 wawel kernel: [23832.596833] BTRFS info (device sda2): 
relocating block group 7044917624832 flags data
Dec 23 00:19:07 wawel kernel: [23848.329302] BTRFS info (device sda2): 
found 9 extents
Dec 23 00:19:18 wawel kernel: [23859.557383] BTRFS info (device sda2): 
found 9 extents
Dec 23 00:19:18 wawel kernel: [23859.916559] BTRFS info (device sda2): 
relocating block group 7041696399360 flags data
Dec 23 00:19:31 wawel kernel: [23872.555941] BTRFS info (device sda2): 
found 18 extents
Dec 23 00:19:46 wawel kernel: [23888.035472] BTRFS info (device sda2): 
found 18 extents
Dec 23 00:19:47 wawel kernel: [23888.620939] BTRFS info (device sda2): 
relocating block group 7038475173888 flags data
Dec 23 00:19:59 wawel kernel: [23900.878661] BTRFS info (device sda2): 
found 9 extents
Dec 23 00:20:14 wawel kernel: [23915.924062] BTRFS info (device sda2): 
found 9 extents
Dec 23 00:20:15 wawel kernel: [23916.373951] BTRFS info (device sda2): 
relocating block group 7035253948416 flags data
Dec 23 00:20:29 wawel kernel: [23930.526982] BTRFS info (device sda2): 
found 13 extents
Dec 23 00:20:40 wawel kernel: [23941.166196] BTRFS info (device sda2): 
found 13 extents
Dec 23 00:20:40 wawel kernel: [23941.603215] BTRFS info (device sda2): 
relocating block group 7032032722944 flags data
Dec 23 00:20:52 wawel kernel: [23953.361622] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:20:54 wawel kernel: [23955.734989] BTRFS info (device sda2): 
found 8 extents
Dec 23 00:20:55 wawel kernel: [23956.150691] BTRFS info (device sda2): 
relocating block group 7028811497472 flags data
Dec 23 00:21:07 wawel kernel: [23968.438551] BTRFS info (device sda2): 
found 11 extents
Dec 23 00:21:11 wawel kernel: [23972.732940] BTRFS info (device sda2): 
found 11 extents
Dec 23 00:21:12 wawel kernel: [23973.122960] BTRFS info (device sda2): 
relocating block group 7025590272000 flags data
Dec 23 00:21:25 wawel kernel: [23986.098275] BTRFS info (device sda2): 
found 10 extents
Dec 23 00:21:43 wawel kernel: [24004.479645] BTRFS info (device sda2): 
found 10 extents
Dec 23 00:21:58 wawel kernel: [24019.409741] BTRFS info (device sda2): 
relocating block group 7022369046528 flags data
Dec 23 00:22:16 wawel kernel: [24037.905347] BTRFS info (device sda2): 
found 10 extents
Dec 23 00:22:36 wawel kernel: [24057.193719] BTRFS info (device sda2): 
found 10 extents
Dec 23 00:22:42 wawel kernel: [24063.236104] BTRFS info (device sda2): 
relocating block group 7019147821056 flags data
Dec 23 00:22:57 wawel kernel: [24078.235035] BTRFS info (device sda2): 
found 10 extents
Dec 23 00:23:17 wawel kernel: [24098.884138] BTRFS info (device sda2): 
found 10 extents
Dec 23 00:23:19 wawel kernel: [24100.237497] BTRFS info (device sda2): 
relocating block group 7015926595584 flags data
Dec 23 00:23:32 wawel kernel: [24113.252248] BTRFS info (device sda2): 
found 11 extents

Dec 26 09:06:30 wawel kernel: [124813.206299] BTRFS info (device sda2): 
found 538 extents
Dec 26 09:06:41 wawel kernel: [124824.121993] BTRFS info (device sda2): 
relocating block group 2862659665920 flags data
Dec 26 09:07:01 wawel kernel: [124844.420159] BTRFS info (device sda2): 
found 76 extents
Dec 26 09:07:26 wawel kernel: [124869.796349] BTRFS info (device sda2): 
found 76 extents
Dec 26 09:07:33 wawel kernel: [124876.379783] BTRFS info (device sda2): 
relocating block group 2859438440448 flags data
Dec 26 09:07:55 wawel kernel: [124898.518810] BTRFS info (device sda2): 
found 314 extents
Dec 26 09:08:20 wawel kernel: [124922.923430] BTRFS info (device sda2): 
found 314 extents
Dec 26 09:08:24 wawel kernel: [124927.088396] BTRFS info (device sda2): 
relocating block group 2856217214976 flags data
Dec 26 09:09:01 wawel kernel: [124964.879333] BTRFS info (device sda2): 
found 3257 extents
Dec 26 09:10:07 wawel kernel: [125030.251298] BTRFS info (device sda2): 
found 3257 extents
Dec 26 09:10:27 wawel kernel: [125050.474861] BTRFS info (device sda2): 
relocating block group 2852995989504 flags data
Dec 26 09:11:17 wawel kernel: [125100.646368] BTRFS info (device sda2): 
found 720 extents
Dec 26 09:11:57 wawel kernel: [125140.038078] BTRFS info (device sda2): 
found 720 extents
Dec 26 09:12:00 wawel kernel: [125143.489371] BTRFS info (device sda2): 
relocating block group 2849774764032 flags data
Dec 26 09:12:30 wawel kernel: [125173.882124] BTRFS info (device sda2): 
found 781 extents
Dec 26 09:13:13 wawel kernel: [125216.215971] BTRFS info (device sda2): 
found 781 extents
Dec 26 09:13:30 wawel kernel: [125233.369639] BTRFS info (device sda2): 
relocating block group 2846553538560 flags data
Dec 26 09:14:10 wawel kernel: [125273.480275] BTRFS info (device sda2): 
found 863 extents
Dec 26 09:14:40 wawel kernel: [125303.044820] BTRFS info (device sda2): 
found 863 extents
Dec 26 09:14:50 wawel kernel: [125313.825051] BTRFS info (device sda2): 
relocating block group 2843332313088 flags data
Dec 26 09:15:11 wawel kernel: [125334.898553] BTRFS info (device sda2): 
found 605 extents
Dec 26 09:15:34 wawel kernel: [125357.032946] BTRFS info (device sda2): 
found 605 extents
Dec 26 09:15:39 wawel kernel: [125362.305375] BTRFS info (device sda2): 
relocating block group 2840111087616 flags data
Dec 26 09:15:57 wawel kernel: [125380.738443] BTRFS info (device sda2): 
found 822 extents
Dec 26 09:16:27 wawel kernel: [125410.554652] BTRFS info (device sda2): 
found 822 extents
Dec 26 09:16:33 wawel kernel: [125416.795941] BTRFS info (device sda2): 
found 1 extents
Dec 26 09:16:40 wawel kernel: [125423.287556] BTRFS info (device sda2): 
found 1 extents
Dec 26 09:16:41 wawel kernel: [125424.662419] BTRFS info (device sda2): 
relocating block group 2836889862144 flags data
Dec 26 09:17:58 wawel kernel: [125500.923465] BTRFS info (device sda2): 
found 6105 extents
Dec 26 09:20:20 wawel kernel: [125643.445337] BTRFS info (device sda2): 
found 6105 extents
Dec 26 09:20:37 wawel kernel: [125660.315318] BTRFS info (device sda2): 
found 9 extents
Dec 26 09:21:19 wawel kernel: [125702.836577] BTRFS info (device sda2): 
found 9 extents
Dec 26 09:21:36 wawel kernel: [125719.739584] BTRFS info (device sda2): 
relocating block group 2833668636672 flags data
Dec 26 09:22:15 wawel kernel: [125758.510136] BTRFS info (device sda2): 
found 1732 extents
Dec 26 09:22:39 wawel kernel: [125782.335053] BTRFS info (device sda2): 
found 1732 extents
Dec 26 09:22:43 wawel kernel: [125786.733606] BTRFS info (device sda2): 
relocating block group 2830447411200 flags data
Dec 26 09:23:14 wawel kernel: [125817.174210] BTRFS info (device sda2): 
found 1540 extents
Dec 26 09:23:32 wawel kernel: [125835.049452] BTRFS info (device sda2): 
found 1540 extents
Dec 26 09:23:37 wawel kernel: [125840.764399] BTRFS info (device sda2): 
relocating block group 2827226185728 flags data
Dec 26 09:23:59 wawel kernel: [125862.499798] BTRFS info (device sda2): 
found 1730 extents
Dec 26 09:24:20 wawel kernel: [125883.528931] BTRFS info (device sda2): 
found 1730 extents
Dec 26 09:24:25 wawel kernel: [125888.791587] BTRFS info (device sda2): 
relocating block group 2824004960256 flags data
Dec 26 09:25:00 wawel kernel: [125923.748361] BTRFS info (device sda2): 
found 1453 extents
Dec 26 09:25:30 wawel kernel: [125953.500151] BTRFS info (device sda2): 
found 1453 extents
Dec 26 09:25:47 wawel kernel: [125970.178853] BTRFS info (device sda2): 
relocating block group 2820783734784 flags data
Dec 26 09:26:19 wawel kernel: [126001.953383] BTRFS info (device sda2): 
found 1321 extents
Dec 26 09:26:47 wawel kernel: [126030.506902] BTRFS info (device sda2): 
found 1321 extents
Dec 26 09:26:59 wawel kernel: [126042.292928] BTRFS info (device sda2): 
relocating block group 2817562509312 flags data
Dec 26 09:27:26 wawel kernel: [126069.399351] BTRFS info (device sda2): 
found 1321 extents
Dec 26 09:28:54 wawel kernel: [126157.696317] BTRFS info (device sda2): 
found 1321 extents
Dec 26 09:29:05 wawel kernel: [126167.934754] BTRFS info (device sda2): 
relocating block group 2814341283840 flags data
Dec 26 09:29:29 wawel kernel: [126192.741151] BTRFS info (device sda2): 
found 1308 extents
Dec 26 09:29:48 wawel kernel: [126210.929302] BTRFS info (device sda2): 
found 1308 extents
Dec 26 09:29:55 wawel kernel: [126218.316856] BTRFS info (device sda2): 
relocating block group 2811120058368 flags data
Dec 26 09:30:24 wawel kernel: [126247.373223] BTRFS info (device sda2): 
found 1302 extents
Dec 26 09:30:50 wawel kernel: [126273.241357] BTRFS info (device sda2): 
found 1302 extents
Dec 26 09:31:06 wawel kernel: [126289.751136] BTRFS info (device sda2): 
found 1301 extents
Dec 26 09:31:11 wawel kernel: [126293.918325] BTRFS info (device sda2): 
relocating block group 2807898832896 flags data
Dec 26 09:31:29 wawel kernel: [126312.570431] BTRFS info (device sda2): 
found 1239 extents
Dec 26 09:31:57 wawel kernel: [126340.525339] BTRFS info (device sda2): 
found 1239 extents
Dec 26 09:32:07 wawel kernel: [126350.580726] BTRFS info (device sda2): 
relocating block group 2804677607424 flags data
Dec 26 09:32:38 wawel kernel: [126381.535312] BTRFS info (device sda2): 
found 1318 extents
Dec 26 09:33:04 wawel kernel: [126407.888226] BTRFS info (device sda2): 
found 1318 extents
Dec 26 09:33:17 wawel kernel: [126420.834830] BTRFS info (device sda2): 
relocating block group 2801456381952 flags data
Dec 26 09:34:57 wawel kernel: [126520.878652] BTRFS info (device sda2): 
found 1314 extents
Dec 26 09:35:30 wawel kernel: [126553.629757] BTRFS info (device sda2): 
found 1314 extents
Dec 26 09:35:40 wawel kernel: [126563.198254] BTRFS info (device sda2): 
relocating block group 2798235156480 flags data
Dec 26 09:36:05 wawel kernel: [126588.438641] BTRFS info (device sda2): 
found 1259 extents
Dec 26 09:36:23 wawel kernel: [126605.928090] BTRFS info (device sda2): 
found 1259 extents
Dec 26 09:36:31 wawel kernel: [126614.349082] BTRFS info (device sda2): 
relocating block group 2795013931008 flags data
Dec 26 09:36:55 wawel kernel: [126638.306903] BTRFS info (device sda2): 
found 1254 extents
Dec 26 09:37:13 wawel kernel: [126656.883642] BTRFS info (device sda2): 
found 1254 extents
Dec 26 09:37:18 wawel kernel: [126661.319326] BTRFS info (device sda2): 
relocating block group 2791792705536 flags data
Dec 26 09:37:39 wawel kernel: [126682.613613] BTRFS info (device sda2): 
found 1034 extents
Dec 26 09:37:53 wawel kernel: [126695.934991] BTRFS info (device sda2): 
found 1034 extents
Dec 26 09:37:58 wawel kernel: [126701.052766] BTRFS info (device sda2): 
relocating block group 2788571480064 flags data
Dec 26 09:38:23 wawel kernel: [126726.414875] BTRFS info (device sda2): 
found 633 extents
Dec 26 09:38:54 wawel kernel: [126757.375947] BTRFS info (device sda2): 
found 633 extents
Dec 26 09:39:05 wawel kernel: [126768.679478] BTRFS info (device sda2): 
relocating block group 2785350254592 flags data
Dec 26 09:39:36 wawel kernel: [126799.425144] BTRFS info (device sda2): 
found 693 extents
Dec 26 09:40:06 wawel kernel: [126829.604815] BTRFS info (device sda2): 
found 693 extents
Dec 26 09:40:25 wawel kernel: [126848.363498] BTRFS info (device sda2): 
relocating block group 2782129029120 flags data
Dec 26 09:41:05 wawel kernel: [126888.549973] BTRFS info (device sda2): 
found 514 extents
Dec 26 09:41:36 wawel kernel: [126919.490217] BTRFS info (device sda2): 
found 514 extents
Dec 26 09:42:03 wawel kernel: [126946.123272] BTRFS info (device sda2): 
relocating block group 2778907803648 flags data
Dec 26 09:42:36 wawel kernel: [126979.670180] BTRFS info (device sda2): 
found 519 extents
Dec 26 09:42:56 wawel kernel: [126999.459002] BTRFS info (device sda2): 
found 519 extents
Dec 26 09:43:05 wawel kernel: [127008.768350] BTRFS info (device sda2): 
relocating block group 2775686578176 flags data
Dec 26 09:43:28 wawel kernel: [127031.510719] BTRFS info (device sda2): 
found 653 extents
Dec 26 09:43:44 wawel kernel: [127047.653185] BTRFS info (device sda2): 
found 653 extents
Dec 26 09:43:51 wawel kernel: [127054.633127] BTRFS info (device sda2): 
relocating block group 2772465352704 flags data
Dec 26 09:44:16 wawel kernel: [127079.730172] BTRFS info (device sda2): 
found 609 extents
Dec 26 09:44:51 wawel kernel: [127114.373682] BTRFS info (device sda2): 
found 609 extents
Dec 26 09:45:09 wawel kernel: [127132.516306] BTRFS info (device sda2): 
relocating block group 2770317869056 flags data
Dec 26 09:46:06 wawel kernel: [127189.531463] BTRFS info (device sda2): 
found 2162 extents
Dec 26 09:47:13 wawel kernel: [127256.870794] BTRFS info (device sda2): 
found 2162 extents
Dec 26 09:47:23 wawel kernel: [127266.335336] BTRFS info (device sda2): 
relocating block group 2768170385408 flags metadata|raid1
Dec 26 10:02:40 wawel kernel: [128183.204056] BTRFS info (device sda2): 
found 64344 extents
Dec 26 10:02:51 wawel kernel: [128194.752371] BTRFS info (device sda2): 
relocating block group 2766022901760 flags data
Dec 26 10:05:51 wawel kernel: [128374.372685] BTRFS info (device sda2): 
found 14657 extents
Dec 26 10:11:59 wawel kernel: [128742.106841] BTRFS info (device sda2): 
found 14657 extents
Dec 26 10:12:04 wawel kernel: [128747.164928] BTRFS info (device sda2): 
relocating block group 2762801676288 flags data
Dec 26 10:12:46 wawel kernel: [128789.843093] BTRFS info (device sda2): 
found 687 extents
Dec 26 10:13:37 wawel kernel: [128840.608651] BTRFS info (device sda2): 
found 687 extents
Dec 26 10:13:57 wawel kernel: [128860.515578] BTRFS info (device sda2): 
found 4 extents
Dec 26 10:14:04 wawel kernel: [128867.761205] BTRFS info (device sda2): 
relocating block group 2759580450816 flags data
Dec 26 10:14:48 wawel kernel: [128911.046501] BTRFS info (device sda2): 
found 2078 extents
Dec 26 10:23:54 wawel kernel: [129457.365421] BTRFS info (device sda2): 
found 2078 extents
Dec 26 10:24:17 wawel kernel: [129480.141652] BTRFS info (device sda2): 
relocating block group 2756359225344 flags data
Dec 26 10:25:06 wawel kernel: [129529.130468] BTRFS info (device sda2): 
found 1948 extents
Dec 26 10:37:54 wawel kernel: [130297.130706] BTRFS info (device sda2): 
found 1948 extents
Dec 26 10:38:07 wawel kernel: [130310.753097] BTRFS info (device sda2): 
relocating block group 2753137999872 flags data
Dec 26 10:39:52 wawel kernel: [130415.674175] BTRFS info (device sda2): 
found 658 extents
Dec 26 10:43:24 wawel kernel: [130627.255410] BTRFS info (device sda2): 
found 658 extents
Dec 26 10:43:42 wawel kernel: [130645.434399] BTRFS info (device sda2): 
found 42 extents
Dec 26 10:43:53 wawel kernel: [130656.815802] BTRFS info (device sda2): 
found 42 extents
Dec 26 10:44:05 wawel kernel: [130668.284526] BTRFS info (device sda2): 
relocating block group 2749916774400 flags data
Dec 26 10:45:37 wawel kernel: [130760.519557] BTRFS info (device sda2): 
found 7795 extents
Dec 26 11:24:02 wawel kernel: [133065.590359] BTRFS info (device sda2): 
found 7795 extents
Dec 26 11:24:49 wawel kernel: [133112.551574] BTRFS info (device sda2): 
relocating block group 2746695548928 flags data
Dec 26 11:25:21 wawel kernel: [133144.523206] BTRFS info (device sda2): 
found 67 extents
Dec 26 11:26:23 wawel kernel: [133206.718874] BTRFS info (device sda2): 
found 67 extents
Dec 26 11:26:34 wawel kernel: [133217.364169] BTRFS info (device sda2): 
relocating block group 2743474323456 flags data
Dec 26 11:27:09 wawel kernel: [133252.030493] BTRFS info (device sda2): 
found 154 extents
Dec 26 11:28:37 wawel kernel: [133340.658370] BTRFS info (device sda2): 
found 154 extents
Dec 26 11:28:48 wawel kernel: [133350.928232] BTRFS info (device sda2): 
relocating block group 2740253097984 flags data
Dec 26 11:29:31 wawel kernel: [133394.349923] BTRFS info (device sda2): 
found 3377 extents
Dec 26 11:50:07 wawel kernel: [134630.385264] BTRFS info (device sda2): 
found 3377 extents
Dec 26 11:50:40 wawel kernel: [134663.264144] BTRFS info (device sda2): 
relocating block group 2737031872512 flags data
Dec 26 11:51:31 wawel kernel: [134714.239962] BTRFS info (device sda2): 
found 244 extents
Dec 26 11:54:06 wawel kernel: [134869.320437] BTRFS info (device sda2): 
found 244 extents
Dec 26 11:54:28 wawel kernel: [134891.019946] BTRFS info (device sda2): 
relocating block group 2733810647040 flags data
Dec 26 11:54:57 wawel kernel: [134920.370189] BTRFS info (device sda2): 
found 560 extents
Dec 26 11:57:30 wawel kernel: [135073.351351] BTRFS info (device sda2): 
found 560 extents
Dec 26 11:57:53 wawel kernel: [135096.801125] BTRFS info (device sda2): 
relocating block group 2730589421568 flags data
Dec 26 11:58:26 wawel kernel: [135129.186591] BTRFS info (device sda2): 
found 243 extents
Dec 26 12:00:28 wawel kernel: [135251.901624] BTRFS info (device sda2): 
found 243 extents
Dec 26 12:01:18 wawel kernel: [135301.341113] BTRFS info (device sda2): 
relocating block group 2727368196096 flags data
Dec 26 12:02:58 wawel kernel: [135401.616231] BTRFS info (device sda2): 
found 7966 extents
Dec 26 12:35:08 wawel kernel: [137331.224676] BTRFS info (device sda2): 
found 7966 extents
Dec 26 12:35:25 wawel kernel: [137348.767051] BTRFS info (device sda2): 
relocating block group 2724146970624 flags data
Dec 26 12:36:18 wawel kernel: [137401.253589] BTRFS info (device sda2): 
found 6267 extents
Dec 26 13:00:55 wawel kernel: [138878.357733] BTRFS info (device sda2): 
found 6267 extents
Dec 26 13:01:11 wawel kernel: [138893.979362] BTRFS info (device sda2): 
relocating block group 2720925745152 flags data
Dec 26 13:02:56 wawel kernel: [138999.875074] BTRFS info (device sda2): 
found 9154 extents
Dec 26 13:29:38 wawel kernel: [140601.538362] BTRFS info (device sda2): 
found 9154 extents
Dec 26 13:30:08 wawel kernel: [140631.396198] BTRFS info (device sda2): 
relocating block group 2717704519680 flags data
Dec 26 13:31:04 wawel kernel: [140687.543046] BTRFS info (device sda2): 
found 7404 extents
Dec 26 13:54:06 wawel kernel: [142069.542451] BTRFS info (device sda2): 
found 7404 extents
Dec 26 13:54:36 wawel kernel: [142099.763738] BTRFS info (device sda2): 
relocating block group 2714483294208 flags data
Dec 26 13:56:01 wawel kernel: [142184.270785] BTRFS info (device sda2): 
found 5820 extents
Dec 26 14:23:00 wawel kernel: [143803.389716] BTRFS info (device sda2): 
found 5820 extents
Dec 26 14:23:05 wawel kernel: [143808.503120] BTRFS info (device sda2): 
relocating block group 2711262068736 flags data
Dec 26 14:25:19 wawel kernel: [143942.663324] BTRFS info (device sda2): 
found 8754 extents


