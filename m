Return-Path: <linux-btrfs+bounces-21384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QZ0YDE0lhGlRzwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21384-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 06:06:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DC5EE9F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 06:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 926193017505
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 05:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C02D0C72;
	Thu,  5 Feb 2026 05:06:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03D29D29C
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267973; cv=pass; b=ClhmT2aXlpf3GjI/fHZICNJPHgfSoV7YCugyNl4/5LjC56jI+psAUGvNDmgQmj237ZktXTi5+ZqTprN3rfhvm4rQf7OCf8CB4X8Ldx6hYgaL2MXHTbWPjo6hZKZtJ4L0L+j2onK1u8SezE7BYlEYYhbzxIdkyuy7PBKtLjHlQys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267973; c=relaxed/simple;
	bh=vepifmTz+gp9Zl0pMommJdsYpAlyYfPNulKBOeyBvag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TEpqOg/0xKPq5g6NHEaDYUVIzwTWOuDGnUK+bqx5XU7gpJksfxmC8MSnlG91NCZfACsHTMGO32fjVfWC1Fmzel4ODqngWsQxV2mBhbWB7TwkZVe9MSaWznLqPFcbcDF9XDYh2r643v4Dg2bVHm7Rc3resJDPjwll6lcCYlu3MzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 23E3492242D;
	Thu, 05 Feb 2026 04:30:38 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-7.trex.outbound.svc.cluster.local [100.123.73.89])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 449B3921226;
	Thu, 05 Feb 2026 04:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770265837;
	b=kPCelxyhBuarUuUQyIy+HSKs2ckJB+CWl9EUk0RhMgJ94FoTMgrpICA1qvmIPXEYxM9Dv3
	cyjuRo8fyzryugY+zAY7ixikMc0ushMwmnWB1NtYtaS8+G4AXW80Kq4UPEUrBZju4Yod4Z
	9mIDxZd3nMh1XWPKI23fAftzI46pk7e+/JABlMGqkUgvACAEf/bPKRUwEUCX3/++lg2Zof
	0ldB652sOYg2wnjXZpPlVwP7bNRhMAQe0QFvylUHhgJs9JDytB3RleiO8ytlMJo3gdNLqP
	nvfFV+xu4Xl9OjfcF++zAqaMECvcY0V/abnrQSDUHUKnJv6jqYMESYmGTsYYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770265837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vepifmTz+gp9Zl0pMommJdsYpAlyYfPNulKBOeyBvag=;
	b=cZTHP2oRyRXcv+mlC1aFE3rudkoj61zwPe5e1vTf+tUHULR7oZCcPbeTOEBjaPyaoLxBhg
	Ok1CJMYPRKxC6tEfFCjUUspgQUTUFnq70UlGkdpTcRzWs4FzFWQ49c3SVEcB189c36hNLG
	VwWb35Bm63m0DspSykCbtSUOjkLLDXDumBd5gMor0XgYfhiQ6QqjITopUgdVg+vpEtJIbr
	be/jUvkgqxV+N03X+8DT63hCla3W4m0QI7u9wWvsphU7ZbijI1HZW/ypPpYzwc19iGC4z1
	Ofg7ICJqStj8uRmBDtAoyLoOqGiVBF4UjBasO01pNn3ql1ete7fceL53xZ4BPw==
ARC-Authentication-Results: i=1;
	rspamd-5b979ccf89-mkxcp;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Madly-Grain: 1d67867351722967_1770265837972_106871681
X-MC-Loop-Signature: 1770265837972:1061123276
X-MC-Ingress-Time: 1770265837972
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.73.89 (trex/7.1.3);
	Thu, 05 Feb 2026 04:30:37 +0000
Received: from [212.104.214.84] (port=11874 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vnr0m-0000000BSjW-0Qx2;
	Thu, 05 Feb 2026 04:30:35 +0000
Message-ID: <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
Subject: Re: We have a space info key for a block group that doesn't exist
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Thu, 05 Feb 2026 05:30:33 +0100
In-Reply-To: <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
	 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
	 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
	 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
	 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
	 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21384-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[scientia.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,scientia.org:mid]
X-Rspamd-Queue-Id: D3DC5EE9F3
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 14:54 +1030, Qu Wenruo wrote:
> Can you provide the dmesg during that mount and unmount.

Tried the same with two different filesystems:
Feb 05 02:21:10 heisenberg kernel: BTRFS info (device dm-1): last unmount o=
f filesystem ff14e046-d72c-4671-b30a-6ec17c58a0f1
Feb 05 02:32:03 heisenberg kernel: BTRFS: device label data-a-1 devid 1 tra=
nsid 4084 /dev/mapper/data-a-1 (253:1) scanned by mount (39262)
Feb 05 02:32:03 heisenberg kernel: BTRFS info (device dm-1): first mount of=
 filesystem ff14e046-d72c-4671-b30a-6ec17c58a0f1
Feb 05 02:32:03 heisenberg kernel: BTRFS info (device dm-1): using crc32c (=
crc32c-lib) checksum algorithm
Feb 05 02:32:17 heisenberg kernel: BTRFS info (device dm-1): enabling free =
space tree
Feb 05 02:32:17 heisenberg kernel: BTRFS info (device dm-1): force clearing=
 of disk cache
Feb 05 02:32:29 heisenberg kernel: BTRFS info (device dm-1): last unmount o=
f filesystem ff14e046-d72c-4671-b30a-6ec17c58a0f1

Feb 05 03:39:12 heisenberg kernel: BTRFS info (device dm-2): last unmount o=
f filesystem e1a465db-0227-46e1-9917-d6be986266cd
Feb 05 03:39:24 heisenberg kernel: BTRFS: device label data-a-2 devid 1 tra=
nsid 2620 /dev/mapper/data-a-2 (253:2) scanned by mount (53935)
Feb 05 03:39:24 heisenberg kernel: BTRFS info (device dm-2): first mount of=
 filesystem e1a465db-0227-46e1-9917-d6be986266cd
Feb 05 03:39:24 heisenberg kernel: BTRFS info (device dm-2): using crc32c (=
crc32c-lib) checksum algorithm
Feb 05 03:39:40 heisenberg kernel: BTRFS info (device dm-2): enabling free =
space tree
Feb 05 03:39:40 heisenberg kernel: BTRFS info (device dm-2): force clearing=
 of disk cache
Feb 05 03:39:59 heisenberg kernel: BTRFS info (device dm-2): last unmount o=
f filesystem e1a465db-0227-46e1-9917-d6be986266cd
Feb 05 03:40:00 heisenberg kernel: BTRFS: device label data-a-2 devid 1 tra=
nsid 2620 /dev/mapper/data-a-2 (253:2) scanned by mount (54040)
Feb 05 03:40:00 heisenberg kernel: BTRFS info (device dm-2): first mount of=
 filesystem e1a465db-0227-46e1-9917-d6be986266cd
Feb 05 03:40:00 heisenberg kernel: BTRFS info (device dm-2): using crc32c (=
crc32c-lib) checksum algorithm
Feb 05 03:40:16 heisenberg kernel: BTRFS info (device dm-2): enabling free =
space tree
Feb 05 03:40:20 heisenberg kernel: BTRFS info (device dm-2): last unmount o=
f filesystem e1a465db-0227-46e1-9917-d6be986266cd


> It looks like the v2 cache is not rebuilt.

At least it claims it would clear it ("force clearing of disk cache").



Thanks,
Chris.

