Return-Path: <linux-btrfs+bounces-19262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4842EC7BF8C
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 00:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56F424E8EA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 23:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915030F524;
	Fri, 21 Nov 2025 23:55:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801FA27CCF0;
	Fri, 21 Nov 2025 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763769331; cv=pass; b=k33CtYEkuEFb35PhV5eEFgVCwmFzH9pkiagwDO4tqVqLETPYvN8enSY8yKl1G+v306JMbBkIS09UivtrmCU0S6fgD3kswcTjYZgRgRVv0xPRv6wGpPNlu8axsHhkuzsKtn6QELqjsrpSLdQqrzNT6LjZxCGFgPVzLNWJxQ1IiYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763769331; c=relaxed/simple;
	bh=z17GmH1uLAaTfLE3ip08f2ikNL4BOXVzJpjL0o8t3s8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rcvz14I48SCUrhkcMlWSKY6DvWvjZYMj8xVC49pyg42E3dunInloTBlbJF4DEpLvCnDfhkXZ9K1GtJa+QZU3dB9WY5/vnWbP53a9msoEGLy6Ie/4PWl9EPAlqWuS4G2Ic5kua10IfPINiD2KSCPXwHLPx9OLppKzO08wjOLGgQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C15238C17C2;
	Fri, 21 Nov 2025 23:55:23 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-3.trex.outbound.svc.cluster.local [100.98.30.13])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8C43C8C1ECF;
	Fri, 21 Nov 2025 23:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763769323;
	b=woyqy/tFnnFELA/K5vN7ki9TL9sRJPd3RcToGsafC7d9GxH4HWC/AyqcbSBMl0jXheh6jx
	Qu3iBCpT1au4UjqFKnneZVbh9UOeXkph27tNxym3QqFM2QX1k/i2QgSPnj6kM6J5fA2UAj
	DVminN+OBS1UGeukq40nfa3yF/hWCWt+jtzjvn8cghQQPVgFtYje30KwaDRv0xDMNuF4VR
	sgc3S/PhlW9WylqBRx8jmsk4nypbHl0X7oS8oYNEvYhVKJVzFsuOqeKM3EGdXxJOWvvPez
	WCCgPSCZP/Yas8LPB4eNLUuAv97mxoYNkNRdJxPDrQoar3FsD0mqRf0956RUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763769323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z17GmH1uLAaTfLE3ip08f2ikNL4BOXVzJpjL0o8t3s8=;
	b=1hCKhqsP9jmRxawGOMIuecGyYO8ZXNqz8Wj5eHEAKyMytVo1EewhLSdfCRyRqb9ykdsv+0
	XPNsBmG0SxhDM0Y7Ht7SlQBww6SpOVzQuua++ZjVYraylHunSSW3q6vjSUGGHtN5/rQ3+Q
	5+boioADPcKavjpD4jG4xL8GQ44lfHap3Yhv51LQuUeQ78TfKvKQm73WVInGqsBSqxKvMU
	ZLT4s9QYeBF88kPWNLlHGVWCrMAbE2oAWprWEjrK52Eq7TbbQ+ZanzQGrmvNPTZspldch8
	MOD7LDyyounuVpOQiTqLJYFvZtrlbPBYiZGUN9qOQCSDcV4LjDV8jtykFMqvuw==
ARC-Authentication-Results: i=1;
	rspamd-66df965b87-89blt;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Desert-Occur: 71eb861f139222e2_1763769323593_2430568932
X-MC-Loop-Signature: 1763769323593:3649635591
X-MC-Ingress-Time: 1763769323593
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.30.13 (trex/7.1.3);
	Fri, 21 Nov 2025 23:55:23 +0000
Received: from tmo-119-69.customers.d1-online.com ([80.187.119.69]:7129 helo=[IPv6:2a01:599:808:f90b:10b3:a6e4:4b02:dff6])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1vMayI-0000000GXPd-2g4V;
	Fri, 21 Nov 2025 23:55:20 +0000
Message-ID: <5493c0684cc1014614ae156e9b8888d52857d2bf.camel@scientia.org>
Subject: Re: [PATCH] btrfs-progs: docs: add warning for btrfs checksum
 features
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Date: Sat, 22 Nov 2025 00:55:18 +0100
In-Reply-To: <5495561f-415d-4bb0-9cd4-4543c510f111@suse.com>
References: 
	<7458cde1f481c8d8af2786ee64d2bffde5f0386c.1763700989.git.wqu@suse.com>
	 <9523838F-B99E-4CC5-8434-B34B105FD08B@scientia.org>
	 <bc5249ba-9c39-42b1-903d-e50375a433d2@suse.com>
	 <3C200394-F95B-4D1C-9256-3718E331ED34@scientia.org>
	 <5495561f-415d-4bb0-9cd4-4543c510f111@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-7 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Fri, 2025-11-21 at 17:14 +1030, Qu Wenruo wrote:
>=20
> Adding linux-crypto list for more feedback.

It would be good if any of them could confirm or reject:

- Whether a filesystem that uses full checksumming (data + meta-data)
and that is encrypted with dm-crypt,... is effectively integrity
protected like it would be with an AEAD.

In particular also:

- Whether this requires a strong cryptographic hash (or as Qu presumed,
any hash would do) and whether the hashing is needed to be done as a
Merkle-tree or whether that's not needed

- Whether, if one uses such a fs, AEAD or dm-verity is even
recommended, or just a waste of resources as the checksumming done by
the fs would already be enough.


> > The question IMO is, whether a (dm-crypt) encrypted btrfs that uses
> > a strong hash function for btrfs (i.e. like hash-then-encrypt)
> > would be effectively integrity protected.
>=20
> In that case, I can not give a concrete answer, but I tend to believe
> it's protected, and no matter what the algorithm is (including
> CRC32C).

I'd rather not think CRC would be enough... I mean why would all crypto
use strong hash algos for signatures, if it could also be done with
fast CRC.


> - For metadata
> =C2=A0=C2=A0 The bytenr will mismatch, thus be rejected.
>=20
> =C2=A0=C2=A0 This prevents csum tree from bing modified.

But meta data *is* still checksum protected right (i.e. it doesn'thave
only the bytenr).

Maybe, if someone from the crypto guys has a look, you could outline
them how the exact hashing structure looks for btrfs.... like is it a
full Merkle-tree starting from the super block, what about super block
copies, etc. pp.=20


Thanks,
Chris.

