Return-Path: <linux-btrfs+bounces-18121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7BBF7825
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 17:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E57F4E3277
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949AC355054;
	Tue, 21 Oct 2025 15:53:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE5355051
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062021; cv=pass; b=f6WT4wLXN99BZkgKwMyldnMYeQVO9k2/cwb6ya3GC0RwbL+KSxP7bKAaFrSM9B+jrr6kVhWxHhxU9VBjOvmIxaunw7zvuu+8ltwebwMJ7MkQllGji1+G1Yos7KfSd5JEYgKHuvoWkHXCqCtwWzeBOyj8F2F/N8lpTX3H+gpk9y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062021; c=relaxed/simple;
	bh=bMS4Pg8FM5CuDl7An0xRt5x0/NWI5d9F4xe2LNVdcI0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1rz8wgGUXr2oGfpJlJHQ6pX0BzLfnI4EMVST0DhH2onuLWOXbeTr8Hb4NTpa7soCoB+IV/L2lhwJtsQ2ZtvfPpBWogJtSTJvN3zQp59GG1DSOMWhgbjHx8v51W4VynAlpdNtR4jrbIA/PSKvOXAX2SlbOyOHFDO+g5H2R9cNyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D8B54361BE0
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 15:53:31 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-1.trex.outbound.svc.cluster.local [100.121.87.108])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id D6C2F360423
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 15:53:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761062007; a=rsa-sha256;
	cv=none;
	b=GUojbrCDTVyufc3R7e5Ki0nIHgklx7ukg+GMR+rgMLDyP8tpweJVo/4qZEE+bDxB2VQl1/
	cN33HGyOTLAnXfFlna/sdtj5AnJQh7LExiWoJuXLFXK0hY33lczJqqK/P4EtAql+CaISrf
	y7V40nF4j4sbJe4qG/OBr258tvfNGk2rKPwOkQbF5tUMpwUPd59b42akhv4FPyUENkqYc/
	czXmuf36TRXEopXBD912mChQuQptCv/7lsOSQmDpY6EY827+hVGyxe1FpBYhzm0MtWOcnZ
	93aJH0U1MOA6a5Mjj4Ja6JGlkFqN06BJzFOXw7ePrxGzFaGLTOtPh8WHyLvKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761062007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMS4Pg8FM5CuDl7An0xRt5x0/NWI5d9F4xe2LNVdcI0=;
	b=eCVhVy7Z11/tqZL8yQmp6Nk/NjV1D8rdfy37ixYwPqHPk5jttOCAO2awu0QTK0NLuCCNBp
	+OClaXTEIRX5SZ+cerBOws7AJMle5o9dMkWCDiDT0g5Fy3vUhgTRFZM6Ja0f8XCzpHyxxV
	iGHE9Uk3sBABs7mlHJyPUH8CAbS5ReTYSW8cx8AeqBt4rhXSLi7+N3b1RyA9C7o+sLVd7H
	5EdkiWoetQ7QeWpmfixg69c1l6XEgBprgIsqFzLB5j+A/wJHBFa9dcaR+Tam70Qnd/q1nU
	F+NMWW/xazwvvMgqP5TwTiS6By1vmOn2ftdITCGdUym7C4vmD2SsLmlZ1I2BqA==
ARC-Authentication-Results: i=1;
	rspamd-6c854d7645-ndhnm;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Glossy-Stupid: 5323e1fd2a27e415_1761062011595_2081052383
X-MC-Loop-Signature: 1761062011595:3426262461
X-MC-Ingress-Time: 1761062011595
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.87.108 (trex/7.1.3);
	Tue, 21 Oct 2025 15:53:31 +0000
Received: from ipbcc0feaa.dynamic.kabel-deutschland.de ([188.192.254.170]:62451 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1vBEfu-0000000F4IQ-3BcN
	for linux-btrfs@vger.kernel.org;
	Tue, 21 Oct 2025 15:53:25 +0000
Message-ID: <a8a16938b9112d7aa68b6df3de30d35c116fb17a.camel@scientia.org>
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Tue, 21 Oct 2025 17:53:24 +0200
In-Reply-To: <d7e67eee-ac1a-4677-8bed-25c358c66c81@harmstone.com>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
	 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
	 <3a3df034-4461-4c35-b170-a5084586d2b3@gmail.com>
	 <d7e67eee-ac1a-4677-8bed-25c358c66c81@harmstone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Tue, 2025-10-21 at 16:46 +0100, Mark Harmstone wrote:
> The brutal truth is probably that RAID5/6 is an idea whose time has
> passed.
> Storage is cheap enough that it doesn't warrant the added latency,
> CPU time,
> and complexity.

That doesn't seem to be generally the case. We have e.g. large storage
servers with 24x 22 TB HDDs.

RAID6 is plenty enough redundancy for these, loosing 2 HDDs.
RAID1 would loose half.


Cheers,
Chris.

