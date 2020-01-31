Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8124B14F0A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgAaQfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 11:35:55 -0500
Received: from ms11p00im-qufo17282101.me.com ([17.58.38.58]:38734 "EHLO
        ms11p00im-qufo17282101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgAaQfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 11:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1580488551;
        bh=+qTRKNWt/67ZFAA4cb+sGTl/aMq4XiIHFQdX7VmkTH4=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=iKFteHVuVOZ0hza1cPSSsm6FUaGzD4UWDDOf3ddQm6mo4gLQvJiZW3qPQsUtOosTx
         copz6cLHdo1mF19gJ3O0dgRm/+zsoqknTmXXgBu8Pgz5rXYfhxQZ/muJE9FBfKIh1S
         mJ6QNdbEmdbta0+nKfs4DIOkskNN5d14/uPpsUMt079ueZLvVDjtAfxYzMGycl5CAc
         mCJt+cUNqW8S87ju1XYe7VnLzOYi3qqRHxHE6TFcMHDB1LzHg2nb2x46BQaOeMqX2g
         ha5yRJ/Jnx+gCopYp8U40H1Rv6aiSg611O0H9X9FLASi6ggVAma/2+P5PA3zq5LmnH
         ORrZlx/swVoTA==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17282101.me.com (Postfix) with ESMTPSA id 657BC781069;
        Fri, 31 Jan 2020 16:35:50 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: btrfs not booting any more 
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtRyr17kdSdozU4_ZxJL_VdCWZe7DCCuUuz0cy2AiJs3=A@mail.gmail.com>
Date:   Fri, 31 Jan 2020 13:35:47 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <783F3013-0759-46A1-BAB4-49BB22D913CF@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com>
 <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com>
 <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
 <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com>
 <CAJCQCtROKcVBNuWkyF5kRgJMuQ4g4YSxh5GL6QmuAJL=A-JROw@mail.gmail.com>
 <25D1F99C-F34A-48D6-BF62-42225765FBC1@icloud.com>
 <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
 <86147601-37F0-49C0-B6F8-0F5245750450@icloud.com>
 <CAJCQCtRkZPq-k6pX3bCJmj25HY4eDdAEUcgLwGSh_Mi6VEqdiQ@mail.gmail.com>
 <5EFA3F48-29DA-4D02-BF14-803DBEEB6BB2@icloud.com>
 <CAJCQCtRyr17kdSdozU4_ZxJL_VdCWZe7DCCuUuz0cy2AiJs3=A@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001310137
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys,

I would need one more help from you before I can do that things by =
myself.

I have a different machine that runs windows and inside Vmware Fusion =
15.
Inside runs as well Suse 15.1.

The linux  operating system is on a 1TB virtual hard disk with following =
setup:


Disk /dev/sdb: 1000 GiB, 1073741824000 bytes, 2097152000 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 186C0CD6-F3B8-471C-B2AF-AE3D325EC215

Device          Start        End    Sectors   Size Type
/dev/sdb1        2048      18431      16384     8M BIOS boot
/dev/sdb2       18432 1920520191 1920501760 915.8G Linux filesystem
/dev/sdb3  2082992128 2097149951   14157824   6.8G Linux filesystem



The OS is on /dev/sdb2 but it does not boot any more (stays at =
grub_rescue).

What can I do now to repair it?




root@ubuntu:~# btrfs ins dump-tree -t root  /dev/sdb2
btrfs-progs v5.2.1=20
parent transid verify failed on 72980660224 wanted 652165 found 652163
parent transid verify failed on 72980660224 wanted 652165 found 652163
Ignoring transid failure
leaf parent key incorrect 72980660224
Couldn't setup extent tree
parent transid verify failed on 72980660224 wanted 652165 found 652163
Ignoring transid failure
leaf parent key incorrect 72980660224
Couldn't setup device tree
ERROR: unable to open /dev/sdb2
root@ubuntu:~# btrfs ins dump-s /dev/sdb2
superblock: bytenr=3D65536, device=3D/dev/sdb2
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xd35229e5 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			affdbdfa-7b54-4888-b6e9-951da79540a3
metadata_uuid		affdbdfa-7b54-4888-b6e9-951da79540a3
label		=09
generation		652165
root			72978268160
sys_array_size		97
chunk_root_generation	649961
root_level		1
chunk_root		1265374330880
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		983296901120
bytes_used		504341774336
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x163
			( MIXED_BACKREF |
			  DEFAULT_SUBVOL |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	652165
uuid_tree_generation	557352
dev_item.uuid		8968cd08-0c45-4aff-ab64-65f979b21694
dev_item.fsid		affdbdfa-7b54-4888-b6e9-951da79540a3 [match]
dev_item.type		0
dev_item.total_bytes	983296901120
dev_item.bytes_used	507877785600
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0




Where can I find default repair methods?

Thanks,

Chris


