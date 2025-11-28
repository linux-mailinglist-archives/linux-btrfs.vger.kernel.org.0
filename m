Return-Path: <linux-btrfs+bounces-19392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DF6C91CD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 12:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BE08345948
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029CE30B52E;
	Fri, 28 Nov 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="kHK/abvG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FF17BA6
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764329777; cv=none; b=jPYQSKh49dBkJy6ErEJHFd4rUYP9k1+fwRR1OdcaSmQBCwb/XnJ2ACYbzkBjnHMaVhn51X5ziRLGExYo6eDPSDxUfbmhsSRER+s0iB4XApzqqD/SrVD43trrhxngoLCYRN75BC9UUbEcgo/Odo7D0U7J9XmwV20Aw82VC43t/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764329777; c=relaxed/simple;
	bh=ugkaeNuKljmwiSgXZluqrhyQJMLdVta4JZdoiNAdkYA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KzAjQwlzmr/vkA7JZlh/P6UcUBsTQdKJd1IXLFpCAQwIx6g0uzFREqL/pu7RH++ivy1JUon2EXQddsKqdE0hThpWn+rbCYwr1aIYfDP5bqIbPS8WfV8Xc4U5j9A8kgZQbilsrmaT/24rbOW1sv/IcXIWRWD6DUwZPMdWL5ba0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=kHK/abvG; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1764329761;
	bh=8HsM5P8BS8x1LqJoX77bfUmWfm10K1hQXwkWxVm/82k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=kHK/abvGwdAzt3/OEsU1znkecGNWHE4uCSfJhtmzW+lQAj+XtemszQpPfzeFzWj7M
	 v734NNEsT5+pFm4Q+R5l7knWhF2qdl1oER9yAxDOyY5GUgIcwOkZ1G/rT4ieyB/9iY
	 v+qCIUHWdPTmo5d9lWjHx2kJRNGJ3ti89huHft2c=
X-QQ-mid: esmtpgz15t1764329760t25f1e1c0
X-QQ-Originating-IP: aQJLKzrn36+5XC8PbxtdDgzv5C7Z3to+27ohEBpmeUo=
Received: from [198.18.0.1] ( [123.134.104.238])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 19:35:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13035330746348230136
Message-ID: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
Date: Fri, 28 Nov 2025 19:36:01 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs <linux-btrfs@vger.kernel.org>
From: HAN Yuwei <hrx@bupt.moe>
Subject: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OatzRg8pHEjpKRr+XpDZB12CRzoARyu/tgWZNsXNLkOWkXjEOjsiK+gy
	NM/FpXBOaOUniOQOaMt+bPyrwsSxHi/JJ4PT/PU073yQp2I3Ac9NlP0nSJhBYNlWFiSBTw0
	sGBgpelfZZCTpeAAB59JxfuBHLokdVzdfQVXTX4LERJZBU5yFXllHZrEkEBonpX3sANLyBC
	JDjPGy8ckn/cNfCO0lbR4cdiSyNNtlgtdenFHK+cwecvK1wCi5qp+M8on99gpr00dJokFMX
	D7Ag5z32Rp8aNI/pWupLSzLqlN2+R5nL5BlOd/UKIbLBNQCWF6iv2h7dAt4BweXE7PoZLDI
	tqb7oHbPFIRHmwXX6GLjtjmSz62FLKxLMqTiLwlCZjmcPq6LQ5wZUIA5TNmjrMNW0eYXi1c
	j8ud/aWXCC+mJpXB2Lcvw0Ue/tnqYEqel5VN10UXMzBZLTfjAbETCqg5fHZqjfEvEnt39lg
	deUaG6yPcpDthF5CcJzIYIMjSCqO9PlmJ5dkA0gi1pas0ulxeOfQXFSkZw7EQ/7ivBt5r32
	0q0Hq1Xz7WmIBOqVYxY4o8yvhd5oyBL+HX7TIDNu5Hw3Za02+sUXj7ZcBwI+Y4yizS1/Dml
	9gtv3RufunYETBfBGVAX3cKnbgA2huNOHPcznWe5zY7CPoRbqdfNgZaR29uroYoiNy1glfs
	eKiyXcbrSPeUwtciYd6LZvJmEq6Q+vMeJczKtuxroKmXBVqkHAkLrikUQp3IZuB62ffvQ1W
	5k9I0IsJ6Ignz9oz8SDRfAMli33X2wWaM/VMASdtP5nvo9mI7mSHKEM1pvS+n430Vv1SQMZ
	/8vRwqgQ+NUIq7RzJTk1R2qIPbk9Gb3CdVBYmFbgK9XELNiQSkOC1P1q+Q5CJojLC38oI7u
	kgciW0N76Y31cNWZ+Cbhsk94BLPbgSnqdiQL1eriR/HJpUIdcLcFrj4EARn21S3Z09QiWcu
	RtwamCbKWdpHYzQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi,

I have upgraded my test bench NAS from 6.18-rc2 to 6.18-rc7, And can't 
mount my RAID1 volume.

[   18.140714] BTRFS: device label DATA4 devid 1 transid 8182 /dev/sdc 
(8:32) scanned by mount (529)
[   18.143655] BTRFS: device label DATA2 devid 1 transid 12997 /dev/sdd 
(8:48) scanned by mount (528)
[   18.151014] BTRFS info (device sdc): first mount of filesystem 
2662c5a3-eac0-477a-a82a-b298a16dae02
[   18.151028] BTRFS info (device sdc): using crc32c (crc32c-lib) 
checksum algorithm
[   18.153940] BTRFS info (device sda): first mount of filesystem 
c3b4520d-ea9c-4ac2-9cbd-2c8820346809
[   18.153953] BTRFS info (device sda): using crc32c (crc32c-lib) 
checksum algorithm
[   18.155658] BTRFS info (device sdd): first mount of filesystem 
6a75f34b-1b2e-40f5-87ef-d83d980148b8
[   18.155675] BTRFS info (device sdd): using crc32c (crc32c-lib) 
checksum algorithm
[   18.157421] BTRFS: device fsid ba54f121-eb78-4af4-8a33-4764db37c0fa 
devid 1 transid 4814 /dev/nvme0n1p4 (259:8) scanned by mount (530)
[   18.157737] BTRFS info (device nvme0n1p4): first mount of filesystem 
ba54f121-eb78-4af4-8a33-4764db37c0fa
[   18.157752] BTRFS info (device nvme0n1p4): using crc32c (crc32c-lib) 
checksum algorithm
[   18.274329] BTRFS info (device nvme0n1p4): enabling ssd optimizations
[   18.274336] BTRFS info (device nvme0n1p4): turning on async discard
[   18.274338] BTRFS info (device nvme0n1p4): enabling free space tree
[   19.192944] BTRFS info (device sda): host-managed zoned block device 
/dev/sda, 52156 zones of 268435456 bytes
[   19.271742] BTRFS info (device sdc): host-managed zoned block device 
/dev/sdc, 52156 zones of 268435456 bytes
[   19.460332] BTRFS info (device sdd): host-managed zoned block device 
/dev/sdd, 52156 zones of 268435456 bytes
[   19.757242] BTRFS info (device sda): host-managed zoned block device 
/dev/sdb, 52156 zones of 268435456 bytes
[   19.868623] BTRFS info (device sda): zoned mode enabled with zone 
size 268435456
[   20.940894] BTRFS info (device sdd): zoned mode enabled with zone 
size 268435456
[   21.101010] r8169 0000:07:00.0 ethob: Link is Up - 1Gbps/Full - flow 
control off
[   21.128595] BTRFS info (device sdc): zoned mode enabled with zone 
size 268435456
[   21.436972] BTRFS error (device sda): zoned: write pointer offset 
mismatch of zones in raid1 profile
[   21.438396] BTRFS error (device sda): zoned: failed to load zone info 
of bg 1496796102656
[   21.440404] BTRFS error (device sda): failed to read block groups: -5
[   21.460591] BTRFS error (device sda): open_ctree failed: -5
[   23.292227] BTRFS info (device sdc): checking UUID tree
[   23.292306] BTRFS info (device sdc): enabling free space tree
[   23.410507] BTRFS info (device sdd): checking UUID tree
[   23.410597] BTRFS info (device sdd): enabling free space tree

uname -a:
Linux ninesheep 6.18.0-rc7-btrfs-test #10 SMP PREEMPT_DYNAMIC Mon Nov 24 
19:50:01 CST 2025 x86_64 GNU/Linux

btrfs inspect-internal dump-super /dev/sda:
superblock: bytenr=65536, device=/dev/sda
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xde24f48f [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    c3b4520d-ea9c-4ac2-9cbd-2c8820346809
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   6.17_RST_TEST
generation              473
root                    1435214675968
sys_array_size          129
chunk_root_generation   471
root_level              0
chunk_root              1658798080
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             28001039286272
bytes_used              765387165696
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             2
compat_flags            0x0
compat_ro_flags         0xb
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID |
                           BLOCK_GROUP_TREE )
incompat_flags          0x5361
                         ( MIXED_BACKREF |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES |
                           ZONED |
                           RAID_STRIPE_TREE )
cache_generation        0
uuid_tree_generation    473
dev_item.uuid           b6f8ba93-410e-4b90-9375-7fc5d1afc677
dev_item.fsid           c3b4520d-ea9c-4ac2-9cbd-2c8820346809 [match]
dev_item.type           0
dev_item.total_bytes    14000519643136
dev_item.bytes_used     387352363008
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

HAN Yuwei


