Return-Path: <linux-btrfs+bounces-1114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AEF81C13C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 23:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9756D1F25F33
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ABD78E72;
	Thu, 21 Dec 2023 22:55:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558E64A96
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2C2A07A27DA;
	Thu, 21 Dec 2023 22:15:24 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0D7C97A2586;
	Thu, 21 Dec 2023 22:15:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1703196923; a=rsa-sha256;
	cv=none;
	b=WTgaiNDDqM3i9MPP0X0PK4DDfMErWw4mAVGV6eJNUp/VmFcJ9qWbOkEUO122zhR5Z46DZT
	6WUVdBhG8IeSeQohrKHRyBIdXujVoQ/grio3uTJjj4rAr4u9qFf5/PZ8/d+Q+4fQVFN/Qy
	dwhLYgp8A0i3BlwW5EtypxIBMDIYiyiuJzmY76R8gn9u/+1X1E7ZK67VePY3t1HXcCnu2/
	jiDPHihMKgv/2x94GLcUmGK+na53I0AxnipEJStCRpBMEofthyobPvuRSouuUS/FeC4jpy
	EZRRa2Bqi4J8LNrn8bfTsFOGRV+5ju1PipTNJzNKkCjuFR+QU6kBHhSTzZBOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1703196923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVogweCpW0Gr3AgzpOyJTC8wIjY4HM758Fd7gs3VN8o=;
	b=XolYur9ABgHJ0l6+1yJ0a/A6WgRvKLqVvUNH28iwKU4l/yOoHJGUwqW5JxSP+yIUu4PApI
	FSELIiKbsEsLhOoNAUtMWBkGQIfD7v1RNipgEDc147avImGyY3Snn0oVcXsOhFGWpC0nFp
	g81ESfCnuoJ0HfS5S/OMd8K/N9cbpIeRsa9UYgow6KD8aHSxTSSh8iZit/Tn0ESOPvwDEJ
	hZ6Ibv4oyGnx1WaBf2NxTD3QnY/ZUV3q5GhLqJbMLSwuFUTOSHMGzaY/NOrxtBMw5rqF0v
	SdTi1bAFv9fqm4NfyvNlh+kYvHzSGbUNLqT1hfVOah5zPL3HOzcnEIvAtZ84Sg==
ARC-Authentication-Results: i=1;
	rspamd-856c7f878f-2bgzp;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Society-Illustrious: 13b5864f40c448f0_1703196923990_992574289
X-MC-Loop-Signature: 1703196923990:119233089
X-MC-Ingress-Time: 1703196923990
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.125.117.212 (trex/6.9.2);
	Thu, 21 Dec 2023 22:15:23 +0000
Received: from p5b0ed5dc.dip0.t-ipconnect.de ([91.14.213.220]:40238 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rGRK4-0002zf-16;
	Thu, 21 Dec 2023 22:15:21 +0000
Message-ID: <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Andrei Borzenkov
 <arvidjaar@gmail.com>
Cc: kreijack@inwind.it, linux-btrfs@vger.kernel.org
Date: Thu, 21 Dec 2023 23:15:15 +0100
In-Reply-To: <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
	 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
	 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
	 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
	 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
	 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
	 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
	 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
	 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
	 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
	 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
	 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
	 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
	 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
	 <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Fri, 2023-12-22 at 07:11 +1030, Qu Wenruo wrote:
> Grab the INODE number of that file (`stat` is good enough).
# stat /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000=
001=20
  File: /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/00=
0001
  Size: 15781418  	Blocks: 30824      IO Block: 4096   regular file
Device: 0,43	Inode: 642         Links: 1
Access: (0664/-rw-rw-r--)  Uid: (  106/prometheus)   Gid: (  106/prometheus=
)
Access: 2023-12-12 17:50:26.968485936 +0100
Modify: 2023-12-12 17:50:28.748495544 +0100
Change: 2023-12-12 17:50:57.280649521 +0100
 Birth: 2023-12-12 17:50:26.968485936 +0100

> Know the subvolume id.

# btrfs subvolume list -pagu /data/main/
ID 257 gen 2371697 parent 5 top level 5 uuid ae3fa7ff-f5a4-cf44-8555-ad5791=
95036c path <FS_TREE>/data


> Then `btrfs ins dump-tree -t <subvolid> <device> | grep -A7 "key (256
> "

I assume 256 should be the inode number?
If so:
# btrfs ins dump-tree -t 257 /dev/vdb | grep -A7 "key (642 "
		location key (642 INODE_ITEM 0) type FILE
		transid 2348290 data_len 0 name_len 6
		name: 000001
	item 128 key (638 DIR_INDEX 3) itemoff 9441 itemsize 36
		location key (642 INODE_ITEM 0) type FILE
		transid 2348290 data_len 0 name_len 6
		name: 000001
	item 129 key (639 INODE_ITEM 0) itemoff 9281 itemsize 160
		generation 2348289 transid 2348290 size 17788225 nbytes 17788928
		block group 0 mode 100664 links 1 uid 106 gid 106 rdev 0
		sequence 408 flags 0x0(none)
		atime 1702399826.500483413 (2023-12-12 17:50:26)
--
	item 132 key (642 INODE_ITEM 0) itemoff 9053 itemsize 160
		generation 2348289 transid 2348290 size 15781418 nbytes 15781888
		block group 0 mode 100664 links 1 uid 106 gid 106 rdev 0
		sequence 3362 flags 0x10(PREALLOC)
		atime 1702399826.968485936 (2023-12-12 17:50:26)
		ctime 1702399857.280649521 (2023-12-12 17:50:57)
		mtime 1702399828.748495544 (2023-12-12 17:50:28)
		otime 1702399826.968485936 (2023-12-12 17:50:26)
	item 133 key (642 INODE_REF 638) itemoff 9037 itemsize 16
		index 3 namelen 6 name: 000001
	item 134 key (642 EXTENT_DATA 0) itemoff 8984 itemsize 53
		generation 2348290 type 1 (regular)
		extent data disk byte 9500291072 nr 268435456
		extent data offset 0 nr 15781888 ram 268435456
		extent compression 0 (none)
	item 135 key (643 INODE_ITEM 0) itemoff 8824 itemsize 160
		generation 2348290 transid 2363471 size 283 nbytes 283
		block group 0 mode 100664 links 1 uid 106 gid 106 rdev 0


If you need the whole output of btrfs ins dump-tree -t 257 /dev/vdb,
it's only 72k compressed, and AFAIU shouldn't contain any private data
(well nothing on the whole fs is private ^^).


Cheers,
Chris

