Return-Path: <linux-btrfs+bounces-1341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E48A282920B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683BB28A10F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB74A07;
	Wed, 10 Jan 2024 01:24:40 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD924689
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 58B09362D3B;
	Tue,  9 Jan 2024 21:57:46 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id BE82B362BD4;
	Tue,  9 Jan 2024 21:57:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1704837464; a=rsa-sha256;
	cv=none;
	b=DUbJdTLXg6gZekiN5SJcQpsEwYEB1u3RnPzXVBh+Z0jY7LmJsyQZWn1CMuSNLNtElKUIaR
	50tgf4AeSOgTYkAxLSHjJFQ+pYhhNUC67Wzi3mIbr3eHYHlrC/HEkHm2+3r8wODnugSxWi
	rAQECD8whVbcuatCqG6p9mkzOA5H3MAOxdBClxTB2HLAzxNPOc7xsqaY45M6Ss6kr4cqNE
	KolfWVthazu1fn5bS+DjuMpQub6wLoYThh++2WevIFr/VTiiR30SNmtRPuJ4iQlhN+AEk4
	RQSC2pwHcp+6Drku5j4h0RV0fM73U38zPRsBNeLepGXy/NuJ0MBbCG0oz9+b2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1704837464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Y9bvWhGq8nYDJt8GesgEBtmMpSmb6gIYeP9yDaHZd8=;
	b=tNzBfuDcizX//eQ1OdnLlX8MN2StzijKH8zfFI3iwWlZPbnKe1E5oCDfhUHJgcX15htfoe
	FdbfVJqy2LQ79DcYSRZaz9zCOLsES3wx9Y5pS8bp2PaTMLWLsKtWk5X7S449EyiIwOuEg3
	+2iIE/fz+fM+sh0so8xUsvmsqdjfu5hlKHPGKjpPndVVvOP4Rhz3adeIoJA7LHKStk2Rnc
	BaEiz0QQCyYeVuXC69n/LvTkuqKfktPATTDwfn+sjvul0Xu+h33/D5ns0wRizbMbEjtq0D
	CEHiygLKNZshYHF4C3ZyBFTi9XdKxGNQmzyFT4Z4UMRJ7fG+8XC5nSZu+qNA4A==
ARC-Authentication-Results: i=1;
	rspamd-69494b7fd5-l52kv;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Snatch-Shoe: 179d36936e3c2a97_1704837464545_2758955925
X-MC-Loop-Signature: 1704837464545:1213073238
X-MC-Ingress-Time: 1704837464545
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.102.134.10 (trex/6.9.2);
	Tue, 09 Jan 2024 21:57:44 +0000
Received: from p5090f6c2.dip0.t-ipconnect.de ([80.144.246.194]:45414 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rNK6L-0007d5-2s;
	Tue, 09 Jan 2024 21:57:41 +0000
Message-ID: <adb8b47a1dcb44747b15dde1aa6ac8c2592edd45.camel@scientia.org>
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag
 target list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Date: Tue, 09 Jan 2024 22:57:35 +0100
In-Reply-To: <59615d5b-8802-4218-8b0b-18e3eff47cb3@gmx.com>
References: 
	<2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
	 <CAL3q7H5LEjZCkhTwgYJLSeQkG6NsY5AhE__na-2hCa7UuXuCzw@mail.gmail.com>
	 <59615d5b-8802-4218-8b0b-18e3eff47cb3@gmx.com>
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

On Wed, 2024-01-10 at 07:34 +1030, Qu Wenruo wrote:
> The 1/16 is chosen as a trade-off between wasted space and possible
> unnecessary defrag.

Felipe's point doesn't seem so invalid.... wouldn't it be possible to
make the trade-off somehow configurable, so that the user can choose
via some command line option?

Cheers,
Chris.

