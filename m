Return-Path: <linux-btrfs+bounces-827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C8880DFD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 01:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D0CB2177B
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 00:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9DC39F;
	Tue, 12 Dec 2023 00:12:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B64BB5
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 16:12:16 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8018294220E;
	Tue, 12 Dec 2023 00:12:15 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id C30989417B1;
	Tue, 12 Dec 2023 00:12:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702339935; a=rsa-sha256;
	cv=none;
	b=O8dJvsPGwV75BZ9xYIUFu87kNJ6lby3HXl4/+zlRxx7uwHww64cyE6HAJEAgFvgxiStk6L
	RlZ6+SorY/dg1fTTNtLrQz0jbeX8WMv6t8qCIdmzCd5QvjssiL0qL/NOc3ano+Ft/DGHHa
	9s4/i/e7OYlM4AIzhRYgjdRvOOIAP0rTlVbdhF8gtPFauB/qbzVNFzST6k9RPUSNWUSclm
	9b9KY6uB9eqBGCsM8efRc3ffZGYgWHSfu+aMj9giGyv+jgn02wlzrkKoiCuTYo1VGGCNzK
	zhFyrQcZEtrSij3I0BT14KMvM8QmM7UZNALMCOX44PDxzGkLkyyxd+mk9v5egQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702339935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxgLEZyJd9LFel7D1Oh1YHmBZOOROr9nZYXpybT+Wao=;
	b=dRr0CXNSRo4B2KTsOoEQbEgPFCHGrCcTtfTH4CLAUTgF8utpqxvVz4wKpnMp56ie/tDKhU
	LgyBlCgUI/p8yNiP4q8u2aySgBzhZRA4U/dqwYDLE4mz/A4cxe7r/D5yR/LJk6UwCLy256
	vf+emZ0kEXzpU1vyZAOwuEkk0EPc+y7Fiho5oK/o4aly074/ON+nBNS+v9XkAE72Rxxyio
	AgsDJRwykP/NftSJ4HYSQFNbXuMccNKrZmQDO2A6UVJTogzHtogJ1PvdfMN4t2ZZCDrRoq
	CzQqZeue5HMiRW77Cx7/QCYjrP9oN805e2u8IBT/XCDucJMItSevCXb962P+hA==
ARC-Authentication-Results: i=1;
	rspamd-6cb9686b59-fwr6j;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Unite-Supply: 342267042089aa84_1702339935331_84393924
X-MC-Loop-Signature: 1702339935331:620153766
X-MC-Ingress-Time: 1702339935331
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.118.156.120 (trex/6.9.2);
	Tue, 12 Dec 2023 00:12:15 +0000
Received: from p5090f0e4.dip0.t-ipconnect.de ([80.144.240.228]:47406 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rCqNd-0005Xv-3D;
	Tue, 12 Dec 2023 00:12:13 +0000
Message-ID: <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Tue, 12 Dec 2023 01:12:08 +0100
In-Reply-To: <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
	 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
	 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
	 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
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

On Tue, 2023-12-12 at 10:24 +1030, Qu Wenruo wrote:
> Then the last thing is extent bookends.
>=20
> COW and small random writes can easily lead to extra space wasted by
> extent bookends.

Is there a way to check this? Would I just seem maaany extents when I
look at the files with filefrag?


I mean Prometheus, continuously collects metrics from a number of nodes
an (sooner or later) writes them to disk.
I don't really know their code, so I have no idea if they already write
every tiny metric, or only large bunches thereof.

Since they do maintain a WAL, I'd assume the former.

Every know and then, the WAL is written to chunk files which are rather
large, well ~160M or so in my case, but that depends on how many
metrics one collects. I think they always write data for a period of
2h.
Later on, they further compact that chunks (I think after 8 hours and
so on), in which case some larger rewritings would be done.
Though in my case this doesn't happen, as I run Thanos on top of
Prometheus, and for that one needs to disable Prometheus' own
compaction.


I've had already previously looked at the extents for these "compacted"
chunk files, but the worst file had only 32 extents (as reported by
filefrag).

Looking at the WAL files:
/data/main/prometheus/metrics2/wal# filefrag * | grep -v ' 0 extents
found'
00001030: 82 extents found
00001031: 81 extents found
00001032: 79 extents found
00001033: 82 extents found
00001034: 78 extents found
00001035: 78 extents found
00001036: 81 extents found
00001037: 79 extents found
00001038: 79 extents found
00001039: 89 extents found
00001040: 80 extents found
00001041: 74 extents found
00001042: 81 extents found
00001043: 97 extents found
00001044: 101 extents found
00001045: 316 extents found
checkpoint.00001029: FIBMAP/FIEMAP unsupported

(I did the grep -v, because there were a gazillion of empty wal files,
presumably created when the fs was already full).

The above numbers though still don't look to bad, do they?

And checking all:
# find /data/main/ -type f -execdir filefrag {} \; | cut -d : -f 2 |
sort | uniq -c | sort -V
   3706  0 extents found
    450  1 extent found
     25  3 extents found
     62  2 extents found
      1  8 extents found
      1  9 extents found
      1  10 extents found
      1  11 extents found
      1  32 extents found
      1  74 extents found
      1  80 extents found
      1  89 extents found
      1  97 extents found
      1  101 extents found
      1  316 extents found
      2  78 extents found
      2  82 extents found
      3  5 extents found
      3  79 extents found
      3  81 extents found
      6  4 extents found



> E.g. You write a 16M data extents, then over-write the tailing 8M,
> now
> we have two data extents, the old 16M and the new 8M, wasting 8M
> space.
>=20
> In that case, you can try defrag, but you still need to delete some
> data
> first so that you can do defrag...


Well my main concern is rather how to prevent this from happening in
the first place... the data is already all backuped into Thanos, so I
could also just wipe the fs.
But this seems to occur repeatedly (well, okay only twice so far O:-)
).
So that would mean we have some IO pattern that "kills" btrfs.


Cheers,
Chris.

