Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF41BA7F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgD0P3p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 11:29:45 -0400
Received: from forward106j.mail.yandex.net ([5.45.198.249]:60605 "EHLO
        forward106j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbgD0P3p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 11:29:45 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2020 11:29:43 EDT
Received: from mxback26g.mail.yandex.net (mxback26g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:325])
        by forward106j.mail.yandex.net (Yandex) with ESMTP id 730E811A1485
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Apr 2020 18:23:20 +0300 (MSK)
Received: from sas2-ee0cb368bd51.qloud-c.yandex.net (sas2-ee0cb368bd51.qloud-c.yandex.net [2a02:6b8:c08:b7a3:0:640:ee0c:b368])
        by mxback26g.mail.yandex.net (mxback/Yandex) with ESMTP id DgyRMG2ah5-NK1uv3o6;
        Mon, 27 Apr 2020 18:23:20 +0300
Received: by sas2-ee0cb368bd51.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 6dKmvG3zED-NJ2OH2vg;
        Mon, 27 Apr 2020 18:23:19 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Michal Soltys <msoltyspl@yandex.pl>
Subject: many csum warning/errors on qemu guests using btrfs
To:     linux-btrfs@vger.kernel.org
Message-ID: <0ee3844d-830f-9f29-2cd5-61e3c9744979@yandex.pl>
Date:   Mon, 27 Apr 2020 17:23:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a guest machine (more about host it's running on later) with current debian buster running on debian's 5.4.0-0.bpo.4-amd64 kernel
(so from what I can see, 5.4.19 + whatever stuff debian did with it).

This machine is essentially nexus3 using btrfs for its storage needs, using snapshotting to ease backup tasks - so basically we prepare nexus to have its data in coherent state, make a ro snapshot of the subvolume with its data, then make backup from that to another subvolume.

The guest is running in qemu, using lvm thin pool as its storage - and journaled mdraid (raid5 physical disks, raid1 journal on ssds) as physical volumes. There are quite a few other virtual machines using this thin pool for - so far - over a year, with no apparent corruption or other issues.

More detailed stack description:

1) guest

debian buster, 5.4.0-0.bpo.4-amd64
☠ btrfs subvolume list /storage
ID 258 gen 62951 top level 5 path nexus-backup
ID 2624 gen 62969 top level 5 path nexus-data
ID 7418 gen 61532 top level 5 path nexus-data-snapshot

2) host

debian buster, 5.2.0-0.bpo.3-amd64
qemu 3.1.0 (3.1+dfsg-8+deb10u2)

the guest in question is using: cache=none, io=native, discards passed down, virtio-scsi with 1 iothread

3) storage

lvm thin-pool using mirrored ssds for metadata, raid5 on md for data (with journal on md raid1 consisting of two ssds)

the disks are behind:
24 disk backplane, connected via:
mpt2sas_cm0: Current Controller Queue Depth(8056),Max Controller Queue Depth(8192)
mpt2sas_cm0: Scatter Gather Elements per IO(128)
mpt2sas_cm0: LSISAS2308: FWVersion(20.00.07.00), ChipRevision(0x05), BiosVersion(07.39.02.00)
The lsi controller is in "IT" mode.

I can of course provide whatever more details are needed (mdadm, lvs, etc.)

Anyway we noticed rather worrysome amount of csum warnings. First a few files from actual production data (we have 13 files pinpointed by btrfs scrub):

Apr 24 16:12:04 nexus3 kernel: BTRFS warning (device sdb1): checksum error at logical 1116939354112 on dev /dev/sdb1, physical 528537223168, root 2624, inode 2019088, offset 4788224, length 4096, links 1 (path: blobs/touk_hosted/content/vol-04/chap-02/b52ea3b8-d072-4088-9bbc-6bbc279a06dc.bytes)
Apr 24 16:17:12 nexus3 kernel: BTRFS warning (device sdb1): checksum error at logical 1206004457472 on dev /dev/sdb1, physical 624044777472, root 2624, inode 2053325, offset 38678528, length 4096, links 1 (path: blobs/touk_hosted/content/vol-11/chap-09/9b6e7c7d-96f1-4b77-81a8-1d3a1b8d5053.bytes)
Apr 24 16:38:45 nexus3 kernel: BTRFS warning (device sdb1): checksum error at logical 1653594550272 on dev /dev/sdb1, physical 1072708612096, root 2624, inode 4764888, offset 1732608, length 4096, links 1 (path: blobs/touk_hosted/content/vol-02/chap-33/a64e7204-922a-46d5-b907-ba7cadfdcc92.bytes)
Apr 24 16:42:23 nexus3 kernel: BTRFS warning (device sdb1): checksum error at logical 1720708112384 on dev /dev/sdb1, physical 1141969657856, root 2624, inode 8460204, offset 77910016, length 4096, links 1 (path: blobs/touk_hosted/content/vol-07/chap-12/b01daa03-8345-440a-8830-07aebc6b03fc.bytes)

In this case, each of the files is either zip or jar. In case of zip files, unzip verifies everything correctly until the 4kb block.

But when we were doing fresh backup recently (as outlined above - from snapshotted ro subvolume to another subvolume):

Apr 27 13:31:45 nexus3 kernel: BTRFS warning (device sdb1): checksum error at logical 1731807096832 on dev /dev/sdb1, physical 1154142384128, root 258, inode 285, offset 3560243200, length 4096, links 1 (path: nexus3_blob_store_backup-touk_hosted-full-2020-04-25_01-00.tar)
Apr 27 13:32:00 nexus3 kernel: BTRFS warning (device sdb1): checksum error at logical 1735887626240 on dev /dev/sdb1, physical 1158222913536, root 258, inode 285, offset 7288856576, length 4096, links 1 (path: nexus3_blob_store_backup-touk_hosted-full-2020-04-25_01-00.tar)
Apr 27 13:32:08 nexus3 kernel: BTRFS warning (device sdb1): checksum error at logical 1738657308672 on dev /dev/sdb1, physical 1160992595968, root 258, inode 285, offset 9750835200, length 4096, links 1 (path: nexus3_blob_store_backup-touk_hosted-full-2020-04-25_01-00.tar)
Apr 27 13:33:44 nexus3 kernel: BTRFS warning (device sdb1): checksum error at logical 1761327661056 on dev /dev/sdb1, physical 1184736690176, root 258, inode 285, offset 29991952384, length 4096, links 1 (path: nexus3_blob_store_backup-touk_hosted-full-2020-04-25_01-00.tar)
Apr 27 13:34:29 nexus3 kernel: BTRFS warning (device sdb1): checksum error at logical 1774246481920 on dev /dev/sdb1, physical 1197655511040, root 258, inode 285, offset 41648664576, length 4096, links 1 (path: nexus3_blob_store_backup-touk_hosted-full-2020-04-25_01-00.tar)

(and many more - over 180 total)

At this point we're somewhat perplexed as to what is going on. This level of errors would nearly for sure cause visible issues with other virtual machines using this lvm pool. While it's possible we have corruptions creeping under without even realizing it, but after all this time we would have likely noticed something going on on other guests ... but:

On this host, there is one other machine with btrfs as its main filesystem (this one on arch, with kernel 5.3.8-arch1-1), I did quick test just a moment ago there and scrubbed it afterwards:

dd if=/dev/zero of=/atest bs=262144 count=$((16*4096))

[3802380.689492] BTRFS info (device sda3): scrub: started on devid 1
[3802448.842611] BTRFS warning (device sda3): checksum error at logical 20659965952 on dev /dev/sda3, physical 21708541952, root 5, inode 6665778, offset 9469747200, length 4096, links 1 (path: atest)
[3802448.843220] BTRFS error (device sda3): bdev /dev/sda3 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
[3802448.844983] BTRFS error (device sda3): unable to fixup (regular) error at logical 20659965952 on dev /dev/sda3
....

Afterwards I did repeat the above *directly on the host machine*, creating 16gib files (with dcfldd, so not 0s anymore) for half an hour, on same thin-pool using freshly made btrfs - no issues observed after btrfs scrubs. This might imply that the friction is somewhere around qemu (qemu version ? machine options ? virtio-scsi ? kernel ?). I did check ECC state of memory, but as far as edac-util is concered, no issues here either.

Were there any bugs around those kernel versions (5.2+ ?) related to btrfs / checksums or btrfs living in qemu (or perhaps that particular qemu version) ? Any suggestion how to pinpoint the issue ?
