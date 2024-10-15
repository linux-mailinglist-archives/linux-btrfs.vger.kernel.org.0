Return-Path: <linux-btrfs+bounces-8933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95F99EFED
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436DE1C22CF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40631D516C;
	Tue, 15 Oct 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="thG8Lz9M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxOrRS0X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D611B21BA
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003442; cv=none; b=rG3/vRhWdaB4sMek7xKEahJosx7FKmGUkqCppmmoqHbEI7y+gY73AGMngsJo86EOSS93rFoVxPDZp2R+4G4mJ/Gm3K+AoMZ/gq8J+JjJ8KWFc5vKYseg798e52u3kFbABBCbuGfy+P0RWJNFcKZhN30aM8ixAFYClYy/McfIDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003442; c=relaxed/simple;
	bh=Mt+N/QPmk2zq0ODsZrqlBcvmdrGJStUE5XFyVo4jtpU=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=tn+nEHujQuuiMbXVXq0q2lazDgC4UYLxm4+MZmxmFmSQqxV67wC+mK22TKxpZfqPrzfVqnvutRf32FEvPZPKL0BEzXAWo3vCl3K1CikjkyoA5Ick+sSoXgH9nshtFMTWP+KxSM4bgVFapaUOVH6JdS7PhEa0wSkTCbibki+xG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=thG8Lz9M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxOrRS0X; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DDC5F13801DD
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 10:43:58 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Tue, 15 Oct 2024 10:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm3; t=
	1729003438; x=1729089838; bh=nwOXPT0droS9ai6vZO5CsKK+8Hq4DZKqOMO
	IDxiQkdc=; b=thG8Lz9M9dw2YqD3+aVCOX5NWH6n40f9BxMRImeNLFEwYMAEFee
	9wJhriMwnWs1i8V3372QOC10aN1gXytGcTj10TTydK8GY1YPk4xElkGLGlfI0vOe
	cFS/+61o2vBGJp1LLbAen7/FIopPyr/UPkRbs+MjTr8b2hdtlQk5xvukx+qcsaXa
	r4msMb/KBJ2tsw3802lY04sda77RSwa8uVQPkQqeH8wUlSng7wvn8AxAqIOLiI1h
	fQc0Fa8CutxocHI2wSW/8XL24eWbEzg0KgTEGJHmFGVBqp+0k1p2LLEaC7SoBkkD
	o1bOeKmBonsfSl82TJ8A0/y0+qH4hd7j8rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729003438; x=1729089838; bh=nwOXPT0droS9ai6vZO5CsKK+8Hq4
	DZKqOMOIDxiQkdc=; b=WxOrRS0X6TlKmNtr7Q4AzwXAtQ2uUiQ9/2uVVhUZBkcU
	8FdlscXOn/3PiF5G/nIUx55icOvdZVym8acZ1lyRDKSXS6zyAoQ94bK2HvRE4Psh
	zGeN6y11/hih4A5tGh0ilfgCqi3cb+Al+gimM6OP3jwDnlsJSU7RybhWoORL95x4
	DtfxQbVuWzjMU+LtUEpNVpSz9KKC/Tb4JDOYSPCe5Nugz4Khb4H7u97dgjTs2UvT
	GETVY7PKUf5MqSUAhLG3aHhInuZ8IkkVrQXjglqC0/GL8+jZIZymRwNp1q9+S+uT
	uu5fdvX6Yg1Ji3e+SpkUkpmyQMwGRmHP1ieyDevutQ==
X-ME-Sender: <xms:rn8OZ0l940eV1WougQdIlswfW1IlT-H_YPIYbLb5L6VX0utisXvU6g>
    <xme:rn8OZz0KrhMEkV3j0s_RmMQK6Ia-OoYpx1gOdjdoBKdabCEneunyYo4ojJ6Vzfagk
    8r7P2D-dwoEENJ2pog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkufgtgfesthejredtredttdenucfh
    rhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvg
    guihgvshdrtghomheqnecuggftrfgrthhtvghrnhepudffteffjedutdekvdetffethffh
    vefhtdeufefgveejhfektdeifeduffffffetnecuffhomhgrihhnpehfvgguohhrrghprh
    hojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtg
    hpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsght
    rhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rn8OZyqC6QsYMAyt8mN6q-YP3SCQ9BfJYgcIZHWYF_PStE2JtdsuGQ>
    <xmx:rn8OZwmU-YzUUM1dG6pBP1G-AKn8qfapumiJQT_HNf-b1_XfDRWEjA>
    <xmx:rn8OZy3i08M9_F0-t_FRg04J0kaVM9JhOMGATI0UCdE7OpEaDLJ87g>
    <xmx:rn8OZ3tXzsadRu9Exegd4xGfuNnnF-EHVlmHWL3mVrkP3LDDVy-hWg>
    <xmx:rn8OZ3_6UJ9Oc6eRzvYRVvF9Y-3KIRnNqTSTol7VeMXQWRyG4Dt2cBou>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A29411C20066; Tue, 15 Oct 2024 10:43:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 10:43:38 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <4717ca78-1d70-4aa7-bebb-d303c4ada4ca@app.fastmail.com>
Subject: kernel 6.8.5, bad tree block start, couldn't read tree root, including any of
 the backup roots
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Fedora user report:
kernel 6.8.5-301.fc40.x86_64
btrfs-progs 6.8
Kioxia NVMe KXG80ZNV1T02, firmware 11304102 (used by Dell, seems firmware is current)
https://discussion.fedoraproject.org/t/stuck-in-emergency-mode-after-force-shutdown/133615

Description:
User reports system was suspended, and wouldn't wake from suspend. And power was forced off to recover. The problem appears on the subsequent boot. This post contains the most relevant photo of kernel messages showing the mount errors, including both copies (DUP metadata) of all the backup tree roots.

https://discussion.fedoraproject.org/t/133615/15

Supers all look good:

superblock: bytenr=65536, device=/dev/nvme0n1p3
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x79e5611c [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			2c03e734-1b38-49e9-991a-1f85b9cc97f7
metadata_uuid		00000000-0000-0000-0000-000000000000
label			fedora
generation		38863
root			808009728
sys_array_size		129
chunk_root_generation	32970
root_level		0
chunk_root		24854528
chunk_root_level	0
log_root		0
log_root_transid (deprecated)	0
log_root_level		0
total_bytes		1022505254912
bytes_used		81702764544
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x3
			( FREE_SPACE_TREE |
			  FREE_SPACE_TREE_VALID )
incompat_flags		0x371
			( MIXED_BACKREF |
			  COMPRESS_ZSTD |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	0
uuid_tree_generation	38863
dev_item.uuid		0aab31a2-3c63-4c6f-bc4c-8f4b4bad66ac
dev_item.fsid		2c03e734-1b38-49e9-991a-1f85b9cc97f7 [match]
dev_item.type		0
dev_item.total_bytes	1022505254912
dev_item.bytes_used	89145737216
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 1 offset 22020096
			dev_uuid 0aab31a2-3c63-4c6f-bc4c-8f4b4bad66ac
			stripe 1 devid 1 offset 30408704
			dev_uuid 0aab31a2-3c63-4c6f-bc4c-8f4b4bad66ac
backup_roots[4]:
	backup 0:
		backup_tree_root:	803454976	gen: 38861	level: 0
		backup_chunk_root:	24854528	gen: 32970	level: 0
		backup_extent_root:	802881536	gen: 38861	level: 2
		backup_fs_root:		30572544	gen: 9	level: 0
		backup_dev_root:	73252864	gen: 36528	level: 0
		csum_root:	801767424	gen: 38861	level: 2
		backup_total_bytes:	1022505254912
		backup_bytes_used:	81702764544
		backup_num_devices:	1

	backup 1:
		backup_tree_root:	804864000	gen: 38862	level: 0
		backup_chunk_root:	24854528	gen: 32970	level: 0
		backup_extent_root:	804093952	gen: 38862	level: 2
		backup_fs_root:		30572544	gen: 9	level: 0
		backup_dev_root:	73252864	gen: 36528	level: 0
		csum_root:	801931264	gen: 38862	level: 2
		backup_total_bytes:	1022505254912
		backup_bytes_used:	81702899712
		backup_num_devices:	1

	backup 2:
		backup_tree_root:	808009728	gen: 38863	level: 0
		backup_chunk_root:	24854528	gen: 32970	level: 0
		backup_extent_root:	806535168	gen: 38863	level: 2
		backup_fs_root:		30572544	gen: 9	level: 0
		backup_dev_root:	73252864	gen: 36528	level: 0
		csum_root:	803799040	gen: 38863	level: 2
		backup_total_bytes:	1022505254912
		backup_bytes_used:	81702764544
		backup_num_devices:	1

	backup 3:
		backup_tree_root:	801734656	gen: 38860	level: 0
		backup_chunk_root:	24854528	gen: 32970	level: 0
		backup_extent_root:	800374784	gen: 38860	level: 2
		backup_fs_root:		30572544	gen: 9	level: 0
		backup_dev_root:	73252864	gen: 36528	level: 0
		csum_root:	797999104	gen: 38860	level: 2
		backup_total_bytes:	1022505254912
		backup_bytes_used:	81702764544
		backup_num_devices:	1


btrfs insp dump-t -b 808009728 $DEV
btrfs-progs v6.8
checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
Couldn't read tree root
checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
ERROR: failed to read tree block 808009728

btrfs insp dump-t -b 80486400 $DEV
btrfs-progs v6.8
checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
Couldn't read tree root
checksum verify failed on 80486400 wanted 0x00000000 found 0x973bc4ee
checksum verify failed on 80486400 wanted 0x00000000 found 0x14f430d1
ERROR: failed to read tree block 80486400


btrfs insp dump-t -b 803454976 $DEV
btrfs-progs v6.8
checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
Couldn't read tree root
checksum verify failed on 803454976 wanted 0x080fd04c found 0x4431a259
checksum verify failed on 803454976 wanted 0x00000000 found 0x3be418cb
ERROR: failed to read tree block 803454976


btrfs insp dump-t -b 801734656 $DEV
btrfs-progs v6.8
checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
Couldn't read tree root
checksum verify failed on 801734656 wanted 0x080fd04c found 0x69344e69
checksum verify failed on 801734656 wanted 0x00000000 found 0x818d4e83
ERROR: failed to read tree block 801734656


But I'm not sure where to suggest the user go from here since none of the tree roots can be read. That seems like quite a lot of problems all at once to different parts of the media.

thanks,


--
Chris Murphy

