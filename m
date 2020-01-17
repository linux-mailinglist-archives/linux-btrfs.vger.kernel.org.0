Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F9A14059E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgAQItC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 03:49:02 -0500
Received: from p-impout003aa.msg.pkvw.co.charter.net ([47.43.26.134]:48673
        "EHLO p-impout001.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729121AbgAQItC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 03:49:02 -0500
Received: from static.bllue.org ([66.108.6.151])
        by cmsmtp with ESMTP
        id sNJLiHED2SkogsNJMipV2T; Fri, 17 Jan 2020 08:49:00 +0000
X-Authority-Analysis: v=2.3 cv=eKttc0h1 c=1 sm=1 tr=0
 a=M990Q3uoC/f4+l9HizUSNg==:117 a=M990Q3uoC/f4+l9HizUSNg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Jdjhy38mL1oA:10
 a=DASJQXl0GO5y55qBbFsA:9 a=QEXdDO2ut3YA:10
Received: from bllue.org (localhost.localdomain [127.0.0.1])
        by static.bllue.org (Postfix) with ESMTP id 63C70C1570;
        Fri, 17 Jan 2020 03:48:58 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 17 Jan 2020 03:48:58 -0500
From:   Kenneth Topp <toppk@bllue.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: write time tree block corruption detected
In-Reply-To: <381e8322-48dd-6885-23e6-16da38922086@gmx.com>
References: <5c4a4a6e021fcaf8f608c247a572e95b@bllue.org>
 <381e8322-48dd-6885-23e6-16da38922086@gmx.com>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <35d184624be3d8aac778a29d4f701606@bllue.org>
X-Sender: toppk@bllue.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.3
X-Spam-Checker-Version: SpamAssassin 3.4.3 (2019-12-06) on static.bllue.org
X-CMAE-Envelope: MS4wfHs4cPnsXGmsdzIUwXX3G1ObAzOIRndqf1kzXx18teftlmZGqYpomKvtxTtMxYBx5ZQnwBW6a0ESPfLvOKvgolfA+00FUiKzsB08SvDHlOHj7igV3eUK
 rnXumDIV+8xccnUCOyD+7AyY+pXPne8S7HdsTmaqnKBI1rZdDKw7rnLpGxbDjuelxvqJIQJxFM4zroVLF3K20DO/43wl33RnXhU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-01-17 03:33, Qu Wenruo wrote:
> On 2020/1/17 下午4:21, Kenneth Topp wrote:
>> I've been running 5.4.8 for 10 days and this popped up:
>> 
>> [917767.192190] BTRFS error (device dm-19): block=21374679056384 write
>> time tree block corruption detected
>> [917767.193436] BTRFS: error (device dm-19) in btrfs_sync_log:3104:
>> errno=-5 IO failure
>> [917767.193438] BTRFS info (device dm-19): forced readonly
> 
> You missed the most important line. One line before "write time tree
> block corruption detected" is the most important line.
> 

sorry, here is the missing line.

[917767.192187] BTRFS critical (device dm-19): corrupt leaf: 
root=18446744073709551610 block=21374679056384 slot=174 ino=219743 
file_offset=1385357312, file extent end range (1460178944) g
oes beyond start offset (1385385984) of the next file extent
[917767.192190] BTRFS error (device dm-19): block=21374679056384 write 
time tree block corruption detected
[917767.193436] BTRFS: error (device dm-19) in btrfs_sync_log:3104: 
errno=-5 IO failure
[917767.193438] BTRFS info (device dm-19): forced readonly

thanks for responding so quickly!

ken

>> 
>> 
>> This was a btrfs filesystem created on 5.4.8 with two 4kn drives, each
>> with a single whole disk dm-crypt partition.  The fs was created with
>> mkfs -O no-holes -d single -m raid1 and mounted with
>> clear_cache,space_cache=v2.
>> 
>> After that issue, I tried to update my backups, but it didn't go very 
>> well:
>> 
>> [918052.104923] BTRFS warning (device dm-19): dm-19 checksum verify
>> failed on 21374567694336 wanted 6c2341bd found 640f30e8 level 0
>> [918052.121801] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.121818] BTRFS info (device dm-19): no csum found for inode
>> 219677 start 3397271552
>> [918052.138406] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.139080] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.139094] BTRFS info (device dm-19): no csum found for inode
>> 219677 start 3397275648
>> [918052.139768] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.140158] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.140171] BTRFS info (device dm-19): no csum found for inode
>> 219677 start 3397279744
>> [918052.140532] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.140868] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.140880] BTRFS info (device dm-19): no csum found for inode
>> 219677 start 3397283840
>> [918052.159794] BTRFS warning (device dm-19): csum failed root 5 ino
>> 219677 off 3397271552 csum 0x33c9a639 expected csum 0x00000000 mirror 
>> 1
>> [918052.213959] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.216411] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.216418] BTRFS info (device dm-19): no csum found for inode
>> 219677 start 3397271552
>> [918052.216570] BTRFS warning (device dm-19): csum failed root 5 ino
>> 219677 off 3397271552 csum 0x33c9a639 expected csum 0x00000000 mirror 
>> 1
>> [918052.216790] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918052.217037] BTRFS info (device dm-19): no csum found for inode
>> 219677 start 3397271552
>> [918052.217165] BTRFS warning (device dm-19): csum failed root 5 ino
>> 219677 off 3397271552 csum 0x33c9a639 expected csum 0x00000000 mirror 
>> 1
>> [918062.496366] BTRFS warning (device dm-19): dm-19 checksum verify
>> failed on 20043100192768 wanted 8bf4c1c9 found 23b8dea8 level 0
>> [918062.504832] verify_parent_transid: 1 callbacks suppressed
>> [918062.504836] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100192768 wanted 45126 found 45104
>> [918062.504848] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 28672
>> [918062.506174] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100241920 wanted 45126 found 45104
>> [918062.509823] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 28672 csum 0xa0f9eaf7 expected csum 0x00000000 mirror 1
>> [918062.513826] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100241920 wanted 45126 found 45104
>> [918062.513838] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 49152
>> [918062.519723] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 49152 csum 0x76421bb0 expected csum 0x00000000 mirror 1
>> [918062.530287] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100192768 wanted 45126 found 45104
>> [918062.530866] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100192768 wanted 45126 found 45104
>> [918062.530874] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 65536
>> [918062.539238] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100192768 wanted 45126 found 45104
>> [918062.539560] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100192768 wanted 45126 found 45104
>> [918062.539566] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 69632
>> [918062.540020] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100192768 wanted 45126 found 45104
>> [918062.540261] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100192768 wanted 45126 found 45104
>> [918062.540269] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 77824
>> [918062.540965] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043100192768 wanted 45126 found 45104
>> [918062.541199] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 114688
>> [918062.541753] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 118784
>> [918062.544496] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 65536 csum 0xdcb45a27 expected csum 0x00000000 mirror 1
>> [918062.547421] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 114688 csum 0x1d5a0f30 expected csum 0x00000000 mirror 1
>> [918062.549968] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 69632 csum 0x24dd186c expected csum 0x00000000 mirror 1
>> [918062.572502] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 77824 csum 0xba341c47 expected csum 0x00000000 mirror 1
>> [918062.575300] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 118784 csum 0x519e7044 expected csum 0x00000000 mirror 1
>> [918062.584005] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 172032
>> [918062.586782] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 221184
>> [918062.587106] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 221184 csum 0xc9c50b2d expected csum 0x00000000 mirror 1
>> [918062.590739] BTRFS info (device dm-19): no csum found for inode
>> 5464098 start 450560
>> [918062.591255] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 450560 csum 0xd2e5e3eb expected csum 0x00000000 mirror 1
>> [918062.601361] BTRFS warning (device dm-19): dm-19 checksum verify
>> failed on 20043100258304 wanted 61da40d5 found 204cd10a level 0
>> [918062.602875] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5464098 off 503808 csum 0x183beedc expected csum 0x00000000 mirror 1
>> [918085.820716] verify_parent_transid: 42 callbacks suppressed
>> [918085.820730] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.837964] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.837992] __btrfs_lookup_bio_sums: 17 callbacks suppressed
>> [918085.837994] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 159711232
>> [918085.838459] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.838987] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.838995] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 159715328
>> [918085.839349] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.840054] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.840065] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 159719424
>> [918085.840402] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.840943] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.840951] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 159723520
>> [918085.850438] btrfs_print_data_csum_error: 17 callbacks suppressed
>> [918085.850442] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 159711232 csum 0x1e34dbf6 expected csum 0x00000000 mirror 
>> 1
>> [918085.959941] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.960447] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 21374567694336 wanted 45126 found 45104
>> [918085.960452] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 159711232
>> [918085.960624] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 159711232 csum 0x1e34dbf6 expected csum 0x00000000 mirror 
>> 1
>> [918085.961220] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 159711232
>> [918085.961341] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 159711232 csum 0x1e34dbf6 expected csum 0x00000000 mirror 
>> 1
>> [918087.026984] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 193855488
>> [918087.028152] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 193859584
>> [918087.028598] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 193863680
>> [918087.029005] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 193867776
>> [918087.042810] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 193855488 csum 0x86af03b1 expected csum 0x00000000 mirror 
>> 1
>> [918087.054812] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 193904640 csum 0x279aea06 expected csum 0x00000000 mirror 
>> 1
>> [918087.071004] BTRFS warning (device dm-19): dm-19 checksum verify
>> failed on 20043549310976 wanted fcc4f73a found 3d3d8e83 level 0
>> [918087.103303] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 193937408 csum 0x1fedc264 expected csum 0x00000000 mirror 
>> 1
>> [918087.118559] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 193986560 csum 0xc47dad65 expected csum 0x00000000 mirror 
>> 1
>> [918087.131234] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 193855488 csum 0x86af03b1 expected csum 0x00000000 mirror 
>> 1
>> [918087.132513] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 193855488 csum 0x86af03b1 expected csum 0x00000000 mirror 
>> 1
>> [918087.135749] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 193986560 csum 0xc47dad65 expected csum 0x00000000 mirror 
>> 1
>> [918119.990544] BTRFS warning (device dm-19): dm-19 checksum verify
>> failed on 20043135205376 wanted 79d70254 found 93ac2b61 level 0
>> [918120.010421] verify_parent_transid: 105 callbacks suppressed
>> [918120.010428] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043135205376 wanted 45126 found 45104
>> [918120.010565] __btrfs_lookup_bio_sums: 48 callbacks suppressed
>> [918120.010567] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 678543360
>> [918120.028733] btrfs_print_data_csum_error: 5 callbacks suppressed
>> [918120.028735] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 678543360 csum 0xcd3c1a5d expected csum 0x00000000 mirror 
>> 1
>> [918120.040591] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043135205376 wanted 45126 found 45104
>> [918120.041097] BTRFS error (device dm-19): parent transid verify 
>> failed
>> on 20043135205376 wanted 45126 found 45104
>> [918120.041112] BTRFS info (device dm-19): no csum found for inode
>> 5468073 start 678543360
>> [918120.041440] BTRFS warning (device dm-19): csum failed root 5 ino
>> 5468073 off 678543360 csum 0xcd3c1a5d expected csum 0x00000000 mirror 
>> 1
> 
> Since you haven't rebooted, all these mismatch can be caused by aborted
> transaction.
> 
>> 
>> 
>> Fortunately, after a reboot, everything appears healthy, no file
>> corruption that I can observe, but I'm still running some checks.
> 
> That's great, write time tree checker prevented corruption.
> 
> But still, btrfs check, and scrub recommended.
> 
> And the most important thing, please provide the missing key log line.
> 
> Thanks,
> Qu
> 
>> 
>> I'm not sure what the write tree is or if this is related to the read
>> tree issues mentioned on the mailing list, any advice/pointers would 
>> be
>> most appreciated.  One thing I can note is that I've started to write
>> heavily to this filesystem via nfs export (the nfs client happens to 
>> be
>> a vm on the same machine, fwiw).
>> 
