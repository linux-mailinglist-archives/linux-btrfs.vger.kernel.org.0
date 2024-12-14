Return-Path: <linux-btrfs+bounces-10377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A23049F209C
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 20:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE014167BB7
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 19:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F0B1AB510;
	Sat, 14 Dec 2024 19:18:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865F19A2B0
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203894; cv=pass; b=s/RJLOqhR0QzmnXcxAuWqoeu7n/U3QoijRh1c3Jrzu2l0zMGl9hXc/AjVnEGCGuP9Y2WbYdWGU3rZ72OOcss0FBYzTyZSQGRUCB7RxSH3xe20sTZ/xNmrQWAHS5mvlwA9DIEITbjB7TP0md7lONtHuvuC1ZqF1HKTstw4XLSD34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203894; c=relaxed/simple;
	bh=wDinYSR45g+0Q5md3fswWDCBqmnRyXEa4V7x+s+ZzyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QRQzxDQqo5STN/2kTy0D3ddkg0Gkw5ij/CU+Jp1Dn1rHWO4+jEH1ZeJLxeT+WQ0W/bRWV3+PfLfuAJZqYuoJyydK67YxIG71BSwMb/FXZRjtxXtsuzztRE4b7A4eUhABEXnN2vFy63G7zL8CHUVOYGNPjGOSeeh4ZL34aK7ErJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C22D823449;
	Sat, 14 Dec 2024 19:09:18 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-9.trex.outbound.svc.cluster.local [100.98.194.21])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1482B23477;
	Sat, 14 Dec 2024 19:09:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1734203358; a=rsa-sha256;
	cv=none;
	b=yPE4Ooul8PZGQadZZKPX7u4BQgGJP+bgYJyD3M5VRyPLobznUjGEVt7/tqg4slr94uGiFN
	dtQZlzDP4tWdNSLTIeQeObx5dLlunHYn3T92G6b+JMx+EScBBa8kfu6OYxHiRQkoAhK21p
	+wRztqIsYJMnyNMcXuIuqvXNlaxPbzSnzlcSgJrsqxj9JZrs3UyWtQ5eI7B4Z63QIQnNDo
	xTPM4JkMN2pxGdRcXzmGbnvD1gpq87i2W+jY2q/w5suqqKwCTJd8FvDxJnN6eSq1WkDAA+
	+eIH02YhPZsiGX+OI4kRLNwnqVcI0x1hHk3rFDyjCUPWtEsYFisHaQ68FXPF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1734203358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDinYSR45g+0Q5md3fswWDCBqmnRyXEa4V7x+s+ZzyA=;
	b=k+U2Ytf4mOR/nq7cWmIGhW3bPOoFyWwKORgiB9Hzwa2QRiBTvXqq41U5p8uX3BkfR67khI
	ZSeeq/PQytT09PwhoIXM1yQEzxMBfcpqcMvjNOrIFs5VChNBpwVsJ+8gu6EZL+8K5PLylK
	bt1nG8HWbZ6rW32Q5Xzrg6JmcdCkdU00eRPqFYEwjC3nhhg8i82i0MVRI3QKzuFFUYcnMr
	L/KZytzsckahXgQu2R20u1QUuWHecZ85QuUQ6ZugjemoMPW1VfhyCdsB8bceX7eeWvn2Pn
	OBUH7eNQjiDX4dAPWl0o0UVkad6jdcGEZ0IDtE/ALFtOcHXRgL/U3ZGmBbtMqQ==
ARC-Authentication-Results: i=1;
	rspamd-56b8c8586d-2jd8k;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Print-Glossy: 74256b2842358a94_1734203358697_400526812
X-MC-Loop-Signature: 1734203358697:665059998
X-MC-Ingress-Time: 1734203358696
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.194.21 (trex/7.0.2);
	Sat, 14 Dec 2024 19:09:18 +0000
Received: from p5090f2d3.dip0.t-ipconnect.de ([80.144.242.211]:60650 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <calestyo@scientia.org>)
	id 1tMXVv-0000000CyPB-1ktE;
	Sat, 14 Dec 2024 19:09:16 +0000
Message-ID: <1d51a2cca61c2202b5c7d51f9c5772d2e79c3ef6.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Date: Sat, 14 Dec 2024 20:09:15 +0100
In-Reply-To: <156b27d5ea42ed4afa6d73dec8e2f479d346786d.camel@scientia.org>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
		 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
		 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
		 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
		 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
		 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
		 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
		 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
		 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
		 <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
		 <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
		 <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
		 <c085dabb449f8088156d906062db0b9fa0f7fe32.camel@scientia.org>
		 <aa69e84f-d466-457d-9b29-47043c2aef53@suse.com>
		 <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
		 <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
		 <513dfa2b00cf496e6f682508037616b6165fcc53.camel@scientia.org>
		 <494daef3-c180-4529-befb-325a46a3eeeb@gmx.com>
	 <156b27d5ea42ed4afa6d73dec8e2f479d346786d.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey Qu, et all.

Is the issue behind this still being looked at?

There used to be some patches out there, but I think they were never
merged.


Still having quite massively (well only where I use Prometheus) the
problem that on some filesystems where the application does that pre-
allocation, a lot of space is wasted.


IIRC your patches tried to put that in defrag, but the downside with
that is IMO that you have to defrag - and didn't that break up
refcopied extents?


Thanks,
Chris.

