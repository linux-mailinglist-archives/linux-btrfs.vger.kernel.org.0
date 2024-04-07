Return-Path: <linux-btrfs+bounces-4004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C374C89AE21
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 04:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE3281FEB
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 02:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C971879;
	Sun,  7 Apr 2024 02:52:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50A17C9
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Apr 2024 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712458344; cv=pass; b=qRwrtdoqjSx6o1rplxLM16/lfcpyqjySf0Hm+lIBWsW5wJqog8HHWZ6KaHGK6OmA82vLx+84aKwGdE/cwdE3RhyZZdCdZVJHH/k5FlyLFaiCphsZpyB1XEbcleF9WtOvRO5AJHSnbugQg7clvI2Zr+qraKjbkyWoF6jxfkhQjTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712458344; c=relaxed/simple;
	bh=0oHOkeBSNLO5d+0TgrtWTLLpCTwI5nnOKCy3vXvUyjQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFjW/Ua/0x5ttPsxbgVcBBs/mSWlLHtBTa5UCYBFb447hnW96T1rQWZXUZyMpjzLqJFN66Xx2IxBKYTJS4LC0latfeRi3V5210vwS6oH83iWtouaw/45KdsNZR1YUpQaAUD0Lm5ZI2iQ40YppuoVuidN9dVtosR7+UTaaSWT84k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 037605014BD;
	Sun,  7 Apr 2024 02:52:14 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id F14115013E8;
	Sun,  7 Apr 2024 02:52:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1712458333; a=rsa-sha256;
	cv=none;
	b=h4EV35MUOtiN1/VzsWJCh0+CjIcJ9VA5tDnJ3LjvdX5GbLF8mVKaPUS9EyetCSjLa6Wsd8
	rESMHVC/BzSXmAM4ETf6dD+e5ly2swIlG4+2ttaTnxUJGpCX8ka8EyP8pdJFKosz/X3vDs
	jIH7YipKbsElNg54iEkIJJJmGnMvusIpX0a1ln8kFQBWaX12FlIcCLo/xCDQ7qkoD5yZB5
	mz63XvAuV+8SFFxC/nmaS+4J6obr/tkmGdjHSojyCh61z3/61FfqNmiEc11cmb5MMxyFvI
	e1Z/uX++amO5mNjJD48/ytkPgn4Y6umAIx1qD0gI7XImBpE0p4TE/v4oVLxRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1712458333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oHOkeBSNLO5d+0TgrtWTLLpCTwI5nnOKCy3vXvUyjQ=;
	b=l8yMzRgCRw7nYwVj6qbpVam2BqChObDAvcu5x4fZ68Ny5IAQwG7sYmTWdpjFswmGNi4Er7
	TllvxpFQHtiB4e1PiPCyDOBeSmxW0YjN4/N5MDtClMwrNSQuPtaHN+KvsA3iMv94f4C/Lm
	LwPsZRXG7wK7OyZGMxcJ56R04GvzIlJE4bOziJ8lhhFMFkqW162Iv9W2nhgIFkFnALRcVy
	OEANGFn345MSjb5KWMZgbqV3ziEVhowutTFqi8tKNcekTDmYBS8DQEoSSMMTUWwweTvB3o
	ujsc/6RILA8Z29+C+IATh2dM3/v3aa0z51APcH6Gcey5J4a32RdlJfTtLqFaFg==
ARC-Authentication-Results: i=1;
	rspamd-86f86f958-q58xr;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Turn-Chemical: 716c41e37f9bce3a_1712458333621_3083461605
X-MC-Loop-Signature: 1712458333621:3300203521
X-MC-Ingress-Time: 1712458333621
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.111.183.71 (trex/6.9.2);
	Sun, 07 Apr 2024 02:52:13 +0000
Received: from p5090f899.dip0.t-ipconnect.de ([80.144.248.153]:58930 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rtIde-0006oA-16;
	Sun, 07 Apr 2024 02:52:11 +0000
Message-ID: <d7c9378abccd7a7c243fc10938c6ba1ba48db232.camel@scientia.org>
Subject: Re: exactly shrinking btrfs on a device?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date: Sun, 07 Apr 2024 04:52:06 +0200
In-Reply-To: <bba42153-f4d9-4fb6-8252-a5cd1929b901@gmail.com>
References: <896a5d36071a30605c38779dd03103b6429ebcae.camel@scientia.org>
	 <20240406033700.2c2404c1@nvm>
	 <0c9f96442083fe6e5ad387adbc496ff2f3370270.camel@scientia.org>
	 <bba42153-f4d9-4fb6-8252-a5cd1929b901@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1+b1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Sat, 2024-04-06 at 08:03 +0300, Andrei Borzenkov wrote:
> Why not? You set the container to the exact size and let btrfs grow
> up=20
> to it. Or may be you need to clarify your question.

Well... maybe, I guess, I just wanna know where it exactly ends. ^^


Cheers,
Chris

