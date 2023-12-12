Return-Path: <linux-btrfs+bounces-836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C1980E2BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 04:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FE9282635
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 03:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8F69463;
	Tue, 12 Dec 2023 03:27:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EA3EB
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 19:27:36 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 11EEC14243D;
	Tue, 12 Dec 2023 03:27:36 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id F04601414AA;
	Tue, 12 Dec 2023 03:27:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702351655; a=rsa-sha256;
	cv=none;
	b=zlPB1K7XFbbFeUR3CJah6SXrsDnCsD4EW+ALR4vpx5YeW6Jfl4YZJ7MDH5d3Xk7qJydKxE
	UBCDg0kujcmqqeG3SD69H9CORozZiRv57oSA2+Q0OWE1Yg8VkgbJzSXk1S1Ii7HLJJMKPx
	j1IbKLKBYUZ4xNrvy6z4zzp+MGT/z0j3fCme0Hy3zg7Klr3kCM3wN3iSVaxBbNsytX86Pu
	vBMs/HD2T02hix/fqyBkyqa31trbeZgOYxKm0UGZuB2Nbyw1HoINJ/3XGpKpEZWlOqc5fM
	mBHEp80wQJuiyWPMd3Ol7dBOWmVPFKZSEPQsXcWBquG6YtIMdpgp4i07Rdvo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702351655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDtoF6st2njpQWnjZUcLZt/68nAGVr3MGrxD96Ihrfk=;
	b=BWGXHDNCPvhNampg0/HrncROwPBG1NN7qUuI2XNc4Q8qudAxpOaTM7NjbZD3DDwyPkEuQt
	AqIvCSUddi276ycNGXYY/y+jkO/Z/VJ3ixNxBg/X154Wh/ActI8sGgUQv0Fi82JOg+nEZo
	63gQNjmqd0aD4Q4kIrXeY+GCFTnnUONIKUUEKefCnC2yYCTfNz26nvqLnATQB6lyAJI6im
	jAMioV2oTGMZkuMrqwthqC+tP5mASdd3z0e71BAO1rTB2hcsxETYsE8z9w8w3Tk4G7DBy4
	fNaivDXr2gvKMZQO+t8FQnwTAiVVsosAVNM9GRvaWzavKweRRXZWv/5Vn++Djg==
ARC-Authentication-Results: i=1;
	rspamd-5749745b69-mrchj;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Coil-Harbor: 0b4655ff5ed9af71_1702351655505_134495659
X-MC-Loop-Signature: 1702351655505:423297085
X-MC-Ingress-Time: 1702351655505
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.108.178.136 (trex/6.9.2);
	Tue, 12 Dec 2023 03:27:35 +0000
Received: from p5090f0e4.dip0.t-ipconnect.de ([80.144.240.228]:35136 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rCtQf-00077b-2t;
	Tue, 12 Dec 2023 03:27:33 +0000
Message-ID: <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Tue, 12 Dec 2023 04:27:28 +0100
In-Reply-To: <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
	 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
	 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
	 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
	 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
	 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
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


Hey.

On Tue, 2023-12-12 at 13:00 +1030, Qu Wenruo wrote:
> IIRC compsize can do it.
> https://github.com/kilobyte/compsize

Okay... that seems promising:


/data/main/prometheus/metrics2# compsize 01H*
Processed 544 files, 399 regular extents (447 refs), 272 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%       37G          37G          23G      =20
none       100%       37G          37G          23G      =20

01H* are the subdirs for the "semi-final" chunks.

So here's my stolen storage ;-)
I'm a bit puzzled how that can happen, I mean for the chunks I'd have
naively assumed that they just write them more or less at once and in
sequence.


Interestingly, the WAL seems good, though:
/data/main/prometheus/metrics2# compsize wal/
Processed 3723 files, 1617 regular extents (1617 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%      1.9G         1.9G         1.9G      =20
none       100%      1.9G         1.9G         1.9G      =20



One thing I've noted by chance and don't understand:

I assumed "Referenced" was the number of unique bytes actually
references (by someone). So when I run compsize on a single file,
Reference should be the file size?


/data/main/prometheus/metrics2/wal# lll 00001030
251052 -rw-rw-r-- 1 106 106 ? 134217728 2023-12-10 04:51:58.665808973 +0100=
 00001030

/data/main/prometheus/metrics2/wal# compsize -b 00001030
Processed 1 file, 83 regular extents (83 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%     134451200    134451200    134217728  =20
none       100%     134451200    134451200    134217728  =20

=3D> okay, here it is


/data/main/prometheus/metrics2/wal# lll 00001045
251947 -rw-rw-r-- 1 106 106 ? 33034564 2023-12-10 08:57:01.892017049 +0100 =
00001045

/data/main/prometheus/metrics2/wal# compsize -b 00001045
Processed 1 file, 316 regular extents (316 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%     33116160     33116160     33038336   =20
none       100%     33116160     33116160     33038336   =20

=3D> here, Referenced is 3772 bytes larger than the actual file size?
   How can that happen?



On Tue, 2023-12-12 at 11:28 +1030, Qu Wenruo wrote:
>=20
>=20
> But WAL indeeds looks like a bad patter for btrfs.

> Thus we have "autodefrag" mount option for such use case.

Well the manpage warns from using on large DB workloads... I mean
Prometheus is not exactly like a DB, and I would have naively assumed
that at least the chunks were written not as many small random
writes... but apparently they are.

Also, this a VM, so the storage volume is actually something Ceph
backed, which the university's super computing centre provides us with.

I wonder if I do autodefrag on all that, if it doesn't just kill of our
performance even more?



Thanks :-)

Chris.

