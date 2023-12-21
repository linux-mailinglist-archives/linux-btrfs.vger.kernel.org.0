Return-Path: <linux-btrfs+bounces-1104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EE981B91E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 15:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB77B2594E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198C79463;
	Thu, 21 Dec 2023 13:53:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC878E95
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3369C143AF0;
	Thu, 21 Dec 2023 13:53:40 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1C697143941;
	Thu, 21 Dec 2023 13:53:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1703166819; a=rsa-sha256;
	cv=none;
	b=2vDyWw1hC63ub+aQUBVeGEEKakBuozwaXHs375OAMFSxXLS6dztiAx41QYzM3xK5sNGy5P
	g0SgznH+eE5K+VA0Y0t5RTkqSDKtKox/m7tv2ugoemxXftANo498stlGB5ylhXMekSoqMT
	tILvgxSI+uPNnbrFODF5Hjqq48lATK4RuYfYeBgJHJKr12BlFg3sBnUhCKS3XWpX/7FRnV
	QRbEq9jr5KSyAvXSImhmnU7iKLpkNsRT+SIARVkc/GD0KSNXUvaBX+CnFha4d2U/fhBumK
	Ncp5r/MBph5FwculquJHOjkDbpTSeLgsn9pZ5jyMJ4nCdjSkB0n+x9qu8B1MzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1703166819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OhIbyAIpvA/Hxew56LZ9YtL3OxsP0F2ZWw38Zqm6GE=;
	b=6G0EnuKUtzBHAiMh9JXSC3EuatwcQx/CPZV75V/9wzOQLKOEiqsJnIsZCT5dnx+rK3m10v
	Aazs1m04jVevXwLiv1UiNao3VN3rU1n7xynp7NA6YveVQTQ1XCcvEKxAZAyb23kFBzTHrM
	whe2VakBQc0rlC60Eg1rQ/oy/7ZPwPAqDPZokT+P0c2tDDP122xXGSazcidqVCY8en9POZ
	WFkw58BjlkqODaYDd/H4M+lX+1Hl6+XHVrtmZyfo4CpOPcid35qviVYT6B6YZ/Ob6m6RP2
	xeY6xrpzAw+g6EBxFqDkqjzRySgymiZA+/Nc0Ok9SI7lv2ATR7cxQ53+YyL0Yg==
ARC-Authentication-Results: i=1;
	rspamd-856c7f878f-tsn87;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Wipe-Army: 555e99fe4e9fa817_1703166820041_1741592657
X-MC-Loop-Signature: 1703166820041:4146605999
X-MC-Ingress-Time: 1703166820041
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.127.58.193 (trex/6.9.2);
	Thu, 21 Dec 2023 13:53:40 +0000
Received: from dhcp-138-246-3-41.dynamic.eduroam.mwn.de ([138.246.3.41]:49110 helo=[10.183.50.88])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rGJUV-0004tF-0o;
	Thu, 21 Dec 2023 13:53:37 +0000
Message-ID: <21d14fb83e170441f9640f98bae3ba8f0e48eaad.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: kreijack@inwind.it, Andrei Borzenkov <arvidjaar@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Thu, 21 Dec 2023 14:53:31 +0100
In-Reply-To: <9bb4ead3-2e98-4d0f-a980-1d53847c8b99@inwind.it>
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

Hey Goffredo.

On Tue, 2023-12-19 at 20:09 +0100, Goffredo Baroncelli wrote:
> Ok, now we have the case study.
> To be sure, could you try a defrag (+ sync) of this single file ?

# btrfs filesystem defragment /data/main/prometheus/metrics2/01HHFEZPJ8TPFV=
YTXV11R7ZH4X/chunks/000001
# btrfs filesystem defragment -t 1000M /data/main/prometheus/metrics2/01HHF=
EZPJ8TPFVYTXV11R7ZH4X/chunks/000001
# sync
# btrfs filesystem sync /data/main/
# compsize /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks=
/000001=20
Processed 1 file, 1 regular extents (1 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%      256M         256M          15M      =20
none       100%      256M         256M          15M      =20
#=20



> The what is the lsof output ?

# lsof -- /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/=
000001=20
COMMAND       PID       USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
prometheu 2327412 prometheus   12r   REG   0,43 15781418  642 /data/main/pr=
ometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001
#=20

I also stopped prometheus synced and checked then:
# systemctl stop prometheus.service=20
# lsof -- /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/=
000001=20
# btrfs filesystem sync /data/main/
# compsize /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks=
/000001=20
Processed 1 file, 1 regular extents (1 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%      256M         256M          15M      =20
none       100%      256M         256M          15M      =20


> Does anyone know a way to extract the "owners" of an extent ? I think
> that
> we should go through the backref, but I never did. I don't want to
> re-invent the wheel, so I am asking if someone knows a tool that can
> help to find the owners of a extent.

Not me ;-) ... Does it help if I'd provide something like dump-tree
data?


The fs is soon to be full again, so I'll likely have to delete some of
the (test) data...


Thanks,
Chris.

