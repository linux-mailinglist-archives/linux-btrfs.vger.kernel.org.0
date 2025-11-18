Return-Path: <linux-btrfs+bounces-19115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8BC6BFD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 00:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 190DB29D2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 23:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611EF302CDB;
	Tue, 18 Nov 2025 23:27:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011F189906
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508441; cv=pass; b=mP/4J+wrVzghFfztl3YDGdSfJRgLYEoJyAfV26BHlZ/jHj59phSwoJHvA1MgRhakSLrfK1Zn8k8HbpjUafpE+IIVJkG5BUjn4OvoQ2yJPYtNMEUwhBu924knRUqdjrNBGsPuka+84R8Xcqqn2gKdBeTIv1PQxxrvAVTPjxFQenU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508441; c=relaxed/simple;
	bh=etQgIQP4yUO77+e1eJW/WiSBq0dLO4Vs9Gk7d2qFL8w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvDBzFB38l6IW9fJ9TKLucmmYS/zLxTRATwBqLe4t5spwXIYSZwrz73o1OJgRYF37MlgsWdlsMInDoSSQ8O+o3HcBS2EUxCLg/VAKc07hCyPkfCEwblGEL8QNJfqQFhaWsN2x+AaELhFaOhwW1a1iskZ8/1djuo/P5XfSFY94XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 87D639214A0;
	Tue, 18 Nov 2025 23:27:13 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-8.trex.outbound.svc.cluster.local [100.96.77.123])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 509B9921498;
	Tue, 18 Nov 2025 23:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763508432;
	b=MOhlAzmbSWlnPPxVpESjhDO8XsG5hMqhbhFpTSUiVFm7VL96lX+FjGAmgt5I+kdYipA27D
	iIIpjB40jzildA9EhhcvHtal7uKi1mY0T0DXizbChCWIn9fPW4Q91SOMh6Txp8QEgLykqg
	FbmSMlLQVrXpPiZgl2YxCFpXF6jp8yM+W2ScI2EGln/EjfxZIEH+6AIOV56y9dd/YQuQmt
	b/Fu6Bu5PQnZ+5rUH89xoZ4SQRQ9xtCa5/3U70/P183gkNmZUsqh+kovm/ZPk4xB2NwcfZ
	YSqspRZxsDAcVsH4IeZ87tTbwftoKiQvmXQa//xMI1ZAvEaA9HVfItpLCuPR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763508432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etQgIQP4yUO77+e1eJW/WiSBq0dLO4Vs9Gk7d2qFL8w=;
	b=OJ9PflH3OC9vfYsukny9j8ycXicSPZJaycVeFljqGqnCerTiLFUU2Z4Ay35nSPNeQBpi95
	bdCLhbBTjTuIkI9gTY41nLOPJqVN8D8CQBvJa5VBlWKjYVj2KJqM/qqh549HqbE8avH/zd
	YA4S37pEXaRjiHqmNSwSuVDw4JdZzL5lPROXvoxBeHzHoAmUBXcFgPBsJ0wb3NrfDHONr9
	tVB7OAyganUsdfc9A95CTKklHbwaJ+ihxRhUNp6/LSSBdUNFGkw5/kBK6aGrX0juG2HfnM
	AuAbT/jIUqYdQFAEiJ2IhynFinFHSSwJtMg48zMnDE3AqUaynKB9v7q7ZxHKDw==
ARC-Authentication-Results: i=1;
	rspamd-55b59744f-pwhnm;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Soft-Stretch: 7893ceac3c0b140f_1763508433180_1043385184
X-MC-Loop-Signature: 1763508433180:3713991340
X-MC-Ingress-Time: 1763508433179
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.77.123 (trex/7.1.3);
	Tue, 18 Nov 2025 23:27:13 +0000
Received: from [212.104.214.84] (port=28578 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1vLV6M-0000000DvjY-3Uqh;
	Tue, 18 Nov 2025 23:27:10 +0000
Message-ID: <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
Subject: Re: We have a space info key for a block group that doesn't exist
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Wed, 19 Nov 2025 00:27:08 +0100
In-Reply-To: <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
	 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
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

Hey Qu.

On Mon, 2025-11-17 at 12:48 +1030, Qu Wenruo wrote:
>=20
> Nothing to worry about.

Thanks :-)

So even without clearing the cache as you've proposed below, it
couldn't have caused any post or future corruption, right?!


> If you want the problem to be gone immediately, mount with=20
> "space_cache=3Dv2,clear_cache" should handle it.

Good. I may just wait for the mount time patch.


> No. That's over-reacting.

O:-)


Best wishes,
Chris.

