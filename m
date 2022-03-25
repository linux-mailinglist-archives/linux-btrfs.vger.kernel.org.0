Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C744E6F50
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 09:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbiCYINr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiCYINr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 04:13:47 -0400
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 01:12:13 PDT
Received: from mx4.ncf.ca (mx4.ncf.ca [172.83.172.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D87CC521
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 01:12:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx4.ncf.ca (Postfix) with ESMTP id C68281117C
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 04:06:25 -0400 (EDT)
X-Virus-Scanned: Ubuntu amavisd-new at 
Received: from mx4.ncf.ca ([IPv6:::1])
        by localhost (mx4.ncf.ca [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id JXd8vab8H-qS for <linux-btrfs@vger.kernel.org>;
        Fri, 25 Mar 2022 04:06:24 -0400 (EDT)
Received: from mail.ncf.ca (mail.ncf.ca [172.83.172.45])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx4.ncf.ca (Postfix) with ESMTPS id 5C45C1117B
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 04:06:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.ncf.ca 5C45C1117B
Received: from [192.168.1.124] (23-233-31-135.cpe.pppoe.ca [23.233.31.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: fq600)
        by mail.ncf.ca (Postfix) with ESMTPSA id B600E94FE0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 00:44:34 -0400 (EDT)
Message-ID: <29f7e1cb-7882-ee15-2c19-01d5c43ce363@freenet.carleton.ca>
Date:   Fri, 25 Mar 2022 04:44:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     linux-btrfs@vger.kernel.org
Content-Language: en-CA
From:   peter brown <brown@freenet.carleton.ca>
Subject: btrfs: raid1C3 and raid1C4 fails to go ro when all but 1 drive
 removed.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

  If I set up raid1C3 or raid1C4 and pull drives to simulate a drive failure the 
fs does not go readonly.

  If I perform the same test on a raid1 setup the fs goes readonly when the 
second last drive is removed. Ie when the fs can no longer maintain a two copy 
mirror.



kernel 5.16.17-gentoo
btrfs-progs v5.16.2

short version of the logs...

test1 ~ # mkfs.btrfs -f -L test -d raid1C3 -m raid1C3  /dev/sdb /dev/sdc 
/dev/sde /dev/sdf
test1 ~ # mount -t btrfs -o noatime /dev/sdb /mnt/btrfs/



RAID1C3
pull drive 1 (3 left)
pull drive 2 (2 left)

Pulling drive 2 should trigger a ro fs. Ie we no longer support 3 copies.
[ 1098.411396] BTRFS error (device sdb): bdev /dev/sdb errs: wr 0, rd 0, flush 
1, corrupt 0, gen 0
[ 1098.430918] BTRFS warning (device sdb): lost page write due to IO error on 
/dev/sdb (-5)
[ 1098.430923] BTRFS error (device sdb): bdev /dev/sdb errs: wr 1, rd 0, flush 
1, corrupt 0, gen 0
[ 1098.430936] BTRFS warning (device sdb): lost page write due to IO error on 
/dev/sdb (-5)
[ 1098.430939] BTRFS error (device sdb): bdev /dev/sdb errs: wr 2, rd 0, flush 
1, corrupt 0, gen 0
[ 1098.430949] BTRFS warning (device sdb): lost page write due to IO error on 
/dev/sdb (-5)
[ 1098.430952] BTRFS error (device sdb): bdev /dev/sdb errs: wr 3, rd 0, flush 
1, corrupt 0, gen 0
[ 1098.431101] BTRFS error (device sdb): error writing primary super block to 
device 1
[ 1111.722182] ata6: SATA link down (SStatus 0 SControl 300)
[ 1117.150299] ata6: SATA link down (SStatus 0 SControl 300)
[ 1122.782299] ata6: SATA link down (SStatus 0 SControl 300)
[ 1122.782308] ata6.00: disabled
[ 1122.782324] ata6.00: detaching (SCSI 5:0:0:0)
[ 1122.792186] sd 5:0:0:0: [sdf] Synchronizing SCSI cache
[ 1122.792218] sd 5:0:0:0: [sdf] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 1122.792222] sd 5:0:0:0: [sdf] Stopping disk
[ 1122.792231] sd 5:0:0:0: [sdf] Start/Stop Unit failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

  btrfs device usage /mnt/btrfs/
/dev/sdb, ID: 1
    Device size:               0.00B   <---------
    Device slack:              0.00B
    Data,RAID1C3:            3.00GiB
    Unallocated:           462.76GiB

/dev/sdc, ID: 2
    Device size:             1.82TiB
    Device slack:              0.00B
    Data,RAID1C3:            4.00GiB
    Metadata,RAID1C3:        1.00GiB
    System,RAID1C3:          8.00MiB
    Unallocated:             1.81TiB

/dev/sde, ID: 3
    Device size:           465.76GiB
    Device slack:              0.00B
    Data,RAID1C3:            3.00GiB
    Metadata,RAID1C3:        1.00GiB
    System,RAID1C3:          8.00MiB
    Unallocated:           461.75GiB

/dev/sdf, ID: 4
    Device size:               0.00B <--------
    Device slack:              0.00B
    Data,RAID1C3:            2.00GiB
    Metadata,RAID1C3:        1.00GiB
    System,RAID1C3:          8.00MiB
    Unallocated:           462.75GiB



I can read the fs.

Writing should trigger a ro fs.

touch k
[ 1381.545803] BTRFS error (device sdb): bdev /dev/sdf errs: wr 1, rd 0, flush 
0, corrupt 0, gen 0
[ 1381.546043] BTRFS error (device sdb): bdev /dev/sdf errs: wr 2, rd 0, flush 
0, corrupt 0, gen 0
[ 1381.546186] BTRFS error (device sdb): bdev /dev/sdf errs: wr 3, rd 0, flush 
0, corrupt 0, gen 0
[ 1381.547239] BTRFS error (device sdb): bdev /dev/sdb errs: wr 3, rd 0, flush 
2, corrupt 0, gen 0
[ 1381.572225] BTRFS error (device sdb): bdev /dev/sdf errs: wr 3, rd 0, flush 
1, corrupt 0, gen 0
[ 1381.572244] BTRFS warning (device sdb): lost page write due to IO error on 
/dev/sdb (-5)
[ 1381.572247] BTRFS error (device sdb): bdev /dev/sdb errs: wr 4, rd 0, flush 
2, corrupt 0, gen 0
[ 1381.572257] BTRFS warning (device sdb): lost page write due to IO error on 
/dev/sdb (-5)
[ 1381.572260] BTRFS error (device sdb): bdev /dev/sdb errs: wr 5, rd 0, flush 
2, corrupt 0, gen 0
[ 1381.572270] BTRFS warning (device sdb): lost page write due to IO error on 
/dev/sdb (-5)
[ 1381.572272] BTRFS error (device sdb): bdev /dev/sdb errs: wr 6, rd 0, flush 
2, corrupt 0, gen 0
[ 1381.572376] BTRFS warning (device sdb): lost page write due to IO error on 
/dev/sdf (-5)
[ 1381.572380] BTRFS error (device sdb): bdev /dev/sdf errs: wr 4, rd 0, flush 
1, corrupt 0, gen 0
[ 1381.572392] BTRFS warning (device sdb): lost page write due to IO error on 
/dev/sdf (-5)
[ 1381.572410] BTRFS error (device sdb): bdev /dev/sdf errs: wr 5, rd 0, flush 
1, corrupt 0, gen 0
[ 1381.572423] BTRFS warning (device sdb): lost page write due to IO error on 
/dev/sdf (-5)
[ 1381.572427] BTRFS error (device sdb): error writing primary super block to 
device 1
[ 1381.613884] BTRFS error (device sdb): error writing primary super block to 
device 4

write was sucessful



pulling drive 3  we no longer can support 2 copies.. just 1

[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 1, 
rd 0, flush 0, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 2, 
rd 0, flush 0, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 3, 
rd 0, flush 0, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 4, 
rd 0, flush 0, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sdb errs: wr 3, 
rd 0, flush 2, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 4, 
rd 0, flush 1, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sdb (-5)
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sdb errs: wr 4, 
rd 0, flush 2, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sdb (-5)
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sdb errs: wr 5, 
rd 0, flush 2, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sdb (-5)
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sdb errs: wr 6, 
rd 0, flush 2, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sde (-5)
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 5, 
rd 0, flush 1, corrupt 0, gen 0
[Thu Mar 24 23:27:28 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sde (-5)
[Thu Mar 24 23:27:28 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sde (-5)
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): error writing primary super 
block to device 1
[Thu Mar 24 23:27:28 2022] BTRFS error (device sdb): error writing primary super 
block to device 3
[Thu Mar 24 23:28:28 2022] ata6: SATA link down (SStatus 0 SControl 300)
[Thu Mar 24 23:28:33 2022] ata6: SATA link down (SStatus 0 SControl 300)
[Thu Mar 24 23:28:39 2022] ata6: SATA link down (SStatus 0 SControl 300)
[Thu Mar 24 23:28:39 2022] ata6.00: disabled
[Thu Mar 24 23:28:39 2022] ata6.00: detaching (SCSI 5:0:0:0)
[Thu Mar 24 23:28:39 2022] sd 5:0:0:0: [sdf] Synchronizing SCSI cache
[Thu Mar 24 23:28:39 2022] sd 5:0:0:0: [sdf] Synchronize Cache(10) failed: 
Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[Thu Mar 24 23:28:39 2022] sd 5:0:0:0: [sdf] Stopping disk
[Thu Mar 24 23:28:39 2022] sd 5:0:0:0: [sdf] Start/Stop Unit failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

btrfs device usage /mnt/btrfs/
/dev/sdb, ID: 1
    Device size:               0.00B  <-----------
    Device slack:              0.00B
    Data,RAID1C3:            3.00GiB
    Unallocated:           462.76GiB

/dev/sdc, ID: 2
    Device size:             1.82TiB
    Device slack:              0.00B
    Data,RAID1C3:            4.00GiB
    Metadata,RAID1C3:        1.00GiB
    System,RAID1C3:          8.00MiB
    Unallocated:             1.81TiB

/dev/sde, ID: 3
    Device size:               0.00B  <-----------
    Device slack:              0.00B
    Data,RAID1C3:            3.00GiB
    Metadata,RAID1C3:        1.00GiB
    System,RAID1C3:          8.00MiB
    Unallocated:           461.75GiB

/dev/sdf, ID: 4
    Device size:               0.00B  <-----------
    Device slack:              0.00B
    Data,RAID1C3:            2.00GiB
    Metadata,RAID1C3:        1.00GiB
    System,RAID1C3:          8.00MiB
    Unallocated:           462.75GiB



read from fs
find .
no errors and no logs

The fs should go ro when we write the the drive in this state.

write to fs
touch 3
no errors ---  dmesg logs.
[Thu Mar 24 23:31:34 2022] btrfs_dev_stat_print_on_error: 2 callbacks suppressed
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 8, 
rd 0, flush 1, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdf errs: wr 1, 
rd 0, flush 0, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 9, 
rd 0, flush 1, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdf errs: wr 2, 
rd 0, flush 0, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 10, 
rd 0, flush 1, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdf errs: wr 3, 
rd 0, flush 0, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdb errs: wr 6, 
rd 0, flush 3, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 10, 
rd 0, flush 2, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdf errs: wr 3, 
rd 0, flush 1, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sdb (-5)
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdb errs: wr 7, 
rd 0, flush 3, corrupt 0, gen 0
[Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sdb (-5)
[Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sdb (-5)
[Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sde (-5)
[Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sde (-5)
[Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sde (-5)
[Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sdf (-5)
[Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sdf (-5)
[Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write due to IO 
error on /dev/sdf (-5)
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): error writing primary super 
block to device 1
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): error writing primary super 
block to device 3
[Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): error writing primary super 
block to device 4

There is no going ro log and the write should fail.

raid1C4 is the same thing. As 4 copies are required it should do ro when
the first drive is pulled.


If I configure as raid1

mkfs.btrfs -f -L test -d raid1 -m raid1  /dev/sdb /dev/sdc /dev/sde /dev/sdf
mount -t btrfs -o noatime /dev/sdb /mnt/btrfs/

when I get to pulling the 3rd drive the fs goes ro when I try and write to it. 
As it should

[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 1, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sdf errs: wr 1, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 2, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sdf errs: wr 2, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 3, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sdf errs: wr 3, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 4, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sdf errs: wr 4, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sde errs: wr 5, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS error (device sdb): bdev /dev/sdf errs: wr 5, 
rd 0, flush 0, corrupt 0, gen 0
[Fri Mar 25 00:05:55 2022] BTRFS: error (device sdb) in 
btrfs_commit_transaction:2437: errno=-5 IO failure (Error while writing out 
transaction)
[Fri Mar 25 00:05:55 2022] BTRFS info (device sdb): forced readonly
[Fri Mar 25 00:05:55 2022] BTRFS warning (device sdb): Skipping commit of 
aborted transaction.
[Fri Mar 25 00:05:55 2022] BTRFS: error (device sdb) in 
cleanup_transaction:2010: errno=-5 IO failure
[Fri Mar 25 00:06:01 2022] btrfs_dev_stat_print_on_error: 4 callbacks suppressed
[Fri Mar 25 00:06:01 2022] BTRFS error (device sdb): bdev /dev/sdb errs: wr 4, 
rd 0, flush 1, corrupt 0, gen 0

  Am I missing something here?








