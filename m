Return-Path: <linux-btrfs+bounces-21385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM+zEiMmhGlRzwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21385-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 06:09:55 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6839EEA27
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 06:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD8D3011844
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 05:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FB2DEA9B;
	Thu,  5 Feb 2026 05:09:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from giraffe.ash.relay.mailchannels.net (giraffe.ash.relay.mailchannels.net [23.83.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549212D5C7A
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268187; cv=pass; b=l+nI8TbyjkOw7gqw1pZUwOxGsminxPsKQPXXlxnShuvKHT0inB8GM74oT4Pjy4gcrtQmf9T8BAeMS8mv64fYR4xKI16Kc2tgyRfOxQiHAopeFTt/gpkWgKJzClR4+T2e0tsMPcpICDgP0usFVUrbfojxnOmpw4m9VlI/99OG2BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268187; c=relaxed/simple;
	bh=HD3+mnHnMEsMLtchAGu5Rv8VWeR0y/wFED/CCTXkHDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJ8c/8tOBMxC5S4pcx600v3MHYQzylKyWe5uVq4NtO8UFiy6qaFlmi9QHwhhIxNElQfzZvslXEmM0Nmoho+09ppsTkEOZsR51prc//suzRoPJFmnsHvW66AFasaj9GkmL+PD3soqRFR2F2uyyZfpAUqEOwaLIj3br+zcUtkP7z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4242C581F6D;
	Thu, 05 Feb 2026 04:50:49 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-0.trex.outbound.svc.cluster.local [100.96.77.161])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5E7E1581DBF;
	Thu, 05 Feb 2026 04:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770267048;
	b=LBdHOcZkEH73LX6Qg7GaV3DTGBeZPLAHOxg1yUc9Yqi9Tw/YkRg04Lxc9QhDAxN07hqLas
	dYi7iH5lPIGsyr4079+6Y8VRlqXXAqNprkWwBqeEwMdwrO4k+18IEwFIptF7eHWQTievvb
	AbLSMUa81qCv871cC6lix+3q3V9ms6NFuhaWautMzPaROjkx67uwTgVqCJGoPEsg2yJ0Bd
	p31tUxoZVpTkRYRdC7nM1ITSN650SgaAgroAXfZ2Wx3+yJGZwwl2aPzFVi2hiQhvOe+8YB
	YYGpq1iKUnWmDWu0SXRcPkUAfzmGrX61Q2kZw0SXWrQDXAAf2w8t3njX7qRQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770267048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HD3+mnHnMEsMLtchAGu5Rv8VWeR0y/wFED/CCTXkHDg=;
	b=YTyxb2iBLybPiGG0SfsHTWaxhsgH23A+zUVS/2jMody3438FScTdpVotYfLJX3CxEYZ1Oa
	TvOtzOVbwG59hdwnj62M0zQLtarF6OaJxnvvxhVdDvcDtcdB0KJvPTp3etyvdK79SDnDHG
	cBJX6UwsnxxxU5+Y3v/h5fyDGj1C87aPlUWe2NeCjq1pU+zZYNkDq8tQ7jmYnDtGtZouke
	NiBgTisGLkqBurUuJK2mXphEz53TKMti0xYGUra1IjvwDcO7t/NAQCPM7bg0D171lDO702
	7nV6ttSerM7RrKAAOrBc4yJWVKenofXNgG267nkUfhCkJnKx0k0enWsS8AY3dQ==
ARC-Authentication-Results: i=1;
	rspamd-c758cdf4d-xtxlc;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Occur-Stupid: 2cde6f0c3c93adfc_1770267049087_2515687314
X-MC-Loop-Signature: 1770267049087:320098064
X-MC-Ingress-Time: 1770267049087
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.77.161 (trex/7.1.3);
	Thu, 05 Feb 2026 04:50:49 +0000
Received: from [212.104.214.84] (port=36832 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vnrKJ-0000000BZls-0gtj;
	Thu, 05 Feb 2026 04:50:46 +0000
Message-ID: <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
Subject: Re: We have a space info key for a block group that doesn't exist
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Thu, 05 Feb 2026 05:50:44 +0100
In-Reply-To: <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
	 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
	 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
	 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
	 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
	 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
	 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
	 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21385-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[scientia.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[scientia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6839EEA27
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 15:13 +1030, Qu Wenruo wrote:
> >=20
> That message only means we're parsing the "clear_cache" mount option,
> it=20
> doesn't really mean we're rebuilding the v2 cache.

Is it really *only* a "parsed the option" message... or did it actually
clear the cache?
And would it now cause any issues if I have the cache cleared but no
new one was rebuilt?


> Normally for "clear_cache,space_cache=3Dv2" mount option, we will enter
> btrfs_start_pre_rw_mouont(), and it will set @rebuild_free_space_tree
> to=20
> true, and later entering btrfs_rebuild_free_space_tree(), and
> outputting=20
> a message showing "rebuilding free space tree".

checked for that message... not in the log :-(


> So by somehow your kernel didn't go that path. I have no idea why
> that=20
> happened.

It's the kernel as shipped by Debian (in unstable)...
linux-image-6.18.8+deb14-amd64 package.

Any way to find out why it doesn't rebuild?


> I guess for the worst case you can disable space cache completely
> first?
> E.g. -o space_cache=3Dno,clear_cache.
>=20
> Then retry with v2 cache.

Well... *if* that's safe to do... I'll try it tomorrow.


Thanks,
Chris.

