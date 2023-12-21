Return-Path: <linux-btrfs+bounces-1112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D992E81C0F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 23:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B706B23545
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08B77F2D;
	Thu, 21 Dec 2023 22:25:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from relay.mailchannels.net (gt-egress-001.relay.mailchannels.net [199.10.31.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088C377F10
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6D3923620F0;
	Thu, 21 Dec 2023 22:06:54 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id E5BED361C2E;
	Thu, 21 Dec 2023 22:06:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1703196413; a=rsa-sha256;
	cv=none;
	b=hWkSKwtb7ExzxQBtblDwALYrjgOBq2EAr+t1eBfTFW4ZYtKF5ANWP7wfsM7E7Dbio/qvDO
	+oX3eakG8yURA/EnVgZq8c7lxObGq2qYG1Q7e0wEqdn1YR4qPw6JJPUtRdlXoDeUpS7zYs
	n2tBEKmXVZyoxm8H8xh58JjCWp2YrwoQ9+gPn/Hkz3ZX+EBzCxELvDK1PKsepobuAQpnAG
	NIA9JofwfarHSGf/Jf0VEmP/vT4YgEIU8c3TzVqNnjfIank3XgggAaR9JJyTlj+9Ls0/fh
	XnSl6BKbgKjxTV1EtoRfYomlnbGbMOFMXGJa+xdqlTbsd7o0wfTuM/3p8um8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1703196413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcHJJ0XZHOg8H5nwwxx6NEP3irPSS+hzqeHWOZqKKIg=;
	b=WYiQE7vIbNoFiuPqoLLPJxz1hJKowfi94xOdRJBE8uqRqirDWKP3b6TJgByEp73fo8naFm
	3a+r/VUTJSK0t4jLzXDFLDycQuEf6tAZlBbZNyCjHwWRnh1KEQ+yFt9/cD7+BQ3mdTAZ1N
	g5ypFlF7vEtOBMr5B7l7QZ9gqjOWVOzpPuV7mCZVlhjYvOUfm6V8pQ8FPu2QpmgcEkPoSh
	lKdU33EhZ71H/a35HuvO2UWAxMCq1NZi61LZOF3a6ZSDMo+RxmPorotcFBi49NebWC1aue
	D12VicoJhrZhqvViKed7LdHqI0QmnFCryyt70mfbSAxpo6KI7J1AnkpXyLK29A==
ARC-Authentication-Results: i=1;
	rspamd-856c7f878f-tbr8p;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Duck-Trail: 63ea05421c91248b_1703196413872_3359219665
X-MC-Loop-Signature: 1703196413872:3404601825
X-MC-Ingress-Time: 1703196413872
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.107.232.172 (trex/6.9.2);
	Thu, 21 Dec 2023 22:06:53 +0000
Received: from p5b0ed5dc.dip0.t-ipconnect.de ([91.14.213.220]:60124 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rGRBq-0002cI-0Y;
	Thu, 21 Dec 2023 22:06:51 +0000
Message-ID: <1bdc9dcea3b2ec776e9b5b3b7c711654580e0d31.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: kreijack@inwind.it, Andrei Borzenkov <arvidjaar@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Thu, 21 Dec 2023 23:06:45 +0100
In-Reply-To: <cb2d0cf1-8612-4c7b-8d29-d9efcb7888c4@inwind.it>
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
	 <9bb4ead3-2e98-4d0f-a980-1d53847c8b99@inwind.it>
	 <21d14fb83e170441f9640f98bae3ba8f0e48eaad.camel@scientia.org>
	 <cb2d0cf1-8612-4c7b-8d29-d9efcb7888c4@inwind.it>
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

On Thu, 2023-12-21 at 19:03 +0100, Goffredo Baroncelli wrote:
> > # lsof --
> > /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/00
> > 0001
>=20
> Here you should do a defrag, after the stop of prometheus.

No difference. Even after syncing, and even after unmount/mountig.


btw: I did that:

/data/main# compsize /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7Z=
H4X/chunks/000001=20
Processed 1 file, 1 regular extents (1 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%      256M         256M          15M      =20
none       100%      256M         256M          15M      =20

/data/main# cat /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/c=
hunks/000001 > foo
/data/main# compsize -b foo=20
Processed 1 file, 1 regular extents (1 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%     268435456    268435456    15781888   =20
none       100%     268435456    268435456    15781888   =20
/data/main# ls -al foo=20
-rw-r--r-- 1 root root 15781418 Dec 21 23:02 foo

=3D> Wouldn't have expected that, not only the discrepancy between
   referenced and ls.
   But even the freshly cat'ed file has that space waste. There should
   be no holes, or any other monkey business involved?


# du --apparent-size --total -s --block-size=3D1 /data/main/
22112706625	/data/main/
22112706625	total

# compsize -b /data/main/
Processed 463 files, 865 regular extents (874 refs), 224 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%     35752870045  35752870045  22097375389=20
none       100%     35752870045  35752870045  22097375389=20



>=20
> I am trying to write a tool that walks the backref to find the
> owners.
> I hope for tomorrow to have a prototype to test.

Thanks!


Cheers,
Chris.

