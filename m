Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA76BBE58
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 00:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407693AbfIWWLw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 18:11:52 -0400
Received: from know-smtprelay-omd-9.server.virginmedia.net ([81.104.62.41]:59244
        "EHLO know-smtprelay-omd-9.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390688AbfIWWLw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 18:11:52 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id CWYeifJdoVaV8CWYeit1tI; Mon, 23 Sep 2019 23:11:49 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=PcnReBpd c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pOTRmfe1pl5FEBUjtEIA:9 a=2giLpwy7-SPO-fEY:21
 a=bujH5BNsQ7q_NwJk:21 a=QEXdDO2ut3YA:10
Subject: Re: Balance ENOSPC during balance despite additional storage added
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
 <CAJCQCtRAnJR+Z8Z8Bq91YXiMpfmwOiHK0tQ+9zAJvSVvexHnxg@mail.gmail.com>
 <54fa8ba3-0d02-7153-ce47-80f10732ef14@petezilla.co.uk>
 <CAJCQCtQLk1m8yAxPPDLVZBr3MehdDD3EpNZ6O_OCRsO-FFzRNw@mail.gmail.com>
 <eb9fdaee-ec76-5285-4384-7a615d3cd5c1@petezilla.co.uk>
 <00be81e2-bca2-3906-c27d-68f252a6ffe1@petezilla.co.uk>
 <CAJCQCtRbjz138p_DVX4=v0e38rtDFjpqrOhBTc4o7Mc=s_zcEw@mail.gmail.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <fe29580c-3239-f338-6a27-28739fbe7415@petezilla.co.uk>
Date:   Mon, 23 Sep 2019 23:10:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRbjz138p_DVX4=v0e38rtDFjpqrOhBTc4o7Mc=s_zcEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHdmzO6ncBOb0RP1FXzx8NFLqeW6alcbj9qmvHhhj2I3AtFJSeUpvjwOw5D+cFJGQLAzGnS/DNo5w+irLuPv6DJ/hzgmH5b9++nIbpp8ZBKwO4PhPyO2
 oFePDKLJcYdFGevhLflj5bDomYXERIe/0Tj9fbpvRVW8W09tDzudx1PGGxgM9M65BS/ycfpO8UJM3lx5t86jnCbHQQcpY81WeAA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/23/19 10:52 PM, Chris Murphy wrote:
> What features do you have set?
> 
> # btrfs insp dump-s /dev/
> 

root@phoenix:/var/lib/lxc# btrfs insp dump-s /dev/nvme0_vg/lxc
superblock: bytenr=65536, device=/dev/nvme0_vg/lxc
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xae110928 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    6b0245ec-bdd4-4076-b800-2243d466b174
metadata_uuid           6b0245ec-bdd4-4076-b800-2243d466b174
label                   LXC_BTRFS
generation              548017
root                    1957019598848
sys_array_size          97
chunk_root_generation   547983
root_level              1
chunk_root              1949798760448
chunk_root_level        0
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             354334801920
bytes_used              92528005120
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             2
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x161
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        548017
uuid_tree_generation    548017
dev_item.uuid           0766ea5f-6e0a-4946-a74c-aea3be78c087
dev_item.fsid           6b0245ec-bdd4-4076-b800-2243d466b174 [match]
dev_item.type           0
dev_item.total_bytes    268435456000
dev_item.bytes_used     100965285888
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

root@phoenix:/var/lib/lxc#

Just for good measure the device I added as a temporary measure to clear
enospc, I assume this would give the same result (but I am wrong, at
least in detail):

root@phoenix:/var/lib/lxc# btrfs insp dump-s /dev/nvme0_vg/tempdel
superblock: bytenr=65536, device=/dev/nvme0_vg/tempdel
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xb2dad359 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    6b0245ec-bdd4-4076-b800-2243d466b174
metadata_uuid           6b0245ec-bdd4-4076-b800-2243d466b174
label                   LXC_BTRFS
generation              548017
root                    1957019598848
sys_array_size          97
chunk_root_generation   547983
root_level              1
chunk_root              1949798760448
chunk_root_level        0
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             354334801920
bytes_used              92528005120
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             2
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x161
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        548017
uuid_tree_generation    548017
dev_item.uuid           85b9c239-83ab-486b-b84c-f5d4336f913d
dev_item.fsid           6b0245ec-bdd4-4076-b800-2243d466b174 [match]
dev_item.type           0
dev_item.total_bytes    85899345920
dev_item.bytes_used     0
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          2
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

root@phoenix:/var/lib/lxc#






