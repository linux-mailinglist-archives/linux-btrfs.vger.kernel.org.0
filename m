Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C34113658
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 21:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfLDUVp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 15:21:45 -0500
Received: from [185.35.77.55] ([185.35.77.55]:35365 "EHLO mail.megacandy.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbfLDUVp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Dec 2019 15:21:45 -0500
Received: from [192.168.10.160] (26.51-174-238.customer.lyse.net [51.174.238.26])
        (Authenticated sender: gardv@megacandy.net)
        by mail.megacandy.net (Postfix) with ESMTPSA id 7280442BD04
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2019 20:21:41 +0000 (GMT)
From:   Gard Vaaler <gardv@megacandy.net>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_9483B920-3C4C-4544-BFE4-BF8BB3D820CA"
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Unrecoverable corruption after loss of cache
Date:   Wed, 4 Dec 2019 21:21:40 +0100
In-Reply-To: <CAJCQCtRA2+X-ke4yJ4H8o49ZA9mSOFabLpNeXd=4ULDg99rFgQ@mail.gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net>
 <F7C74BD8-4505-4E74-81F2-EB0D603ABCEC@megacandy.net>
 <CAJCQCtRA2+X-ke4yJ4H8o49ZA9mSOFabLpNeXd=4ULDg99rFgQ@mail.gmail.com>
Message-Id: <C9B1933C-7F87-40D2-82F2-9D668450C01A@megacandy.net>
X-Mailer: Apple Mail (2.3601.0.10)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Apple-Mail=_9483B920-3C4C-4544-BFE4-BF8BB3D820CA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> 4. des. 2019 kl. 20:08 skrev Chris Murphy <lists@colorremedies.com>:
> Why do you think it's complaining about the journal? I'm not seeing
> tree log related messages here.

Thanks for the reply! That must be a misunderstanding on my part (it's =
called "transid", which suggested something in the journal to me).

> Is the output provided complete or are
> there additional messages?

No, that's it.

> What do you get for:
>=20
> btrfs insp dump-s /dev/X

Attached.

--Apple-Mail=_9483B920-3C4C-4544-BFE4-BF8BB3D820CA
Content-Disposition: attachment;
	filename=btrfs-insp-dump
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="btrfs-insp-dump"
Content-Transfer-Encoding: 7bit

[liveuser@localhost-live btrfs-progs-5.4]$ sudo ./btrfs insp dump-s /dev/bcache0superblock: bytenr=65536, device=/dev/bcache0
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xdaa8bba5 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			8c4a9e0d-bfe9-4b8f-be8f-1899c58b00b3
metadata_uuid		8c4a9e0d-bfe9-4b8f-be8f-1899c58b00b3
label			
generation		319148
root			2529691058176
sys_array_size		129
chunk_root_generation	298799
root_level		1
chunk_root		2534052790272
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		6000110088192
bytes_used		3739095216128
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		2
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	319148
uuid_tree_generation	13
dev_item.uuid		7215ede5-5997-47c2-96e3-4b43f67f1eb6
dev_item.fsid		8c4a9e0d-bfe9-4b8f-be8f-1899c58b00b3 [match]
dev_item.type		0
dev_item.total_bytes	2000398925824
dev_item.bytes_used	1515066556416
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		2
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0

[liveuser@localhost-live btrfs-progs-5.4]$ sudo ./btrfs insp dump-s /dev/bcache1
superblock: bytenr=65536, device=/dev/bcache1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xf1f043cd [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			8c4a9e0d-bfe9-4b8f-be8f-1899c58b00b3
metadata_uuid		8c4a9e0d-bfe9-4b8f-be8f-1899c58b00b3
label			
generation		319148
root			2529691058176
sys_array_size		129
chunk_root_generation	298799
root_level		1
chunk_root		2534052790272
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		6000110088192
bytes_used		3739095216128
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		2
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	319148
uuid_tree_generation	13
dev_item.uuid		6f60e735-3829-4223-aa13-dbb377fa28ff
dev_item.fsid		8c4a9e0d-bfe9-4b8f-be8f-1899c58b00b3 [match]
dev_item.type		0
dev_item.total_bytes	3999711162368
dev_item.bytes_used	3407004565504
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0

--Apple-Mail=_9483B920-3C4C-4544-BFE4-BF8BB3D820CA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> What kernel version was being used at the time of the first problem =
instance?

Fedora's 5.2.8-300 kernel.

> The transid messages above suggest some kind of failure to actually
> commit what should have ended up on stable media. Also please provide:
>=20
> btrfs-find-root /dev/

Attached (compressed).

--Apple-Mail=_9483B920-3C4C-4544-BFE4-BF8BB3D820CA
Content-Disposition: attachment;
	filename=btrfs-find-root.xz
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="btrfs-find-root.xz"
Content-Transfer-Encoding: base64

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
WVo=
--Apple-Mail=_9483B920-3C4C-4544-BFE4-BF8BB3D820CA
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



> btrfs check --mode=lowmem /dev/

Attached.

--Apple-Mail=_9483B920-3C4C-4544-BFE4-BF8BB3D820CA
Content-Disposition: attachment;
	filename=btrfs-check
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="btrfs-check"
Content-Transfer-Encoding: 7bit

[liveuser@localhost-live btrfs-progs-5.4]c$ sudo ./btrfs check --mode=lowmem /dev/bcache0 
Opening filesystem to check...
parent transid verify failed on 2529691090944 wanted 319147 found 314912
parent transid verify failed on 2529691090944 wanted 319147 found 310171
parent transid verify failed on 2529691090944 wanted 319147 found 314912
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=2529690976256 item=0 parent level=2 child level=0
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system

[liveuser@localhost-live btrfs-progs-5.4]$ sudo ./btrfs check --mode=lowmem /dev/bcache1
Opening filesystem to check...
parent transid verify failed on 2529691090944 wanted 319147 found 314912
parent transid verify failed on 2529691090944 wanted 319147 found 310171
parent transid verify failed on 2529691090944 wanted 319147 found 314912
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=2529690976256 item=0 parent level=2 child level=0
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system


--Apple-Mail=_9483B920-3C4C-4544-BFE4-BF8BB3D820CA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> The latter will take a while and since it is an offline check will
> need to be done in initramfs, or better from Live media which will
> make it easier to capture the output. I recommend btrfs-progs not
> older than 5.1.1 if possible. It is only for check, not with --repair,
> so the version matters somewhat less if it's not too old.

As you can see, it terminates almost immediately with an IO error. =
However, there's no error in the dmesg on the underlying device, which =
makes me think there's a bad bounds check or something similar.

--=20
Gard


--Apple-Mail=_9483B920-3C4C-4544-BFE4-BF8BB3D820CA--
